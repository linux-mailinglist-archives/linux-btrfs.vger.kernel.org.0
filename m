Return-Path: <linux-btrfs+bounces-5789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D1590C934
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BF1F21B11
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719D15D5BF;
	Tue, 18 Jun 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rJs2cxId"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41E13C3D7
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706052; cv=none; b=JbZCvOvOPSDJ7FejMLfVQjerrA/5Q+eMqxrTxULVxFUnfS6YlWDgoRpOXL8jCHnpblt5yyM/SuALCDDMDoBeJFOPSW0wEPvQwXEpDfv8lEqcMADNOG3nQonVjhTSPL15pjnhFgBIvqdx2uBjBmpDpTk1simr3MnpVBTa1G+H66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706052; c=relaxed/simple;
	bh=Mu+C3K2nQAdn8E7dOLl0VRAI1ACyWvrK1U3q0gxTLfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pgsKgPYDjKqVC9kJCVB5PCPdXUZ4IUFwDhQUkWCL/dHrei4/ILrZUZYNR6zM3YQLrVF6Oi1aSn4f0MmOcS84gjDKL0/FhL8aWBK3NjQXsSx/keXnBY526Urj0Z9W5xfFYzr8RDR1jUBErbOVzxCCBlc7Es2t7GD5/B0Jg0ZtGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rJs2cxId; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718706044; x=1719310844; i=quwenruo.btrfs@gmx.com;
	bh=oqvu3DpTu6czILeoWV5EH+dKY9dymbEWzB99auzHDPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rJs2cxIdz/i8TjGFce5rnjnvqIp9OqRhY2+N/s7INxCrSEWcpf12/60pFO3u3rjj
	 kM2Sq0ePb3IPBw19hXK1xIludxCc+A9fc/loe59TJ2+n87YNr4wj8kJKaaeQ9iOfb
	 qTE+tLdia5AOIsnlx/ENOULNKca2DCA01VXjFyFMv2fkVfhUmFmfYBuZusFXCTB76
	 YLcByNVzxJcic7FX/BNs+9PmjsJ7yd0PPxCZ43f3V6ByhgiDtLGsWzPH1pZ7DERa3
	 +zksGVeRApbfQGQkte74plZd+oESax8rV1b5twFxxyk2Pw5PUGOXl+KPu8jqmocbe
	 7lXe9Bh+CuAmxP1r5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNh1-1srzYT1ejX-00ejQ3; Tue, 18
 Jun 2024 12:20:44 +0200
Message-ID: <06cf04ea-9b40-4329-addd-3aa3467f0b28@gmx.com>
Date: Tue, 18 Jun 2024 19:50:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove NULL transaction support for
 btrfs_lookup_extent_info()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
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
In-Reply-To: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s9ovKYb92jFf4P1Yw7NQnH1yXwrNhlgmqvJEyH/T3ZHXSGwDly+
 p5hPRkxhgD2c6DdP/EbWhmuLUKmRcyp0g+LCtkSyZC8fxOgFAmw74nBZ9XAUnM5M7xXLpML
 yZkAjaQ/rBCNkuZF74UYT4n6z63o7Kw6K1cz5iUTABP/Y4AvN2oCBzH/DikkcGiWh1ygFwG
 j9N1paxq9SRBnc1QJy01A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KYgs4lc7Gr4=;q0Di7XgCDxU5O72FPyNdSUXoSSd
 vc4jK8rr+HfB86yLNxJzpRdg/5kiba9swskFMkw7y1pJDiA/c1gpGXnrjoELcDUWAGil10iv1
 j75AVHNt8UQAIValHZE1hvot+IckHSpnow7WP1leqfbLr0pb48KvnaPy+yNHsYpG5lyEwTzZW
 3crPvBY0TgY3YtiGjMNl6YTzYWfWfU8fAA2B0nSDSG3Ig4gToPoNWdK4SzlleO6s49LAEEt6H
 7ImLGRafH2qlqxD53lBBrljjQnoFVMM0aM0Y0jCwuKzj+akJ1QXNFr4+ZYNR/ya/DVw/dkplZ
 RKX8X2e2x+JwpUV7TkjtWf3Up9OOPU64hPRFLs6Saui+POhn18BLlnFBAFP6OE+WNEMj7Hd3S
 5CqAeMlLBSQycDVnUgx/6g799ozraqMmdgIvSnVJj1ihcImcfhkE0/bQdzqoHhk9UVXgHS897
 htGW1weQkRdAcA7W1vXwWr2mjoEePXei7kF0l1L1L/HzikagPjfKT0teDFBcg/0i5aHhyZpXB
 QQp5JSIl9dZMaIpZdhNnqU9olKiMRVu7/JVuZZc6DdnG1e8SDYwYHrWrN9CIAqKpSrmm26LKE
 7DQD+SisyxJF3OTln/B1mPsf4mhsFRLtfIrXMVwYD646/Iy1uh94Ko2AHOtQcqvSwYeeU53HK
 5ba6cWnpoXDxKvgxHU0RuuFgRPfr1jQ4v1q+LqBL9jdwwcVuNIEbDSarjKAGMQC5BMBufhu+y
 by4kC2lbfRWzJvY0pc4ajYp4iofgVocyKi13wqMDAn4fB46U/pMekQWPvxVZM3JHVkK5GCiuv
 MEXLUZKFuXkpUuTmMG816oNhnTkSb0NOy/9t3NINsK+I0=



=E5=9C=A8 2024/6/18 17:02, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There are no callers of btrfs_lookup_extent_info() that pass a NULL valu=
e
> for the transaction handle argument, so there's no point in having speci=
al
> logic to deal with the NULL. The last caller that passed a NULL value wa=
s
> removed in commit 19b546d7a1b2 ("btrfs: relocation:
> Use btrfs_find_all_leafs to locate data extent parent tree leaves").
>
> So remove the NULL handling from btrfs_lookup_extent_info().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 58a72a57414a..a52e52144fa2 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -126,11 +126,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_han=
dle *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	if (!trans) {
> -		path->skip_locking =3D 1;
> -		path->search_commit_root =3D 1;
> -	}
> -
>   search_again:
>   	key.objectid =3D bytenr;
>   	key.offset =3D offset;
> @@ -186,9 +181,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>   		ret =3D 0;
>   	}
>
> -	if (!trans)
> -		goto out;
> -
>   	delayed_refs =3D &trans->transaction->delayed_refs;
>   	spin_lock(&delayed_refs->lock);
>   	head =3D btrfs_find_delayed_ref_head(delayed_refs, bytenr);
> @@ -219,7 +211,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>   		mutex_unlock(&head->mutex);
>   	}
>   	spin_unlock(&delayed_refs->lock);
> -out:
> +
>   	WARN_ON(num_refs =3D=3D 0);
>   	if (refs)
>   		*refs =3D num_refs;

