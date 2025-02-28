Return-Path: <linux-btrfs+bounces-11950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECAA4A4D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFA4171F03
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52AC23F390;
	Fri, 28 Feb 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NiMqrzkr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3F23F365;
	Fri, 28 Feb 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777367; cv=none; b=YXRZjFkgTKj8Fh/kftXeayziY8VHffGf4j6YaewCWgTOrhJKrheaTxPMgi7eD7yWJE2oPFrCG5MGoWDFUhaEcWqfyxVsLz/5UMROZBhOf9qH4a+c7rEbZoJcLB7SlC8aw14GpGfxAfuWme4T4p83H270cKTgxzUqfU8VoP61vOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777367; c=relaxed/simple;
	bh=a0xsMwnhp4d524e7S6gVV3AdSGHmRPMbIDcgks6Mgrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC9g9jkwyu1FD82wXSjP0yDm4w1BIT8BYfrY5/DtvuXKG61ID08efO0KNCBsV9SwUylE743dx3/M/VtgRhGYz9bNvoAFKlHnr3mXom9B2Iz9h5peXVjGJkpB9MBUm9C9DIHByIsRRAYZNbk2ItlkmavZ+FxAGYLvFXm3H9u3ahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NiMqrzkr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740777362; x=1741382162; i=quwenruo.btrfs@gmx.com;
	bh=W/I7tl/jnGVSXWhVPIDLDjjWwH/80honMUZgn7yLpFo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NiMqrzkr07DxtDmdoWJ2XVwyOHR9E2qS11WmFhryvdn+fxElKarXJC3KNea1rkcn
	 59NPY+9FaAe0mj3NydWBG1akA6IIv4FjR1ALEh5oe28DDIZLeAQmGjoJ7ute5Xf2Y
	 rtoVjJz7SeZtaM2hA2ByPPp5vYXdR7I2mEzTOX40XktydgCEDJIS9X7AmgYpMcHFz
	 NvWWWiBZ9+6EYqFvFwWYSHrIzVDFZ+YvHD3OPe5a0e00s/05XV6UUhTLFmN+/pyIA
	 c6s3fzzyPSh7NqlR9i3c191JFEGBeQnXf9skuRGGk1dU7ejquSpjw/YWJ8Ze6qEsf
	 6NiJB7XypurGuNhuzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1tWJc11Hvv-00VtZK; Fri, 28
 Feb 2025 22:16:02 +0100
Message-ID: <8cdc4be8-f1ad-4baa-beab-c22b0ca0832c@gmx.com>
Date: Sat, 1 Mar 2025 07:45:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/080: fix sporadic failures starting with kernel
 6.13
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 Glass Su <glass.su@suse.com>
References: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
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
In-Reply-To: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xpdrY1Temwo9gMnjKBvp0FqOtyKWFqz27009RKb4lyB8HE5Nfb6
 6//Aw4otH9zn1Ag8CQAM9V/d46wB0Qb8DccLhPgHbYqxn+1nl8TGYBJK5cBQgjPQQKPcKRv
 BetWh5WRXkP1Nnu3bOgvDaD3CSz1mTbQ3Yeupuu6De8hem6V2GEJ5BpR25nkFaURWugowul
 rDcB+z61/E8Tl3d3eM2AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YmN6e7K23BQ=;rcESaB4k/N324STnMi4pBvMWNqg
 eICkh+kOZl2L4t+JhnERCKQMrswLjTQmZzGVQfpZTfRvvT6CGo5z2OFxU20SfPfyf6/BUWZzt
 57hc9QnpHsSZttylDopry0RQ7ffWRQ0FVW/Z582WlJFzmZxi3AWSj7hv8ykPBobOpAoedy1q+
 1CQ7+TyionfklNzKfzoAXnv8/7izJUzsARl7CqbNN1dR1vQHj8PGL0M3TqaqLiDroX0HZ20DD
 tJM1I6Wex++BLJuVKZ9p0m/ptiidDRgcYDwWfr69cakRg0yfvAU0IlpjI8WhhKd+Ntbt57kco
 ZUTyzdTrt/Hnw3BATBrUxGQ8XB/0A4Atf2eiXOe/F2iyy1/80BeBXxXZn6emnyesoo/P4PBOL
 aLyJqY7U51846SAAdbil1uzrOsG1dtUmjEy5uE5ji3Dh9xX7lAnZ0/mbDAuLvcaSvE6h4p/tH
 Wp6AsZDf41390JTJ/3pwTAUj+QT+vSuo8Hm5b2prD5dymxhY3O3DvRTLuOMDpMbWBL03zhMDC
 +6Hvai0RPuvs3i0bh2NDoHwQ4hDhNzYTZgMMxYS6Q7anT6cU7lJnl8bP1gltAw8W6ag4k9zNw
 O7t+pFNHwvBrjbzZUzhuzigItH0L56NvBEpD+CXr/Zo9PpbnLzf+VRAa1SlSI4DOC+f3zIlcy
 g7EdgxhuZknTuFHkagGkuUu9XEVF/W54iaFFWZZuc2xW/F9l+n7Oemn1oGXC7J4tVsSw+NfQv
 gzoKTwiEF7LMWy6gSMrXlYmZ3ABgrpcAQIQjzTlP6793UfMhrJAS2JHU8rIE0QD7doYOVtA80
 5OMe2mRCC69hczSoFKUHgiwkl9lkKnqW4kLHSEsdTqU9VZ86pkn3VEqCki9c6Z4d4T4r1An5H
 +sNfh8vzKTeYb3ZMzhjlZFlVtwWjj68Rg+UVQKrCCwvNb41pb5CSjLAQjDy259H1OBpcxyHig
 7gB5Q/sPBdAeYdFMSAdkqx/GsOdG52TErYc5LVikd3xjuNm02uKli97KF1gTZK2G2cZUsbsG+
 IXrPoiqVMvBk3ZgiYaihSqJnXdZtN4AO1bDFG3cpKxFyiCbYX4rybutJ9m2FZIU+jVcSJXBAq
 NQyh6m3clSpApamnvWkPMPCSyWRcfn30v+ZO6TrT6AYLS4tHNWh8+gZDiQCgSr1nPhDNi9Noy
 XwTCmuxTc8tyQdJ6vILNTr7IrMuGwxItdne4NqDi3kInojtrx4+VBucSsDPWfN6u7CYeyai1C
 cFrfzDJ6jn9zohZbYJIgDIhfnCpDbAIBAc386urMKAKHELRGu2u/HPuwiwtkifqcUW9YERxeP
 8dEXddA01f1YUiZNZlFraN/3JMtdb5ibqv+naG1eBCTTrNK0w2VzWTC7XzQuuNwPKW0TgDlu8
 x6oI/DaO899I5gANLK+lcYU+9/KfgAmTnfybF97D2Jns614DtxCsiEzB1I



=E5=9C=A8 2025/3/1 02:57, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Since kernel 6.13, namely since commit c87c299776e4 ("btrfs: make buffer=
ed
> write to copy one page a time"), the test can sporadically fail with an
> unexpected digests for files in snapshots. This is because after that
> commit the pages for a buffered write are prepared and dirtied one by on=
e,
> and no longer in batches up to 512 pages (on x86_64)

Minor nitpicks, the original limit of pages is 8:

	nrptrs =3D max(nrptrs, 8);
	pages =3D kmalloc_array(nrptrs, sizeof(struct page *),
                               GFP_KERNEL);

I'm not sure if it's a coincident or not, but the first 32K writes
matches the pages limit perfectly (for x86_64).

Meanwhile the second 32770 write is possible to be split even with the
older code, but it should be super rare to hit.

>, so a snapshot that
> is created in the middle of a buffered write can result in a version of
> the file where only a part of a buffered write got caught, for example i=
f
> a snapshot is created while doing the 32K write for file range [0, 32K),
> we can end up a file in the snapshot where only the first 8K (2 pages) o=
f
> the write are visible, since the remaining 24K were not yet processed by
> the write task. Before that kernel commit, this didn't happen since we
> processed all the pages in a single batch and while holding the whole
> range locked in the inode's io tree.

This means no matter the buffered io buffer size, it's the filesystems'
behavior determining if such a buffered write will be split.

Maybe it's not that a huge deal, as the original behavior will also
break the buffered io block size, just with a larger value (8 pages
other than 1).

>
> This is easy to observe by adding an "od -A d -t x1" call to the test
> before the _fail statement when we get an unexpected file digest:
>
>    $ ./check btrfs/080
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 S=
MP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
>    btrfs/080 32s ... [failed, exit status 1]- output mismatch (see /home=
/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad)
>        --- tests/btrfs/080.out	2020-06-10 19:29:03.814519074 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad	20=
25-02-27 17:12:08.410696958 +0000
>        @@ -1,2 +1,6 @@
>         QA output created by 080
>        -Silence is golden
>        +0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>        +*
>        +0008192
>        +Unexpected digest for file /home/fdmanana/btrfs-tests/scratch_1/=
17_11_56_146646257_snap/foobar_50
>        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/080.full for=
 details)
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/080.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad'  to see the e=
ntire diff)
>    Ran: btrfs/080
>    Failures: btrfs/080
>    Failed 1 of 1 tests
>
> The files are created like this while snapshots are created in parallel:
>
>      run_check $XFS_IO_PROG -f \
>          -c "pwrite -S 0xaa -b 32K 0 32K" \
>          -c "fsync" \
>          -c "pwrite -S 0xbb -b 32770 16K 32770" \
>          -c "truncate 90123" \
>          $SCRATCH_MNT/$name
>
> So with the kernel behaviour before 6.13 we expected the snapshot to
> contain any of the following versions of the file:
>
> 1) Empty file;
>
> 2) 32K file reflecting only the first buffered write;
>
> 3) A file with a size of 49154 bytes reflecting both buffered writes;
>
> 4) A file with a size of 90123 bytes, reflecting the truncate operation
>     and both buffered writes.
>
> So now the test can fail since kernel 6.13 due to snapshots catching
> partial writes.
>
> However the goal of the test when I wrote it was to verify that if the
> snapshot version of a file gets the truncated size, then the buffered
> writes are visible in the file, since they happened before the truncate
> operation - that is, we can't get a file with a size of 90123 bytes that
> doesn't have the range [0, 16K) full of bytes with a value of 0xaa and
> the range [16K, 49154) full of bytes with the 0xbb value.
>
> So update the test to the new kernel behaviour by verifying only that if
> the file has the size we truncated to, then it has all the data we wrote
> previously with the buffered writes.
>
> Reported-by: Glass Su <glass.su@suse.com>
> Link: https://lore.kernel.org/linux-btrfs/30FD234D-58FC-4F3C-A947-47A5B6=
972C01@suse.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for the detailed analyze and the fix.

Thanks,
Qu

> ---
>   tests/btrfs/080 | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/tests/btrfs/080 b/tests/btrfs/080
> index ea9d09b0..aa97d3f6 100755
> --- a/tests/btrfs/080
> +++ b/tests/btrfs/080
> @@ -32,6 +32,8 @@ _cleanup()
>
>   _require_scratch_nocheck
>
> +truncate_offset=3D90123
> +
>   create_snapshot()
>   {
>   	local ts=3D`date +'%H_%M_%S_%N'`
> @@ -48,7 +50,7 @@ create_file()
>   		-c "pwrite -S 0xaa -b 32K 0 32K" \
>   		-c "fsync" \
>   		-c "pwrite -S 0xbb -b 32770 16K 32770" \
> -		-c "truncate 90123" \
> +		-c "truncate $truncate_offset" \
>   		$SCRATCH_MNT/$name
>   }
>
> @@ -81,6 +83,12 @@ _scratch_mkfs "$mkfs_options" >>$seqres.full 2>&1
>
>   _scratch_mount
>
> +# Create a file while no snapshotting is in progress so that we get the=
 expected
> +# digest for every file in a snapshot that caught the truncate operatio=
n (which
> +# sets the file's size to $truncate_offset).
> +create_file "gold_file"
> +expected_digest=3D`_md5_checksum "$SCRATCH_MNT/gold_file"`
> +
>   # Run some background load in order to make the issue easier to trigge=
r.
>   # Specially needed when testing with non-debug kernels and there isn't
>   # any other significant load on the test machine other than this test.
> @@ -103,24 +111,20 @@ for ((i =3D 0; i < $num_procs; i++)); do
>   done
>
>   for f in $(find $SCRATCH_MNT -type f -name 'foobar_*'); do
> -	digest=3D`md5sum $f | cut -d ' ' -f 1`
> -	case $digest in
> -	"d41d8cd98f00b204e9800998ecf8427e")
> -		# ok, empty file
> -		;;
> -	"c28418534a020122aca59fd3ff9581b5")
> -		# ok, only first write captured
> -		;;
> -	"cd0032da89254cdc498fda396e6a9b54")
> -		# ok, only 2 first writes captured
> -		;;
> -	"a1963f914baf4d2579d643425f4e54bc")
> -		# ok, the 2 writes and the truncate were captured
> -		;;
> -	*)
> -		# not ok, truncate captured but not one or both writes
> -		_fail "Unexpected digest for file $f"
> -	esac
> +	file_size=3D$(stat -c%s "$f")
> +	# We want to verify that if the file has the size set by the truncate
> +	# operation, then both delalloc writes were flushed, and every version
> +	# of the file in each snapshot has its range [0, 16K) full of bytes wi=
th
> +	# a value of 0xaa and the range [16K, 49154) is full of bytes with a
> +	# value of 0xbb.
> +	if [ "$file_size" -eq "$truncate_offset" ]; then
> +		digest=3D`_md5_checksum "$f"`
> +		if [ "$digest" !=3D "$expected_digest" ]; then
> +			echo -e "Unexpected content for file $f:\n"
> +			_hexdump "$f"
> +			_fail "Bad file content"
> +		fi
> +	fi
>   done
>
>   # Check the filesystem for inconsistencies.


