Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26EE27C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404873AbfJXBhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 21:37:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:48319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404755AbfJXBhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 21:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571880804;
        bh=+RiBRAKPVoPDLybJuci4jWskHhJv5kvH+CIu6Sei+0I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hqwE8n1tcGLM88MfDJoxcIgerw7PY0rO71u7Z5Qzn5xX2f0AmN6/MNb6B3rl+5ZhG
         I4UVbqgU/pDtL35UliR9wicpPMGS5588OooWB7FFQTAoODnZQIFSV79X5FQdYTvyop
         VfnKSv5LPqc60lpS/nE7ITkwML96Dn+vbQ2u2Y38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3DJv-1iR0m61Ylh-003gLj; Thu, 24
 Oct 2019 03:33:24 +0200
Subject: Re: [PATCH] btrfs: Remove btrfs_bio::flags member
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191023070447.6899-1-wqu@suse.com>
 <20191023171713.GE3001@twin.jikos.cz>
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
Message-ID: <6306e163-0761-acf7-904c-0c9908dac84d@gmx.com>
Date:   Thu, 24 Oct 2019 09:33:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023171713.GE3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cCo5GtQnOJWzvB5s99SiDq3uz17O0gRRq"
X-Provags-ID: V03:K1:RmNCpKkALibLXTIknLCqrF/l2XH3meJlbvdmyB9l70Lb7/wPCQa
 dCluwfpLG5kaP9/YPy/jO32eIrRzAHzSCdStEcivU3865d1fnxCU45HEyVe1kgXW0NJoby0
 Nz0fdCbhnQ0wJ0qHeiA9nR52fgJUIyPqpK11+RDHI6ZfO54rSogkSVhY1X7Apgkd1tKHkDm
 72R/m/7vpJOXHDVWYtOeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RjbA+LaesD0=:Sfyy9cp/N46RvfIFaHr+tV
 +A/4Y9Io+e+9HnKWSrPxHL62yq8SDqtByJX1T/b64joFqaDD8E9gwN1+JyjWHS+M0cCEgZIjB
 5ytJynRaW27P0uUNcEtXLqf8jE/AUnfdfq/sTAGzi1RGqnuFL6ISjRlP0on25y+e2ZXgg13Dg
 ++Y7QC3eLS7qJ93rOcAhEoFEBBbnF0LqkU7egBxth1aQjAwsBarcB5YZBFo2AO4pvXZsAu7M5
 aoxabPsD+tzFmsIbr1l8mtZw0C2BewfGWqoY1BO9jcJg5yLggL7ZiCkJKgwBSKUQWV+CPVtDS
 fYQFo6ZS+vgV+0u2Xinajij6lhBMQvDsXvtncQ+mz7/ZXW75IBhw7OogkdSqb6c2OuktFzlsM
 AY9+R0FlgJf6MYxWD7xH7MoEeSPsaYuLzaIr6YON0O2Au32uIe0lMP/cUF99JC55BBJIrIjZc
 Hn7dv0VtLzSBhHgtOIoFIX3ZNwqgYkOxgAi1od5LlqY7XyEUU8i8XB8CmcwJpgCLtmhDapFiC
 dNU0Uki1eqTVSUNDaCI/eq3Ht/jQR/PJ09fy/Za/10iYwUmW61yVb1Gd/fiYoVmTn1MswZgBq
 RmK6z8z2YZRgDjM9y+yhjhjb/MW6ytGl+gZV6nGrTLn1xkSBQOhudXyn+q56UUXP/WvnbJmb/
 L8WvI1Zh+wYmdBddNxXKIaujfHpEWS168wwmzh89pf9A+mP/fDWzHVEnrj4Tdh9INVYUIC3Sd
 YwMX1uY3/P2hotPJ/nqtWO8/Tc9/8XvBUMaTJwGN0tCRmED+Af0cLnFfvk7eKPuIuSzwF7LNJ
 1bmUXXuBj0p/QxSQpwXPrqWAuMmFvxNfAK4uzSRNBbuYKQxAzTxHVV0cTYfXFN5vmYKdGPcZW
 WB/qtbLUDmGkdL6/ZRdwlGxv7RoIseegBXhkBKdQGrPGCFwFEzf8bofp9nuQ/gekcZevAZAcP
 DCKtN6QqDOPhnuigV7oWFUyfcYB0T5jOXaB/Pg6dZN82y5RyeooyFjfuwsLe5ioyeWxCptZ3h
 M1GIJiU3oupEUkeWASRF0vmplDni5VBr/F+M9kkQZ8QC7lfMg9P4DWGASZLckmWJBFH0EveTK
 FP1Eq1RmSIlhwLn/GkOTLP3djhTK1Vmu9ik3FWVi8o0RhzQamNkJMUVUav97ehmYN7LM387YG
 a7oqKFw3kYIOfifgrtpXuHOph+QTlm8rd5Eu4yjn5eQpYyzLfp8sZjj2PMTMBHgH4/W4ae85V
 QyElb60SqY3XhWI2jIAH92DfeSEGw8lpcTrbh7/fgZw45J/HSC6SsBf/PI1Y=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cCo5GtQnOJWzvB5s99SiDq3uz17O0gRRq
Content-Type: multipart/mixed; boundary="ZE3gDKnPpL6YJKdjzlrX90AhqgddS4jro"

--ZE3gDKnPpL6YJKdjzlrX90AhqgddS4jro
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/24 =E4=B8=8A=E5=8D=881:17, David Sterba wrote:
> On Wed, Oct 23, 2019 at 03:04:47PM +0800, Qu Wenruo wrote:
>> This member is not used by any one, just remove it.
>=20
> What's the patch that removed the last use? This should be in patches
> that remove struct members. Otherwise good, every byte removed counts.

Will update the patch with the mentioning of last user.

>=20
> I've briefly checked 'void *private', but looks like it can be removed
> as well, it's holds bi_private of the first_bio (btrfs_map_bio) and it'=
s
> read in btrfs_end_bbio, but bbio is accessible and so bbio->private is
> bbio->orig_bio->bi_private.

Would double check that, anyway it will be another patch.

Thanks,
Qu


--ZE3gDKnPpL6YJKdjzlrX90AhqgddS4jro--

--cCo5GtQnOJWzvB5s99SiDq3uz17O0gRRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2w/14ACgkQwj2R86El
/qhyoAf+MQzPVtI50V/4xcyRNWxVIqX/gMlFiWhMmwWVeeE0Ot5KPoNXchPPwIn6
XiLPvIwhn3Lp+5NsXbL0ymho+TuCD8TGboY7PooSVCLWtyzVruqCtE4yPlDbRlcI
K4NBuYxKVkfXVPIHpm2GafsNkQTI2mN/gVsvcLRqejNpcOpGsBdtdLVHR/jbk44+
kquxU/kGBtaXkmmLcv7L6q7yJx3pYL1nHdeCOEa80CtG8ogtlu8HuJHQAp1N1/Im
VgWGF4sn99cJaiGbd8+dbmtfxgAAXGAIhc69wYsiio0p9HcW0VNANCH52c19loSo
uFxtvQm8n2PFcfA3XJog5ezvJU4v8w==
=l20F
-----END PGP SIGNATURE-----

--cCo5GtQnOJWzvB5s99SiDq3uz17O0gRRq--
