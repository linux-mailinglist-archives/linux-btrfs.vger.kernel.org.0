Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF13722BABF
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGXAF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 20:05:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:57725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgGXAF1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 20:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595549120;
        bh=wsEM1xg8gac+eee4CQPji0dBEovXsTTiaMMgRiIr53o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kIP8V9gjRD1kLthPcADuQFEOuH4AKd8B0h7Hszlp/lOftr65G1mACJYteUBawEf+5
         Fs8y7iRGf3APhja+6MUU/B2F6F0es+wzy+ZTIfByeKioBgQPVEV9q12kdGkBMRqN8N
         BaeK9v2XDHeAZl1XDfDVA5IpLwbcjR9m2iknFEdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1kEEjQ0Vuy-00JpDT; Fri, 24
 Jul 2020 02:05:20 +0200
Subject: Re: [PATCH 0/2] btrfs: balance root leak and runaway balance fix
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200520065851.12689-1-wqu@suse.com>
 <20200522111347.GJ18421@twin.jikos.cz> <20200723215430.GC5890@hungrycats.org>
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
Message-ID: <faeff4c1-c675-a956-6ae9-c3e742df013c@gmx.com>
Date:   Fri, 24 Jul 2020 08:05:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723215430.GC5890@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Do3Hn4olimj4oYxttSD4CRx9jcmCOrWhp"
X-Provags-ID: V03:K1:g98Bw4WK3E2KAgziQBVKmpqnCuFx9zxKlog6MtBkvNlhaRuOi3a
 Gnmbx32qk0jAOkFXf3rCQ5J3ZeYxZ6Ir0Y9eLhnBtGYITIsDXo3ZW6LE4sUadG0/OV1v8Qs
 CoRUHN7RmgSy+w1FMn+FlVj/+EdhBnOleOjUnZrGptBHYxhOrXznyHUMqzYXSVd6oYTuPWo
 kUUwPZgbyWzY0IDfV4gNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:944pLo2YaaE=:b2UoTouUwt4WBnmRnhuwaC
 5HfJfE2JQW1dC4G4A13r6JeHCl+UrzIzZjjqTQeJ3lr5mVoxW7EyHLEJf4ly2EXYN/oYmBffs
 nIif6ETdQ1yA8Xa9AtvAHP9br+whnPq/pCzg05e++sYugZfzZe/lp5eu+0f2nWF+pZhjB11BZ
 lPhl8AnxlJe86VKV1s607Wv3fI3oAeDUdguEcRR1w1S9BB3srrEOVy/7WV5/LSO/s2tuFoKz/
 qTadkby/W/waMvFgqC0Pti6vdU2xJ9lyvHqBcAbAptnR52CBSfkLbHTjjZ7TFS6uBb38pbuwK
 u8Hlp1/PtBh61XKPzZrWZBeuO23JQVHTMQ1bVSROmvZqNcktsnttpntaFPl5AslGRRH2XIbUt
 X5CZ7i8UO6WNDTIwJZfOyyR/72Cx+WKYN7jIs1NS7iMegPCeQMBHlcmgj3FM/CulKhkIKgHbg
 vekMYNqrVPRo3i5ih0i5XEGbuDuFZLinLzgsZWH/esXrEgHpp6Wx7YxUuo6DYJU+GJ+w2oTSR
 zdt4VbNLKjbvQMYNsiwZN4cqQ8lbQu+Ba8PC3yh8F9Lh1NzPGPb9pyDP+2oEImmtn5vCRFfye
 6yWocWu7E7tLN9jkECSgsVr0Fbn19GPkXjcI8Du79ddaLBy12hVwbAe/atqfMVtcrFZCwez6t
 qCevteOuUpblVPcuBUvg1Zfkr2Q13QDae8Fu+Orq9WoIWOguXJFzdjPGDS3J4WFl/D8/0cjcu
 PtCMAqf9B6jcr/FiGExPkDsx3NHu1rNxE4qM23FK5NOeyw5Th+aenOFo8UgULqE8I0WGO0c/5
 Ty5Gola0APArnCiUljgPAf2LTAVi+Qsgjrv2qznHKX9xlTNoc4Ho/Gisem1IVzhMeGSn0F0Sn
 uo2yfESijh8TUivpuVhuBVl38pyDUR4hdXDCFfS2sUAhTtEYuqUEsb/nPjw2IHyNB9hatqNK+
 1bwjBkq6X/q9cqx9SywYYkdHcsQ+2oJ7PPGdf0x17WTyJqWQ9qw1tDObm9QE+JwzA8ns7m4GA
 yELlFLgXQeRPZtPVppWTkGXoa9LmAt/jgx7iZubYmk73R0ubECHPq1qJ2GjJ2SAR9BBRcAz2c
 brEgc1X/XgtryAM56JPLWewb+UtHJfxsyrLADYzzNFP6kP43gEmLlFUZuLic1AhzFr8nlh+Al
 6mpzjoCiikTITF8qzonc2SiTxMxWeFsJkTDGGJtGVBVhPKIb5G0ZuVV3WhD1bOgisP2yvFLz4
 +KNSfXLvE5xosNkfhwI0ldpbDfVgaqhCDjszmHw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Do3Hn4olimj4oYxttSD4CRx9jcmCOrWhp
Content-Type: multipart/mixed; boundary="dL9CbuSJSqZaRPBKpFLtSSJOgQj3r841R"

--dL9CbuSJSqZaRPBKpFLtSSJOgQj3r841R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/24 =E4=B8=8A=E5=8D=885:54, Zygo Blaxell wrote:
> On Fri, May 22, 2020 at 01:13:47PM +0200, David Sterba wrote:
>> On Wed, May 20, 2020 at 02:58:49PM +0800, Qu Wenruo wrote:
>>> This patchset will fix the most wanted balance bug, runaway balance.
>>> All my fault, and all small fixes.
>>
>> Well, that happens.
>>
>> d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merg=
e_reloc_roots")
>>
>> is the most broken patch in recent history (5.1+), there were so many
>> fixups but hopefully this is the last one. I've tagged the patches for=

>> 5.1+ stable but we'll need manual backports due to the root refcount
>> changes in 5.7.
>=20
> The patch 1dae7e0e58b4 "btrfs: reloc: clear DEAD_RELOC_TREE bit for
> orphan roots to prevent runaway balance" does apply to 5.7 itself, but
> it is not present in 5.7.10.  I've been running it in test (and even a
> few pre-prod) systems since May.

Strange, I see no mail about merge failure nor merge success.

I'll send the backport manually to all older branches.

BTW, what's the proper tag for stable branch ranges?

Thanks,
Qu

>=20
> We still get someone in IRC with a runaway balance every week or so.
> Currently we can only tell them to wait for 5.8, or roll all the way
> back to 4.19.
>=20
>> I reproduced the umount crash and verified the fix, the runaway balanc=
e
>> does not happen anymore in the test so I guess we have all the needed
>> fixes in place to allow the fast balance cancel. Thanks.


--dL9CbuSJSqZaRPBKpFLtSSJOgQj3r841R--

--Do3Hn4olimj4oYxttSD4CRx9jcmCOrWhp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8aJbwACgkQwj2R86El
/qgX3wf8DdMCvsWsWfRWx3zCtpyu7jeXvaWKX7oEK33x7hPRfcxzG0yMjb0hCN46
7UhI/yIiAEcI2JaDl9dT+vACYgbFDDXXrT+teCSMxXV4//fOdVHTewAgeup4zHYC
txO6yTby3HpUInlFGDmw7FmhWoxWtYICCz7XGNVTAsTMRJzJKT4l2Ufiji9qGfgq
Ba3uRCl+tpvT33r2VdFqyHslKIfH2LmrqS92W8XDlhSBjtiM6kkyJmizM5KeFh8k
A/yj6U+OXaO66Zttcr4p5qZrklYoocEgkrpnbKde1VQHaXMpjCIN3lYCaLXbx995
RGTPTaL9FwnRPPcrBSA9PA8Yl9vSfQ==
=iFQU
-----END PGP SIGNATURE-----

--Do3Hn4olimj4oYxttSD4CRx9jcmCOrWhp--
