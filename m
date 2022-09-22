Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E685E5F41
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiIVKD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiIVKD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 06:03:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603FABF2D;
        Thu, 22 Sep 2022 03:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1C15B80CB7;
        Thu, 22 Sep 2022 10:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AAEC433D6;
        Thu, 22 Sep 2022 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663841004;
        bh=/pv178E5WPtf7ydYYBkJekiF2SPeFpl3jLs7kYbKeXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N2lp1ReBpusCLwCUyyB6CNF6Jp4DEcRlpd0IFByr9Bz+xqv+/9YWsjfquvOwGkO8H
         sYAubUiizFL00nsMczy68qzMdVH5GRz1Ax3oPlRMOQiztaB+ViZ3YUnC9kh9+7MXR+
         qpBukK3tyu1rd03xacYsBhod2U21J9eGS7wo4lb5V5X2RqeEU6Ekx27FBSrBsWurHc
         T/OREsw3AM15wZjgDsUkU/NPtCXQqeVVUB/P/VZ7M6UFGQ8ecHTWe+I5RSgQcNkVrb
         JzT4WNltjj+32GW2/Dd3HuKs8vwPj6wpTQD1NxmBNJuIraZNwpI3tRWigDWBDFSmiP
         lORI0Dzh4lnNg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1225219ee46so13133998fac.2;
        Thu, 22 Sep 2022 03:03:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf21V9rGoiUKq4GKzZLedbxR4aWNkN8hEuP6zzA2DwCNLeIlZAB4
        khkL0tLsopL/WFBOcC4tR4EQkn2sd1xtrr49Kvg=
X-Google-Smtp-Source: AMsMyM6AigRWcva/7Xi0WE+6FbD7ALUjyZY6apokfg8MFPlJjmTqZWd1aDL2ldQ+h7o+CMbFncfSjdoOwWq0rTak3+c=
X-Received: by 2002:a05:6870:63a6:b0:12b:85ee:59ff with SMTP id
 t38-20020a05687063a600b0012b85ee59ffmr1495166oap.98.1663841003449; Thu, 22
 Sep 2022 03:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220922094123.98330-1-wqu@suse.com>
In-Reply-To: <20220922094123.98330-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 22 Sep 2022 11:02:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7We645PpmA3wRX2dPPX_dDEv0pPJhDqdzX8AyB-UcpnA@mail.gmail.com>
Message-ID: <CAL3q7H7We645PpmA3wRX2dPPX_dDEv0pPJhDqdzX8AyB-UcpnA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/253: update the data chunk size to the correct one
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 22, 2022 at 10:49 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> After kernel commit 5da431b71d4b ("btrfs: fix the max chunk size and
> stripe length calculation") the test case btrfs/253 will always fail.
>
> [CAUSE]
> Btrfs calculates the to-be-allocated chunk size using both
> chunk and stripe size limits.
>
> By default data chunk is limited to 10G, while data stripe size limit
> is only 1G.
> Thus the real chunk size limit would be:
>
>   min(num_data_devices * max_stripe_size, max_chunk_size)
>
> For single disk case (the test case), the value would be:
>
>   min(        1        *       1G       ,       10G) = 1G.
>
> The test case can only pass during a small window:
>
> - Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")
>
>   This changed the max chunk size limit to 1G, which would cause way
>   more chunks for profiles like RAID0/10/5/6, thus it is considered as
>   a regression.
>
> - Commit 5da431b71d4b ("btrfs: fix the max chunk size and stripe length calculation")
>
>   This is the fix for above regression, which reverts the data chunk
>   limit back to 10G.
>
> [FIX]
> Fix the failure by introducing a hardcoded expected data chunk size (1G).
>
> Since the test case has fixed fs size (10G) and is only utilizing one
> disk, that 1G size will work for all possible data profiles (SINGLE and
> DUP).
>
> The more elegant solution is to export stripe size limit through sysfs
> interfaces, but that would take at least 2 kernel cycles.
>
> For now, just use a hotfix to make the test case work again.
>
> Since we are here, also remove the leading "t" in the error message.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good, thanks for fixing this.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
>  tests/btrfs/253 | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/tests/btrfs/253 b/tests/btrfs/253
> index c746f41e..5fbce070 100755
> --- a/tests/btrfs/253
> +++ b/tests/btrfs/253
> @@ -107,7 +107,21 @@ SCRATCH_BDEV=$(_real_dev $SCRATCH_DEV)
>
>  # Get chunk sizes.
>  echo "Capture default chunk sizes."
> -FIRST_DATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size)
> +
> +# The sysfs interface has only exported chunk_size (10G by default),
> +# but no stripe_size (1G by default) exported.
> +#
> +# Btrfs calculate the real chunk to be allocated using both limits,
> +# Thus the default 10G chunk size can only be fulfilled by something
> +# like 10 disk RAID0
> +#
> +# The proper solution should be exporting the stripe_size limit too,
> +# but that may take several cycles, here we just use hard coded 1G
> +# as the expected chunk size.
> +FIRST_DATA_CHUNK_SIZE_B=$((1024 * 1024 * 1024))
> +
> +# For metadata, we are safe to use the exported value, as the default
> +# metadata chunk size limit is already smaller than its stripe size.
>  FIRST_METADATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size)
>
>  echo "Orig Data chunk size    = ${FIRST_DATA_CHUNK_SIZE_B}"     >> ${seqres}.full
> @@ -226,7 +240,7 @@ FIRST_METADATA_CHUNK_SIZE_MB=$(expr ${FIRST_METADATA_CHUNK_SIZE_B} / 1024 / 1024
>
>  # if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne $(expr ${FIRST_DATA_SIZE_MB}) ]]; then
>  if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne ${FIRST_DATA_SIZE_MB} ]]; then
> -       echo "tInitial data allocation not correct."
> +       echo "Initial data allocation not correct."
>  fi
>
>  if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
> --
> 2.37.2
>
