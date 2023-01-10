Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CD663F35
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjAJLXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 06:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjAJLXb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 06:23:31 -0500
Received: from out20-51.mail.aliyun.com (out20-51.mail.aliyun.com [115.124.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129F44C50;
        Tue, 10 Jan 2023 03:23:26 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08125543|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0648409-0.00114849-0.934011;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.QpJ7-NX_1673349800;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QpJ7-NX_1673349800)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 19:23:21 +0800
Date:   Tue, 10 Jan 2023 19:23:22 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs/012: check if ext4 is available
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Zorro Lang <zlang@redhat.com>
In-Reply-To: <20230110082924.1687152-1-johannes.thumshirn@wdc.com>
References: <20230110082924.1687152-1-johannes.thumshirn@wdc.com>
Message-Id: <20230110192321.34D5.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> btrfs/012 is requiring ext4 support to test the conversion, but the test
> case is only checking if mkfs.ext4 is available, not if the filesystem
> driver is actually available on the test host.
> 
> Check if the driver is available as well, before trying to run the test.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/012 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index 60461a342545..86fbbb7ac189 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -32,6 +32,8 @@ _require_command "$E2FSCK_PROG" e2fsck
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  _require_loop
>  
> +grep -q ext4 /proc/filesystems || _notrun "no ext4 support"

when ext4 is module, and is not used, 'ext4' will not be in /proc/filesystems.

so we need a right way to check ext4 support.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/10

