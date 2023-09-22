Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1377AACBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjIVIfc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 04:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVIfc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 04:35:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8583;
        Fri, 22 Sep 2023 01:35:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48C5C433C8;
        Fri, 22 Sep 2023 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695371725;
        bh=yA1EP1f7a790yrhL8e6OjpEsAGP/5wtDGP/+UI6xmVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D6bQeNWeMydtm4ey/v7yY1g2SJN1oG1Os57nreySWZV8yv+61FAy7hGdcrCkgA+P4
         uVBVV2kOI1gJ+hXUTSmPxdOuD1k3Kc8tYVOwyVIy14gJ8sZNmzV8zpVEH+qdv/ch7N
         Yv504Hk3o4KOXE+lLKj4dl5P838P4pn2Vi6VaPEUONlGxSbeW5QFER/Odq7JAhuOc1
         v7TZ+ATj5Xv/yVsPv4eI4+YqqovQKpnNm8zZ00UnU6Rh920eQTvCXGcdPwXy4hQkMP
         yTysEuV+NZtao5oJw9Z1te6TtJ7AjNfqTaWW1KgzTpk0BS5MHkL6M1TdoI4yltsdXw
         moE7rq+W1frrw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1dc6198196aso1043669fac.0;
        Fri, 22 Sep 2023 01:35:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoEd01n5Z0blMZ63AOqBq1/D+SowyzTb6n2a9b6+jmdyDA3Y11
        H+z2S1qHwhdDw4ceWoOMXZ9GUP7U+nK8JyMzHdg=
X-Google-Smtp-Source: AGHT+IGJdlkVceh36Y6rKSzedFfiPm1XaCfxQie2IkIoOQ9IcU0nVAMjuqmzZt5P4sowVEmajbNVw4kw03SbmVHDSaQ=
X-Received: by 2002:a05:6870:b49f:b0:1bb:6792:4787 with SMTP id
 y31-20020a056870b49f00b001bb67924787mr8715175oap.40.1695371725233; Fri, 22
 Sep 2023 01:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230922000249.2345701-1-naohiro.aota@wdc.com>
In-Reply-To: <20230922000249.2345701-1-naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 22 Sep 2023 09:34:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5nbsLTPA9J31aRFz2nF36=EwE9TdNqh8jKd1XB_4CUyQ@mail.gmail.com>
Message-ID: <CAL3q7H5nbsLTPA9J31aRFz2nF36=EwE9TdNqh8jKd1XB_4CUyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/259: fix output's wrong word
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 1:40=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.com>=
 wrote:
>
> It prints "File extent layout before defrag" for the both outputs, but th=
e
> latter one should be "after defrag".
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/259 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index cbbea9f527f5..358a455068a1 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -40,7 +40,7 @@ sync
>
>  new_csum=3D$(_md5_checksum $SCRATCH_MNT/foobar)
>
> -echo "=3D=3D=3D File extent layout before defrag =3D=3D=3D" >> $seqres.f=
ull
> +echo "=3D=3D=3D File extent layout after defrag =3D=3D=3D" >> $seqres.fu=
ll
>  $XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
>  $XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" > $tmp.after
>
> --
> 2.42.0
>
