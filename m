Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79AF15B647
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 02:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgBMBAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 20:00:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:46565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbgBMBAT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 20:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581555604;
        bh=qGxjBvebJPKwl15cBDYfFLOTlodLUFVcyPkoBkOXRio=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UHrIpv1OAvDCBOw1QPLr7c3YFRVHkpT2jglndnF/3gtQ2Ujha5MHKceO01e1AubuZ
         HBTDqkMgKgqSQ3hJIjjbVDCU250OlAoIzw0dGq2UkMlqhLHfURZ0S+vs0J8RvJoClb
         ZFmOq/po2IGkfbbJY+es5DAVjb+UUqwrVLHQ4ucY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1jRZw61t8X-011E9j; Thu, 13
 Feb 2020 02:00:04 +0100
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
To:     dsterba@suse.cz, ethanwu <ethanwu@synology.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
 <5901b2be7358137e691b319cbad43111@synology.com>
 <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
 <20200211182159.GD2902@twin.jikos.cz>
 <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
 <8eeca7c0-8283-8cd6-2354-9eb9373c9bd3@gmx.com>
 <20200212145740.GK2902@twin.jikos.cz>
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
Message-ID: <0aa5bb89-d8ed-973b-9cd2-8e787fabe301@gmx.com>
Date:   Thu, 13 Feb 2020 08:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212145740.GK2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LVRo5u79gKGlX3gt2Rp7rMI6Whiw7gUnB"
X-Provags-ID: V03:K1:Ju/KlYzRCp21GEGvezCsSeMAIGqcfHqLW3pgOTpAlk6j0pgazqU
 VaQDOKoE7IWt3vmrS9rXdtjeAFkb52th35mF8WDc21ak5ClzbFCaIF3isnDwwAO0KowOa32
 QF8IogwatY1GbQveQc+YEPRYMyY6cddnHAblW9voKnjUo+j9/GfiVCfhPM2GlEMjtMt2/0O
 QgaLrW/ag9nSE/DsgxIcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e9VzlB5QnSU=:NXI8bIu/gxLhhjBA1U/pgi
 3UmIT+TXnt/xoBgPqC2XEIcdV/VHoRQzEmApRQyfHikyRDWs6cfV+Utx76Xg4M8l4FGFRGBzv
 F/dC1beOwYtAmcV6vk7Lk0mWd5p/vCJo+5mej0V6bBSCalL3QKbV3BJZCJaMin+sRCS63uHsM
 LC/1hYISEw6a07K/X3IVjQfGMxv/6GE5uQAykQvDUZjaKfoFqI2acVJsIbjzGg5JKsAUPX2rp
 k6kwP6UCEVb1akb9bbBJ2aJBwhxmoYJWC6/WEorJK5xbjB5gPXQvn9WybtD8599/GC5zva79n
 Ou8P+dQiZrTZWTRG/Pfe704OYKCzGi+Mk17bpiUlZoxLnvT6AklLEPjsrzAVsf30PRXtcTiWY
 2GLTR5/YzCyO0I5JBHwi/8aqAucJBhozrg3VO7qSVOfO8OIvJpaso530+dTBJ7dUpaW18ORha
 aC4MVg+HOb6kMXnGvP8DfeNFSb51gKNmROcOvGxS9AN/V/5pkiNYIQ++dmv5/eXO7jnIk1n7M
 8aSEejIYWgKZlrNojF+xYXIws2coFAUDUYkh9DBFp9sb/1Dd8OL0MjWr4aF6pxXeOOMRtl7+n
 C6r9PPzi3m8qnygVjyPVRt/F362mNFGb84a9LV/Vu7LgVzighmQy1rQensRa1Mv39TsUiAFE6
 rS/XWynO5lGQ1JDLYDW9C/hf/Rw5O+k0Yb5VTzVx5PGK5AaH8u78ttSaWJA2kRNTD69s7yLfT
 UnCi4DXUutoaFxZwwB1MQWXapNWXmznoOonzDNIsd8jcNYX89TY5GoevXGO1/HHI8yIn9ncKE
 dwsr4NGKtkLeRFR8onuLq24kBbSh4CJx2tmA2Wgy2FDySRZdTg1cDJbTxSd2yahseWXwBbByX
 ftaQklDPGnjKDsMsKcHCAYNvFrTTusCCgjw/nT0NvwR9XL1kXq/GREWSIEQvvqgspjFLK7TMB
 HD3SHWoGf02lDWWLglcirW1zaUD+kxNamDIzVWtCYZyMOuoqkvb+BCA6CTruQDd1wjZJuuUWM
 WAjog0lRdnCs5+2LxBCBkHVRcJSV7kYcg8aIWhal52zaICkKa41xVMXO9f/OuA7kb4z8eAfUi
 jbnGliHhsCSshv9w+l+4c4PfgrMyTrYjN4Cs30GGN/GZpLkCRfVtjQJqkwZMPws4YTgCisIxD
 tXmmmQTZmOvgTTRJ17gReWuy06BmLkWww25ZqKApO7zLYBIj7d7EYzYNNltltA7rVoeDOWEIb
 xGC8jUVNBwFc3k3Xu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LVRo5u79gKGlX3gt2Rp7rMI6Whiw7gUnB
Content-Type: multipart/mixed; boundary="5OxFGrU5fHatDCFEdjev0CQZqEf6MWnVc"

--5OxFGrU5fHatDCFEdjev0CQZqEf6MWnVc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8B=E5=8D=8810:57, David Sterba wrote:
> On Wed, Feb 12, 2020 at 08:11:56PM +0800, Qu Wenruo wrote:
>>>>>
>>>>> This looks like an existing bug, IIRC Zygo reported it before.
>>>>>
>>>>> Btrfs balance just randomly failed at data reloc tree.
>>>>>
>>>>> Thus I don't believe it's related to Ethan's patches.
>>>>
>>>> Ok, than the patches make it more likely to happen, which could mean=

>>>> that faster backref processing hits some race window. As there could=
 be
>>>> more we should first fix the bug you say Zygo reported.
>>>
>>> I added a log to check if find_parent_nodes is ever called under
>>> test btrfs/125. It turns out that btrfs/125 doesn't pass through the
>>> function. What my patches do is all under find_parent_nodes.
>>
>> Balance goes through its own backref cache, thus it doesn't utilize th=
e
>> path you're modifying.
>>
>> So don't worry your patches look pretty good.
>>
>> Furthermore, this csum mismatch is not related to backref walk, but th=
e
>> data csum and the data in data reloc tree, which are all created by ba=
lance.
>>
>> So there is really no reason to block such good optimization.
>=20
> I don't mean to block the patchset but when I test patchsets from 5
> people and tests start to fail I need to know what's the cause and if
> there's a fix in sight. So far the test failed 2 out of 2 (once the
> branch itself and then with for-next), I can do more rounds but at this=

> point it's too reliable to reproduce so there is some connection.
>=20
> Sometimes it looks like I blame the messenger and complaining under
> patches that don't cause the bugs, but often I don't have anyting bette=
r
> than new warnings between 2 test rounds. Once we have more eyes on the
> problem we'll narrow it down and find the root cause.
>=20
BTW, from your initial report, the csum looks pretty long.

Are you testing with those new csum algos? And could that be the reason
why it's much easier to reproduce?

Thanks,
Qu


--5OxFGrU5fHatDCFEdjev0CQZqEf6MWnVc--

--LVRo5u79gKGlX3gt2Rp7rMI6Whiw7gUnB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5En4wACgkQwj2R86El
/qimkwf/V3dzj+73htoW6JmB7oiD6TRpBbLY7h/KYzJiW0D+TLuQzy1TkeuwxvtL
ACFQcQPfxElS6AXXDrpFjQwUV2p6730FzwrD+3Gm+W4GX6ntmHRw4/IorfMbhGXp
E0Wr7iGd6ZYeGSFCsF6QqYGol4irmcrEVllFGxFAxqmprRDOTImDVSjrO6pAL1WO
e+9JJTEq1oIu1BNlbOHU5vyIwqVl8RZaSQGb4IiQjiYtvY1ZRC4kzq+2NNvXtOr+
2e5up8aVF6BkrTLf3mcT8E9QBPv6h6vniLPlwCAlGNr/4gqufCHQ5gFxWCZZAZ1K
AiUz9wrtIdJQQppSKTa7S8fNScVP6g==
=M1fN
-----END PGP SIGNATURE-----

--LVRo5u79gKGlX3gt2Rp7rMI6Whiw7gUnB--
