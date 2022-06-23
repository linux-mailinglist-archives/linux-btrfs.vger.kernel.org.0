Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1421557577
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 10:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiFWIac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiFWIab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 04:30:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA3348335
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 01:30:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D25F21CE9;
        Thu, 23 Jun 2022 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655973029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIVTraYZonKxeV/pFdjQnK2yzJdD14rX+wq7PDSRUQo=;
        b=WQs0BJAEhVkdNNDEiy2/erJpQsUyM5QZryZHuesXSpVqeexOIv7VjFOCdkBhmiOy08CUx2
        BaQCiKKrFPlEAMdAIGznDhGjDqAida4NVL5Wna9BbmAmVCI8XG9lJGwFgDlEaiGyRQKiMJ
        lff5F/flgTmUBalx2OWhC8ID+PHTYdE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E76C813461;
        Thu, 23 Jun 2022 08:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dv2sNaQktGIwBwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Jun 2022 08:30:28 +0000
Message-ID: <09f47914-871d-432c-858c-0514e60e154c@suse.com>
Date:   Thu, 23 Jun 2022 11:30:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: remove skinny extent verbose message
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
 <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.06.22 г. 11:22 ч., Qu Wenruo wrote:
> 
> 
> On 2022/6/23 16:08, Nikolay Borisov wrote:
>> Skinny extents have been a default mkfs feature since version 3.18 i
>> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
>> make skinny-metadata default") ). It really doesn't bring any value to
>> users to simply remove it.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Looks fine to me.
> 
> But this means we need to define the level of (in)compat flags we want
> to show in the dmesg.
> 
> By default, we have the following lines:
> 
>   BTRFS info (device loop0): flagging fs with big metadata feature
>   BTRFS info (device loop0): using free space tree
>   BTRFS info (device loop0): has skinny extents
>   BTRFS info (device loop0): enabling ssd optimizations
>   BTRFS info (device loop0): checking UUID tree
> 
> For "big metadata" it's even less meaningful, and it doesn't even have
> sysfs entry for it.

Already sent a patch for this one.

> 
> For "free space tree" it may be helpful, but if one is really concerning
> about the cache version we're using, it's better to go sysfs other than
> checking the kernel dmesg.
> 
> For "SSD", it's a good thing to output.
> 
> For "UUID" tree, it's definitely not useful, even for developers.

This is predicated on whether we need to check the UUID tree not on 
whether a flag is set, but I agree it could be removed.

> 
> For skinny metadata it's the one you're cleaning.
> 
> So I guess you can clean up more unnecessary mount messages then?

Yes

> 
> Thanks,
> Qu
>> ---
>>   fs/btrfs/disk-io.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 8c34d08e3c64..0af4c03279df 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3501,9 +3501,6 @@ int __cold open_ctree(struct super_block *sb, 
>> struct btrfs_fs_devices *fs_device
>>       else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
>>           features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>>
>> -    if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>> -        btrfs_info(fs_info, "has skinny extents");
>> -
>>       /*
>>        * Flag our filesystem as having big metadata blocks if they are 
>> bigger
>>        * than the page size.
