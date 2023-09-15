Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3A7A1A3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 11:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjIOJSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjIOJSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 05:18:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448CB10C7;
        Fri, 15 Sep 2023 02:18:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF78C433C8;
        Fri, 15 Sep 2023 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694769510;
        bh=1j1fzWAcRmwx5lPxJN7RH4Gq7nrVDaAbA5pBEpoL7qE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GdVDnULgka9CfTmy7aejfMkdt5HsDvvrQjtJ3kiLKXemS9amw8iusbVFMKC4Q4Old
         icj8Fo0w0h27dS7cTwck6guXBzKSxx5OGoZ+KpkKKkfLpsn6dq0BWLXo3Re5wxz2IV
         Fkc2dfmgDapB8JOlJfyu9cvaLwp7jHtE99ZTrHGLXVoTT275nUL+HUdgXDl2e1hZYZ
         XEKMddpmACBoU12dqmeVeyUJrgA8cZiDo4leS08xYvdQSBIehJWxFSOC+qTcs8oCTt
         etKpiGGz4T3yXg9XWcs9RMmVw/KlHdew3GA7EDGzTYn1yruSXMboPbv9SNs5iEFP9h
         Y0NVF2WZx9bUg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1d66baacc8cso105339fac.1;
        Fri, 15 Sep 2023 02:18:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzvba28AwrzY57DJyemwB2O+vEJN4agALCAXW6H23ZKBwAPIUSE
        P14BzrHd9M0N6PGvfk47qghesyB7CZJ/OxQfYjY=
X-Google-Smtp-Source: AGHT+IEcJJl8SYxORpBltTU5xYEikH3KO/T9GLNYOexVGgCfB5WljyYh8/adydakH8opziIVggl+rl5Tdlx5SBbzgt4=
X-Received: by 2002:a05:6870:c155:b0:1bb:c204:fde3 with SMTP id
 g21-20020a056870c15500b001bbc204fde3mr739964oad.1.1694769510182; Fri, 15 Sep
 2023 02:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694762532.git.naohiro.aota@wdc.com> <d975ad16c184649e89c57dedcb85064cb385ca47.1694762532.git.naohiro.aota@wdc.com>
In-Reply-To: <d975ad16c184649e89c57dedcb85064cb385ca47.1694762532.git.naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 15 Sep 2023 10:17:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7HbiMGMO7=iYkAzdP+OTYyFmaHtUJS=nwhKsnOE-tZig@mail.gmail.com>
Message-ID: <CAL3q7H7HbiMGMO7=iYkAzdP+OTYyFmaHtUJS=nwhKsnOE-tZig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs/076: use _fixed_by_kernel_commit to tell the
 fixing kernel commit
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
> The fix commit is written in the comment without a commit hash. Use
> _fixed_by_kernel_commit command to describe it.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Looks good,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  tests/btrfs/076 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/btrfs/076 b/tests/btrfs/076
> index a5cc3eb96b2f..dbb67bd1c241 100755
> --- a/tests/btrfs/076
> +++ b/tests/btrfs/076
> @@ -5,10 +5,8 @@
>  # FS QA Test No. btrfs/076
>  #
>  # Regression test for btrfs incorrect inode ratio detection.
> -# This was fixed in the following linux kernel patch:
> -#
> -#     Btrfs: fix incorrect compression ratio detection
>  #
> +
>  . ./common/preamble
>  _begin_fstest auto quick compress
>
> @@ -27,6 +25,8 @@ _cleanup()
>  _supported_fs btrfs
>  _require_test
>  _require_scratch
> +_fixed_by_kernel_commit 4bcbb3325513 \
> +       "Btrfs: fix incorrect compression ratio detection"
>
>  # An extent size can be up to BTRFS_MAX_UNCOMPRESSED
>  max_extent_size=3D$(( 128 << 10 ))
> --
> 2.42.0
>
