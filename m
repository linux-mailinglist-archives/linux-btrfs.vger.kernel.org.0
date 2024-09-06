Return-Path: <linux-btrfs+bounces-7873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F076696F1B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 12:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA39F284E5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D81C9EDB;
	Fri,  6 Sep 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qlji8VQ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B91C8FC7;
	Fri,  6 Sep 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619150; cv=none; b=cupDJAh9m+qFon3XdyYVuN3EyvUEKFEI60v40nzt77TBn/gAmHiu+f+NJgWJXlA3PAGwp13yEhIAKfWnpVBPkUA3sZ0mQ5joWRnJbXHPWxxaBJpzqX1ynJBOGcJpFLiSBrCcFoj5+cyOYKSZBjcnPfbSB6tOWW9nfosJHkHAj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619150; c=relaxed/simple;
	bh=MdWiRZfqV3txf8wAMM24OuAa7HVxR/anTE9Ew+X8MVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQDhKRS50zm7ik951WnwqlXsUtGGkjdODmJDk9o2aG0nhiMBKzUeoC2twaUFosewj4utzYJCpg4BLnedbu5xHXSaMeAfaYuzs2nFIboy10JPnVI+uAv/M4SgJeFo9BuNKvilikW6R4gFnQ0L+b46S258vAVMJH2ikv7OPpJT/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qlji8VQ7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725619141; x=1726223941; i=quwenruo.btrfs@gmx.com;
	bh=ZvZqIw6aShSQU+/Fr1eCITd1crLIQK/srXxoyacNjy4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qlji8VQ7cFLIzuFaUb7NM0osXM/ST5q6HE5qk4ouFjzicis4dayjHgSQnHImWB97
	 x8QsvXX2onnBU1cuC3U2JlsHtS9o1UrSzVK7ryk/tzutDfQAVqmYnJax3QbGv8BMy
	 RNu0QM6b4684z+CK5gsiF2R4wqz3kEYYilL9aQ+yRNARlIrmwsvZhOhSxa+n8BGvt
	 3SwWI1u+rNIvU1SaGBMFHG3hxFrq981nG7ltc1lb74NL7qUmksq/tUVtjTkpb/Eg6
	 Rjfy2tyDtWt/wD76iqcIAMfNjsQ+pGbttO6TDbZLD7hJaqx/UJ+oTK+hObA2cDUnh
	 /HtoCdToOFgCR9uKTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1shH2n1hlN-00844T; Fri, 06
 Sep 2024 12:39:00 +0200
Message-ID: <21f138f8-7824-4570-b409-d773bcc7c1fa@gmx.com>
Date: Fri, 6 Sep 2024 20:08:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/319: make the test work when compression is used
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
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
In-Reply-To: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MpYsA/l072hEP+USEI8JTJ6hIWlkqPlz8GXpVedDUNARnm318O9
 D2JFoJriHGQjbBSY4T3dR69PNKzfRHF5wuhkk0JD9x/5Aos0bF1yAODVzcvxkULFQBreaJo
 zxKhS6aV+wZscGqlIbx00Oyeh8eRDEAOgYd9Uhq8Irv3mX3nOPoI9MxmJplLH2T+klXmVBN
 9PlZkMfJvLZb/+DkhgI1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0QdvaY9uIs4=;ndXEzreJ3W0Jdq+8aj6HEw8WM3R
 6EtHAQVDwTE9bSVx7177MYFlcP9hmcv8BTu79y2cVOxPw9nLyqibjiIpZUn2RT+UgukOvRA3v
 /ODmepGxs4LBHpvoHaHOH7fMBLLc48r9Dmbr9XHRMn94SOVHODNvMG3mWmXj3gVR8sbPuHuZy
 /RLzWRHdTWgPCQjA1UXpdxbxZO6FU73ex58Kvdc0p3EWmJVdgC9BLDrR2ENK1cFC2l1VSKXvb
 ku4BWb4SdWWWPUBvyBi/Wq1etek2oWkt9S5UL3wDSock1R7X3FqxazBSwScTDxt0C9jJXrb6n
 luB6i94YlQP71xpSDoZgi133kSEs4ZhgWZNoLHwG682M8bOaxHyamRbkEN0tdnwSUjEyjOZtt
 kl1pvj+Z2R2F1zcqOmD3v9PnuhsiGaD8mb4frHNgNOHD4yqCX420t+/L3zTDs57d4BvgBL8+R
 R9zr3Spxjr77Zdz80OYsx97Qzy1RhCQMOxQ/XyEJqY6SHrs0dxOTIovld3u5sFrQk1GO9lA5v
 DMO4xm6FbAkzU01t+5wVbbr2g3aOAXZmXxb6CgEW6rPFuDrvHw3aFmIHYXj8kdwfKFu37zOkr
 gRjqiIzrb32n1WrjhHfc46RZSD0OO9YJlW/8sccEOkviwjC/wAxHEgg23nQwHaG9FhaylhRAS
 /J7DPtNoZP4q3QmCTResYnX4MGpiDiEugRg1JqYHnFG0qfhUGRKObnevS6ZXU+RvTou4DPRds
 B1bKDfqUh4SrUMTwPljpyjOg9Oss4qIuUh++t9X2gpVxDj1JtbA5jTTlsp/7ua+9yK4EvladU
 8Qf3BGfaw7/AkQTY6jGB5YXDS9lZ/LzfCrf3NCzq5F8ak=



=E5=9C=A8 2024/9/6 01:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently btrfs/319 assumes there is no compression and that the files
> get a single extent (1 fiemap line) with a size of 1048581 bytes. Howeve=
r
> when testing with compression, for example by passing "-o compress" to
> MOUNT_OPTIONS environment variable, we get several extents and two lines
> of fiemap output, which makes the test fail since it hardcodes the fiema=
p
> output:
>
>    $ MOUNT_OPTIONS=3D"-o compress" ./check btrfs/319
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc6-btrfs-next-173+ #1 S=
MP PREEMPT_DYNAMIC Tue Sep  3 17:40:24 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scra=
tch_1
>
>    btrfs/319 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstes=
ts/results//btrfs/319.out.bad)
>        --- tests/btrfs/319.out	2024-08-12 14:16:55.653383284 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad	20=
24-09-05 15:24:53.323076548 +0100
>        @@ -6,11 +6,13 @@
>         e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>         e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
>         File bar fiemap in the original filesystem:
>        -0: [0..2055]: shared|last
>        +0: [0..2047]: shared
>        +1: [2048..2055]: shared|last
>         Creating a new filesystem to receive the send stream...
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/319.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad'  to see the e=
ntire diff)
>
>    HINT: You _MAY_ be missing kernel fix:
>          46a6e10a1ab1 btrfs: send: allow cloning non-aligned extent if i=
t ends at i_size
>
>    Ran: btrfs/319
>    Failures: btrfs/319
>    Failed 1 of 1 tests
>
> So change the test to not rely on the fiemap output in its golden output
> and instead just check if all the extents reported by fiemap have the
> shared flag set (failing if there are any without the shared flag).

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one minor improvement to make debug a little easier.

>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/319     | 19 +++++++++++++++----
>   tests/btrfs/319.out |  4 ----
>   2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tests/btrfs/319 b/tests/btrfs/319
> index 975c1497..7cfd3d00 100755
> --- a/tests/btrfs/319
> +++ b/tests/btrfs/319
> @@ -32,6 +32,19 @@ _require_odirect
>   _fixed_by_kernel_commit 46a6e10a1ab1 \
>   	"btrfs: send: allow cloning non-aligned extent if it ends at i_size"
>
> +check_all_extents_shared()
> +{
> +	local file=3D$1
> +	local fiemap_output
> +
> +	fiemap_output=3D$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_fiema=
p_flags)

Maybe also save the full unfiltered output to seqres.full?

Thanks,
Qu

> +	echo "$fiemap_output" | grep -qv 'shared'
> +	if [ $? -eq 0 ]; then
> +		echo -e "Found non-shared extents for file $file:\n"
> +		echo "$fiemap_output"
> +	fi
> +}
> +
>   send_files_dir=3D$TEST_DIR/btrfs-test-$seq
>   send_stream=3D$send_files_dir/snap.stream
>
> @@ -58,8 +71,7 @@ echo "File digests in the original filesystem:"
>   md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
>   md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
>
> -echo "File bar fiemap in the original filesystem:"
> -$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_f=
lags
> +check_all_extents_shared "$SCRATCH_MNT/snap/bar"
>
>   echo "Creating a new filesystem to receive the send stream..."
>   _scratch_unmount
> @@ -72,8 +84,7 @@ echo "File digests in the new filesystem:"
>   md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
>   md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
>
> -echo "File bar fiemap in the new filesystem:"
> -$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_f=
lags
> +check_all_extents_shared "$SCRATCH_MNT/snap/bar"
>
>   # success, all done
>   status=3D0
> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> index 14079dbe..18a50ff8 100644
> --- a/tests/btrfs/319.out
> +++ b/tests/btrfs/319.out
> @@ -5,12 +5,8 @@ Creating snapshot and a send stream for it...
>   File digests in the original filesystem:
>   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> -File bar fiemap in the original filesystem:
> -0: [0..2055]: shared|last
>   Creating a new filesystem to receive the send stream...
>   At subvol snap
>   File digests in the new filesystem:
>   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> -File bar fiemap in the new filesystem:
> -0: [0..2055]: shared|last

