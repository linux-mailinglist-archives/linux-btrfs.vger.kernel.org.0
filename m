Return-Path: <linux-btrfs+bounces-8554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACE9901B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC271F22591
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA59156C76;
	Fri,  4 Oct 2024 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Hj+wIeAe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2D13B5B7;
	Fri,  4 Oct 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039428; cv=none; b=BpeNC870iHYQeUQtcqbYPZSQuvJWDFs22i59M1EB9TCYjy/cNLu6yRfno3S2BBwtRt2MVuEarxBA3tZ2jyual+NMshxBRPnhANsujNFVERa/mJjaYeKEcmo13zoXoRFIhvQXzKG5BwZ4RAN0h4DV5cft/odjvqkY3WIGXtfIUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039428; c=relaxed/simple;
	bh=eb52MeZ5/aT1GCwF5NcVQ+kFxaTXTIpnpTKJUrLlbeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMw4dr7MOR2lHYo4TODml+Gwff7VHX5CmU96wCJCcbuZnXqr3bbaz53nRr360BHURCzQ6VYJ3Z91EFvbTjuJqlVWQbkrRxUIQHkGsN30DVUZooULjUo+42iSR0BD5TWAn2yoVURwprUm1nIyPN6PjkjQjiM71g6r6uuFgu3Caq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Hj+wIeAe; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728039411; x=1728644211; i=quwenruo.btrfs@gmx.com;
	bh=U/4Vt3Aob1zk7qyucu3162PTeTZLjehtvOpwuoaODuA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hj+wIeAetQrxy1Eyav8Vt5So8Zzq/7xpbicf3sxyHxPox0O7vnv7+pg/p8ENwKpE
	 euySAXAzmh2oSkgeUjBRyNl1ueVOXRyYxVuT2vKLN8Go4fwgCr348vbNAhg9Z0RQ0
	 TbCu6BOmH0WTaVclK1NJNbz2uhPbrO/I5r74Q2XfB3WctETm16gg5DcEkxdYtbfg+
	 ozdLBDfT/xPu0El7EnvrKLqCYb7RFlZEhcxbcaHAr18TJVGsnbPkwf/yi/RqrEMje
	 4b1PvDdi5f5VsDGhUE3E8MXlIKsT9DtexwpDnkvBs8PwJp4xaQ3HZ+29iHTuAt9Y9
	 jcfSpkkaNJL4M6Acxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrhQ6-1s96503JAK-00pf3P; Fri, 04
 Oct 2024 12:56:51 +0200
Message-ID: <6f6f9521-a724-48ae-8695-5af7227427af@gmx.com>
Date: Fri, 4 Oct 2024 20:26:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: don't BUG_ON() NOCOW ordered-extents with
 checksum list
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
References: <20241004105333.15266-1-jth@kernel.org>
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
In-Reply-To: <20241004105333.15266-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4VTj0tOWT5DGbTJiTOOSlHAga5EiZ26pGQMtP0eWn9esC6/kxL
 GyoFdh7NmYjXbVbFtVpyvh1Xoam6DrA4H6QdQe6ULiMoza9fsInZjpL0v/ut/ywvyLEmL0X
 nhNQlNrWyTbDdw3hkriLdKws42arYuKfHp0NjWVCANIPxYvAFi3BuPKRzPfvp4lBnd1HCFJ
 anP1zQxsuwr63Pix1Ht3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CWtKdr+ERYs=;nUqzWwFWgi2OIpYAIGVJ9ReU7lF
 mqt4wjvAjaFbUrCzgWNt04tor1L1yKBaZel59G2JYsAGhbhRSRmvMYHwobtuTpPuvs9AjvB2h
 PIlpXlAEndE5Vf29548/D0TwQ25XZVnvK797Qrzu2I5C3YKpue+mBs1dk0z5sgxf4CppAmMLZ
 w+wf3SrXZhRwn4fNLrt1uyeWacMpFQ27DWQiey11qCXrZ6WcmNcY+GobTiecC/BPIgG/zgiyS
 x+L0/CiYczFrEd2Wh72/XsAi7PjTwGy87ZUWpeukrhVmkTFUlPtPz7cR23o0HWeWb1f2YswAw
 NbsDI98+8dQXV9+Ii3cArRuSNmH06vcAvpjd9RvzE+OALqNJV6pj4Vl7U4GbrpjYeFkqv1OtB
 D/jwXxsnIkkpiehhwAkavCtOwG2M2JBrgxKVxUU8NeqgVFipJJae+TJAtGVKHtKL+FfvJ8PK+
 iymRgF4r1ANdRY8ofcvU0Ak+m+HMPxJO2RyCgwAIuk1sTPY/oIHl+igMOlklqa2Yr/USYvEXh
 PA9zUiqvY0i+pH3nVFL1yfZQhhY1qdw69YoF6qgJu9jrhmnA6M9buiHbC0Q7NeUM2WaAelIUI
 GEMz1+yYqApKs/Pj4Ppa3J641yil53919A5LpfxFMTxrndEB87MOV6NOa/72nLs8nYALStyNI
 Kt3Kt9h2O79h6XYHOqK/a2mQUICvKy4gXhfumTrkd/qaBEGsdlKferIE+tjmeyDNLzs/jwWKf
 HfiZPJ/RpfXHHyJdte8m1GCPWrxFpxMgIaI+Rp1xhMBxs+UJym6++tksKdITXGGa1m/DagXAi
 NnvqhHvNbOvJ+b66ZexBTwVQ==



=E5=9C=A8 2024/10/4 20:23, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Currently we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
> ordered-extent that is flagged as NOCOW, but it's checsum list is non-em=
pty.
>
> This is clearly a logic error which we can recover from by aborting the
> transaction.
>
> For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() tha=
t the
> list is empty.
>
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> Changes to v1:
> * Fixup if () and ASSERT() (Qu)
> * Fix spelling of 'Currently'
> ---
>   fs/btrfs/inode.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 103ec917ca9d..e57b73943ab8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3088,7 +3088,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered=
_extent *ordered_extent)
>
>   	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
>   		/* Logic error */
> -		BUG_ON(!list_empty(&ordered_extent->list));
> +		if (!list_empty(&ordered_extent->list)) {
> +			ASSERT(list_empty(&ordered_extent->list));
> +			btrfs_abort_transaction(trans, -EINVAL);
> +		}
>
>   		btrfs_inode_safe_disk_i_size_write(inode, 0);
>   		ret =3D btrfs_update_inode_fallback(trans, inode);


