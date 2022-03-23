Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5707E4E5BFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 00:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiCWXn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 19:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbiCWXns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 19:43:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4CBD8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:42:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 390E4210F0;
        Wed, 23 Mar 2022 23:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648078937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MCL9/IAhgAj/6NfC5o+xhf4NTmZKOzbdKw0/eD/p90=;
        b=QOz18Pb+oUXpxDpMUb/KUPmC2wKQ27FtbRP67frNSb0UuIZgZXnxiLuzw4sw38ftvlxgfM
        QTfchh1obbkyeh0xLKG1TKVy0cMEwjfeLZXpAgIVDR7c9lMD0ziwjbvcEWiQXhnNPyY/CZ
        twlIyDeDUbxirAqeOLbxhXXFu2hem2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648078937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MCL9/IAhgAj/6NfC5o+xhf4NTmZKOzbdKw0/eD/p90=;
        b=2uwX2C33P3sqVHZxSuP9bjw5hpTG3fLSwdjStA5BDimZ4Mux7wlesc6lNTVRZvU8mf/vpI
        INDl5AvgBDmp2jCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2B3A2A3B83;
        Wed, 23 Mar 2022 23:42:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99A8EDA7DE; Thu, 24 Mar 2022 00:38:22 +0100 (CET)
Date:   Thu, 24 Mar 2022 00:38:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     boris@bur.io, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add print support for verity items.
Message-ID: <20220323233822.GG2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, boris@bur.io,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220323194504.1777182-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220323194504.1777182-1-sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 03:45:05PM -0400, Sweet Tea Dorminy wrote:
> 'btrfs inspect-internals dump-tree' doesn't currently know about the two
> types of verity items and prints them as 'UNKNOWN.36' or 'UNKNOWN.37'.
> So add them to the known item types.
> 
> Suggested-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> ---
> 
> Inspired by Boris' recent patchset noting that these items were not yet
> properly printed:
> https://lore.kernel.org/linux-btrfs/5579a70597cd660ffb265db9e97840a1faca8812.1647382272.git.boris@bur.io/T/#u
> 
> ---
> 
>  kernel-shared/ctree.h      | 4 ++++
>  kernel-shared/print-tree.c | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index bf71fc85..b8d7e5a8 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1350,6 +1350,10 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  #define BTRFS_INODE_REF_KEY		12
>  #define BTRFS_INODE_EXTREF_KEY		13
>  #define BTRFS_XATTR_ITEM_KEY		24
> +
> +#define BTRFS_VERITY_DESC_ITEM_KEY	36
> +#define BTRFS_VERITY_MERKLE_ITEM_KEY	37
> +
>  #define BTRFS_ORPHAN_ITEM_KEY		48
>  
>  #define BTRFS_DIR_LOG_ITEM_KEY  60
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index 73f969c3..ee7f679c 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -647,6 +647,8 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
>  		[BTRFS_DIR_LOG_ITEM_KEY]	= "DIR_LOG_ITEM",
>  		[BTRFS_DIR_LOG_INDEX_KEY]	= "DIR_LOG_INDEX",
>  		[BTRFS_XATTR_ITEM_KEY]		= "XATTR_ITEM",
> +		[BTRFS_VERITY_DESC_ITEM_KEY]	= "VERITY_DESC_ITEM",
> +		[BTRFS_VERITY_MERKLE_ITEM_KEY	= "VERITY_MERKLE_ITEM",

    [CC]     kernel-shared/print-tree.o
kernel-shared/print-tree.c: In function ‘print_key_type’:
kernel-shared/print-tree.c:650:49: error: lvalue required as left operand of assignment
  650 |                 [BTRFS_VERITY_MERKLE_ITEM_KEY   = "VERITY_MERKLE_ITEM",
      |                                                 ^
kernel-shared/print-tree.c:650:71: error: expected ‘]’ before ‘,’ token
  650 |                 [BTRFS_VERITY_MERKLE_ITEM_KEY   = "VERITY_MERKLE_ITEM",
      |                                                                       ^
      |                                                                       ]
kernel-shared/print-tree.c:682:9: error: expected expression before ‘}’ token
  682 |         };
      |         ^
make: *** [Makefile:414: kernel-shared/print-tree.o] Error 1
