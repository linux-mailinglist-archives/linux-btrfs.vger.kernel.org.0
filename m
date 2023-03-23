Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7116C6709
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjCWLpz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 23 Mar 2023 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjCWLpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 07:45:53 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C48D30EAF
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 04:45:49 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id r11so85167820edd.5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 04:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679571947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTCU2zjs8gR2oT4CSZzSWRahp9gQHiSGSnhBnme8pJM=;
        b=yjpOW8X3KL1FQVaYOYEEUuaruKq9yva/kS59s/5ktuDy7EvovHLVSokLD+Bk1OdA3R
         HM+z+bYOk7yOcbCT0vOvU/wmmDOgvthxtBb8YtojSC6zzdGADoCimj9doVG5rXJQ4KKk
         UygjiwfTjQrUxQ/GXB7E9bfeywhuXrnnoXg/OAOjbleWmxi+TwCgaa8tpCQvoWTd9vIS
         SprE1uNeEkubDGOzeLcv7tQsAwRncTFQ0gbQh9YURk23frBEXVbIjNgbNc86kvgEsQZP
         FAGLcYTNLHWhgaZrAaT+HSKMaNfTyCEK9Xv39XYNUKY5UQIZVX5nHbZrBoywh83kh2sm
         9SGQ==
X-Gm-Message-State: AO0yUKX7F4D6sTdPHib6mWFeiS4zY/ClCbpEoL2p/Ma8BpHIN4GUxkq+
        Suijhlg+TkstDBZoikcem+MODcx+sXCGNA==
X-Google-Smtp-Source: AK7set8XcT+obqL6Cg+k3PPxOQ8yC0rsRvsYbrvUZy2jcbAkvVm+vq6X6QIDs5JCu1Sg17z/JsB07w==
X-Received: by 2002:a17:906:ac6:b0:907:9bda:93b9 with SMTP id z6-20020a1709060ac600b009079bda93b9mr10521371ejf.17.1679571947052;
        Thu, 23 Mar 2023 04:45:47 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id cd2-20020a170906b34200b0092c8da1e5ecsm8552487ejb.21.2023.03.23.04.45.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 04:45:47 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id ew6so22152740edb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 04:45:46 -0700 (PDT)
X-Received: by 2002:a17:906:fe0c:b0:93c:dd93:8bf6 with SMTP id
 wy12-20020a170906fe0c00b0093cdd938bf6mr962889ejb.9.1679571946717; Thu, 23 Mar
 2023 04:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <b186e39f1c4bd938270918ff0411f9c8ba6e8934.1679571105.git.anand.jain@oracle.com>
In-Reply-To: <b186e39f1c4bd938270918ff0411f9c8ba6e8934.1679571105.git.anand.jain@oracle.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Thu, 23 Mar 2023 07:45:10 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9KppYWOncS_w1y+5Rq+pph9jXmp+DDfk44i7if5+UAbA@mail.gmail.com>
Message-ID: <CAEg-Je9KppYWOncS_w1y+5Rq+pph9jXmp+DDfk44i7if5+UAbA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: move comment to the related code
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 7:40 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Commit 12659251ca5d  ("btrfs: implement log-structured superblock for ZONED
> mode") moved only the code but not its related comment. Move to the comment
> code where it makes sense.
>
> (no functional change).
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cc1871767c8c..e04b10a73d3b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1360,13 +1360,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>
>         lockdep_assert_held(&uuid_mutex);
>
> -       /*
> -        * we would like to check all the supers, but that would make
> -        * a btrfs mount succeed after a mkfs from a different FS.
> -        * So, we need to add a special mount option to scan for
> -        * later supers, using BTRFS_SUPER_MIRROR_MAX instead
> -        */
> -
>         /*
>          * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
>          * initiate the device scan which may race with the user's mount
> @@ -1381,6 +1374,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>         if (IS_ERR(bdev))
>                 return ERR_CAST(bdev);
>
> +       /*
> +        * We would like to check all the supers, but that would make
> +        * a btrfs mount succeed after a mkfs from a different FS.
> +        * So, we need to add a special mount option to scan for
> +        * later supers, using BTRFS_SUPER_MIRROR_MAX instead
> +        */
>         bytenr_orig = btrfs_sb_offset(0);
>         ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
>         if (ret) {
> --
> 2.38.1
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
