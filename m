Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A907ABBE9
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjIVWku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIVWks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:40:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4691B4;
        Fri, 22 Sep 2023 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695422434; x=1696027234; i=quwenruo.btrfs@gmx.com;
 bh=kJsSxDI7SQ9K5GQtJSbCS3qdmMhhXSoEOs4tzmjXcHI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jpn802AbICDSBw78C//gRX0lniar66jQfX/ulyyyIE04YfcvppEkYGDjKG+uvL2sDNisSHM5U8e
 jhtuETYljGexQNGI2WYhapm5v9iZeAENuAW1k8VElWY1RZgdscnYt4Jr4mqr+bXjwCjZNMI9BByLB
 EfiqSFxLvleyNB/e9O214vg4OxwWW4JvaWdkx/v3GdAka1g+w09fiFq99kBHaSSDRERHpiYnHm1PR
 UD1naL2oHtLlvtbpfa3UreVCmaew0LBVvcaoFLYvM2ZPW/8b9FvUrYzXFfsyjIVykUHT7wBPa9zmO
 ammQ26irTzQgSMApMsMhlTQpWWOtPcrXFP4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhnN-1rfTea2EJF-00vh3V; Sat, 23
 Sep 2023 00:40:34 +0200
Message-ID: <17c15c9b-49a8-443b-84ae-a33b13512504@gmx.com>
Date:   Sat, 23 Sep 2023 08:10:30 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/287: filter snapshot IDs to avoid failures when
 using some features
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <99982dd613b5bb2d693b0491af873e1e7291dd4b.1695383059.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <99982dd613b5bb2d693b0491af873e1e7291dd4b.1695383059.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJDatGAhdeto+jLo+yQAWT8SQ8wz2AomHRANRfDZWw9TZ0wJRna
 zh4uPV/7mCL5/scMaDm6o7MSokYylwoqpGhTgk0iWWgjECVvVkUTnhu1QLzAAfJq/ppVZUe
 RmcxaLsmxFVaY3FLUageODjnOV71u/PQP8QhaZPaqXCEmVMAW4sI5w1G1q0jVyLdCY74zSE
 6p5f5royK75OBn0l8mlQg==
UI-OutboundReport: notjunk:1;M01:P0:oz9Rge66aIQ=;LKTe8oqQunw+WNDjp//8bo3Datr
 7sZ0pnluoZvtF3+HET4c1zIWBwdphITx4MKYiqGdJzKSMaDghmgLQ7S0NNTpwV2igz2zGteEj
 TKm+S7QRDa8WfR4MCZcxkdLq5CI5KqrWCvwEDvHrUsm29jSn1IxmwTf7vQK77mJ1eHe7ZpIsK
 SHbt5hp22qkGXJEFedn4Ziuev9eEO2BxbGwVEyRiilwRZcPxepFmXOKIdzDY5nHxbAiZJVzTI
 xZd23386VGpehRW6f0F5ZqLq3A9YYrqRAtSNCqcEcO+0ZoRWf4sZfeNnDSLNqU5B8cw9k8vSY
 UkMBOXQXoLiUFQx2WNi373M8dYmIasmNx4G6Ut2xtVXvxSLVh02VnF6dCYBG4y39frV3obtuy
 I13h85MywIYKZkCmyjrVAOEUmvTCfPN1VTf0gN0iPLNfXbb4dukpNd2gwxdPcTc+pz5OH/NK6
 B7IfXbpS8TK+I0wXXqLJbdaLEgCSux2khefo3FLg6r/KIw1bcU4v72nK/VM540J8Vb5UqKV0A
 QgmJwtoZ3YuUItx9SETl8GpuK7gqpup3LyVKH+iG7OErYNuyLPLPZRBeNEcPajY7VqxL+KQ5Q
 jzhP4AHc0WADnjbD9YvFNmIqsszUBYHAymPZ3Aocx3YmdvaPtdeDoK/h2NuN7zV+HjIEKGsEI
 /VFNYANV5uznzutfCiNR76V9Y2zmaCe+PWRT91CN2iuH1R73aVPmvBImduMScvYAL4qyoDuYw
 lA5WgEa+UfDpu7NR8Lgjq09rS5hqq2hlEnboaP/fAF2ewArA3h1hRTRv2aBBKu8yPcNiV9S+H
 g9UHL8isM8RB8OClU2BvW2JTTvPz9TNYRkor8NQk1td9o0AbicTlhOzbZ20QuJQz+5Fea/w9G
 02QyzU+jQF/atD61YA+tPWFGwL6oY7RRY5Lx78YSV+/cGDF+mAu+Tlx+Xnq/UynNbA668VGVk
 dRzcu78VRs0jAf+QSDtN8cyE6bM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 21:15, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When running btrfs/287 with features that create extra trees or don't
> the need to create some trees, such as when using the free space tree
> (default for several btrfs-progs releases now) versus when not using
> it (by passing -R ^free-space-tree in MKFS_OPTIONS), the test can fail
> because the IDs for the two snapshots it creates changes, and the golden
> output is requiring the numeric IDs of the snapshots.
>
> For example, when disabling the free space tree, the test fails like thi=
s:
>
>    $ MKFS_OPTIONS=3D"-R ^free-space-tree" ./check btrfs/287
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc2-btrfs-next-138+ #1 SM=
P PREEMPT_DYNAMIC Thu Sep 21 17:58:48 WEST 2023
>    MKFS_OPTIONS  -- -R ^free-space-tree /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
>    btrfs/287 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstes=
ts/results//btrfs/287.out.bad)
>        --- tests/btrfs/287.out	2023-09-22 12:39:43.060761389 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	20=
23-09-22 12:40:54.238849251 +0100
>        @@ -44,52 +44,52 @@
>         Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap=
1'
>         Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap=
2'
>         resolve first extent:
>        -inode 257 offset 16777216 root 257
>        -inode 257 offset 8388608 root 257
>        -inode 257 offset 16777216 root 256
>        -inode 257 offset 8388608 root 256
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the e=
ntire diff)
>
>    HINT: You _MAY_ be missing kernel fix:
>          0cad8f14d70c btrfs: fix backref walking not returning all inode=
 refs
>
>    Ran: btrfs/287
>    Failures: btrfs/287
>    Failed 1 of 1 tests
>
> So add a filter to logical reserve calls to replace snapshot root IDs wi=
th
> a logical name (snap1 and snap2).
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/287     | 24 ++++++++++++++-----
>   tests/btrfs/287.out | 56 ++++++++++++++++++++++-----------------------
>   2 files changed, 46 insertions(+), 34 deletions(-)
>
> diff --git a/tests/btrfs/287 b/tests/btrfs/287
> index cac96a23..04871d46 100755
> --- a/tests/btrfs/287
> +++ b/tests/btrfs/287
> @@ -27,6 +27,15 @@ query_logical_ino()
>   	$BTRFS_UTIL_PROG inspect-internal logical-resolve -P $* $SCRATCH_MNT
>   }
>
> +# The IDs of the snapshots (roots) we create may vary if we are using t=
he free
> +# space tree or not for example (mkfs options -R free-space-tree and
> +# -R ^free-space-tree). So replace their IDs with names so that we don'=
t get
> +# golden output mismatches if we are using features that create other r=
oots.
> +filter_snapshot_ids()
> +{
> +	sed -e "s/root $snap1_id\b/snap1/" -e "s/root $snap2_id\b/snap2/"
> +}
> +
>   _scratch_mkfs >> $seqres.full || _fail "mkfs failed"
>   _scratch_mount
>
> @@ -107,16 +116,19 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MN=
T $SCRATCH_MNT/snap1 \
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2=
 \
>   	| _filter_scratch
>
> +snap1_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
> +snap2_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
> +
>   # Query for the first extent (at offset 0). Should give two entries fo=
r each
>   # root - default subvolume and the 2 snapshots, for file offsets 8M an=
d 16M.
>   echo "resolve first extent:"
> -query_logical_ino $first_extent_bytenr
> +query_logical_ino $first_extent_bytenr | filter_snapshot_ids
>
>   # Query for the first extent (at offset 0) with the ignore offset opti=
on.
>   # Should give 3 entries for each root - default subvolume and the 2 sn=
apshots,
>   # for file offsets 2M, 8M and 16M.
>   echo "resolve first extent with ignore offset option:"
> -query_logical_ino -o $first_extent_bytenr
> +query_logical_ino -o $first_extent_bytenr | filter_snapshot_ids
>
>   # Now lets punch a 1M hole at file offset 4M. This changes the second =
file
>   # extent item to point to the second extent with an offset of 1M and a=
 length
> @@ -126,14 +138,14 @@ query_logical_ino -o $first_extent_bytenr
>   # return file offsets 12M and 20M.
>   $XFS_IO_PROG -c "fpunch 4M 1M" $SCRATCH_MNT/foo
>   echo "resolve second extent after punching hole at file range [4M, 5M)=
:"
> -query_logical_ino $second_extent_bytenr
> +query_logical_ino $second_extent_bytenr | filter_snapshot_ids
>
>   # Repeat the query but with the ignore offset option. We should get 3 =
entries
>   # for each root. For the snapshot roots, we should get entries for fil=
e offsets
>   # 4M, 12M and 20M, while for the default subvolume (root 5) we should =
get for
>   # file offsets 5M, 12M and 20M.
>   echo "resolve second extent with ignore offset option:"
> -query_logical_ino -o $second_extent_bytenr
> +query_logical_ino -o $second_extent_bytenr | filter_snapshot_ids
>
>   # Now delete the first snapshot and repeat the last 2 queries.
>   $BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_scra=
tch
> @@ -142,13 +154,13 @@ $BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/=
snap1 | _filter_scratch
>   # and 20M for the default subvolume (root 5) and file offsets 4M, 12M =
and 20M
>   # for the second snapshot root.
>   echo "resolve second extent:"
> -query_logical_ino $second_extent_bytenr
> +query_logical_ino $second_extent_bytenr | filter_snapshot_ids
>
>   # Query the second extent with the ignore offset option, should return=
 file
>   # offsets 5M, 12M and 20M for the default subvolume (root 5) and file =
offsets
>   # 4M, 12M and 20M for the second snapshot root.
>   echo "resolve second extent with ignore offset option:"
> -query_logical_ino -o $second_extent_bytenr
> +query_logical_ino -o $second_extent_bytenr | filter_snapshot_ids
>
>   status=3D0
>   exit
> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
> index 683f9875..0d694733 100644
> --- a/tests/btrfs/287.out
> +++ b/tests/btrfs/287.out
> @@ -44,52 +44,52 @@ inode 257 offset 2097152 root 5
>   Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   resolve first extent:
> -inode 257 offset 16777216 root 257
> -inode 257 offset 8388608 root 257
> -inode 257 offset 16777216 root 256
> -inode 257 offset 8388608 root 256
> +inode 257 offset 16777216 snap2
> +inode 257 offset 8388608 snap2
> +inode 257 offset 16777216 snap1
> +inode 257 offset 8388608 snap1
>   inode 257 offset 16777216 root 5
>   inode 257 offset 8388608 root 5
>   resolve first extent with ignore offset option:
> -inode 257 offset 16777216 root 257
> -inode 257 offset 8388608 root 257
> -inode 257 offset 2097152 root 257
> -inode 257 offset 16777216 root 256
> -inode 257 offset 8388608 root 256
> -inode 257 offset 2097152 root 256
> +inode 257 offset 16777216 snap2
> +inode 257 offset 8388608 snap2
> +inode 257 offset 2097152 snap2
> +inode 257 offset 16777216 snap1
> +inode 257 offset 8388608 snap1
> +inode 257 offset 2097152 snap1
>   inode 257 offset 16777216 root 5
>   inode 257 offset 8388608 root 5
>   inode 257 offset 2097152 root 5
>   resolve second extent after punching hole at file range [4M, 5M):
> -inode 257 offset 20971520 root 257
> -inode 257 offset 12582912 root 257
> -inode 257 offset 4194304 root 257
> -inode 257 offset 20971520 root 256
> -inode 257 offset 12582912 root 256
> -inode 257 offset 4194304 root 256
> +inode 257 offset 20971520 snap2
> +inode 257 offset 12582912 snap2
> +inode 257 offset 4194304 snap2
> +inode 257 offset 20971520 snap1
> +inode 257 offset 12582912 snap1
> +inode 257 offset 4194304 snap1
>   inode 257 offset 20971520 root 5
>   inode 257 offset 12582912 root 5
>   resolve second extent with ignore offset option:
> -inode 257 offset 20971520 root 257
> -inode 257 offset 12582912 root 257
> -inode 257 offset 4194304 root 257
> -inode 257 offset 20971520 root 256
> -inode 257 offset 12582912 root 256
> -inode 257 offset 4194304 root 256
> +inode 257 offset 20971520 snap2
> +inode 257 offset 12582912 snap2
> +inode 257 offset 4194304 snap2
> +inode 257 offset 20971520 snap1
> +inode 257 offset 12582912 snap1
> +inode 257 offset 4194304 snap1
>   inode 257 offset 20971520 root 5
>   inode 257 offset 12582912 root 5
>   inode 257 offset 5242880 root 5
>   Delete subvolume (commit): 'SCRATCH_MNT/snap1'
>   resolve second extent:
> -inode 257 offset 20971520 root 257
> -inode 257 offset 12582912 root 257
> -inode 257 offset 4194304 root 257
> +inode 257 offset 20971520 snap2
> +inode 257 offset 12582912 snap2
> +inode 257 offset 4194304 snap2
>   inode 257 offset 20971520 root 5
>   inode 257 offset 12582912 root 5
>   resolve second extent with ignore offset option:
> -inode 257 offset 20971520 root 257
> -inode 257 offset 12582912 root 257
> -inode 257 offset 4194304 root 257
> +inode 257 offset 20971520 snap2
> +inode 257 offset 12582912 snap2
> +inode 257 offset 4194304 snap2
>   inode 257 offset 20971520 root 5
>   inode 257 offset 12582912 root 5
>   inode 257 offset 5242880 root 5
