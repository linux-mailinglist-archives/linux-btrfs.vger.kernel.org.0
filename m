Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B989190BD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCXLEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 07:04:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:49973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgCXLD7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 07:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585047829;
        bh=s/CP7kUrr7XVsEXTx10tY9L55bfEn/dYwT03h+yDKkc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jAxDR7cYGGsxqYE47DxDNN7eYwpRUVoRVDVtuam9BVwVOyHPjoirDXhpSDdEkk4fx
         ehbEp/GMHg2r9AGO1eRXMXkysAPRufaZEzJzAOO3FIJWKteVVMO6sH92t2fqKJ1xig
         rtrHt8jMnAwFEXK6w9Ul25Rpf5k/8Q1btGzwERmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlKs-1jlNOW1JYG-00dnkj; Tue, 24
 Mar 2020 12:03:48 +0100
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
Message-ID: <178a0729-57ad-030d-7bbb-e3afb0278d57@gmx.com>
Date:   Tue, 24 Mar 2020 19:03:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319162822.GG12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8OfmTL3JLJCnFG6USfp530g4orFvQYvVp"
X-Provags-ID: V03:K1:XxsS9nT27nJyD3VKh2WbivYqGxpbuRszfYcJcj8um4B0mHjPqKY
 zwTn9JZiHrHySBYHnpHbCGjVmuRu2D4ILk6wiEvvxhmZ1gi97mMC3oMm/M/voTW2lbs9jac
 EH7EMEXv4bgBp4+hMhfdFH2l7OjXghJtLyfVAgWTeM1l78fN/mEcWw+IvZvmyLpr4fkcs1g
 tTXyGlqCS8GLAHquyn1nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Az1FSRBhak4=:HF6WWOSKerg0eeJFGWP73/
 owDGmy26GVXdFNuqMm0UzWYYH0GrZOxEwTDsRC9f4cPp4D+5CX2C7Deuww8QPsd5KAV4XHogl
 JU3SgFiOfEDUaWEfpT8SjWRzSyJUL/IKuLxVlAtXFh2Z7cEfew17q1f9jFG4u2UCXfKbzPgt3
 /qWjA2iTMRY62F80lkT4bOaha9XP8MdJbNV40HD1DxcN+nbPvJp6dxoyCws5Msk4Ulgf+BTDp
 54dQMJyau9XV+y9seXgo6Jou/ygPf+pi3GEoV6Mba0Ryw2JVdNkPDTUsJvClpSXdAW3SrsMtk
 j8K0RkmQMW5uhXoGa4kVrvL7i9lWve+5SV5AaYhIGq5k2qFT4UF6kri25AW6hxKSP0Wc5MNCb
 DTp4ff92rWwK1yDl3z9UJLS3sVvSXaxfD+FcljpwNKgBvX4JDdquidpoq2UasahVC0Ua2j3Cr
 4Y/s1eg53hbcypVuJgxC5w5CzgIiXHkvNIlcU1mkjT4qlqjoNxpwoZ9Pm6a9qNZqY0jMGJWUE
 F+Kf2tSuL9x1ESH2JAK01cMQtbr738h4LKgBSDIHSkGC3o0XuacuLogiOaP1Z3lqS0D9HRv13
 ODRrsxtcOFRpaWDdg1wct+o4O1QkVmLYUupubtBlss4ByYvfsOULoURrNQmfsmzH3F5q5tEsV
 o0wrD25yUGlSB/pxZEkswzwtAT4IkuYn+TNXz4udFE98Pvfk81WIinodD5s7uf3chVM4zRfr+
 YE5r1LD5U2X/gFJYWrP/E7qQcMaHVSI9IBSIvJid6MqKha567jjHr8ni/RMO4ML80DIwjdGy+
 OgPQY58yCsBsdAQYVpmwXeSZDmum0Ulx1ANkm/XPJmLhK1SLO8sgCHCDO5VR4z/T1sa8TR4Or
 OITYE9f1L9xbPUWqEq5OpaNwJgYS4mZHrcB2AVpRyKdmW9s3SEcGuzsw0kmbJQ4UoqPuzrhV8
 fDo1zaXQyS1IQwXpP2d9xoFtvQYc05kR1kh8eAPNsvqqimu4JVPKhLGZDW9vLfFcGyyBANgUl
 Qy4cW9B2dIdaj5CBSbwGpQk+W00Gbl3xNpkoiMIJl65J0r0mQ4gQ4drrc68PT7bchFD2zpEUw
 UtXheksPmrO8VvVEhLbQYytvwqM1lSS6HTGJPGPMS6NrljAH6uOZaTLFuJxqyrn1V4KqOw9UM
 lVTMwAZisIgaBy25KDcVsITPggnNwJaeoqxYVT71VfFylhhv6qgtDWROWUk0zJ43NiJVCoZOc
 u7bt0mxR7fVz/71UB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8OfmTL3JLJCnFG6USfp530g4orFvQYvVp
Content-Type: multipart/mixed; boundary="z0AzPhsXX8yGSulRVXWM60UxLU6iGaorj"

--z0AzPhsXX8yGSulRVXWM60UxLU6iGaorj
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

Would this plan look OK to you? Or we need to wait for the full
re-implementation?

Thanks,
Qu


--z0AzPhsXX8yGSulRVXWM60UxLU6iGaorj--

--8OfmTL3JLJCnFG6USfp530g4orFvQYvVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl556REACgkQwj2R86El
/qgTVQf6AvCa/b5yX6yvExsUDZv4igMquvR0RrsKBCLkasICAaIHOTRW/3Lt7gNf
qk5Xo/pDbC7zT4ga9g0nbUoj2tVrlA4vCo7fg7QeKb6nCW44/8CE5t/i/M94OXJk
fxn5dzs63NZESjLqDfkBSSwJx8/DoQX1NbO6C9IZ2pHMXmk3oYF4h2cak76LmXnN
2bTJOsu3gXnZAL4qmNINnPoglZIKyY1t7QqcKIu9RRZHJtanvbApryVLxKn7+n4z
mdwEMnuAXp/KzYOn9XvTE/npvbiAW5DHiEFXv/iaE0lZtYbS7PcrDZFh65nJddif
lftHNfvcPNBO1lMiNs5bpE5b45eF1A==
=iEQy
-----END PGP SIGNATURE-----

--8OfmTL3JLJCnFG6USfp530g4orFvQYvVp--
