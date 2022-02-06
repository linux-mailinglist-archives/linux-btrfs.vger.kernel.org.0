Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878504AB04E
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 16:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbiBFPjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 10:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 10:39:23 -0500
Received: from out20-2.mail.aliyun.com (out20-2.mail.aliyun.com [115.124.20.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C1C043184
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 07:39:20 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0559254|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00595614-0.00251912-0.991525;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Mm9MvcP_1644161950;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Mm9MvcP_1644161950)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sun, 06 Feb 2022 23:39:11 +0800
Date:   Sun, 06 Feb 2022 23:39:12 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Su Yue <l@damenly.su>
Subject: Re: [PATCH 2/2] btrfs: tree-checker: check item_size for dev_item
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <5ypsw5k3.fsf@damenly.su>
References: <20220205224936.478B.409509F4@e16-tech.com> <5ypsw5k3.fsf@damenly.su>
Message-Id: <20220206233912.BA89.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> >> >>>> A btrfs filesystem failed to boot with this patch.
> >> >>>>
> >> >>>> corrupt leaf: root=3 block=1081344 slot=0 devid=1 invalid
> >> >>>> item
> >> >>>> size: has 0 expect 98
> >> >>>>


> As Qu suggested to me, would you plase provide output after
> apply of the following diff? (It may crash the kernel if there is *real*
> one invalid dev_item).
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 9fd145f1c4bc..5fb981b4b42a 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -25,6 +25,7 @@
>  #include "volumes.h"
>  #include "misc.h"
>  #include "btrfs_inode.h"
> +#include "print-tree.h"
> 
>  /*
>   * Error message should follow the following format:
> @@ -977,6 +978,7 @@ static int check_dev_item(struct extent_buffer *leaf,
>         if (unlikely(item_size != sizeof(*ditem))) {
>                 dev_item_err(leaf, slot, "invalid item size: has                 %u expect %zu",
>                              item_size, sizeof(*ditem));
> +               btrfs_print_leaf(leaf);
>                 return -EUCLEAN;
>         }

When I tested this new diag patch, I noticed that I wrongly applied
these 2 patches to 5.15.x.
btrfs-tree-checker-check-item_size-for-inode_item.patch
btrfs-tree-checker-check-item_size-for-dev_item.patch

some depency patches(at least btrfs-drop-the-_nr-from-the-item-helpers.patch,
maybe more) are missed.

In fact, without these depency patches, there are some build warning,
but I failed to noticed them.

so this is just my bad now. sorry.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/06


