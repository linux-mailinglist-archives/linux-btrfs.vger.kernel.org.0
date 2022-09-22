Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2825E6755
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 17:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIVPls (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIVPlr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 11:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04344EFA66
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663861305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuEVOCaePF0x52QRZveop/hCtakLu2js5SPN/0L6700=;
        b=Twbpeqw388BXq6Bm4x0QCeZo2zgqflbIzu1ukSsug6x/SKigUjOPfjWbnTCorLW3IHwoYy
        tYdBU32ZzakFLJeFMTWYF5esx2pHdWQO2kVNJfwRgR/5r6g05ao7p4BIZK0kM0LPgxLlQ9
        vM3TipplB8YEo6UEGnX8ODJdBtCrrlI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-F2V1b-7EPFWBkyakoUoSGA-1; Thu, 22 Sep 2022 11:41:39 -0400
X-MC-Unique: F2V1b-7EPFWBkyakoUoSGA-1
Received: by mail-qv1-f72.google.com with SMTP id y7-20020ad45307000000b004ac7fd46495so6741829qvr.23
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 08:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nuEVOCaePF0x52QRZveop/hCtakLu2js5SPN/0L6700=;
        b=JKZDbGlqU0Ug/SKpexw2eM152tPQ1YY4y8Rj9aPlKrC9es0TI3Rh7gTrTx0gdeY0j7
         U13ir07rwK2wjwmGT50uuJlfvSTqW9mk+FrYhf4OOJmixLAqpZ55UzYy2dj4fjwHQ82q
         ZiNkbgnP1qsfYlgg6zR9+dOHrsKs5gq0jbmrT9uc3dE04PEL2Lb2tgi18tgwpB8SBFz0
         c80RyJnAWy2gTX5VGLxQpbAiJMdFd+cdy+hMjbkZBkNxWWtbafIlIbT/cCDKwdVoE12s
         IHskO1ub3AX/06ea6+glZJHQQWn4pq+YlwoEoafEYDFoIE7qT/q6V/6outTUk0B3xl97
         h2lQ==
X-Gm-Message-State: ACrzQf2ZXgR5P9xQGSBcxscwqTT7kxsviEmJT9xXEr9Vo2Tn8tJUscJS
        6f71r3celco6fO6U8aztV95K6qQNCzvDt5r3l5gCQyH2OSfPsjChW7Gl68nKqkffBVQehpb0aqg
        6Q3++qezF/T9uV22ER5vpG3E=
X-Received: by 2002:a05:620a:2910:b0:6ce:1517:918 with SMTP id m16-20020a05620a291000b006ce15170918mr2640654qkp.190.1663861297827;
        Thu, 22 Sep 2022 08:41:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JLuPBlrTKAe+fIcdQMnOfUld9Eo7n49K0Tld3CA1tQKnRKtXLMI25ZQa9MYbQHMZ9bS3dGQ==
X-Received: by 2002:a05:620a:2910:b0:6ce:1517:918 with SMTP id m16-20020a05620a291000b006ce15170918mr2640647qkp.190.1663861297586;
        Thu, 22 Sep 2022 08:41:37 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q14-20020a37f70e000000b006bba46e5eeasm3735100qkj.37.2022.09.22.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:41:37 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:41:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Message-ID: <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 22, 2022 at 02:54:58PM +0900, Naohiro Aota wrote:
> Introduce _zone_capacity() to return a zone capacity of the given address
> in the given device (optional). Rewrite btrfs/237 with it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/zbd      | 17 +++++++++++++++++
>  tests/btrfs/237 |  8 ++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
>  create mode 100644 common/zbd
> 
> diff --git a/common/zbd b/common/zbd
> new file mode 100644
> index 000000000000..329bb7be6b7b
> --- /dev/null
> +++ b/common/zbd

I don't like this abbreviation :-P If others don't open this file and read the
comment in it, they nearly no chance to guess what's this file for.

> @@ -0,0 +1,17 @@
> +#
> +# Common zoned block device specific functions
> +#
> +
> +. common/filter
> +
> +_zone_capacity() {
> +    local phy=$1
> +    local dev=$2
> +
> +    [ -z "$dev" ] && dev=$SCRATCH_DEV
> +
> +    size=$($BLKZONE_PROG report -o $phy -l 1 $dev |\
> +	       _filter_blkzone_report |\
> +	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> +    echo $((size << 9))
> +}

Do you have more zone related helpers are going to provide? If only this
single one helper, I think it's not worth adding a new common file. You
can put it into common/rc simply, as there're already several *zone*
related helpers in it.

We can pick up these *zone* related function into a separate include file in
one day we feel it's time (too many related helpers, and better to be maintained
individually).

Thanks,
Zorro

> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index bc6522e2200a..101094b5ce70 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -13,7 +13,7 @@
>  _begin_fstest auto quick zone balance
>  
>  # Import common functions.
> -. ./common/filter
> +. ./common/zbd
>  
>  # real QA test starts here
>  
> @@ -56,11 +56,7 @@ fi
>  
>  start_data_bg_phy=$(get_data_bg_physical)
>  start_data_bg_phy=$((start_data_bg_phy >> 9))
> -
> -size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
> -	_filter_blkzone_report |\
> -	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> -size=$((size << 9))
> +size=$(_zone_capacity $start_data_bg_phy)
>  
>  reclaim_threshold=75
>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> -- 
> 2.37.3
> 

