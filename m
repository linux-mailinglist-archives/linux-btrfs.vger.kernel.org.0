Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4C192729
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCYLcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 07:32:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:53959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgCYLcp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 07:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585135953;
        bh=Zn1RwRC5WagZJ5hW7CxqjA5OlIHCIJV540iTu12EXww=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VelOntDDljalPyUWdSwh7keJSPxRI+LzgGMqbeod/xj3H0wDLalNz9ZqQtUDWl6vC
         8felHUes9ZGhT3RurrcmeMmyb6Q36mlj4K24yyP/O8mD692CQwlzdNDGuve4f0Zcce
         iUmXfDafVMWlkKxrt+LcAQfm/vdpOQpVG47T7Ris=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKZ3-1ixUOE0gJD-00LqYJ; Wed, 25
 Mar 2020 12:32:33 +0100
Subject: Re: [PATCH 2/2] uboot: fs/btrfs: Fix LZO false decompression error
 caused by pending zero
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200319123319.37848-1-wqu@suse.com>
 <20200319123319.37848-3-wqu@suse.com> <20200325090900.276eef09@nic.cz>
 <6b42f7e0-626f-67da-e9ba-fa4d9db8dd15@gmx.com>
 <20200325120020.65427217@nic.cz>
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
Message-ID: <4e300eb6-b159-2f88-b0ca-89f03bca1638@gmx.com>
Date:   Wed, 25 Mar 2020 19:32:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325120020.65427217@nic.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="phxONRF6915sfI253RUyDoSsHvLMD1HYP"
X-Provags-ID: V03:K1:SPW8cguZ+tAXZm01t+lsEwbMWNtgNt2dQ354SwAVHNmvjKYKE74
 nMB3abFQZp0DhdOXp2tfJRy3mf2hsvdyKxFZJ2Xlpy4B+oFWbhz1w7o80um4+2A6A7IkP/w
 FU+2Eyp1aMwpM/C/Majuq2oDJxgYHs+YO6PLhMmZrxg6x3DqIdSR58fgStlO77t6fAedpU/
 OxSU1Bsw40Fa1e2ddX5OA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JShlJORxd5I=:P4+Cf7GYl7tM9DlXFkiHv3
 AoAJdMRJb/oPlwBTr/+dtDiwBEnMy6Ek9kGLfG8J2OwLPB5l9t544YZau+cJMBAFBtaBNrnye
 WmcPtbG6KNrAF7oj5cEsfS0jL7e2XhPwrflgBoL2vjLxDZwrW2evnbaRO4xhBhIseu1yr8Hl4
 cPFvhMeyTyQJE07uxAV9NP8eJVnHfKkvFt+yTMc9V0FSEES8slEwpz85/gDwp/x7ybTIBUKSG
 +PF6wmI1oizqAdsNBuAnQBWjI3uFC8cYJiWrSBcn7D+EyhN/QR8udErA3yuLGtc2gdiGiKzBg
 Gz9OZHOVI5CzKotNDViXB2y7naaEi7lQN7Yw+nINSGvG9eDIJCL5OVmVNovkx9IyrUY8iYEkH
 rMOL3rp1u0GRJxI5zJ3VLrKp7cqmqOSQeNrH1N0ljOojBV/CltXV1uLee1YoAc4m5hm1tOEuO
 yhg3nWnaCHVYujaEOBe6Mn4NCS0vxR9tSo0FRGN2i7YnxUEUtuwjbCXpzXDy+jFDmellSId9z
 T558+OuE6ZVg5wbrijyEy21/sI5wLCARgPzUSMwRX9vN98WEoxmS/2fsHlCOa9nwyjR4nc2MZ
 qPuc3hFgdG1H3GAFdsEWO1dnJ0wiCoJQKS0741OR4HotJz51aAwoq+w5og75jJYZ4VLe8BCtP
 glJxH/nv9YyywW6YDvqB+O6ovKcxRBc+G2Ufy5ZIqV/ZhUMNeCbkPnbOcnMjqZm8N75nd9aEr
 M6VL6pjiP9XCjL0YuCqzc6NPc0a8ksEFLvQQWYRFuo7auYc56D3dv0IEWX+Hi8CXQVLNMgvE1
 FcwJCwmsas1YbqQ3sNiyhGoC5AjhRL9/zK2P1iwi8RQZQRmWSr/v3JX0lIUzn8DPB67gGHv9V
 /xxwsmbuo9c9w8bk7tpNA4FuhyV51ASeMot+f6cVuIC3gZN/JU6WQIrbpxky3hf6kc4bSeoqG
 CRn/clcFcrWPbd1GBmRlkPy6rjZpUiD8mdcg8OD7qb2BvOIejHq54HGZ7NchiZXPi3wUsHbiM
 D/IGcoGxPW3dy958FYZyra0jJgIuIJVzfgM2mM5dk35+z/2HmV6Y9EJYp26IpAUnO7PfRt8i0
 +XpahcKWpdamtQujHI63+eBVMhMTMqjXMxN0HnC0FsDithcsejhqy834k3W0GlEMXjGDlq3Ix
 K3jETvlGKhYJQGEAussxpL0AII7JLvXYrOz6w7GecXtFse9acvLBnvdWLF8Kq+sq/b36DeuF9
 deT1Wcx7ZVQHrlM9z
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--phxONRF6915sfI253RUyDoSsHvLMD1HYP
Content-Type: multipart/mixed; boundary="8FDKPp17EuEBd8wuMWhxEFYTYtAY0m8x5"

--8FDKPp17EuEBd8wuMWhxEFYTYtAY0m8x5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/25 =E4=B8=8B=E5=8D=887:00, Marek Behun wrote:
> On Wed, 25 Mar 2020 16:27:16 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>> On 2020/3/25 =E4=B8=8B=E5=8D=884:09, Marek Behun wrote:
>>> On Thu, 19 Mar 2020 20:33:19 +0800
>>> Qu Wenruo <wqu@suse.com> wrote:
>>>  =20
>>>> [BUG] =20
>>>
>>> The subject line should not contain uboot keyword. If you check git l=
og
>>> for fs/btrfs, the commits always start with:
>>>   fs: btrfs:
>>>
>>> Also please don't use [BUG] [CAUSE] and [FIX] in commit messages. =20
>>
>> Why? I think such section makes the analyse much easier to read.
>=20
> Hi Qu,
>=20
> I think your commit message without the tags is well-readable, but mayb=
e
> this is just my personal view. On the other hand such tagging is not
> customary for U-Boot commit messages nor for Linux.

Got it, would try to control my eager to use such sections at least for
U-boot code.

>=20
>>>
>>> You could have also added myself to CC, since I am the original autho=
r
>>> of U-Boots btrfs implementation. I just stumbled on your patches by
>>> chance. =20
>>
>> Since there is no maintainer name in MAINTAINERS file, there is no way=

>> other guys would know who to CC.
>=20
> You have a fair point, sorry about that.
>=20
>>
>>>
>>> Also do not add linux-btrfs mailing list for u-boot patches. =20
>>
>> I don't see any reason why we can't include the mail list for more
>> experts to review.
>=20
> See below.
>=20
>>>  =20
>>>> For certain btrfs files with compressed file extent, uboot will fail=
 to
>>>> load it:
>>>>
>>>>   btrfs_read_extent_reg: disk_bytenr=3D14229504 disk_len=3D73728 off=
set=3D0 nr_bytes=3D131
>>>>   072
>>>>   decompress_lzo: tot_len=3D70770
>>>>   decompress_lzo: in_len=3D1389
>>>>   decompress_lzo: in_len=3D2400
>>>>   decompress_lzo: in_len=3D3002
>>>>   decompress_lzo: in_len=3D1379
>>>>   decompress_lzo: in_len=3D88539136
>>>>   decompress_lzo: header error, in_len=3D88539136 clen=3D65534 tot_l=
en=3D62580
>>>>
>>>> NOTE: except the last line, all other lines are debug output.
>>>>
>>>> [CAUSE]
>>>> Btrfs lzo compression uses its own format to record compressed size
>>>> (segmant header, LE32).
>>>>
>>>> However to make decompression easier, we never put such segment head=
er
>>>> across page boundary.
>>>>
>>>> In above case, the xxd dump of the lzo compressed data looks like th=
is:
>>>>
>>>> 00001fe0: 4cdc 02fc 0bfd 02c0 dc02 0d13 0100 0001  L...............
>>>> 00001ff0: 0000 0008 0300 0000 0000 0011 0000|0000  ................
>>>> 00002000: 4705 0000 0001 cc02 0000 0000 0000 1e01  G...............
>>>>
>>>> '|' is the "expected" segment header start position.
>>>>
>>>> But in that page, there are only 2 bytes left, can't contain the 4 b=
ytes
>>>> segment header.
>>>>
>>>> So btrfs compression will skip that 2 bytes, put the segment header =
in
>>>> next page directly.
>>>>
>>>> Uboot doesn't have such check, and read the header with 2 bytes offs=
et,
>>>> result 0x05470000 (88539136), other than the expected result
>>>> 0x00000547 (1351), resulting above error.
>>>>
>>>> [FIX]
>>>> Follow the btrfs-progs restore implementation, by introducing tot_in=
 to
>>>> record total processed bytes (including headers), and do proper page=

>>>> boundary skip to fix it.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/compression.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>>>> index 4ef44ce11485..2a6ac8bb1029 100644
>>>> --- a/fs/btrfs/compression.c
>>>> +++ b/fs/btrfs/compression.c
>>>> @@ -9,6 +9,7 @@
>>>>  #include <malloc.h>
>>>>  #include <linux/lzo.h>
>>>>  #include <linux/zstd.h>
>>>> +#include <linux/compat.h>
>>>>  #include <u-boot/zlib.h>
>>>>  #include <asm/unaligned.h>
>>>> =20
>>>> @@ -17,6 +18,7 @@
>>>>  static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 d=
len)
>>>>  {
>>>>  	u32 tot_len, in_len, res;
>>>> +	u32 tot_in =3D 0; =20
>>>
>>> This function does not define local variable values in declaration,
>>> please don't mix this. Also tot_in is of the same type as the variabl=
es
>>> above, so use
>>>   u32 tot_len, tot_in, in_len, res; =20
>>
>> Please give us the proper code style doc, I understand that each proje=
ct
>> or even each subsystem has its own style, but without proper doc it wi=
ll
>> be a mess to maintain.
>>
>> So, please show the proper code style for us to follow.
>=20
> When patches are being sent for example to netdev, sometimes netdev
> maintainer or reviewers nitpick about coding style and ask the author
> to fix this. Not all of these coding style requests are
> documented nor does the checkpatch script checks for all of them.
> Sometimes the only way for to get to know the coding style is by
> reading the code, and sometimes even that does not suffice. Either way
> these are reasonable requests and the authors fix the patches.
> I know that I always did it, for example when I sent patches for the
> mv88e6xxx linux driver, and Vivien or David asked me to fix such things=
=2E
>=20
> I understand that people may find this exaggeration, but we know what
> happens when nobody cares about such things: look at U-Boot's ext4
> driver.

Fine.

Although it may be tricky that if we cross port btrfs-progs (not kernel,
as we don't really need to bother the full functionality from kernel),
the code style would greatly change from the current one.

>=20
>>>
>>> And put
>>>   tot_in =3D 0;
>>> after line 24:
>>>   tot_len =3D le32_to_cpu(get_unaligned((u32 *)cbuf));
>>>  =20
>>>>  	size_t out_len;
>>>>  	int ret;
>>>> =20
>>>> @@ -27,6 +29,7 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen=
, u8 *dbuf, u32 dlen)
>>>>  	cbuf +=3D LZO_LEN;
>>>>  	clen -=3D LZO_LEN;
>>>>  	tot_len -=3D LZO_LEN;
>>>> +	tot_in +=3D LZO_LEN;
>>>> =20
>>>>  	if (tot_len =3D=3D 0 && dlen)
>>>>  		return -1;
>>>> @@ -36,6 +39,9 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen=
, u8 *dbuf, u32 dlen)
>>>>  	res =3D 0;
>>>> =20
>>>>  	while (tot_len > LZO_LEN) {
>>>> +		size_t mod_page;
>>>> +		size_t rem_page; =20
>>>
>>> The rest of the function uses u32, not size_t. Please use it as well.=

>>> Also since the variables are of same type, please use one-line
>>> declaration only, eg:
>>>   u32 mod_page, rem_page;
>>>  =20
>>>> +
>>>>  		in_len =3D le32_to_cpu(get_unaligned((u32 *)cbuf));
>>>>  		cbuf +=3D LZO_LEN;
>>>>  		clen -=3D LZO_LEN;
>>>> @@ -44,6 +50,7 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen=
, u8 *dbuf, u32 dlen)
>>>>  			return -1;
>>>> =20
>>>>  		tot_len -=3D (LZO_LEN + in_len);
>>>> +		tot_in +=3D (LZO_LEN + in_len);
>>>> =20
>>>>  		out_len =3D dlen;
>>>>  		ret =3D lzo1x_decompress_safe(cbuf, in_len, dbuf, &out_len);
>>>> @@ -56,6 +63,19 @@ static u32 decompress_lzo(const u8 *cbuf, u32 cle=
n, u8 *dbuf, u32 dlen)
>>>>  		dlen -=3D out_len;
>>>> =20
>>>>  		res +=3D out_len;
>>>> +
>>>> +		/*
>>>> +		 * If the 4 bytes header does not fit to the rest of the page we
>>>> +		 * have to move to next one, or we read some garbage.
>>>> +		 */
>>>> +		mod_page =3D tot_in % PAGE_SIZE;
>>>> +		rem_page =3D PAGE_SIZE - mod_page; =20
>>>
>>> Is there a reasof for mod_page? You could use just
>>>   rem_page =3D PAGE_SIZE - (tot_in % PAGE_SIZE); =20
>>
>> I tend to keep the difference from btrfs-progs to minimal, as that's
>> what I tend to plan to backport soon.
>=20
> See below.
>=20
>>
>>>  =20
>>>> +		if (rem_page < LZO_LEN) {
>>>> +			cbuf +=3D rem_page;
>>>> +			tot_in +=3D rem_page;
>>>> +			clen -=3D rem_page;
>>>> +			tot_len -=3D rem_page;
>>>> +		}
>>>>  	}
>>>> =20
>>>>  	return res; =20
>>>
>>> Sorry for this nitpicking, but I would like my driver to remain
>>> consistent in coding style. =20
>>
>> I know uboot btrfs is mostly backported by yourself and I respect the =
work.
>>
>> But please add yourself to maintainers files, and also consider use
>> existing btrfs-progs code to make code sycn easier, which would avoid
>> such bug from the very beginning.
>=20
> I am going to call this crossporting (porting from Linux to U-Boot),

Indeed crossport is much appropriate.

> since I understand backporting to mean porting code to a previous
> version of the same program (ie. Linux 5.6 to Linux <5.6).
>=20
> The U-Boot btrfs driver was not exactly crossported from Linux btrfs
> driver.

The kernel part is too complex, too fully functional, and too limited to
kernel infrastructure. Things like bio is never really used out of
kernel. So kernel code is seldom a good source for cross port.

> Sure I have many times read Linux sources when I was not sure
> about something from documentation,

And any complain about the doc is welcome since it helps us to improve
the doc.
(Yep, another reason why getting btrfs community involved could be helpfu=
l)

> and this reflected on the U-Boot
> implementation. But code-syncing is not possible with the original, as
> it was never intended to.
>=20
> I also did not collaborate with Linux btrfs authors when writing this
> driver. These are the reasons why I don't see much point in adding
> linux-btrfs mailing list to Cc, since they may have never seen the
> codebase.

But from the git history, there are some other problem which can be
exposed earlier, like the tree search behavior.

Thus sometimes it would be nicer to get the fs guys involved, some ideas
like cross port btrfs-progs to u-boot even before trying to implement
the code base.

Anyway, I'll update the patchset to address your comment soon, and
explore the possibility to cross port btrfs-progs to make it easier to
sync code.

Thanks,
Qu

>=20
> Marek
>=20


--8FDKPp17EuEBd8wuMWhxEFYTYtAY0m8x5--

--phxONRF6915sfI253RUyDoSsHvLMD1HYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl57QU0ACgkQwj2R86El
/qgO1ggAog2lCgtJMbeA0yIKmuy//NU8wgXTuxX0LV0SsqQUWC6Wi4QxkQ06t2D7
i3+gQwRro3mqFgSDkZRWQaRhhWD8dKxpeF9JzlhiRKJfHEareJ7kVeSz5g99UTl6
rvI6HEtYx69l4/oYNxaKuY7TnQF5Jjo5Z33KzPbAfttDiVtHcA9XrQKQcehu6bE0
YeClYCaIdmGkFtfwynSMwC3ZjuMgQi9LGfQQZDtwzo9bU6lMuaDLbGtZIZzntNEv
bxm/kQ5bCN3f2vf+nmKuLJpI6CmCwDoJU5gK4QDhNSR3znhIiG4IoU6Gzuo6XdJt
uL17htSMhDoHW1BMKTsLVQKBxmLkYA==
=RB3O
-----END PGP SIGNATURE-----

--phxONRF6915sfI253RUyDoSsHvLMD1HYP--
