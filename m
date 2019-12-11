Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D017F11A013
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 01:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLKAhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 19:37:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:50989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfLKAhB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 19:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576024603;
        bh=7q3qXuUPUUg3/EyAm5Qd8wlvHi0YjdmFe2h5PhXqQLU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JyKeSq7dBT8cQ1r06OmSZwJcI4qL7+uw/1YtSKbTw5Z/H1FFAKRY+DZfnUvVo/fdj
         7Swfn9QMSZpT3H1jbPRbKhIOhRPpJo6Zj23KzYIUe5VaOUvIetSzvyiENGYWe8iNOh
         8nRh2JjqDxPP3nojN/yi0Tf2uD+8QrlEA3pSBOQI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvPD-1iFr271kqT-00Rm2i; Wed, 11
 Dec 2019 01:36:43 +0100
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
To:     Christian Wimmer <telefonchris@icloud.com>,
        Qu WenRuo <wqu@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
 <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
 <6538780A-6160-4400-A997-E8324DB61F69@icloud.com>
 <e461ee1a-dc24-dcde-34b5-2ddd53bb1827@suse.com>
 <18F0134D-AFF9-4CB9-A996-E44AC949DCAA@icloud.com>
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
Message-ID: <985d1845-d211-9134-4c9b-85a0956e7404@gmx.com>
Date:   Wed, 11 Dec 2019 08:36:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <18F0134D-AFF9-4CB9-A996-E44AC949DCAA@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xTDKLZrf01Lm97JlkMpgIhHwd4pB23Lsv"
X-Provags-ID: V03:K1:vr9gWwTMunp6ECZ2q7V2Sj/BXVQ3ijmerbouccvY+JF19cqIWwh
 t4+bGM/prqhykg+njBS+0B6cAo3RWt5TFhZGPdfDQYbo3b5SVqaWaVFFQ1qL1R0Uo3vwIw+
 HHkWD0cblwmsrZm5uOCawE95HXeWfsfTry97mz8civH8Q1+gTINQ3k1Eo53b30U7kkEPfBx
 ewlNX77vNd0BBB7GGe08A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BHXnfwhVvik=:U7Yor6S1nSd2rE6LTyfaNZ
 Ej6fB9/ASurJ3Q0R6V4XkWgc37CcQTnkGGtpptnaanBL4151gLwajIASPXE/aFvp0e3DYulfn
 t49Uc+MuZtYzXxMuGaY2Gh3bPJuVscOhs1XovD9lcH+OB/++pU92M3ymTWy8EcsfCLOo9lJtc
 /qouwiHxR+ys2JU4LEo4yz8SonBMGWmJWPpU+us/1e3zfi6AON4YgSjjGfvTAFG29xdHED14k
 FQ2yzo3zuEezpUo0USL5LsWSPa2BhOWjABRgmazltahDzDUk4bVh1Y40db3j37AC+NpHj4Ndt
 xDwtX5NAtqF4GywsAM8oiGhlgVNRa6gYWNE0NVNOLGQUFv27OJIomJe1aHQgsJ/IpBsYL2ug7
 Vg6kKF7tGTkYkYcD6cnvxtEOJvgZQ/GH6H11d81o4+BuctbHK9T+I/gtFEyHSDEnE9AAWIASx
 3cCDK5sFgXqDpTZOF91iMy6uFsWPnbZMgiMdVd4asqLN6j+XojylPkTYvxvWf2kUrCsE8X1KR
 JywYP6clfxI+I8NI+failQSP16v+6oj9uBRBp4ynD1IuJycTa+HKZF9iXjQIpMTTACbf/rM7W
 lnk8VAHE9k7TYBhjoMs4+MIh6q+XtViQcPYDO9lBbm+l8WBsZlw3uKdFqL+awXzI8FSYYMidN
 jCAaklO9mei5muZK6dbTEv82QLtudri0VUVboXOBqZdMcYT/5nxZBFqf8+UwknepPog5A8/qJ
 MwyRZ2DCYeA70+lIiMKq2EZunm2Tb/ZXDA0rtHVvWMzk6Uzh2sRX2aF0fnO6AvAWlUX9/yhri
 mjGcV9IebSZzbZ/XRB4pDZvVY0eVqQFR3+s8+8IISOv0Cp9B2qnAUqmffBe8jphSrVyDRsI5w
 QFvVdtIg+y3SN0azcNsKgfnzWtlxmN8L7agHSScWUD9lebO10JxavKouEezM9UunRM3bhmrbx
 WlVMtaz97FyaHZM182Hyda2WnG4lFpJMYQM/JMVAjnSR9575N2ej8ZinFcaFUTz+Hw2+UuQz0
 ANNpScQ0krI+xODPbbluIfn4p0QpiDHTjMG1Q2tyCq0cgnIOGJXOvNqrCcPwhPNZN73BkswUS
 TG5P66fLsZqQEjUmD1lwHboyqt7VfmJUUyzrEAxh/5sOhmYhkj1WigYI4+1UT+uiYGeZ3rhJW
 Z/TmdFWcf3hyeHUDKmYnbD+PFAFJZxvdwMbxBbonmrQE35txl15yx3diqGNOLJOgLN0Row/iI
 k9MAlORnrqAWdT671BsMGScYsFlMOAV8JTuGP0klf26pAgvNa/NMdmKwsn5k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTDKLZrf01Lm97JlkMpgIhHwd4pB23Lsv
Content-Type: multipart/mixed; boundary="2WDZ57mfbveapze1XFxG38c15Mt6bIKwc"

--2WDZ57mfbveapze1XFxG38c15Mt6bIKwc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/11 =E4=B8=8A=E5=8D=885:25, Christian Wimmer wrote:
> Hi Qu and all others,
>=20
> thanks a lot for your help and patience!
>=20
> Unfortunately I could not get out any file from the arrive yet but I ca=
n survive.
>=20
> I would like just one more answer from you. Do you think with the newes=
t version of btrfs it would not have happened?

=46rom the result, it looks like either btrfs is doing wrong trim, or the=

storage stack below (including the Parallels, the apple fs, and the
apple drivers) is blowing up data.

In the latter case, it doesn't matter whatever kernel version you're
using, if it happens, it will take your data along with it.

But for the former case, newer kernel has improved trim check to prevent
bad trim, so at least newer kernel is a little more safer.

> Should I update to the newest version?

Not always the newest, although we're trying our best to prevent bugs,
but sometimes we still have some bugs sneaking into latest kernel.

>=20
> I have many partitions with btrfs and I like them a lot. Very nice file=
 system indeed but am I safe with the version that I have (4.19.1)?

Can't say it's unsafe, since SUSE has all necessary backports and quite
some customers are using (testing) it.
As long as you're using the latest SUSE updates, it should be safe and
all found bugs should have fixes backported.

Thanks,
Qu
>=20
> BTW, you are welcome to suggest any command or try anything with my bro=
ken file system that I still have backed up in case that you want to expe=
riment with it.
>=20
> Thanks=20
>=20
> Chris
>=20
>=20
>> On 7. Dec 2019, at 22:21, Qu WenRuo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2019/12/8 =E4=B8=8A=E5=8D=8812:44, Christian Wimmer wrote:
>>> Hi Qu,
>>>
>>> I was reading about chunk-recover. Do you think this could be worth a=
 try?
>>
>> Nope, your chunk tree is good, so that makes no sense.
>>
>>>
>>> Is there any other command that can search for files that make sense =
to recover?
>>
>> The only sane behavior here is to search the whole disk and grab
>> anything looks like a tree block, and then extract data from it.
>>
>> This is not something supported by btrfs-progs yet, so really not much=

>> more can be done here.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Regards,
>>>
>>> Chris
>>>
>=20


--2WDZ57mfbveapze1XFxG38c15Mt6bIKwc--

--xTDKLZrf01Lm97JlkMpgIhHwd4pB23Lsv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3wOhUACgkQwj2R86El
/qjragf8DY1BSDYxiofc+pNOS7NMoYeP1QP9514B3ZTQ2IG5dqjj149V0FyvMVng
jFmFxlTmKwNFpW2eTQ73pQ44gMZQnKt90je775pE/O6GlDGfRuw/lTkMSBCHVweT
vnJ25E9cJbXgtmRFKxUafREiMhaXm5zERZSgZ4u+K6/DCpsQcfLP1xAgSO47ux6u
iHaOcZYmhAfYJNKlCKuR8TuRamqGOrCvS5QGCIQBVx8CGAOwOTxIuwvJUtkYNgOE
zFcFlvaMK40aWCUm1IAWKb5R87H6fZG1SZEvbs9JF+KzJGf0/OaGTw7MeNoxY+CR
eS1gudlIsGk3+TX5TfX+TB1yUOqxFw==
=uOTy
-----END PGP SIGNATURE-----

--xTDKLZrf01Lm97JlkMpgIhHwd4pB23Lsv--
