Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF277A1A36
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjIOJRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjIOJRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 05:17:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE67E69;
        Fri, 15 Sep 2023 02:17:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B950AC433C8;
        Fri, 15 Sep 2023 09:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694769428;
        bh=DtvxGVzOPGFupwW79FGzEZmBR9jmuAqd6iOjVSaRrXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6TzZpdbfyrBjG592CJXvJpjzgu5VTrINoXLNhe21tvdryUeh8TREksXBYHoYkXF6
         mrBdQfEn+0RNzgu8uQywHVNo72+nTldc6L3BRhJj41NnXhwxPIrrMdZgj1zo/BpxVt
         9i1rU679LnuTI/06QixwWh9AGSuo2Say+KMI64ZONmihnR5FPhIGQ+Qo/sj3f3P/op
         I21+8edWT8uhVp4b4ZnIzDjg3BSOlZAIa1i7LMSW6bl5WZ9mhKD4c5iMIG/g2peoCg
         o2lNjIephRkkhTCeFcpKjhmQ2cEHKaDF1031UBc5+fS1TBru9cWzh0GBOOY+pDkK1C
         Su65f1FGSPJyw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5717f7b932aso1137335eaf.0;
        Fri, 15 Sep 2023 02:17:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw7Ucbi5zeCib3fPj9+2mGMK3H+QDvI6zTXA+GvUHO+4Gz+7sFh
        EKELknOQ0IQLv77vUGJ/k3ayZbjJtAsFZqxIAMs=
X-Google-Smtp-Source: AGHT+IECHr68NtXKp9qlOEcU+0zgPrUqm0+5QEewhk6iVURRA3A0vRkz0GmDpvAqklUWvMTXbW2t1gEPXsy4p1NZo9c=
X-Received: by 2002:a05:6870:3906:b0:1be:fd4e:e36c with SMTP id
 b6-20020a056870390600b001befd4ee36cmr1360405oap.2.1694769428024; Fri, 15 Sep
 2023 02:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694762532.git.naohiro.aota@wdc.com> <f03093d83baa5bcd4229a0dc9a473add534ee016.1694762532.git.naohiro.aota@wdc.com>
In-Reply-To: <f03093d83baa5bcd4229a0dc9a473add534ee016.1694762532.git.naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 15 Sep 2023 10:16:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5m-kGMT7=wAmfDm-ZJ3bpdmN0=GhRkinMciRq8GfF-QQ@mail.gmail.com>
Message-ID: <CAL3q7H5m-kGMT7=wAmfDm-ZJ3bpdmN0=GhRkinMciRq8GfF-QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs/076: support smaller extent size limit
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 8:28=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.com>=
 wrote:
>
> Running btrfs/076 on a zoned null_blk device will fail with the following=
 error.
>
>   - output mismatch (see /host/results/btrfs/076.out.bad)
>       --- tests/btrfs/076.out     2021-02-05 01:44:20.000000000 +0000
>       +++ /host/results/btrfs/076.out.bad 2023-09-15 01:49:36.000000000 +=
0000
>       @@ -1,3 +1,3 @@
>        QA output created by 076
>       -80
>       -80
>       +83
>       +83
>       ...
>
> This is because the default value of zone_append_max_bytes is 127.5 KB
> which is smaller than BTRFS_MAX_UNCOMPRESSED (128K). So, the extent size =
is
> limited to 126976 (=3D ROUND_DOWN(127.5K, 4096)), which makes the number =
of
> extents larger, and fails the test.
>
> Instead of hard-coding the number of extents, we can calculate it using t=
he
> max extent size of an extent. It is limited by either
> BTRFS_MAX_UNCOMPRESSED or zone_append_max_bytes.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Looks good,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Just two minor comments below.

> ---
>  tests/btrfs/076     | 23 +++++++++++++++++++++--
>  tests/btrfs/076.out |  3 +--
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tests/btrfs/076 b/tests/btrfs/076
> index 89e9672d09e2..a5cc3eb96b2f 100755
> --- a/tests/btrfs/076
> +++ b/tests/btrfs/076
> @@ -28,13 +28,28 @@ _supported_fs btrfs
>  _require_test
>  _require_scratch
>
> +# An extent size can be up to BTRFS_MAX_UNCOMPRESSED
> +max_extent_size=3D$(( 128 << 10 ))

For consistency with every other test and common files, using 128 *
1024 would be perhaps better. I certainly find it easier to read, but
that's a personal preference only.

> +if _scratch_btrfs_is_zoned; then
> +       zone_append_max=3D$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/qu=
eue/zone_append_max_bytes")
> +       if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_=
size ]]; then
> +               # Round down to PAGE_SIZE
> +               max_extent_size=3D$(( $zone_append_max / 4096 * 4096 ))
> +       fi
> +fi
> +file_size=3D$(( 10 << 20 ))

And this one it's even less immediate to understand, having 1 * 1024 *
1024 would make it much more easier to read.

Thanks.

> +expect=3D$(( (file_size + max_extent_size - 1) / max_extent_size ))
> +
>  _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount "-o compress=3Dlzo"
>
>  $XFS_IO_PROG -f -c "pwrite 0 10M" -c "fsync" \
>         $SCRATCH_MNT/data >> $seqres.full 2>&1
>
> -_extent_count $SCRATCH_MNT/data
> +res=3D$(_extent_count $SCRATCH_MNT/data)
> +if [[ $res -ne $expect ]]; then
> +       _fail "Expected $expect extents, got $res"
> +fi
>
>  $XFS_IO_PROG -f -c "pwrite 0 $((4096*33))" -c "fsync" \
>         $SCRATCH_MNT/data >> $seqres.full 2>&1
> @@ -42,7 +57,11 @@ $XFS_IO_PROG -f -c "pwrite 0 $((4096*33))" -c "fsync" =
\
>  $XFS_IO_PROG -f -c "pwrite 0 10M" -c "fsync" \
>         $SCRATCH_MNT/data >> $seqres.full 2>&1
>
> -_extent_count $SCRATCH_MNT/data
> +res=3D$(_extent_count $SCRATCH_MNT/data)
> +if [[ $res -ne $expect ]]; then
> +       _fail "Expected $expect extents, got $res"
> +fi
>
> +echo "Silence is golden"
>  status=3D0
>  exit
> diff --git a/tests/btrfs/076.out b/tests/btrfs/076.out
> index b99f7eb10a16..248e095d91af 100644
> --- a/tests/btrfs/076.out
> +++ b/tests/btrfs/076.out
> @@ -1,3 +1,2 @@
>  QA output created by 076
> -80
> -80
> +Silence is golden
> --
> 2.42.0
>
