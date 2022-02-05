Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198C94AA623
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 04:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379120AbiBEDNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 22:13:44 -0500
Received: from out20-37.mail.aliyun.com ([115.124.20.37]:39284 "EHLO
        out20-37.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378886AbiBEDNn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 22:13:43 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05353932|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00339441-0.00136205-0.995244;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Mll.9zb_1644030822;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Mll.9zb_1644030822)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sat, 05 Feb 2022 11:13:42 +0800
Date:   Sat, 05 Feb 2022 11:13:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Su Yue <l@damenly.su>
Subject: Re: [PATCH 2/2] btrfs: tree-checker: check item_size for dev_item
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20220121093335.1840306-3-l@damenly.su>
References: <20220121093335.1840306-1-l@damenly.su> <20220121093335.1840306-3-l@damenly.su>
Message-Id: <20220205111348.9D4B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

A btrfs filesystem failed to boot with this patch.

corrupt leaf: root=3 block=1081344 slot=0 devid=1 invalid item size: has 0 expect 98

Any way to fix it online?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/05

> Check item size before accessing the device item to avoid out of bound
> access.
> 
> Signed-off-by: Su Yue <l@damenly.su>
> ---
>  fs/btrfs/tree-checker.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 2978fc89c093..87fff4345977 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -965,6 +965,7 @@ static int check_dev_item(struct extent_buffer *leaf,
>  			  struct btrfs_key *key, int slot)
>  {
>  	struct btrfs_dev_item *ditem;
> +	u32 item_size = btrfs_item_size(leaf, slot);
>  
>  	if (unlikely(key->objectid != BTRFS_DEV_ITEMS_OBJECTID)) {
>  		dev_item_err(leaf, slot,
> @@ -972,6 +973,13 @@ static int check_dev_item(struct extent_buffer *leaf,
>  			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
>  		return -EUCLEAN;
>  	}
> +
> +	if (unlikely(item_size != sizeof(*ditem))) {
> +		dev_item_err(leaf, slot, "invalid item size: has=%u expect=%zu",
> +			     item_size, sizeof(*ditem));
> +		return -EUCLEAN;
> +	}
> +
>  	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
>  	if (unlikely(btrfs_device_id(leaf, ditem) != key->offset)) {
>  		dev_item_err(leaf, slot,
> -- 
> 2.34.1


