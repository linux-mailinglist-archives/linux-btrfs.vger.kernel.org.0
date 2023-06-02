Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA61A71FEB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjFBKNP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjFBKNL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 06:13:11 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87881A7;
        Fri,  2 Jun 2023 03:13:10 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-555536b85a0so997953eaf.2;
        Fri, 02 Jun 2023 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685700790; x=1688292790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JfMvZYQUFsWPmSuPf8lqhiQLviaxrd/5ApgResj+aO0=;
        b=iyNMRZj3xqTuqpKPXF3XWhXMMEmUhg1u9llJTMlAdE4owBtK2409XuSUtuwG+ntYOS
         aqmYTe5NQ981j7s5EKv4KyjqnY9ahq4VRfhNdjHKZe0PJw4SHspbwwPw4Ove0DjyNWSU
         w/QyEQvOaSsGoxuJNd6UQiDYPuOlgyL47n+J+7ol5k0+8j1QxkxlYlNRymfDByffPI/X
         ZNW5htxHERW554b3R6JsjL0PUQCc7BQkX4DxGJpwnIhaF2l2hGLaBsiNyj4iraM0XGIx
         pVeb/Pf+KTa2l9j046C8mWD4+J0F5T89UBMUmuU8rSdBX94ABfy9oY3TjHDn1EQi68Dx
         +UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700790; x=1688292790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfMvZYQUFsWPmSuPf8lqhiQLviaxrd/5ApgResj+aO0=;
        b=Db/KKWunk2nDKh/oI19hNwyCeCoX5FemsytcnIrXB7wV64dvM8dTGYGE3PXQsJacQ9
         +IzbftRySygGsfoCZRTfrHdJdxM7AmgcicbBG8rHNFhDvx2uFEHM1X/wB9MZLo0ChEV9
         WXdAEhO4NKw1u4hYTy/SjGiVJ+tmtHaIWnlIPgym+4fphBS5Cjj1TiaclIjc5L67gnT/
         nLz9sg8TVQYJP+Ee4zU7zEITiTfO4Hq2Lih936v+6WIAcaZeKbt7ZpxJk7uDsRDZYqiq
         DJYfCtF3htxY2oMORn34wOdt/HcdMJfUjX/t4N150B/rscGKCQVUsTiXv+lpJM09N5/G
         B+6g==
X-Gm-Message-State: AC+VfDyhJvBFZbfXrK+F08UoCs1lyg4kC5qZpHYl/2W6ZjutwInz+yP7
        jYa3bnIlSxxeAj/nf0h6i2eCiAc0S2mZ4LFlhzlFwncW
X-Google-Smtp-Source: ACHHUZ480hcM9oC+CLvHAJ5/eNll4Qtsu5nQgtGxDJbbwpVIxXuVHHIB+VVDwVUc5tJgCALxoyHGqkTM5+zKRg/yJec=
X-Received: by 2002:a05:6870:5403:b0:192:b3f7:9325 with SMTP id
 d3-20020a056870540300b00192b3f79325mr1136050oan.47.1685700789895; Fri, 02 Jun
 2023 03:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230602082759.132364-1-wqu@suse.com>
In-Reply-To: <20230602082759.132364-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 2 Jun 2023 11:12:33 +0100
Message-ID: <CAL3q7H5MrXiVEOTiqrN02d4o6XkYJeofR1k=8reLrW8W+S7nKg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/106: avoid hard coded output to handle different
 page sizes
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 2, 2023 at 9:29=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Test case btrfs/106 is known to fail if the system has a page size other
> than 4K.
>
> This test case can fail like this:
>
>     btrfs/106 5s ... - output mismatch (see ~/xfstests-dev/results//btrfs=
/106.out.bad)
>     --- tests/btrfs/106.out     2022-11-24 19:53:53.140469437 +0800
>     +++ ~/xfstests-dev/results//btrfs/106.out.bad      2023-06-02 16:12:5=
7.014273249 +0800
>     @@ -5,19 +5,19 @@
>      File contents before unmount:
>      0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>      *
>     -40
>     +1000
>      File contents after remount:
>      0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/btrfs/106.out /home/adam/xfstests-=
dev/results//btrfs/106.out.bad'  to see the entire diff)
>
> This is particularly problematic for systems like Aarch64 or PPC64 which
> supports 64K page size.
>
> [CAUSE]
> The test case is using page size to calculate the amount of data to
> write, thus it doesn't support any page sizes other than 4K.
>
> [FIX]
> Instead of using the golden output, go with md5sum and compare them
> before and after the remount.
>
> The new md5sum would only go into $seqres.full for debugging, not into
> golden output to avoid false alerts on different pages sizes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/011     |  2 +-
>  tests/btrfs/106     | 15 +++++++++++----
>  tests/btrfs/106.out | 18 ++----------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 852742ee..dd432296 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -190,7 +190,7 @@ btrfs_replace_test()
>                 # For above finished case, we still output the error mess=
age
>                 # but continue the test, or later profiles won't get test=
ed
>                 # at all.
> -               grep -q canceled $tmp.tmp || echo "btrfs replace status (=
canceled) failed"
> +               #grep -q canceled $tmp.tmp || echo "btrfs replace status =
(canceled) failed"

This change to btrfs/011 is not supposed to be here...

With this hunk removed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>         else
>                 if [ "${quick}Q" =3D "thoroughQ" ]; then
>                         # The thorough test runs around 2 * $wait_time se=
conds.
> diff --git a/tests/btrfs/106 b/tests/btrfs/106
> index db295e70..7496697f 100755
> --- a/tests/btrfs/106
> +++ b/tests/btrfs/106
> @@ -38,8 +38,9 @@ test_clone_and_read_compressed_extent()
>         $CLONER_PROG -s 0 -d $((16 * $PAGE_SIZE)) -l $((16 * $PAGE_SIZE))=
 \
>                 $SCRATCH_MNT/foo $SCRATCH_MNT/foo
>
> -       echo "File contents before unmount:"
> -       od -t x1 $SCRATCH_MNT/foo | _filter_od
> +       echo "Hash before unmount:" >> $seqres.full
> +       old_md5=3D$(_md5_checksum "$SCRATCH_MNT/foo")
> +       echo "$old_md5" >> $seqres.full
>
>         # Remount the fs or clear the page cache to trigger the bug in bt=
rfs.
>         # Because the extent has an uncompressed length that is a multipl=
e of 16
> @@ -52,9 +53,15 @@ test_clone_and_read_compressed_extent()
>         # correctly.
>         _scratch_cycle_mount
>
> -       echo "File contents after remount:"
> +       echo "Hash after remount:" >> $seqres.full
>         # Must match the digest we got before.
> -       od -t x1 $SCRATCH_MNT/foo | _filter_od
> +       new_md5=3D$(_md5_checksum "$SCRATCH_MNT/foo")
> +       echo "$new_md5" >> $seqres.full
> +       if [ "$old_md5" !=3D "$new_md5" ]; then
> +               echo "Hash mismatches after remount"
> +       else
> +               echo "Hash matches after remount"
> +       fi
>  }
>
>  echo -e "\nTesting with zlib compression..."
> diff --git a/tests/btrfs/106.out b/tests/btrfs/106.out
> index 1144a82f..cd69cdd7 100644
> --- a/tests/btrfs/106.out
> +++ b/tests/btrfs/106.out
> @@ -2,22 +2,8 @@ QA output created by 106
>
>  Testing with zlib compression...
>  Pages modified: [0 - 15]
> -File contents before unmount:
> -0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -40
> -File contents after remount:
> -0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -40
> +Hash matches after remount
>
>  Testing with lzo compression...
>  Pages modified: [0 - 15]
> -File contents before unmount:
> -0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -40
> -File contents after remount:
> -0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -40
> +Hash matches after remount
> --
> 2.39.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
