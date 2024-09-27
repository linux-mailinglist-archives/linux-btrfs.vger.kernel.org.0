Return-Path: <linux-btrfs+bounces-8299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 748779882BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D890CB2150B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D3187547;
	Fri, 27 Sep 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="djwtSaTf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218C39AD6;
	Fri, 27 Sep 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433977; cv=none; b=E7XrJLOqX2fDV77vckxce7rJgfrsYjyV26UXQh9eNz04sl5Crm4U9WKk2Bit+5hjNo12fHfB1sN9VG/tlKERAsKXmDgt/xNeqhDgRkZR67xENSqtkOpTF4W41r5xjVTCgudw0gMuu4IL4Unl5npXhxlIqTLcb3nAEbQ94j+bn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433977; c=relaxed/simple;
	bh=OjWJgTFiMevfMHRWDd3ucH0a3xUritJCrRfF2LaWKXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLf8wMR1LYQdUw4I9bsBrN9hYDW167ba8KaRRqPCHIR+27m/5DnO8FJRMof5fU9yCYdMSfWAyBpSn4OBQVl1ZxBIgsezAdItnh36A3ggB/3U3tr/oI2YlpciVymX4XEMdTJOZmRbQagnHCwS4tDzePV8ajAqWRr6ZNk2qmbdKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=djwtSaTf; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727433967; x=1728038767; i=quwenruo.btrfs@gmx.com;
	bh=FHLmprBN+8BvBkcYJP5lQXA36pqXWPZMUMuipRnTwyQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=djwtSaTf4FiHHXJfgwrQxSOwkLKMTE/foTijHkGX7lKR+l+p9fEUzBYShI0ec8nG
	 U0APoccLcbKdXjm++JWTEEsbxbwoVM66tztWEbF34fmmUo3AkLhhytQuGKXVk1H3+
	 EAblA5L/OMwUX5dbtIC52B/y5prhDu5jEOohvkkcJhKBqgvatEFj4lENXkwNUv5r6
	 MwnHx96imD+nEAjLjA9RKfwnh1L4DU00XPdlZbnZi+YV6sJduMhXvjfBYuvuSC43w
	 08tdEiD3SR2ZL6mkGkiOC2hn3cvbQ3OPzyaam9PYCmJqCxkvFTCtLRGR9guMHFG9E
	 AcjU+kGfShcRbIpeTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1scsiU15c1-00Nf3S; Fri, 27
 Sep 2024 12:46:07 +0200
Message-ID: <32a28670-a5bc-4638-b576-1c756417b925@gmx.com>
Date: Fri, 27 Sep 2024 20:16:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test an incremental send scenario with cloning of
 unaligned extent
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5qLlNotGX6HJ1//eCre8AURe8BxyZYiAuHkaRyJ9rjuMy+C3S3i
 gCP7S0aA63YHT7DU18Rhv7XBGTfi6l6qsyiHGV818OV4CFdbBidB3TsVcbrwl5SB/SxYEqm
 liiAzOihnIlVVAifPucj0BIYtG++x+gieYMOffxwSy8AqCapCQoHkz1szxNuJZF1LAwrUZy
 vVRyK9mz7Eq3fMYOTr+Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LNdReHfvlKI=;jKNO8dohBLaCeQi1xB4zNSOXz6+
 0p/taQ8QDpXii2f5V9GS7ieIjOWmGUeiNzKsNGOkv0K+0j1Ve+O9/RTa6Ob6X0TWj61wR8Bsi
 HvvTN7uaV6Cb8EjRfOhxU98c4rLF60TpE35nt2/xT2b+Jih/J85E1rj+dbZ6q6Q9A46mYv3x2
 gUXPJey0P5aOgVg7y+RoxHmNhuPs8WxPd0eZnYLuvTPfrdCC1ALUFg4ns4VfKTNTUoeGX9ad9
 8nkMdzmdk4reyru5xPQHrVYO2oPRo+BunxQ1uUmhFoCTgVwFaNNDHnhFUa/jZGZq426+vDrqW
 iOq50Rj+4SCKxBDCtS1DMtk/EUtlZsynJUVpG9hzTyoL5BjDd4vvph08BwPD86Sicu5Cmn91p
 OJkpj0DZ6bHk1a6UsmB5wrgDnS+LuqLjHRpfYByTtFKGOuP5SOvo5lAYyK6ZjLjTwXss6ALzt
 D/sdQjFjQPWeVmjVaXJ9+PH58b3pGEdnjm7zhf8W8FOgi7RKhoqhISJVugPp9BiCZ8h9VzpDb
 re6CzejZA7o3CMevnQKFVs5GrK+xPHGv9BHYH7dkXE4k2n7cQXKiNh5li9nxW0BhHt2OFaf0w
 qsl1rMVXWfhnr2c+q2q097QgFjQ46UqlMvvp8gGnTb/NwbIRR2Mo9p/290vsWhVbT0XZ+mlx4
 EtQBvYm9wNQmJ8WMgMdNojgq8NRx58OB0lSDrXfYni+mGx3nshy83nSgQBcpPPNYQj4yLnGjB
 svfM5M+Ph1vDMjmSNyYk7C9hTV2nlA/fc5azPn4EoG4jcPtXoFOwXgaSVdR4rZCNJidULQiuo
 wu/394sC8ax8zWW2MWezaLUA==



=E5=9C=A8 2024/9/27 19:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that doing an incremental send with a file that had its size
> decreased and became the destination for a clone operation of an extent
> with an unaligned end offset that matches the new file size, works
> correctly.
>
> This tests a bug fixed by the following kernel patch:
>
>    "btrfs: send: fix invalid clone operation for file that got its size =
decreased"
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick.

[...]
> +. ./common/filter
> +. ./common/reflink
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_require_test

Initially I thought test is not necessary, but later turns out that
we're using TEST_MNT to store the two streams.

May be we can just reuse $tmp.*?

Thanks,
Qu

> +_require_scratch_reflink
> +_require_xfs_io_command "fiemap"
> +_require_odirect
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: send: fix invalid clone operation for file that got its size d=
ecreased"
> +
> +check_all_extents_shared()
> +{
> +	local file=3D$1
> +	local fiemap_output
> +
> +	fiemap_output=3D$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_fiema=
p_flags)
> +	echo "$fiemap_output" | grep -qv 'shared'
> +	if [ $? -eq 0 ]; then
> +		echo -e "Found non-shared extents for file $file:\n"
> +		echo "$fiemap_output"
> +	fi
> +}
> +
> +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> +full_send_stream=3D$send_files_dir/full_snap.stream
> +inc_send_stream=3D$send_files_dir/inc_snap.stream
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> +_scratch_mount
> +
> +# Create a file with a size of 256K + 5 bytes, having two extents, the =
first one
> +# with a size of 128K and the second one with a size of 128K + 5 bytes.
> +last_extent_size=3D$((128 * 1024 + 5))
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
> +             -c "pwrite -S 0xcd -b $last_extent_size 128K $last_extent_=
size" \
> +             $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Another file which we will later clone foo into, but initially with
> +# a larger size than foo.
> +$XFS_IO_PROG -f -c "pwrite -b 0xef 0 1M" $SCRATCH_MNT/bar | _filter_xfs=
_io
> +
> +echo "Creating snapshot and the full send stream for it..."
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> +$BTRFS_UTIL_PROG send -f $full_send_stream $SCRATCH_MNT/snap1 >> $seqre=
s.full 2>&1
> +
> +# Now resize bar and clone foo into it.
> +$XFS_IO_PROG -c "truncate 0" \
> +	     -c "reflink $SCRATCH_MNT/foo" $SCRATCH_MNT/bar | _filter_xfs_io
> +
> +echo "Creating another snapshot and the incremental send stream for it.=
.."
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $inc_send_stream \
> +		 $SCRATCH_MNT/snap2 >> $seqres.full 2>&1
> +
> +echo "File digests in the original filesystem:"
> +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> +
> +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> +
> +echo "Creating a new filesystem to receive the send streams..."
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG receive -f $full_send_stream $SCRATCH_MNT
> +$BTRFS_UTIL_PROG receive -f $inc_send_stream $SCRATCH_MNT
> +
> +echo "File digests in the new filesystem:"
> +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> +
> +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/322.out b/tests/btrfs/322.out
> new file mode 100644
> index 00000000..31e1ee55
> --- /dev/null
> +++ b/tests/btrfs/322.out
> @@ -0,0 +1,24 @@
> +QA output created by 322
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131077/131077 bytes at offset 131072
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Creating snapshot and the full send stream for it...
> +linked 0/0 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Creating another snapshot and the incremental send stream for it...
> +File digests in the original filesystem:
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
> +Creating a new filesystem to receive the send streams...
> +At subvol snap1
> +At snapshot snap2
> +File digests in the new filesystem:
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar


