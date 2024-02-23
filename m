Return-Path: <linux-btrfs+bounces-2689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13661861D07
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 20:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FBB2876EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE63614535B;
	Fri, 23 Feb 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PZYDWBuW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187313DBA8
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718197; cv=none; b=qRNCtmgkgqmS6jM1pKQhvEA3/vPJUas4RJR7dco29jZLs0nPxrK29Rav3CIl918GtdUccjhTCdGB5XY4TGcZX7i2PLhIe2464TGmOX6eS5gFMGFT71uVvuDfNYpjqgWMMcyNOYnWOUP2JWt2l4w0VmNqQr/eAOUvTq+nxtXnqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718197; c=relaxed/simple;
	bh=6VhihhivP0dCX55qoj+AKdKnQMd8yuQfHPBSUWDxanQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hQGLLqEVOu8sXPjbMtdRKHWEq0fEVUWc5g3f5vEPZD2Mo2N97UGmF0y9wnb2ESoh+oiYerJoptqn+1WK6kbuYoSCi4z5L3WMchh/MWR4T3EUAtZRnc3o2C5o/f5fMkqfWYdzGIh+kILVNEzfRw6s6nAyVNpCLV479rMAbkZWVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PZYDWBuW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708718145; x=1709322945; i=quwenruo.btrfs@gmx.com;
	bh=6VhihhivP0dCX55qoj+AKdKnQMd8yuQfHPBSUWDxanQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=PZYDWBuWGIcPEmGjydWj1pGtdbQnQdHGEaGXjmPAqpKasggc36w3nNG1/P2jPV7n
	 gB6FKNVNsyqbb7bQt0w2hV1ELYtQKr2hoxTaIHL9AxBTOsCv/HZuwOAEY88Bx5hxM
	 Ury+AMATKdjLoAbAz0jC2S0qRe96KJpRWmmqjer+iekBt8kqDS3okfFm9wzJs+fM2
	 y/V4yt6phjWD6bQKuCJ2p6o1WQlRe8tO87ZJW76nJJPWj7Xr7HNUTh346bc5fKY0y
	 EiITLiq2vmHC7/bglabdWw5bUklAMeDQCowOaukrd1MEZ0+k60wqI0t4T/Hs9fSmT
	 zzbQ8r39F32fnsRHhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7GM-1rkiOg1Rqk-00BgMB; Fri, 23
 Feb 2024 20:55:45 +0100
Message-ID: <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
Date: Sat, 24 Feb 2024 06:25:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
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
In-Reply-To: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WAhnpMRfczz05wzgLJPue66Z/SqEYySwZ03Wc/1Dql/+JwpFMyD
 n2OfHQEWtbsDU5mMEP4UVuhT9iN9az1fGspZChcp614juszgXq/MDkhWqa+vtye5UtCiIpt
 Nmhv1EsgrEI6iJVhlk/XyxSCxAu/fjNedO7sw22TrCAbKecWdvfM0oe8XBCZcP0G6ekjf8D
 Nwtb9NROk6cJ9/N9RP2FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8l+3Tw1ZJDw=;zKXVQsp7ei/m9IARn3bMB7C4wUN
 /6ni2T+ujknJ6rByX7MRutdl8SWJ8qXdYKZcyUB7yPuIC8/421A7Nm1jZF2UzgMxoXI/ETyFD
 hYc0IEZaWUhJdlLjKQeGZr7hMwRfH5YazlRcBIEvoq8x58YkUqo9F2FuenMA7hBsKcb3BNqGD
 XjoORL/zclpPXC1jRVJ7pczwJ0I1vJh2/aPu17DFPSOo2tFi7RT4kHHRhVhxkUJVsAmLdUnCd
 oCCDgpInsS6/T+Lz1ss07dJ3nMhCyw/xFwCyLPyZt+pkvXIs3uMXqT0eG5FyNuNT9NMvcetoQ
 86eWOnQ3WSN3+43ez91yA3iDuB5QTKRS5lhiav4zpF7rpyoJhwjPV3HLOn24eXse+28b56Xlm
 spphOtv45QKYetyO+osFXzXy2we59blD/3wUsKI9JV3HJrKUF+ydZ7SKLPhiyFGgwyVjMBAcx
 Ylj7Pu3HmmtakJtnUZmNM8DDsZvMhsEXwG6SNusUxy9h/JVzw6TbYQr3S5iGeFL6/weCPwo35
 yQT2PkGm5rrnKW6kdqD559pPArJq4kN2iYAVLLTteuaTy5mwgsDWMrrybzVtcaqscOEvAF2Dn
 OzSWISkYUqeRwG+fwpaA373GaCwLU5sEPcml7dR5k7KE9n8qpf8dfrUxfw1IY8mL+ShVOOXKs
 vmh+UZQ3TOB9i93UTTQBoa0ivaeYYSfjnD93eY9j19PeZtm6FVNBF1bhEvPxW/7k9nbFH+nq9
 Owhm2ikyfIq/xMHEq2iRfwYPOWsd5zvj/af2h9TwzV0tj5fLMv0M3jRe+Qwz9H5B+x5QrTxq2
 YHNnp7KbAXKTbvlnYszrplb+MtFU5wn3+v/gy3qhEuQ0k=



=E5=9C=A8 2024/2/23 21:39, Matthew Jurgens =E5=86=99=E9=81=93:
> If I can't run --repair, then how do I repair my file system?
>
> I ran a scrub which reported 8 errors that could not be fixed.

The scrub report and corresponding dmesg please.

>
> ------------------------------------------------------------------------=
------------------------------------------------------
>
> Then I ran a btrfs check while mounted which looks like:
>
> WARNING: filesystem mounted, continuing because of --force

Do not run btrfs check --force on RW mounted fs.

It's pretty common to hit false transid mismatch (which normally should
be a death sentence to your fs) due to the IO.

Thanks,
Qu
> Opening filesystem to check...
> Checking filesystem on /dev/sdg
> UUID: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
> parent transid verify failed on 18344238039040 wanted 4416296 found
> 4416299s checked)
> parent transid verify failed on 18344238039040 wanted 4416296 found 4416=
299
> parent transid verify failed on 18344238039040 wanted 4416296 found 4416=
299
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D18344237924352 item=3D1 paren=
t
> level=3D2 child bytenr=3D18344238039040 child level=3D0
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:00:06 elapsed, 69349
> items checked)
> ERROR: failed to repair root items: Input/output error
> parent transid verify failed on 18344253374464 wanted 4416296 found 4416=
300
> parent transid verify failed on 18344253374464 wanted 4416296 found 4416=
300
> parent transid verify failed on 18344253374464 wanted 4416296 found 4416=
300
> Ignoring transid failure
> parent transid verify failed on 18344264335360 wanted 4416296 found 4416=
301
> parent transid verify failed on 18344264335360 wanted 4416296 found 4416=
301
> parent transid verify failed on 18344264335360 wanted 4416296 found 4416=
301
> Ignoring transid failure
> parent transid verify failed on 18344243511296 wanted 4416296 found 4416=
301
> parent transid verify failed on 18344243511296 wanted 4416296 found 4416=
301
> parent transid verify failed on 18344243511296 wanted 4416296 found 4416=
301
> Ignoring transid failure
> parent transid verify failed on 18344246345728 wanted 4416296 found 4416=
301
> parent transid verify failed on 18344246345728 wanted 4416296 found 4416=
301
> parent transid verify failed on 18344246345728 wanted 4416296 found 4416=
301
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D18344243445760 item=3D4 paren=
t
> level=3D1 child bytenr=3D18344246345728 child level=3D2
> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed)
> ERROR: errors found in extent allocation tree or chunk allocation
> parent transid verify failed on 18344238039040 wanted 4416296 found 4416=
299
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D18344237924352 item=3D1 paren=
t
> level=3D2 child bytenr=3D18344238039040 child level=3D0
> [3/7] checking free space cache=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed)
> parent transid verify failed on 18344241594368 wanted 4416296 found
> 4416300ecked)
> parent transid verify failed on 18344241594368 wanted 4416296 found 4416=
300
> parent transid verify failed on 18344241594368 wanted 4416296 found 4416=
300
> Ignoring transid failure
> root 5 root dir 256 not found
> parent transid verify failed on 18344253374464 wanted 4416296 found 4416=
300
> Ignoring transid failure
> ERROR: free space cache inode 958233742 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233743 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233744 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233745 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233746 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233747 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233748 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233749 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233750 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233751 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233752 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233753 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233754 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233755 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233756 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233757 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233758 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233759 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233760 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233761 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233762 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233763 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233764 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233765 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233766 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233767 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233768 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233769 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233770 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233771 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233772 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233773 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958233774 has invalid mode: has 0100644
> expect 0100600
> parent transid verify failed on 18344264335360 wanted 4416296 found 4416=
301
> Ignoring transid failure
> ERROR: free space cache inode 958232811 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232812 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232813 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232814 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232815 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232816 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232817 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232818 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232819 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232820 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232821 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232822 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232823 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232824 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232825 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232826 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232827 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232828 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232829 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958232830 has invalid mode: has 0100644
> expect 0100600
> parent transid verify failed on 18344243511296 wanted 4416296 found 4416=
301
> Ignoring transid failure
> ERROR: free space cache inode 958231543 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231544 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231545 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231546 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231547 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231548 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231549 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231550 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231551 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231552 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231553 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231554 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231555 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231556 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231557 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231558 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231559 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231560 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231561 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231562 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231563 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231564 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231565 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231566 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231567 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231568 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231569 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231570 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231571 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231572 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231573 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231574 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231575 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231576 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231577 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231578 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231579 has invalid mode: has 0100644
> expect 0100600
> ERROR: free space cache inode 958231580 has invalid mode: has 0100644
> expect 0100600
> parent transid verify failed on 18344246345728 wanted 4416296 found 4416=
301
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D18344243445760 item=3D4 paren=
t
> level=3D1 child bytenr=3D18344246345728 child level=3D2
> [4/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed, 1 items
> checked)
> ERROR: errors found in fs roots
> found 0 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 0
> total fs tree bytes: 0
> total extent tree bytes: 0
> btree space waste bytes: 0
> file data blocks allocated: 0
>  =C2=A0referenced 0
>
> ------------------------------------------------------------------------=
------------------------------------------------------
>
> I then ran a btrfs check again whilst not mounted and I won't put the
> output here since the file is 1.5GB and full of things like:
> root 5 inode 437187144 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 942513356=
 index 9 namelen 14 name
> _tokenizer.pyc filetype 1 errors 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 945696631=
 index 9 namelen 14 name
> _tokenizer.pyc filetype 1 errors 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 948998753=
 index 9 namelen 14 name
> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 952510365=
 index 9 namelen 14 name
> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 954421030=
 index 9 namelen 14 name
> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>
> and
>
> root 5 inode 957948416 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 690084 in=
dex 17960 namelen 19 name
> 20240222_084117.jpg filetype 1 errors 4, no inode ref
> root 5 inode 957957996 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 890819470=
 index 4463 namelen 8 name hourly.3
> filetype 2 errors 4, no inode ref
>
> and ends like:
>
> [4/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:00:58 elapsed, 415857
> items checked)
> ERROR: errors found in fs roots
> found 4967823106048 bytes used, error(s) found
> total csum bytes: 4834452504
> total tree bytes: 17343725568
> total fs tree bytes: 10449027072
> total extent tree bytes: 1109393408
> btree space waste bytes: 3064698357
> file data blocks allocated: 5472482066432
>  =C2=A0referenced 5313641955328
>
>
> ------------------------------------------------------------------------=
------------------------------------------------------
>
> I have tried to see if I can find out which files are impacted by doing =
eg
>
> btrfs inspect-internal logical-resolve 18344253374464 /export/shared
>
> using a what I think is a logical block number from the scrub or btrfs
> check, but these always give an error like:
>
> ERROR: logical ino ioctl: No such file or directory
>
> ------------------------------------------------------------------------=
------------------------------------------------------
>
> after mounting it again, subsequent checks while mounted look like the
> first one
>
> I have also run
>
> btrfs rescue clear-uuid-tree /dev/sdg
> btrfs rescue clear-space-cache v1 /dev/sdg
> btrfs rescue clear-space-cache v2 /dev/sdg
>
>
> I am currently running another scrub so I will see what that looks like
> in a few hours
>
>
> ------------------------------------------------------------------------=
------------------------------------------------------
>
> Other Generic Info:
>
> uname -a
> Linux gw.home.arpa 6.5.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Oct
> 11 04:07:58 UTC 2023 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v6.6.2
>
> btrfs fi show
> Label: 'SHARED'=C2=A0 uuid: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 4 FS bytes use=
d 4.52TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 2.73TiB used 2.55TiB path /dev/sdg
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 2.73TiB used 2.56TiB path /dev/sdf
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 2.73TiB used 2.55TiB path /dev/sdb
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 si=
ze 2.73TiB used 2.56TiB path /dev/sdc
>
> btrfs fi df /export/shared
> Data, RAID1: total=3D5.09TiB, used=3D4.50TiB
> System, RAID1: total=3D64.00MiB, used=3D768.00KiB
> Metadata, RAID1: total=3D24.00GiB, used=3D16.14GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
>

