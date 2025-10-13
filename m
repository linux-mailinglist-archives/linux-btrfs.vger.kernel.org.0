Return-Path: <linux-btrfs+bounces-17743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E353BD65A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 23:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4F03E56B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E82EBDE0;
	Mon, 13 Oct 2025 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="t8hat5LF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8B2EAB66
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390910; cv=none; b=olCERYbisdBkE1ClekxY9vqYU9zSe1eqNNOZCa3Rinjk+ZR6TjG/jMtB/NAyxwrwXzI43wHVidBihRVtSy2Gg/l4kplnfVghEaThGCSYTRHl6tZYp5xV0srIZVN99TYFtz4kVBrBFweO/xdsguf8/wya3wb2KkfP53mM1QHR7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390910; c=relaxed/simple;
	bh=7Yr+k4+pMytyO0syaOaXbz5MW8CatBeFa+GfoOhLqoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UAqT+ICjWssbEaW55FAio0K5rMGc27F7aLzJwWq5Dre1W94SY7GHwF9m/WSlQ3wiCUoLSVhM1Z5hfZI4Fful06APxP1HGQak/ImSdyvKw71WTf3h3yc38uTz8yHtr2XOIB1+hhpvXS86/dgXOjqU4tdaHttIaMBZmedSiJXgjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=t8hat5LF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760390905; x=1760995705; i=quwenruo.btrfs@gmx.com;
	bh=bypWkFS39W1+HScQKHDfs/qBf0rbLZ91jXJPaosuo7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t8hat5LFQj8miQtaoz7q9LhYHyKmwfQzlSjOLng0U9GH910v/UAYlRnywbDrZQEc
	 QdRW+ndUjkx0iOogJdLcmv8LTgJzHrDj4umXvGVl3RFIEFYjOdRmKKIwIYEeeZiXA
	 wv04Ihmy3rbQVmuyrvOALoY+7mF61kSozEd5EqIy60kfa6Z3ea2m/VwLfcw39bDWL
	 ilj0XE7tYWLodUYrS8ei/0i/jUkcSL7y/igd/AbpUp5YhZ7+K1YI/Yj4sh2iqDWd4
	 0354hVp9EatNLizdF/kUAIFswf/AjgWBz3pngOObJ3grMQSfsZWjktB7+I+9FIqxL
	 3h34ndSN+wVxK2hFcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1ubZEv0YCe-00hONi; Mon, 13
 Oct 2025 23:28:25 +0200
Message-ID: <1239e4f0-07ad-4d70-ae87-4f9a684b764e@gmx.com>
Date: Tue, 14 Oct 2025 07:58:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] btrfs: remove fs_info argument from space_info
 functions
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760376569.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O4vJCSlNJm2mv6m3b3kzaQ5fF4cSZkuLEbE4YHhw17Z9sHgfnUo
 HeiwakExyRq9XGTWIURcr2kxtJh1y9ZACYGcgmRq2a30SmHV84XBGy5EdfR6zGhH7njnBMU
 CzxeCnngZUnvS7tsugMSCAYAJVcMwUNWPE3M1ulyc0Uo1YLuHhesleioKVEJEMZQ1L/e7bu
 murlC7R0r3j/YxXBSCocw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lIgGm+Anybw=;GhVaLRDq3RViCOIpJdv4TQTCcZQ
 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
 kp14u4jwnRGvTi2Kf6+6vGhvKkZwBVOjNaE=



=E5=9C=A8 2025/10/14 04:07, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We don't need to pass fs_info since we can grab it from a space_info.
> More details in the changelog, trivial patchset.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (16):
>    btrfs: remove fs_info argument from btrfs_try_granting_tickets()
>    btrfs: remove fs_info argument from priority_reclaim_data_space()
>    btrfs: remove fs_info argument from priority_reclaim_metadata_space()
>    btrfs: remove fs_info argument from maybe_fail_all_tickets()
>    btrfs: remove fs_info argument from calc_available_free_space()
>    btrfs: remove fs_info argument from btrfs_can_overcommit()
>    btrfs: remove fs_info argument from btrfs_dump_space_info()
>    btrfs: remove fs_info argument from shrink_delalloc() and flush_space=
()
>    btrfs: remove fs_info argument from btrfs_calc_reclaim_metadata_size(=
)
>    btrfs: remove fs_info argument from need_preemptive_reclaim()
>    btrfs: remove fs_info argument from steal_from_global_rsv()
>    btrfs: remove fs_info argument from handle_reserve_ticket()
>    btrfs: remove fs_info argument from maybe_clamp_preempt()
>    btrfs: fix parameter documentation for btrfs_reserve_data_bytes()
>    btrfs: remove fs_info argument from __reserve_bytes()
>    btrfs: remove fs_info argument from btrfs_reserve_metadata_bytes()
>=20
>   fs/btrfs/block-group.c    |  15 ++--
>   fs/btrfs/block-rsv.c      |  14 ++--
>   fs/btrfs/delalloc-space.c |   4 +-
>   fs/btrfs/delayed-ref.c    |   2 +-
>   fs/btrfs/extent-tree.c    |   3 +-
>   fs/btrfs/space-info.c     | 168 +++++++++++++++++---------------------
>   fs/btrfs/space-info.h     |  14 ++--
>   fs/btrfs/transaction.c    |   4 +-
>   8 files changed, 101 insertions(+), 123 deletions(-)
>=20


