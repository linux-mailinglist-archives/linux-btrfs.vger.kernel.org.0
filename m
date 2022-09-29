Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977815EED21
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 07:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiI2FPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 01:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiI2FPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 01:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84A50716
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 22:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664428514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GTuWhbffLEeU8hqaqNOROd9qdekK/JDI25YrwgIquQ=;
        b=EBA468mbN9ZwLhFGtd5pQLdIiGS72kQgG+KY85puLsUjnqHVQn0hz0807+NtxAKxHY9FjB
        3PKBzSbsgMKG9Ao0C8odlWE4T7+SHPvvG0lwydnxPkIVLzmfZab1ND3F1cfVSEZwSjfouW
        gTJHBQ2WdZbuiPp9aMuZjchOBICZe+E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-nKpZRPQgMI6Cf48sMVdL8g-1; Thu, 29 Sep 2022 01:15:13 -0400
X-MC-Unique: nKpZRPQgMI6Cf48sMVdL8g-1
Received: by mail-pl1-f200.google.com with SMTP id o1-20020a170902d4c100b00177f59a9889so284934plg.13
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 22:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7GTuWhbffLEeU8hqaqNOROd9qdekK/JDI25YrwgIquQ=;
        b=ilO6VSNkXsavQs18sSELqYv7p4zEgabnxQySKLV0pEfPHBN/4DkvFV1Ep0aZaVxKVt
         IRH5W6A7U7vs8JLLnTZhyjOjS2ukHKNZparGkbXhPGx4wLlmcx/mkpdyixN/M4Yz10gl
         q/MyRayzskp0VzkBLkHEmZUZGoLy7dvDa40lZaK3pagHA5zuOQr46lcb0J7cOJ6zO9Ia
         eqi781kgyXFbnufiK1hmmTI1CKADMYMen1Y3jtMeJ+rzMOaUyh6yyzfOnrIyTnOB+f7Y
         zVBNvbbK6NmdrSslWGpfr9NRXXiKEuLuuiQN5leLbOFXkxnl8ieopmCUyqxCjI/RPSNY
         nOAg==
X-Gm-Message-State: ACrzQf1sLeQdwqEYpFsddTKSI9zfn62s5+cQKaSvBLoL4sMwjQOSlcNj
        iLOg9++bOE//4YsnYYELBhE4tWtrx+f5A8swNJEs9D4uIla3h5qK2GvahvAYEHGoOeF99ijDi/g
        8QnM1J9ql5WyuBb6VYpvrgUo=
X-Received: by 2002:a17:90a:1617:b0:200:9da5:d0ed with SMTP id n23-20020a17090a161700b002009da5d0edmr1726919pja.90.1664428511890;
        Wed, 28 Sep 2022 22:15:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5WymMJm3RJ490QTBz0OGuToqqM9rKqU7ZRaOk4r7ofg6uhYEgWsXRz4PMJwbsSgxbu1fD9OQ==
X-Received: by 2002:a17:90a:1617:b0:200:9da5:d0ed with SMTP id n23-20020a17090a161700b002009da5d0edmr1726883pja.90.1664428511523;
        Wed, 28 Sep 2022 22:15:11 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z67-20020a626546000000b00546d875a944sm5002769pfb.214.2022.09.28.22.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:15:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:15:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common: introduce zone_capacity() to return a
 zone capacity
Message-ID: <20220929051507.aonami57xnhnixan@zlang-mailbox>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <b148b071bb11828f4a4c6600331cc8464a1895f1.1664419525.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b148b071bb11828f4a4c6600331cc8464a1895f1.1664419525.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 01:19:24PM +0900, Naohiro Aota wrote:
> Introduce _zone_capacity() to return a zone capacity of the given address
> in the given device (optional). Move _filter_blkzone_report() for it, and
> rewrite btrfs/237 with it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/filter   | 13 -------------
>  common/zoned    | 28 ++++++++++++++++++++++++++++
>  tests/btrfs/237 |  8 ++------
>  3 files changed, 30 insertions(+), 19 deletions(-)
>  create mode 100644 common/zoned
> 
> diff --git a/common/filter b/common/filter
> index 28dea64662dc..ac5c93422567 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -651,18 +651,5 @@ _filter_bash()
>  	sed -e "s/^bash: line 1: /bash: /"
>  }
>  
> -#
> -# blkzone report added zone capacity to be printed from v2.37.
> -# This filter will add an extra column 'cap' with the same value of
> -# 'len'(zone size) for blkzone version < 2.37
> -#
> -# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> -# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
> -_filter_blkzone_report()
> -{
> -	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
> -	sed -e 's/len/cap/2'
> -}
> -
>  # make sure this script returns success
>  /bin/true
> diff --git a/common/zoned b/common/zoned
> new file mode 100644
> index 000000000000..d1bc60f784a1
> --- /dev/null
> +++ b/common/zoned
> @@ -0,0 +1,28 @@
> +#
> +# Common zoned block device specific functions
> +#
> +
> +#
> +# blkzone report added zone capacity to be printed from v2.37.
> +# This filter will add an extra column 'cap' with the same value of
> +# 'len'(zone size) for blkzone version < 2.37
> +#
> +# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> +# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
> +_filter_blkzone_report()
> +{
> +	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
> +	sed -e 's/len/cap/2'
> +}
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

I'm a little surprised this line doesn't report error :) Anyway, it should be
common/zoned as above. Others look good to me. With this fix, you can add:

Reviewed-by: Zorro Lang <zlang@redhat.com>

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

