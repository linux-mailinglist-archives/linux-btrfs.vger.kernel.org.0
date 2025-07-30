Return-Path: <linux-btrfs+bounces-15765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753AB1689B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D5116E723
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683C2253A5;
	Wed, 30 Jul 2025 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rtXbwG8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE81E1A05
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912412; cv=none; b=qaHZeaJi/K7KRkcUPINRn88TX7CbIM5AwEiugBeQPwQY20t0ulO1WUFd9I0x2VcxmuAZ0JwIqKh0grPf7s0KtuiswbWB7FHmva/slx+ZIc2UoyPQU6qELAZRn5OjLqYa/jj2i10EqoAMAZm93OmcstqVXtlxJ7Tnh80alKZIwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912412; c=relaxed/simple;
	bh=VFSxy0YD1SXHoTOyxv80yT2spNjBcodcG0Ly7O5j7Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM04t5sZOTkVT802GnebiCG/bNEpw0QNeIWh0wkvVV61MILTN6Urs9ySGIn8zQ+RfcgjpxEYBsSsdn503hiZ//5an1q+pmvgENfxQXymMKVt96SlbFO5DRJ0g6ikdQ2uPO/c2qi6EZFSvd/f54evCWkDe0KwGiYI65y5ij51Pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rtXbwG8f; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753912403; x=1754517203; i=quwenruo.btrfs@gmx.com;
	bh=rfmYcbv3yiGQpgXM8DLpILv8A/VmM0LKYwyvTnWu4Ek=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rtXbwG8fXdyuozPGGy3nceOi0cL9ZqByhN/TYOFlttCRQth39MKQinmxbrKzpwXx
	 JbiYRi2RQ/Dtan7qrieYctgPgHxvK/n0/1BciSanXA0WvNE2n9dpma2ZbuhhDP1o4
	 0B0nzsdEVxHKRJtuTUP1H9BOla3JMr+OSsvEmIbtMa6KoQ/VoSl7tuRJrOHEgOFFP
	 /BXviNV7SUaXU5h2eZASrh+hGJAAFupdVf4DIW8j9tdQL41iVOb2YpG7X2RC2qFR7
	 10ZR2+R9OsfP4kGU8vqISU6qlwOUtwxu1ZkzN6vH3fOAJcuTPD5JzY644sLUYEceF
	 TMZ8DQqUnutsj4kYvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1uxoBa3H8m-00PpfF; Wed, 30
 Jul 2025 23:53:23 +0200
Message-ID: <2c569965-de5f-43fa-916f-21dd860cb8d4@gmx.com>
Date: Thu, 31 Jul 2025 07:23:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix iteration bug in __qgroup_excl_accounting()
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: wqu@suse.com
References: <3cc7e1d9f60efebe0b19f96eb4526dc195be4b2a.1753898804.git.boris@bur.io>
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
In-Reply-To: <3cc7e1d9f60efebe0b19f96eb4526dc195be4b2a.1753898804.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lI5G4smGuAYifjvDU6LTHNSbQ/vfesJt/5pxrBWRAJFM2z+W72L
 rO2W5Px8GB/9XzcQmIClrTTEgTvKZu1oEgD+bujjm6I3cH18lZqbdFV2jEexfJ8yRWjxtWv
 pEAoChR7AC+DklWnnneoPhSdKDp5v6N+ZpgifASF1vTq5h+wji+cPhsJYjp8Bv0g9bL02b+
 E0W7Z9TZikkxgSHqrMIxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G4Nr2qzaUdU=;7W34ymF4dH+P0sIm/CdgHnHGzL0
 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
 rA==



=E5=9C=A8 2025/7/31 03:37, Boris Burkov =E5=86=99=E9=81=93:
> __qgroup_excl_accounting() uses the qgroup iterator machinery to
> update the account of one qgroups usage for all its parent hierarchy,
> when we either add or remove a relation and have only exclusive usage.
>=20
> However, there is a small bug there: we loop with an extra iteration
> temporary qgroup called `cur` but never actually refer to that in the
> body of the loop. As a result, we redundantly account the same usage to
> the first qgroup in the list.
>=20
> This can be reproduced in the following way:
>=20
> mkfs.btrfs -f -O squota <dev>
> mount <dev> <mnt>
> btrfs subvol create <mnt>/sv
> dd if=3D/dev/zero of=3D<mnt>/sv/f bs=3D1M count=3D1
> sync
> btrfs qgroup create 1/100 <mnt>
> btrfs qgroup create 2/200 <mnt>
> btrfs qgroup assign 1/100 2/200 <mnt>
> btrfs qgroup assign 0/256 1/100 <mnt>
> btrfs qgroup show <mnt>
>=20
> and the broken result is (note the 2MiB on 1/100 and 0Mib on 2/100):
>    Qgroupid    Referenced    Exclusive   Path
>    --------    ----------    ---------   ----
>    0/5           16.00KiB     16.00KiB   <toplevel>
>    0/256          1.02MiB      1.02MiB   sv
>    Qgroupid    Referenced    Exclusive   Path
>    --------    ----------    ---------   ----
>    0/5           16.00KiB     16.00KiB   <toplevel>
>    0/256          1.02MiB      1.02MiB   sv
>    1/100          2.03MiB      2.03MiB   2/100<1 member qgroup>
>    2/100            0.00B        0.00B   <0 member qgroups>
>=20
> with this fix, which simply re-uses `qgroup` as the iteration variable,
> we see the expected result:
>    Qgroupid    Referenced    Exclusive   Path
>    --------    ----------    ---------   ----
>    0/5           16.00KiB     16.00KiB   <toplevel>
>    0/256          1.02MiB      1.02MiB   sv
>    Qgroupid    Referenced    Exclusive   Path
>    --------    ----------    ---------   ----
>    0/5           16.00KiB     16.00KiB   <toplevel>
>    0/256          1.02MiB      1.02MiB   sv
>    1/100          1.02MiB      1.02MiB   2/100<1 member qgroup>
>    2/100          1.02MiB      1.02MiB   <0 member qgroups>
>=20
> The existing fstests did not exercise two layer inheritance so this bug
> was missed. I intend to add that testing there, as well.
>=20
> Fixes: a0bdc04b0732 ("btrfs: qgroup: use qgroup_iterator in __qgroup_exc=
l_accounting()")
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 1a5972178b3a..ccaa9a3cf1ce 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1453,7 +1453,6 @@ static int __qgroup_excl_accounting(struct btrfs_f=
s_info *fs_info, u64 ref_root,
>   				    struct btrfs_qgroup *src, int sign)
>   {
>   	struct btrfs_qgroup *qgroup;
> -	struct btrfs_qgroup *cur;
>   	LIST_HEAD(qgroup_list);
>   	u64 num_bytes =3D src->excl;
>   	int ret =3D 0;
> @@ -1463,7 +1462,7 @@ static int __qgroup_excl_accounting(struct btrfs_f=
s_info *fs_info, u64 ref_root,
>   		goto out;
>  =20
>   	qgroup_iterator_add(&qgroup_list, qgroup);
> -	list_for_each_entry(cur, &qgroup_list, iterator) {
> +	list_for_each_entry(qgroup, &qgroup_list, iterator) {
>   		struct btrfs_qgroup_list *glist;
>  =20
>   		qgroup->rfer +=3D sign * num_bytes;


