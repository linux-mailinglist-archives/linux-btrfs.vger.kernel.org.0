Return-Path: <linux-btrfs+bounces-6647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AACA9396C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 01:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822FE1F223C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD5A4776A;
	Mon, 22 Jul 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ivOMOTOH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97A17C7C
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689426; cv=none; b=mu067cbB8lng3K221pyHgm3iCvvCAhY9xMM2aE/pYteHMNcynvDtBdxkEAv70r2u4RdwX1zfsej6DCjHZORxN2uC/AiaqhVIB6Youy8ZjyQPPOdMn6xLPQ+WWFGJxktdOwImdYWYbag+y4Pq5FgNYsrlREXyjGub865iLdrRySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689426; c=relaxed/simple;
	bh=cJYCG/OhC7ucu5tELi5kfS9FzRI37YNmGaOTxJpl6wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O56sSol3sOibQmDStP0hLVLrhRa9tz03r/fhg/5VENtV/LEgu4+lGP42wZw9CT2fw3YUPcR08ZTSZwKWgooNIYysgomuEBppyI9qBM8+QWUSOuX5nqutR9uSXoREMm/Upr7MmTROIIn1HrsV3he59OrBOPxl3uAUHEXGybxVrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ivOMOTOH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721689419; x=1722294219; i=quwenruo.btrfs@gmx.com;
	bh=eSMAdD5ShinnxHsJ48pJWPFxlepRlXSxfkcvP8Q9u0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ivOMOTOH11NSsPpCs/iveJkEbjyAPAtlijku6q4XAa2eOUqMLmrWF94OgPT4+bMx
	 XtmTZGoI5rIpW5ADOp83r/01G5MDD/VPHp2bjQt3LRTaQW9lJvrqNW93AOIW9p5x2
	 0//lN1/ArqEtJJKc7Sve9OjMKnbXAOQn7BAz0fb1SvnTaE/ObYbg9K+ehYlhUwUU8
	 MwBxJdBlw7BUx/BXEzLTJCyno7cXwOng0ooSz1BXthKXvewTW2AM2xdtjfJ8DgqU2
	 F+dcxlQPrUEGGfSJO2xwn1pOWzeOsIbSosmGlW0RkvofTbFnEpslL9g1rsUUxMbGW
	 P9p8it6UcsPXJfIxYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1ryLDd1OQM-00bRAV; Tue, 23
 Jul 2024 01:03:39 +0200
Message-ID: <aff55683-8e3e-4d25-85f5-f28339aa4dc1@gmx.com>
Date: Tue, 23 Jul 2024 08:33:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: set transid in btrfs_insert_dir_item
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240722133320.835470-1-maharmstone@fb.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240722133320.835470-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eoUXKK68lx//eYlui3J0jUvWyCxL6jZuhZVogvCIa4DTJvZ1pDo
 BHnMxEPA45AZlMrrB6QAWFXViEvgwT273daikhkKYuyqssUoTm653NHdui27UNG0LgzUpXD
 SCY5yGoa32gj0k7+O5iG7w2Mq6RzPK5R4zTwVQnRxz4FgtF0Lq3+SoPZ0M8U6WKYr4ud5Pr
 kilmUe3mO3tAKZoXlQKYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GXQrZGbNz2w=;TT5tQCdJFKdxQZT0lgJOhVyoZ6L
 3acCr/RnAxI017UxGacouY54dQiXmoiVmjTzr/6HSdAaTwC8eociy7d7WKxOiumVr4QUAPVxH
 broLsv+J4iLJmnQJPY/toS3bHFP9l4ykFRUcfdRxSqJmNvRS4w6Q1kclaI85RKJGVoBuXb1rY
 7cH7AbdLT7ZqLPk+objy7nwiS9g8XmEencu02aLH9piRuIXVnCb8GKYWinUhhB4s8YYUFF0x2
 ehInGXMIhyWTZL7LbT6RqE46HBtWzf/02uE2jqRr1GPHajER1mO5HPTDYJbOmLQTWUwwMD9Di
 HzAeZF9lHaJu7vxKeUYXrIfmAlcbFaA+nJafFz47uzo5+1BfLWHLUPyVnPrBX8RYQM5Vx70/V
 hRff9+o02qP+8TazYVlxIeOxgyVVtlLTUhytZWU71hG8/A70uygajo5vfrR53+XNBGjv6885R
 3ZWDnjHYMZIeUXlOvaqd680H/FGs9t8NG+8awUnf8Z6+y77S9Zp0I1V+sIg+u57rEd2BMfw7a
 cGOubiousIKQw9J+fxziAahJUiruZRK6DZBP8Bjehvfokk5nZB6IH4ws3EgGukGeTjpn3i47j
 agsCUQgMz12d1PCbnDiZ1ZPR74VDobNjXKPvJDjJ46e8cwiocxOvU39w0vUj13A979RUE6iiF
 86WGHw8Ck69Ag/hP+UZgDbezOoqqGgpdvoldUO0lVqrysspM7Y4vEF7C793nh6j5sLtTsL1dT
 plh0GFI1JjuGUvUUH6V9xtN4XI3QMGQN3hPh4QODqF8bnUyZdatNZGitBIlzLIcu9O/fMJkd0
 Cxd1YgkGPvFdLOhQGxbdnOeA==



=E5=9C=A8 2024/7/22 23:03, Mark Harmstone =E5=86=99=E9=81=93:
> btrfs_insert_dir_item wasn't setting the transid field in
> btrfs_dir_item. Set it to the current transaction ID rather than writing
> uninitialized memory to disk.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/dir-item.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
> index 4c62597b..5e7d09e6 100644
> --- a/kernel-shared/dir-item.c
> +++ b/kernel-shared/dir-item.c
> @@ -27,6 +27,7 @@
>   #include "kernel-shared/accessors.h"
>   #include "kernel-shared/extent_io.h"
>   #include "kernel-shared/uapi/btrfs_tree.h"
> +#include "kernel-shared/transaction.h"
>
>   struct btrfs_trans_handle;
>
> @@ -173,6 +174,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle =
*trans, struct btrfs_root
>   	btrfs_set_dir_flags(leaf, dir_item, type);
>   	btrfs_set_dir_data_len(leaf, dir_item, 0);
>   	btrfs_set_dir_name_len(leaf, dir_item, name_len);
> +	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
>   	name_ptr =3D (unsigned long)(dir_item + 1);
>
>   	write_extent_buffer(leaf, name, name_ptr, name_len);
> @@ -202,6 +204,7 @@ insert:
>   	btrfs_set_dir_flags(leaf, dir_item, type);
>   	btrfs_set_dir_data_len(leaf, dir_item, 0);
>   	btrfs_set_dir_name_len(leaf, dir_item, name_len);
> +	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
>   	name_ptr =3D (unsigned long)(dir_item + 1);
>   	write_extent_buffer(leaf, name, name_ptr, name_len);
>   	btrfs_mark_buffer_dirty(leaf);

