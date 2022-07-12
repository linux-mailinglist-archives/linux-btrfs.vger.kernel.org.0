Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E373572893
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 23:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiGLV01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGLV0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 17:26:25 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C97D0E22
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 14:26:24 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C332680D88;
        Tue, 12 Jul 2022 17:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657661183; bh=R7Jkg1zEwTCIHU657jVm6+Yt1Z58/hCosgtxp4R1/mA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jm2AvZ00jvlnvTW2PDsZHnGj0S5bw8DAi28RZBfKLRgTcwKlDgS5wcfHTciRRVDTw
         km39LzmjzvGqGfbeYB7DJT2IpKDpgyXdnpddxES5o7DtOS11wTh0Z67ODPTjggQvhH
         dtfto3wJX/qZHMJ87alWP10zcEvVG0YCr3VIXqxJcWxuvUlUHic98GRg6vRrYsX5Tt
         KZx60UTkXaEoEIAW3Ei3iRnFtalGzMKfK4/hOpvXfpNQW96Xu7Rk3dnDeq/DT86GTz
         MV88GSGZ0KH5F+ckLWxZ8oOHEEzgMprigccGq9vo2aEuNObqksb7riVF/Eyf5xRrDc
         EsX61wancvBqA==
Message-ID: <3a699181-680c-42cb-de1c-8b9f53d753f3@dorminy.me>
Date:   Tue, 12 Jul 2022 17:26:21 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: simplify error handling in btrfs_lookup_dentry
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Rohit Singh <rh0@fb.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220711151618.2518485-1-nborisov@suse.com>
 <Ys3Rdl7HrV+bbtmB@fb.com> <4ceb1340-0844-53d9-3e24-660f50019a1c@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <4ceb1340-0844-53d9-3e24-660f50019a1c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0b17335555e0..44a2f38b2de0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5821,18 +5821,16 @@ struct inode *btrfs_lookup_dentry(struct inode 
> *dir, struct dentry *dentry)
>                          inode = new_simple_dir(dir->i_sb, &location, 
> sub_root);
>          } else {
>                  inode = btrfs_iget(dir->i_sb, location.objectid, 
> sub_root);
> -       }
> -       if (root != sub_root)
>                  btrfs_put_root(sub_root);
> -
> -       if (!IS_ERR(inode) && root != sub_root) {
> -               down_read(&fs_info->cleanup_work_sem);
> -               if (!sb_rdonly(inode->i_sb))
> -                       ret = btrfs_orphan_cleanup(sub_root);
> -               up_read(&fs_info->cleanup_work_sem);
> -               if (ret) {
> -                       iput(inode);
> -                       inode = ERR_PTR(ret);
> +               if (!IS_ERR(inode)) {
> +                       down_read(&fs_info->cleanup_work_sem);
> +                       if (!sb_rdonly(inode->i_sb))
> +                               ret = btrfs_orphan_cleanup(sub_root);
> +                       up_read(&fs_info->cleanup_work_sem);
> +                       if (ret) {
> +                               iput(inode);
> +                               inode = ERR_PTR(ret);
> +                       }
>                  }
>          }

I was looking at this just now because Rohit was talking about it, and 
noticed you could potentially reduce indentation a hair if you felt like it:


         } else {
                 inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
-       }
-       if (root != sub_root)
-               btrfs_put_root(sub_root);
-
-       if (!IS_ERR(inode) && root != sub_root) {
+               if (IS_ERR(inode))
+                       return inode;
                 down_read(&fs_info->cleanup_work_sem);
                 if (!sb_rdonly(inode->i_sb))
                         ret = btrfs_orphan_cleanup(sub_root);
