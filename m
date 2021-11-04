Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2B94452D3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhKDMTp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 08:19:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhKDMTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 08:19:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20CDA1FD47;
        Thu,  4 Nov 2021 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636028226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVHJDcPyTZzhMgxRidAyU/tuFXG6BPAywobyGCGu3Yk=;
        b=DZPBf3KWoUlir8N8W0A73fchTAvmAz2Nq5VfdYaaNwPbs1Gndm9f//tCVvCG/JSVVMhveD
        RZNM7nSYnZB/9mS0rVU+dbBdB1ubTBjkO64/Jou16sfqTdGtYtNw4qSIkXGfXhODAQagQZ
        4Ff1D3tml/2BHoz0eGA04e8+DMPLybs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC7F813BD4;
        Thu,  4 Nov 2021 12:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CAcqN0HPg2EnBQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 12:17:05 +0000
Subject: Re: [PATCH v2] btrfs-progs: Make "btrfs filesystem df" command to
 show upper case profile
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211104015807.35774-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c7c2e955-9fae-b679-3fd9-38f5b627f9df@suse.com>
Date:   Thu, 4 Nov 2021 14:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104015807.35774-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.11.21 г. 3:58, Qu Wenruo wrote:
> [BUG]
> Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
> to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.
> 
> The failure of btrfs/151 explains the reason pretty well:
> 
> btrfs/151 1s ... - output mismatch
>     --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 +0800
>     +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 17:13:43.879999994 +0800
>     @@ -1,2 +1,2 @@
>      QA output created by 151
>     -Data, RAID1
>     +Data, raid1
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out ~/xfstests-dev/results//btrfs/151.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
> raid table") will use btrfs_raid_array[index].raid_name, which is all
> lower case.
> 
> [FIX]
> There is no need to bring such output format change.
> 
> So here we split the btrfs_raid_attr::raid_name[] into upper_name[] and
> lower_name[], and make upper and lower case helpers for callers to use.
> 
> Now there are several types of callers referring to lower_name and
> upper_name:
> 
> - parse_bg_profile()
>   It uses strcasecmp(), either case would be fine.
> 
> - btrfs_group_profile_str()
>   Originally it uses upper case for all profiles except "single".
>   Now unified to upper case.
> 
> - sprint_profiles()
>   It uses lower case.
> 
> - bg_flags_to_str()
>   It uses upper case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add new lower_name[] and upper_name[] for btrfs_raid_attr
>   So we don't need temporary string buffer
> 
> - Review all commits unifying the output to check what's the original
>   output format

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

<snip>
