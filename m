Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C564233117
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 13:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgG3Lmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 07:42:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:37335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgG3Lmu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 07:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596109349;
        bh=DRTlO509DJ63kWEyWdJPOdUHZAXsw1EuTigFLGM91ik=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a3VnQvOusAJ9b+BsHsWNrZg5gXl9/741zezI+LMUa8Gz+FICP7lPrYhH2Hgzw0non
         1pl+xeDbwv3hwcI3g+Hze32hzdHffosUQOAiCbcrNo2nBmqlzqKCMD1oLAEwDRfUwa
         /iu1HpZmCHrV3qGw/0zakGpXKKfNohN6U/OVmaXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDysg-1jtNi43a2m-009wrR; Thu, 30
 Jul 2020 13:42:29 +0200
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no
 right_info
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200727142805.4896-1-josef@toxicpanda.com>
 <20200728144346.GW3703@twin.jikos.cz>
 <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
 <e7370ce1-a799-3307-cfa3-f1a660d308c2@toxicpanda.com>
 <20200729161344.GB3703@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <0c64dfd6-7846-babe-b7d2-12decddce4cc@gmx.com>
Date:   Thu, 30 Jul 2020 19:42:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729161344.GB3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JVL8l5HwpnXgI20CS2gyj2P1LJy73TxDq"
X-Provags-ID: V03:K1:xig3AkDinDSv3pdyqUXxWx+ODFaWCDvO9L73RFEhDFfUQRch+11
 CgZ0OqIFJesLO100cVrmEEv3Ymvsv4pBJR5WMN7xF6+xb67tQXRY4xyIKUHydafH+SvXGge
 o6BeMq/Nq1SuPgqyHVkSV3eW2CDCsdACXwHhDb3YgxMK2vWnil/YqYtHZt/IakA2CyQJ6R2
 y3/lPbD8GknpF87AYxyjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V6iVysA0OTM=:7R2RyxzM8tEPpOS9Ma3Qzt
 MXEeOOHxweFX8D+U2RBCDPcg+TejSCQamh+H56tDSRx6UdTpJ7ePV615kgxbhqSCpy/IupoQh
 dOPSo9WymdUopUigw+ZJQ4oj5hGKW+5f6R4PuFaA7ZceXvtygcZPBU5r0L4qDB6/crK4c65Qu
 wB3Fzl7pV1kcdvCofrcEe1gIOgzVAKVhF2p5leT4dPPRj4pRR+lOwSTrzSOIVsuPydAymLfDH
 jrHVpP/4pu2b8WMWjdLhHbKn+UY+fFUfU+7ram2OW9pGWnN28VDaPAtXJ6XL8Eh+6bnunfLmp
 dfquoeIqJRqlvewYX60DhsdWa9FtMoMdZlL5UiAGp9j1UbXphL8WdiSDr1KWaZQxrVh6Mrla8
 OBgqcnp8z1RAgboo5MRbHxc+3mZuYFOlfvFnHOx8UcScSGn4Cg5o0xG+lou5slUGltDkn6Grz
 VBkamLf2F7gRemyvfAKac/5GZ9720680iTX74TM+9wWaVEHTKeinOYPAmoQSyn0V18nDyHzQ0
 yBHXewdfQMpTaZxm847wEYJCJH6CeYJFbLMqhJTRc+zykSQOLNP+TsMPIBOxzSAhzbtCoTRR/
 UJk3f1OyaZADDR0TfgG7Fne20aGJaxTizoDHJqCGJHEhLbwSRFJNCAori/saRj9mOo3dTXGaS
 sgq6rBXS1Mf8zEvznOOGyEcR7MT5sL0GCFUPRWlQT1AVN0tcnGBZ3GSw/s77THhZD2Af/NxkH
 EL0LdtnF7vCNI3uxGdm28uUI8hZNDeWudXuYLhM/S7aZwuF3DRUfONsCfi8BI9SnttIc9Yd9F
 ITsoVZLpL5mdxPay9WI91mMSKqYr6LD4adBjbWWzQ5KqJH+NgM/DQxEI5K/umk2oqetCTAt/3
 gWVz76VHAoOPtcfPnKpGoahXsetqb/N8cy5/+tB/soxU+3XYH3uuiNGtOqpznryFNR3wsO36V
 Z1bVTx6Q2EzSb7ynfrquuIyg6LnTPgBMIyLeQHXaQA5tQc8VdnE8rm5nBsq+tRJdaHcd2inSj
 8Sn5ok+UrWRVJ7b8RDX5NxmWRNXTuDpZ1B4AAMZlp1+pwBvekSWJSG2a1mpU3g5iIMauGQKt4
 m+oANR3zOUPVqncxH4GFkT8xpmSG+F1fB9ZeUg0vL0edsxh257UJPOYttBwbXFkxCK8RnoTgD
 Bi12IqJxiT8W75OJ/0gYon+/fSdCxPHD+kW55wq6fhDbCv/Q5iG9hbipEonTlhYMavXb2Sf2H
 O+lH32NQWj6UVMLnFmzOMOL4IStgTnlpUOg4sSQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JVL8l5HwpnXgI20CS2gyj2P1LJy73TxDq
Content-Type: multipart/mixed; boundary="y5eV9iZEfeqRevahLuqRkbvF44G5mzJ8D"

--y5eV9iZEfeqRevahLuqRkbvF44G5mzJ8D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/30 =E4=B8=8A=E5=8D=8812:13, David Sterba wrote:
> On Wed, Jul 29, 2020 at 11:43:40AM -0400, Josef Bacik wrote:
>> On 7/29/20 11:42 AM, Sebastian D=C3=B6ring wrote:
>>> For reasons unrelated to btrfs I've been trying linux-next-20200728 t=
oday.
>>>
>>> This patch causes Kernel Oops and call trace (with
>>> try_merge_free_space on top of stack) on my system. Because of
>>> immediate system lock-up I can't provide a dmesg log and there's
>>> nothing in /var/log (probably because it immediately goes read-only),=

>>> but removing this patch and rebuilding the kernel fixed my issues. I'=
m
>>> happy to help if you need more info in order to reproduce.
>>>
>>
>> Lol I literally just hit this and sent the fixup to Dave when you post=
ed this.=20
>> My bad, somehow it didn't hit either of us until just now.  Thanks,
>=20
> Updated misc-next pushed, for-next will follow.
>=20
I guess it's still not working...

The latest commit 2f0cb6b46a28 ("btrfs: only search for left_info if
there is no right_info in try_merge_free_space"), shows it's now the
updated one.

But still fails at selftest:
https://paste.opensuse.org/41470779

Have to revert that commit to do my test...

Thanks,
Qu


--y5eV9iZEfeqRevahLuqRkbvF44G5mzJ8D--

--JVL8l5HwpnXgI20CS2gyj2P1LJy73TxDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8isiAACgkQwj2R86El
/qhdYQf9Es9eHFNqtIdDsfTicbi33+MW+6HrTPqdiwpZK3CJCt3uNMIxg3aegDr/
N5PZaAcsHYC9Q3GOKdEjjzKWJxePLPMs2nYCqJFO8t9wiiAjRFh5ko0q4DovOZSJ
WlABfPBxnpG0Xsckr7GXmhAiIrGxhy/YBCI0Kd3fAtS+ILZR4fds8Pvdl8g9L/uv
+aDsz6mmKXVWg/3Zy5FaTO2I2mtu4zEiwunvtkODZvTKbJaPzAIkWzzo/FV5bXcp
f8SbcaYJkbFjSa/14yKd43ewZPeThk/V9W4dNGWF/3NJRYt1GNMuw9vzHqA66lJ6
XsECiPraYkmnmtldzkpKQd2SNAzUUg==
=d/bJ
-----END PGP SIGNATURE-----

--JVL8l5HwpnXgI20CS2gyj2P1LJy73TxDq--
