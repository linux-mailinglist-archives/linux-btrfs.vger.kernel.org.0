Return-Path: <linux-btrfs+bounces-18045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C343BBF0873
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1BA3B5D79
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD1C2F5A11;
	Mon, 20 Oct 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hlogd918"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B02F617E
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955997; cv=none; b=agGqHfUnPkpb7Vd3IKtImJDJc/OSUVb9GjMR1plgaTGsbmdcK57+pg0absGT4n96pBTIeDHOU2cDPD61Qu+Z1HCC5AIzArVPHixm12s7z0lX/bNYYSYwZVozCBIJbcsD37aqd6mcxcCPYKTzAcBAhOwe1tq/pXEKQw6YMq9dk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955997; c=relaxed/simple;
	bh=K8kjIDMEzT+y1h+vxXXm0/Me5nc5jVYvybd/JUbSJWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRwh3WUR8drbkgr4h47sxbbpzwOnff91ROik4LIbrY5BSi3USKivUEbRap8T8gdEYOc+j8zcdp9eLrc3twx1QvG81TygG2nEeTAXH9GiorCnOCBcIlzVPjL0r6OKkbEev+67/EZ4ObqopIkG0lZWZH10kv0sX1pilBlMe1wFrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hlogd918; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760955992; x=1761560792; i=quwenruo.btrfs@gmx.com;
	bh=Gr3MfQMT6AkjYMxFlbG0bvGPoz/5dG5uTDqR7NpJwYU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hlogd918sFZVf+hX33RZ0QSyugWNBGHXmAmBAEtsVcCsl7b8BMCBoOorb3pVi6q7
	 NqmS1CMY5o7ysfCmT+P15seaWQHM8ubQ4f1iVm8cQlKhbKbgLZ5OPkP39h1GfsswJ
	 CIJL+Rj/Le4WDIWfX8d45jNxMtZgaIQu5wQ5XunXiuk2l/Xqb1fHJcTEq5bJPN7p6
	 yfQsV+EfuHBM2F6AMDP6j6SHh/omqpKKODkJrYUcu3J3EQDHQmplIOlwUvjD5BYhr
	 x6D3zEcdcVwK5jTPj/ejMOLprgISd22b5zuCFQFqEA7ASjGFHOzBW0hnIBpoIFsJr
	 aWMnrfqHgCKwaOFUVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1uO20z2ewM-00co9c; Mon, 20
 Oct 2025 12:26:32 +0200
Message-ID: <cc22f604-25f2-407c-bbb8-887e18630819@gmx.com>
Date: Mon, 20 Oct 2025 20:56:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs/071 is unhappy on 6.18-rc2
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org
References: <aPXjTw8WN5Jlv2ho@infradead.org>
 <9093d4c3-b707-4ef1-be48-36578ac1d2f3@gmx.com>
 <aPYFECiBrh36AwtB@infradead.org>
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
In-Reply-To: <aPYFECiBrh36AwtB@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ti6yWV+e9EWn0weePDDmk5x8FD+/DsGSROsb7Ip6fWsv//UC+Rb
 vOZqhyFrM0TdXvnjOAS1XnjQytPAPqymsMhHrznnRXACXO7rJpo0XA6PVGr1wiVBK58bGL3
 Rfi75r5rxjLt3S0ivRcDY7qXJ3mo06s07drO0CfZKA7H4/qXPbxSPsBf959R8EzaaXsYtkV
 0yF38JA2cdE5gqNiNX5Mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AukdiV1rGPY=;0dBo3Hlbeb30QEqY0wyJ/AWiqKW
 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



=E5=9C=A8 2025/10/20 20:16, Christoph Hellwig =E5=86=99=E9=81=93:
> On Mon, Oct 20, 2025 at 07:41:03PM +1030, Qu Wenruo wrote:
>>> [  279.247651] Oops: general protection fault, probably for non-canoni=
cal address 0x6b6b6b6b6b6b6d73:I
>>> [  279.250656] CPU: 1 UID: 0 PID: 82037 Comm: btrfs-cleaner Tainted: G=
N  6.18.0-rc2
>>> [  279.250656] Tainted: [N]=3DTEST
>>> [  279.250656] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-debian-1.16.3-2 04/01/4
>>> [  279.250656] RIP: 0010:btrfs_kill_all_delayed_nodes+0x145/0x1e0
>>
>> Any line number/context
>=20
> Nope, that's it.  Last lines before are:

I mean the code line number extracted from that RIP.

But I'll try to reproduce it after the recent direct IO problem solved.

Thanks,
Qu

>=20
> [   62.492209] BTRFS info (device nvme1n1): first mount of filesystem 97=
5f6fd4-b50f-4f3d-8112-319c
> [   62.492520] BTRFS info (device nvme1n1): using crc32c (crc32c-lib) ch=
ecksum algorithm
> [   62.510951] BTRFS info (device nvme1n1): checking UUID tree
> [   62.511230] BTRFS info (device nvme1n1): enabling ssd optimizations
> [   62.511452] BTRFS info (device nvme1n1): turning on async discard
> [   62.511728] BTRFS info (device nvme1n1): enabling free space tree
> [   62.642011] BTRFS info (device nvme1n1 state M): use zlib compression=
, level 3
>=20
>> and reproducibility?
>=20
> 100% over a few runs.
>=20
>> If you're able to reproduce, mind to try KASAN?
>> As I just checked my logs, no failures on btrfs/071 recorded yet (but n=
ot on
>> upstream rc2 yet)
>=20
> A bit busy right now, but I'll try to do a KASAN run later.
>=20
>=20


