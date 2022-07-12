Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B202657275F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 22:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGLUgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGLUgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 16:36:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AFBEB58
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 13:36:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5563F3382A;
        Tue, 12 Jul 2022 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657658161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHLNVgQObr8mDiE+4lY8Vl/3w/iEzS8jgmAvhCHbJ4A=;
        b=tIiAvkYKbSjDckYYznFr5ZzFLXlgmUyp7+gvM/AOLrMUPFBr8+3Tjp6yyFwme6T1f0xBqT
        fgnB1jSHUhKQyjOmWQPQI2qh7f/B+eUONsE/9yk9pAv9nXqoIWbiTIge8jb3Iw0NmWQC9q
        Gh1++Ijeh1tFa45CXgtHAt7ylSzTn1c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 275E713A94;
        Tue, 12 Jul 2022 20:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MiucBjHbzWKLXQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Jul 2022 20:36:01 +0000
Message-ID: <4ceb1340-0844-53d9-3e24-660f50019a1c@suse.com>
Date:   Tue, 12 Jul 2022 23:36:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: simplify error handling in btrfs_lookup_dentry
Content-Language: en-US
To:     Rohit Singh <rh0@fb.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220711151618.2518485-1-nborisov@suse.com>
 <Ys3Rdl7HrV+bbtmB@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <Ys3Rdl7HrV+bbtmB@fb.com>
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



On 12.07.22 г. 22:54 ч., Rohit Singh wrote:
> On Mon, Jul 11, 2022 at 06:16:18PM +0300, Nikolay Borisov wrote:
>> In btrfs_lookup_dentry releasing the reference of the sub_root and the
>> running orphan cleanup should only happen if the dentry found actually
>> represents a subvolume. This can only be true in the 'else' branch as
>> otherwise either fixup_tree_root_location returned an ENOENT error, in
>> which case sub_root wouldn't have been changed or if we got a different
>> errno this means btrfs_get_fs_root couldn't have executed successfully
>> again meaning sub_root will equal to root. So simplify all the branches
>> by moving the code into the 'else'.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>   fs/btrfs/inode.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 0b17335555e0..1dd073e96696 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -5821,11 +5821,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
>>   			inode = new_simple_dir(dir->i_sb, &location, sub_root);
>>   	} else {
>>   		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
>> -	}
>> -	if (root != sub_root)
>>   		btrfs_put_root(sub_root);
>> -
>> -	if (!IS_ERR(inode) && root != sub_root) {
> 
> It looks like the root != sub_root stuff looks correct.
> 
> Can't the btrfs inode have an error state on it though?

Yes it can, under low memory condition. So I guess the correct version would be:

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b17335555e0..44a2f38b2de0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5821,18 +5821,16 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
                         inode = new_simple_dir(dir->i_sb, &location, sub_root);
         } else {
                 inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
-       }
-       if (root != sub_root)
                 btrfs_put_root(sub_root);
-
-       if (!IS_ERR(inode) && root != sub_root) {
-               down_read(&fs_info->cleanup_work_sem);
-               if (!sb_rdonly(inode->i_sb))
-                       ret = btrfs_orphan_cleanup(sub_root);
-               up_read(&fs_info->cleanup_work_sem);
-               if (ret) {
-                       iput(inode);
-                       inode = ERR_PTR(ret);
+               if (!IS_ERR(inode)) {
+                       down_read(&fs_info->cleanup_work_sem);
+                       if (!sb_rdonly(inode->i_sb))
+                               ret = btrfs_orphan_cleanup(sub_root);
+                       up_read(&fs_info->cleanup_work_sem);
+                       if (ret) {
+                               iput(inode);
+                               inode = ERR_PTR(ret);
+                       }
                 }
         }

