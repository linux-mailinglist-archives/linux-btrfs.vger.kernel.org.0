Return-Path: <linux-btrfs+bounces-15829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F3B19AC6
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 06:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E949E3A9A58
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141D2135D1;
	Mon,  4 Aug 2025 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ManJJHpH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85013EFE3;
	Mon,  4 Aug 2025 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282125; cv=none; b=gGHRc7DyBjiytqihOsN2o4szTCx90CAQMtA72kFPkW7s4nMXMUITTbfIe/c9jjjdyqFbhjSY5LqPC59tJEppd2WQd5RSuGYfg9Iw27BR4azOh5FsQMyYEueRn95sylmuS0B0rA9eJ4N87TNF2WRlSgmap1OzX/DOIcy25pEL6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282125; c=relaxed/simple;
	bh=KMxmqP+SIUPHWDS9L1oeEIxTuclLBo0PQk1Blm1R9J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+wDacLHQ1xJYhsyw1c6GrxW5qzZDwuiId81UL9lqoDHTwOxJKqOCho1k0V3ihM/amTswIz7pTDQYE1kbziS0honTkcZaBp1/hYR+4UoMrHm7WrwTQkH7JeWgoTgT+CDdjQ01ZMu6BE2aaAkg83xLzVgHEYKEUWuCHjIY5OsLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ManJJHpH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754282113; x=1754886913; i=quwenruo.btrfs@gmx.com;
	bh=b/UjWLjGBV3a8OQHQtjYCpGMfKoX7xqMz2/swWe2t7s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ManJJHpHauWyCxDO6gZsfPQN0z7fV0UlXPALZKtebwQyhfGRyNqm3CK0Pq5gzo5n
	 E4c6ili6KbK3rUY/wg0McAx6Bbl/6P2+KobYU6WjbYs3vbosG8NDZv8cr9mzqpYjQ
	 fWoAA9BZMG4mfR5yQ5UUZDC/EoI+v+Q+QBc6iLtEgxv9VzPghpwKILVcckCbeW90C
	 9iboRfnSG7hj1iCu7R3E+dElA6ERA+DaVSpctSkkrIeCCIoobOB8KotvvhoypCl/T
	 aU4lEdJXXFfW4UX2bjjl66gXW7VlLu/pteEbiBzatxs3RodeKeQRlc2Jl9rc16YKm
	 0ESrcKzQwZO7rDLCRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1v8eTf0wEo-00UjOt; Mon, 04
 Aug 2025 06:35:13 +0200
Message-ID: <18dbfdb1-57cb-425a-bbfb-bac8a658441d@gmx.com>
Date: Mon, 4 Aug 2025 14:05:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] generic/274: Make the test compatible with all
 blocksizes.
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <0a9f6e6d2018c6d505be192031aeb9e656b23bd3.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <0a9f6e6d2018c6d505be192031aeb9e656b23bd3.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wp7iM9WKaw+GDeynNsTDTSX6vK/CDU5UQE9owB7+KMSLXpkyHNW
 S36fK5vF6zM5SAgkg1u5dcjKi01TKB/0w5XVH7t3NQXjaz7t0rJAaMHAyN4aWR9goXwDlin
 0PItOetUmUi4gYcWCeH6HdCQreCRUBZ38wGqvgK3vbI19N/hO9S+U7zl7c6npj34Gffa4A5
 IOZIWPZGywVu8mkQqgbUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9/e6ZUhFq2o=;t4qGXxalbwAnkg3f6rtquNOqdzC
 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



=E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
> On btrfs with 64k blocksize on powerpc with 64k pagesize
> it failed with the following error:
>=20
>       ------------------------------
>       preallocation test
>       ------------------------------
>      -done
>      +failed to write to test file
>      +(see /home/xfstests-dev/results//btrfs_64k/generic/274.full for de=
tails)
>      ...
> So, this test is written with 4K block size in mind. As we can see,
> it first creates a file of size 4K and then fallocates 4MB beyond the
> EOF.
> Then there are 2 loops - one that fragments at alternate blocks and
> the other punches holes in the remaining alternate blocks. Hence,
> the test fails in 64k block size due to incorrect calculations.
>=20
> Fix this test by making the test scale with the block size, that is
> the offset, filesize and the assumed blocksize matches/scales with
> the actual blocksize of the underlying filesystem.

Again, just enlarge the block size from 4K to 64K, then all block size=20
will work.

Thanks,
Qu

>=20
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/generic/274 | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/generic/274 b/tests/generic/274
> index 916c7173..4ea42f30 100755
> --- a/tests/generic/274
> +++ b/tests/generic/274
> @@ -40,30 +40,31 @@ _scratch_unmount 2>/dev/null
>   _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
>   _scratch_mount
>  =20
> -# Create a 4k file and Allocate 4M past EOF on that file
> -$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test=
 \
> -	>>$seqres.full 2>&1 || _fail "failed to create test file"
> +blksz=3D`_get_block_size $SCRATCH_MNT`
> +scale=3D$(( blksz / 1024 ))
> +# Create a blocksize worth file and Allocate a large file past EOF on t=
hat file
> +$XFS_IO_PROG -f -c "pwrite -b $blksz 0 $blksz" -c "falloc -k $blksz $((=
 1 * 1024 * 1024 * scale ))" \
> +	$SCRATCH_MNT/test >>$seqres.full 2>&1 || _fail "failed to create test =
file"
>  =20
>   # Fill the rest of the fs completely
>   # Note, this will show ENOSPC errors in $seqres.full, that's ok.
>   echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
>   dd if=3D/dev/zero of=3D$SCRATCH_MNT/tmp1 bs=3D1M >>$seqres.full 2>&1
> -echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
> -dd if=3D/dev/zero of=3D$SCRATCH_MNT/tmp2 bs=3D4K >>$seqres.full 2>&1
> +echo "Fill fs with $blksz K IOs; ENOSPC expected" >> $seqres.full
> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/tmp2 bs=3D$blksz >>$seqres.full 2>&=
1
>   _scratch_sync
>   # Last effort, use O_SYNC
> -echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
> -dd if=3D/dev/zero of=3D$SCRATCH_MNT/tmp3 bs=3D4K oflag=3Dsync >>$seqres=
.full 2>&1
> +echo "Fill fs with $blksz DIOs; ENOSPC expected" >> $seqres.full
> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/tmp3 bs=3D$blksz oflag=3Dsync >>$se=
qres.full 2>&1
>   # Save space usage info
>   echo "Post-fill space:" >> $seqres.full
>   df $SCRATCH_MNT >>$seqres.full 2>&1
> -
>   # Now attempt a write into all of the preallocated space -
>   # in a very nasty way, badly fragmenting it and then filling it in.
>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>   for i in `seq 1 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i bs=3D4K count=3D1 c=
onv=3Dnotrunc \
> +	dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i bs=3D$blksz count=
=3D1 conv=3Dnotrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
>   done
>   _scratch_sync
> @@ -71,7 +72,7 @@ echo >> $seqres.full
>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>   for i in `seq 2 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i bs=3D4K count=3D1 c=
onv=3Dnotrunc \
> +	dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i bs=3D$blksz count=
=3D1 conv=3Dnotrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>   done
>   _scratch_sync


