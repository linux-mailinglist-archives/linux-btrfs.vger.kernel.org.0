Return-Path: <linux-btrfs+bounces-4021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1089BA24
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08149B21088
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D42E84F;
	Mon,  8 Apr 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NYOJZRVF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDB2DF73;
	Mon,  8 Apr 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564705; cv=none; b=eFcEgWaFgNRg7sjqETFiI5Xp4BlheHMgKOM6Y9eoG0+smP/vw+bIJUzbovNDolXRuBR/orwwKNgLFU4iqu8fJRJeU2Dv1/tRm5SawVqjwiYSjXhtM3XQ7zw/SRs4igqKNRCactB8eINQwGH75W7HR1lA9+60pTcwpy26bdoM3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564705; c=relaxed/simple;
	bh=XmTln+eUsoWCkPR6GkOM0BRnuknb8QhDwgh2drmWyg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReMpPEu5C8zmy61+Mfy0ttvGHAaUa7PtQX3hFCaCAal/kJb+3FF9q4fBckHH2OEqLzGipmuyukq7U4UpPX62Fk7582sby48HX31yMbBv9dkvJjQuvNEMltrdmAKb0viGxEnErK5FLgap+BQoDybo70PwjcBEBO7qdmJ356bCoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NYOJZRVF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712564696; x=1713169496; i=quwenruo.btrfs@gmx.com;
	bh=4M9DuBL0CZiGyh8KIzrC6Zinn76ITyDxsBz6BYK0LIQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=NYOJZRVFUC3oWxeljXU62RgODqvQj14QMAIJypEv55y1Nj/6/YJUozkH/RWM990U
	 1BQN62TCoC74Oksw5FlzdQA9uG7G5HhyjTsyKuYMcWVtAmMktzpPW2QObDqnGXwJN
	 hS9IGq3rnpJ6PHs8VyCahW03OPhCZfyCSMpyD9h/kAvwZtKV0Xmyva5bFpmZ/jQrC
	 PEHTxOMv7mTs68N96i5r1RUF96xkrJL/TYDy/KMyqbayqGL0EJj9O3NltHwAqMqOQ
	 luxahNGdPbk4r7i/+K5m16CKvUUej4as7yyyuG4FLNcwVYB4RAM5Pse87SRknmIr5
	 /ODsYLsUwLdC7LBQXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1rpMaV1XdY-004Tq3; Mon, 08
 Apr 2024 10:24:56 +0200
Message-ID: <8ed760a1-eaa7-4fc6-9599-f642b3b70b76@gmx.com>
Date: Mon, 8 Apr 2024 17:54:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/filter.btrfs: introduce _filter_snapshot
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712306454.git.anand.jain@oracle.com>
 <bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
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
In-Reply-To: <bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VU+nM28BCCAWcGRtVjgoZ9BK1bvcBSGqIfD7CXVPN9UJMunvQ2N
 BUUGnEljyR7WeAAPSidmNI0ED8NSCQYG9AisabXi2DCfgW9St9KFGkSY5WBGxvtcDAVCPEA
 5pMyK7sWceuUc8MrvCvixLI2HncshtrtGNzp7eg7y3dQflCtvZAsrzXaLSixWT/g08btyIr
 yLS9E6WRfOMt6BBR+j/qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kn+8hrXp6RA=;ITT2W7jRckL8CHnseZ5rAVG6XFn
 UF5mFrehSYzfNMW/PPN5GXm4JqQKBLsZqrU8aTaVyqgo4x2OOnbeJriAvJe+F6jMUEl0zIjCF
 1dJGqFQJTmDTd65bWBNm84ecKBMCvPjxJxUQPM/YJkm2Bk4k5whfDlDqHUuhH4C2C21oWM9mn
 uxc571XrVWzATRbkUAY8fOs0hWgFtV4XiGTpOpxTNQYlvRspgHRf/KOXaNnKSfEbO1Wh5FN0E
 nmZFTufLBdHensfZJRCMOm2EkHTtWKQuPQ7KY1yzGCaVKByqw1lfUpoeOxDe2g171WcSzOB5D
 ORt0nYI7mvGRScm7ihP7hLFoVnGAjAk5MtKN6piLGDWOMsrhvOL+R2ZzVO0PtDsJbhKNoEtiC
 J909kslibC2UjR0VhtTd9NNYk7QlYfJZDvsRYWjmyMa7cQXIpMwS+Li4ACJFDxGnQ0qoJmaED
 QhhyJVcktK3NYfnFaVhh12A8e35SIXx/G6SncrYCV3VltFjfUAPMtbPaio8qrz5BuKaxI1vMP
 8hB1asZ8NSKq8TQ3ldXn/PDfCRn+YZCNdRpr+S82DbpG97kK2tMXWggu3snfHrk8IMR+z5wr6
 WIYqLvjc9B7MfFDa+JRHW2dxKEFD17JojWrdjLEUdV2pf32YIReGFN/bpGAqhVrxzg9wziEWg
 fj7QyLSGszjSUuY+ynk5oQwbMf3pUe8+vqqCiVIjWaJ0A94JP6mYsOTiXmhL9BJZq3QTHR80e
 mrcSVBZT2z4z5MgERwuDP3ygmy9cuwyyvuLJsuO3+5G2tgQUgJh6PuktURNvOX/g6Uf5BAE3M
 lFhNOlJLuaB7GliVwYqQI2PUyH5o8DhP8DNwm/0+d0Qm8=



=E5=9C=A8 2024/4/8 14:02, Anand Jain =E5=86=99=E9=81=93:
> Btrfs-progs commit 5f87b467a9e7 ("subvolume: output the prompt line only
> when the ioctl succeeded") changed the output for snapshot command,
> updating the golden outputs.
>
> Create a helper filter to ensure the test cases pass on older btrfs-prog=
s.
>
> Another option is to remove the 'btrfs subvolume snapshot' command outpu=
t
> from the golden output and redirect it to /dev/null, but this strays fro=
m
> the bug-fix objective.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: The missed testcases included now.
>      Merged following two patches in v1:
> 	common/filter.btrfs: add a new _filter_snapshot
> 	btrfs: create snapshot fix golden output

Still I do not think this is correct way to go.

3 points for my objection:

- Most test cases are already doing the redirection for "btrfs
   subvolume" command group
   Check my patch's commit message, overall the touched ones are less
   than 25% of all the "btrfs subvolume snapshot" calls.

- Missing handling for "btrfs subvolume delete"
   Sure you can add new filters, but I do not think it's worthy just a
   new filter.

- How to enforce the filters for the future test cases?
   Good luck if you're really pushing everyone to use the new filter.
   On the other hand, it's pretty instintive to just redirect the output.

>
>   common/filter.btrfs | 9 +++++++++
>   tests/btrfs/001     | 3 ++-
>   tests/btrfs/001.out | 2 +-
>   tests/btrfs/152     | 6 +++---
>   tests/btrfs/152.out | 4 ++--
>   tests/btrfs/168     | 6 +++---
>   tests/btrfs/168.out | 4 ++--
>   tests/btrfs/169     | 6 +++---
>   tests/btrfs/169.out | 4 ++--
>   tests/btrfs/170     | 4 ++--
>   tests/btrfs/170.out | 2 +-
>   tests/btrfs/187     | 6 +++---
>   tests/btrfs/187.out | 4 ++--
>   tests/btrfs/188     | 8 ++++----
>   tests/btrfs/188.out | 4 ++--
>   tests/btrfs/189     | 4 ++--
>   tests/btrfs/189.out | 2 +-
>   tests/btrfs/191     | 6 +++---
>   tests/btrfs/191.out | 4 ++--
>   tests/btrfs/200     | 6 +++---
>   tests/btrfs/200.out | 4 ++--
>   tests/btrfs/202     | 4 ++--
>   tests/btrfs/202.out | 2 +-
>   tests/btrfs/203     | 6 +++---
>   tests/btrfs/203.out | 4 ++--
>   tests/btrfs/226     | 4 ++--
>   tests/btrfs/226.out | 2 +-
>   tests/btrfs/276     | 2 +-
>   tests/btrfs/276.out | 2 +-
>   tests/btrfs/280     | 4 ++--
>   tests/btrfs/280.out | 2 +-
>   tests/btrfs/281     | 4 ++--
>   tests/btrfs/281.out | 2 +-
>   tests/btrfs/283     | 4 ++--
>   tests/btrfs/283.out | 2 +-
>   tests/btrfs/287     | 4 ++--
>   tests/btrfs/287.out | 4 ++--
>   tests/btrfs/293     | 4 ++--
>   tests/btrfs/293.out | 4 ++--
>   tests/btrfs/300     | 2 +-
>   tests/btrfs/300.out | 2 +-
>   tests/btrfs/302     | 4 ++--
>   tests/btrfs/302.out | 2 +-
>   tests/btrfs/314     | 2 +-
>   tests/btrfs/314.out | 4 ++--
>   45 files changed, 92 insertions(+), 82 deletions(-)
>
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 9ef9676175c9..7042edf16d2a 100644
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
> +	_filter_testdir_and_scratch | sed -e "s/Create a/Create/g"
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
> diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
> index c782bde96091..c9e32265da6a 100644
> --- a/tests/btrfs/001.out
> +++ b/tests/btrfs/001.out
> @@ -3,7 +3,7 @@ Creating file foo in root dir
>   List root dir
>   foo
>   Creating snapshot of root dir
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   List root dir after snapshot
>   foo
>   snap
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
> diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
> index a95bb5797162..763d38cefe65 100644
> --- a/tests/btrfs/152.out
> +++ b/tests/btrfs/152.out
> @@ -5,8 +5,8 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
>   Create subvolume 'SCRATCH_MNT/recv1_2'
>   Create subvolume 'SCRATCH_MNT/recv2_1'
>   Create subvolume 'SCRATCH_MNT/recv2_2'
> -Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/sub=
vol1/.snapshots/1'
> -Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/sub=
vol2/.snapshots/1'
> +Create readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvo=
l1/.snapshots/1'
> +Create readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvo=
l2/.snapshots/1'
>   At subvol 1
>   At subvol 1
>   At subvol 1
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
> diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
> index 6cfce8cd666c..0eccbc3fc416 100644
> --- a/tests/btrfs/168.out
> +++ b/tests/btrfs/168.out
> @@ -1,9 +1,9 @@
>   QA output created by 168
>   Create subvolume 'SCRATCH_MNT/sv1'
>   At subvol SCRATCH_MNT/sv1
> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
> +Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
>   At subvol SCRATCH_MNT/snap1
> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
> +Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
>   At subvol SCRATCH_MNT/snap2
>   At subvol sv1
>   OK
> diff --git a/tests/btrfs/169 b/tests/btrfs/169
> index 009fdaee7c46..e507692fd0c6 100755
> --- a/tests/btrfs/169
> +++ b/tests/btrfs/169
> @@ -20,7 +20,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   # real QA test starts here
>   _supported_fs btrfs
> @@ -44,7 +44,7 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
>   	     $SCRATCH_MNT/foobar | _filter_xfs_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1=
 2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&=
1 \
>       | _filter_scratch
>
> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRAT=
CH_MNT/snap1 2>&1 \
>   $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2=
 2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap =
\
>   		 $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
>
> diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
> index ba77bf0adbe3..c3467d5162d9 100644
> --- a/tests/btrfs/169.out
> +++ b/tests/btrfs/169.out
> @@ -1,9 +1,9 @@
>   QA output created by 169
>   wrote 1048576/1048576 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   At subvol SCRATCH_MNT/snap1
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   At subvol SCRATCH_MNT/snap2
>   File digest in the original filesystem:
>   d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index ab105d36fb96..50b6fa8654d4 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -12,7 +12,7 @@
>   _begin_fstest auto quick snapshot prealloc
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   # real QA test starts here
>   _supported_fs btrfs
> @@ -46,7 +46,7 @@ md5sum $SCRATCH_MNT/foobar | _filter_scratch
>
>   # Create a snapshot of the subvolume where our file is.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # Cleanly unmount the filesystem.
>   _scratch_unmount
> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
> index 4c5fd87a8b17..ebdf872c7eb2 100644
> --- a/tests/btrfs/170.out
> +++ b/tests/btrfs/170.out
> @@ -3,6 +3,6 @@ wrote 131072/131072 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   File digest after write:
>   85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   File digest after mounting the filesystem again:
>   85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
> diff --git a/tests/btrfs/187 b/tests/btrfs/187
> index d3cf05a1bd92..f0935c9e6516 100755
> --- a/tests/btrfs/187
> +++ b/tests/btrfs/187
> @@ -17,7 +17,7 @@ _begin_fstest auto send dedupe clone balance
>
>   # Import common functions.
>   . ./common/attr
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>
>   # real QA test starts here
> @@ -152,7 +152,7 @@ done
>   wait ${create_pids[@]}
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1=
 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # Add some more files, so that that are substantial differences betwee=
n the
>   # two test snapshots used for an incremental send later.
> @@ -184,7 +184,7 @@ done
>   wait ${setxattr_pids[@]}
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2=
 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   full_send_loop 5 &
>   full_send_pid=3D$!
> diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
> index ab522cfe7e8c..208cfb212b8f 100644
> --- a/tests/btrfs/187.out
> +++ b/tests/btrfs/187.out
> @@ -1,3 +1,3 @@
>   QA output created by 187
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
> diff --git a/tests/btrfs/188 b/tests/btrfs/188
> index fcaf84b15053..feeb4397c234 100755
> --- a/tests/btrfs/188
> +++ b/tests/btrfs/188
> @@ -21,7 +21,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>
>   # real QA test starts here
>   _supported_fs btrfs
> @@ -45,16 +45,16 @@ $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_=
MNT/foobar | _filter_xfs_io
>   $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1=
 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # Now punch a hole that drops all the extents within the file's size.
>   $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
> index 260988e60084..586543cfde61 100644
> --- a/tests/btrfs/188.out
> +++ b/tests/btrfs/188.out
> @@ -1,9 +1,9 @@
>   QA output created by 188
>   wrote 512000/512000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   File digest in the original filesystem:
>   816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
> diff --git a/tests/btrfs/189 b/tests/btrfs/189
> index ec6e56fa0020..244ca84299fa 100755
> --- a/tests/btrfs/189
> +++ b/tests/btrfs/189
> @@ -23,7 +23,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>
>   # real QA test starts here
> @@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/=
baz | _filter_xfs_io
>   $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | _filter_xf=
s_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1=
 \
>   	| _filter_scratch
> diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
> index 79c70b03a1ba..a516167578e4 100644
> --- a/tests/btrfs/189.out
> +++ b/tests/btrfs/189.out
> @@ -7,7 +7,7 @@ wrote 2097152/2097152 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2097152/2097152 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
>   linked 131072/131072 bytes at offset 655360
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/191 b/tests/btrfs/191
> index 3c565d0ad209..9c1fd80b7583 100755
> --- a/tests/btrfs/191
> +++ b/tests/btrfs/191
> @@ -19,7 +19,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>
>   # real QA test starts here
> @@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" $SCRATCH_MN=
T/foo | _filter_xfs_io
>
>   # Create the base snapshot and the parent send stream from it.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysna=
p1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 2=
>&1 \
>   	| _filter_scratch
> @@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" $SCRATCH_MNT/=
bar | _filter_xfs_io
>   # Create the second snapshot, used for the incremental send, before do=
ing the
>   # file deduplication.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysna=
p2 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   # Now before creating the incremental send stream:
>   #
> diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
> index 4269803cce1e..ad4d779814f7 100644
> --- a/tests/btrfs/191.out
> +++ b/tests/btrfs/191.out
> @@ -3,11 +3,11 @@ wrote 524288/524288 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 524288/524288 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>   At subvol SCRATCH_MNT/mysnap1
>   wrote 1048576/1048576 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>   deduped 524288/524288 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   deduped 524288/524288 bytes at offset 524288
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index 5ce3775f2222..3d18165a630f 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -19,7 +19,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>   . ./common/punch
>
> @@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRA=
TCH_MNT/bar \
>   	| _filter_xfs_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1=
 \
>   	| _filter_scratch
> @@ -64,7 +64,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $=
SCRATCH_MNT/bar \
>   	| _filter_xfs_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> index 3eec567e97fe..5c1cd855fa99 100644
> --- a/tests/btrfs/200.out
> +++ b/tests/btrfs/200.out
> @@ -5,11 +5,11 @@ linked 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
>   linked 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   At subvol base
>   At snapshot incr
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
> diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
> index 7f33d49f889c..6b80810e96ed 100644
> --- a/tests/btrfs/202.out
> +++ b/tests/btrfs/202.out
> @@ -1,4 +1,4 @@
>   QA output created by 202
>   Create subvolume 'SCRATCH_MNT/a'
>   Create subvolume 'SCRATCH_MNT/a/b'
> -Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
> +Create snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
> diff --git a/tests/btrfs/203 b/tests/btrfs/203
> index e506118e2cd2..e62f09edb570 100755
> --- a/tests/btrfs/203
> +++ b/tests/btrfs/203
> @@ -20,7 +20,7 @@ _cleanup()
>   }
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>
>   # real QA test starts here
> @@ -44,7 +44,7 @@ _scratch_mount
>   $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | _filte=
r_xfs_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1=
 \
>   	| _filter_scratch
> @@ -70,7 +70,7 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
>   	     $SCRATCH_MNT/foobar | _filter_xfs_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr =
2>&1 \
> -	| _filter_scratch
> +							| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   		 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
> index 58739a98cd1b..59c2564bc61b 100644
> --- a/tests/btrfs/203.out
> +++ b/tests/btrfs/203.out
> @@ -1,7 +1,7 @@
>   QA output created by 203
>   wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
>   wrote 65536/65536 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -15,7 +15,7 @@ wrote 65536/65536 bytes at offset 786432
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   linked 196608/196608 bytes at offset 196608
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   File foobar digest in the original filesystem:
>   2b76b23b62fdbbbcae1ee37eec84fd7d
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 7034fcc7b2a5..f96a832505a4 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -11,7 +11,7 @@
>   _begin_fstest auto quick rw snapshot clone prealloc punch
>
>   # Import common functions.
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>
>   # real QA test starts here
> @@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
>   	     $SCRATCH_MNT/f2 | _filter_xfs_io
>
>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
> -    | _filter_scratch
> +							| _filter_snapshot
>
>   # Write into the range of the first extent so that that range no longe=
r has a
>   # shared extent.
> diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
> index c63982b0ba4a..1855e5255fce 100644
> --- a/tests/btrfs/226.out
> +++ b/tests/btrfs/226.out
> @@ -13,7 +13,7 @@ wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   pwrite: Resource temporarily unavailable
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> index f15f20824350..30799ebe449e 100755
> --- a/tests/btrfs/276
> +++ b/tests/btrfs/276
> @@ -105,7 +105,7 @@ sync
>   echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>
>   # Creating a snapshot.
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _f=
ilter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _f=
ilter_snapshot
>
>   # We have a snapshot, so now all extents should be reported as shared.
>   echo "Number of shared extents in the whole file: $(count_shared_exten=
ts)"
> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> index 352e06b4d4b2..27ea29bdf87b 100644
> --- a/tests/btrfs/276.out
> +++ b/tests/btrfs/276.out
> @@ -1,6 +1,6 @@
>   QA output created by 276
>   Number of non-shared extents in the whole file: 2000
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   Number of shared extents in the whole file: 2000
>   wrote 65536/65536 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/280 b/tests/btrfs/280
> index fc049adb0b19..4957825b7e4b 100755
> --- a/tests/btrfs/280
> +++ b/tests/btrfs/280
> @@ -15,7 +15,7 @@
>   . ./common/preamble
>   _begin_fstest auto quick compress snapshot fiemap
>
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/punch # for _filter_fiemap_flags
>
>   _supported_fs btrfs
> @@ -37,7 +37,7 @@ _scratch_mount -o compress
>   $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xf=
s_io
>
>   # Create a RW snapshot of the default subvolume.
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _f=
ilter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _f=
ilter_snapshot
>
>   echo
>   echo "File foo fiemap before COWing extent:"
> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
> index 5371f3b01551..4f0e5d2287b6 100644
> --- a/tests/btrfs/280.out
> +++ b/tests/btrfs/280.out
> @@ -1,7 +1,7 @@
>   QA output created by 280
>   wrote 134217728/134217728 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>
>   File foo fiemap before COWing extent:
>
> diff --git a/tests/btrfs/281 b/tests/btrfs/281
> index ddc7d9e8b06d..2943998bee20 100755
> --- a/tests/btrfs/281
> +++ b/tests/btrfs/281
> @@ -15,7 +15,7 @@
>   . ./common/preamble
>   _begin_fstest auto quick send compress clone fiemap
>
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>   . ./common/punch # for _filter_fiemap_flags
>
> @@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" $SC=
RATCH_MNT/foo \
>
>   echo "Creating snapshot and a send stream for it..."
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap =
\
> -	| _filter_scratch
> +	| _filter_snapshot
>   $BTRFS_UTIL_PROG send --compressed-data -f $send_stream $SCRATCH_MNT/s=
nap 2>&1 \
>   	| _filter_scratch
>
> diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
> index 2585e3e567db..49c23a00baea 100644
> --- a/tests/btrfs/281.out
> +++ b/tests/btrfs/281.out
> @@ -6,7 +6,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/se=
c)
>   linked 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Creating snapshot and a send stream for it...
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   At subvol SCRATCH_MNT/snap
>   Creating a new filesystem to receive the send stream...
>   At subvol snap
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> index 118df08b8958..d9b8c1d24b8f 100755
> --- a/tests/btrfs/283
> +++ b/tests/btrfs/283
> @@ -11,7 +11,7 @@
>   . ./common/preamble
>   _begin_fstest auto quick send clone fiemap
>
> -. ./common/filter
> +. ./common/filter.btrfs
>   . ./common/reflink
>   . ./common/punch # for _filter_fiemap_flags
>
> @@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" $SCRAT=
CH_MNT/foo | _filter_xfs_i
>
>   echo "Creating snapshot and a send stream for it..."
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap =
\
> -	| _filter_scratch
> +	| _filter_snapshot
>
>   $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | _filter=
_scratch
>
> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> index 286dae332eff..37f425bf8312 100644
> --- a/tests/btrfs/283.out
> +++ b/tests/btrfs/283.out
> @@ -4,7 +4,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/se=
c)
>   wrote 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Creating snapshot and a send stream for it...
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   At subvol SCRATCH_MNT/snap
>   Creating a new filesystem to receive the send stream...
>   At subvol snap
> diff --git a/tests/btrfs/287 b/tests/btrfs/287
> index 64e6ef35250c..dec812760917 100755
> --- a/tests/btrfs/287
> +++ b/tests/btrfs/287
> @@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
>
>   # Now create two snapshots and then do some queries.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1=
 \
> -	| _filter_scratch
> +	| _filter_snapshot
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2=
 \
> -	| _filter_scratch
> +	| _filter_snapshot
>
>   snap1_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
>   snap2_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
> index 30eac8fa444c..5798ec5d7c55 100644
> --- a/tests/btrfs/287.out
> +++ b/tests/btrfs/287.out
> @@ -41,8 +41,8 @@ resolve first extent +3M offset with ignore offset opt=
ion:
>   inode 257 offset 16777216 root 5
>   inode 257 offset 8388608 root 5
>   inode 257 offset 2097152 root 5
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   resolve first extent:
>   inode 257 offset 16777216 snap2
>   inode 257 offset 8388608 snap2
> diff --git a/tests/btrfs/293 b/tests/btrfs/293
> index 06f96dc414b0..fffdcd53441a 100755
> --- a/tests/btrfs/293
> +++ b/tests/btrfs/293
> @@ -32,9 +32,9 @@ swap_file=3D"$SCRATCH_MNT/swapfile"
>   _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqres.ful=
l
>
>   echo "Creating first snapshot..."
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 =
| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 =
| _filter_snapshot
>   echo "Creating second snapshot..."
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _=
filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _=
filter_snapshot
>
>   echo "Activating swap file... (should fail due to snapshots)"
>   _swapon_file $swap_file 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
> index fd04ac9139b8..7b2947a705e7 100644
> --- a/tests/btrfs/293.out
> +++ b/tests/btrfs/293.out
> @@ -1,8 +1,8 @@
>   QA output created by 293
>   Creating first snapshot...
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   Creating second snapshot...
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   Activating swap file... (should fail due to snapshots)
>   swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
>   Deleting first snapshot...
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> index 8a0eaecf87f7..00ffcb82eae6 100755
> --- a/tests/btrfs/300
> +++ b/tests/btrfs/300
> @@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
>   touch subvol/{1,2,3};
>   $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
>   touch subvol/subsubvol/{4,5,6};
> -$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot | sed -e 's/Create =
a/Create/g';
>   "
>
>   find $test_dir/. -printf "%M %u %g ./%P\n"
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> index 6e94447e87ac..06a75bff5ce1 100644
> --- a/tests/btrfs/300.out
> +++ b/tests/btrfs/300.out
> @@ -1,7 +1,7 @@
>   QA output created by 300
>   Create subvolume './subvol'
>   Create subvolume 'subvol/subsubvol'
> -Create a snapshot of 'subvol' in './snapshot'
> +Create snapshot of 'subvol' in './snapshot'
>   drwxr-xr-x fsgqa fsgqa ./
>   drwxr-xr-x fsgqa fsgqa ./subvol
>   -rw-r--r-- fsgqa fsgqa ./subvol/1
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
> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
> index 8770aefc99c8..c08f8c135538 100644
> --- a/tests/btrfs/302.out
> +++ b/tests/btrfs/302.out
> @@ -1,4 +1,4 @@
>   QA output created by 302
>   Create subvolume 'SCRATCH_MNT/subvol'
> -Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subv=
ol/snap'
> +Create readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol=
/snap'
>   OK
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 887cb69eb79c..598af611d249 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -43,7 +43,7 @@ send_receive_tempfsid()
>
>   	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>   	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
> -						_filter_testdir_and_scratch
> +							_filter_snapshot
>
>   	echo Send ${src} | _filter_testdir_and_scratch
>   	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
> index 21963899c2b2..d29fe51b3ff9 100644
> --- a/tests/btrfs/314.out
> +++ b/tests/btrfs/314.out
> @@ -3,7 +3,7 @@ QA output created by 314
>   From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
>   wrote 9000/9000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   Send SCRATCH_MNT
>   At subvol SCRATCH_MNT/snap1
>   Receive TEST_DIR/314/tempfsid_mnt
> @@ -14,7 +14,7 @@ Recv:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/t=
empfsid_mnt/snap1/foo
>   From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
>   wrote 9000/9000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/=
314/tempfsid_mnt/snap1'
> +Create readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/31=
4/tempfsid_mnt/snap1'
>   Send TEST_DIR/314/tempfsid_mnt
>   At subvol TEST_DIR/314/tempfsid_mnt/snap1
>   Receive SCRATCH_MNT

