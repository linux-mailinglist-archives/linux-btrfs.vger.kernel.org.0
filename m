Return-Path: <linux-btrfs+bounces-15379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5753AFE4DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 12:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D17B16A05F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75129288524;
	Wed,  9 Jul 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D3j+utso"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81B2877F4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055372; cv=none; b=Q0DNwktG0oS8K6VQTq1vZvQKxXOhxNzTdtULtSi8obx4Jh6eJvBBkJW2P8oh/ednjQN33iLOQJpjN7OR84XTTurezzF3EvscS2JDRQYe/kK6nL6Iym1j2se3B1rxUSKC7Fi73j9qfNrr4vaIMyTI7EkQwiz8PxeCWd9jPCTBzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055372; c=relaxed/simple;
	bh=SEj1ivMkUrJxXiYV9AqJA4gT/bfNDi4tMj7Om6kLG3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nJXi5N61w7J7PsBR67ldx4YlZS2TfH5mTHv1g6ATqF4y7bRkonQXohFmpyoO69LVOh5kdTQL6k8yOTmziEySKlO7RTErWn+zTrQjBaakNNolG0V1nQUX5qlJAhLPhVb/x4OIDE8oW6/hFToz2ejbt9ynvug+fOd9UQEicqKkWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D3j+utso; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752055365; x=1752660165; i=quwenruo.btrfs@gmx.com;
	bh=Azdtx5aZhvEojY13uBWqtbRCTeysuFqgiitENFPM5IE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D3j+utsoxHBuRuolrYgK1fRVI6UGbtfQs/ih+yzQq0IqlrYGES+oUtRX3G3oNHoY
	 NzEdPLlmlhcCdcsCqTaRin51ysR/nAorPryJrU6CIGYBhVPVTb2OL27OyanuZVzNe
	 wc8gM0zwlofyMvz6S1tS978/FMictFwQEskCHAYsp3nYFoPFsBSiNtoj9rqafKgz5
	 8N66VKELkEGOqJmqxOohCOHgi4HNHoZjwpcj6jWr50vzbYdr/gZmNXdnnMfsWREZG
	 LnWhRZW/aGLI0a1astCNAukV2AiwpQLigSvv3hovM3rtY20jDfSeKtq9y+a+Kd11v
	 cIXCh8XNViNYLyNjIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO6M-1v27Z50bk0-00n0S3; Wed, 09
 Jul 2025 12:02:43 +0200
Message-ID: <20489128-ca79-48be-9b43-dc125dfb9659@gmx.com>
Date: Wed, 9 Jul 2025 19:32:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: use variable for io_tree when clearing range
 in btrfs_page_mkwrite()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1752050704.git.fdmanana@suse.com>
 <a8b95fa1119a5cff19ccde53ffc182d2441c1172.1752050704.git.fdmanana@suse.com>
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
In-Reply-To: <a8b95fa1119a5cff19ccde53ffc182d2441c1172.1752050704.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5bh31kElCkUG26yYUxbkmnKOETVNZyFEpAM7NUId24cW1HMOe39
 6uRg1m+/4Qq6EXgVAxTEkhhKFl4sYd6UUA1F9QMKZv9W/o8rMD5pCiWt6a+Vs58UxRlb1Wi
 qtjEBMwhWWgMQm2y96nzVUOzsXT9p7bvSAx1YozCgvH481T1DAy9mN8ElH94dCkZzjMzwLv
 glRihSb+NdjE0SIhvGbRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xFflp5LJHOU=;zxCpMuEEMHwOjh28gNyDO+BVK0w
 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
 ng==



=E5=9C=A8 2025/7/9 18:23, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have the inode's io_tree already stored in a local variable, so use i=
t
> instead of grabbing it again in the call to btrfs_clear_extent_bit().
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f08c72dbb530..e76e92873de5 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1940,7 +1940,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fau=
lt *vmf)
>   	 * clear any delalloc bits within this page range since we have to
>   	 * reserve data&meta space before lock_page() (see above comments).
>   	 */
> -	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
> +	btrfs_clear_extent_bit(io_tree, page_start, end,
>   			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
>   			       EXTENT_DEFRAG, &cached_state);
>  =20


