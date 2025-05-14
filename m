Return-Path: <linux-btrfs+bounces-13988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BEAB608A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 03:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1552719E4B49
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0BC1D95A9;
	Wed, 14 May 2025 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oik1xhwn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA028EC;
	Wed, 14 May 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187278; cv=none; b=SRcOCcuCb4A7bZy07MbWul+5H3W0dF1KYpjo541lDxSIbGWCF0s17MVTJaA6zye+0aMOzK64+uaxGf6gN/b+VfYs0TOQgFWlYAMuP2x2Mt8OVNjta9YLG+055N6V63s3Zw2Jwlp1+AQ6KkCSEZ439ZPCdZvT+UT5lr+N0b7svQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187278; c=relaxed/simple;
	bh=KXM3+X13MchzGYAvgOcUpGactumqcTgDnUgE4Rx7huo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqau87ulzw7OaDxOsKkAY6SalrwuGOyy2kyEQyka9sfbOkFnb81xdwiND2nz4xIkHQFxJmxdFjyJbqZ+2xxveVlJyIFFdg4qaVHFt6Yy8lE7+mg2LJEWcY1/xnZOIQlP9i0DiXYi1x6Hhyc/A9U0oDajcTZMM+tKn1fGL+hGQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oik1xhwn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747187274; x=1747792074; i=quwenruo.btrfs@gmx.com;
	bh=SEDWYJjdiR94EAKAfPlOo7X6CXDAAihOXvMCEApid+M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oik1xhwnHVwLeyvKjDx+FJDWNlF9Ju9t7AWBYizSxjz8yPJU9LyPz2+wvUmJ3/00
	 P0C8f46L6LqOTO8BLIIzwZ9y+uN4/OvCwiMgfXnDUzdczLZHoyDd7oI74NGLey/yF
	 Jrgza7QfJbE5xUkvxXwMk5LKKHGAwCNVI0tqXeHzAVVVJfDKtxxa7nD9tB2Eb8Wjq
	 GJMj9GuO78VCRevgstZPuY8VHVI+2+b/iKsF0lebrbmOI8qCvalLopOls28nc2zo7
	 doH8VxXdMos9TmWadIy3CkQDOu/0B5+I4ExQQUITSz4J5vVNVT5N1/X9SBL74RYoe
	 uZRukesM+qrdh12BKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacOQ-1upjgR15xq-00ear2; Wed, 14
 May 2025 03:47:53 +0200
Message-ID: <6c89137d-a835-447a-90db-da7b5e78263b@gmx.com>
Date: Wed, 14 May 2025 11:17:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/336: misc extra fixes for the testcase
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <9c9683df7928397142cb345ac5bbef2456972bf7.1747185899.git.anand.jain@oracle.com>
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
In-Reply-To: <9c9683df7928397142cb345ac5bbef2456972bf7.1747185899.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JIey5ht4lE6OhsgU93CYO6qHDW/PZoOau0Llq0+7oO7hMOGoHOZ
 H+EKUZaoqaXI2Yv43zU1UfoxavJEVPnmTiraVUvMxm0xx+Hq6iUgBKX3QMs2VMR55+wO3pN
 Yisuyr9Fdxy8GqDh7ZlVV4D9JPEvu4IIzpq82jq0ZjIPTi4GNznZ1yK4heNxtiFUO2cpUQN
 xXHCjL2OxkJVNLYB3G87Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CmFDb7do74o=;lG6z97sPrdQQR7OAHDCsZTFdqK8
 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
 ZTQy7rQrEO+UM=



=E5=9C=A8 2025/5/14 11:05, Anand Jain =E5=86=99=E9=81=93:
>    Along with adding group dangerous..
>    Fix the fixed_by_kernel_commit with the correct commit.
>    Use the golden output to check for the expected error.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Qu, This change is big for the last minute merge time fixes for the
> testcase with rbs. Pls review.
>=20
>   tests/btrfs/336     | 25 +++++++++++++------------
>   tests/btrfs/336.out |  3 ++-
>   2 files changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/btrfs/336 b/tests/btrfs/336
> index f6691bae6bbc..503ff03b377a 100755
> --- a/tests/btrfs/336
> +++ b/tests/btrfs/336
> @@ -8,10 +8,12 @@
>   # rescue=3Didatacsums mount option
>   #
>   . ./common/preamble
> -_begin_fstest auto scrub quick
> +_begin_fstest auto scrub quick dangerous
>  =20
> -_fixed_by_kernel_commit 6aecd91a5c5b \
> -	"btrfs: avoid NULL pointer dereference if no valid extent tree"
> +. ./common/filter
> +
> +_fixed_by_kernel_commit f95d186255b3 \
> +	"btrfs: avoid NULL pointer dereference if no valid csum tree"

My bad, wrong commit. I'm totally fine with the fix on the group and fix=
=20
commit.

>  =20
>   _require_scratch
>   _scratch_mkfs >> $seqres.full
> @@ -19,16 +21,15 @@ _scratch_mkfs >> $seqres.full
>   _try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null 2>&1 |=
|
>   	_notrun "rescue=3Dignoredatacsums mount option not supported"
>  =20
> -# For unpatched kernel this will cause NULL pointer dereference and cra=
sh the kernel.
> -$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
> -# For patched kernel scrub will be gracefully rejected.
> -if [ $? -eq 0 ]; then
> -	echo "read-only scrub should fail but didn't"
> -fi
> -
> -_scratch_unmount
> +filter_scrub_error()
> +{
> +	grep -E "ERROR|Status" | _filter_scratch
> +}

Again I prefer not to catch exact error.

The output message has changed in btrfs-progs commit e578b59bf612=20
("btrfs-progs: convert strerror to implicit %m").

And there is no guarantee it will not change again, nor the kernel may=20
change the error number/behavior, I just prefer not to play the filter=20
game on something non-critical.

To me the current make-sure-it-fails behavior is already good enough,=20
and more future proof.

Thanks,
Qu

>  =20
> -echo "Silence is golden"
> +# For a patched kernel, scrub will be gracefully rejected. However, for
> +# an unpatched kernel, this will cause a NULL pointer dereference and
> +# crash the kernel.
> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT 2>&1 | filter_scrub_error
>  =20
>   # success, all done
>   status=3D0
> diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
> index 9263628ee7e8..63b53ef43650 100644
> --- a/tests/btrfs/336.out
> +++ b/tests/btrfs/336.out
> @@ -1,2 +1,3 @@
>   QA output created by 336
> -Silence is golden
> +ERROR: scrubbing SCRATCH_MNT failed for device id 1: ret=3D-1, errno=3D=
117 (Structure needs cleaning)
> +Status:           aborted

