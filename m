Return-Path: <linux-btrfs+bounces-4205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DF8A3C2B
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A34E1F221DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0D39FFD;
	Sat, 13 Apr 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c+j5hFQu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42A2576B
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003165; cv=none; b=MzTbAKrMJKAqat5u9fUquqaFPSvQSRaGys1/UxdXpDWD36DRsDoc7St1sHaJ68q99W6DZowIc5EPI2NRFaadzvgaSK7CDuxEcpFybXYwccBhXQiliIonC+0h3TAfhlDFPUn1rGTfsOZzzB52tIRhHSCV63iN2zf9/c8xFIvTWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003165; c=relaxed/simple;
	bh=VZdD2kAPNqNlsbFS535f7YBC5skN8b89ikG6g22JAso=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hcVK5ibmiaYvuppad58M5OncXPSwhkPDOORR79Me+FYLDHUxNhnGeZ1E8Dx3/gC9kPlbr0JKZVQdrqf00SAnPRn3rH7EMQjC/vIfEu2/Xy5SyDG+sMH1XmaTZMwGxdFH9ATj/duD+2nRNNuT9mcsmZUXPPOXsb0gSptj4YI+UJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=c+j5hFQu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713003158; x=1713607958; i=quwenruo.btrfs@gmx.com;
	bh=suCJdn1mVSuwof4tKi+5lE9eATKQ60fcz1PJebiTsss=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c+j5hFQuZO1RPdEip9U0vgMrW3m5Gnh3s//2sMZ1mcrzZkSlBGIpHJ/lA2bHA3hE
	 MwM8kP+OGo6990lKYYHyGXeQzgrzZShegvd6/Y9Zcvw84kWlRc0SftcVsA9FSlwIy
	 pBWTG+sMtr9G9yJ2RjBPY/RdGNLlUwhPnN+Hzn6LV3ZseMUiJkJ2pW9+Lmykbt8Gy
	 Y13K94fk6rtaPS3WzldIV78loXE8OH9URp4IXOLJvYz6gKA75NmeFfW+WbpwPIIKq
	 uJuE3hTovv7AseV4gqMHwL8ZS1kwFyh6WLGML6r/kE2kyqy+wQtgCGXUB1SOqwQGG
	 jbd3O2w/ntSYNM+HOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1soNp825Sl-017ELD; Sat, 13
 Apr 2024 12:12:38 +0200
Message-ID: <d26e9f50-e935-4479-a6f1-1d3db48e9a0a@gmx.com>
Date: Sat, 13 Apr 2024 19:42:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] btrfs: simplify error path for
 btrfs_lookup_csums_list()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712933003.git.fdmanana@suse.com>
 <d5576134584be460ba386627ee5853fcca5c2edd.1712933006.git.fdmanana@suse.com>
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
In-Reply-To: <d5576134584be460ba386627ee5853fcca5c2edd.1712933006.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2C1+wv6DO0gC4XyNpqqGNGKirIBsQTV4UtMEUM16KhGzei9/Zy3
 +MCO0Mc+x2A/awzlKaRsXl7grOY7JmA/XbJTcssl8J0C5jlWgLNVl/VSd4ZTYFikAnfLO/J
 8PhEvrxowKvbK7XSs5OHdpzl0HtHAjAmuE0JRF8m+EM241x82ypUj7pHSB+enLYLcoQfK2O
 qW1ucrdpMnYEeZmUlfEkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ny0kiB5ndQ8=;4pxfCEeZdkPtysvhUmepZwNhqTx
 HFHHnAAjc5Oh9o9IBa71HnDathQj6/f6MuJN2FbudcaQw8B6a8X8gw7ZMVLM0qiH18fW1xzby
 cQ66qnM1KVUiJYJVG8xnXkAgWqfuWsZdWIuga4I+3TCkKaJf+EnbclivcuXxyUyxeA5b5VT48
 iMitlFL1MBrf5BfdzZzluRay8197PWeYIV7vKu5pwXBUh+yPU9reWWDDA54jQ7oqm0V2hvQhC
 hptBkLnyhHeu28TGWs+QJeAQfzFJTahF5nXNiE8jvekPiWbpW9/URVb3CmtVLJJI+te9Jvo5O
 OkOy7862qijV+nIjKXgNJVm/7kpwgvyX/vZ7b53dCbzDINnsEQn0qYNtRKMn2q26dOXJJqtLR
 s0KzpqoswJlqIxTAlnZT6mS7rBKAAGj3OftEkcW00Q/YFsghOAx9sIS3y0urW/s3MAYKmY/za
 eyl4AN5h0or/Df3ZYQS8FzrAzGqM2r1dPPGlZa846Dhx8ed//O8vFE+e5r2l4XYD7jbBLrRRk
 rBuIDHKnBa41rFyUdZIPqe6ioibAz6TQZq7lwhAgwreitSUvFha6/Id+nyfW0qDVGbR2e3QGa
 YDNxvnDdOzPwCIhgHH4NrYf7DyKnnQD7iL8moqEr+hZqNwjwQTDXSP45/1HIkEHZDgEuWoRnT
 l0qxP5XRoNBJw70AdFOmg2RKXyRgoF4VJ6SkljYXYE6wBDGk4GywR9Uj6jrfTahy3UL9+FcNN
 kLmWNQ2Vd3ej2GJKGisF+3fDtn+NA0IDrnVYkxCpBT4qCnUtpUPN2vCeiwMIGjFN5J/lc8E4v
 0o7y4+3QA4Svr8QGp1wVbEJ5ZCWh7o+3a5ZlmXAK9sxvI=



=E5=9C=A8 2024/4/13 00:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> In the error path we have this while loop that keeps iterating over the
> csums of the list and then delete them from the list and free them,
> testing for an error (ret < 0) and list emptyness as the conditions of
> the while loop.
>
> Simplify this by using list_for_each_entry_safe() so there's no need to
> delete elements from the list and need to test the error condition on
> each iteration.
>
> Also rename the 'fail' label to 'out' since the label is not exclusive
> to a failure path, as we also end up there when the function succeeds,
> and it's also a more common label name.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/file-item.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index c2799325706f..231abcc87f63 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -487,7 +487,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root,=
 u64 start, u64 end,
>
>   	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>   	if (ret < 0)
> -		goto fail;
> +		goto out;
>   	if (ret > 0 && path->slots[0] > 0) {
>   		leaf =3D path->nodes[0];
>   		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
> @@ -522,7 +522,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root,=
 u64 start, u64 end,
>   		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
>   			ret =3D btrfs_next_leaf(root, path);
>   			if (ret < 0)
> -				goto fail;
> +				goto out;
>   			if (ret > 0)
>   				break;
>   			leaf =3D path->nodes[0];
> @@ -557,7 +557,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root,=
 u64 start, u64 end,
>   				       GFP_NOFS);
>   			if (!sums) {
>   				ret =3D -ENOMEM;
> -				goto fail;
> +				goto out;
>   			}
>
>   			sums->logical =3D start;
> @@ -576,11 +576,12 @@ int btrfs_lookup_csums_list(struct btrfs_root *roo=
t, u64 start, u64 end,
>   		path->slots[0]++;
>   	}
>   	ret =3D 0;
> -fail:
> -	while (ret < 0 && !list_empty(list)) {
> -		sums =3D list_entry(list->next, struct btrfs_ordered_sum, list);
> -		list_del(&sums->list);
> -		kfree(sums);
> +out:
> +	if (ret < 0) {
> +		struct btrfs_ordered_sum *tmp_sums;
> +
> +		list_for_each_entry_safe(sums, tmp_sums, list, list)
> +			kfree(sums);
>   	}
>
>   	btrfs_free_path(path);

