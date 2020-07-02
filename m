Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19EC21302C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGBXhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 19:37:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:53415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBXhK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 19:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593733019;
        bh=D6opsDhCayU9W0VWRL/ghSa+TVS265WFuw7HXVcx7UE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UHnhvroE8F4f2nEb5/Oc3mNfM/c6KJIRX26btfPPLIARyCJGCgxrnzxHTEwHvJsrX
         Z05msywvIf8d8eEFkXPx8QHdBTgsJAk/VrEPiPZ7LaQ5JYGTRjjhWPAkaMe1jJQG2r
         W92OGK4Vnl1JSvak2H2N36eIVZB8Vx1xxRzNrk0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1jAern30JR-00hQ1w; Fri, 03
 Jul 2020 01:36:59 +0200
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     Josef Bacik <josef@toxicpanda.com>, waxhead@dirtcellar.net,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
 <e0294251-606e-b08f-6df7-20a225de8630@gmx.com>
 <2630e0b0-00a4-6258-f253-cbc6f0fb9847@toxicpanda.com>
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
Message-ID: <8e14c765-dad1-1bbb-b856-afcd4ffc0731@gmx.com>
Date:   Fri, 3 Jul 2020 07:36:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2630e0b0-00a4-6258-f253-cbc6f0fb9847@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XGGiD7ptCOswrns0BHMQBmmnL29t36MFN"
X-Provags-ID: V03:K1:YpPuckGbINjJvarfSMqvWhRwHZ7c0+4o1a+j8gEaXsePUCfTpVI
 W5ZqxaWWRNcoLz5X7wjpq9LtS1+fCMSbK7U9H+T3VaWKLcZADjNDS7hRmWQT0tntyPJ6TAp
 BWDerRuBPIBO1XWQhWO8xFfSpbMSjMuEHEtG7DTVVfuT+vP+45+MjeAgOPm9wkKZwcjVaqd
 2vGt7fl1EzIxakiN5E3Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j5x5QF7cnW8=:s6NPEq/N9LGZj1KSOPcUlV
 0HPkuxVTPKBZI0YlxbnC58T2f9RNH2HYXUKMhhqge0qkjaedPGsVXZAIHNYvdsslRpgLPZEQs
 ZPv9m9JhCXhic54M9PztDgV5ugWdf1Vc/E1rBe2DFYvucOjEhx6gwHx6WuWb2hUpWHj8kiX5P
 Ge2PCetPchWiREzdK8qMksoMyWC88cSvuwQmWmXhb19frc/h1WEDzDBQ1nxdHkWR5ZaCmnh2H
 qCAEF8w2SOwmGbc5kjkmMn/H37v7WwzNAEaQnS3UKJSXFRF0ExvCNpFz6dtXdk+R3whIImuOw
 0WOctZ1dN8zech/ZHoQFIy4duKvXX7C1P30zRiMCxHFF+AYM8bkw81ONd7LePoly0SuSCc7C9
 8vFAYWaFokOCSX4VqbdN9PTMFaCNp6bDxEERad5N3M1tYXqEzRBlatxRWMBksZ9UJk0Ofs6cs
 zXdxcIG2051Jvs0F8NihWzgO66yiMmIOKZ6mMIpWbi86U+FoJuyo9jLXmOxQfKDy2NVsTHRM6
 MfWe3y/GoNneoltB5xyjfFuukaNaSefRVNozwGS+mZ9akncMgt8utjHcHad1rzihhGPQ7gPaO
 9VYafCTmtHDMtGtlMCeQDDpbetSBS38ctuEtiaYVvH6Oid2RTtfrzwVbokiyD7O3P9B1d0LK7
 zHEwJ1oB8tfvlwu+eODMhrnN5G8nqxpgel5ThBLJH+OBLOOBxL7efWj+PnbtJAY7kl96wEaQL
 5igC3oMIxUVJZzuYuPdAptZ1+EQqkoTwwx4EF6z68/s/zrOqAi17t74KEbMBU5lVZr64ATlzN
 zRsLSB8RwUCYfZAdo4TfQDwBD9GhSUhaTbFzUZQcg8kPxQ41NvMzjQlQor3VdYYh06LoRixFv
 r6unkmgqTQP3bdYFw0rZul+3Zpa3UpXISZkYxlnCX8n8NZ+03FOuPbwcUzgohyzGIV/GhxlDc
 QMZjq1JhG0FfB2xy76w5AvgYgTIKSEL8BP4ZyQxteMdAlx0gF07duQh+PcvVONliHvqikDiVV
 2iuyp460u/si9rpbcIB9ceW371FvTFitkH0t0o0SzIYsfcEe9zrxyXryXFy9Hv53VOyk9/fFs
 Kk4YZj0EqSzMLkS7MBLoxEa05ouJEVF3eK5QtMeiyaG+nQa4+7qGnMRmS7pDLI4ydBQDg98Vt
 +Ij4li3xAlbe0h5F4394yLsO15nHwznbM/fIn1q6S4KAKYq3wwGRyjAGMFMN14iy5stX3vULb
 y7YAN03lQMEdIzm9w
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XGGiD7ptCOswrns0BHMQBmmnL29t36MFN
Content-Type: multipart/mixed; boundary="8xzJjMCaMEilAK5M5m9jCySLVR81fv0yo"

--8xzJjMCaMEilAK5M5m9jCySLVR81fv0yo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=8811:28, Josef Bacik wrote:
> On 7/1/20 11:09 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/2 =E4=B8=8A=E5=8D=883:53, Josef Bacik wrote:
>>> On 7/1/20 3:43 PM, waxhead wrote:
>>>>
>>>>
>>>> Josef Bacik wrote:
>>>>> One of the things that came up consistently in talking with Fedora
>>>>> about
>>>>> switching to btrfs as default is that btrfs is particularly vulnera=
ble
>>>>> to metadata corruption.=C2=A0 If any of the core global roots are
>>>>> corrupted,
>>>>> the fs is unmountable and fsck can't usually do anything for you
>>>>> without
>>>>> some special options.
>>>>>
>>>>> Qu addressed this sort of with rescue=3Dskipbg, but that's poorly
>>>>> named as
>>>>> what it really does is just allow you to operate without an extent
>>>>> root.
>>>>> However there are a lot of other roots, and I'd rather not have to =
do
>>>>>
>>>>> mount -o
>>>>> rescue=3Dskipbg,rescue=3Dnocsum,rescue=3Dnofreespacetree,rescue=3Db=
lah
>>>>>
>>>>> Instead take his original idea and modify it so it just works for
>>>>> everything.=C2=A0 Turn it into rescue=3Donlyfs, and then any major =
root we
>>>>> fail
>>>>> to read just gets left empty and we carry on.
>>>>>
>>>>> Obviously if the fs roots are screwed then the user is in trouble, =
but
>>>>> otherwise this makes it much easier to pull stuff off the disk with=
out
>>>>> needing our special rescue tools.=C2=A0 I tested this with my TEST_=
DEV that
>>>>> had a bunch of data on it by corrupting the csum tree and then read=
ing
>>>>> files off the disk.
>>>>>
>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>> ---
>>>>
>>>> Just an idea inspired from RAID1c3 and RAID1c3, how about introducin=
g
>>>> DUP2 and/or even DUP3 making multiple copies of the metadata to
>>>> increase the chance to recover metadata on even a single storage
>>>> device?
>>>
>>> Because this only works on HDD.=C2=A0 On SSD's concurrent writes will=
 often
>>> be shunted to the same erase block, and if the whole erase block goes=
,
>>> so do all of your copies.=C2=A0 This is why we default to 'single' fo=
r SSD's.
>>>
>>> The one thing I _do_ want to do is make better use of the backup root=
s.
>>> Right now we always free the pinned extents once the transaction
>>> commits, which makes the backup roots useless as we're likely to re-u=
se
>>> those blocks.
>>
>> IIRC Filipe tried this before and didn't go that direction due to ENOS=
PC.
>> As we need to commit multiple transactions to free the pinned extents.=

>>
>> But maybe the latest async pinned extent drop could solve the problem?=

>>
>=20
> Yeah before it was tricky, but with Nikolay's work it made async pinned=

> extent drop possible, I've been testing that patch internally.
>=20
> Now it's just a matter of keeping the last 4 transactions worth of
> pinned around and only unpinning under enospc conditions.=C2=A0 I'll di=
g out
> the async unpinning and send that up next week since that's already
> valuable by itself, and then we can talk about wiring up the ENOSPC par=
t
> of it.=C2=A0 Thanks,

That's really awesome, let make btrfs the most bullet proof fs then!

Thanks,
Qu

>=20
> Josef
>=20


--8xzJjMCaMEilAK5M5m9jCySLVR81fv0yo--

--XGGiD7ptCOswrns0BHMQBmmnL29t36MFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7+b5cACgkQwj2R86El
/qhW7gf8CrzT5MG3nhUhzr0S2EJmv/tRhwI0qEf+Ta7/rig3ZEctl9jVpZHHiWek
d2ekp4sYAhaPO3Vx/ebqJUN9bjhHy/G/6/0y4IMrTQZ1R0E4RqmvN+ShqlGM9DHQ
8rmjmO7O5VJ/tvGyBez/VXwoWudoxxDA83Ct1xNmnWLJtlgiYEu0eJ47OFD/Qiya
8LB6StVL00U6/NsuxanLndghEIVA1b+V/0rS0/V7f1Ijb9mY4autn3n49P9WDEBA
7ZRRdoemNPDwnvclRi+BlYEIeuA9JMwp2cHOGmv29Csjqwn0VD+LNSBHJcg04mPn
jla2793C+uE2jlmgZlKTPgqtAuovuw==
=S4uH
-----END PGP SIGNATURE-----

--XGGiD7ptCOswrns0BHMQBmmnL29t36MFN--
