Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837C4D019B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiCGOmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 09:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCGOmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 09:42:14 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE465D38
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 06:41:19 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 00E77803F1;
        Mon,  7 Mar 2022 09:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1646664079; bh=WjeFez3xWTctE5oH1UF2JCImAhmfWxRqffK/ZSozPHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GbdnedIiba40GMN8Z02oMH0bNCEMiXOqlkyo/cEXv4lbyeKJj+JiAoIvmaL+fO6zd
         e6Ze9DTB9Uo54EAUM64Y32loWLmsrUjCyOKKZPptIjtInOuEnsaGlBRDFPdqCsyeLM
         Sk92gmnX7Qt3lXF65rgJcSr4twxhU8fa75vm6H3N+B0VuLMSZmJWJxsVZNQJOf/9ul
         rlBIhSEnJuCwyhZDqIlXRoVHqg9EqwIXdVGhwfFDz1SiilFo+K6gLe0FCZ++GQ8u4V
         xrzBZtmQtRg95QEXH5sVCf0u1K0bWmfGkJKYa6EssUh3X9nDephlHcI3/MBhYc0tKd
         tfQ1Yt2BVRl0g==
Message-ID: <d8bb896d-30f7-31bc-1edd-161d54305d34@dorminy.me>
Date:   Mon, 7 Mar 2022 09:41:18 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 00/12] btrfs: inode creation cleanups and fixes
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1646348486.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
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

For 1-11, please feel free to add

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

On 3/3/22 18:18, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> This series contains several cleanups and fixes for our inode creation
> codepaths. The main motivation for this is preparation for fscrypt
> support (in particular, setting up the fscrypt context at inode creation
> time). But, it also reduces a lot of code duplication and fixes some
> minor bugs, so it's worth getting in ahead of time.
>
> Patch 12 is the main change, which unifies and simplifies all of our
> inode creation codepaths. Patches 1-11 are small cleanups that I was
> able to peel off of the big patch.
>
> Thanks!
>
> Omar Sandoval (12):
>    btrfs: reserve correct number of items for unlink and rmdir
>    btrfs: reserve correct number of items for rename
>    btrfs: get rid of btrfs_add_nondir()
>    btrfs: remove unnecessary btrfs_i_size_write(0) calls
>    btrfs: remove unnecessary inode_set_bytes(0) call
>    btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
>    btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
>    btrfs: remove redundant name and name_len parameters to create_subvol
>    btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
>    btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
>    btrfs: set inode flags earlier in btrfs_new_inode()
>    btrfs: rework inode creation to fix several issues
>
>   fs/btrfs/acl.c   |  39 +-
>   fs/btrfs/ctree.h |  39 +-
>   fs/btrfs/inode.c | 944 +++++++++++++++++++++++------------------------
>   fs/btrfs/ioctl.c | 175 ++++-----
>   fs/btrfs/props.c |  40 +-
>   fs/btrfs/props.h |   4 -
>   6 files changed, 581 insertions(+), 660 deletions(-)
>
