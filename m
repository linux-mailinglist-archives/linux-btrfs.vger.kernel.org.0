Return-Path: <linux-btrfs+bounces-15775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F08B16949
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153EF565937
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F923816A;
	Wed, 30 Jul 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="r7m+6TDP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51601236A9C;
	Wed, 30 Jul 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918205; cv=none; b=IqGI7NljsaeawXQQ9DTQa87B8IfWK1YfxYvTtZoLohfIS5LNFwkTUzBTunnuLFmPO8J3F5oZ8NgAJJJoCwK6LLgXTWEhLvHsJqPsDkbsSj9tmOlecJSabmkTUpjXtnrb2i5jnaoL8faVwe4E8zcuZLJ4M2MKZ1rmQHjHkeGfxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918205; c=relaxed/simple;
	bh=1v6AwnuCbj1sm3t1gBOWBrdEAMzAe7A3+mVQJnmsa8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jnsua0Opn1ame2RdtXUBR8LI4ZxV7iR8mUssp0SysYHbjcgEcU62eUT7oaLjJ8PcVMfkcEgOhE3PrGMRxBT732CTXGPwWeDgLkVwm8dvcOWvuTtZAy2rY5BpStapCL2H+BzzOWn3AfpiaSnAoipr9vIsPOuwVJg2j7ILoa0zAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=r7m+6TDP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753918197; x=1754522997; i=quwenruo.btrfs@gmx.com;
	bh=AnRSaqYsOL4mCKVFqxEaDZN2YYX9lVH/7DOZOCTdl6U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r7m+6TDPgn4uWtCY6mYLyNxpm1g4lvooH0a2JDs633HClOynIUw9EOd1JFBfY50i
	 fw+b4BNdhsBccYVfzMm1xXFzsgJXrHePbnkmbtDZSzs1ewnXLZCz6PB6Ri4fyzc+l
	 znXrSD+eYmi7cgBP6jG1ga20HQadoVBoLEvUJsc5zW/pfJhMtligbx4xrIaabrVDG
	 EoxK1ROZfKsBFa4vFq9vamRB8NzltlhArldnj4cUf6wDpzgMoue2OoAvR4P32PMXZ
	 k+asnILvEwMxCBDf9aP0+MJzgxSdEXmD1i85/VbdHQ2Sm6a7NSaGHv1IWmon759NB
	 7oECIqU8Mz/1FRCd+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6ux-1uIcet3doR-00kkRt; Thu, 31
 Jul 2025 01:29:57 +0200
Message-ID: <04558d2c-ef60-4355-af0f-e3a493608805@gmx.com>
Date: Thu, 31 Jul 2025 08:59:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/301: enhance nested simple quotas test
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, fstests@vger.kernel.org
References: <5b4103224ad0a5f26f3856b7333e7efff8575296.1753916569.git.boris@bur.io>
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
In-Reply-To: <5b4103224ad0a5f26f3856b7333e7efff8575296.1753916569.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RsEfWSltNeXArSQ0tiw+U5kqzpQnGRdQ0LnA7HkjuA+iiM7G22A
 BIXEdfN6hfn3lQ+KIfGs61en8QQRdJx7XlhQ75FVuxoLbm6nXbCRL2dcuEU9IXF2Lu2g/O1
 D6ZvfR6uwV/av4FDJDZeyyiyBRwbiISgEi3raQzHJ3VZcAx1DvnGZ/J3inuKBjXrlsrZj8p
 GWV60S33Nig3dbAsN8CWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AL5B7gF5vJ4=;cPKZvXoXvCB1fAYnINHo8FdJWeG
 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
 Xg==



=E5=9C=A8 2025/7/31 08:33, Boris Burkov =E5=86=99=E9=81=93:
> We had a bug with qgroup accounting with 2+ layers, which was most
> easily detected with a slightly more complex nested squota hierarchy.
> Make the nested squota test case a tiny bit more complex to capture this
> test as well.
>=20
> The kernel patch that this change exercises is:
>          btrfs: fix iteration bug in __qgroup_excl_accounting()
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/301 | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 6b59749d..7f676001 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -19,6 +19,9 @@ _require_xfs_io_command "falloc"
>   _require_scratch_enable_simple_quota
>   _require_no_compress
>  =20
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
> +
>   subv=3D$SCRATCH_MNT/subv
>   nested=3D$SCRATCH_MNT/subv/nested
>   snap=3D$SCRATCH_MNT/snap
> @@ -49,7 +52,7 @@ get_qgroup_usage()
>   	local output
>  =20
>   	output=3D$($BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
> -		 grep "$qgroupid" | $AWK_PROG '{print $3}')
> +		 grep -a "^$qgroupid" | $AWK_PROG '{print $3}')
>   	# The qgroup is auto-removed, this can only happen if its numbers are
>   	# already all zeros, so here we only need to explicitly echo "0".
>   	if [ -z "$output" ]; then
> @@ -218,7 +221,9 @@ prepare_nested()
>   	prepare
>   	local subvid=3D$(get_subvid)
>   	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup create 2/100 $SCRATCH_MNT
>   	$BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign 1/100 2/100 $SCRATCH_MNT >> $seqres.ful=
l
>   	$BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $seqre=
s.full
>   	$BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
>   	local nestedid=3D$(get_nestedid)
> @@ -228,6 +233,7 @@ prepare_nested()
>   	local subv_usage=3D$(get_subvol_usage $subvid)
>   	local nested_usage=3D$(get_subvol_usage $nestedid)
>   	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> +	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
>   }
>  =20
>   # Write in a single subvolume, including going over the limit.
> @@ -377,12 +383,14 @@ nested_accounting()
>   	local subv_usage=3D$(get_subvol_usage $subvid)
>   	local nested_usage=3D$(get_subvol_usage $nestedid)
>   	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> +	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
>   	rm $nested/f
>   	check_subvol_usage $subvid $total_fill
>   	check_subvol_usage $nestedid 0
>   	subv_usage=3D$(get_subvol_usage $subvid)
>   	nested_usage=3D$(get_subvol_usage $nestedid)
>   	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> +	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
>   	do_enospc_falloc $nested/large_falloc 2G
>   	do_enospc_write $nested/large 2G
>   	_scratch_unmount


