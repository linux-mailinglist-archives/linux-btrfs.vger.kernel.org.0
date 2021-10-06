Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4E423A2F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhJFJHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 05:07:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhJFJHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 05:07:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C9C1224D8;
        Wed,  6 Oct 2021 09:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633511159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWKrArrNq+cnYjbhZ/pLOqNPQTNUxKUku32abBGNngo=;
        b=WqI6q24EzWNVfhLtT5vXG+uceGknRPGKyM4H3/FBmXbV5kIjGJMhXbiMx7y8dhBMkKygSO
        UZAWyPymtqcQQqWaluAQNur52j2CNJ2boisCVcYAq3YNQnWAnKUPzS5jnhOCuufK8vvGD2
        6SqzmGcmW4uz21zf72tWclIv2uB7TZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22B8C13E19;
        Wed,  6 Oct 2021 09:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EUIBvdmXWEjQQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Oct 2021 09:05:59 +0000
Subject: Re: [PATCH v4 6/6] btrfs: use btrfs_get_dev_args_from_path in dev
 removal ioctls
To:     Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <78f4669e469232db2d8675fd7b4fd06028f2eef5.1633464631.git.josef@toxicpanda.com>
 <e81e4690-377d-40f1-8488-21530ee6c57d@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <338ca6f9-9728-edc9-642c-7893573b1678@suse.com>
Date:   Wed, 6 Oct 2021 12:05:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e81e4690-377d-40f1-8488-21530ee6c57d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.10.21 г. 11:54, Anand Jain wrote:
<snip>

>> Suggested-by: Anand Jain <anand.jain@oracle.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ioctl.c   | 67 +++++++++++++++++++++++++++-------------------
>>   fs/btrfs/volumes.c | 15 +++++------
>>   fs/btrfs/volumes.h |  2 +-
>>   3 files changed, 48 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index b8508af4e539..c9d3f375df83 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3160,6 +3160,7 @@ static long btrfs_ioctl_add_dev(struct
>> btrfs_fs_info *fs_info, void __user *arg)
>>     static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user
>> *arg)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct inode *inode = file_inode(file);
>>       struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>       struct btrfs_ioctl_vol_args_v2 *vol_args;
>> @@ -3171,35 +3172,39 @@ static long btrfs_ioctl_rm_dev_v2(struct file
>> *file, void __user *arg)
>>       if (!capable(CAP_SYS_ADMIN))
>>           return -EPERM;
>>   -    ret = mnt_want_write_file(file);
>> -    if (ret)
>> -        return ret;
>> -
>>       vol_args = memdup_user(arg, sizeof(*vol_args));
>>       if (IS_ERR(vol_args)) {
> 
>>           ret = PTR_ERR(vol_args);
>> -        goto err_drop;
>> +        goto out;
> 
>      return  PTR_ERR(vol_args);
> 
> is fine here.
> 
>>       }
>>         if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
>>           ret = -EOPNOTSUPP;
>>           goto out;
> 
> At the label out, we call, btrfs_put_dev_args_from_path(&args).
> However, the args.fsid and args.uuid might not have initialized
> to NULL or a valid kmem address.

On tha contrary, the fact that args is initialized via a designated
initializer guarantees that the rest of the members of the struct are
going to be zero initialized, or more precisley as if they had a "static
lifetime"

https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

<snip>
