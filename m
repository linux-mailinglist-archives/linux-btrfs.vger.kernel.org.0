Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6311410D035
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 01:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK2AhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 19:37:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:33361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfK2AhY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 19:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574987764;
        bh=M787s1OFD3VahE+W6uwLiar1RXvCmT866hnTMvZkcIw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XmHSjOKotvzF6iTB4qlDv+Jyegz+fcI8wSxHEnl76nHKEgmVH2b9IZwvsugI7IO2i
         MD7vDNgw8Uo3uswNeh4S85lVFEZpJFlYtJgTcLRgF8za/qBQuLKzUeGXW8pmd4bcdl
         /bALzmN9qbUyzNw7FdDzkVTXvp2xVeKK58maxTC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1i9h9x2vmg-00hiCa; Fri, 29
 Nov 2019 01:36:04 +0100
Subject: Re: [PATCH] btrfs: relocation: Output current relocation stage at
 btrfs_relocate_block_group()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191128075437.10621-1-wqu@suse.com>
 <20191128154002.GH2734@twin.jikos.cz>
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
Message-ID: <9b43b4be-737e-c119-eab2-ae56cae9e0b3@gmx.com>
Date:   Fri, 29 Nov 2019 08:35:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128154002.GH2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r4Nm7eK32O0rJpDzRe5dYfNXtLfDahhxq"
X-Provags-ID: V03:K1:MDadbsO8X3SjVztW+tVaA5OEhgdJTtF6IRqG8qtNYGsdlEQ+irE
 w5OOg2UnsTURNwSUKUibJl3fJT+6epMaWR5bzABOHsqoUWJHjHxyTIuHu1sQf/d81oTMqaG
 4YkWBbBLpq86rq6YBc2MPlsOYucbEley7vpjxWoc5btza9GzWZmnXrcnPksHL0rOEuqht4J
 Hs9LnR7fXem5ubJFbX0gQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGNBBXax+tc=:43VgnmxY+xpNk7JN8R68mY
 1/JsQ+E55zyrp0xpj9CDQJeP7JdW7JC3dSeC3rsl2rE3q6pkK7HXgGiz7kF9YDsZ1P9BFNxhg
 GWIZNs7HY07/9uFosoTaW+KOKTSw5vbglhkb8yJzQK6+QwhSKQtfd8NgC9KuzZzTB+rwlbO1B
 NQ5QG5PbmEoUbU++lHTS6ob/6rioIB3qrsIImtYFXfyQnwnXPI/58Ftyne8n59+B5kpt/Jd77
 ArkYlxdRNH03C/TOou5jUsvEeLBhL6TScwjUV4Rr6HzUZjo1HyutWDbY8h0xPai4881rWfj5s
 NlT4QNkSD7ivD8QlnygciqOVKWQeCqIZcbtKlygHhlEqUNzRX9oJPTjHyqurWvXrqdsVpXrKg
 yByh6sOC7gZId4+zIbmbYybSyP4jg3omSvLuVgq2ssJAzbwK634qtiy8dIKT7WC63LTnsgtoG
 ZN8vLToH8srMfwBxTDYDa8nJcXQonObMZZ5hlE4nl0m2RCyKCw5qeeMgTt0+6C3JHgfzUjRhb
 kKaVwNXck88g+XwTe52d/H01lWj9UUjxVgAj77y4e+IFUiW1647lgUlPesx5DmQYcQAWmkOIX
 WQIq5sEPFZpor9Q/cCtTL7TkHUmYmre3WFvmlQ80pwvJ2YBllzkCWWSheiVrG69VI4PSV7s7d
 fgBgJL7AV5CyuFmKgT/fJS9Uppv98mjdhCRz3Wb/LeaBHmMFPimxsJs/me/uIQw0zzmSb3b7b
 DsNdTGtHKzmBK3GQjWwp3+JiJpgfMKmjAzptXv6vjbZJhvitYnLS9eHzsrmetuM+GSfcJOyrT
 M29tDwFLJI0kjpsHyKut4yVxo77/6nm+PDq5/2gwfit1FX6jN5fyG3th8uYnqVaFhOrKAUeRy
 FueTb0+n6tQSwb30MJqVLKnPdH2j212mX8DpcvSVH6+gSaxAP7KXBfLSQkXHDMY8aDxrhOjeI
 NIGFMAIMqOv7urCVxkB7P4WqEAFyVjFgP/6aiiMMRPJb4b9Z4crTnWXbGxkrsd/GX74SsiRFS
 7/jnCf0ImZqJazcY6I2hZA+bRs6KiLLg01CxAhN7/YFih9U3k5fspXghE2JkELGm8WPZzsRkh
 bbNrDC8lsT/dkd4BtW+FUD81ayaVlZIwYm1baPhyWxFnDw+qmtqs4JgMBc/hcM6wK1u7KH583
 7Pz2p9KC8+2Mf5kVBx6qGQp8n82oON2plg1IGCPXoweAK8P4Ph2BwZ7xgb2KY3qIJ37he6iEK
 yeRbJv3E6zcCRCo1VbpNmjqXx0VFxqPjFxrgwL1t3f4pwDFmVuAJ1IILpFAU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4Nm7eK32O0rJpDzRe5dYfNXtLfDahhxq
Content-Type: multipart/mixed; boundary="UuS4CfTOGayrnI2zrJ3YuBU5B3rm8bain"

--UuS4CfTOGayrnI2zrJ3YuBU5B3rm8bain
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/28 =E4=B8=8B=E5=8D=8811:40, David Sterba wrote:
> On Thu, Nov 28, 2019 at 03:54:36PM +0800, Qu Wenruo wrote:
>> There are several reports of hanging relocation, populating the dmesg
>> with things like:
>>   BTRFS info (device dm-5): found 1 extents
>>
>> The investigation is still on going, but will never hurt to output a
>> little more info.
>>
>> This patch will also output the current relocation stage, making that
>> output something like:
>>
>>   BTRFS info (device dm-5): balance: start -d -m -s
>>   BTRFS info (device dm-5): relocating block group 30408704 flags meta=
data|dup
>>   BTRFS info (device dm-5): found 2 extents at MOVE_DATA_EXTENT stage
>>   BTRFS info (device dm-5): relocating block group 22020096 flags syst=
em|dup
>>   BTRFS info (device dm-5): found 1 extents at MOVE_DATA_EXTENT stage
>>   BTRFS info (device dm-5): relocating block group 13631488 flags data=

>>   BTRFS info (device dm-5): found 1 extents at MOVE_DATA_EXTENT stage
>>   BTRFS info (device dm-5): found 1 extents at UPDATE_DATA_PTRS stage
>>   BTRFS info (device dm-5): balance: ended with status: 0
>>
>> The string "MOVE_DATA_EXTENT" and "UPDATE_DATA_PTRS" is mostly from th=
e
>> macro MOVE_DATA_EXTENTS and UPDATE_DATA_PTRS, but the 'S' from
>> MOVE_DATA_EXTENTS is removed in the output string to make the alignmen=
t
>> better.
>>
>> This patch will not increase the number of lines, but with extra info
>> for us to debug the reported problem.
>=20
> Nice. I'd suggest to make it more user friendly
>=20
> 	relocation: found 111 extents, stage: move data blocks
> 	relocation: found 111 extents, stage: update data pointers

This is much better, keeps the indent while provide better readability.

I'll go this way in the next version.

Thanks,
Qu
>=20
> The identifier can be understood what it means but it's IMHO not
> important to copy it to the message verbatim.
>=20


--UuS4CfTOGayrnI2zrJ3YuBU5B3rm8bain--

--r4Nm7eK32O0rJpDzRe5dYfNXtLfDahhxq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3gZ+8ACgkQwj2R86El
/qjuwgf/TB00Vz5uAbxXbWVHKPuM+ulOp5oyhMcujoeLy0E5LLG6leXsCSvA6l68
lfDVx0EI+eVEeGZp+KSV3YjR81XizMMbPhwtXKfp9dNj/eRoHp07o+c5uwbaPUHT
1sp+usiAeCuilj2CefjC7ly7HMRT5svsa4ZP42mjWlftVfSOORYH6JaSOJPByKsG
7YwNrFzT9A6Yq+zLLCa8MUTGJZvkFs82L7bXK/zbtr9D9bB+os+nxztt+0sfp0Hl
gSA7F2zbUVg27f+/8vgl9K55mrBNIQfT7j/F3k4L3PRFJkzdLzi/h28Uwd5I9vrw
TqEWtKtE0+bglpk4A2UfiejRw1WqpQ==
=D3ut
-----END PGP SIGNATURE-----

--r4Nm7eK32O0rJpDzRe5dYfNXtLfDahhxq--
