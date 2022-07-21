Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D357CF65
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiGUPhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 11:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiGUPhA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 11:37:00 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97802D9E
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 08:36:45 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0A067811FD;
        Thu, 21 Jul 2022 11:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658417805; bh=Z2etR5LfMH+nHpM0sKVHGrdYwTmM9p4JdNPa0mNAG1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lgr9oVbIbLk8qhzGsfRfg008K1F6JQD/Jii7V+vyn/O8E2Gfw0hnHa8fOuQfuB0xf
         16OAkzLzTuusyO9kXOlRyOI5E67P8kDp6X1z3tPqS28Tpko5602yVKYW6aHGyxr39e
         zcOgGf/nVirgk3daoTwKELqpJr4ppN+1cGEJjT0DL8SIt61jl1CRf2h3EXCoLZl1Pm
         FG00trIHC4iCrEVKIrFh9HAFrOHNFXRJfJMD30/bwhGL4PFflSdQJTqV3IpXfw0sp9
         vpo672vtbiswQmu8YDCNFWf7gC4nFlC/H3Xx1lgWgBVLvbu+gwo1B7sftIxVAlbIct
         LEt8xyu27AouQ==
MIME-Version: 1.0
Date:   Thu, 21 Jul 2022 11:36:44 -0400
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Remove duplicate code in
 btrfs_prune_dentries/find_next_inode
In-Reply-To: <20220721135006.3345302-1-nborisov@suse.com>
References: <20220721135006.3345302-1-nborisov@suse.com>
Message-ID: <ff489af54f3e4cfc521876c4208b103e@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

checkpatch has a minor nit, while(node) needs to be while (node), but 
otherwise, for the series:

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

On 2022-07-21 09:50, Nikolay Borisov wrote:
> Both functions share similar logic to find a particular inode. So this 
> series
> first factors out the common code in btrfs_find_inode and subsequently 
> uses it
> to remove most of the internals of the two client functions. This 
> greatly
> streamlines the codeflow in the affected functions.
> 
> The changes survived a full xfstest run.
> 
> Nikolay Borisov (3):
>   btrfs: introduce btrfs_find_inode
>   btrfs: use btrfs_find_inode in btrfs_prune_dentries
>   btrfs: use btrfs_find_inode in find_next_inode
> 
>  fs/btrfs/ctree.h      |  1 +
>  fs/btrfs/inode.c      | 75 ++++++++++++++++++++++++++++++-------------
>  fs/btrfs/relocation.c | 54 +++++++++++--------------------
>  3 files changed, 73 insertions(+), 57 deletions(-)
> 
> --
> 2.25.1
