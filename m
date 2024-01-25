Return-Path: <linux-btrfs+bounces-1769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03583B88D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 05:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E286F1C225F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA679E1;
	Thu, 25 Jan 2024 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G30gAYVl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4E79C3
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155269; cv=none; b=j26pg5Y6B9jITAlHaWEpQQCAUzcRCjKTloGzPlYttrIdl/mglgieJBamsOeLB/hQQD3lkAjIw/u27bOvJOuxhJ+0HbwEqK1GzhacKU/pS66Wk1Q6oeDWb3OcN/04KGN1bOyvsRpySQdz2sBFSG7Ym8iMJI49acKOTwOStIYkQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155269; c=relaxed/simple;
	bh=lGirp8ZnXAyplnnWbIaAo88afZoRTb3tAsP5nRBd7t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nXjmgofBaLs1GBkusPaGDduEZKyJs4QogfsVbKoU255/ayUiKCdQSioNbtqlEFQ0u85fjpZHSpu5lY3GTShipM4joobHloV54bftZ4Po949NKFT1cJXiONDkV6Swu7Aqfu4v7u96tPUWxtus8lx547A80/ORJYT0jJwMo6OQLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G30gAYVl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706155264; x=1706760064; i=quwenruo.btrfs@gmx.com;
	bh=lGirp8ZnXAyplnnWbIaAo88afZoRTb3tAsP5nRBd7t4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=G30gAYVlHfHnOBTTOcco1MLNOxp/2szm+c/SVFV44r/xauLWxCxDvpWyHZANBWi9
	 63OUdk+wHq5WHlX+gaKJP0nSYyHa1WcW213PNtyigpUzoQiP9F+tCnMEbu2EClQXi
	 mhftPOflWVf+fmyFVTjXsH2uZDKf9H/41OYBuLs3HrCq5yCE1cRE5noV02j6OmDel
	 k/uZiedrdP4+4xF+9CYClkp6BZF6KedmFudGpNfFk91vau2w3VDY/kgiWfhOznglS
	 7Mmo9EP1/TZ0RovDDgOWj5Jc42d5Df2aeb2VUWPNlsIrbpH6w2lt/a7kWh/8Spizs
	 GR1UXjYqZrpkaYYDIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1qjLc23qGb-00q93R; Thu, 25
 Jan 2024 05:01:04 +0100
Message-ID: <9da349b5-b058-44de-b8a7-97ec7df21fec@gmx.com>
Date: Thu, 25 Jan 2024 14:31:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] btrfs: handle root deletion lookup error in
 btrfs_del_root()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <a3879c9484eb245085f08fc90f94dbf027dbe22a.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <a3879c9484eb245085f08fc90f94dbf027dbe22a.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VF61/fTe+Vlfa9uc2BOX1ArlodRQb9ydcOsECEGRr6CP8p9Kq9T
 rfA45SEtnp6keXI8CiFEIFlmpVfg9Wg4s3CDQ+QPYpHf2lP08BlLGLJl4G7r0Fr7sP9D+d/
 X7TNwUf2gWTEi774xHAdsBdZFa5ibH2Bap6NRCqIaIWBrjhPwcKPGNUBBkH2AEI5digkqxo
 5NWgrgZv0E43Ca7LC255w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vOqxXdJ84Zk=;zmgcDbXojLcnIB86XgfzqS+Tw3s
 swnPNYvxq3FhCSKicgmQdbi6rfDCmMzrkYJXOIqv2m+6/J/HcpOsuM5szSor5ccHAfSznnou4
 QAzVd5OZRqlFmXHn/12SzClsAcg7ho4mnc8DoM5WvRkgWsYNKF9obxq5hKK04D60SJOVCF5U5
 w/tMKiXnTc1FKPexaYC/kGFJp3LiNVRNbBk/yCHaDqG6qQbcYMulSrB5mcEqjdIgu2xPifxcr
 w5TZxdeonMBmCnxLyaXvzdIFX1vIPpl1xAjKrpCiy5fg1Eh82OZmKQs/tnvq7Or8kmUsxmvok
 3rrYuZn09IlffXc/nA2sFwUvyxgp5iAmL9WBaLqPCzzDA/sCB/t5Q6kqWmDhZo2nFvv72USKw
 HoJLf/vlyXDzfg2OFyO0hRjwovQm5X4xufmb881WlHsqT2b1OO0Mt443WujnikEask1hzk7fU
 Mvv+6Df2U391LDiOytgK8iC/i+QAxdwXkjApCR7QpWKZ/Kao9/v+hkueQJ1rzV2xJ0Fi1Sa/u
 rESTyqp0myW1x+K/D/nSVvS+TrLcFXN+++ZcLI5gOb3k/4JwYORZS7kQqcQ3PalhF9ZlIEOVO
 1aeq0FgIrj79/LpTWNYcoNtUpcv0CeY1jX0xw27ot1v9XpEkeP5LGCpiecZVwKL6JAX4QHhCj
 b8GPA1AaE6HYuQVXa6qTDVfP6xyuOgAKLOPArPjp/EX9cUWIcEBnEjmtHtWf3ZPseBUIvs9yh
 6eFBSVT77xoNrYUlCHV3FrEKo+soYvS+qrysVGc3ofbiaeHDD9nAgPcm6gCLW9RTU8U00TGzY
 8kszIcrQ5xrfspQfFTkdHeJYObB0INDOrQrPI5adkAGPYdHF3aMrO4gLlMxfJqAi+MRtzImSt
 yi++ZfWTc/lRibM6d4Zvv0P29cOqD7fOO+g+LbTXQY0WPiW6sifYXmc+yul+z+Y0lN8z38/Sb
 ZuQ19LRVXaFDn0zu4QDQzWbSMEg=



On 2024/1/25 07:48, David Sterba wrote:
> We're deleting a root and looking it up by key does not succeed, this
> is an inconsistent state and we can't do anything. All callers handle
> errors and abort a transaction.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/root-tree.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 603ad1459368..ba7e2181ff4e 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -323,8 +323,11 @@ int btrfs_del_root(struct btrfs_trans_handle *trans=
,
>   	ret =3D btrfs_search_slot(trans, root, key, path, -1, 1);
>   	if (ret < 0)
>   		goto out;
> -
> -	BUG_ON(ret !=3D 0);
> +	if (ret !=3D 0) {
> +		/* The root must exist but we did not find it by the key. */
> +		ret =3D -EUCLEAN;

IIRC every EUCLEAN needs a message (at least that's the rule inside
tree-checker).

And the only two callers are also aborting the transaction, thus I
believe we can just abort here.

Thanks,
Qu

> +		goto out;
> +	}
>
>   	ret =3D btrfs_del_item(trans, root, path);
>   out:

