Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9476CADA
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHBK27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjHBK2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 06:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCA5B9E;
        Wed,  2 Aug 2023 03:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94659618F3;
        Wed,  2 Aug 2023 10:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED124C433C9;
        Wed,  2 Aug 2023 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690971826;
        bh=rcGjV/KllcFJSF5eC33oaYw+vMBa6oe6ki6be/o5rW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hKi2RrDPE3ROAsB73j2WuLUioaX0CGNWG+i8uSo3Rd3BCtgcQrPhX8LUgCfWqxVrB
         Jn+/syZ5ZiirZ5lKe2A0eU8k82tRj8TvYkHsxdV1wZSWQzUIO9gAuNovkj4SFEvK4t
         xLUuQYfzOnNT3D7fyObfvzw85akW6xNLMqtfs2snMz8/66/KpvvhjntFxX0GcXxRoC
         YFEI33mI89M1+TjOv1nrd/7WrU9BXoVAM78+ECgP+dByGJ2VLVlEOckwuQ2pG+jyrY
         noYs84H0Fru/bYSuzbyVeePF4EeNfvy2NvH+qxaZI30eg0/wX/Vc7xhBRtGmkw0P9l
         1KGONwbFF1AVA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56c74961e0cso3665881eaf.3;
        Wed, 02 Aug 2023 03:23:45 -0700 (PDT)
X-Gm-Message-State: ABy/qLZmKod0LwNoBbfQcNVY13/0dgSEfIPqNgXstNJujuWJ1BnLWmq9
        7jv4pcdIFLXXKWIrphEwpqI1h3xx/bSiqFrLtoc=
X-Google-Smtp-Source: APBJJlEazdyiE7Qo+5LylQwWp5KWeBlA5L4fNkimke1nS+jpvRSwrYIqSyI+K+svoAhuyjW6vs/uLRmidtGjjJigO+4=
X-Received: by 2002:a05:6870:1686:b0:1bb:a359:b909 with SMTP id
 j6-20020a056870168600b001bba359b909mr17667225oae.55.1690971825012; Wed, 02
 Aug 2023 03:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230801065529.50122-1-wqu@suse.com>
In-Reply-To: <20230801065529.50122-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 2 Aug 2023 11:23:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
Message-ID: <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/276: allow a slight increase in the number of extents
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 1, 2023 at 8:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Sometimes test case btrfs/276 would fail with extra number of extents:
>
>     - output mismatch (see /opt/xfstests/results//btrfs/276.out.bad)
>     --- tests/btrfs/276.out     2023-07-19 07:24:07.000000000 +0000
>     +++ /opt/xfstests/results//btrfs/276.out.bad        2023-07-28 04:15:=
06.223985372 +0000
>     @@ -1,16 +1,16 @@
>      QA output created by 276
>      wrote 17179869184/17179869184 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -Number of non-shared extents in the whole file: 131072
>     +Number of non-shared extents in the whole file: 131082
>      Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>     -Number of shared extents in the whole file: 131072
>     ...
>     (Run 'diff -u /opt/xfstests/tests/btrfs/276.out /opt/xfstests/results=
//btrfs/276.out.bad'  to see the entire diff)
>
> [CAUSE]
> The test case uses golden output to record the number of total extents
> of a 16G file.
>
> This is not reliable as we can have writeback happen halfway, resulting
> smaller extents thus slightly more extents.
>
> With a VM with 4G memory, I have a chance around 1/10 hitting this
> false alert.
>
> [FIX]
> Instead of using golden output, we allow a slight (5%) float in the
> number of extents, and move the 131072 (and 131072 - 16) from golden
> output, so even if we have a slightly more extents, we can still pass
> the test.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/276     | 41 ++++++++++++++++++++++++++++++++++++-----
>  tests/btrfs/276.out |  4 ----
>  2 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> index 944b0c8f..a63b28bb 100755
> --- a/tests/btrfs/276
> +++ b/tests/btrfs/276
> @@ -65,10 +65,17 @@ count_not_shared_extents()
>
>  # Create a 16G file as that results in 131072 extents, all with a size o=
f 128K
>  # (due to compression), and a fs tree with a height of 3 (root node at l=
evel 2).
> +#
> +# But due to writeback can happen halfway, we may have slightly more ext=
ents
> +# than 128K, so we allow 5% increase in the number of extents.
> +#
>  # We want to verify later that fiemap correctly reports the sharedness o=
f each
>  # extent, even when it needs to switch from one leaf to the next one and=
 from a
>  # node at level 1 to the next node at level 1.
>  #
> +nr_extents_lower=3D$((128 * 1024))
> +nr_extents_upper=3D$((128 * 1024 + 128 * 1024 / 20))
> +
>  $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_i=
o

Does adding '-s' (fsync after every write) to the $XFS_IO_PROG fixes the is=
sue?
On my test vm, it doesn't increase runtime by that much (16 to 23 seconds).

I'd rather do that so that we can be sure fiemap is working correctly
and not returning more extents than there really are - this approach
of allowing a bit more allows for that type of bug to be unnoticed,
plus that little bit more might not be always enough (depending on
available rm, writeback settings, etc).

Thanks.

>
>  # Sync to flush delalloc and commit the current transaction, so fiemap w=
ill see
> @@ -76,13 +83,22 @@ $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/=
foo | _filter_xfs_io
>  sync
>
>  # All extents should be reported as non shared (131072 extents).
> -echo "Number of non-shared extents in the whole file: $(count_not_shared=
_extents)"
> +found1=3D$(count_not_shared_extents)
> +echo "Number of non-shared extents in the whole file: ${found1}" >> $seq=
res.full
> +
> +if [ $found1 -lt $nr_extents_lower -o $found1 -gt $nr_extents_upper ]; t=
hen
> +       echo "unexpected initial number of extents, has $found1 expect [$=
nr_extents_lower, $nr_extents_upper]"
> +fi
>
>  # Creating a snapshot.
>  $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _fi=
lter_scratch
>
>  # We have a snapshot, so now all extents should be reported as shared.
> -echo "Number of shared extents in the whole file: $(count_shared_extents=
)"
> +found2=3D$(count_shared_extents)
> +echo "Number of shared extents in the whole file: ${found2}" >> $seqres.=
full
> +if [ $found2 -ne $found1 ]; then
> +       echo "unexpected shared extents, has $found2 expect $found1"
> +fi
>
>  # Now COW two file ranges, of 1M each, in the snapshot's file.
>  # So 16 extents should become non-shared after this.
> @@ -97,8 +113,18 @@ sync
>
>  # Now we should have 16 non-shared extents and 131056 (131072 - 16) shar=
ed
>  # extents.
> -echo "Number of non-shared extents in the whole file: $(count_not_shared=
_extents)"
> -echo "Number of shared extents in the whole file: $(count_shared_extents=
)"
> +found3=3D$(count_not_shared_extents)
> +found4=3D$(count_shared_extents)
> +echo "Number of non-shared extents in the whole file: ${found3}"
> +echo "Number of shared extents in the whole file: ${found4}" >> $seqres.=
full
> +
> +if [ $found3 !=3D 16 ]; then
> +       echo "Unexpected number of non-shared extents, has $found3 expect=
 16"
> +fi
> +
> +if [ $found4 !=3D $(( $found1 - $found3 )) ]; then
> +       echo "Unexpected number of shared extents, has $found4 expect $((=
 $found1 - $found3 ))"
> +fi
>
>  # Check that the non-shared extents are indeed in the expected file rang=
es (each
>  # with 8 extents).
> @@ -117,7 +143,12 @@ _scratch_remount commit=3D1
>  sleep 1.1
>
>  # Now all extents should be reported as not shared (131072 extents).
> -echo "Number of non-shared extents in the whole file: $(count_not_shared=
_extents)"
> +found5=3D$(count_not_shared_extents)
> +echo "Number of non-shared extents in the whole file: ${found5}" >> $seq=
res.full
> +
> +if [ $found5 !=3D $found1 ]; then
> +       echo "Unexpected final number of non-shared extents, has $found5 =
expect $found1"
> +fi
>
>  # success, all done
>  status=3D0
> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> index 3bf5a5e6..e318c2e9 100644
> --- a/tests/btrfs/276.out
> +++ b/tests/btrfs/276.out
> @@ -1,16 +1,12 @@
>  QA output created by 276
>  wrote 17179869184/17179869184 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Number of non-shared extents in the whole file: 131072
>  Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> -Number of shared extents in the whole file: 131072
>  wrote 1048576/1048576 bytes at offset 8388608
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 1048576/1048576 bytes at offset 12884901888
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Number of non-shared extents in the whole file: 16
> -Number of shared extents in the whole file: 131056
>  Number of non-shared extents in range [8M, 9M): 8
>  Number of non-shared extents in range [12G, 12G + 1M): 8
>  Delete subvolume (commit): 'SCRATCH_MNT/snap'
> -Number of non-shared extents in the whole file: 131072
> --
> 2.41.0
>
