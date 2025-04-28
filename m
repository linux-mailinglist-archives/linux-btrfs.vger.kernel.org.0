Return-Path: <linux-btrfs+bounces-13475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D7A9FCF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703931A87AFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4E210F4B;
	Mon, 28 Apr 2025 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S00XK6Zw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A263208
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878773; cv=none; b=pEKnfM2t95PHqWvB4836NpebszHOU3LCSkGj8v6jcpWEhZucekF3wN57IR2e2km6B6hv59Fcps0hcJlR6C2AUXMyj9K5BdL53d2jEZJszL9BoIJJFLdFKKhMdntXVVLvQ0uuns2m+c2Nt5dyt6Jbv3VeywLDy6iuTUGCrxSpt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878773; c=relaxed/simple;
	bh=jR3ywEkIS0QU+iyFSBYnORcAyM/iyOHH2sSeksGRdXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ag+KMSyjyncTo7iEzC0aBQ3y/rEZCxTYdeVKdS1nWvmyPU/OiyQQHzXt5o+4JBkj0A06ayZKJ9wPBHn1HEPU3AhcVnoeoKqTpeUi/kw0qj4S5IneTa/W9UXpN1Dey4M6upRkSWiyR40Lk7fCVs+irgeUTGnUH2WN+PJ0rAEciPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S00XK6Zw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745878766; x=1746483566; i=quwenruo.btrfs@gmx.com;
	bh=3ORh/qJLx9TttOsN5p7qOJ/QKrXyaT8B7k+J9G0rcBA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S00XK6ZwloBqqfnFjvUFY+H8XJwhWi4jG3XtE/mDmQxnpEblutSC1xNQgvJAov8k
	 N7TdpE7vPlq3B4zFSPAy8CP4IU4YIJqsr1iSlPlUgsipkny1fSNMHcptvnwrPRVHj
	 nQCGFHGt6I1dEZhhzQ5Z/DZNH5G8awG0q10wOtNts+288D8eGRoVK9bj7Ra0hLdjS
	 23eBlk+XVCs2u7c7/JasMddsvqhqqjGN7DnHmShY9L1HRGl5/OBYfSzUU0tYkf8r6
	 x4T1/HGmL1zg8O2wYLWJBT9LD1DM7IuR6N+nAP8s+T0SAus8p3Ww3pwjR3PJuJa56
	 EMOm8n7Otf9DnrNhOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1uAsP01jIJ-00Ffym; Tue, 29
 Apr 2025 00:19:25 +0200
Message-ID: <d479b722-f3c9-4882-9aa0-eb7f7f7272df@gmx.com>
Date: Tue, 29 Apr 2025 07:49:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Implement warning for commit values exceeding 300
To: =?UTF-8?B?5bCP56yg5Y6fIOWFseW/lw==?= <sawara04.o@gmail.com>,
 dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
References: <20250428044626.2371987-1-sawara04.o@gmail.com>
 <a95364ca-7903-4cbf-9f75-417fc0d26bbc@gmx.com>
 <20250428151259.GE7139@twin.jikos.cz>
 <CAKNDObASvhXH3F4jRBHQ2EA6CN+-L-qgg92D2GKAorMu2g9Aig@mail.gmail.com>
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
In-Reply-To: <CAKNDObASvhXH3F4jRBHQ2EA6CN+-L-qgg92D2GKAorMu2g9Aig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XGQFeMFZP0/cTb8HrHwcShLV4Mym4i3em54swRsFLTOH7mqhs2K
 9YVUg/+4QY1pCfh1iuYAVWYZ0sBZ16tsLTeqj8x3rApkUTKWJEKdH+wRZhuczff+Z2EvSx5
 hjZ/p6DbNL4NcGbGSUHThi+frr75YCu80VFHLoSQr8Q/oPUapazi9r1aDmBX6T7ux1RivAo
 8V531fCfUlZJYITBFVGGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qdbu6E4xmhw=;BTWBp5xYy1tbai8W7d569wq2ZhK
 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



=E5=9C=A8 2025/4/29 07:45, =E5=B0=8F=E7=AC=A0=E5=8E=9F =E5=85=B1=E5=BF=97 =
=E5=86=99=E9=81=93:
> Thank you very much for your review and the helpful feedback.
>=20
> I will revise the patch according to your suggestions, replacing the=20
> warning message with something less alarming such as "Use with care."
>=20
> Additionally, would it be okay if I also update the "nobarrier" message=
=20
> to make it more informative?

Sure, that sounds good to me.

Thanks,
Qu

>=20
> 2025=E5=B9=B44=E6=9C=8829=E6=97=A5(=E7=81=AB) 0:13 David Sterba <dsterba=
@suse.cz=20
> <mailto:dsterba@suse.cz>>:
>=20
>     On Mon, Apr 28, 2025 at 03:06:14PM +0930, Qu Wenruo wrote:
>      > =E5=9C=A8 2025/4/28 14:16, sawara04.o@gmail.com
>     <mailto:sawara04.o@gmail.com> =E5=86=99=E9=81=93:
>      > > From: Kyoji Ogasawara <sawara04.o@gmail.com
>     <mailto:sawara04.o@gmail.com>>
>      > >
>      > > The Btrfs documentation states that if the commit value is
>     greater than 300
>      > > a warning should be issued. This commit implements that
>     functionality.
>      > > For more details, visit:
>      > > https://btrfs.readthedocs.io/en/latest/
>     Administration.html#btrfs-specific-mount-options <https://
>     btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-
>     mount-options>
>      > >
>      > > Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com
>     <mailto:sawara04.o@gmail.com>>
>      > > ---
>      > >=C2=A0 =C2=A0fs/btrfs/fs.h=C2=A0 =C2=A0 | 1 +
>      > >=C2=A0 =C2=A0fs/btrfs/super.c | 6 ++++++
>      > >=C2=A0 =C2=A02 files changed, 7 insertions(+)
>      > >
>      > > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>      > > index b572d6b9730b..f46fba127caa 100644
>      > > --- a/fs/btrfs/fs.h
>      > > +++ b/fs/btrfs/fs.h
>      > > @@ -285,6 +285,7 @@ enum {
>      > >=C2=A0 =C2=A0#define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00ULL
>      > >
>      > >=C2=A0 =C2=A0#define BTRFS_DEFAULT_COMMIT_INTERVAL=C2=A0 =C2=A0 =
=C2=A0(30)
>      > > +#define BTRFS_WARNING_COMMIT_INTERVAL=C2=A0 =C2=A0 =C2=A0 (300=
)
>      > >=C2=A0 =C2=A0#define BTRFS_DEFAULT_MAX_INLINE=C2=A0 (2048)
>      > >
>      > >=C2=A0 =C2=A0struct btrfs_dev_replace {
>      > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>      > > index dc4fee519ca6..c6911e9f17f2 100644
>      > > --- a/fs/btrfs/super.c
>      > > +++ b/fs/btrfs/super.c
>      > > @@ -569,6 +569,12 @@ static int btrfs_parse_param(struct
>     fs_context *fc, struct fs_parameter *param)
>      > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>      > >=C2=A0 =C2=A0 =C2=A0case Opt_commit_interval:
>      > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx->commit_inte=
rval =3D result.uint_32;
>      > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctx->commit_inter=
val >
>     BTRFS_WARNING_COMMIT_INTERVAL) {
>      > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0btrfs_warn(NULL,
>      > > +"commit=3D%u is considerably high (> %u). Large amount of data
>     can be lost when the system crashes.",
>      >
>      > I'd say the large commit value is not really going to cause a lot=
 of
>      > data on crash.
>      > It's really depending on the workload, e.g. if there no fs
>     activity at
>      > all for over 300s, there will be no data loss at all.
>      >
>      > Furthermore, we do not really to scare users to use a super low
>     value,
>      > which will cause tons of unnecessary transactions and fragments t=
he
>      > filesystem with too many small extents (if data cow is enabled).
>      >
>      > Another thing is, we do not even warn about more dangerous mount
>      > options, like nobarrier, thus I'm not sure if we really want such
>     a warning.
>      >
>      >
>      > At least I'd prefer a less scary warning, maybe just "Use with ca=
re"?
>=20
>     We used to have the warning there before the 6.8 mount option parser
>     rewrite and it got removed in 6941823cc87812 ("btrfs: remove old mou=
nt
>     API code") without being properly implemented in the new API.
>=20
>     The wording of the message was not alarming or scarying,
>     "excessive commit interval %u". The consequences of the large interv=
al
>     could be data loss but this may not be suitable for the error messag=
e as
>     this is a corner case. I agree that 'use with care' (and read
>     documentation) would be reasonable.
>=20
>     Regarding nobarrier, there's a message "turning off barriers" printe=
d in
>     btrfs_emit_options(), we can possibly enhance that too.
>=20


