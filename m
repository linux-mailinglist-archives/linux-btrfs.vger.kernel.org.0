Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3B5B42EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Sep 2022 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiIIXMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiIIXMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 19:12:36 -0400
Received: from out198-163.us.a.mail.aliyun.com (out198-163.us.a.mail.aliyun.com [47.90.198.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA56E0BE
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 16:11:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05464048|-1;BR=01201311R141S02rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0754572-0.00556135-0.918981;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.PCA5391_1662765052;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PCA5391_1662765052)
          by smtp.aliyun-inc.com;
          Sat, 10 Sep 2022 07:10:52 +0800
Date:   Sat, 10 Sep 2022 07:10:58 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: mkfs: use pretty_size_mode() on min size error
Cc:     dsterba@suse.com, johannes.thumshirn@wdc.com, naohiro.aota@wdc.com,
        damien.lemoal@wdc.com, pankydev8@gmail.com, p.raghav@samsung.com,
        mcgrof@kernel.org
In-Reply-To: <20220909214810.761928-3-mcgrof@kernel.org>
References: <20220909214810.761928-1-mcgrof@kernel.org> <20220909214810.761928-3-mcgrof@kernel.org>
Message-Id: <20220910071057.1F80.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Use a human pretty output for the error message about the
> minimum required size for a btrfs filesystem.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mkfs/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ebf462587bd5..8a0018abd01e 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1388,10 +1388,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	}
>  	/* Check device/block_count after the nodesize is determined */
>  	if (block_count && block_count < min_dev_size) {
> -		error("size %llu is too small to make a usable filesystem",
> -			block_count);
> -		error("minimum size for btrfs filesystem is %llu",
> -			min_dev_size);
> +		error("Size %s is too small to make a usable filesystem",
> +			pretty_size_mode(block_count, UNITS_DEFAULT));
> +		error("minimum size for btrfs filesystem is %s",
> +			pretty_size_mode(min_dev_size, UNITS_DEFAULT));
>  		goto error;
>  	}
>  	/*
> -- 
> 2.35.1

Could we do a rename 'block_count' to 'byte_count' here?

It is a size based on byte, not based on block (sector).

and '--byte-count' is used as a param of mkfs.btrfs.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/10


