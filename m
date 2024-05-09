Return-Path: <linux-btrfs+bounces-4850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B08C0860
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 02:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0219E1C20F23
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F81843;
	Thu,  9 May 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ohJB5n/e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499964D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214202; cv=none; b=M54Pl1zfiR7LtlwTohEDnnPslDlpD80Pq9V6zW2HoxO/gIJ8C3upNl4GniK1Z3vnCEaoNoapryxBgeJolXhzYOXh52NORSKFtvLZ5YciWC3fqRPqpfNyA2o1j6+fJb2jHsib30mF19sH2aaHPA55mjinSaGd4BXkSlDEIQwz3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214202; c=relaxed/simple;
	bh=HDy436t21/KvO8BwpYX0KCi29cP6Sb5qsT5BnUWFwvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KPYFKwaAPymPlnL3jYnCRZLOeeItx22L1ybhZv4/jSu/T8gyaHkz5X7N+qYQNoYCBf6EOicviRqyICzXxs2H6HLO00UuQaPedj3dxCREy+eDDMaPrgsjudfqtQy709h3L6pWGgDzmSCqshK/qSm3MfvQY2qikUn2wZ9Y55t2I8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ohJB5n/e; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715214194; x=1715818994; i=quwenruo.btrfs@gmx.com;
	bh=Z7dWDfQ3hmz1gBt9Rn655fl3D5f+Wu4RmIJFKm35crE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ohJB5n/ekPD7UlJy08F/xwxSjuvk96Lk3xwNzbp9FziOc+jZzdRJaEU5utKp/dzV
	 Nxj4g36+xQW+MQ/SF9ERu5Ld87kXM3NttOQ8MzPMvySdvmY1q8XAb75EiJDlr7afA
	 1ZEhEkK1+xvkU/Ims2vFFIzxcT3L5Z6kYxjlTPWYmMa0stBnCCfnksmA2yc4dPnGH
	 sIISnWD5hLNBHBKxG8aGhjmFCHut4/0wu5hMHf2Fct2fukf3rtjP3mpisOzF+EISN
	 Yd8DHrsvrxHYhWz+4YgGWmFxpOV5Mc4scfCNdKUqdyZy2zVbnIF3dgNtmV6ppL2wC
	 SHwPBNBICZMSR+o45g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1seTMe1Rbd-00Ze6X; Thu, 09
 May 2024 02:23:14 +0200
Message-ID: <32e84f0f-a8d9-4b84-9a52-c0230d779de4@gmx.com>
Date: Thu, 9 May 2024 09:53:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] btrfs: reduce nesting and deduplicate error handling
 at btrfs_iget_path()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <ca3427c0ca2b7984b0d074531cc31b0433b7eb56.1715169723.git.fdmanana@suse.com>
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
In-Reply-To: <ca3427c0ca2b7984b0d074531cc31b0433b7eb56.1715169723.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8d0th9kwrXnDDnaTgctHg5yofAEYJdf3XfSm28HvGCItcA/Dy4j
 QdP3EcPePPqB8oJWWOKa6VC/7cJNPsGJxRMWeCnYirhLpKeJCS8p7FADDKsRXSYtTbm81mN
 6ynpkPS0bDXvuY/1l0zWg30bysEWlJ1NlRdS3M970nehf7OAik720Jt4mpUbMSEdjZmYd8P
 GqN8RJ3hvgSCtFIAlwiDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DPeDwjknzRI=;EnIfxV41TfJuf0CbV8rjYvqaXFm
 ZozECHk5srEubCDWizqTtdCUGoIDqqRtu5u4FqcW00DRHDPRLc6lSWYLaY55RfgAdvfW+6WwQ
 k2cCz7qs614rqj2dNTMbULbfVNDrEdekuMqleN3TeZygsbLJ+skfB7GqgInx9ju34NYG39awF
 21Afy3x5nEQ7W+0L6LizX5fAG8Zwd7k7dHHfcArJ99xXoVeBgA+/5xrwMaBGVg+JPK0i9KUUh
 f35ywc8f3hdvp5NqO0rIbsXCMmZPU1QTgCicJZaPOfjHFC6s+NbHLxrItV67NInQj4T13/2r0
 xdPKXT4HMD8eFrertImglU5iqI9AHUu1LGtitb3bzZS7U6KfTx7XKC1ZV8vekfSvyirGWbCYb
 DUiz2vQYdaSI/N2hqxj1cwfqY0WfcJr0/JoV7dtg9zeax0440C8JvHShWZ9NspenMFmmGXIRl
 Bol3CELSiJWO5+LcZb2WMgwTRv/gr3QF5W1MWD1/IXrd3EAlvbjzhjBkegmWqHEGw24bplWKd
 tB/OK9mfs95VJUz/pWK23PfHXuZkpQhfvVJet9pVp0x3crC/12VKTuD8MR8zWxhcyF8q1ftvE
 pmC4pcmurKrL197xLJa0pi0xVakLQHFcuwgrFAXgjI9qLuDfJpOQPdHdRnBLtu7x5ejKcPyWS
 6ucET2OMdqaAvpuiWf/Ig5nxGEtcdG2v79z/NkwZ0x5QG7Bv6ZaC/PtNct01aQTLeDt5QqIEo
 Bhi+WTSgFenR56gLdzt+8XFSxDITKejKva4425nf1qTAxR6GIPX1+0wG4M6xDq4EX9sqx0GEP
 76rQeEpkqUB4SmZMgg6XCEoaX3HMWZwoOwwBHhzqoDAyY=



=E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Make btrfs_iget_path() simpler and easier to read by avoiding nesting of
> if-then-else statements and having an error label to do all the error
> handling instead of repeating it a couple times.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 44 +++++++++++++++++++++-----------------------
>   1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 85dbc19c2f6f..8ea9fd4c2b66 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5598,37 +5598,35 @@ struct inode *btrfs_iget_path(struct super_block=
 *s, u64 ino,
>   			      struct btrfs_root *root, struct btrfs_path *path)
>   {
>   	struct inode *inode;
> +	int ret;
>
>   	inode =3D btrfs_iget_locked(s, ino, root);
>   	if (!inode)
>   		return ERR_PTR(-ENOMEM);
>
> -	if (inode->i_state & I_NEW) {
> -		int ret;
> +	if (!(inode->i_state & I_NEW))
> +		return inode;
>
> -		ret =3D btrfs_read_locked_inode(inode, path);
> -		if (!ret) {
> -			ret =3D btrfs_add_inode_to_root(BTRFS_I(inode), true);
> -			if (ret) {
> -				iget_failed(inode);
> -				inode =3D ERR_PTR(ret);
> -			} else {
> -				unlock_new_inode(inode);
> -			}
> -		} else {
> -			iget_failed(inode);
> -			/*
> -			 * ret > 0 can come from btrfs_search_slot called by
> -			 * btrfs_read_locked_inode, this means the inode item
> -			 * was not found.
> -			 */
> -			if (ret > 0)
> -				ret =3D -ENOENT;
> -			inode =3D ERR_PTR(ret);
> -		}
> -	}
> +	ret =3D btrfs_read_locked_inode(inode, path);
> +	/*
> +	 * ret > 0 can come from btrfs_search_slot called by
> +	 * btrfs_read_locked_inode(), this means the inode item was not found.
> +	 */
> +	if (ret > 0)
> +		ret =3D -ENOENT;
> +	if (ret < 0)
> +		goto error;
> +
> +	ret =3D btrfs_add_inode_to_root(BTRFS_I(inode), true);
> +	if (ret < 0)
> +		goto error;
> +
> +	unlock_new_inode(inode);
>
>   	return inode;
> +error:
> +	iget_failed(inode);
> +	return ERR_PTR(ret);
>   }
>
>   struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_=
root *root)

