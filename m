Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9C4BBA0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiBRNXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 08:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRNXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 08:23:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68325B2ED
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 05:22:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DD8F1F37E;
        Fri, 18 Feb 2022 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645190573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFt9B0oFy9YnYR8530gP98Ly+TVDbfXzgkie4c79dvc=;
        b=P7d23VmxMfBk46eEPsvju3P152yDCNVbM+9wo8BAsbKQW7KFpJe9z1t4uW2/y9jyUagkrw
        sL3VSINbEQM2UvnTY3fJK/sfa1/161zN6YnkjfzWy5gL4yYxprju55nVk2pPgTY8+5K+1x
        U/hyj6bOrAQ3OS1TllTYaVwk2uSRmtE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0675213C8A;
        Fri, 18 Feb 2022 13:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MJHZOaydD2KuYwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 18 Feb 2022 13:22:52 +0000
Message-ID: <532a5d22-0601-8a98-e4d4-fb1d433394e9@suse.com>
Date:   Fri, 18 Feb 2022 15:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: remove the cross file system checks from remap
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <ef6f142a8be5bb8a3d2ac2643cc01870038f11b9.1645041975.git.josef@toxicpanda.com>
 <1ebfca5a-4aeb-ce63-f9c7-5a4444a2773d@suse.com>
In-Reply-To: <1ebfca5a-4aeb-ce63-f9c7-5a4444a2773d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.02.22 г. 15:15 ч., Nikolay Borisov wrote:
> 
> 
> On 16.02.22 г. 22:06 ч., Josef Bacik wrote:
>> This is handled in the generic VFS helper, we do not need to duplicate
>> this inside of btrfs.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/reflink.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
>> index a3930da4eb3f..4425030e09cb 100644
>> --- a/fs/btrfs/reflink.c
>> +++ b/fs/btrfs/reflink.c
>> @@ -771,10 +771,6 @@ static int btrfs_remap_file_range_prep(struct 
>> file *file_in, loff_t pos_in,
>>           if (btrfs_root_readonly(root_out))
>>               return -EROFS;
>> -
>> -        if (file_in->f_path.mnt != file_out->f_path.mnt ||
>> -            inode_in->i_sb != inode_out->i_sb)
>> -            return -EXDEV;
> 
> Where exactly is this check performed in the vfs because I can't see 
> anything in generic_remap_file_range_prep.


Ah it depends on another patch in the ML which is not part of the same 
series. Fair enough, though I agree with David's suggestion to have an 
assert just in case.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> 
>>       }
>>       /* Don't make the dst file partly checksummed */
