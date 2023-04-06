Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994976DA5F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 00:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjDFWpM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 6 Apr 2023 18:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDFWpL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 18:45:11 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEB93F7
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 15:45:10 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-93db98f7b33so124872166b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821108; x=1683413108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQsm/Yc2F8zxsNO+iTkFHv84YuzAVpviyaoHD9v43og=;
        b=lke9Z/gvr+HLcFNx45fm4J1QsGETH7Ei2Lnk45vsAd3i++7WEmT1qNVGGFknWuicXq
         rzJYLvwZKclZrPoJ7LMPn/1AIE950kM30IiJIUuCoP66MwsUULV8MofPa9LM1Ks+VmAe
         0EW21coCB25N7uS+Ko2CPN0cfD/0iKhiW1eKbhc2EjnlyjaNgIAeWgJ8LO005ov6DDX3
         ERrLgD93+E1IslCQLH4J6zymt8q/NQM0Y+j6koV0FEiUE7CM1B6P46I/iHCsjL3zB7b/
         C6qmiiEC0eeNrOUFaNA55dYS1CyAkx5gAK9ZlyyWK5QlSJ3GRxkw7/BqBSVxdV9Syvw7
         VcsQ==
X-Gm-Message-State: AAQBX9dZaIG/FFN8cbD+PHEtY9vKAIk8fVAd4GGOqtlvcEG9cdbUQPGt
        uF5qVWXr1XqmIzUqUbKhD3EIYGC6fuYBsQ==
X-Google-Smtp-Source: AKy350YJQpjV4cSkjjWGPqKkaNfLh7k5YfqkoKIg7GQXvTdIFUVRRAyBQVD/ASqXy0s9aampsNJrTQ==
X-Received: by 2002:aa7:d153:0:b0:502:32ba:37a9 with SMTP id r19-20020aa7d153000000b0050232ba37a9mr1153508edo.0.1680821108403;
        Thu, 06 Apr 2023 15:45:08 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id m20-20020a509994000000b0050470aa444fsm813932edb.51.2023.04.06.15.45.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:45:08 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-4fa3c1a7a5aso1448425a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:45:08 -0700 (PDT)
X-Received: by 2002:a50:d6da:0:b0:502:148d:9e1e with SMTP id
 l26-20020a50d6da000000b00502148d9e1emr538811edj.3.1680821108033; Thu, 06 Apr
 2023 15:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680723651.git.boris@bur.io> <73afd4f8e96351ffe1ba0d50d4fca75873ae3c54.1680723651.git.boris@bur.io>
In-Reply-To: <73afd4f8e96351ffe1ba0d50d4fca75873ae3c54.1680723651.git.boris@bur.io>
From:   Neal Gompa <neal@gompa.dev>
Date:   Thu, 6 Apr 2023 18:44:31 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-+i-SQKfd0QTZXScDFWAt=ieDCgwmN0eOYy-pUL4i_-g@mail.gmail.com>
Message-ID: <CAEg-Je-+i-SQKfd0QTZXScDFWAt=ieDCgwmN0eOYy-pUL4i_-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: set default discard iops_limit to 1000
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 5, 2023 at 3:49 PM Boris Burkov <boris@bur.io> wrote:
>
> Previously, the default was a relatively conservative 10. This results
> in a 100ms delay, so with ~300 discards in a commit, it takes the full
> 30s till the next commit to finish the discards. On a workstation, this
> results in the disk never going idle, wasting power/battery, etc.
>
> Set the default to 1000, which results in using the smallest possible
> delay, currently, which is 1ms. This has shown to not pathologically
> keep the disk busy by the original reporter.
>
> Link: https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/discard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 317aeff6c1da..0bc526f5fcd9 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -60,7 +60,7 @@
>  #define BTRFS_DISCARD_TARGET_MSEC      (6 * 60 * 60UL * MSEC_PER_SEC)
>  #define BTRFS_DISCARD_MIN_DELAY_MSEC   (1UL)
>  #define BTRFS_DISCARD_MAX_DELAY_MSEC   (1000UL)
> -#define BTRFS_DISCARD_MAX_IOPS         (10U)
> +#define BTRFS_DISCARD_MAX_IOPS         (1000U)
>
>  /* Monotonically decreasing minimum length filters after index 0 */
>  static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {
> --
> 2.40.0
>

Seems reasonable.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
