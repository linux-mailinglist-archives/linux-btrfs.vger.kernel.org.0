Return-Path: <linux-btrfs+bounces-21812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJRKOR3HmGlgMAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21812-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 21:42:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4116AB6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E3CE3018401
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E672930C345;
	Fri, 20 Feb 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="q7joQdiW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07655309F09
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620121; cv=none; b=LOgLYdLXzpeNede+wo21qdb08rEyAgJq6/82Q/w+LSN6Qiz7aE06g7y1sUobfNUjtz/x/6FOCrnFlDytF5fUIOCZNBN0vdJVLKx9y8rCzUwtgBhyAcaoCerVlgaJ9zAEeHGQQa3/wWu5FRWfUGop53ZJ9UnzzbsiN2UttuWPiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620121; c=relaxed/simple;
	bh=/jJeIreVRydBSFy7K0O7MS1Ue1ooQizxX/TDRqNjXCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XGb7NvAQsndIeRqviJJ669qG7oRnLQ8Ie+k+gmtW6+OH5ApeeCSIELOyYobnP57amBObVm8MZw/ezrOpai9hZVgDH32OPvKT5g/P8ZU/EtQNYqV1D3MOFNvrJRvwTvlgfZZHkRiRJG45eRkaBxJxCCrsXSNN6XuVleneNVcVQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=q7joQdiW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771620117; x=1772224917; i=quwenruo.btrfs@gmx.com;
	bh=mm+R7vYIMaqSR5J/MxMnlH+YLtFI3FUxAW363VcBDUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q7joQdiWxyPU5NIemU/295zpRGPdkMp8awKGf88DzRevzgrJdW1SEXg9v77bO1rB
	 53lOvCW8oofJnUZMt+K3TJ8Ya8hpB2+rQBxYPwF3MKYzTAfgmOEhQs3iKLz81zehb
	 UqqxLX0ZMNpCE369XBVQLpdtMuCQjtiRmRG842Wgo//W/mjKizIK/E6fjO9TjwxFA
	 8nSZYuNgYfsf7TrwfDu/dy4JpXH2GgrFBeBCQR8BJPg9Ohp4wuVDk0JsyJWMAP0Bb
	 nGvqciNZ3xYFDhXXd2vb7ELvb8D3ctvlroRFYg24VVbcPdFqQmfLW8VCcSqpnrsh6
	 kerzOWbqbP7sbGzHng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dsV-1vhYLm2KFJ-00tRiB; Fri, 20
 Feb 2026 21:41:57 +0100
Message-ID: <6ea99497-10bb-40a1-9432-11c59cdf3fcd@gmx.com>
Date: Sat, 21 Feb 2026 07:11:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix chunk offset error message in
 check_dev_extent_item()
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
References: <20260220113013.30254-1-mark@harmstone.com>
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
In-Reply-To: <20260220113013.30254-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NMpsm7u87sAnVAADf6IYTfuUwKfZeJh/QJ/paBnbpPpi5Z0+iNK
 IU54StFgbB0vnPbMkpfYE5OpFuuVPURAwI8pYD5j82Y0co9jTMo9oANTg4dGOW+rFWkxycl
 w3jDsWCUZA2mfHiY0AfY+78WWFQxQqko8H5pUK2p2Ls2GfCDMBZMACC6t0qIxmDG+g/6wq9
 4P/BeQ7rZlJ+tx3rYya7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yXnKxlYuKzc=;3nPbm92aitmHL9TbdrDZadyCZzw
 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
 Pn/5mr0eKSRwqiWnKF3Esyv0K8ZzC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21812-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 7FD4116AB6F
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/20 22:00, Mark Harmstone =E5=86=99=E9=81=93:
> Fix a copy-paste bug in an error message in check_dev_extent_item():
> we're reporting an incorrect offset, but actually printing the objectid.
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: 008e2512dc56 ("btrfs: tree-checker: add dev extent item checks")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ac4c4573ee39..133510f99fc5 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1899,7 +1899,7 @@ static int check_dev_extent_item(const struct exte=
nt_buffer *leaf,
>   				 sectorsize))) {
>   		generic_err(leaf, slot,
>   			    "invalid dev extent chunk offset, has %llu not aligned to %u",
> -			    btrfs_dev_extent_chunk_objectid(leaf, de),
> +			    btrfs_dev_extent_chunk_offset(leaf, de),
>   			    sectorsize);
>   		return -EUCLEAN;
>   	}


