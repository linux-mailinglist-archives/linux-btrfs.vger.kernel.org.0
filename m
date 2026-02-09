Return-Path: <linux-btrfs+bounces-21526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FRnHAKpiWnfAQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21526-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:29:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E2410D8F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCE5730059B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE21364044;
	Mon,  9 Feb 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dpA1aWVH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831E3644AB
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629374; cv=none; b=UgMqzwzU4sYs0NnGJTRteWZ5NWZQdADmhcCU3WWAYZ5Basz6dNRI7w1A+iRznqxz/U23CjCtDS3os6dyPih2QInYaY6Un+3NXohBR+e+J3+FDaBDh7D2kGsL6jy4Ml/FuGosQuvExgIYvan4jnSK5nNNyiZW6m4ARbB8vPupJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629374; c=relaxed/simple;
	bh=uOS39cXOShrwiCKgm7hDWfD7NFKERxxcxfN6j4dPsbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YyoYBVhaTw7nz8tuAb21DxkxAR3MdpiJVc76FFi/ONLZGvEPyVvqnd26SHkbQ108cNPcM4FfxchhCkXzGsiHE6TQuwD4ffqH6XaU7PI6HYMgYUhUiKQmHUoS6zpWMshoql4S+YU+WNHyWGYjHokEJeuzb05Aar6sw/OFWKKbXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dpA1aWVH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770629371; x=1771234171; i=quwenruo.btrfs@gmx.com;
	bh=uOS39cXOShrwiCKgm7hDWfD7NFKERxxcxfN6j4dPsbk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dpA1aWVH28M4tJrTOdOUM3HTCvsWYtENl6Rxu2E1eFAUBZNY0Alva9G6thn+zBix
	 cwZXch4fiN48sg2MYn8nSlCjBylpbdybUE/JdRhOUsifc5/P4f/kWvStF8GCUW/TX
	 s+ZACOLgCKjmTHsirQ5/h3/K0YTj0xPzeiAtVJ0kF1iyJBJUIH4M1+LspmINDuF4a
	 Cmx1Bz+M3wDqru9tmhJlBlxjm+DT7euuWfZmwIHpc/rXCZxIvmzBxgPq5uab1E63H
	 aQQGjhDks4kW16JeX9MZtEOfYvDceTNwfFy4KZQAMJxQKsu5XS8tjARzTYqqzaA8X
	 nsOJcKlpORomxEsENg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKbgE-1w5wUp0Ds4-00SXU9; Mon, 09
 Feb 2026 10:29:31 +0100
Message-ID: <5671e66f-c451-490b-bad6-39e5da6d54fe@gmx.com>
Date: Mon, 9 Feb 2026 19:59:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.18, 6.19 very slow write speed compared to 6.12
To: Wladi <wladik.haha.psn@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAGpq3yLOFSSn3knMWLOCu39DnJeKPbSGZZky6KfPJEo=+U5p4A@mail.gmail.com>
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
In-Reply-To: <CAGpq3yLOFSSn3knMWLOCu39DnJeKPbSGZZky6KfPJEo=+U5p4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHsy88Zdr6ilsKY6ojjjmdZKEWQ/+2uPeKTQ+srL8xx9dSRjYtl
 Kh2mPGjUvFQEmgDes3+1Iw/bNKO/KcGTBth+sFZjUOaemkrteF7sGJnoCpeScwy9KuL5764
 WBL3xW5EIHsNUs7+DVnLqCIYHaGY6bi7kDQBFsqmPJAZXVEfEwF0TJlKdMpWKYkmxUEvFvj
 4HXRKfqX41dH6j7hjfl9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g6UwptYK9YI=;UWvOzdxLIQf+pneM702yLL3sEvX
 +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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21526-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 16E2410D8F4
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/9 19:41, Wladi =E5=86=99=E9=81=93:
> Hello,
>=20
> (If this isn't the correct place to ask this, I'm sorry)
>=20
> My system:
> WD SN850x 2 TB (PCIE 4.0 x4)
> BTRFS + Luks2 (4096 sector size)
> Ryzen 7 5800X3D on B550
> Fresh installation, drive only 5% full
>=20
> I have noticed that my write speeds are very slow with Kernel 6.18 and
> 6.19 (on both linux-cachyos and linux-arch) compared to 6.12 LTS
>=20
> I've tested with "KDiskmark" (Fio):
> SEQ1M Q8T1 with cow
> 6.18 and 6.19 -> Read 6900MB/s, write 900MB/s
> 6.12 -> Read 6600MB/s, write 4500MB/s
>=20
> With no_cow write speeds reach around 6000MB/s on 6.18 and 6.19
>=20
> Is this a known regression?
>=20

It's not a regression but an expected behavior change only affecting=20
direct IO.

It's kernel commit 968f19c5b1b7 ("btrfs: always fallback to buffered=20
write if the inode requires checksum"), that changed the behavior.

Between slowing down in direct IO writes, and data integrity, I think=20
most people will choose data integrity.

And for people like you which are benchmark focused, KDiskMark itself=20
has already adapted proper workaround:

https://github.com/JonMagon/KDiskMark/commit/ca9801d6f2d3ac330061f2bfd9ceb=
25a74bdf6b2

For most common applications they are not using direct IO and should not=
=20
be affected.

Thanks,
Qu

