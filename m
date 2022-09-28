Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855785EDECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiI1Oaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiI1Oa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 10:30:28 -0400
Received: from out20-85.mail.aliyun.com (out20-85.mail.aliyun.com [115.124.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48676768
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 07:30:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05532454|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0720796-0.00280173-0.925119;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PQb0xQQ_1664375422;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PQb0xQQ_1664375422)
          by smtp.aliyun-inc.com;
          Wed, 28 Sep 2022 22:30:22 +0800
Date:   Wed, 28 Sep 2022 22:30:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH PoC v2 04/10] btrfs: scrub: introduce place holder helper scrub_fs_block_group()
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <ba1a99b5c44dd02a9ebb63cb95d8dc4080bd1949.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com> <ba1a99b5c44dd02a9ebb63cb95d8dc4080bd1949.1664353497.git.wqu@suse.com>
Message-Id: <20220928223024.79F6.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> The main place holder helper scrub_fs_block_group() will:
> 
> - Initialize various needed members inside scrub_fs_ctx
>   This includes:
>   * Calculate the nr_copies for non-RAID56 profiles, or grab nr_stripes
>     for RAID56 profiles.
>   * Allocate memory for sectors/pages array, and csum_buf if it's data
>     bg.
>   * Initialize all sectors to type UNUSED.
> 
>   All these above memory will stay for each stripe we run, thus we only
>   need to allocate these memories once-per-bg.
> 
> - Iterate stripes containing any used sector
>   This is the code to be implemented.
> 
> - Cleanup above memories before we finish the block group.
> 
> The real work of scrubbing a stripe is not yet implemented.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 232 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 97da8545c9ab..6e6c50962ace 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -198,6 +198,45 @@ struct scrub_ctx {
>  	refcount_t              refs;
>  };
>  
> +#define SCRUB_FS_SECTOR_FLAG_UNUSED		(1 << 0)
> +#define SCRUB_FS_SECTOR_FLAG_DATA		(1 << 1)
> +#define SCRUB_FS_SECTOR_FLAG_META		(1 << 2)
> +#define SCRUB_FS_SECTOR_FLAG_PARITY		(1 << 3)
> +

there is few use case for SCRUB_FS_SECTOR_FLAG_PARITY ?

and we may need SCRUB_FS_SECTOR_FLAG_SYSTEM so we can match 'btrfs scrub
start' well with 'btrfs balance start -d -m -s'

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/28



