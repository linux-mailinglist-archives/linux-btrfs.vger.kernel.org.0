Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5652837A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiEPLqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiEPLqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 07:46:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB4EE0AC
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 04:45:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A525A21FD5;
        Mon, 16 May 2022 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652701558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5W/sNGE5fwKhB5JziK8Is7DJ6eozjkARyx9JO7D31Zc=;
        b=CYnw2PN8ro7tJxjP4oXuz+sJIQTcVnA0S66nbgQzxP2+o2EJNWccMcGKnemNX/33SEOgY3
        CsjLvRBLG7BE4Z7xsilSxh5Omlk9ywOfQMvdQR7CJ9FGryzqJjODLYDtgbFsNozwV16S7p
        hNTS1J8pl1ItQzq+oRVG2upfTEtogv4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F40013AAB;
        Mon, 16 May 2022 11:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bHoNE3Y5gmJ1TAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 16 May 2022 11:45:58 +0000
Message-ID: <576a6039-5ee3-6b5e-aa3c-8caaeec956df@suse.com>
Date:   Mon, 16 May 2022 14:45:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [bug report] btrfs: turn fs_roots_radix in btrfs_fs_info into an
 XArray
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gniebler@suse.com, linux-btrfs@vger.kernel.org
References: <YoIFmTMuHork+zC2@kili>
 <beed78e9-ca59-636a-1503-cd10eca2b276@suse.com>
 <20220516110239.GH29930@kadam>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220516110239.GH29930@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.05.22 г. 14:02 ч., Dan Carpenter wrote:
> On Mon, May 16, 2022 at 01:39:52PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 16.05.22 г. 11:04 ч., Dan Carpenter wrote:
>>> Hello Gabriel Niebler,
>>>
>>> The patch 06a79e50ff00: "btrfs: turn fs_roots_radix in btrfs_fs_info
>>> into an XArray" from May 3, 2022, leads to the following Smatch
>>> static checker warning:
>>>
>>> 	fs/btrfs/disk-io.c:4560 btrfs_cleanup_fs_roots()
>>> 	warn: ignoring unreachable code.
>>>
>>> fs/btrfs/disk-io.c
>>>       4520 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>>>       4521 {
>>>       4522         struct btrfs_root *roots[8];
>>>       4523         unsigned long index = 0;
>>>       4524         int i;
>>>       4525         int err = 0;
>>>       4526         int grabbed;
>>>       4527
>>>       4528         while (1) {
>>>       4529                 struct btrfs_root *root;
>>>       4530
>>>       4531                 spin_lock(&fs_info->fs_roots_lock);
>>>       4532                 if (!xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
>>>       4533                         spin_unlock(&fs_info->fs_roots_lock);
>>>       4534                         return err;
>>>       4535                 }
>>>       4536
>>>       4537                 grabbed = 0;
>>>       4538                 xa_for_each_start(&fs_info->fs_roots, index, root, index) {
>>>       4539                         /* Avoid grabbing roots in dead_roots */
>>>       4540                         if (btrfs_root_refs(&root->root_item) > 0)
>>>       4541                                 roots[grabbed++] = btrfs_grab_root(root);
>>>       4542                         if (grabbed >= ARRAY_SIZE(roots))
>>>       4543                                 break;
> 
> breaks out of xa_for_each_start() loop.

This is fine, as when we fill root[] then we'd process it in the 
subsequent for loop.

> 
>>>       4544                 }
>>>       4545                 spin_unlock(&fs_info->fs_roots_lock);
>>>       4546
>>>       4547                 for (i = 0; i < grabbed; i++) {
>>>       4548                         if (!roots[i])
>>>       4549                                 continue;
>>>       4550                         index = roots[i]->root_key.objectid;
>>>       4551                         err = btrfs_orphan_cleanup(roots[i]);
>>>       4552                         if (err)
>>>       4553                                 break;
> 
> breaks out of for loop.

However, this is indeed a genuine bug, and the fix for it is:

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fe309db9f5ff..f33093513360 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4549,12 +4549,13 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info 
*fs_info)
                         index = roots[i]->root_key.objectid;
                         err = btrfs_orphan_cleanup(roots[i]);
                         if (err)
-                               break;
+                               goto out;
                         btrfs_put_root(roots[i]);
                 }
                 index++;
         }

+out:
         /* Release the roots that remain uncleaned due to error */
         for (; i < grabbed; i++) {
                 if (roots[i])


> 
>>>       4554                         btrfs_put_root(roots[i]);
>>>       4555                 }
>>>       4556                 index++;
>>>       4557         }
>>>       4558
>>>       4559         /* Release the roots that remain uncleaned due to error */
>>> --> 4560         for (; i < grabbed; i++) {
>>>
>>> This code is unreachable now.
>>
>> How is it unreachable, if we error in the middle of btrfs_orphan_cleanup,
>> we'd break and this loop will cleanup the rest of the roots,
> 
> There are breaks inside the inner loops but nothing breaks out of the
> while (1) loop.
> 
> regards,
> dan carpenter
> 
