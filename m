Return-Path: <linux-btrfs+bounces-3953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03516899885
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C11F22197
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC915FA9B;
	Fri,  5 Apr 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PuhNU70v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B81465B4;
	Fri,  5 Apr 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307145; cv=none; b=R+ak6am8Z2jUd92jH2cpEsVWUnP7XW3K1HvFETg5PO0uGMuKTY1O0eX5rHDsDGzxqAdQYxH3cu7vVn2e/aoAM2enZqT4mbKGN2KG38XiWT9w/lIfR6K0QGwgVl9J2ESstHrqIhgVbk8l1o7OS6agfGofMOnpegMycz+NmnxoivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307145; c=relaxed/simple;
	bh=8fpQObyvF5WPPpn3qPxbs2yT1K9xGZSbvJ0SUCL9iaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB/y4QvxLz14664KY4uiTxyCy0uwEk0uYhxMTgn7BZS0U2+OskF3I0HbDr4hcy+qb8UVHsNrk6BII6PvY/cWmcW5/Zro4Ykage7AY00G4eumL1D5H9iML9dxrbjO4eYdPqeDawD+WAm0p0l73uVKpgw5QCIndmFGkiEMblOyb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PuhNU70v; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712307128; x=1712911928; i=quwenruo.btrfs@gmx.com;
	bh=jNZ8pjb8gpe54W6a+ytJj44l6sdiGMBCrwiYOirzJAg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PuhNU70vv8dBZmqRm81D0I9IINrcbRSohdJJNGyMBNKszoqDkRTNbzJruJGdtZYT
	 Gc6KifL7LalSPWkfSbs3G/egPFiORAaNBP7Rs6HJeL/NiU7uMUp+zltUNUxaWDDfc
	 H2tqI+P6ETgVApIYFwSS7SRJfi6W/Eu8iftAhrOmjn65NJ1cYeZgH27Y4C/jGNJwI
	 t2uhVQW+xtTO9ma+sQzgMcFGF/jWUTxZ/0Et+RwiuCOrcs59q8ELWW70SYXgakSat
	 S/7Co0Mj+jI9qN8tKFe2JXrU0/4oDfrLPEhE1euQB0wi7YnKl/yvl0zx0qsKfBgkS
	 bVBDAoXnJvF/SdBEtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1sIp1S3sm1-00Qm0q; Fri, 05
 Apr 2024 10:52:08 +0200
Message-ID: <a62dbef2-0371-49e7-b5eb-9bb5fed32a17@gmx.com>
Date: Fri, 5 Apr 2024 19:22:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/filter.btrfs: add a new _filter_snapshot
To: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 josef@toxicpanda.com, dsterba@suse.cz
References: <cover.1712306454.git.anand.jain@oracle.com>
 <3d035b4355abc0cf9e95da134d89e3fbb58939d0.1712306454.git.anand.jain@oracle.com>
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
In-Reply-To: <3d035b4355abc0cf9e95da134d89e3fbb58939d0.1712306454.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EqI4Sh2D+8km/g6sI87nXec/JSP9W7lImzH9QdV0s5yX4IZfpYD
 wW0gZIbkrw724qgavtSN6svgsrR6M+YWGhquHo4Kx2rZ5FscGFAms5uH8NyeDvseZXx2TlL
 /DPYrx7fSDhW+D2JDxBEhkto/6QFz6DzizdFuaFaBTo2V+IvO0Dia0J0Lg+tG+VhEnheEon
 dIbk1j18jnJbi+ba9sqsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:02fplLV7Pco=;+NrrSxpfZWseBgzze8J7zRvBOIA
 kArJTCx9TJkefIrXCnMekGkVbl5PbUgRYuU9E2JMA86kEpz1/11nQw18+PoiHvz8Aa85V2HfE
 H0scuewFvbFHGc2rKaMjESMYt72HSwvofGCeglvClzqHITgxGe0V0/098al1FQzjQpWGGcjSp
 GNHW+kk7o3D5EmiMd7/P1s9c9rq/l1oq64V8rDLllhjrqQhyLO/F8hEHpWE6qVqlhQsiuMASA
 WvX/8p0uYJVB6usvaeDTVcUrgTsx3JxgPt77NfbIGFH4ZFisn+fq7mSChfBlRlPTKKzxWz/1E
 aNWNbAylm2p0grZpPVbY2LQaeu/P+fD6p7cikQ7LGFV7yrDY8w72GsmRyzkXTy2AixCAJTeVy
 EzQ/YP6MYvD7E7KZhVZO9YkJklvq7lz8XpJ4iAxfb7VdTLWJU7ZywUhnjBeseZVJgW7Kcx5Z4
 OZ78nTCY5HEzs8cIuhmLVQxT84D54xGuvoryvxZA/x5viNcj7r7blOFKtY2L7sC/PYKPe3sK1
 nsGLO/Y5uliv/EDThi92oJlrLTBRAcyynq02Dank6njnpiBEIyzNmZFRvGK462yHdN5fqWz0K
 4877CCkRIt5mauRMBWph789OVsa15WkMoPsCZvoYD3+tOJUVpwPp5s1DBiWFkKqAUdidTKK/k
 MVCzaIrP6A8f2QdI3C4obbNxZQ4NfgjCkzEyayHwuIyXOExH7uvCvwAw2n58FTMFO7nZnzfg7
 qtejmCTIvlZFOC90j+reYbqbgr1kEc0gSzeQMDfH5uxYQ1fRSyqfdnAb7grOpFXQcy7wawALb
 IcqMr1vKXolmKzADhQ6v6zWnlQDFzOT12hOZOgH/qOC/w=



=E5=9C=A8 2024/4/5 19:15, Anand Jain =E5=86=99=E9=81=93:
> As the newer btrfs-progs have changed the output of the command
> "btrfs subvolume snapshot," which is part of the golden output,
> create a helper filter to ensure the test cases pass on older
> btrfs-progs.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Can we stop the golden output filter game?

 From day one I'm not a big fan of the golden output idea.
For snapshot/subvolume creation, we don't really care about what the
output is, we only care if there is any error (which would come from
stderr).

In that case, why not just redirect the stdout to null?

To me, if we really care something from the stdout, we can still save it
and let bash/awk/grep to process it, like what we did for various test
cases, and then save the result to seqres.full.

Thanks,
Qu
> ---
>   common/filter.btrfs | 9 +++++++++
>   tests/btrfs/001     | 3 ++-
>   tests/btrfs/152     | 6 +++---
>   tests/btrfs/168     | 6 +++---
>   tests/btrfs/202     | 4 ++--
>   tests/btrfs/302     | 4 ++--
>   6 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 9ef9676175c9..415ed6dfd088 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -156,5 +156,14 @@ _filter_device_add()
>
>   }
>
> +_filter_snapshot()
> +{
> +	# btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: subvolume: output the
> +	# prompt line only when the ioctl succeeded") changed the output for
> +	# btrfs subvolume snapshot, ensure that the latest fstests continue to
> +	# work on older btrfs-progs without the above commit.
> +	_filter_scratch | sed -e "s/Create a/Create/g"
> +}
> +
>   # make sure this script returns success
>   /bin/true
> diff --git a/tests/btrfs/001 b/tests/btrfs/001
> index 6c2639990373..cfcf2ade4590 100755
> --- a/tests/btrfs/001
> +++ b/tests/btrfs/001
> @@ -26,7 +26,8 @@ dd if=3D/dev/zero of=3D$SCRATCH_MNT/foo bs=3D1M count=
=3D1 &> /dev/null
>   echo "List root dir"
>   ls $SCRATCH_MNT
>   echo "Creating snapshot of root dir"
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _f=
ilter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | \
> +							_filter_snapshot
>   echo "List root dir after snapshot"
>   ls $SCRATCH_MNT
>   echo "List snapshot dir"
> diff --git a/tests/btrfs/152 b/tests/btrfs/152
> index 75f576c3cfca..b89fe361e84e 100755
> --- a/tests/btrfs/152
> +++ b/tests/btrfs/152
> @@ -11,7 +11,7 @@
>   _begin_fstest auto quick metadata qgroup send
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   # real QA test starts here
>   _supported_fs btrfs
> @@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>
>   # Create base snapshots and send them
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
> -	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
> +	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapshot
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
> -	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
> +	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapshot
>   for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>   	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null =
| \
>   		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
> diff --git a/tests/btrfs/168 b/tests/btrfs/168
> index acc58b51ee39..78bc9b8f81bb 100755
> --- a/tests/btrfs/168
> +++ b/tests/btrfs/168
> @@ -20,7 +20,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   # real QA test starts here
>   _supported_fs btrfs
> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro fals=
e
>   # Create a snapshot of the subvolume, to be used later as the parent s=
napshot
>   # for an incremental send operation.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/s=
nap1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # First do a full send of this snapshot.
>   $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv=
1/baz >>$seqres.full
>   # Create a second snapshot of the subvolume, to be used later as the s=
end
>   # snapshot of an incremental send operation.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/s=
nap2 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # Temporarily turn the second snapshot to read-write mode and then ope=
n a file
>   # descriptor on its foo file.
> diff --git a/tests/btrfs/202 b/tests/btrfs/202
> index 5f0429f18bf9..57ecbe47c0bb 100755
> --- a/tests/btrfs/202
> +++ b/tests/btrfs/202
> @@ -8,7 +8,7 @@
>   . ./common/preamble
>   _begin_fstest auto quick subvol snapshot
>
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   _supported_fs btrfs
>   _require_scratch
> @@ -28,7 +28,7 @@ _scratch_mount
>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # Need the dummy entry created so that we get the invalid removal when=
 we rmdir
>   ls $SCRATCH_MNT/c/b
> diff --git a/tests/btrfs/302 b/tests/btrfs/302
> index f3e6044b5251..52d712ac50de 100755
> --- a/tests/btrfs/302
> +++ b/tests/btrfs/302
> @@ -15,7 +15,7 @@
>   . ./common/preamble
>   _begin_fstest auto quick snapshot subvol
>
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   _supported_fs btrfs
>   _require_scratch
> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>   # Now create a snapshot of the subvolume and make it accessible from w=
ithin the
>   # subvolume.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
> -		 $SCRATCH_MNT/subvol/snap | _filter_scratch
> +				 $SCRATCH_MNT/subvol/snap | _filter_snapshot
>
>   # Now unmount and mount again the fs. We want to verify we are able to=
 read all
>   # metadata for the snapshot from disk (no IO failures, etc).

