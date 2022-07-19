Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB157A30B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiGSPbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGSPay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 11:30:54 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6EE237E1;
        Tue, 19 Jul 2022 08:30:52 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E8C6B81223;
        Tue, 19 Jul 2022 11:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658244652; bh=QUE5lCqNFgbcwKZmRXIED2MBDwk+5Rg10YU04z5n0SM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=iXyZY/wN7BfiP74TyWsODbZP8OG8jmdEXsRzaMLre0sP1A4Ccja4jfQ+n5epkVPpv
         po6LaVLPthx3T2g/und2/z75Ekk4fE54qVC9D/hptFK1qRq0L0B1/MwfKH98v75Tgj
         M88lpbo+W/Fn/A/Zp/u6Xq4fWubEk8sewtNYbQJiYeRB4FVb4DhLvxJkB53/+bSGbu
         HB6bhvM1p2gASjOK6j0BXXOgLNGOnjhAOVOli/SR8RdrUvq7Bt7lbG7OvMFUl57i2m
         QLnb3e3UFiNZbwborkaLzP9cl3rN4aFkb+XGQ2v+inz5oZhFcJod2RbQ+ezAoqTJZJ
         eEAAlTnsEV+IA==
Message-ID: <b36032a0-f2a0-5ebb-2abb-c6b4434e9e68@dorminy.me>
Date:   Tue, 19 Jul 2022 11:30:50 -0400
MIME-Version: 1.0
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH] btrfs: fix btrfs/271
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220719061454.829559-1-hch@lst.de>
Content-Language: en-US
In-Reply-To: <20220719061454.829559-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-07-19 02:14, Christoph Hellwig wrote:
> The commited old version test the broken behavior of the current
> upstream code that writes the uncompressed data into a previously
> bad mirror.  Fix the test to check that the compressed data gets
> re-replicated and add it to the compress group while we're at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  tests/btrfs/270     | 11 +++++++----
>  tests/btrfs/270.out | 34 ----------------------------------
>  2 files changed, 7 insertions(+), 38 deletions(-)
> 
> diff --git a/tests/btrfs/270 b/tests/btrfs/270
> index 4229a02c..5b73fb15 100755
> --- a/tests/btrfs/270
> +++ b/tests/btrfs/270
> @@ -7,7 +7,7 @@
>  # Regression test for btrfs buffered read repair of compressed data.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick read_repair
> +_begin_fstest auto quick read_repair compress
> 
>  . ./common/filter
> 
> @@ -60,7 +60,9 @@ _scratch_unmount
>  echo "step 2......corrupt file extent"
>  echo " corrupt stripe #1, devid $devid devpath $devpath physical 
> $physical" \
>  	>> $seqres.full
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > 
> /dev/null
> +dd if=$devpath of=$TEST_DIR/$seq.dump.good skip=$physical bs=1 
> count=4096 \
> +	2>/dev/null
> +$XFS_IO_PROG -c "pwrite -S 0xbb -b 4K $physical 4K" $devpath > 
> /dev/null
> 
>  _scratch_mount
> 
> @@ -70,8 +72,9 @@ _btrfs_buffered_read_on_mirror 1 2
> "$SCRATCH_MNT/foobar" 0 128K
>  _scratch_unmount
> 
>  echo "step 4......check if the repair worked"
> -$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
> -	_filter_xfs_io_offset
> +dd if=$devpath of=$TEST_DIR/$seq.dump skip=$physical bs=1 count=4096 \
> +	2>/dev/null
> +cmp -bl $TEST_DIR/$seq.dump.good $TEST_DIR/$seq.dump
> 
>  _scratch_dev_pool_put
>  # success, all done
> diff --git a/tests/btrfs/270.out b/tests/btrfs/270.out
> index 53a80692..6d744c02 100644
> --- a/tests/btrfs/270.out
> +++ b/tests/btrfs/270.out
> @@ -5,37 +5,3 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX 
> ops/sec)
>  step 2......corrupt file extent
>  step 3......repair the bad copy
>  step 4......check if the repair worked
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  
> ................
> -read 512/512 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
