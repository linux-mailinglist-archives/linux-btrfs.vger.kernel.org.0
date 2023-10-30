Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C377DBDF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjJ3QdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJ3QdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 12:33:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53BA6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 09:33:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FD6C433C9;
        Mon, 30 Oct 2023 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698683592;
        bh=glvmiLeMqOTnT6CI7YIAA/s4YewtcBA12YF0DuV4b/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PGQ+QnOcexVvnx3nSVnrKPD8lTc6w6t4m9f8ee47ZilTHwcgIe0wL5ZJTMF5HBFtB
         ieoYhCanUMWqB5zpoMG4zfE6sgkcH9ImVn7lgMkloI3aupjitjGwbXZvIaMRPixv3Y
         hp3wgLEYbjrfBPyzT2d1FWVKCw44pq3EETQzhr+FJVuYj+5LAT+1kNWipBaWacnEMI
         HYD/bGb32K8Dwwb8A64u9GfmGgQxAMUKpvYkguUi7WTiUMXBPVzMj9CLAS4wfWzqTf
         clk0SZBh7Qv8rvYXZj/wZoMHPgJbcUP6D6EFPF45geCGjt4yfaP5Ub3qBUeRZRy+cE
         4g7UdsEbWkB9Q==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9c603e235d1so756400166b.3;
        Mon, 30 Oct 2023 09:33:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQg29bvgPMVB6oSJTWs2Lgwm3hZjxuM31RWc+L5Yx7e32KvSfH
        LIcpzAUcGFeYODXN36nC8VTCq3DNQZwkk6/gtg8=
X-Google-Smtp-Source: AGHT+IGFhJzU1PThAabNOY11PDeBwewV1qdxiND/RX9XVg8PvM5VwWCNoXnFrliiCFmcNBWRnZ4TJ7qYorHP8mwRKyE=
X-Received: by 2002:a17:906:4fd0:b0:9be:ef46:6b9d with SMTP id
 i16-20020a1709064fd000b009beef466b9dmr10079843ejw.29.1698683590482; Mon, 30
 Oct 2023 09:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <5c22b975907174835f5a42e4d53b482b266b9056.1698674332.git.anand.jain@oracle.com>
In-Reply-To: <5c22b975907174835f5a42e4d53b482b266b9056.1698674332.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 16:32:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4w_bDWnMta6CQabDtSWaNA3Zfab0MavMsEwLqWd0weDA@mail.gmail.com>
Message-ID: <CAL3q7H4w_bDWnMta6CQabDtSWaNA3Zfab0MavMsEwLqWd0weDA@mail.gmail.com>
Subject: Re: [PATCH 6/6 v3] btrfs/219: add to the auto group
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 2:15=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Add this test case back to the auto group which reverts the
> commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") sin=
ce
> the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
> btrfs_close_devices for a single device filesystem") has already been
> integrated.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>
> v3: A split from the patch 5/6.
>
>  tests/btrfs/219 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index 3c414dd9c2e0..ebebb75f4b1d 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -12,7 +12,7 @@
>  #
>
>  . ./common/preamble
> -_begin_fstest quick volume
> +_begin_fstest auto quick volume
>
>  # Override the default cleanup function.
>  _cleanup()
> --
> 2.39.3
>
