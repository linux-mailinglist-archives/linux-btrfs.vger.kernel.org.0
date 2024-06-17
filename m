Return-Path: <linux-btrfs+bounces-5750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F7A90A2C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 05:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13EF281312
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F917B51E;
	Mon, 17 Jun 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TiVmIgaF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08995367
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593741; cv=none; b=Tjje6XRCvhRD0O3iK3yh9oOTZNtZ/8UjRdapzXQNfzKH/MkHW6Qv2OOlU5oCpX3Qy5Lpm/Gki7j2SsTRKZVycvOZHX7gNAszRRdXl99IS2Z7O94t6hc3+eRVNRmwz68/bgMJr0Tg+0PUKUuq7sqs6kg6iITu9TpGdssXJyNmJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593741; c=relaxed/simple;
	bh=5jRjtw576nDZv7F211Bt8zjuGPtP58UeXI13Cl9dvCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mE9npxqqnJHb52FBuZSibIh/IuZ7TIUK3nGaxw/b5y0uHHqLiJMjtCXfEZdYHO9NEiV8fQL6Kj098UORk4ofxVjieJyJIY3qvVRXB70iDdvxmSatnXA7nikr0yeZlJdd1JVbzm0pd0QeWKuFNbNNbgcmBFG5coIMPKH7m+GHl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TiVmIgaF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718593729; x=1719198529; i=quwenruo.btrfs@gmx.com;
	bh=AIxDn07Pn6duVL8HMrq0eOt+rHN0aEiLD9n68NYBbDM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TiVmIgaFyGY02W+vljRU9d1O9VpDLlFcbFNs0S4++u7c1Rb0nfqPv8c6P/iPMpVw
	 Q7Q87WgLxCdEviR/5LaFxOiBD9aeZu5PXTn3cWzR422I07QNt2QuBnQUITStV/Ivj
	 2r7LLxUmtMBO0eLLp3+lrkaIoX39rqZddS5wBL/Uk1PuORsctIiCxAxcnNnuNg6gg
	 brBJKGxigj9R+GHjWhYaI1l/TMU8PidwRs0WzET+KjJ9oZhOqU6LF10GA0TvUMH7S
	 FC+XwWvs5JWjNgnum48+4BHGRoDm9DiEWzCdJ/YpUtNppCHC35ydfDFUYoIv5vBOl
	 Ak9Yap9uIo1lvpSIcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1sezPE1q8O-00yF4D; Mon, 17
 Jun 2024 05:08:49 +0200
Message-ID: <7b732d3a-e893-427b-bc88-24c30a5a4702@gmx.com>
Date: Mon, 17 Jun 2024 12:38:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: use goto style to handle error in
 add_delayed_ref().
To: Junchao Sun <sunjunchao2870@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
References: <20240607143021.122220-1-sunjunchao2870@gmail.com>
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
In-Reply-To: <20240607143021.122220-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N2SB0144BvHcyYoEhdZ68K3JRfKR2fgFApWH7yesRmjJcOVaIdN
 PTsHPYPsDggPzGixgzlBtRgkFFfLFnDREHlPnz1ElGHP221+23WdFlYYeobyxA80kaUYeKz
 qgr8QTUso5Sn6oRUqAwRaGTXmudLV/rS6hDRxcMXdoIjjQSXLzdyVudwKbguJ1W2XKtSRd8
 KqOzDZXIW2Bx4Mo83uEGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9JVkWZnYRcA=;Mf/dlUdyId9SSJhXONeM8rpH/w2
 5RNBLxFg031lQpTTxfnhKFVLb8U8hxBLqMPPMM56OPnDZwSWWyABiZY8FNLMfOtry9DvJ7n9t
 kEVb2zzH+0zuT1XySl+61voDt/AXJSMFGVnKiT2luhvwk0Kgr4JFuopXWVu4LxOM3tvZADnLD
 GgiqBc1PnbQf7LK3p5KFDjwoQJDrOYgzMaRiyEXDLetKjBcpvTDcic34Vv8RYVLB0DW/XDz8Q
 dpzW7mSUz500rCtZIuHRmkl7RTb6lMFRfEoSIoGS5g1joD6DR0cwJN61dCYZYjEz2tgOvoPg4
 JFgZI+Yj6YTf2Bu757nRbtL/KzOMmCQzqbNhnDJy4oe/IF8uIR/W1nrztAuKdWP/M1T5TLkOH
 vzUvupO+j+cXdDFkx9QE+nFfXhtbQYSitSgePnq0TzJnXEvr+xTRLCT/062LPYZsakVedUqcv
 v2GPF8wYtWgLzGWT8JzXqI/7tz2PHP/YR4U7F0E9lpLETj6FGGKmIkao6c2nweEHx5hbv7WfJ
 L21H4/C8kieuW9p+5xmIL9na/089+HHWa9ASgbjMnoFB9EOxPI/8Z0t+u6j7VFmDKAgCy6TER
 FTiWX85nuqGNf1s/tbywT68kOszv+UO6MRveWH5P/fVMNEgUO1CgXFGEC4+/+h3Q6ik4toVKK
 F1YHrJXer/3vVEyzFbO4e53nuxscaOyOuJfPN5VDvL4v69+Muq/o0vqZ5TnfyM5etYebXdoBr
 jtlMEQzn+lTV5jOWz1FaW+giKcCNWZNbnJTPRL9YcVrfXcj33D0zbDxtBvn8mCulY3Iw9vgsS
 vUi6ATvBB2YsiuJNDAyVU6w33DMwAyVDB1gyRMJmXa/hs=



=E5=9C=A8 2024/6/8 00:00, Junchao Sun =E5=86=99=E9=81=93:
> Clean up resources using goto to get rid of repeated code.
>
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6cc80fb10da2..1a41ab991738 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1041,18 +1041,13 @@ static int add_delayed_ref(struct btrfs_trans_ha=
ndle *trans,
>   		return -ENOMEM;
>
>   	head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS=
);
> -	if (!head_ref) {
> -		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> -		return -ENOMEM;
> -	}
> +	if (!head_ref)
> +		goto free_node;
>
>   	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgrou=
p) {
>   		record =3D kzalloc(sizeof(*record), GFP_NOFS);
> -		if (!record) {
> -			kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> -			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> -			return -ENOMEM;
> -		}
> +		if (!record)
> +			goto free_head_ref;
>   	}
>
>   	init_delayed_ref_common(fs_info, node, generic_ref);
> @@ -1088,6 +1083,12 @@ static int add_delayed_ref(struct btrfs_trans_han=
dle *trans,
>   	if (qrecord_inserted)
>   		return btrfs_qgroup_trace_extent_post(trans, record);
>   	return 0;
> +
> +free_head_ref:
> +	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> +free_node:
> +	kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> +	return -ENOMEM;
>   }
>
>   /*

