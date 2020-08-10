Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717FF2402AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgHJHf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 03:35:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:36039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJHf0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597044920;
        bh=B8QoF4k6lg5CXVMIrP87QNwI9N3ruUoaWMZJcxCKCdc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FTlvUXAm5WIJDDDGxkYxYt3bMul2Wrrf3m99uO7LgwiCUWfvKL/VoWfVVUQBwA2Co
         G1TK5IeSLL+Bqw1oHGOHsEQ1i6b/UXPScUvJy5d6QiLJUmNTEDhAuHvUi2mtRwzSE6
         svDxOhkRdFM63j5Ensn0mD+K0QFhwSUEOwHv51Qo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1ksaeL3koP-00wiWx; Mon, 10
 Aug 2020 09:35:20 +0200
Subject: Re: [PATCH 1/4] btrfs-progs: check/lowmem: add the ability to repair
 extent item generation
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200810072747.64439-1-wqu@suse.com>
 <20200810072747.64439-2-wqu@suse.com>
 <SN4PR0401MB35989D15F1724F55E26DD13E9B440@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <dd7cc94b-102c-ab8b-662c-b9fbe7449b7a@gmx.com>
Date:   Mon, 10 Aug 2020 15:35:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35989D15F1724F55E26DD13E9B440@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pY6IeVcObjQ2f0Dvlsmmxmb4dUe4Zsj2Y"
X-Provags-ID: V03:K1:v7ee5ebC3p5vTS7MzrI8Lk3yN9FL+VIZfBz4Q4xU93isvX2RROW
 UGA8xq1AslX9r2Uodm8uE0W9JSijMyFNZSa3GWrJ9twRjnejJRirXjM0XvJwCz8V3G771vs
 8v0sbFFX6xPj7p57yHV06gpy1zMd4NEvmtFLhPiAijJfPUU8plw1dlFE5A8xPQvUC2r7sh4
 HMFoaLM9cmmmRUsVY/gzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OHk3QHndguo=:xgCTOT46vB/fkQTSP2tebM
 7wbwolXF5KMCm9Agx+l8bdPEPvWewopZhYdIEMekfg5HaUnF4Pr//1Hp352ff5AA/Y+k7/VzG
 Rkcbgat4Mx3FQCZ3RJ6hb3wiYNv2sdqZGGfILR28gz0TLOK38j7P4wyr92Od4sxlM6L+kL+Xx
 i/F8PUh8VC/uQoGzCe8aKBS3PrCeKHxqdIonn25TUY++kO9nrVOpq0IQEo4t5oCfUGk/l/yok
 vxyp1PbDWZzebSq9Sv0aJW/4WKyfYSNAf578XyS6iTPz62sxQw0Y0+PAgHzCdBD91hSqICsOg
 livnrjX14v10Gp0W+h1FSn7f0USrsYD9bX8Mh/u/XAfeRAm7D37dWBM9ge/LXOiDW00Lr8CA9
 Gt3Vrp/UVVC4VCmTKP5mzLxejmrg1anmVGCsuOtSwPY7ml8e+Ge4t4ILK8Al+Bf+crX8bAP5J
 ue3j3xlUJ58qMrLYBrgl/ON7RTQgNz9kb0aqmyXxqekHxfr7hCPp3gT29I8JiN810pVX2eWe1
 itGgWJUqyqJoPxN/lmpHbBqZpvns+ZWAaPO8kOJrKvXedGl5P2q2UbyJBYbWzJsAjmTJCzcBx
 NGqDPbLeesC17OfzLkfdhGTVMs5xfmLDioTcN6B+vsdp4jERAKnFnHsd+sQaDnUoWpSEtsb5w
 aJq+TQs4Slj4BtRmSKFJ/qyfaeTqcBNdPHVFAZ5e0tdtRWyv6tldtkzXRHS8AtNFoh4PAGdJ/
 Zx3Ku02MgeXJYJaYQmdAdsmcnJhBFO3EzNJY6sC6M7322t1Cvi/tpI91NaULiSOxTkVyhubaK
 3p/NlYmu5oSIgwHL2HDabpK/RMMdA9VnBUdc+zb/UIOp+E2d/1N9j6coPNH755SKMHcGh2Z+Z
 io5DKWE65/kWBHAYN3HABMWTHGfZ13dgkF7Ca2FpW6dWHx58SP6zYT6JobDFt+FvviAOyjpw9
 FWxAP3lkP1kyrerd8YaZ/USTLlxOJ2wvC4k7XTG0pU9+q9gp870/CJcqNZZVohagQIvgyQVPM
 2MPZd+JfEdZG8ZvyJpkyFHIv9kftzMY8RjHBooYxAGmbitnkBHUBYQqLybtv+3hmMKrYjhbQG
 grcPetSakZIw2J76Rqs6pmEnAQVA2LHxQPtdoVYXlEr4qXM1LlJsMZ27q4/zPdIg9Fa1Rt3tn
 8lewpoiTnv2nP3ckMBgIPpxGk9evPSAflhHYxoHTtP6xRI3ROy6bLDrA8zFX4FK4UKfmyo38+
 9W2lgMD1sqVFdWchjgq757TZ6xiXF3qZn/LUfqg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pY6IeVcObjQ2f0Dvlsmmxmb4dUe4Zsj2Y
Content-Type: multipart/mixed; boundary="MOKQDMCTUE32hiiwYqK82cJPVXMCPmFQA"

--MOKQDMCTUE32hiiwYqK82cJPVXMCPmFQA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/10 =E4=B8=8B=E5=8D=883:30, Johannes Thumshirn wrote:
> On 10/08/2020 09:27, Qu Wenruo wrote:
>> +	if ((tmp_err & (INVALID_GENERATION) && repair)){
>=20
> Shouldn't this be 'if  ((tmp_err & INVALID_GENERATION) && repair) {'
>=20

Nice catch!

Will fix it in next update, since I also found the patch name for the
4th patch has a typo...

Thanks,
Qu


--MOKQDMCTUE32hiiwYqK82cJPVXMCPmFQA--

--pY6IeVcObjQ2f0Dvlsmmxmb4dUe4Zsj2Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8w+KoACgkQwj2R86El
/qigVwf+K4gUSWg5AZsZ0HSPHK87x3V8vcj4OslOyr0rqxSlHXP6dzdOOiUxhz+C
UCpZwjKuaGtPQauqa83IxwOG3rf+sUNJNxmnXz4+5Igtoua7CCULFZ1gy6hGTiJC
0KFAo5fqrd7wWuHbkpYqc8xBqIjskTcVWDJBpKfMWbq/jbpVkp5dMAdMkHNBBjQ7
KNiOOzGxjqpwdybB3cIFWNmDz7z1ki92mdaPXFffT86YCaTUfyRMgZSfdso80rh5
Ajo04vAL1Ozi0URw3UtmiLhHKqqFTIJJ9yOZE+0VOa0/ZNj/kcIxKUjbr9zLodG1
tSPn6fgmUrXQkFX9kPi+tWd4a0eBtg==
=HGlO
-----END PGP SIGNATURE-----

--pY6IeVcObjQ2f0Dvlsmmxmb4dUe4Zsj2Y--
