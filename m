Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281BE75EAAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGXE43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGXE42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9DE40
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690174536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rlutq8Z7KDhlUXfrK5vwQPEoqf3nu5Bflb9MQCA4ltI=;
        b=SJjHOnK0bkMgbHqGXoEYpa4xJJSc0sJpbpGqlfQc2nAETpB9JohuMzOW4sbu8IElia/BXY
        b0Y9fCpSGST3sRCDJliCJWDZD8Fgk+cR56ovHO/ap/IqLigMj1PLMZzoP+1diHbqqE9Jax
        +09vS5e0xvCU8A3inSlmaZ0l1XDkAQE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-rlEQDT_zMjGTRV5V_tgWTw-1; Mon, 24 Jul 2023 00:55:34 -0400
X-MC-Unique: rlEQDT_zMjGTRV5V_tgWTw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34603502e5aso31646005ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690174534; x=1690779334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlutq8Z7KDhlUXfrK5vwQPEoqf3nu5Bflb9MQCA4ltI=;
        b=c4eI8IHqst1htkxupVlIZ8nCGfJ2VBVHPfdw5OSEKXMPCqxXp3ihnTONUa7Rmu44i8
         3OV1Q1t4tzKktGLIT1r/InR9ljaF+S44FqBse9gRHHmtqUg0Vrh9zqH+dYqNksdG/ps2
         J1dUyeadQKC/ngsDHD4dF/pDrZvYF0j1HimLBW5YXoeN1E7/+HFz8RONtTz5wuHk0SXq
         /pnm47vbJcc2RegIJK/JCoaYjL3XbkiXsIM9ce658bPX/maAI7ulVB0/Co4L0VlcrImQ
         tk8MwOZrb48NsVrQO3VAJxGPRL8m9+dqja7zTonLxxWy+vAqc5bfnTnbYAnPRMLvw+nT
         Gutg==
X-Gm-Message-State: ABy/qLbTzvwR3ulJw/5Mugc1yVh8ZK6voBPm4RvwmhyLqvyEMe0Zl1x0
        Fvuy+kAz6Lkqi+rEsUIeh9664u4gpGGsEmWzDkcCdzmFC3WM6GoDDxGIiqMd7Ur4PKuDyJvDOKj
        tY1ONnl88df8s3VBsEqZJQyI=
X-Received: by 2002:a05:6e02:1103:b0:348:d70e:b7f0 with SMTP id u3-20020a056e02110300b00348d70eb7f0mr756161ilk.32.1690174534179;
        Sun, 23 Jul 2023 21:55:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHMW9PBYZZnSySVxXp2kK0+VdMZQ7SLoFpSK9lxWDc7LixiJQpyR/jom3Qk3I3/vlLJWhaExw==
X-Received: by 2002:a05:6e02:1103:b0:348:d70e:b7f0 with SMTP id u3-20020a056e02110300b00348d70eb7f0mr756149ilk.32.1690174533947;
        Sun, 23 Jul 2023 21:55:33 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001aad714400asm7770244plb.229.2023.07.23.21.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 21:55:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:55:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Message-ID: <20230724045530.mhtb3fnbdodpvfjb@zlang-mailbox>
References: <20230724030423.92390-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724030423.92390-1-wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> The test case itself is utilizing RAID5/6, which is not yet supported on
> zoned device.
> 
> In the future we would use raid-stripe-tree (RST) feature, but for now
> just reject zoned devices completely.
> 
> And since we're here, also update the _fixed_by_kernel_commit lines, as
> the proper fix is already merged upstream.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Oh, good, you've sent this patch, ignore my reply to last patch.
Looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  tests/btrfs/294 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/294 b/tests/btrfs/294
> index 61ce7d97..d7d13646 100755
> --- a/tests/btrfs/294
> +++ b/tests/btrfs/294
> @@ -16,11 +16,15 @@ _begin_fstest auto raid volume
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +
> +# No zoned support for RAID56 yet.
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
>  _require_scratch_dev_pool 8
>  _fixed_by_kernel_commit a7299a18a179 \
>  	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> -	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> +_fixed_by_kernel_commit cb091225a538 \
> +	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
>  
>  _scratch_dev_pool_get 8
>  
> -- 
> 2.41.0
> 

