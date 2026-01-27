Return-Path: <linux-btrfs+bounces-21128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBIWJ1kueWlOvwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21128-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:30:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 158DB9AB2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5663A301DD87
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC029A31C;
	Tue, 27 Jan 2026 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NS61gnJo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E129AAFA
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549391; cv=none; b=mDMT/A8gNAG8PFR+QuWc6qukLopl91QWqY0Gm7011uW/W7PIdy9vbApsvwhob9123ltJOhLZexg9nVEknTgYH9bKVh1JoB/gk5L8sv3AZTrLj1YlSySGvWHRYtBicN5vL3LAQOpL3oCHwQBHUys/7HwP20BBkpCm2nKRFxH1R4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549391; c=relaxed/simple;
	bh=jrMBrUg2kVDjWfGJqFXfLIanBmc4PuJNGq+V7132jww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdRFEPcwEEN76mVWJ9Tcp3epBGHZVUMiqzTUuN7VvXnVAndnHSgtNLSYcesWVjC3qo2jhlEPdCck4Xc/pXBbnq7kmOV/Z9AeoktXSjlvyKXlDSUEZsAiZB0ImMM4vaiPbS5RbZXauOgrNS0KjZ54Ene4LC3mKSgJe3xezIpESDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NS61gnJo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769549386; x=1770154186; i=quwenruo.btrfs@gmx.com;
	bh=jrMBrUg2kVDjWfGJqFXfLIanBmc4PuJNGq+V7132jww=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NS61gnJoy02mObhtwS6H24CfEn/n8L2ELzv+epv/pmliQ/dAYUXsm/605rRYofH9
	 cUZ3p6hMAwnnuDIQuZnvFdrvk98YTiHFCDNknQOFGgClg+jubLFdp8IZgZ9y9zavo
	 7/tSBDr9SnCBVbCUXCRffrQi14SPsunM9e18RsWDp6LImtehHtXmzGGGXxtAtprLt
	 Z1PO0wUnJkNIIE9fPJTPis4g5eoDeXAGc+dLHJh04wjgLBkAuwn7uwP0rxTpi3D2U
	 UwiufvfeRvkcx/R4Qk5+U2CiAHX9p3ZsNke73CMFG25j1cUr90O/F2BOHeIiqlYOy
	 8FYWPQyR0/2zTp31XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ygY-1vi6oD37w6-008fOF; Tue, 27
 Jan 2026 22:29:46 +0100
Message-ID: <749f28bc-d55c-4f9e-81dc-c5d307adce58@gmx.com>
Date: Wed, 28 Jan 2026 07:59:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] btrfs: get rid of compressed_folios[] usage for
 encoded writes
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1769482298.git.wqu@suse.com>
 <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
 <20260127202805.GA3504710@zen.localdomain>
 <a14a1533-ed6b-4c98-9ae8-c742efc7c28c@suse.com>
 <20260127212705.GA3548083@zen.localdomain>
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
In-Reply-To: <20260127212705.GA3548083@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jSWPEIgqzMYKllSQfWVsQDkQfz9r7x6UPy2Mdc55Ce0ajs0B619
 JOSFVYwBjjgC9+0MYUPP5SB7atLr03xiSCgewanvEAHETJDth5zX/1zKzxkrnjt4Nu7zoQj
 YqYUCQDzEVWj/GFjaL04AAYm7RIC0q6aNCPDaEzHUd7ToL0HeWt1sZdWFAtMmZRp+nRAwpN
 RxVAuBOV3SGHefc0MU3mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z2OK/+/sfXw=;X4aIHXN+SXcuTDmVDj6QJ1UWzs+
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21128-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 158DB9AB2C
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/28 07:57, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Jan 28, 2026 at 07:40:23AM +1030, Qu Wenruo wrote:
[...]
>>
>> Wow, the AI review is better than I thought.
>>
>> Indeed caught two real and careless errors.
>=20
> I have been impressed lately as well. The main reason I fired it up on
> your patches was that it found several interesting bugs in my recent
> work as well.
>=20

Can we have a public bot doing this? Or will it easily exhaust the quota?

Thanks,
Qu

