Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0C3BA0B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhGBMxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 08:53:18 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:36488 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhGBMxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 08:53:17 -0400
Received: by mail-qk1-f175.google.com with SMTP id c3so8226679qkc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 05:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EifV/LfZwY4P1MKXsR6R17aefJ52QOFWSQcmdGLH1Tc=;
        b=libLBBVfkFDvd8xNUXeUvG8HExwQrU4UoryWIWsbBS3wQCTWeyT65c6QjdNKJt2Zvx
         YtwBd/JlpR7W9KGAKPbHdKo97RV1Dp/B2xTJqc8fz9w+OVPh10Cb5l+GYpzRSmoXNeK5
         OFcSu+muU38PgybhAUTyFZ5y3suKMPvswdDEnRjZrx5cQ1RkSSOtitumz6v/U30Anp02
         QvqgGKQ+/ymMxzg9PgmdtndvNaLRW+MxFqk7Pdh2bxByEIzznpRBitW96HGBZrjHVy2e
         QZeqDMhrUct5KrEsPYaOLGTDkuxHOWNRd3LQlZyAPBBVyTtNNvUX4+ZSeeuJho7mrR/w
         Q0JQ==
X-Gm-Message-State: AOAM532nsm4cY8MhCSfMRC59p99BU628QgtxKWaqI2KKzRBmQsQXixyx
        mCNU2e48y2TV12re/pYWYXPK61SVJxQ=
X-Google-Smtp-Source: ABdhPJyz/uYg92F7NYgYv8v2ZoRxB5teBm6lvvuGAAYbn8nVSjy++EenPDtI+PYJSTHQbTN2gKaH0w==
X-Received: by 2002:a37:5c87:: with SMTP id q129mr5241838qkb.137.1625230244228;
        Fri, 02 Jul 2021 05:50:44 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c22sm1349579qka.95.2021.07.02.05.50.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 05:50:44 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id r135so16305080ybc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 05:50:43 -0700 (PDT)
X-Received: by 2002:a25:be8a:: with SMTP id i10mr6747986ybk.176.1625230243632;
 Fri, 02 Jul 2021 05:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
In-Reply-To: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
From:   Neal Gompa <ngompa@fedoraproject.org>
Date:   Fri, 2 Jul 2021 08:50:07 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9whNMO4r4dKi1vTWF14CFsrqusHzNFjqp6dn1nO2138w@mail.gmail.com>
Message-ID: <CAEg-Je9whNMO4r4dKi1vTWF14CFsrqusHzNFjqp6dn1nO2138w@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: zoned: revert "btrfs: zoned: fail mount if the
 device does not support zone append"
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 2, 2021 at 7:40 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support")
> is merged in master, the device-mapper code can fully emulate zone append.
> So there's no need for this check anymore.
>
> This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the device
> does not support zone append").
>
> Cc: Naohiro  Aota <naohiro.aota@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 297c0b1c0634..e4087a2364a2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -354,13 +354,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>         if (!IS_ALIGNED(nr_sectors, zone_sectors))
>                 zone_info->nr_zones++;
>
> -       if (bdev_is_zoned(bdev) && zone_info->max_zone_append_size == 0) {
> -               btrfs_err(fs_info, "zoned: device %pg does not support zone append",
> -                         bdev);
> -               ret = -EINVAL;
> -               goto out;
> -       }
> -
>         zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>         if (!zone_info->seq_zones) {
>                 ret = -ENOMEM;
> --
> 2.31.1
>

Looks good to me.

Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>

-- 
Neal Gompa (FAS: ngompa)
