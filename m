Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6042A693
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhJLOBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 10:01:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56666 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbhJLOBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 10:01:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F4D822170;
        Tue, 12 Oct 2021 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634047146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Dm+azMsFPThARLdr0o/MxBdW8rVfWWrWHmhAFXg01c=;
        b=Ldh+nJye0KwGSBtXO0EZi7Kv2nHqZTLu96WUZ1Z+tULuoVfLFJprRbtiQ8FGTWYr1mUkYD
        byfppuMkUg+QPUrS1fB96uHb3gg61KoFYpjV2VyWYk2z6pK4ZIVKCJ+DYL2OEpHtpmqs2l
        dOzjLVhsRhcsLp3t1KA3LBQfSiWGEDE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33FF513BEC;
        Tue, 12 Oct 2021 13:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s66eCaqUZWE8eAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 13:59:06 +0000
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
 <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
 <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
 <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
 <a643cdea-5130-c44e-ce4f-dc8fa23e7481@suse.com>
 <0fbd2076-2b6c-4531-01ea-84db37abf621@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1dea2507-5dfb-75ca-7bcb-f1114f5929b6@suse.com>
Date:   Tue, 12 Oct 2021 16:59:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0fbd2076-2b6c-4531-01ea-84db37abf621@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.10.21 г. 15:24, Qu Wenruo wrote:
> 
> 
> On 2021/10/12 19:56, Nikolay Borisov wrote:
>>
>>
>> On 12.10.21 г. 14:42, Qu Wenruo wrote:
>>>

<snip>

> 
> There is a special handling for SINGLE:
> 
> +               /*
> +                * Special handing for SINGLE profile, we don't output
> "SINGLE"
> +                * for SINGLE profile, since there is no such bit for it.
> +                * Thus here we only fill @profile if it's not single.
> +                */
> +               if (strncmp(name, "single", strlen("single")) != 0)
> +                       strncpy(profile, name, BG_FLAG_STRING_LEN);
> 
> See, if we hit SINGLE profile, we won't populate @profile array.

Fair enough, I had misread the != 0 check ... However, I'm wondering,
since this is only used during output, why don't we, for the sake of
consistency, output SINGLE, despite not having an exclusive bit for it?
The point of the human readable output is to be useful for users, so
instead of me having to know an implementation detail that SINGLE is not
represented by any bit, it will be much more useful if I see that
something is single profile, no ?

> 
> Thanks,
> Qu
> 
>>
>> <snip>
>>
> 
