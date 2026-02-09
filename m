Return-Path: <linux-btrfs+bounces-21539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFyCH460iWlLBAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21539-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 11:18:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAAA10E122
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3C9530131DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57446358D2C;
	Mon,  9 Feb 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZZISONaC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D883446CC
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632319; cv=none; b=Di5iAjeO17I9852aiYok7O0i7BHEh3EnPEcQLjWH2G7AEE0tiWB6RNwuO0vZQPGNXobSTvV9Pjd09dO4PZiu4+G70UCw8ZG0GnwPnydyRUjQgY/a0v/0McQNWpWJiFqq6KU+lcOkqnh60ePzjruknrehZq91RDNBVIxB7Klnefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632319; c=relaxed/simple;
	bh=Hp3butTsCzU0ZN6sMtCygM3X1WICTFWvnXkBAxwKrS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PE9qECbzLfJSJwCbfGGXq/N7r29Fu13Isz9bAnzvZZJgp2uq9v9K3XjQIlxZk1vaoMG7Ydsd+ja8tzcukPhBredCgECKas6yxe+VWXTa7u4ML5FxBd75dyiEfEqFr04iAuvBWDUFVWPDSnLxs6eKkbCPv7eAc2Ejk9BT+fK1Fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZZISONaC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770632317; x=1771237117; i=quwenruo.btrfs@gmx.com;
	bh=tiHYFun8jfC8YybG1x+dI+3AR/UbkFiDLWGjFpk0HqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZZISONaCLX2iLdRjoACkswNrArsycwa5kucx3D6elfOxDoa3EP0yPC7W8XFWxiET
	 C/3jzaKPwHfBg9bQp+kj07YPJUCshuCtkRrbb5Mbc2cfTbUp+EmJMy0IFMog2jNOd
	 3dUL53KcR3AEnkUntXX6jy5/EkqVsM0m5svT7MQG1SD+1pxAqShJemYT7H/f7IFQE
	 NfdGEvWDz699EN4hJooooh0ruTkVknbrWUfxIp5l+PgsjN+fYi8zBhI9WBDeoMio4
	 9k0+MKx9RLA4SMS6oafFY0LOFYQPSAYmkzlMsZ8m6tBcMYPwPtHTwdBQ9kWycYG5x
	 qwLPOdTV53Kj/o0Q1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1vGbpN24EU-00lrJN; Mon, 09
 Feb 2026 11:18:37 +0100
Message-ID: <59f97ac2-8991-41cd-94ba-29bd6981df69@gmx.com>
Date: Mon, 9 Feb 2026 20:48:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove duplicated eb uptodate check in
 btrfs_buffer_uptodate()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9e7f31b1561a9733de07046f076657e95a3af39a.1770632164.git.fdmanana@suse.com>
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
In-Reply-To: <9e7f31b1561a9733de07046f076657e95a3af39a.1770632164.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vzVOo2r437jrxN87hAiiZnCYH1EJaQhn5SMYMxKYYZ5MDiO4qNw
 QQPomuGc0grpp/BgeXiDP7AsXC9WeVMd2FOqwQ/DLOSlCOETbrz0QoqV3oA4T1n8qBikben
 HtBjeXsE0pI3XjQaf0n/WtrTwQbplGXqkt8AV8LOXow2sSziqjBHOHeC7lc/XL6Jnbzqd16
 7mjPXYydfkfFSq5NrjR7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k+D70dfKX0A=;zX649ApCxISlzO6Dhg7XVI+PKfT
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
	TAGGED_FROM(0.00)[bounces-21539-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,gmx.com:mid,gmx.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CAAA10E122
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/9 20:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We are calling extent_buffer_uptodate() twice, and the result will not
> change before the second call. So remove the second call.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 53237ec14d49..2e7af6ead4a6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -121,8 +121,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *eb, =
u64 parent_transid, bool ato
>   	if (atomic)
>   		return -EAGAIN;
>  =20
> -	if (!extent_buffer_uptodate(eb) ||
> -	    btrfs_header_generation(eb) !=3D parent_transid) {
> +	if (btrfs_header_generation(eb) !=3D parent_transid) {
>   		btrfs_err_rl(eb->fs_info,
>   "parent transid verify failed on logical %llu mirror %u wanted %llu fo=
und %llu",
>   			eb->start, eb->read_mirror,


