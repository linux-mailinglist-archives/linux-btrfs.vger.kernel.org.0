Return-Path: <linux-btrfs+bounces-9163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AC9AFF0E
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378E01C2143D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8291D88D1;
	Fri, 25 Oct 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GcekUWPa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006721D4171;
	Fri, 25 Oct 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850008; cv=none; b=K5PtNfacGr3tQTW5m705oB+Aq3K9CLTV0k9gh9nWdPYdzxzStNpcr7cOdfu8DDyuTd8SY18sbaylqhB+CUBC6RAD965s+Jgq9YRGzATu+SBRsAoGg6EcoakfuYKgbIKvDB8ZmMwZ6hIr1fPz7/5e/6QBa+cyASDKk0wOXFqE/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850008; c=relaxed/simple;
	bh=3GCCxsuI9n7XNl54XoG4tIyQuEC8wiEbiYSRcgxhmUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0ZtL0rkzT1+4yT8UlDNr6XhousmhiA7kX+dXRzmzDQtyEspvg0uiZegmsic6xt5tF0IDKe7E9MriPqj8OfCSmelfylzsqZZcU2HKRo4TGuB3L0N/53K/3wN1m8BU8kJfyGZMZ5SzzsaOTCpI25KMxDVxMLjk8TuXvCIrpIFoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GcekUWPa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729849992; x=1730454792; i=quwenruo.btrfs@gmx.com;
	bh=uMeleqJO7jnTh95WCLf2T0O4fw2AFCMRQLdaVWIbQWo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GcekUWPa7mxaRoCumrIOCu6T6nZeX6axjwd5tDENDIaybzea8C3yHIgSalNXWT1v
	 1u9kmJ1+KuIXzNpkoJQuSl0yen+FyRgQOmmNUEP9ErdesXayrBtBCN0Ev/w9rAhlF
	 LMFEUPeTRwdg/uYh954RqvI7hJ55zelHol5Sl5TxGJjFatFbfzkuG039cAUfThVi8
	 2dDXpmAmlRBSLe8thqkl/doclBaqqGCZg5T3EYxLtud4+ROkghmfEh0MIMAk7fWOh
	 SDBWYAzz7E04Y8tmXTlbBphMzFYWfnqDkofDFUIVnMaexm1v2HQZZtRo6fpHZnEpa
	 Fw2bVx0Gb87PMeqmXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDj4-1tBNkk08ru-003bHz; Fri, 25
 Oct 2024 11:53:12 +0200
Message-ID: <03bcaafe-4a15-487a-af2b-b23970162bbb@gmx.com>
Date: Fri, 25 Oct 2024 20:23:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
 <20241025045553.2012160-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20241025045553.2012160-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wk+wMdINVDakQQ2Jfz/4RIbvuLYDli506/cb+u9DGlaGW9s/r3M
 OKhQBsemmqsBh7jIOhw8193s/0yEITIDQ1m1ha+uK6/++mm/SpdZnlTsAPcG+FEoe8dwEjR
 lQEoftFd+BExlihy1y6oUNWs8yVqSYMfnIEqpQgczdxhevCCT2UDIUF01SOX33l+waMpR8I
 EfZKDL/8EkzE3c7ivqK0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Th5GR6/gEZg=;p1EtZl8sYho4jkmbpiMg7+gw3+G
 DI461v3WdJW4m1gJHnrw3/uPnfYyYR7b9rWzDEaCu+nWrLhP6g4zRGsmsLaxKJo9uD2mkkf0o
 ZmL7WJnk0fACHIPNSFneHkzZF1byEmNOm5J1PkxJdgfV9JqS0qvoxJECg2koaOsf9m44Rms5x
 fCnYwcOMhxuN7QtQGAfJEKwAZ5XAKMPjEBioJwGU9PfvBkpEWTQnsoDJ98VN4Sx9n3JY8HHvV
 TiuDPDu0pN4tQzyl9apTkPtn6/h32/Q0p9Dy/+kN33lIuMRICHPI3lxbJJRSxz6mC4WDnSj3M
 rlv1F3rTpU1phtl2Moa8YQOGFXLs3IJXPN1IA122iRYkSUve6qkCGP7+KdR6qNX0i8QtafEqC
 tOUjXUa6MMpPhGV7ApeQ/kh89K9cxmMG3KI2myG8VgcUC22jjcno3G4rSD5mWMzoT7kLCzkdK
 lLcRft5oHfhD8bWLm0IMf37sHa1IJpWkQ8iV21+DbEqIPny7CoYxBCVgo5dBDeMRRn5ROzxMH
 fCmSax0UCejNacG1nq0K14AvSoHXlcrn1f7aLKCr0IwHbQQ/TvYc2ZBkvXmmIvPdX65/BkbI7
 LT44IG4q6/QSf+KK5MYYSL9cO2jUeQ/PXdwn8fp0Yng0eJ0fQ77D2li+Sk+nc0IHplkXpYk3Z
 Mqawq7rzLG8CoErVzEr2HuIaIDMQGx0YTHWanBsGWVH5XX+ghW37EKZjffQxEomNhjvhKPm+0
 Hg0FmFThCz/2yyQl55KdCoyNLDlFq+qEBt3fW1n8tt0lKbCJqYPuKxMGMqsrCa2QVju16+GN6
 F4HtLfe2A/XhxZk27mbiJ8Xz3w6BumKyee3dmigKgZR3E=



=E5=9C=A8 2024/10/25 15:25, Lizhi Xu =E5=86=99=E9=81=93:
> Syzbot report a null-ptr-deref in btrfs_search_slot.
> It use the input logical can't find the extent root in extent_from_logic=
al,
> and triger the null-ptr-deref in btrfs_search_slot.
> Add sanity check for btrfs root before using it in btrfs_search_slot.

Although I'd prefer to explain a little more about why the NULL root
pointer can happen (caused by the rescue=3Dall mount option), which can
cause NULL root pointer for non-critical tree roots, like
uuid/csum/extent or even device trees.

You don't need to bother sending an update.
I can add such info when pushing to the maintainer's tree.

>
> Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D3030e17bd57a73d39bd7
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0cc919d15b14..9c05cab473f5 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2010,7 +2010,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>   		      const struct btrfs_key *key, struct btrfs_path *p,
>   		      int ins_len, int cow)
>   {
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_fs_info *fs_info;
>   	struct extent_buffer *b;
>   	int slot;
>   	int ret;
> @@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
>   	int min_write_lock_level;
>   	int prev_cmp;
>
> +	if (!root)
> +		return -EINVAL;
> +
> +	fs_info =3D root->fs_info;
>   	might_sleep();
>
>   	lowest_level =3D p->lowest_level;


