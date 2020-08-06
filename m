Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5523E461
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHFXbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Aug 2020 19:31:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:44923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgHFXbf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Aug 2020 19:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596756691;
        bh=SPvvoj7BXovqN+r4v9OR3LXhUFG+AGT9i+mwQHisqn4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Vc0x8VGaxtG8NdwSmXDVAHD6ixAMd3A5j+8q8c036zv9MxKBT+5Medi6J+HCs8gRj
         MyDZy1tnBSsZSrSzH7IJsJXS2sHkskbI4OK3AFmyzzKtER5e9GvYpbei/OWJayIPbE
         xog96VhmIJzrfHtMXx1PmpZ23i/U4LR08uUgs/9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof57-1kWabb31mj-00p7KF; Fri, 07
 Aug 2020 01:31:31 +0200
Subject: Re: [PATCH] btrfs-progs: docs: update the stability and performance
 status of quota
To:     kreijack@inwind.it, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200806072906.358641-1-wqu@suse.com>
 <7c72a892-da46-6ad6-446b-5ac7b10dc47d@libero.it>
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
Message-ID: <df8df45c-4c70-e354-f04c-ba25542277ce@gmx.com>
Date:   Fri, 7 Aug 2020 07:31:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7c72a892-da46-6ad6-446b-5ac7b10dc47d@libero.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uezeYWdTmWhzxHJzJyiXlOTkdjs55eFaL"
X-Provags-ID: V03:K1:w2ArBUHmK967lUKaIQ0vMslmQOEI4gCoX4BrgnUD+PKMN2O9ywA
 6lnygC456eta1qXQqPygBIVkS/3R69IlK2wuR4gHClJNkLjUWkW6dNOtwfVoGtL34FPXFcs
 weipiliuvWwqfzlr0EFyAcIn9NObPAxKixqK2ynEzsXCd4PwPy8yYlrRvgYikDPoVRuFJnb
 BZ66/5fLCvJWQEnnIMsKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t89+dXUUYCY=:twNh8RrAlIigUyp+umNPip
 neW1akzx8+zqHQVyEwar8GxfTYGAij8tIRJXmKeCFzo7DtWyPOAHvPcakiw4XUdDHPz6EuxDO
 CiCoiaBxF+DxGPsXA1Pr1tNtEQaXUoodzfpYbxY9nkmEhKurXoZg9rJkwvzlItV1kraCHdW1v
 9ePvkcCMSgtfWW1G0Z20nCMT7U0JYkukRf2WJCcy5lNC7RzsYZlOtJNju7pNlsjRZPD6PRDM4
 LtnMmg+Zf92khXeNqBqyqsKBjEuF4P2bX/VWbPGAoz/REBx3xxiM4zLEdiu7yWerJpf1pXuT7
 9lp+Z229/OerOAOJ8Jf4tmc9iAWHG38107spnKkSuBxGsNIGvnBfUdlbUnzN6YZHV0RTdizEc
 BRK8juxrHqfA8A+7+w94+bUkc9FfBSnGYFNkA7rJet/HN/uCwjccI8JIvmZljjrE3NxN4RCDr
 aF60OX0I4/M0jtdc/xkeJqf4gPeFrX6vESZJc5jdXhqEBvrgFxDDNVfrFP2YNEjAUyzfwM0xc
 zH/11NTOyx/q5WIY3f0NPnDwZuRqLYLNnpdmelNlvY1KbkyaMOaxsunDPCYFq1o+pPnKAmnNW
 uenz+uE5pPksIGYvpr5sNZmSF8cR1KK1AjVixiTk+Cjwj/Jk1VA2mlKyvNzdQ0iGrjScpBhO6
 wz4mkitHvN4lXtYicILO8KCrGOWOBLVMNHPs0rU9QqhbcxQIF6fs1r3ES8fSz6zgLaneoy5wc
 3yDYLiGjZsVD7Tdm5KfhZ5pwB6GYz+xoA44/bmUY9XoHuhGpp71QP4IB0WzWSZg1AiMXLNRzI
 aRBCAWuUczvMHy8VzEi6uIKEnNS1Ps0VxkJ6RRqNhy/v1fc+EBKjyxDoWPYVuoJuGrOcfOZRB
 B8vnJ1wVsjP0fa73KJOlq55duY/PHr4OC8woXhwuQe+3kAwPxSHHKXGx7Gwjivyf8tTErNA2Z
 wzWogLzA12/VlZRS7xVI462VWb0KZbTdeUFeF35jpdiS6VpsVtEu090PPtl5MONNvMVM5cJvV
 tEQjT6McNQC4+ju2a78rmngySZEfgC4SvlAIqckPUOM7hb+4QZCaAm/BnLB8swR/aiWvaPPdw
 12kKNwnOqy82tiNp5Obw+iu5cxSL7B6YC4T3hjWVFNtHLiwLs3+wlblr+g9zCJjm0NLI5e3sG
 9r58YM7jN4fM8djzZJNPKDEGpUvPZnBDN2HM8GReWgrt1D4YY8fH/N/SXYtIEo7mG2xVlorM1
 WxlH7BTK4na2Ljc5HZW7Bpe/YVAk6F8Vz97x/sA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uezeYWdTmWhzxHJzJyiXlOTkdjs55eFaL
Content-Type: multipart/mixed; boundary="hDNMsN1kJmDUO18PL0gCfa1OFglUsFd6X"

--hDNMsN1kJmDUO18PL0gCfa1OFglUsFd6X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/7 =E4=B8=8A=E5=8D=881:47, Goffredo Baroncelli wrote:
> On 8/6/20 9:29 AM, Qu Wenruo wrote:
>> There are a lot of enhancement to btrfs quota through v5.x releases.
>>
>> Now btrfs quota is more stable than it used to be.
>>
>> So update the man page to relect this.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 Documentation/btrfs-quota.asciidoc | 43 +++++++++++++++++++++++=
++-----
>> =C2=A0 1 file changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/btrfs-quota.asciidoc
>> b/Documentation/btrfs-quota.asciidoc
>> index 85ebf729c2fa..1c032f11d001 100644
>> --- a/Documentation/btrfs-quota.asciidoc
>> +++ b/Documentation/btrfs-quota.asciidoc
>> @@ -23,16 +23,47 @@ PERFORMANCE IMPLICATIONS
>> =C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~
>> =C2=A0 =C2=A0 When quotas are activated, they affect all extent proces=
sing,
>> which takes a
>> -performance hit. Activation of qgroups is not recommended unless the
>> user
>> -intends to actually use them.
>> +performance hit.
>> +
>> +Under most cases, the performance hit should be more or less
>> acceptable for
>> +root fs usage.
>> +
>> +There used to be a huge performance hit for balance with quota enable=
d.
>> +That problem is solved since v5.4 kernel.
>> =C2=A0 =C2=A0 STABILITY STATUS
>> =C2=A0 ~~~~~~~~~~~~~~~~
>> =C2=A0 -The qgroup implementation has turned out to be quite difficult=
 as
>> it affects
>> -the core of the filesystem operation. Qgroup users have hit various
>> corner cases
>> -over time, such as incorrect accounting or system instability. The
>> situation is
>> -gradually improving and issues found and fixed.
>> +Btrfs quota has different stablity for different functionality:
>> +
>> +Extent accounting
>> +^^^^^^^^^^^^^^^^^
>> +
>> +Pretty stable, there aren't many bugs (if any) affecting the extent
>> accounting
>> +through v5.x release cycles.
>> +
>> +Thus if users just want referenced/exclusive usage of each subvolume,=
 it
>> +should be safe to use.
>> +
>> +Limit
>> +^^^^^
>> +
>> +Should be near stable since v5.9.
>=20
> Is it correct v5.9 ? We are at v5.8....

Yes. The fixes are in the latest torvalds' master branch, which will
become v5.9-rc1 soon.

Thanks,
Qu
>=20
>> +
>> +There used to be some bugs causing early EDQUOT errors before v5.9.
>> +But v5.9 should solve them quite well, along with extra safe nets
>> catching any
>> +reserved space leakage.
>> +
>> +Corner cases and small fixes may pop up time by time, but the core li=
mit
>> +functionality should be in good shape since v5.9.
>> +
>> +Multi-level qgroups
>> +^^^^^^^^^^^^^^^^^^^
>> +
>> +Needs more testing. Although the core extent accounting should also
>> work well
>> +for higher level qgroups, we don't have good enough test coverage yet=
=2E
>> +
>> +Thus extra testing and bug reports are welcomed.
>> =C2=A0 =C2=A0 HIERARCHICAL QUOTA GROUP CONCEPTS
>> =C2=A0 ---------------------------------
>>
>=20
>=20


--hDNMsN1kJmDUO18PL0gCfa1OFglUsFd6X--

--uezeYWdTmWhzxHJzJyiXlOTkdjs55eFaL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8sks4ACgkQwj2R86El
/qhPsAf/WbDwJEDut76ZPnr2NqFH3YXlZPTc/1ZOThk6BQIFHwMo5vwZzHF8gdPx
q3m1TDsLg9NGzcE1ci3cyxeinc3dpLljtHhxDr8dFL6mx6HQazhz6gtRY29vtRXB
LfjsujbrPDOa/F0c25BR7ukPr5l467xcz7dHmaTTxM8tCIWsRo/O5QIlJh9IPQkK
2rbYYrcp6ioGdfAbsOZ6TTNkp69dGZ27Bsa9+bQXs8xeYpUf+IhN2z9UcGbqDSuc
KFhkQw7FXyMiF4u8ilXagAK4UQ2cBff8KZH/YZ2+SLlZ8K+PKV8E57aPzAzf8Sp6
Vbk72e9D9wPvWSm31dN2bW6AyNrqFw==
=Kgya
-----END PGP SIGNATURE-----

--uezeYWdTmWhzxHJzJyiXlOTkdjs55eFaL--
