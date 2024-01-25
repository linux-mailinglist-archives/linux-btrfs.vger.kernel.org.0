Return-Path: <linux-btrfs+bounces-1770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61883B88E
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 05:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8041BB23668
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A57482;
	Thu, 25 Jan 2024 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KIm4Bcwg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFB63D1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155441; cv=none; b=EuLd5I6uQdi/V4h6wANHisuyfMSZjyNTeNq+RWp6eaj//KzHZrU7rvB7r9L7tblSOKUbpqiCaYnRDrhtFcjxK2W7UG2azUi70roG5msOTcsB6AAfLGh5tC9mFDmav0ynsNXs6VISS8DfKFUk/BeoexOdmEAovazmPYLsMGtN5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155441; c=relaxed/simple;
	bh=xUQrBNduSzwwx5GeVtZedFsZF03u2umR8IbxbLyF/xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vb2C9wpNvwieiB/n4qF+tQGtqr5U/F7wkgy3Mn2cVYJ8EbL/f5/uaOHv2thkeIqcrg5AlbCrEx93ZPzAn53XyvxnVTbnVo9c3l9qQt9w4pzAFp8QRZpB7y7vKdKKlffIOgu0mO45glDgfHJLdoYVePTKF8/uMvk+rhxH9UPdcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KIm4Bcwg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706155437; x=1706760237; i=quwenruo.btrfs@gmx.com;
	bh=xUQrBNduSzwwx5GeVtZedFsZF03u2umR8IbxbLyF/xY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=KIm4BcwgPuBfDwk6xdvkVi7kgJrJXY6bJM61UkDcfRCu90nku+YXHPVfMpsBpEPD
	 UnO44FPi+9vq03MHVTf7rDU+NjQaUPQFUtw1ZapyHpktqTAIGKx+usmrzADn6uGm9
	 xEkUiMY48ZhCNvDKFlkAKb4ATD7SPHpMrSyQegVaTyUjeFSKk0tTeJi0DxgyZ+bbV
	 l4vDYVHIqmQLrfeIzp0prGgtQ352esk4FbOEEGdBsMEtcnDTosBh6it0aLPMpcY8o
	 fqDFk2GngMYW9CncBruvFbVSQy3IzXuNUAkwuPz4eOktdyP0tb2YAYqCNVAivTjpF
	 TQcLEUedBMuKOXuYqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JqV-1rSZqv1g9p-000PBO; Thu, 25
 Jan 2024 05:03:56 +0100
Message-ID: <73f3c94a-7661-411a-8c86-f309d3acd329@gmx.com>
Date: Thu, 25 Jan 2024 14:33:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zvkXjOd+eMlxBfea7TqFLdJ7a6x0Q0gh95Jc904nLmozMTdZQyz
 dIb5mWoBgdH7rUsayhaVFIfIbYfYYpSj64RnNR98qdn6DHwMYfgjO2BqzE64ErZX2qphBTe
 PiXtWDwu6Z5PBWr6JfQ5tNnn6vHnrRJJqfJ/TMiirZ7C3fP9dkbih2UrXZ1w8TrKPu8kw2v
 KlEuQp1HMx33lEKB++VkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pTp/lSox8bc=;pI67GAlCEmdrdXikwS3xtWmi7U7
 K7NEMHKjjskC1KFscq4cseBBqdIYaJ0cYjZKBZd2/5bB5rEUWgxlfPx3fqGVov9nUd2cOXu+c
 9WEqDOnyvkqA/GlNDm624lg2W8YQYW+YfTYXv3bV+ku9XbTWH7xbVgbrPAsxJlFxyA+t305tR
 0Y+ogdxdwfwTLFvHGnbcBNlFzql1f5Xgf1OBwEap0IQrEmTaRr+IjeQiFXtrqAsEbYhpvo803
 hPpOmy50P9MQ/+lrQVQOiGyKrlOOnwRBSYHdj4Gx8iCWLe2uCOofeD7HcX5N8r78yUji7Gup9
 Mx+dLgsKcyLkl0uZxNildbKFX62yVSQMh6Co9V1Jn8BidtK26Ob/IUQoMfHx2HougUbaICvYR
 c00l2xgug9PWklDSsPBCl3eZt9ISZHybNT3evxo8Uso/rT4w8z3kSor1CHpJTkrlqtMmTaaY9
 e7eR1/+igNX5Z6MkwKDA7+2UbaG9uV3laWfiDaqFm9e0zyv1Qm7wOsNyKcdpZ3KDeMXp48hM8
 kXsS2s7fiDNd+H07SVnPPRuq5uiqM1xiAVBNUKnN9jkUE1yyIAzyAVAnIyQHm82f38yW2ikUR
 nsf55o/uiBrTdZAA//DEDG3Y+3cNZ4ikJ4vd7pCVz8wAi6RUDQUfTAwsfj9Fof55fJuVZg+st
 3n91FGAGz3rZxgzjZmOa3mnkvq/7O2JxCnKIhtSGsupjkPCzCgkxauVD9XNJLSs9eYNNPc2jC
 6ER0EcHTrjyLYRxkF9cu9e+YcuBBNa/ADcy7xUbebrsGl2mHe2jIEJKgDImq1jTiLSJKRfDbt
 1RlDh1ZnAIvYEccxwscNAcXOYXDe142az60EOz/XduuZOpveNeFdGr+X83//MVFCRongXbfeJ
 T8kD4XfcAi28RjKd8DJxrrN1BVfgoIpeEBj98oGodYPL5YYQGepzkf5284SIWykvcH9ro9lkF
 oouAuA==



On 2024/1/25 07:48, David Sterba wrote:
> The btrfs_find_root() looks up a root by a key, allowing to do an
> inexact search when key->offset is -1.  It's never expected to find such
> item, as it would break allowed the range of a root id.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/root-tree.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index ba7e2181ff4e..326cd0d03287 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const st=
ruct btrfs_key *search_key,
>   		if (ret > 0)
>   			goto out;
>   	} else {
> -		BUG_ON(ret =3D=3D 0);		/* Logical error */
> +		/*
> +		 * Key with offset -1 found, there would have to exist a root
> +		 * with such id, but this is out of the valid range.
> +		 */
> +		if (ret =3D=3D 0) {
> +			ret =3D -EUCLEAN;
> +			goto out;
> +		}

Considering all root items would already be checked by tree-checker,
I'd prefer to add an extra "key.offset =3D=3D (u64)-1" check, and convert
this to ASSERT(ret =3D=3D 0), so that we won't need to bother the impossib=
le
case (nor its error messages).

Thanks,
Qu

>   		if (path->slots[0] =3D=3D 0)
>   			goto out;
>   		path->slots[0]--;

