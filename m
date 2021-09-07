Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2327402654
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbhIGJsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 05:48:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbhIGJse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 05:48:34 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDEAF2204C;
        Tue,  7 Sep 2021 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631008047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfPT2Ce5wXjQy+ek64k5lQZ76lWOgcaMJn9+2kxgal4=;
        b=kDiYux7m+j4SsXtfLlxZ5wfn0HnCK6/QH6arrL0jyfd+lySR68OAaKhmx1Iny/kNM1+kYz
        UmstrZZw3MMb7EaNvBsUpwg1yVZo/1MXvADarUg4ONBcSypoAjI9nAp/lW6d8k0zQmP5tN
        PEsaaRx3UHLbMAu12npftozLKdKoPfU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 99D63132AB;
        Tue,  7 Sep 2021 09:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id REjdIi81N2F3NgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 07 Sep 2021 09:47:27 +0000
Subject: Re: [PATCH 2/3] btrfs: rename struct btrfs_io_bio to struct
 btrfs_logical_bio
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210907074242.103438-1-wqu@suse.com>
 <20210907074242.103438-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <95fd7c35-a100-6aca-64e2-c396420a8fda@suse.com>
Date:   Tue, 7 Sep 2021 12:47:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907074242.103438-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.09.21 г. 10:42, Qu Wenruo wrote:
> In btrfs there are at least 4 types of different bios currently:
> 
> - btrfs_io_bio
>   It's used to specify IO for logical bytenr

Perhaps this structure needs to be turned into a btrfs_bio.

> 
> - btrfs_bio
>   It's real physical bio

It's not even that, because btrfs_bio itself is not submitted at all,
it's really some sort of a semaphore, which is used to signal all stripe
bios i.e those bios which are submitted to the actual devices have
completed. In that regard it's not even a bio per-se, more like an
io_context.

> 
> - compressed_bio
>   Only used for compressed read write.

This should be compressed_io_ctx or some such.

> 
> - btrfs_raid_bio
>   Only used by RAID56
> 
> The naming of btrfs_bio and btrfs_io_bio is just anti-human.
> 
> Rename btrfs_io_bio to btrfs_logical_bio, and all involved helpers to
> make clear at which layer the bio works.
> 
> Since we're here, also add extra comments on critical members like
> @mirror_num.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

<snip>
