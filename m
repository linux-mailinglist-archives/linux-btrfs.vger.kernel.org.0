Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB76C4A10
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 13:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCVMOr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 22 Mar 2023 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCVMOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 08:14:46 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594C1C587;
        Wed, 22 Mar 2023 05:14:45 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id h8so71969089ede.8;
        Wed, 22 Mar 2023 05:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh9QhLCuvfVYcQf/CMNMvbAp744bdFznA1TciHrugmM=;
        b=qWU46RYC8xTO8lSEPH58IQxla7GN1qISrc8cDoy7q8ZkcOYuqxKHuoGQ/3GUUBZGYW
         r07fZXMhJVSYUd7LUU3gT5dlkVXawOLZkhvbAx42+5VjlWoChdL/69yLYT0L+o43z8B+
         ncs6/n3wgNfRWn56J3AaUlryP1xYDCHzAr8aZeCx3ljmoTKCx4Nh5Ym/Id3E7QJG2hrW
         WVjt/ZAn3+Rmik+rkAlb3YF44PLAK/6bWvD/+BJRZqe/k2FB9/uQfwfCeynzuPGrI7Pm
         uSj53VKy8nZXl9wRcToFmCT4b5Shl93qK6qF9Im325nS52unstrKr56gBxUU31BNvqTv
         KSmg==
X-Gm-Message-State: AO0yUKVUfqgbFHHxkwRZLsFyVqomZEcunfyWMNc5MQNcuqF+SBkwW5vf
        BIhsTyMibp2A/XYzkff+NOH23RDrnTtDSQ==
X-Google-Smtp-Source: AK7set/LIoFV19kqgkO7wxDP4N8uupZwVuHIlYq20/NltTWZe7jVZOrHieApqpwT2bXx6v4zbVBrTg==
X-Received: by 2002:a17:906:829a:b0:90b:53f6:fd8b with SMTP id h26-20020a170906829a00b0090b53f6fd8bmr5872326ejx.31.1679487283518;
        Wed, 22 Mar 2023 05:14:43 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id lz24-20020a170906fb1800b009334309eda5sm5282403ejb.196.2023.03.22.05.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:14:43 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id h8so71968655ede.8;
        Wed, 22 Mar 2023 05:14:42 -0700 (PDT)
X-Received: by 2002:a05:6402:3496:b0:4ad:739c:b38e with SMTP id
 v22-20020a056402349600b004ad739cb38emr1488495edc.1.1679487282769; Wed, 22 Mar
 2023 05:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <dc3eb7e8a9286b2eab1fd1829e56428300d51a5a.1679464212.git.wqu@suse.com>
In-Reply-To: <dc3eb7e8a9286b2eab1fd1829e56428300d51a5a.1679464212.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 22 Mar 2023 08:14:06 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-D9VR7G_kcr0u6CUqaGETsgDmr7xLvB348k-nMqdfjvQ@mail.gmail.com>
Message-ID: <CAEg-Je-D9VR7G_kcr0u6CUqaGETsgDmr7xLvB348k-nMqdfjvQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/246: skip the test if the tested btrfs doesn't
 support inline extents creation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
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

On Wed, Mar 22, 2023 at 1:59 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [FALSE ALERT]
> If test case btrfs/246 is executed with a 16K page sized system (like
> some aarch64 SoCs) using 4K sector size (would be the new default), the
> test case would fail with output mismatch:
>
>   btrfs/246 1s ... - output mismatch (see ~/xfstests-dev/results//btrfs/246.out.bad)
>       --- tests/btrfs/246.out   2022-11-24 19:53:53.158470844 +0800
>       +++ ~/xfstests-dev/results//btrfs/246.out.bad     2023-03-22 13:27:34.975796048 +0800
>       @@ -3,3 +3,5 @@
>        0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
>        sha256sum after mount cycle
>        0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
>       +no inline extent found
>       +no compressed extent found
>       ...
>       (Run 'diff -u ~/xfstests-dev/tests/btrfs/246.out ~/xfstests-dev/results//btrfs/246.out.bad'  to see the entire diff)
>
> [CAUSE]
> For current btrfs subpage support, there are still some limitations:
>
> - No compressed write if the range is not fully page aligned
> - No inline extents creation
>   Reading inline extents is still supported
>
> Thus we won't create such inlined compressed extent at all.
>
> [FIX]
> Just skip the test case if we can not even create a regular inline
> extent.
>
> This is done by a new require helper,
> _require_btrfs_inline_extent_creation(), which would detect if btrfs can
> even create an uncompressed inlined extent.
>
> Reported-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/btrfs    | 22 ++++++++++++++++++++++
>  tests/btrfs/246 |  3 +++
>  2 files changed, 25 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 7c32360376c2..344509ce300c 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -499,6 +499,28 @@ _require_btrfs_support_sectorsize()
>                 _notrun "sectorsize $sectorsize is not supported"
>  }
>
> +_require_btrfs_inline_extents_creation()
> +{
> +       local ino
> +
> +       _require_xfs_io_command fiemap
> +       _require_scratch
> +
> +       _scratch_mkfs &> /dev/null
> +       _scratch_mount -o max_inline=2048,compress=none
> +       _pwrite_byte 0x00 0 1024 $SCRATCH_MNT/inline &> /dev/null
> +       sync
> +       $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline | tail -n 1 > $tmp.fiemap
> +       _scratch_unmount
> +       # 0x200 means inlined, 0x100 means not block aligned, 0x1 means
> +       # the last extent.
> +       if ! grep -q "0x301" $tmp.fiemap; then
> +               rm -f -- $tmp.fiemap
> +               _notrun "No inline extent creation support, maybe subpage?"
> +       fi
> +       rm -f -- $tmp.fiemap
> +}
> +
>  _btrfs_metadump()
>  {
>         local device="$1"
> diff --git a/tests/btrfs/246 b/tests/btrfs/246
> index 0dcc7c0d1a43..2fe54f959048 100755
> --- a/tests/btrfs/246
> +++ b/tests/btrfs/246
> @@ -23,6 +23,9 @@ _cleanup()
>  _supported_fs btrfs
>  _require_scratch
>
> +# If it's subpage case, we don't support inline extents creation for now.
> +_require_btrfs_inline_extents_creation
> +
>  _scratch_mkfs > /dev/null
>  _scratch_mount -o compress,max_inline=2048
>
> --
> 2.39.2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
