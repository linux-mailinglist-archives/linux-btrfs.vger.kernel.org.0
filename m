Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06147AD66A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 12:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjIYKw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYKwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 06:52:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52824AB;
        Mon, 25 Sep 2023 03:52:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF88C433C9;
        Mon, 25 Sep 2023 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695639169;
        bh=5bnoinFF4G9IUrVjhzp58yzu+hr3u35MV4h7EV8om4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kCioLaPvFeAAlRkKAY+8Y/Xqker4XFd0j3aJnaORoWUbvJXQ0NgBMv2QONcaBA3VA
         q5oHVNL0TD0D+gINXVWleWlqHUfTrMK9O5dBBRpcA8mUotyOHREO47z1+LQisyrzyr
         rlWUBlhcS7P0uemINp5LwhzTrPcq9MCpAuJ5astc1y8GF+8kgw4e/VCjwtnFKWMemd
         dpX9dKK/wXo9o81D9TzIGoF34gDF1cK0V4D/gyHIn2m+uRwuFLzYHSV9QoczwyfXHm
         aFoLrEgrrJUs2w2SH5r+A353bE3XJ1keBUswYOamFa7sa3vj45kKK62TYZ2PCnSH6u
         9TCG+mINFp27g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so2393007fac.0;
        Mon, 25 Sep 2023 03:52:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy/UIEnyXfHr7TWthp4GJl1S3OoLNbzyB0k8pBCgJh+vdXGEJLF
        JpI1Y28OmUoCoKTWr8UtRtVswV5zlb1djubwXc8=
X-Google-Smtp-Source: AGHT+IFWgpWb1sUu5fqX6uq2PUoFqypSDrEyPsg2/1QulnsQQ5Fn0G/p0BuIyTtdKHU9ZWkKHoaqgsOGtAuSebCfPms=
X-Received: by 2002:a05:6871:72a:b0:1d6:5c40:11b6 with SMTP id
 f42-20020a056871072a00b001d65c4011b6mr9618599oap.14.1695639168244; Mon, 25
 Sep 2023 03:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230925055541.2848073-1-naohiro.aota@wdc.com>
In-Reply-To: <20230925055541.2848073-1-naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 25 Sep 2023 11:52:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7s1koL6fpJ+OuiSSo5JEDh2QZHMm5mbjK-enbGEUmeVg@mail.gmail.com>
Message-ID: <CAL3q7H7s1koL6fpJ+OuiSSo5JEDh2QZHMm5mbjK-enbGEUmeVg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/283: skip if we cannot write into one extent
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 25, 2023 at 6:55=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.com>=
 wrote:
>
> On the zoned mode, the extent size is limited also by
> queue/zone_append_max_bytes. This breaks the assumption that the file "fo=
o"
> has a single extent and corrupts the test output.
>
> It is difficult to support the case, so let's just skip the test in this
> case.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks reasonable, thanks.

> ---
>  tests/btrfs/283 | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> index c1f6007d5398..118df08b8958 100755
> --- a/tests/btrfs/283
> +++ b/tests/btrfs/283
> @@ -25,6 +25,14 @@ _require_fssum
>  _wants_kernel_commit c7499a64dcf6 \
>              "btrfs: send: optimize clone detection to increase extent sh=
aring"
>
> +extent_size=3D$(( 128 * 1024 ))
> +if _scratch_btrfs_is_zoned; then
> +       zone_append_max=3D$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/qu=
eue/zone_append_max_bytes")
> +       if [[ $zone_append_max -gt 0 && $zone_append_max -lt $extent_size=
 ]]; then
> +               _notrun "zone append max $zone_append_max is smaller than=
 wanted extent size $extent_size"
> +       fi
> +fi
> +
>  send_files_dir=3D$TEST_DIR/btrfs-test-$seq
>  send_stream=3D$send_files_dir/snap.stream
>  snap_fssum=3D$send_files_dir/snap.fssum
> --
> 2.42.0
>
