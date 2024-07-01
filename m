Return-Path: <linux-btrfs+bounces-6117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A691EACB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 00:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F471F2250B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C616FF48;
	Mon,  1 Jul 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qw1D/uSK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8138394
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872604; cv=none; b=oOwmFYzMbBZUjsDM3Q4W/g4ChnhtgMO56cPiWPVDDO/msRueuCphVtaxf0G56ovHCyEKGsq3C3jbSR+NjolqE0K75S+tfS3hx7a8AL/+owmQD5tMk+u0MgScS3LHqj7Vslz88IXymRbeak5bV5DaQVj4syS3E0MkS8ZlicdwUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872604; c=relaxed/simple;
	bh=IdqJdV5RJ3Ilm+lMVjwYkjPMfxiz9vVR8U6CsVStMPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NrTJzN11SyphAPHa6GPJ4E1yCZebzaCulX0dDG6+xDS1qQB0OSc6Fd91XJoXM9HJQRycKhQLnyxdejxDOOuimm6eY25mh3zSsayxCqBWw8fd4lkik+YNhHhvcZni11iYmG90sMAm6NbrK3kqVXmHLgp78DpZYaYOHZABHaUDccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qw1D/uSK; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719872594; x=1720477394; i=quwenruo.btrfs@gmx.com;
	bh=BC4x78yYYfF7xF3idNWLGKoLheEe+uxMegJnO6YWr8Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qw1D/uSKKA6jyWf0zzBbTKcRO2fXGlaYw3mlmmVlCQ1nODdTuRM9WtsNf0AiEk2t
	 yu22j19Af6NJmP4+5lDauzfb4U05xbj23MUiv2SY63+OP8XQ9DW4Ni08Q0V6DI9YP
	 rTsx8tcM0Yfz1rowKlmk0EGTZ4JaMHzwhKy/Xm1PoTO/MA36epR23VZloZ76QIbvq
	 CnoPIsQv4F7U3pA/Y+tapFDbqDKWRvGq0rZ00hC6cMTEKgRntjHlrcEtzZ/lfhAII
	 OG/2/DLuqke6GiDDsaMLxz5wgBd3FROFpsNiELG3pdNOaN0hxNkZTttkm5EUZ9L+p
	 KntPVtzFBS0IgwIGgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD2O-1rtDbU0CtG-00eotT; Tue, 02
 Jul 2024 00:23:14 +0200
Message-ID: <d23e6527-7a68-4aa9-92ca-66423ebf0ba1@gmx.com>
Date: Tue, 2 Jul 2024 07:53:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix __folio_put with no deref in
 btrfs_do_encoded_write
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <5d7a3eabf63e5c60a8ceb243221bc8778117a8e8.1719867140.git.boris@bur.io>
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
In-Reply-To: <5d7a3eabf63e5c60a8ceb243221bc8778117a8e8.1719867140.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pkl287lNU7PgcEBzTpfvvZHmE67fzKse2Q9m45rKgK7vsC9z3q+
 Pxc9PjnYbS9VTLGbzm4DVm+UuVLbI7uvvdd+wJSbgrbTT4j0tFrqBakOmr+ePFfmKlIhB08
 SNtdfLDgTB+gS8kQcjkvzEiKXjJryI4IL+H9adKWTHfKt18ObZle0/32FdzRYg4efDPuH48
 WUrtcxkHVE/BF/6E1z/gQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TpuuXnnZENU=;0bMK1IOqErvcvsR11tY49n7nAPh
 U6RTA+G69g/FUOFv+oXxEBXkbDUO5U98WH06iupE5eeflyg4WyLBfiYxv5scKNNf7VCSYDFXk
 vSSQnyG2SChn+c1k2NQBR9kTABPZyBrV+q0sm1mS9mBQFkd/Ge9mOSidW8BNYeEEwiGbPtmS4
 jVnBifNrXoNfOj2dDtmRRD0BuYb737u37JEwSJqInh58HEUrsvmnz/p/i1fcEyDwUUHiBjwqL
 MERCVClXihQhqfAaJxbp3CzIOAmkDzOylpBaJRUxJI7DWFdFdJ1DRf7Muqh1zHswzQUPuGzOz
 Qak897CqBm57tc0U5oLBRWsP47azd0NcN7NOMbfaZgDhpiCpa3hbxl7iUuxuf+Z11RYyqWPoq
 8IXWlAAjelxOr3Lze4et0swc5qwzrGwAJcimVa/C+zYvDArkIi83xclQ2kRQ1EHtMD3fHRA+o
 JZ0s9dD414WoFdynkRqZc4q7I94+9pTsTVRxaw+63ISkpSqfyBrB5NbqaIg+3HpVHXciBPwxJ
 0KrOz4AnpGEX0F/gDfzgcvcBHcO4lul/i8YfH2XpjxGQMMkMbkpLRH07ZcrcLSKmdhuQgRcRb
 +uBY/O/xceBtzVI0dEz7PhjOA4SBgxsWWO/3VJvV1vx8AgN0Tsi7TwQhwopvKV3HjjXrFeG+8
 rgiB2As5zMuX1d7Ag558tJRD4cHFZMzvgPR7HRkxOcHyMUqKmFXrZiVQiO0AjnGw7lCcZCBid
 bys0FdtjmpBZfNXVH+ZmGJekeQ1cXsNPPOE1HRry/mDRsccQZS2T6VIL1Lx1OBogZxRNAeLsJ
 tDFc8ccLNbJWuK7Aiw8jSplr5OWqskFM66ZF5gTDMJrOQ=



=E5=9C=A8 2024/7/2 06:22, Boris Burkov =E5=86=99=E9=81=93:
> The conversion to folios switched __free_page to __folio_put in the
> error path in btrfs_do_encoded_write.
>
> However, this gets the page refcounting wrong. If we do hit that error
> path (I reproduced by modifying btrfs_do_encoded_write to pretend to
> always fail in a way that jumps to out_folios and running the xfstest
> btrfs/281), then we always hit the following BUG freeing the folio:
>
> BUG: Bad page state in process btrfs  pfn:40ab0b
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0=
x40ab0b
>   flags: 0x5ffff0000000000(node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
> raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: nonzero _refcount
> Call Trace:
> <TASK>
> dump_stack_lvl+0x3d/0xe0
> bad_page+0xea/0xf0
> free_unref_page+0x8e1/0x900
> ? __mem_cgroup_uncharge+0x69/0x90
> __folio_put+0xe6/0x190
> btrfs_do_encoded_write+0x445/0x780
> ? current_time+0x25/0xd0
> btrfs_do_write_iter+0x2cc/0x4b0
> btrfs_ioctl_encoded_write+0x2b6/0x340
>
> It turns out __free_page dereferenced the page while __folio_put does
> not. Switch __folio_put to folio_put which does dereference the page
> first.
>
> Fixes: 400b172b8cdc ("btrfs: compression: migrate compression/decompress=
ion paths to folios")
> Signed-off-by: Boris Burkov <boris@bur.io>

My bad, I should go deeper before doing the switch from __free_page() to
__folio_put().

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for catching this!
Qu

> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0a11d309ee89..12fb7e8056a1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9558,7 +9558,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb,=
 struct iov_iter *from,
>   out_folios:
>   	for (i =3D 0; i < nr_folios; i++) {
>   		if (folios[i])
> -			__folio_put(folios[i]);
> +			folio_put(folios[i]);
>   	}
>   	kvfree(folios);
>   out:

