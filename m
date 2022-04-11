Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E64FB265
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 05:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiDKDfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Apr 2022 23:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243905AbiDKDf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Apr 2022 23:35:27 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Apr 2022 20:33:12 PDT
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671293700C
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Apr 2022 20:33:11 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 9C01A80E02;
        Mon, 11 Apr 2022 03:27:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id EF0F620013;
        Mon, 11 Apr 2022 03:27:47 +0000 (UTC)
Message-ID: <c855ba7ca204b948c59c9fd966c154e5505b3d77.camel@perches.com>
Subject: Re: [PATCH] btrfs: remove unnecessary conditional
From:   Joe Perches <joe@perches.com>
To:     cgel.zte@gmail.com, dsterba@suse.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Sun, 10 Apr 2022 20:27:47 -0700
In-Reply-To: <20220411032252.2517399-1-lv.ruyi@zte.com.cn>
References: <20220411032252.2517399-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EF0F620013
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Stat-Signature: x9zcho6otzoqyaap4jsuow1knk4szspy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/JE10KGuUKttvL2rS3dxE7Klpi/bq+qqs=
X-HE-Tag: 1649647667-178116
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2022-04-11 at 03:22 +0000, cgel.zte@gmail.com wrote:
> iput() has already handled null and non-null parameter, so it is no
> need to use if().
[]
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
[]
> @@ -3846,8 +3846,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
>  	btrfs_end_transaction(trans);
>  	btrfs_btree_balance_dirty(fs_info);
>  	if (err) {
> -		if (inode)
> -			iput(inode);
> +		iput(inode);
>  		inode = ERR_PTR(err);
>  	}
>  	return inode;

I think a direct return would be easier to understand.

	if (err) {
		iput(inode);
		return ERR_PTR(err);
	}

	return inode;


