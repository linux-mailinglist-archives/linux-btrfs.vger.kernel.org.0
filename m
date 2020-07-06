Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080962156B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgGFLve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 07:51:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:60067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgGFLvd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 07:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594036289;
        bh=dGhx2FoOc+qzmg3bHacLYVM/+RMADKvTY+Mih9VFIXY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lJvDfDFHiJ2V3edW79AdnjjUAQGSgwq2kveHz33i980WoaKsDeNNfXhAwh1wBmdRa
         H1s6sbYEqwI9fiyYlYU5LrYkAcsrfKPn3mvZAw3lF4Lv/GCEDsYcvB0OJ8ARQCuiSl
         XxsEvj6L8A/us+95e2eaPF5+HXBouylsTIXHB0ak=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1kl4oM0m4I-00toaq; Mon, 06
 Jul 2020 13:51:29 +0200
Subject: Re: BTRFS-errors on a 20TB filesystem
To:     =?UTF-8?Q?Paul-Erik_T=c3=b6rr=c3=b6nen?= <poltsi@poltsi.fi>,
        linux-btrfs@vger.kernel.org
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
 <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
 <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
 <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
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
Message-ID: <e1beb547-3989-0fdd-b2e4-5491728f7dec@gmx.com>
Date:   Mon, 6 Jul 2020 19:51:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V6SlM7ISglGf4gmrZptyLwI8cREZkVmWC"
X-Provags-ID: V03:K1:uIX+GO9R7s7PZoYnRp0CCubcwvuuHeQf7wyK81rCFc4CFmEwdDL
 t5zqyKj+xJn+TI04l8Nx6YAEo4wb4N9Yd4OrkcjCIMjjio3qvopzfFTGiXvPIaaeca6X2l8
 0f13JBeBCOWCUbBTgXIt+gTmR57GS7xE4y9iDfKYOc+2ASMlDW9n7xup07V55ppL0eSUbC5
 y27scQcRcgHOFjnxobqDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6X3kVHpfl0s=:VkG57TYgGUckBDLofni9Rp
 oj7V9qkA1bRdWwgida/0BaInD2gg6DVxyG8hbXqqg4AnTcwcdsQkAKJilYrr35TG/dc/JnvnI
 lt6eQssLTHVc93nBOTZB6L7V95oUWg82a/BBe9+rpBOcyJaYuvJEF1UCpSzoYJbEjdsB6+6Em
 yXAcezl4WZqScDq7wzeGvn/ba3O64d5RsLlXaN7t67a7Gp4cx8/FKq6JT6dnteqz9X2MOvvjr
 x7m9eJ+oSh4QV8suwtZ4hs/Pjko7hVEpReaY1pHjsBLloNtSbHVln2IE1CF0NSgCI2FiUZKao
 jpbIrtpQwf0VfoXn0zvC2yvYTgf1sMHSOQNDUXT5uKjYhfp9UnDBByHTklK473hazQoAYabTd
 tQBzg+XbxGKxxgLz7guZts48tEfpuKTHTi27so7X9fcUkHnVKrFxikMb1p/3HNZpaVd+OhrnG
 m/paT69odPPVO+cTn74cih3oQuRAfZsGAlsModQTV1UnopeR5s6HnA6dcSC5767yWQDQE1gXW
 0JwYxZRJYrADZOQTzS1ky8zsbrhwV8XBtJfFKpDEJMo0KrAf3I/uTg31ybfca7ftLRY4Qw455
 JkPg192HmCfHiv0nC4KMWmDRvF5Up/SCLIKDCEQONOp2YVCEtqaSXu4cDnAZhnCv7YwVatWoX
 XbU04wG5ut3k4jKGNfqMBkExeTxX9sl2Hm5wPhE+aod3BWVjE4vULwgEprnCin70ciiikrg0+
 1EQOyN8wlN6+K3GnQ+kXot+RmAkQuYDp6YcnGMUYpen6kJ06leHkahpBE4PUqAG7y0IlHaqok
 3nFPx1+tpIPZrgRDzDpNJFusADRfrJVx5ZB3iG0nUPDWviD1qkRFDY/S5f3T6NV6LDazlHkDw
 sCfN+qIXT6/10hvXmBC0XAth7MS4FI/WoUNDW5qAGVn2tmJRTRwR+cUtfv25ch2hAg0FZfBMv
 Ywbdz7LrOrVbrr9a07HyXqU6CGmGltp2ANqU7FkIaqY2yd06s6j3kaX/l7DDUuuhZzt7uoaaf
 s5v8WmCeCLn0vnPkVlfYn+8laHGh3T78TECF3/OMVZam07q8PLHZdCUuNd32RhiK8pu7rnmfv
 0a37nvvInbM6cgy3U2yjMv5qXzwwaW989OOajYBl8ezFppmLU68pW8xChE5+ggFSdIYxrKPtd
 euxAf22Xee+W8COimscCh+LwsKRxSmw08SxtodUDTo30eIFyay8gB58/dS4oGWTYi22V8x5VC
 iW0kaEMB3qyx8UutIzj/E4HJPXVPv8p1nBAmZOQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6SlM7ISglGf4gmrZptyLwI8cREZkVmWC
Content-Type: multipart/mixed; boundary="axYh3OPeKSqznRUAUDyHJkDzm4KVlkPBh"

--axYh3OPeKSqznRUAUDyHJkDzm4KVlkPBh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=887:33, Paul-Erik T=C3=B6rr=C3=B6nen wrote:
> Aand I messed up by sending this to the person only. Sorry for that.
>=20
> On 2020-07-06 13:55, Qu Wenruo wrote:
>> Some older extents are affected by older kernel not handling extents
>> length correctly.
>>
>> 18446744073709481984 =3D -69632, which means there is some underflow.
>>
>> Recent upstream kernel caught it and reject the whole tree block to
>> prevent furhter problem.
>=20
> Ok, so if I understand this correctly, the issue is essentially created=

> by using a new (5.x) kernel, whereas the server was running 3.10 (CentO=
S
> 7.8 version with btrfs-support) -> CentOS 8.2.

Oh, that explains the amount of problems...

>=20
>> Would you please provide the dump for this bytenr?
>> I'm a little interested in this.
>=20
> I'll provide you the dumps you requested in the evening. Should I email=

> them to the list, or directly to you?

If the dump contains confidential filenames, then feel free to send it
only to me.
Or feel free the censor the filenames if you want to send it to the mail
list.

Thanks,
Qu
>=20
>> Thanks for your detailed report, this would help us to enhance
>> btrfs-progs to fix them.
>=20
> Glad to be of help.
>=20
>> For now, you can just mount them with older kernel, find the offending=

>> inode using the ino number in the dmesg, and delete the offending file=
=2E
>> With all offending inodes deleted, the fs would come back to normal
>> status.
>=20
> Ah, well. As mentioned in the previous email, I reinstalled the server
> with CentOS8. Unfortunately RHEL/CentOS8 dropped support for btrfs (as
> well as megaraid_sas), so I will be running this machine on the UEK
> kernel for the forseeable future and planning on replacing/recreating
> the FS on the partition.
>=20
> Poltsi


--axYh3OPeKSqznRUAUDyHJkDzm4KVlkPBh--

--V6SlM7ISglGf4gmrZptyLwI8cREZkVmWC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8DED0ACgkQwj2R86El
/qjByQgAseiVDUOmac3jx/KfEoVchV3krweOCBKnNQ3mUFy4HMK6X43UuxWjruB4
N/F+FJFM8bFvC3p5FHHbqpO2zBvFHZN6uu1G/bzb4GyGKc9UzUicR0/IlKDOfCi4
Xv3TLEcfKoZdmGas5cxSCrG6FGC9OKtW+pt1t4fz7jZTFv0SeffFHkxHKqW2pTLy
ecmmADy04fvi/dG+h/OjH2cbvdp/SaulJZ3OETP2JGUAKLxlIJ5HXpSMtmVwIGm3
CZdkS/KTVfxYrenOCRKAhz5uNYebH0hcGWRbJbWt6AB1kXUTUSv6JVB64madKUBe
PJcM0x//fod6fI1AGyDfQ6ZxlX6pAQ==
=3Wio
-----END PGP SIGNATURE-----

--V6SlM7ISglGf4gmrZptyLwI8cREZkVmWC--
