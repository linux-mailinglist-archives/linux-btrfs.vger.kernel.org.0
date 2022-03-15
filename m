Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074D4D9E4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbiCOPBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbiCOPBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:01:39 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59155BDA
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:00:26 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E6085802A9;
        Tue, 15 Mar 2022 11:00:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647356426; bh=FwZQ5RbuBY0zzW9zVvYzzMhjCKhjupko8xRCQ1vyZIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uVqIPgDcXeDoelbW9Sa9BGL/7QAaLeEz7/VYFBruMRPIdUN/3foLmd/0SLFyxKbb+
         7K6hB9QrDR+/6/KMngFyrDhTOWJyN4fMZik6CTkqAE+QjLVKrBtPp89tmlFfU/g4KI
         NzW9sB2Ng1iiAG3Iz7LBXAy6vMGjHJFyTnC0sKi7PPiQNCG6YWPhYxa/FvSClDe+vh
         9wvhO3jIgQWzfE3IG6GzLcbqOKMwBPcDLghHkIj/yyBnT5vKRGakW7TIEA+jeUb5m0
         F31RBVxiMYCXG8jlJFVkezzteUAeghMf3cfbhL/oWfSwyZNANlnkLuQz1cGxHHhUiT
         yGR1CeP2SWz/A==
Message-ID: <13b94cc4-2656-4409-94da-3739b09b0388@dorminy.me>
Date:   Tue, 15 Mar 2022 11:00:23 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] btrfs: inode creation cleanups and fixes
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1647306546.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1647306546.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All looks good to me still. Thanks!

On 3/14/22 21:12, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> This series contains minor updates of the final four patches of my
> previous series [1].
>
> Based on misc-next with the previous version of "btrfs: allocate inode
> outside of btrfs_new_inode()" removed.
>
> Changes since v3 [2]:
>
> - Fixed a struct btrfs_root leak [3] in patch 1 which was fixed later in
>    the same series by patch 3 for the sake of git bisect.
>
> Changes since v2:
>
> - Mentioned reason for removal of btrfs_lookup_dentry() call in
>    create_subvol() in commit message of patch 1.
> - Made btrfs_init_inode_security() also take btrfs_new_inode_args in
>    patch 2.
>
> Thanks!
>
> 1: https://lore.kernel.org/linux-btrfs/cover.1646875648.git.osandov@fb.com/
> 2: https://lore.kernel.org/linux-btrfs/cover.1647288019.git.osandov@fb.com/
> 3: https://lore.kernel.org/linux-btrfs/CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com/
>
> Omar Sandoval (4):
>    btrfs: allocate inode outside of btrfs_new_inode()
>    btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
>    btrfs: reserve correct number of items for inode creation
>    btrfs: move common inode creation code into btrfs_create_new_inode()
>
>   fs/btrfs/acl.c   |  36 +--
>   fs/btrfs/ctree.h |  37 ++-
>   fs/btrfs/inode.c | 800 +++++++++++++++++++++++------------------------
>   fs/btrfs/ioctl.c | 140 +++++----
>   fs/btrfs/props.c |  40 +--
>   fs/btrfs/props.h |   4 -
>   6 files changed, 489 insertions(+), 568 deletions(-)
>
