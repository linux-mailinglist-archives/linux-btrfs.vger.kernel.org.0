Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9754627A98
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 11:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiKNKej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 05:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiKNKeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 05:34:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C871D334;
        Mon, 14 Nov 2022 02:34:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 127506091A;
        Mon, 14 Nov 2022 10:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E9C433B5;
        Mon, 14 Nov 2022 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668422074;
        bh=rVvi7LwZHUZthQoZ6/M2mq/MMa9/VLvNBEU7VXbsEt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=irMmCSACEMITGk083ufDTO9EGnVl72S6HDWzCxRz/9JVetTr1AQfdOhf5X5MPybiA
         ZE9LtDoBgoYKyyQaDBkRvfAWz7uE78XJeGQH7Yi5rCHAyuETZejjiwY455/EaYiuK+
         heNCboea72ptd61R1U0mIQZAYDsyI09kP/O8zUqjtd756oCYs6ZeJfoFrSiC3RJc7+
         aNRraYdG2y47uxsj20iFLEcmCxFCM1KZihcIXc1EyUnHz18lWEwjfK7/AN0mAcl2NE
         k5bHLhottC/qfdYXeVIjDddephqtlkrlPepTwp48E34k2STtQPkYA+3w2L2RDLSZse
         SUpz5yaZDzAWA==
Received: by mail-ot1-f52.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso6380769otr.9;
        Mon, 14 Nov 2022 02:34:34 -0800 (PST)
X-Gm-Message-State: ANoB5pljFZIgYcmXa+ydluvJRQ/7eernj7O7ojez370d0WI0i1hCcPdG
        4g8La1F87CwhkMCDl/xSDbUf4AwecFlnp4c2d4g=
X-Google-Smtp-Source: AA0mqf6CWDN1tBbG5hjFWV0xuzlN1YN3H4KaTGTEYi3eV+iwCOwHQ3ydoQYsarhcLESqX3EGRUryrOJuaBvRggLb1Zo=
X-Received: by 2002:a9d:7407:0:b0:66d:9d4:e276 with SMTP id
 n7-20020a9d7407000000b0066d09d4e276mr6050483otk.345.1668422073623; Mon, 14
 Nov 2022 02:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20221113015323.38789-1-wqu@suse.com>
In-Reply-To: <20221113015323.38789-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 14 Nov 2022 10:33:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4U+VuiL0+eEPnWAa6hwcuLbd=soNVoJqdeMJ+V_mCp8w@mail.gmail.com>
Message-ID: <CAL3q7H4U+VuiL0+eEPnWAa6hwcuLbd=soNVoJqdeMJ+V_mCp8w@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/053: use "-n" to replace the deprecated
 "-l" mkfs option
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

On Sun, Nov 13, 2022 at 2:11 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Test case btrfs/053 will fail if using newer btrfs-progs with the extra
> error output:
>
>     mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>            dmesg(1) may have more information after failed mount system call.
>     mount /dev/mapper/test-scratch1 /mnt/scratch failed
>
> [CAUSE]
> The option "-l"/"--leafsize" is already marked deprecated since
> btrfs-progs v4.0, and finally in btrfs-progs v6.0 we removes the support
> for such deprecated option completely.
>
> But unfortunately the test case is still using the old option.
>
> [FIX]
> Fix and improve the test case by:
>
> - Use "-n" to replace the "-l" option
>
> - Rename "leaf_size" variable to "node_size"
>
> - Save the output of _scratch_mkfs to $seqres.full
>   This would save quite some time if it later failed due to some other
>   reasons in mkfs.btrfs.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/053 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I had already sent a fix for this last week:

https://lore.kernel.org/fstests/793a063833727ea80a1d0c6f13f531cff9581a1a.1668011940.git.fdmanana@suse.com/

Thanks.

>
> diff --git a/tests/btrfs/053 b/tests/btrfs/053
> index fbd2e7d9..006ea0e6 100755
> --- a/tests/btrfs/053
> +++ b/tests/btrfs/053
> @@ -37,14 +37,14 @@ _require_attrs
>  # max(16384, PAGE_SIZE) is the default leaf/node size on btrfs-progs v3.12+.
>  # Older versions just use max(4096, PAGE_SIZE).
>  # mkfs.btrfs can't create an fs with a leaf/node size smaller than PAGE_SIZE.
> -leaf_size=$(echo -e "16384\n`getconf PAGE_SIZE`" | sort -nr | head -1)
> +node_size=$(echo -e "16384\n`getconf PAGE_SIZE`" | sort -nr | head -1)
>
>  send_files_dir=$TEST_DIR/btrfs-test-$seq
>
>  rm -fr $send_files_dir
>  mkdir $send_files_dir
>
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "-n $node_size" >> $seqres.full 2>&1
>  _scratch_mount
>
>  echo "hello world" > $SCRATCH_MNT/foobar
> @@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
>  _scratch_unmount
>  _check_scratch_fs
>
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "-n $node_size" >> $seqres.full 2>&1
>  _scratch_mount
>
>  _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> --
> 2.38.0
>
