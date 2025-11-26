Return-Path: <linux-btrfs+bounces-19365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7AC8BE3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 21:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471633AD30B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD9340A4A;
	Wed, 26 Nov 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sCCIZ8+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2B27BF7C
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189623; cv=none; b=U3DnWhyuL3KSA1QD/jL1pe7oQAq3Jt9/Zz2FmByEYNL/3gK6p3acC/bvAsB9vQm/XicucRfDuLC/Tyqa3aZvGqMAHYgMWWE96Eng/P14+pIhMyyEF3xlIoYyV3PolWNxsbHH1Vv4gRrACXMesm+XUM9qkykdsxhpKOd/jPqe3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189623; c=relaxed/simple;
	bh=ce5BROX4TPLg1E9mzMrhunOJKR4bGfhux/wabpXULK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUEobFHs9Ao2lA6gkvagKtuWk1jaDCvWlxgIj6jaHV38uJENnjoFQqPCbCORPXA2T56GC4UndS0fNXzzt51rU1x3oEmIZuOlMjvTqsJGYXlDuu6KOVINne/P4SELzMkcOOs/wIJnJKGUvYpZq4KVw1MfpSlPfn7cCWqlwH2wqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sCCIZ8+h; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764189618; x=1764794418; i=quwenruo.btrfs@gmx.com;
	bh=h0MdHWjvBoxCf+KjF6O3wElZCgK8rITdEKXNWL9bCeM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sCCIZ8+hXkhrgrBRiKAvZpxMk393y3FBPf/1cC2RLlvhpyJbFrgF7tgJRaVC31Rr
	 Tc6NbMV6+rrSKXvsmdRxQr2loWaKIZOjmY/kOO2+tUXaGMGEyUNB8GvOKXZ3e8EOC
	 romxBtbyuw6FEL8in816WisRCE5bmvZTfd+zzx7b+ne7FJN6I8WqMbzrUPqeQcMJY
	 kriWjUFp4GqfwJ8C0CN+IulTPq3ykOLPvFzeP8ARth2NDOTEUS8qPwqiRg9QNUQJw
	 QZZswpgmmXmqtzSB5iCv9RXnkvFKzIuUAc5wAn2aERAl2621kDdwromKX2hZwBA9K
	 27eZGsEx6rilfnUGgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowKc-1vtphU02yk-00qBvd; Wed, 26
 Nov 2025 21:40:18 +0100
Message-ID: <1e7a1a27-efef-41f5-9d4e-019d319fc585@gmx.com>
Date: Thu, 27 Nov 2025 07:10:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1764106678.git.wqu@suse.com>
 <8922862996ef5e57e694de08dca430b372585728.1764106678.git.wqu@suse.com>
 <20251126142750.GC13846@twin.jikos.cz>
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
In-Reply-To: <20251126142750.GC13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6g9A1R68RvBKce4uNtZNwpr51sj4u/41txf2v6Sn8n63/97T1zi
 8m3btapQR09QFg72Hi/T/xKH40Hch1H/KZ290DbWw3G4Yoy+x6Ww6cZv6Xw1yUD+yZhvggs
 tOwcvuxkAAa3QSi1FBGAiOy11lcStS96xIwQRiBZjxVrQONGWEVUMZwyH+bvLW+lVWBvUnK
 b8E1vCgi4aNScrcryx+Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2SLl5ltPdsA=;l5zZFskhO+6TQSQSjnsOH9oGzcB
 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



=E5=9C=A8 2025/11/27 00:57, David Sterba =E5=86=99=E9=81=93:
> On Wed, Nov 26, 2025 at 08:20:21AM +1030, Qu Wenruo wrote:
>> There are already several bugs with on-stack btrfs_path involved, even
>> it is already a little safer than btrfs_path pointers (only leaks the
>> extent buffers, not the btrfs_path structure itself)
>>
>> - Patch "btrfs: make sure extent and csum paths are always released in
>>    scrub_raid56_parity_stripe()"
>>    Which is going into v6.19 release cycle.
>>
>> - Patch "btrfs: fix a potential path leak in print_datA_reloc_error()"
>>    The previous patch in the series.
>>
>> Thus there is a real need to apply auto release for those on-stack path=
s.
>>
>> This patch introduces a new macro, BTRFS_PATH_AUTO_RELEASE(), which
>> defines one on-stack btrfs_path structure, initialize it all to 0, then
>> call btrfs_release_path() on it when exiting the scope.
>>
>> This will applies to all 3 on-stack path usages:
>>
>> - defrag_get_extent() in defrag.c
>>
>> - print_data_reloc_error() in inode.c
>>    There is a special case where we want to release the path early befo=
re
>>    the time consuming iterate_extent_inodes() call, thus that manual
>>    early release is kept as is, with an extra comment added.
>>
>> - scrub_radi56_parity_stripe() in scrub.c
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.h  |  9 +++++++++
>>   fs/btrfs/defrag.c |  5 +----
>>   fs/btrfs/inode.c  |  8 +++++---
>>   fs/btrfs/scrub.c  | 18 ++++++------------
>>   4 files changed, 21 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 692370fc07b2..d5bd01c4e414 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -85,6 +85,14 @@ struct btrfs_path {
>>   #define BTRFS_PATH_AUTO_FREE(path_name)					\
>>   	struct btrfs_path *path_name __free(btrfs_free_path) =3D NULL
>>  =20
>> +/*
>> + * This defines an on-stack path that will be auto released exiting th=
e scope.
>> + *
>> + * This one is compatible with any existing manual btrfs_release_path(=
) calls.
>> + */
>> +#define BTRFS_PATH_AUTO_RELEASE(path_name)					\
>> +	struct btrfs_path path_name __free(btrfs_release_path) =3D { 0 }
>=20
> For the on-stack path it makes sense though it's a bit confusing because
> BTRFS_PATH_AUTO_FREE defines a pointer. It's way more common to get a
> path from a parameter and then call btrfs_release_path() on the pointer,
> so it's not possible to use the AUTO_RELEASE pattern anyway.

I can remove the last sentence during commit.

Thanks,
Qu


