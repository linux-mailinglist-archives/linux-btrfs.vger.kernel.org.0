Return-Path: <linux-btrfs+bounces-14897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A907AE5A5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 05:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709264803C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BA1A8405;
	Tue, 24 Jun 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QcbmWl/k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC119D09C;
	Tue, 24 Jun 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734489; cv=none; b=CfhLsc+umycJUiXPUGxCYMspXDkJpIhkn3Su1td1i48DN/4rW08x5qiLtWCb9ge1xpuJWkGEKZfV/rYSH4O8zvtOz8YBPH0xR8pVJQ4oJkAai5ZdWNCd3aOZfke91sG/K+3/fUIUWZHiAyRXVl6o83P9P9Vn+cic2q+BiqHaqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734489; c=relaxed/simple;
	bh=IWXsQJDfKWF3D/2J/p70E7axtKZxHxfsmoul6LMdKDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlH8zPQHkELtZGjh5IarOFxQoKpH2sXGYTnbZkjBdo0ImcA76+imyTkaqJaOtAuS3BunJwzAXeqnqklbGIaFY/5HY2l3AppbVc559aE8MSUArRYgsEfadDqNLvkj1uC/yiBgfMxJC2YQ4w0DsoJnIcb9ibwwIRX8eSRci4VpHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QcbmWl/k; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750734478; x=1751339278; i=quwenruo.btrfs@gmx.com;
	bh=Nz/uicxZB1UJIQLq/JcmQ9lxIzcoltTRTUNvZTWkx84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QcbmWl/k3KDvNjpaCKUgJmMJBnR/fQ0jalHrnCFeCbjyBb7wkCJGDN2qBzfBq3Eu
	 exYMMBC1X3meKNAgKS1nVRargM5AV4kro4+O+LKP4WvsqiPBi4bJDan4W2/fwZGo2
	 qYLmdJFvtGY9T6q+kd3JifqJTe6nnXlWtWPqjm19ebliPu5hV7ZeCiJPGyTawtb62
	 FkHtwwnc6i5oB0Xv0bn8tyBaRu4EIrFKNA2i4M60NukN4I9GsGuAfNkOGOUKAgxY7
	 lu7AFKb498YPo5BUQBtPxfCNPclkQGJbxzQrEh6u0MqSHyvYrGTtlVmiH4yI4zQVs
	 6+5OZgKd8aEdZ7E4Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiHf-1u6aGo1upj-00Y50d; Tue, 24
 Jun 2025 05:07:58 +0200
Message-ID: <f80c28ea-5c46-4caa-b2b9-6e76f45a7cfb@gmx.com>
Date: Tue, 24 Jun 2025 12:37:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DEPT report on around btrfs, unlink, and truncate
To: Byungchul Park <byungchul@sk.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 yeoreum.yun@arm.com, yunseong.kim@ericsson.com, gwan-gyeong.mun@intel.com,
 harry.yoo@oracle.com, ysk@kzalloc.com
References: <20250623032152.GB70156@system.software.com>
 <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
 <20250623081919.GA53365@system.software.com>
 <474347bb-bbba-4238-8964-299f87de664a@gmx.com>
 <20250623095250.GA3199@system.software.com>
 <a93738a1-57af-4eef-9a32-edfc60c7e7b4@gmx.com>
 <20250624014426.GC5820@system.software.com>
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
In-Reply-To: <20250624014426.GC5820@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+lb+mf101Ec+ikybKUcrS6+KWpHF8H7575PHnzNqY7K+LWQoM/L
 JBeDo8TI6JE6tNIIoBE11n8fU+TF4O02xJgfY3cottg9+A1OfG1xciai8jel6oClC8iXWRG
 6+pBgm37BKDBlnPDHapX0oH4wbaTB3lIxlaX60/o8Pv258qM31rSpQutCKH+MplrGAIA+Re
 +E30AwNUg3Zz7GjvsGAng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:flBKW/rqFYY=;fKT/8hhsaQU3tZGixVu+D9E9ynk
 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



=E5=9C=A8 2025/6/24 11:14, Byungchul Park =E5=86=99=E9=81=93:
[...]
>> I believe it's from btrfs_clear_buffer_dirty():
>>
>> As we have a for() loop iterating all the folios of a an extent buffer
>> (aka, metadata structure), then clear the dirty flags.
>>
>> The same applies to btrfs_mark_buffer_dirty() -> set_extent_buffer_dirt=
y().
>=20
> Thanks to Yunseong, I figured out this is the case.
>=20
>> In that case, the folio is 100% belonging to btree inode thus metadata.
>=20
> Good to know.
>=20
> Lastly, is it still good with directly manipulating block devs or
> stacked file system using loopback devices, from the confliction of
> folios and extent_buffers?

Not an expert of the block device page cache, but since the=20
data/metadata split is fully handled by btrfs inside itself, even with=20
stack loopback devices the metadata/data IO from btrfs just becomes data=
=20
IO of the next layer.

Since we do not deadlock inside the btrfs, then it shouldn't cause=20
deadlock on lower layer, as the IO just become all data even if the=20
lower layer is another btrfs.

Thanks,
Qu

>=20
> If you confirm it, this issue can be closed :-) Thanks in advance.
>=20
> 	Byungchul
>=20
>> Thus the folio lock can not conflict with a data folio, thus there
>> should be no deadlock.
>>
>> Thanks,
>> Qu

>>



