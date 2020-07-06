Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9512161AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGFWom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 18:44:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:41255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgGFWol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 18:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594075479;
        bh=wzjBB7ntdg0+mIiMUcaNgDLhsjxCcKtGjLPUL5xkvwA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hSrXC2BU6Fk2CSAzj725SKizad9Y0ALmhTKL+Z5l9owVKXduCCkJpMBPZmd8PpqDu
         pCSEpMw42VnJTC4EDF3VNz8NE5eaH+d+wiQGqWQL5Uk/OWiFLYrQQ14skLJ6mkOEQ9
         rY2UmGCoscymQYldBIECfLA9AI5D/Jod7bBP98Qg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1kscvw15OA-011Tbv; Tue, 07
 Jul 2020 00:44:38 +0200
Subject: Re: Growing number of "invalid tree nritems" errors
To:     Thilo-Alexander Ginkel <thilo@ginkel.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
 <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com>
 <CANvSZQ_HDZ=54MW+dSAP1A_zUiaGR_PLkV7anQj5K+qNds0QsQ@mail.gmail.com>
 <2483ed80-90ae-765d-e3d3-15042503841c@gmx.com>
 <CANvSZQ_NCb_RZyd0Z5v1W8ggrDuBRs4Gw1Q_wT62DC1e+8fjTA@mail.gmail.com>
 <CANvSZQ8WFEQbkhuXZ7E+EYOZn-dZA=q1qoy74vMMFiUYpRX5+w@mail.gmail.com>
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
Message-ID: <9ac1b6d7-cd89-b8da-43e5-eed37c5d0a88@gmx.com>
Date:   Tue, 7 Jul 2020 06:44:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANvSZQ8WFEQbkhuXZ7E+EYOZn-dZA=q1qoy74vMMFiUYpRX5+w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="45OEedSfUOAFYOHYfmeiDTd8CMRsvnJU9"
X-Provags-ID: V03:K1:oajyVzqkNym0M5B3DElziau+ySlx/OZ1EDUlCE2OXpCSdAgjwmD
 tUKM7+XlofPZdJTd5gPY4Ls/F+3ozzFppewSg/hLpqLeMOTXudCbX5qFjs+seMuK/k0MnBw
 WViM6f2XLc7p0T3mpEAXkHZkPpt9ltoR38usYQr0Uez3GrmQi45zNMbG65Em2JKIIKq3dm9
 tJ4UUpPpniv/pZ7GP6gJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3tfFQrk5u0=:vzOtXPfWqAsx6TXq2XTshk
 vcLmKZ9ERn7VKovtoNwIIYhVdo+pEbbbDp+K+4sZHdSnwySyIe/C0asIeiu0WywmTsNJ7gEK6
 LdFoXWyinFT1zujrs1CZN3DjL5k6k8bVyox1D3Dbg6S98uiK/YQoiJqQBgWFBqc25D3bGu5Lt
 wgWgV0H3vVKK7CsP6cgVEk177trFTsmWinBlu+Q5P8ALzrRhL82JbCdaKJW9xhTTTExVqvcfL
 4+465UdLNMCGVmq0eHOh4fKeEYYsIcZTXaApDfzapTyCTBivAP71lIVO484UFc3W7UpF07Bka
 jr11iISuIXp504DW5QGcv6tjPvfj6DvgXUam1yghvdq7okfsr9P9b6WiecuoKieD2dMdv5DqZ
 llT4EH/x07VJALqLm4QkNmjHS+Asn5fMq3iZKJ3Sh8vqKeC+ayEXweKFCpd6ky8XfErMOFn4O
 OSeiPGVZ168wtenVgjm2qrlIXVled+FtFcbK6IObQ7iyAKKMqgYmafUgRMt8KcU5l3YyZbH7S
 sZGh8DswnWN2av6o2v55kstfqOxi1FpyJ8PdF/VYu/MHkdMlNaRVy4L+ZThixzX7WEI/ErYtM
 YKd8e7XkXsy40GVtDNhVLW1X+SmhDs5qzMKSm+Er4IgmSoUGt6N9hpSrVD3F+r9VFgwcBgTnz
 ZCq7OO0oWP2YuhvGYxUlY14tinxh9OaVCvhqaQg/+0erWQCwwp4Lc9YkP81JZeOtMvUPLc9TO
 ODik2NxHqQUPCs/U1wSN+5RKmm2bsT5ZY+cSQygBRtew3QA2K/Uc14EmXAFEK8/Yr9+gCvYdS
 OqiWtgi5Qw6sslm7GhgpsRvfcwKsQYtUfvzwDCxl/o7Wi0LitQ9Kgsq0SIR9YUtAOrW9NGso9
 cIZPrJ0NRGA/iZfAYgm/bXhKTLTbFfsi8yyNtUU3BcI+QAjXFusu+87SKIgO+XMMPCz9B+uEW
 wqRLEcxRwaBbJNFBz+kUhzxs52UeNT/u5GNO3OaBjpKTQQ/XZo4TLVtFW74X0Kg8PM0ll3dW0
 IqHaGdOsTFQ27iVeLvTZdzFnGyOoOdmWBH4VJcwoR22QX5RgZHVxO/ojCO4iid6upinGnRcQc
 qUq4w/3Ign7UTO1OrLBVXbt48kHBgrahayz6IZo+spF2XEgq6aw3TMXpv6wvykOrbesdwHCQU
 hgbEiUbFLn87AGrIjLgfLVSAfzz7AYGhx0ghMF7NUcnu9eE49Z4XHhr+AZaps4oMx4ixzuKKl
 7/1uN9NtD6TzXJxzqLNGlHoDHM4g3weJm01C1lw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--45OEedSfUOAFYOHYfmeiDTd8CMRsvnJU9
Content-Type: multipart/mixed; boundary="ZwkBawfOAS8Y1MArn94d1TT73zjn5hIOH"

--ZwkBawfOAS8Y1MArn94d1TT73zjn5hIOH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/7 =E4=B8=8A=E5=8D=884:19, Thilo-Alexander Ginkel wrote:
> On Sun, Jul 5, 2020 at 3:24 PM Thilo-Alexander Ginkel <thilo@ginkel.com=
> wrote:
>> On Sun, Jul 5, 2020 at 2:10 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>> So if it's possible, try upstream kernel can also be an alternative t=
o
>>> test if it's really something wrong.
>>
>> I took Patrik Lundquist's advice and upgraded to the latest HWE
>> kernel, which is based on 5.3.0. I'll follow your suggestions if the
>> problem manifests again.
>=20
> Good news, the problem is gone after upgrading to 5.3.0 (the most
> recent Ubuntu 18.04 HWE kernel).

Then it will be a good idea to report this incident to Ubuntu team, to
let them know the backport problems.

Thanks,
Qu
>=20
> Thanks for your support!
>=20
> Regards,
> Thilo
>=20


--ZwkBawfOAS8Y1MArn94d1TT73zjn5hIOH--

--45OEedSfUOAFYOHYfmeiDTd8CMRsvnJU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8DqVMACgkQwj2R86El
/qgRtwf8Dk8rsPQOacf3L2/Ay0w42I7UHsbhrQfOpxhMC3ub4mRifme62StiF6uy
P4BloQj18deef/C7tSkF2+vocsoEXKBrQ22E5Ggnh0J+0Jz9jOK5Ya4iwcDsMmPq
f9UKB5cIS5yEKVHzQq72Dlu1hY5goabKQRp6Yh2sOLiZlK5fiFjd3G5/CfJi4y1/
Qe8iBvae3xmNeCdkPdWgvPYmh6n14RvH6AeZvJxfgxTU76VIUFu4pQFJeo7OjkEL
sDXLDJhF7GCz5p4laTbGSMluUTm7UFI95arQ9fl2pDuZcQ2EWB0MgaLgfKLgggRO
fb7bIYpgIpyWis82dZsneVpUPf02Mw==
=2MGg
-----END PGP SIGNATURE-----

--45OEedSfUOAFYOHYfmeiDTd8CMRsvnJU9--
