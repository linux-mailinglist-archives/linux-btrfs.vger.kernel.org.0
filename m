Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5A6DA5F7
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjDFWsB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 6 Apr 2023 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjDFWsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 18:48:00 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9461BDC
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 15:47:59 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-4fa3c484814so1631745a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821278; x=1683413278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUkmTDnePXSmXghqOElgkH/HNwaXSNqo6NRKT0VUM4k=;
        b=48igHUvWMKvZDqd/4fGP6Xw4hUlgZgDIDAnT1c3ngJW4CrbE82SSMc2ZaYu8HIouKs
         vn7fh+l1Ku2Ra0fPpFhcVOwacP67IAY867oXDia9ka6gri+NDj5CPt22Ysr255Hbnbbv
         h3NlhxbGhKTczRyDqfrsqfygnPnGh2cP3gvdC8jHEDIs8wGOdFJoeFLWmkNHeB7yrIUk
         YWLKBbFiWSy5HI21GQwqfjyw9jmU9bvzpxuFj+8sGVD/Fkm95Mm1WHgL4fZal1rNronf
         JdMeFerOLZJAXObdh45MAk/fqSA6B1StYOtQMaP164RsMOab4nMKwjEopsE9Zio1OdPF
         BS4w==
X-Gm-Message-State: AAQBX9ddHJWtvSiBY3Fld9NSbzwCTb6is2Jz6GkktfKS9MdJSEhD4S4E
        360hyWLAltCeRqNcKLp8ntciIBVLkv07zg==
X-Google-Smtp-Source: AKy350ZSupBLenuTw8IBpp91URlY2dLlFzrn+P01/gbCcqadjb91P3WnZaL+Dd+aIVp5XnrddKAHEA==
X-Received: by 2002:a05:6402:885:b0:4fa:b05e:ced5 with SMTP id e5-20020a056402088500b004fab05eced5mr1006236edy.36.1680821277594;
        Thu, 06 Apr 2023 15:47:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004c06f786602sm1241834edd.85.2023.04.06.15.47.57
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:47:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id n21so4824504ejz.4
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:47:57 -0700 (PDT)
X-Received: by 2002:a17:907:7ea2:b0:949:37e:f6cc with SMTP id
 qb34-20020a1709077ea200b00949037ef6ccmr207583ejc.9.1680821277271; Thu, 06 Apr
 2023 15:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680723651.git.boris@bur.io> <ac03a3ccafe6c5a1c5cf1883e9b88dddfb34fcfe.1680723651.git.boris@bur.io>
In-Reply-To: <ac03a3ccafe6c5a1c5cf1883e9b88dddfb34fcfe.1680723651.git.boris@bur.io>
From:   Neal Gompa <neal@gompa.dev>
Date:   Thu, 6 Apr 2023 18:47:21 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9JF+jcO8PGJZDn5Lvq-_YrnRKtQmFMZF8W8G19B6OSyw@mail.gmail.com>
Message-ID: <CAEg-Je9JF+jcO8PGJZDn5Lvq-_YrnRKtQmFMZF8W8G19B6OSyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: reinterpret async discard iops_limit=0 as
 no delay
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 5, 2023 at 4:00 PM Boris Burkov <boris@bur.io> wrote:
>
> Currently, a limit of 0 results in a hardcoded metering over 6 hours.
> Since the default is a set limit, I suspect no one truly depends on this
> rather arbitrary setting. Repurpose it for an arguably more useful
> "unlimited" mode, where the delay is 0.
>
> Note that if block groups are too new, or go fully empty, there is still
> a delay associated with those conditions. Those delays implement
> heuristics for not trimming a region we are relatively likely to fully
> overwrite soon.
>

For my own clarity, this means that there's a basic heuristic of not
activating right away all the time? If so, that seems sound.

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/discard.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 0bc526f5fcd9..c48abc817ed2 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -56,8 +56,6 @@
>  #define BTRFS_DISCARD_DELAY            (120ULL * NSEC_PER_SEC)
>  #define BTRFS_DISCARD_UNUSED_DELAY     (10ULL * NSEC_PER_SEC)
>
> -/* Target completion latency of discarding all discardable extents */
> -#define BTRFS_DISCARD_TARGET_MSEC      (6 * 60 * 60UL * MSEC_PER_SEC)
>  #define BTRFS_DISCARD_MIN_DELAY_MSEC   (1UL)
>  #define BTRFS_DISCARD_MAX_DELAY_MSEC   (1000UL)
>  #define BTRFS_DISCARD_MAX_IOPS         (1000U)
> @@ -577,6 +575,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>         s32 discardable_extents;
>         s64 discardable_bytes;
>         u32 iops_limit;
> +       unsigned long min_delay = BTRFS_DISCARD_MIN_DELAY_MSEC;
>         unsigned long delay;
>
>         discardable_extents = atomic_read(&discard_ctl->discardable_extents);
> @@ -607,13 +606,16 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>         }
>
>         iops_limit = READ_ONCE(discard_ctl->iops_limit);
> -       if (iops_limit)
> +
> +       if (iops_limit) {
>                 delay = MSEC_PER_SEC / iops_limit;
> -       else
> -               delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> +       } else {
> +               /* unset iops_limit means go as fast as possible, so allow a delay of 0 */
> +               delay = 0;
> +               min_delay = 0;
> +       }
>
> -       delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
> -                     BTRFS_DISCARD_MAX_DELAY_MSEC);
> +       delay = clamp(delay, min_delay, BTRFS_DISCARD_MAX_DELAY_MSEC);
>         discard_ctl->delay_ms = delay;
>
>         spin_unlock(&discard_ctl->lock);
> --
> 2.40.0
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
