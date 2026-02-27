Return-Path: <linux-btrfs+bounces-22083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKM9LDIComnPyAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22083-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:44:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BDB1BDE56
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 855A53057497
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D3477E5E;
	Fri, 27 Feb 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lE4b2yIF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0E38F920;
	Fri, 27 Feb 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225071; cv=none; b=kkE2aaNwpzht10N0QDgvjEO/j0E6vN8OYj9Pf1jxZHzk3oysQVdMzOFN6VUEUPj9L/MbaVFA6gC0nXBUhNfK3iDbk/TzaxaGqYGD4j9d03Acz2mG/H4UL5r5tPA/l8XCCMZpNWRVO5BZk0jLbmezfShsicEz5gDXdmpiiOlAIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225071; c=relaxed/simple;
	bh=REI0Z1FpILMYtTCvvnMPwjrZHeiKOCOjSWe2rsPgFH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9t0XPrKmu5mtThjtIQO06O7HrLGyRDBqyKYBrndB3DK4SmmNQDW+z8VpyeH5QyT5relOuOCcyku8rFd032vzEoAczFgXHG+qMTio2VpSoyRPGq3fzbhUxDJH6wxrW3JptZoCs8b08qTFpt3t6AX1fJyynH06ZpmqERdvT67ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lE4b2yIF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772225068; x=1772829868; i=quwenruo.btrfs@gmx.com;
	bh=vieuEO7hxUJWds8h7wkn+eX2/wsHCHZYyoAplu7VYy8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lE4b2yIFLoD5A+fwhqHoVAqmRxWVJWXRYIunRNnmK8EVAiN7X6n8J3h4sYXVQi7H
	 UOu1I/74ZhNt1vIk05KGRsGabY+/7ztL2tvDjOVq1nrEkvQICdu7p5ZyilA62EiGY
	 iXk90/zKu+9UbG5iM2RXJ8uKW/lun3IeMwLcYV+oxNXnlv2JsuGGbXYq9hU+T6OPy
	 jLVZ/Jvq+aDwnmYGXFepdgkrjOCtv6YIEE0yqAwvdzK6mjAjh1B3asOgplC08BPf3
	 6JRqPJ/fAvnuG5+lZtQQ2b3+MmRh1BAXQ4li+IyQuAgHmb8mKjGHhHSAG4B1QTrlT
	 hi5GIfef8pVlpLUQ7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXtY-1w4yfD0eqe-00P6jF; Fri, 27
 Feb 2026 21:44:28 +0100
Message-ID: <24efa2ba-44c7-472e-adbb-60f2e0200ba9@gmx.com>
Date: Sat, 28 Feb 2026 07:14:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: clean coding style errors in extent-tree.c
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227183111.9311-1-adarshdas950@gmail.com>
 <20260227183111.9311-5-adarshdas950@gmail.com>
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
In-Reply-To: <20260227183111.9311-5-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5v23luAbZbcCWTCRWBcbs6Hv8rE0f2QBymfKjrKinbgGDJrf6F
 Hm7Tc2FdHOKDXvcVV6Tq9eCPOLqNwkjh6fNOCJDjcBlqJ0KgGdcE5z6QLvqNGKFxucWDlv7
 q31JYmRnHnY1yDVrn/3TMBAUL7uu/MtuDNdrnkQD2W4G7kzS7wNpLnWnKSiwfD7pineeDXm
 Z8NAhcGfDTyx3AXaFQ7Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fXTLsyR7N7s=;CXzr158syvr24HTWXyXF8sCIIyc
 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
 VmxMrXzw=
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22083-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 44BDB1BDE56
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/28 05:01, Adarsh Das =E5=86=99=E9=81=93:
> As the previous commits are changing code in extent-tree, this patch
> takes the oppurtunity to fix checkpatch errors in the same files. All
> the errors were formatting related.
>=20
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>

Just fold this into the previous patch.

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 9748a4c5bc2d..8ea88174e4d5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2111,7 +2111,7 @@ static noinline int __btrfs_run_delayed_refs(struc=
t btrfs_trans_handle *trans,
>   			 * head
>   			 */
>   			ret =3D cleanup_ref_head(trans, locked_ref, &bytes_processed);
> -			if (ret > 0 ) {
> +			if (ret > 0) {
>   				/* We dropped our lock, we need to loop. */
>   				ret =3D 0;
>   				continue;
> @@ -4351,8 +4351,7 @@ static int find_free_extent_update_loop(struct btr=
fs_fs_info *fs_info,
>   			if (ret =3D=3D -ENOSPC) {
>   				ret =3D 0;
>   				ffe_ctl->loop++;
> -			}
> -			else if (ret < 0)
> +			} else if (ret < 0)
>   				btrfs_abort_transaction(trans, ret);
>   			else
>   				ret =3D 0;
> @@ -5676,7 +5675,7 @@ static int check_ref_exists(struct btrfs_trans_han=
dle *trans,
>   		 * If we get 0 then we found our reference, return 1, else
>   		 * return the error if it's not -ENOENT;
>   		 */
> -		return (ret < 0 ) ? ret : 1;
> +		return (ret < 0) ? ret : 1;
>   	}
>  =20
>   	/*


