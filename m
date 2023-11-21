Return-Path: <linux-btrfs+bounces-219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9987F24B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 04:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9825B21AF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 03:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEB171D0;
	Tue, 21 Nov 2023 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rSpt6l48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5AAB
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700538627; x=1701143427; i=quwenruo.btrfs@gmx.com;
	bh=R4Bb/gdpFnLAoyvp/JkXQYCBdRItTBslfbrCASd35VQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rSpt6l482yEEW3XP8gfu1/BcagEKpi4hf82mHGAdMz9OdcLBvxsdgyzNt/hw8RRm
	 aeoZM/yyDNbPZ4ClfkcBcXe+gNPGJEJKErE0m5kPkL3Pe6pv/MWdPIMVX0YyqPLuV
	 c/SdcXa8hHDNIkz5VcjCjJtEhnoqNeiedNQPhZHiQOVmVqvvE0yICXoXZz6zh/Obn
	 8waysWqNHMoIfiPGZ7ixSIje30DSrkN02Ka9JrDC1oG0T8bzHgFqPLjD24r81T2rL
	 l9d1Zps9lBo25brpUnlcg+TBl8GwyDNwkCivEuNNnzpm9imkUCHmQ4eGLlcgwegbT
	 C0ieYRKNZK0x2BWqLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1rPGYM0tfk-016RFR; Tue, 21
 Nov 2023 04:50:26 +0100
Message-ID: <61fa9fda-8dee-4ff1-bbbb-2db3e409c64a@gmx.com>
Date: Tue, 21 Nov 2023 14:20:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Remove some unused struct members
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: jirislaby@kernel.org
References: <cover.1700531088.git.dsterba@suse.com>
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
In-Reply-To: <cover.1700531088.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27hpF3oknFcK/TSwxoZYKuJ3iRyB868n47yqd2H+g8H4pUUgBi6
 j3dPSayJKDqrW42U0B5g+xL6JWdRUQsw4SrmUdKZyXCCaj6gyC2TLi9q6OMmJPxBtSOkkhj
 jp5s923RT9Ve2v6n88QVEFJcYJJTjoMqtmwMXnVqgbtSNvojZyW9vWw7yAzy9s169bK4uiL
 FY3cLbFIsYup8jmIe4cqA==
UI-OutboundReport: notjunk:1;M01:P0:zLshZWVpqB8=;cJw74vBikBnY8QYrDjfD02MqyZ+
 BaM+INvApC7649r3u4szocFsggWeV+b0eaiCp5bN/nNk3fZ3NFDZgrsPapMZgfnEO5pR1zM1j
 hQkOPFkzCEsuYCmL+D7gYZVBFXvMtMql2o7y/wKT1/M0RO1gjrQZR8gQMerbWEWSRGKoRSUXJ
 GHDGnU0PAVEgdG5oouoy3pWJO6Yai+58zSVLmmWRlhVbGfIMpCnjqHeNlpAl4zo2+5H8rTTai
 IcLaigedeGZLmyg6J9XUcii/mm8s2EhGMWolu5O7xqdhrBkuH6kcbYgmRqaeuU+P27M+9PC2v
 sT6d0QI6qN3hu65ygQThaGj4dr6/C+0TRp9mpzKC5g3K9DMvCKNQ+HRkbGlx1KL+f34/nUVGD
 bIv2T/aNHexVrbT2+GM15Fd0EITppzZYJIrzntpb9ceLWVK4ZTIGh96PonOowvO00kIVnro0D
 iILjrbn1mQOPvKbtMaiH6CH4cg1A/uq7itTA41yB0sWSZuVl9iZmJTjZRXNt4bSpwqka/KpNw
 blSNd2ytuCKO0+piuVz+J6Vi9fF7JRSt5JyBlSzZpuRUIK0lxwEsTK1CFo2cxhSD3u5rG8nHm
 aVAJzT8QL4luxooBEDwsDG49v5tBy1qi3fEcu1KwHszOEPZL/e9/hQ29A9tlvc6ZIbQZzZThv
 S5eo/b8wA2ADz6veq/+5lfMFL937bA18lnl7gSm4kIdobQBDEF50EM6BbZ1pMfU7oj4FfSKzG
 eJka2tCCOoCT3Mz7yu2Sj5U7rubwTNftgscnrbBiMgNlaotfEC3KP5jkyDBTZrZqK3xWaXYWv
 8Uf1Aa7nzSE2Qinl4I5GczNyCF5C/luLtXPJcEBv8eWCndc8zGh2O3oaZjjlMY4cOyEQOPdJ/
 rVOxPBMCUlyub5ul+Vc16U30MYD7A4zbb19rrUPb1tO7dGv2hb2gQpFPWicgtYW27in1KpxtP
 lP5T30RVnO/pPWOyPqWxcsS5D1U=



On 2023/11/21 12:20, David Sterba wrote:
> Jiri Slaby wrote a tool to find unused struct members [1]. There are
> some interesting fossils. Comparing that to my hacky coccinelle scripts,
> it did a much better job.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>
> [1] https://github.com/jirislaby/clang-struct

The tool looks awesome!

Thanks,
Qu
>
> David Sterba (5):
>    btrfs: scrub: remove unused scrub_ctx::sectors_per_bio
>    btrfs: remove unused btrfs_ordered_extent::outstanding_isize
>    btrfs: raid56: remove unused btrfs_plug_cb::work
>    btrfs: remove unused definition of tree_entry in extent-io-tree.c
>    btrfs: remove unused btrfs_root::type
>
>   fs/btrfs/ctree.h          | 2 --
>   fs/btrfs/extent-io-tree.c | 6 ------
>   fs/btrfs/ordered-data.h   | 7 -------
>   fs/btrfs/raid56.c         | 1 -
>   fs/btrfs/scrub.c          | 1 -
>   5 files changed, 17 deletions(-)
>

