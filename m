Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33425F4FD8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJEGnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 02:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJEGnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 02:43:07 -0400
Received: from out20-109.mail.aliyun.com (out20-109.mail.aliyun.com [115.124.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E461DAF
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 23:43:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07374419|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00644198-0.000658932-0.992899;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PUQRkfq_1664952183;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PUQRkfq_1664952183)
          by smtp.aliyun-inc.com;
          Wed, 05 Oct 2022 14:43:03 +0800
Date:   Wed, 05 Oct 2022 14:43:12 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 2/3] btrfs-progs: mkfs-tests/025: fix the wrong function call
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <e89c8122b8b999737e4164467b2b6164daae0575.1664936628.git.wqu@suse.com>
References: <cover.1664936628.git.wqu@suse.com> <e89c8122b8b999737e4164467b2b6164daae0575.1664936628.git.wqu@suse.com>
Message-Id: <20221005144310.DA9C.409509F4@e16-tech.com>
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

> [BUG]
> Btrfs-progs test case mkfs/025 will output the following error:
> 
>   # make TEST=025\* test-mkfs
>     [TEST]   mkfs-tests.sh
>     [TEST/mkfs]   025-zoned-parallel
>   ./test.sh: line 11: !check_min_kernel_version: command not found
> 
> [CAUSE]
> There lacks a space between "!" and the function we called.
> 
> [FIX]
> Add back the missing space.
> 
> Note that, this requires the previous fix on check_min_kernel_version(),
> or it will not properly work on v6.x kernels.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/mkfs-tests/025-zoned-parallel/test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/mkfs-tests/025-zoned-parallel/test.sh b/tests/mkfs-tests/025-zoned-parallel/test.sh
> index 8cad906cd5d1..83274bb23447 100755
> --- a/tests/mkfs-tests/025-zoned-parallel/test.sh
> +++ b/tests/mkfs-tests/025-zoned-parallel/test.sh
> @@ -8,7 +8,7 @@ source "$TEST_TOP/common"
>  setup_root_helper
>  prepare_test_dev
>  
> -if !check_min_kernel_version 5.12; then
> +if ! check_min_kernel_version 5.12; then
>  	_notrun "zoned tests need kernel 5.12 and newer"
>  fi

'_notrun' should be changed to '_not_run' too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/10/05

>  
> -- 
> 2.37.3


