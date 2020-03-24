Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F39190BD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 12:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCXLDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 07:03:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:36029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgCXLDm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 07:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585047815;
        bh=UfgwrIhOBjzAiaLFYEF01Kzvk1DbFN74xUXgShD4X5k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jkrwsJoyA6upJGWmoIPzl6YSXogx4uYupSbs9FzWcBoFQUgDWw+OreyfJjmvjimfZ
         7IBhDqMKfyS90vlt7F9jVrKjqlOzlBbo29aQeYN7xBZQV9vf37/Quby37sstXrrU2H
         QzHERnGlWhqsqJpdhAY8d/OQA5q4MFDTr/CkBs5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mjj8D-1jezcL1EpX-00lAKs; Tue, 24
 Mar 2020 12:03:34 +0100
Subject: Re: [PATCH 2/2] uboot: fs/btrfs: Fix LZO false decompression error
 caused by pending zero
To:     dsterba@suse.cz, Matthias Brugger <mbrugger@suse.com>,
        Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org
References: <20200319123006.37578-1-wqu@suse.com>
 <20200319123006.37578-3-wqu@suse.com>
 <49c5af50-8c09-9b49-ab44-ebe5eb9a652c@gmail.com>
 <20200319135641.GB12659@twin.jikos.cz>
 <46e58bc7-4a4c-fa2a-33cd-0e8df65d6bac@suse.com>
 <20200319162822.GG12659@twin.jikos.cz>
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
Message-ID: <0e17f85f-46ab-2c2b-1547-3ef6b8b81d93@gmx.com>
Date:   Tue, 24 Mar 2020 19:03:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319162822.GG12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HBrOqnFmpnsXH2auMee8iDtcOMSWCrMlN"
X-Provags-ID: V03:K1:AmsAMaYeVUSlBfUmuFgz7PZEo3z3uRmxPOQf5zX5ICmLk0Gm0Zb
 SHVURc6KpQ3fZ+SbV63uKJEUwLLFwOE978N9na1tPepemPGafibNdmHKs9YhC4OODa6dDg7
 8tTeNRp7V2Sr/dmQan3Q3bqENHwyJbuvqmo2gMuEp7+zX6+Za8WGQCogX/e3zZfb2Dav+Ik
 STwD5ZpCIIsz0jRo7izTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYZnmlfj52A=:ZTY7yuSfY8GpL/cxhfeukv
 k7EqoI6itxMTuWW19QhRLz/QmtX+yABf150aEKm9Esioce8fZj/r5/yY4GiDPHzqWOKh1xG9p
 B9M7qPxxbGbAy54sP8FgsjEUYdn5T8CIS3hxrOjgRKCOp4Km6h3Li1ibMfZ19/4HxG8klm5Rs
 kIXGTdnUjcXnkTJvVr96lPL9oQ/0dZBpd84JacbZTrbFbmXriNFKb2U6AALi9a6J8DkorqPUy
 ZvrNr1+a/cE+cZulyM6952BixziaKsx9zn3/P/VRuaV46wXvqFiEioblsNJipzgxVNSYpetJW
 HL/8LDBUwXTkDB8bBjXm/CspZ0MdnvZM3+zw4iP7fXy90NAnh0gxAKxxgjy5+mWJ4SdhRXosT
 YEOFghhAr/j16wCQT7emtFDAScL55lChOyYue7L9WI71oRjjT3l353F6z8gN1Cqg0rzn7rYlZ
 89gjadCSdMPgxIUZNhzhQYXfpH9cHHNDixjdiFUU6JAzapsw37ihDBZsjn44CONGklTq6SN2a
 1AMkD3a/6Qy1ztfSU2QQVvb4D2nyLVffy7GCr3DqLHqOWZM6sEXULNsj7AOuotG7WuUs6EWfm
 ZhE58R18V1q/B4XjpW4Lkw0p2AiwojhNwtg2MzMpjJ8hateIjDySmmS/quqbOOIogtwSy0DsJ
 1LmEwRdSuqRuu0fvsKUgVJGrjhp/Gef78yi+cDIKleqgNps2YF1wJVETYtfLMw7Ovnub7SaP9
 wm87JL7XaXTeaNOC5hiRzBurBqas94RtnesTZZK4Ps9/93s2mntPe+gBBT2IheQJ8vTYOZOIn
 wIZkEA4KCDVkPeXcl6jT1tfD0ZQHBF/OqFZ+xP2aYauHJHtwE5ASsmztFTBv0iSLyC37oFO5W
 K5xiSQra+SFfV3Ta3BwvXWJFMrivvVBGwadwNf9sY5EcAxZfiN726OHJyEV4h9PX4NbqW05uu
 6I7Ksqmp6ffGbX1A4a/VtzZVhz0oGU/TGApzxZggnSBZ3XdWPC0AZbcecSKpLQbqTlY0PH1VO
 LDnoLlOd2oDSx0lnXnvULtEfX+9wuuXsRJpjlyA7tdaD9Lm7Is6AJJzgiXAWksUY9B3NVZrY3
 71ljSZVGWbU1dzxK13C4oZz+1+5ufZ1m4MCiu8uorle5TOxw8p1tw8lShFiqPW4u0LkLX1Kyt
 +DFSbbkYHrjwip9QDoQxjKW3hqvXK/YhJKT2DaEFaF1bOIOZW+PQS6SLgSm89SDyaCKIu7Uh2
 SVGE7TqQXKigNVjs2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HBrOqnFmpnsXH2auMee8iDtcOMSWCrMlN
Content-Type: multipart/mixed; boundary="einzXboniEHsa4PHz5bUG8M46N1RM41yJ"

--einzXboniEHsa4PHz5bUG8M46N1RM41yJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/20 =E4=B8=8A=E5=8D=8812:28, David Sterba wrote:
> On Thu, Mar 19, 2020 at 03:34:12PM +0100, Matthias Brugger wrote:
>>
>>
>> On 19/03/2020 14:56, David Sterba wrote:
>>> On Thu, Mar 19, 2020 at 02:33:28PM +0100, Matthias Brugger wrote:
>>>>>  		dlen -=3D out_len;
>>>>> =20
>>>>>  		res +=3D out_len;
>>>>> +
>>>>> +		/*
>>>>> +		 * If the 4 bytes header does not fit to the rest of the page we=

>>>>> +		 * have to move to next one, or we read some garbage.
>>>>> +		 */
>>>>> +		mod_page =3D tot_in % PAGE_SIZE;
>>>>
>>>> in U-Boot we use 4K page sizes, but the OS could use another page si=
ze (16K or
>>>> 64k). Would we need to adapt that code to reflect which page size is=
 used on the
>>>> medium we want to access?
>>>
>>> Yes, it is the 'sectorsize' as it's set up in fs_info or it's equival=
ent
>>> in uboot. For kernel the page size =3D=3D sectorsize is kind of impli=
cit and
>>> verified at mount time.
>>>
>>
>> Does this mean we would need to add a Kconfig option to set the sector=
size in
>> U-Boot?
>=20
> No, the value depends on the filesystem so it can't be a config option.=

> What I mean is btrfs_super_block::sectorsize, where the superblock is
> btrfs_info::sb.
>=20

Sorry for the delayed reply. (Stupid filter setup).

Currently most Uboot boards should use the same page size setup for its
kernel, and most btrfs uses 4K sector size.

So for Uboot it should be no problem.

Although the best practice is to read the fs_info::sectorsize as David
mentioned, but the code base doesn't allow us to do that yet.

So I'm going to backport the read part code from btrfs-progs in the
near-future, and completely solve it, making it sector size independent.

Would this plan looks sound? Or we need to wait for the full
re-implementation?

Thanks,
Qu


--einzXboniEHsa4PHz5bUG8M46N1RM41yJ--

--HBrOqnFmpnsXH2auMee8iDtcOMSWCrMlN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl556QIACgkQwj2R86El
/qhn7wf+J81VVtZrPfOw+LaChdRMcfgiTaruX8uE10l1hca5VxeI/nwPo/l8KlQ3
tpZb83BNdTWRWO4CRDoQaVPP0hz9vLscNCxLZbguNpRv8803erQ76G+L+/iAg+Qv
CKOmko4a8YVLxqBsieVEKEEzYiE0U6GbZTgECh4+8BCfVsGbf13Xmx/nnutPVlD6
2lY1WZ0wWzB1qKgRYublnObDjZmuzaHEoNhvMDJ9Vq0YFFViklZh+ysScZRgzDbi
if3O5mLzBXAnaoHpBtlg7U5n/tEMBFI/yvMKKFFgvkCdsJInu7Ap0JXBUetyDxej
4QEDtyTI+bgJ4m+l1PXMpYq3eBvUeA==
=l/2B
-----END PGP SIGNATURE-----

--HBrOqnFmpnsXH2auMee8iDtcOMSWCrMlN--
