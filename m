Return-Path: <linux-btrfs+bounces-20354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF6D0C45F
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 22:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E69302F82A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6F33CE90;
	Fri,  9 Jan 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HL5qMBTv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B519E97B
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993380; cv=none; b=u2yRqRKPHXNriy2BEtcz/Dc0nRRBw9cl6eddJoTEEaboJt6TWCMQGmTzumVIhc7QYVZzncQtZx06wpXE5bRCrawtWyQ5fLuPvRGXVE/CBSqKPRymkC7ZUmcgpsYk3IrTwUaNS0tVikWf16Err0p7CmC0AnExrLekHI8xXgQ80+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993380; c=relaxed/simple;
	bh=zLumlCkeAexMCk2A+pGA5gs0ZWK3pbT/tBwfJdWxAVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FVmUF8ZW8YEBCw13waskWTxDecAScsbIIEmavMtwBcK2i6EMaMD0sAvx38az6WNuJny1JLy6dasuPNlLW0Ox6HsMGegZNu/pCBuosTsMe1Fc8h433kmEfoFbYoFVixhya9UJ6EDue6pmrUk7RK9tgLP0A2GArwk3yLEAuQBPxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HL5qMBTv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1767993375; x=1768598175; i=quwenruo.btrfs@gmx.com;
	bh=63ADv3iK+YV1m4OsdnfQ6deTl9243E/gRe1Trww/XRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HL5qMBTvdayCoDZ9TwAZs9lWyAdf02Wi8+ZMlrLc0rgc42uU7mKG5WpGArR2NVwz
	 HYV2iqfqUW8N7/S7y4O7LOuvRNl9+WfA9DfSu+k4vvsjQBb5vgICiP1XbVBvLE/GE
	 mmaWDshX+fFFUeLu+mwU6TS1gqV12OE7B703mMGod9qHyShdpznIgUhTE+h7tfnei
	 VK1SEzAqdSsE9zbxssqE5eh4FtEXGK3i5L+s6u8DZaapptOJPQ6ROeRoMTL0UJjYm
	 Joh75SLbsOHP1aed19UsUPnE9vkcUo1W/N9mHAyDOAYr68wS5kMQTGBLwC0XDDPWI
	 /FWRZ1Rrdlzn97SacA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1vhMF002Sz-007FjN; Fri, 09
 Jan 2026 22:16:15 +0100
Message-ID: <60a3f79f-b337-4309-9689-3ce0dd90e69d@gmx.com>
Date: Sat, 10 Jan 2026 07:46:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: reorder members in btrfs_delayed_root for
 better packing
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1767979013.git.dsterba@suse.com>
 <4ffb0817d978715cb34cef429c797f211a993551.1767979013.git.dsterba@suse.com>
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
In-Reply-To: <4ffb0817d978715cb34cef429c797f211a993551.1767979013.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RGNBezAMNdSGd4VLmEtdnvTiF+Oskubz1BAA1ddW+TTeECdqT+b
 +29pIlc/P0j1lN96Mpqau998Akjb10G0NyPtv0lBUl4XqUdWsU5dEqoy1TT7FgxOXxw0Xk4
 1I4aOCxoFZyEBYKZ4SEkAWHD9IVwSLXO+AuAyBGADbJJV9YsX8u2YQf8Tl/Y7Oh26SXTKPI
 pv/udJDZVTjd9a4vDf1wA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qDpiz7w/eQg=;h86ytUNb+wCK2uu2dPJceQW5tR0
 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
 LFlrQEMTx1e6TzB49zCcuWkUd3TDJ



=E5=9C=A8 2026/1/10 03:47, David Sterba =E5=86=99=E9=81=93:
> There are two unnecessary 4B holes in btrfs_delayed_root;
>=20
> struct btrfs_delayed_root {
>          spinlock_t                 lock;                 /*     0     4=
 */
>=20
>          /* XXX 4 bytes hole, try to pack */
>=20
>          struct list_head           node_list;            /*     8    16=
 */
>          struct list_head           prepare_list;         /*    24    16=
 */
>          atomic_t                   items;                /*    40     4=
 */
>          atomic_t                   items_seq;            /*    44     4=
 */
>          int                        nodes;                /*    48     4=
 */
>=20
>          /* XXX 4 bytes hole, try to pack */
>=20
>          wait_queue_head_t          wait;                 /*    56    24=
 */
>=20
>          /* size: 80, cachelines: 2, members: 7 */
>          /* sum members: 72, holes: 2, sum holes: 8 */
>          /* last cacheline: 16 bytes */
> };
>=20
> Reordering 'nodes' after 'lock' reduces size by 8B, to 72 on release
> config.

Not a huge thing, but can we put members in descend order of their sizes=
=20
if they are properly aligned.

For this particular case, wait_queue_heat_t itself isn't properly=20
power-of-2 sized, but with 2 32bits member, it can be shrink even futher:

struct btrfs_delayed_root {
         wait_queue_head_t          wait;                 /*     0    24 *=
/
         int                        nodes;                /*    24     4 *=
/
         spinlock_t                 lock;                 /*    28     4 *=
/
         struct list_head           node_list;            /*    32    16 *=
/
         struct list_head           prepare_list;         /*    48    16 *=
/
         /* --- cacheline 1 boundary (64 bytes) --- */
         atomic_t                   items;                /*    64     4 *=
/
         atomic_t                   items_seq;            /*    68     4 *=
/

         /* size: 72, cachelines: 2, members: 7 */
         /* last cacheline: 8 bytes */
};

Thanks,
Qu

>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/fs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index dd4944f9a98553..4d721fbd390c55 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -456,6 +456,7 @@ struct btrfs_commit_stats {
>  =20
>   struct btrfs_delayed_root {
>   	spinlock_t lock;
> +	int nodes;		/* for delayed nodes */
>   	struct list_head node_list;
>   	/*
>   	 * Used for delayed nodes which is waiting to be dealt with by the
> @@ -465,7 +466,6 @@ struct btrfs_delayed_root {
>   	struct list_head prepare_list;
>   	atomic_t items;		/* for delayed items */
>   	atomic_t items_seq;	/* for delayed items */
> -	int nodes;		/* for delayed nodes */
>   	wait_queue_head_t wait;
>   };
>  =20


