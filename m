Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7876F61E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Aug 2023 01:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjHCX0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 19:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjHCX0k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 19:26:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7EF1BF6;
        Thu,  3 Aug 2023 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691105189; x=1691709989; i=quwenruo.btrfs@gmx.com;
 bh=VCL9GE1SpjLZYKVktWpbJrXTIcExxsccI54Si4WMudU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YmdcpprvcaUpFzpbUuQ+M72Nuc26IyOWi0/BnnvyzlOT96HEl5CHWfpMizb05OPiHfaId0A
 bQtxiEnd4XLpMTE/lTPRnUMhsFyd/sX//Y+u7LsGPaicUcQj+/ogYfxuIBvxBMjZXowq1Qy0u
 YiH+wzL9yxTjOSUoEgnxA2wEbz8D6q7redDzalP+G2Xu0b78mCGpt84Sxi09Ux7xC/aw/LkFR
 9p9jLuz6QPexMGDKWayFnx6Ejq9Rr2wfa3M34QmdxQt8wlAA4o20nlcBCBMo72cl5Husk7PeR
 c2urwpLt9qbaG2zgKHFeUjs0xBmqvcTV+MrfQXlaKxRaYIb2/Yxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1pfDIR457n-00xNXh; Fri, 04
 Aug 2023 01:26:29 +0200
Message-ID: <ae643756-44b1-ef82-4349-a51dccb25e57@gmx.com>
Date:   Fri, 4 Aug 2023 07:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs/276: make test accurate regarding number of
 expected extents
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Qu Wenruo <wqu@suse.com>
References: <c54bf70be6bbeefe440ea5b1341495b16803455c.1691058187.git.fdmanana@suse.com>
 <d74e3007a58128e6352f7aced6c403e2a2291181.1691062439.git.fdmanana@suse.com>
Content-Language: en-US
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
In-Reply-To: <d74e3007a58128e6352f7aced6c403e2a2291181.1691062439.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9LbvEG9R4qTljU+574Bb14vdsSitp+uci7u8rijBzaYYQ70APPQ
 YpSkSCDhZQPwu6iaQ5hzMM7QVWXmD57mVpYGAmiuRwfvdJUv6r9vsAPvlWPyMstrMaPOep7
 AFSWGojnlYqsXWkTSlC6XhdSi4ZZ1Okf8kk6z5p07yKwT1BW9vwgNMY0CtwqQXveYYtKyXR
 0wx0Gc8P7JDCIWC1Wv1Rg==
UI-OutboundReport: notjunk:1;M01:P0:xqs3hX0MOnw=;+GehiqgYAFl4CRBwvZPyZ9XrI9Q
 AI7Wgf+kGSlF8qcKf7vwF664sL96MLGF+5aODCk0CVAMuQ4hOtwFZn5FVNOG/9SthRAiZlpdK
 G4uLFi9v100AINUIEnNeeIgPww/dkm5/Ud6RG7qmLKmoilf7h8Tgb+3giR5K68gu841pTkKq2
 c2yhfm1ZvE0CYwZaqNSmtxMFB0KHZras809N3ULNzXSLgGbZYynulV7Hd0gGLYISNVHG3WoaV
 mb97YXMLjHbqcSLo5iIvHyT6lFQqULt27uK3kzKCuKXTLmicP2t1wIEikRIaIOZ3d5SfUMjua
 WuTwAKhvmG9cgiTehM3QsArKS8+hjjbI8mf3gAIEFDKcjFTrDoj7NpdqKDtZ2jSQjU+jIcqI8
 A38Wzfl8mjL6BB9/bsxo/OMzF0xZGHYyxBzn9QOcnSfT+jLKrdEDnD7+KwY9601Mv8cFxk1pY
 eAuis3F+kgZF1TySJtj/AXdxCsFrGONj5pQ9G4UyHvZtCB/eeafbcWGtRuPuI3ik1MQ6OeN3K
 tb+ASynRypz7ENoydvFb74Zx+SRXp3JU6YHt/8VZHejNs7zTzr+MLM0UCWE1V5Tst7MO4lVra
 N2mYfsthK1OS3esPiqwMc/Oo56Byph1CpaLTex4DkJRXWwogn2aNuAjvHt7bxa8F3odO0SxV1
 HI5AOe65rvPhHKAjamK2ez1M/UJ/DHbT8wF2djcctrwx9kz2VobKPqXGgedUHI/hzQ9nOsFc+
 pQlwIsq5bKPjZrdd1eNI7GehM1TV15Miedt8FC3YuP7qeiJVT1CM1BAlBtRFAONgAXdMW+dwE
 r4jQSeQa7oiOJZEVG7h+h4H+NJMwAsQDiVg6TCaDuY9DNeQxHX641WkLsk3d3xZX+6ig6Fh3m
 or0tY9Gt0ibpaCLOuUyFuFXmgiD87lNSlM8V/NqXpqpMof6E0SzE8GSFRiStzF0F57muGCA9r
 Ps1NfCNehABqtvHwimOXypItmNA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/3 19:37, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> btrfs/276 creates a 16G file with compression enabled in order to quickl=
y
> and efficiently create a file with many extents and have a fs tree with =
a
> height of 3 (root node at level 2), so that it can test that fiemap is
> correctly reporting extent sharedness when we have shared subtrees of th=
e
> fs tree due to a snapshot.
>
> Compression results in extents with a maximum size of 128K and the test
> is expecting only extents of 128K, which normally happens if the machine
> has a large amount of RAM and writeback is not triggered before the xfs_=
io
> command finishes. However if writeback is triggered in the meanwhile, du=
e
> to memory pressure for example, then we can get end up with some extents
> that are smaller than 128K, therefore increasing the total number of
> extents in the test file and make the test fail.
>
> This seems to happen often on test machines with small amounts of RAM,
> such as 4G, as reported by Qu in the following thread:
>
>    https://lore.kernel.org/linux-btrfs/20230801065529.50122-1-wqu@suse.c=
om/
>
> So to address this create a file with holes and direct IO to make sure w=
e
> always get a specific number of extents in the test file. To speedup the
> test create 2000 64K extents, with holes in between them, so that it wor=
ks
> on a fs with any sector size, and then create a bunch of files with larg=
e
> xattrs to quickly bump the fs tree height to 3 for any node size (4K to
> 64K). This also guarantees that the file extent items are spread over
> multiples leaves, in order to exercise fiemap's correctness when reporti=
ng
> shared extents due to shared subtrees.
>
> Reported-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>
Tested-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> V3: Add missing 'wait' after each loop. Use sync to wait for ordered
>      extents after creating the file as well to avoid any races, and use
>      sync after updating the file to make sure we wait for ordered
>      extents to complete and we end up using the extent tree path in
>      the fiemap code instead of the delayed refs path (as it was before
>      this change).
>
> V2: Use sync writes when overwriting file ranges to make sure fiemap
>      will see the new file extent items.
>
>   tests/btrfs/276     | 86 +++++++++++++++++++++++++++++----------------
>   tests/btrfs/276.out | 20 +++++------
>   2 files changed, 64 insertions(+), 42 deletions(-)
>
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> index 944b0c8f..8a21963c 100755
> --- a/tests/btrfs/276
> +++ b/tests/btrfs/276
> @@ -9,19 +9,19 @@
>   # and when the file's subvolume was snapshoted.
>   #
>   . ./common/preamble
> -_begin_fstest auto snapshot compress fiemap
> +_begin_fstest auto snapshot fiemap
>
>   . ./common/filter
> +. ./common/attr
>
>   _supported_fs btrfs
>   _require_scratch
>   _require_xfs_io_command "fiemap" "ranged"
> +_require_attrs
> +_require_odirect
>
>   _scratch_mkfs >> $seqres.full 2>&1
> -# We use compression because it's a very quick way to create a file wit=
h a very
> -# large number of extents (compression limits the maximum extent size t=
o 128K)
> -# and while using very little disk space.
> -_scratch_mount -o compress
> +_scratch_mount
>
>   fiemap_test_file()
>   {
> @@ -29,8 +29,9 @@ fiemap_test_file()
>   	local len=3D$2
>
>   	# Skip the first two lines of xfs_io's fiemap output (file path and
> -	# header describing the output columns).
> -	$XFS_IO_PROG -c "fiemap -v $offset $len" $SCRATCH_MNT/foo | tail -n +3
> +	# header describing the output columns) as well as holes.
> +	$XFS_IO_PROG -c "fiemap -v $offset $len" $SCRATCH_MNT/foo | \
> +		grep -v 'hole' | tail -n +3
>   }
>
>   # Count the number of shared extents for the whole test file or just f=
or a given
> @@ -63,19 +64,43 @@ count_not_shared_extents()
>   			  --source 'END { print cnt }'
>   }
>
> -# Create a 16G file as that results in 131072 extents, all with a size =
of 128K
> -# (due to compression), and a fs tree with a height of 3 (root node at =
level 2).
> -# We want to verify later that fiemap correctly reports the sharedness =
of each
> -# extent, even when it needs to switch from one leaf to the next one an=
d from a
> -# node at level 1 to the next node at level 1.
> -#
> -$XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_=
io
> -
> -# Sync to flush delalloc and commit the current transaction, so fiemap =
will see
> -# all extents in the fs tree and extent trees and not look at delalloc.
> +# Create a file with 2000 extents, and a fs tree with a height of at le=
ast 3
> +# (root node at level 2). We want to verify later that fiemap correctly=
 reports
> +# the sharedness of each extent, even when it needs to switch from one =
leaf to
> +# the next one and from a node at level 1 to the next node at level 1.
> +# To speedup creating a fs tree of height >=3D 3, add several large xat=
trs.
> +ext_size=3D$(( 64 * 1024 ))
> +file_size=3D$(( 2000 * 2 * $ext_size )) # about 250M
> +nr_cpus=3D$("$here/src/feature" -o)
> +workers=3D0
> +for (( i =3D 0; i < $file_size; i +=3D 2 * $ext_size )); do
> +	$XFS_IO_PROG -f -d -c "pwrite -b $ext_size $i $ext_size" \
> +		$SCRATCH_MNT/foo > /dev/null &
> +	workers=3D$(( workers + 1 ))
> +	if [ "$workers" -ge "$nr_cpus" ]; then
> +		workers=3D0
> +		wait
> +	fi
> +done
> +wait
> +
> +workers=3D0
> +xattr_value=3D$(printf '%0.sX' $(seq 1 3900))
> +for (( i =3D 1; i <=3D 29000; i++ )); do
> +	echo -n > $SCRATCH_MNT/filler_$i
> +	$SETFATTR_PROG -n 'user.x1' -v $xattr_value $SCRATCH_MNT/filler_$i &
> +	workers=3D$(( workers + 1 ))
> +	if [ "$workers" -ge "$nr_cpus" ]; then
> +		workers=3D0
> +		wait
> +	fi
> +done
> +wait
> +
> +# Make sure every ordered extent completed and therefore updated the fs=
 tree.
>   sync
>
> -# All extents should be reported as non shared (131072 extents).
> +# All extents should be reported as non shared (2000 extents).
>   echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>
>   # Creating a snapshot.
> @@ -84,26 +109,25 @@ $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $S=
CRATCH_MNT/snap | _filter_scr
>   # We have a snapshot, so now all extents should be reported as shared.
>   echo "Number of shared extents in the whole file: $(count_shared_exten=
ts)"
>
> -# Now COW two file ranges, of 1M each, in the snapshot's file.
> -# So 16 extents should become non-shared after this.
> +# Now COW two file ranges, of 64K each, in the snapshot's file.
> +# So 2 extents should become non-shared after this. Each file extent it=
em is in
> +# different leaf of the snapshot tree.
>   #
> -$XFS_IO_PROG -c "pwrite -b 1M 8M 1M" \
> -	     -c "pwrite -b 1M 12G 1M" \
> +$XFS_IO_PROG -d -c "pwrite -b $ext_size 512K $ext_size" \
> +	     -d -c "pwrite -b $ext_size 249M $ext_size" \
>   	     $SCRATCH_MNT/snap/foo | _filter_xfs_io
>
> -# Sync to flush delalloc and commit the current transaction, so fiemap =
will see
> -# all extents in the fs tree and extent trees and not look at delalloc.
> +# Wait for ordered extents to complete and commit current transaction t=
o make
> +# sure fiemap will see all extents in the subvolume and extent trees.
>   sync
>
> -# Now we should have 16 non-shared extents and 131056 (131072 - 16) sha=
red
> -# extents.
> +# Now we should have 2 non-shared extents and 1998 shared extents.
>   echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>   echo "Number of shared extents in the whole file: $(count_shared_exten=
ts)"
>
> -# Check that the non-shared extents are indeed in the expected file ran=
ges (each
> -# with 8 extents).
> -echo "Number of non-shared extents in range [8M, 9M): $(count_not_share=
d_extents 8M 1M)"
> -echo "Number of non-shared extents in range [12G, 12G + 1M): $(count_no=
t_shared_extents 12G 1M)"
> +# Check that the non-shared extents are indeed in the expected file ran=
ges.
> +echo "Number of non-shared extents in range [512K, 512K + 64K): $(count=
_not_shared_extents 512K 64K)"
> +echo "Number of non-shared extents in range [249M, 249M + 64K): $(count=
_not_shared_extents 249M 64K)"
>
>   # Now delete the snapshot.
>   $BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_scrat=
ch
> @@ -116,7 +140,7 @@ $BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/sn=
ap | _filter_scratch
>   _scratch_remount commit=3D1
>   sleep 1.1
>
> -# Now all extents should be reported as not shared (131072 extents).
> +# Now all extents should be reported as not shared (2000 extents).
>   echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>
>   # success, all done
> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> index 3bf5a5e6..197d8edc 100644
> --- a/tests/btrfs/276.out
> +++ b/tests/btrfs/276.out
> @@ -1,16 +1,14 @@
>   QA output created by 276
> -wrote 17179869184/17179869184 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Number of non-shared extents in the whole file: 131072
> +Number of non-shared extents in the whole file: 2000
>   Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> -Number of shared extents in the whole file: 131072
> -wrote 1048576/1048576 bytes at offset 8388608
> +Number of shared extents in the whole file: 2000
> +wrote 65536/65536 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 1048576/1048576 bytes at offset 12884901888
> +wrote 65536/65536 bytes at offset 261095424
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Number of non-shared extents in the whole file: 16
> -Number of shared extents in the whole file: 131056
> -Number of non-shared extents in range [8M, 9M): 8
> -Number of non-shared extents in range [12G, 12G + 1M): 8
> +Number of non-shared extents in the whole file: 2
> +Number of shared extents in the whole file: 1998
> +Number of non-shared extents in range [512K, 512K + 64K): 1
> +Number of non-shared extents in range [249M, 249M + 64K): 1
>   Delete subvolume (commit): 'SCRATCH_MNT/snap'
> -Number of non-shared extents in the whole file: 131072
> +Number of non-shared extents in the whole file: 2000
