Return-Path: <linux-btrfs+bounces-9105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BCD9AD658
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDC1F26AD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200FE1E9070;
	Wed, 23 Oct 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b+e0H0th"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933E155757;
	Wed, 23 Oct 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717693; cv=none; b=ds0Mf+U8d9zp8bzwvQUCou0T7g7QujmkuZvOszgHqHkYAdkmsZJAGRrQduPDaANe4UswQSU/BOjTQLbYUCPgP5u/7S3ss2vxYNqEcis84KK4VMA3yxDqEskEAKn+8khXqYJJ0Jvps8/tbeEhAQ8g5TlltdJS9Obme3K8+ts25ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717693; c=relaxed/simple;
	bh=JvK5hqeHkhaAz7PJV4BGvl+87T31ZzUZ26uvW+5Nuzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cE3uYCDZKgQiDN3nYwDuevpo8lzhZjytLrvrkJl7CDuG1ixIgBixYOgLfn357PU53fgEWvMBLcpUH/3cHVBY+/XyM5N8bijp6fkyHOoh4qMZk/G5mqAretBrVxTT5pP+7hsc4QZI15t2Moh05eN9f9b7xatr5l/onwSZwuuwk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b+e0H0th; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729717680; x=1730322480; i=quwenruo.btrfs@gmx.com;
	bh=v1wt7PY2yIezjNuYTtxw+NYJOeA9FXABuYr9urNbQmw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b+e0H0thvdyedLojodPT9bMs1s0Uc+9k+WbE6akv/g/cvebcwLS1mzNXRivmGYlT
	 W2310QfkSpqD/jU+DXsRtbrHtUH8cmLZWBjE+v02ZJUTHEoot6dddkAxXTgKDBHCQ
	 RsPjhdI5URpERybWKxaBbiwOdclDIvGman4ApgNkU6vpGQf2X2ptx9b0ndgiGFj90
	 wEMSyfKeUdUxcKhy2xh97eTgG5QgAxsL5Rx/t1mkO2CZTZoi+1GW1x2XkhB13zgGD
	 NVWupD8MqPn1son2xOO/5n1pKKvzFzM7DFbYqVd99IxaJczaC4wWfXsBPyDrUMVMC
	 GWYdRddJoEeSfrJBew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1tJ3bj2x1k-00PaaD; Wed, 23
 Oct 2024 23:08:00 +0200
Message-ID: <d409289e-bfb5-48a1-87b5-f25b5b9c9502@gmx.com>
Date: Thu, 24 Oct 2024 07:37:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a sanity check for csum root before fill the
 data csum
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
 <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
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
In-Reply-To: <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QrCmk5neeIFQFCHgTQAzNmuhhRngOQtfkuR19eu1LpAG1MlTT9Y
 hJX5M4UqeykKzjk/AF1lxJ95fvP+WaaF2K7sj80yO5DENM9HByzpiHixAfExn++iJCHrkC8
 H9Ftmd///Qpa0gXqaJ/POgVQcNnYPcvDodcS53GILNWy/1Y4JvtTrpTi06W/cSGorlneWWz
 W/SolxVGPCBnRx+CGYhYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c4eO0mQdfKw=;OlAqyBUQfTKjgx+qUE/qOIz/jek
 /0aNV6BlWp+CGNkJFN0DYipKWdSyISxehuVK3KW+ELRWWNWOjW9W07rlf8EAzNfbsyqVANZo/
 /1wQ8Yec1444nLz7zdLbqAY62pGp8uiINBOAYelyF0JNggummpIetTl6COFb72V96pbC51Q2g
 49wmHd1QsfJ3sG0bbUDi8xtbctuaKTGGeKYVDuu7YgYfQso8rb7yFIYaVwjSVZTrhbOgOD0n4
 TTk2F0OaP68t25kgJlDdDr31OC6VvNk2Grej8Fu/DlakICrPO3swbq9F4+qH8X9UDKs6j+wAm
 jAdGtXCGxSaCMEsHXWhbYSOWS+rWBGazERO1/U2p2zsXYNCc97tIbGzwtbDEGwXtGEzSQ7B7O
 m5nZwbQoaihiWYqMyM89UzPO63Q73k7QsjYAZoUq+HAVGZYXW+FjKIibR/mWnJTYLPUI32Z87
 DThmki9B7PowV5uAxFHTBz9s4m7r4lfwsJwecTzBvju7Me5fon0WbW28KtP05L/3zrls1DQcd
 4ipsI6x9m/dxSzoi4vJ91nqpmNpYN40sSSm6XdjpmPtCKU0Ehz6x7jXUupEIgu2x+NlivHGKv
 9NkfNAfCA+RnN+R/ybs5xjKaNdRni6JKh05ij0cKOWpGbBee5B6DjuH5RqQ9kXhrfdcD9oXVx
 uf1bLNT5isD5YeP8M2C60kvxlz1R/ZUI3yQiJWIPlYDbco3N76w754yJ2gjgpBGI56yAkGXUS
 T7GM4+evkMXxuC0SX/yal95v84fIAJ+sG+tIcOdOljqN+S/N94Kfb3nf0XWD/8kiGrRRBrgui
 w1SQlsiy14uASHG6QOp9b67Qef3GJOBakeDrLrNwQaieM=



=E5=9C=A8 2024/10/23 21:34, Edward Adam Davis =E5=86=99=E9=81=93:
> Syzbot reported a null-ptr-deref in btrfs_lookup_csums_bitmap.
> The btrfs info contains IGNOREDATACSUMS, which prevents the csum root fr=
om
> being loaded.
> Before filling in the csum data, check the flag BTRFS_FS_STATE_NO_DATA_C=
SUMS
> to confirm that the csum root has been loaded.
>
> Reported-and-tested-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmai=
l.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5d2b33d7835870519b5f
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3a3427428074..1ba4d8ba902b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1602,7 +1602,8 @@ static int scrub_find_fill_first_stripe(struct btr=
fs_block_group *bg,
>   	}
>
>   	/* Now fill the data csum. */
> -	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
> +	if (!test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
> +	    bg->flags & BTRFS_BLOCK_GROUP_DATA) {
>   		int sector_nr;
>   		unsigned long csum_bitmap =3D 0;
>


