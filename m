Return-Path: <linux-btrfs+bounces-4996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81B8C5D9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73677283CAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72949181D0C;
	Tue, 14 May 2024 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AJaByG/x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3A181CE9
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725261; cv=none; b=AElfo9irsil9EaY82EV1uTtCowv7vM5s/h38l5ggFob+lDOqxV1Mj8Oh7/ssuCd62UDbGcN4K5/bI+bFwYgUHUwNHopnmXkbv6U9JZDmtDgGI6movkBOySRclsk2gff0pc3Co7wqYax8eGgKLlkVF9ZRfALuclrnjqbqZfhqIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725261; c=relaxed/simple;
	bh=9QONpUmRmtO3THjFb5Zbxc6LF2F4s2LvT9KuW3C30fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cUowNOyo61hvEmAcfQbQeIrW385jyUqrZzA1PMzZvFmXsaj30K4HGhu/DhzzrbinDtxfPG2MfXU75ASyocrJ2evWgt/kmko6azpagq2UYzipPfeGGVChsr5q+U5I77ebOWDiUvlvqR2Wz4jZTem/3Rw5CJ9jNSJ6sERxkKz2Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AJaByG/x; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715725253; x=1716330053; i=quwenruo.btrfs@gmx.com;
	bh=FWyC9o5WbCfdqGejHThW+KSZpM7DzZMGlJ0xl4tKVVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AJaByG/xO4e41fyqKFtJlQ1/4BO5lp7DM/ij9MigJkYx90K768lxhrKqYjzTmAm8
	 ddZq+ahfYBBX/Y7aE+T6CwwukctBF/mePQTqXcrQsWGiaoQA8C+67J/aj/QKXeZAO
	 GZd9jKK5bjSrKAuS39eeHyuRvQa3AoNP5MOQzJV0P7ACtKXQ+EcPlWXD0/S13WjbH
	 Hz+H/llLvOrh8CsQoY8I/Mg1DUyVB+QjN34TJQoxmLCpzxoikhdMnEroOvfuRUi5s
	 dQnDqrvkplXNP6nm3PeAdt3N0A7caCMkadM+KZpqGUSgdqjFNBR3S0DNeV4A8PMw4
	 cG0j3uMx3m4RGzTSWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0Ne-1sr2aK2HQe-00kLI5; Wed, 15
 May 2024 00:20:53 +0200
Message-ID: <551fca0e-b599-4c25-82a7-bd06ed64184f@gmx.com>
Date: Wed, 15 May 2024 07:50:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix end of tree detection when searching for data
 extent ref
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <d025098ef2c013545df5f37ef85128805a104571.1715699835.git.fdmanana@suse.com>
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
In-Reply-To: <d025098ef2c013545df5f37ef85128805a104571.1715699835.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmUYfz/qaXi9501aLF9W+asOdqyqnplv/xU24k7WstAXATKULUg
 6Jv8ESbSPmgxmiblyt2PUb6clzfl9tpG8N/gDL+hMnLZ5uZe+fo8TVwEFBIE5QJChqn74Dt
 s3Jqe1/HJ1hCKazcBXQCeCtlZViS+Sy8ue+KjhpDpkcjQgT6+3z53TbJAi9J/y6RiSC1H7R
 Cv0F6K0H2t5h9JhEIrhZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lnLBcJHa3No=;47MTO3MeE5IS3+VsEz1AjH8hpJu
 BXeGx6EyqVLtGoEbsIdFBFjyJyMYxrXaaCeIfhCMUAIjLGGROTOX6XeVqhZn+f73/00o1jDP6
 VHuh4qr/+p29st7g2UcxDjwioO6t+ROXVme2LhBtmqNcawoeXZRt2Cqr0/zy0si5nNXp+cs4Q
 OMAIy9VZk/qgpI6uCv5/7K7jRTogByfHaQ2Bqhdpau+QkDG/WQyaJgfUEXARLPVez0XAtllQr
 IReECgn24dJ1xhG46XldYCxBvYkaRShnygrD5m6SpWW3hGCNjaTOMKOdqTUmBORTOkePFwuNL
 P9d2n43RV9H0ekvk1zZ0VSB0rKk2SsbJmfXHPXnYlde8RHj5JVhdANOKVir5b+31OiKpg9M3o
 Lm39pztBCXjcu7mhjpLBaj1ZSapFGk+wkIqb6FbGp4wrSZiqr1d6FFZ7KqvKqgYdmAo24PXtj
 aCujVj510z3Spy+eo2pDmOY15CibOeNBgFHRsrNdeu2YtS5tD0djdJq3u0L0afBaPXyldzIOS
 829gIx/EpSz847ycvX9isRS6RkUhhZo3leuzimX7Q8RXPfuDRXPeuhsLtPGTMaJtXSpK3Gjow
 PLnX1acmi5C/ApBaNFOM6F+TX5Tj0OTyJ1ksNMxkk8yc8pgZWnkZ8pi6MvaP6MRN9VDD5OlRe
 cKcjCPIQ6B7GaGjvaFTs6nqnDnRmR3HGBeQq4cG/t3LMeEgI/TBZe5rr9h780e5Lov18vrAgz
 EPj60j1tTyH8zd4FTV0akJHozfifF6c2AjlB3/wIZcVim68keU79hLmhFHRP69aVH4zpEAJFs
 wwVPxxlVfrvlFh6+Ugcgif/EB9tdxTKm/5WTBzWpR0Afg=



=E5=9C=A8 2024/5/15 00:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At lookup_extent_data_ref() we are incorrectly checking if we are at the
> last slot of the last leaf in the extent tree. We are returning -ENOENT
> if btrfs_next_leaf() returns a value greater than 1, but btrfs_next_leaf=
()
> never returns anything greater than 1:
>
> 1) It returns < 0 on error;
>
> 2) 0 if there is a next leaf (or a new item was added to the end of the
>     current leaf after releasing the path);
>
> 3) 1 if there are no more leaves (and no new items were added to the las=
t
>     leaf after releasing the path).
>
> So fix this by checking if the return value is greater than zero instead
> of being greater than one.
>
> Fixes: 1618aa3c2e01 ("btrfs: simplify return variables in lookup_extent_=
data_ref()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 47d48233b592..3774c191e36d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -477,7 +477,7 @@ static noinline int lookup_extent_data_ref(struct bt=
rfs_trans_handle *trans,
>   		if (path->slots[0] >=3D nritems) {
>   			ret =3D btrfs_next_leaf(root, path);
>   			if (ret) {
> -				if (ret > 1)
> +				if (ret > 0)
>   					return -ENOENT;
>   				return ret;
>   			}

