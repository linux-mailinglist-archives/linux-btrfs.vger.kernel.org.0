Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8774451FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 12:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhKDLMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhKDLMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 07:12:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DFBC06127A;
        Thu,  4 Nov 2021 04:09:42 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id s9so4957613qvk.12;
        Thu, 04 Nov 2021 04:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ENtW/JsXylZcchdewa5mhVWtajWWLyfgk4sgNraSWgA=;
        b=XPx62z+utkotxFVoHyHcyFvakHqgmETbrFhNqivSc02oLF4aRg7nTinlqkZ0+XTdxB
         Sv8OjFJQxJ7s6FX7hmVLoDjcTEtDRP3u9lrHtLoy6mCBO6zP0rZkh/hhhvFr2AjPUUn1
         /aIWc3rvZYFxMA34P5yi5g2KGnNmZpJ0+KhvDz65u6JI+4fwjL4zZG0z9IE+G7lXQDER
         p4ZEb9qxGruDCAdQyH1OpT8lXw+O6pcqMyMh9F2t2AT0HlhLpDWdgeflUmCdDNH11rmw
         bEcig0TFtxNamZeaYDuSS6RkR5O/k39ipAphammR5wrrYGaEy7UanXd3EMPtJ7VOktRH
         Ur4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ENtW/JsXylZcchdewa5mhVWtajWWLyfgk4sgNraSWgA=;
        b=OZm236065BuUcy5JfrmqEqXkWfxEVkBCloFCj0fSo6ehqtikmjPmOmZXX8LEy46Rxk
         9JTJAyvtgYkJ/ytHVGyLIHs72OLc41zs3h1UA1xfUKS6tLTm+hkJEwzMA8vnMvLQ6/8T
         BrzQOCCoOS7xbYdaeOGJ8npI5S0GOgNHLriPe4TQbXSyEihk731/TonFqcVwTvo02C8B
         a2Fq8RyXG3zkC4Ur3fV4PrKjiRj680s3BwiF1rhZStgWavGrQspyGf3uWWlTevtKaM5G
         qs2RxLvi2TOD9qryHK64socWpq8qHVouiwQLAYQ2tYxP91bdfupuVmw0jbpt6D/Xgqqb
         euxw==
X-Gm-Message-State: AOAM532lwG6zTCtDzeqCX1Q7zhlPvFqd74Rh6AVA/zLe8a8p25AY0dTc
        RaQCHZcDJu0NFIajKcqyEoxcbb7pAZdaN9ocnEI=
X-Google-Smtp-Source: ABdhPJwa8pPvXQHQSG9vTfe2vTdS1k2dOA+P0KB1+40LjC5qSK03sijbsf3toNyx1hDEKNIOXXgwcPCnwNej1FN56Yw=
X-Received: by 2002:a05:6214:5197:: with SMTP id kl23mr48642235qvb.46.1636024181605;
 Thu, 04 Nov 2021 04:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211104005553.14485-1-wqu@suse.com>
In-Reply-To: <20211104005553.14485-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 4 Nov 2021 11:09:05 +0000
Message-ID: <CAL3q7H4BT22oDwKC8SSLMtZdRXaw4zCNb2DgS=6vNrUskv7tJw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: make nospace_cache related test cases to
 work with latest v2 cache
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 4, 2021 at 12:56 AM Qu Wenruo <wqu@suse.com> wrote:
>
> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> v2 cache by default.
>
> However nospace_cache mount option will not work with v2 cache, as it
> will make v2 cache out of sync with on-disk used space.

will -> would

(having "will" was actually making me worry and check the code)

>
> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> to reject the mount.
>
> There are quite some test cases relying on nospace_cache to prevent v1
> cache to take up data space.
>
> For that case, we can append "clear_cache" mount option to it, so that
> btrfs knows we do not only want to prevent cache from being created, but
> also want to clear any existing v2 cache.
>
> By this, we can keep those existing tests to do the same behavior for
> both v1 and v2 cache.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Apart from that, it looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  tests/btrfs/102 | 2 +-
>  tests/btrfs/140 | 2 +-
>  tests/btrfs/141 | 2 +-
>  tests/btrfs/142 | 2 +-
>  tests/btrfs/143 | 2 +-
>  tests/btrfs/151 | 2 +-
>  tests/btrfs/157 | 2 +-
>  tests/btrfs/158 | 2 +-
>  tests/btrfs/170 | 2 +-
>  tests/btrfs/199 | 5 ++++-
>  tests/btrfs/215 | 2 +-
>  11 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/tests/btrfs/102 b/tests/btrfs/102
> index e5a1b068..39c3ba37 100755
> --- a/tests/btrfs/102
> +++ b/tests/btrfs/102
> @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
>  # Mount our filesystem without space caches enabled so that we do not ge=
t any
>  # space used from the initial data block group that mkfs creates (space =
caches
>  # used space from data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount "-o nospace_cache,clear_cache"
>
>  # Need an fs with at least 2Gb to make sure mkfs.btrfs does not create a=
n fs
>  # using mixed block groups (used both for data and metadata). We really =
need
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 5a5f828c..e7a36927 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -62,7 +62,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>
>  # -o nospace_cache makes sure data is written to the start position of t=
he data
>  # chunk
> -_scratch_mount -o nospace_cache
> +_scratch_mount -o nospace_cache,clear_cache
>
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
>         _filter_xfs_io_offset
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index cf0979e9..bf559953 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -61,7 +61,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>
>  # -o nospace_cache makes sure data is written to the start position of t=
he data
>  # chunk
> -_scratch_mount -o nospace_cache
> +_scratch_mount -o nospace_cache,clear_cache
>
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
>         _filter_xfs_io_offset
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index 1318be0f..b2cc34a3 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -39,7 +39,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>
>  # -o nospace_cache makes sure data is written to the start position of t=
he data
>  # chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +_scratch_mount -o nospace_cache,nodatasum,clear_cache
>
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
>         _filter_xfs_io_offset
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 6736dcad..2f673ae2 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -46,7 +46,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>
>  # -o nospace_cache makes sure data is written to the start position of t=
he data
>  # chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +_scratch_mount -o nospace_cache,nodatasum,clear_cache
>
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
>         _filter_xfs_io_offset
> diff --git a/tests/btrfs/151 b/tests/btrfs/151
> index 099e85cc..e8bdc33c 100755
> --- a/tests/btrfs/151
> +++ b/tests/btrfs/151
> @@ -32,7 +32,7 @@ _scratch_dev_pool_get 3
>  _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
>
>  # we need an empty data chunk, so nospace_cache is required.
> -_scratch_mount -onospace_cache
> +_scratch_mount -onospace_cache,clear_cache
>
>  # if data chunk is empty, 'btrfs device remove' can change raid1 to
>  # single.
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 0cfe3ce5..cd69cc16 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -66,7 +66,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>
>  # -o nospace_cache makes sure data is written to the start position of t=
he data
>  # chunk
> -_scratch_mount -o nospace_cache
> +_scratch_mount -o nospace_cache,clear_cache
>
>  # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index ad374eba..1bc73450 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -58,7 +58,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>
>  # -o nospace_cache makes sure data is written to the start position of t=
he data
>  # chunk
> -_scratch_mount -o nospace_cache
> +_scratch_mount -o nospace_cache,clear_cache
>
>  # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index 15382eb3..746170f4 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -29,7 +29,7 @@ _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
>
>  # Mount without space cache so that we can precisely fill all data space=
 and
>  # unallocated space later (space cache v1 uses data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount "-o nospace_cache,clear_cache"
>
>  # Create our test file and allocate 1826.25Mb of space for it.
>  # This will exhaust the existing data block group and all unallocated sp=
ace on
> diff --git a/tests/btrfs/199 b/tests/btrfs/199
> index 6aca62f4..2369d52f 100755
> --- a/tests/btrfs/199
> +++ b/tests/btrfs/199
> @@ -70,12 +70,15 @@ mkdir -p $loop_mnt
>  # - nospace_cache
>  #   Since v1 cache using DATA space, it can break data extent bytenr
>  #   continuousness.
> +# - clear_cache
> +#   v2 cache can't work with nospace_cache, so we workaround it by clear=
ing
> +#   all the space cache.
>  # - nodatasum
>  #   As there will be 1.5G data write, generating 1.5M csum.
>  #   Disabling datasum could reduce the margin caused by metadata to mini=
mal
>  # - discard
>  #   What we're testing
> -_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
> +_mount -o nospace_cache,clear_cache,nodatasum,discard $loop_dev $loop_mn=
t
>
>  # Craft the following extent layout:
>  #         |  BG1 |      BG2        |       BG3            |
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index fa622568..7f0986af 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
>  _scratch_mkfs > /dev/null
>  # disable freespace inode to ensure file is the first thing in the data
>  # blobk group
> -_scratch_mount -o nospace_cache
> +_scratch_mount -o nospace_cache,clear_cache
>
>  pagesize=3D$(get_page_size)
>  blocksize=3D$(_get_block_size $SCRATCH_MNT)
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
