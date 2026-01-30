Return-Path: <linux-btrfs+bounces-21251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPHwKMsWfWkGQQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21251-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 21:38:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D8BE753
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 21:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15F930180B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 20:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676E34FF60;
	Fri, 30 Jan 2026 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RD/Q86zQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810A332ED3
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805508; cv=none; b=Z2ZNmsj82lDVTRhvCfIavimFRi4J5QvWwY0FX6lk9UwdjP5r5A/+cvmGTMIfuDoYQITIOX8XjQ22HS7akSp3Z1tVL7phePtG6pbIKeBgSy7NQeqomFV3CgnV6VCUzVfqTaPC/+P56jKOzf8WyHklD40AfH0C/fUWjE2NbEX3i7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805508; c=relaxed/simple;
	bh=/HfCv/8BgNTuewqXfw8WTt/DXhNBERpSIqRz33TcWN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ql8YsUSO5TCyq+CgGX2fCJTrWwARlxMYZ5I5GAsCZ8oFZ3tuQQ7kcV9HnrStnWJkI2qr6HgRfI9WN8mfoqzupi64T9U9ytiLSnuHVCWmQcsSkkO73DwFR9vjgJvQ/cboRfuVzGRu4om8sQ27OdgoK8t89AXM/H+haJRuLAfcED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RD/Q86zQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769805504; x=1770410304; i=quwenruo.btrfs@gmx.com;
	bh=ELsOLuTLocN3QIqsVP58wMrf2GIMKEXQhN9FjitQglg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RD/Q86zQHrGWcLG384yUf7j1e0T3RtXKw4F/FyYNkw4yyrqUumbbrH4mcWst0nx8
	 9vvx6eDWG74eFnOHbgoZRt13lM+L8xAa9UQCMssBGV6RXkOkPXz+hfrElDfCqaQo4
	 MNVB50fKKppxWUrSOCHpbRMS1iY0clNpkAM2vK1mK5x0rdac43KOzybpsfOjvcVJk
	 ZHRgP9R/zFTIzkKIbB8O4752xA13PiCSLFMgDHmyzqFXdIbut00bPm1bgeyAW5SMm
	 XCfubGhA5WgDpXpnweDX2QUWOHCRRP/ukncqwbZfJXbSB+QwukPaz5CiEhnGNB9Oh
	 NsJ3Kwc+Xsl4FUTILA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1viLx446w9-0082ut; Fri, 30
 Jan 2026 21:38:24 +0100
Message-ID: <1a448160-eaf8-4150-af8e-59f011dc351f@gmx.com>
Date: Sat, 31 Jan 2026 07:08:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: raid56: fix memory leak of
 btrfs_raid_bio::stripe_uptodate_bitmap
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <140aedc1e1af2866bb838d29b742c2015d55d91e.1769793280.git.fdmanana@suse.com>
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
In-Reply-To: <140aedc1e1af2866bb838d29b742c2015d55d91e.1769793280.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:REVe4OSac643smnlEV98kDCpzlSuEYuYKHAZN0Cr5I/ivpZJZSo
 j0/9Ru5ARHBc6JTsIWjcT86ru/FJ3ZdYOPHtOPnEH4H3aUjLiLa0/Dpmy8Ofr0LaEVcfDsk
 +QTP1MT33x56Nnfycacxf6qw58Ewke5cuGLSkA6Fd2Ii8ZpiA6+/U0NY9IJNwwrbUev6Iwx
 4WmReWnWxHZ44vr6XIF5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VrQcoIani4s=;kZiiDhW83AI2ttawWUaz14k+BWF
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21251-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 4E1D8BE753
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/31 03:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We allocate the bitmap but we never free it in free_raid_bio_pointers().
> Fix this by adding a bitmap_free() call against the stripe_uptodate_bitm=
ap
> of a raid bio.
>=20
> Fixes: 1810350b04ef ("btrfs: raid56: move sector_ptr::uptodate into a de=
dicated bitmap")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/linux-btrfs/20260126045315.GA31641@lst.de/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

My bad, thank for pinning this down.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/raid56.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index f38d8305e46d..baadaaa189c0 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -150,6 +150,7 @@ static void scrub_rbio_work_locked(struct work_struc=
t *work);
>   static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
>   {
>   	bitmap_free(rbio->error_bitmap);
> +	bitmap_free(rbio->stripe_uptodate_bitmap);
>   	kfree(rbio->stripe_pages);
>   	kfree(rbio->bio_paddrs);
>   	kfree(rbio->stripe_paddrs);


