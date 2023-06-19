Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1F735C02
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjFSQOA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjFSQNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 12:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89AC1;
        Mon, 19 Jun 2023 09:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B096F60CEC;
        Mon, 19 Jun 2023 16:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EBFC433C0;
        Mon, 19 Jun 2023 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687191230;
        bh=vkC+ydyc1K10E4aU96V2606YKMmGw0UTU+dAgU4Ei/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LlzVplq6gegHBlgVfXPaFXrnrwRh5xBajvDFE/U+N2XrG9Hrd7WMKFYHx6Hthkk59
         IwUOTCaVJUMWWA0Istarlc7A3d5FapnvX1bwHOeT8kO+PsTYw8msVqrVwxVKmsldX4
         sb98W8kpAR0phvNf4cGAeyomkdUNSO3tnGFGiQl2ZUE/kLHP9CrQ8Ml3HoPEic/r97
         pSkQjmnJvZPv0TqXK4n9jNOsKPqe6OaRjUbUiEy3j2YCognQi++j1SqC3SQFE75AaV
         YOaXAK0Z52TK5osqHCSIXxY8iWSGPFH/iopALL8HNo4X2GlkBVq0natlbcxz0th7MP
         X0seYMUOwYj7g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-55e4b840858so812264eaf.1;
        Mon, 19 Jun 2023 09:13:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDyjmWbSXxfYzmbM397tNOjCbu69fCYwv2dCXut8GrIkBDxY/pvv
        VXuMhdpG1vVi30ftVAf2gJWA/TnaVmVMiMJe4hE=
X-Google-Smtp-Source: ACHHUZ5HJYk8bbA358WS/a2zDirWJzLwrzwCY4opXo9+zPR3a/R/p5GPUmflobu0Zmcns11pVn5Zh/1uZVAuLy1ZX8s=
X-Received: by 2002:a05:6808:199:b0:39b:3494:1ee5 with SMTP id
 w25-20020a056808019900b0039b34941ee5mr10334930oic.18.1687191229235; Mon, 19
 Jun 2023 09:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230608114836.97523-1-wqu@suse.com>
In-Reply-To: <20230608114836.97523-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 19 Jun 2023 17:13:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6VhahmpcWZGpfauyUmrG76kqAyZAMQb8_5T74Xyg6U+A@mail.gmail.com>
Message-ID: <CAL3q7H6VhahmpcWZGpfauyUmrG76kqAyZAMQb8_5T74Xyg6U+A@mail.gmail.com>
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 8, 2023 at 1:02=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a chance that btrfs/266 would fail on aarch64 with 64K page
> size. (No matter if it's 4K sector size or 64K sector size)
>
> The failure indicates that one or more mirrors are not properly fixed.
>
> [CAUSE]
> I have added some trace events into the btrfs IO paths, including
> __btrfs_submit_bio() and __end_bio_extent_readpage().
>
> When the test failed, the trace looks like this:
>
>  112819.764977: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D1 le=
n=3D196608 pid=3D33663
>                                     ^^^ Initial read on the full 192K fil=
e
>  112819.766604: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D2 le=
n=3D65536 pid=3D21806
>                                     ^^^ Repair on the first 64K block
>                                         Which would success
>  112819.766760: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D65536 mirror=3D=
2 len=3D65536 pid=3D21806
>                                     ^^^ Repair on the second 64K block
>                                         Which would fail
>  112819.767625: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D65536 mirror=3D=
3 len=3D65536 pid=3D21806
>                                     ^^^ Repair on the third 64K block
>                                         Which would success
>  112819.770999: end_bio_extent_readpage: read finished, r/i=3D5/257 fileo=
ff=3D0 len=3D196608 mirror=3D1 status=3D0
>                                          ^^^ The repair succeeded, the
>                                              full 192K read finished.
>
>  112819.864851: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D3 le=
n=3D196608 pid=3D33665
>  112819.874854: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D1 le=
n=3D65536 pid=3D31369
>  112819.875029: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D131072 mirror=
=3D1 len=3D65536 pid=3D31369
>  112819.876926: end_bio_extent_readpage: read finished, r/i=3D5/257 fileo=
ff=3D0 len=3D196608 mirror=3D3 status=3D0
>
> But above read only happen for mirror 1 and mirror 3, mirror 2 is not
> involved.
> This means by somehow, the read on mirror 2 didn't happen, mostly
> due to something wrong during the drop_caches call.
>
> It may be an async operation or some hardware specific behavior.
>
> On the other hand, for test cases doing the same operation but utilizing
> direct IO, aka btrfs/267, it never fails as we never populate the page
> cache thus would always read from the disk.
>
> [WORKAROUND]
> The root cause is in the "echo 3 > drop_caches", which I'm still
> debugging.
>
> But at the same time, we can workaround the problem by forcing a
> cycle mount of scratch device, inside _btrfs_buffered_read_on_mirror().
>
> By this we can ensure all page caches are dropped no matter if
> drop_caches is working correctly.
>
> With this patch, I no longer hit the failure on aarch64 with 64K page
> size anymore, while before this the test case would always fail during a
> -I 10 run.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> RFC:
> The root cause is still inside that "echo 3 > drop_caches", but I don't
> have any better solution if such fundamental debug function is not
> working as expected.
>
> Thus this is only a workaround, before I can pin down the root cause of
> that drop_cache hiccup.
> ---
>  common/btrfs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 344509ce..1d522c33 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -599,6 +599,11 @@ _btrfs_buffered_read_on_mirror()
>         local size=3D$5
>
>         echo 3 > /proc/sys/vm/drop_caches
> +       # Above drop_caches doesn't seem to drop every pages on aarch64 w=
ith
> +       # 64K page size.
> +       # So here as a workaround, cycle mount the SCRATCH_MNT to ensure
> +       # the cache are dropped.
> +       _scratch_cycle_mount

Btw, I'm getting some tests failing because of this change.

For e.g.:

./check btrfs/143
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc6-btrfs-next-134+ #1 SMP
PREEMPT_DYNAMIC Thu Jun 15 11:59:28 WEST 2023
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/143 6s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
    --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
2023-06-19 17:04:00.575033899 +0100
    @@ -1,37 +1,6 @@
     QA output created by 143
     wrote 131072/131072 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
/home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
the entire diff)
Ran: btrfs/143
Failures: btrfs/143
Failed 1 of 1 tests

The problem is this test is using dm-rust, and _scratch_cycle_mount()
doesn't work in that case.
It should be _unmount_dust() followed by_mount_dust() for this particular c=
ase.


>         while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
>                 exec $XFS_IO_PROG \
>                         -c "pread -b $size $offset $size" $file) ]]; do
> --
> 2.39.1
>
