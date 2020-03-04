Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0EA178753
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 02:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgCDBAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 20:00:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:54685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgCDBAm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 20:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583283635;
        bh=nU7ndp1PZLwXq/7frlnp1PAB04fTmtwHtfBAjHKUbHI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MrHbH0BVSHJlvoFwprEo2HUKbwdMuYn46zv0OTmjnS3hEWwFm/a7uln2hJ4l4u0iX
         kLX4FCWbPvd76ht/0YkWBhOMt/DogZ8tz/EUuTkd+6IZv1FWDd4H1QEE5WY+FnjZdv
         nZAJD0zlWnIXHJpARi+abo+07FMVrkoI0fI/wBFE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWASe-1itDi41sB0-00XbxY; Wed, 04
 Mar 2020 02:00:35 +0100
Subject: Re: [PATCH v2 05/10] btrfs: relocation: Refactor tree backref
 processing into its own function
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-6-wqu@suse.com> <20200303172917.GK2902@twin.jikos.cz>
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
Message-ID: <8e35a517-9fdd-cfed-674f-b22602e6be7b@gmx.com>
Date:   Wed, 4 Mar 2020 09:00:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303172917.GK2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UZUqh3wxv7F7FRGa2z9Ug9AGLIsQiwGzc"
X-Provags-ID: V03:K1:U6VbwBUz5WnI06PbBQjk1JtH0hQ+G42ypWd+qXrvvT4gz9ZBIl9
 QYPsODj5I+PuXXz/e3ancSkC255pqfxgF/PrBSpGvagkkaEx5Y3kBgohwCVJcruxKMngXyH
 ot9aVSDG8htI4pWJ3KAlltrkF40cfHezx6HgWx48IZuG2H65e/FZKRdPdMoL9Lkm6TKx67Q
 X04VDkT9j81X2PHj39rEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4oWlCswgg/I=:09EioO3y/29ENmC27iTEGi
 wpY3veg0xFIoGMFdmJNX0nDO6sM9+jDiDfTwYPPu9xh760YDvmjKtrbOolwuBtOGXP1093bfC
 wBYHp87Vs6Y7cjqMpwjAufrcp4/LcKCP1dSPCljgX1YcKBePE98n1Vb+6RNrLaaTIXVIObrl6
 G2G/K+Fp+0s4is59ZZ0l7IzGzSkn/WzLJIzMT5Dz90ah5zsot9kWRkqT8lrSCmxcoWpInRJqs
 /ER3Cn4Mj3I/R7G+vqaestm+xD91bj/bnR87WyjGKo5qp49hgZeuCMvpgqdSqd8/zET9VLaCQ
 oghytCmBRH4AJt2WFd/oRIfIrZAIWFuSr2GxL5C5FqnvNxOzFjgEAUZXUqqGfsAQERF7DMrbA
 FPJumZnI6cuWheqeDNs8jUe+8dzbX1bjS4q8n31XEkYcbftG9Zl/LTL/MdwdNLDZFNaPE1uVG
 PUbWoEDTOEwKPizFtpGFAhZJ4DeID+VeK8vpjo6aQNJ4VjyIc3Wu4kz7W7T/ibPpq6Ar4zbD1
 3qTPdcByWqnwlPpYsoHR6NRljtcWuAsNq7It8Vi7ze7Jt8Yra6LYxrTs8wB17mO9tbAoRGJ/Q
 UBjvGEk5gmMB20bgcaf4yUk2EUwnogtwiyGNtXMVfFgLAJTfzMmGxh5aUE6ls4S7QMWkbxCFe
 KR51jIxQCApPy+9a6JVJrw7LmDsb3U//wywO9oYR9NI1b79Xl4So+3pS781K6VTqIbsgKb4e4
 cSTzkzVIpJjV5g3k6Rk9qNrA2jXqSTzIx+QD5PX8kBHwywBsI+b4keUFMS01l9NUxJAmmGMym
 N806O4as8SpEKjdiUHBRkZ5SxRi4irCHGCiuZ/yju+BDrsT7tztSLMxjO+ReuZUY+P8jxJLHg
 hA4CW1F2cFbd5HpWoJXBjQf4ew2IWzxySJWaGS7ucAMVhf6f5U9MZeKV6ty6LZqYgEnUyq5kA
 2ngFb/B/iyQIbMpmvu7p1OwBHkfKN4w4Exz9zw6lzRRRuVyUZL+BJNhIeeXar1pV4Vvr95GyU
 oc85/t0rehatrYWfLUeHldYSScZiR1RCzCJdIkub/5dZZNs6J6VmrzSctj65/86KMgPQFoco1
 S46HOxBteme8O4kP6/ohi4brg7/awC4RFKbOJgl9hBI8MDEpD14KPz2R7bhQrAKTSQGfNgbVD
 5T43Ar9o2P1sfxQmPU9pxSTXGd3XkjV2tTIi8tvXwaNwExiHYGqppG+6s+SPxiVGzaGD+p2af
 WUL73znYfASyw9trC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UZUqh3wxv7F7FRGa2z9Ug9AGLIsQiwGzc
Content-Type: multipart/mixed; boundary="yjhSzXiX84iPhGabxCUMRccg4qdzHKUaA"

--yjhSzXiX84iPhGabxCUMRccg4qdzHKUaA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8A=E5=8D=881:29, David Sterba wrote:
> On Mon, Mar 02, 2020 at 05:45:48PM +0800, Qu Wenruo wrote:
>> build_backref_tree() function is painfully long, as it has 3 big parts=
:
>> - Tree backref handling
>> - Weaving backref nodes
>> - Useless nodes pruning
>=20
> So this is the first patch that mentions the 'useless' nodes. This seem=
s
> like a misnomer or confusing at best but I haven't read enough code to
> see if it's really the right name.

The 'useless' is from the original code, there is a list called 'useless'=
=2E

It's not that useless, those nodes are just ignored, but still cached to
prevent extra lookup.

Hopes there would be a better name.

>=20
> Also the term 'weaving', that seems to be added by you. Did you mean
> splicing or merging?
>=20

It's complex, but definitely not splicing or merge.

The overall workflow looks like this:

1) Iteration works build a map like this: (start point is X)

      A       B
       ^     ^
        \   /
          C
          ^
          |
          X

   At this stage, it's single directional, means we can only go
   X->C, C->A, C->B

2) Weaving part makes the map bi-directional
      A       B
       ^     ^
        \   /
         v v
          C
          ^
          |
          v
          X

   That's the weaving part.
   Any better naming is welcomed.

Thanks,
Qu


--yjhSzXiX84iPhGabxCUMRccg4qdzHKUaA--

--UZUqh3wxv7F7FRGa2z9Ug9AGLIsQiwGzc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5e/a8ACgkQwj2R86El
/qh4MAf+N2dKvkXsFvuL1HXCzSY0yGMsLPhN6+6GecL5LzNLdW0l9C3HtvFvvR52
qcJzPIW0fdQi7bsPbdAYLJyalK6aD0zbtQ+jV48aInJQSuELImrDoClu+FI8jZ2A
35Qs3wGveOO2cK6O1f6blFTI3arCzLJNrmXGiNTpq5mgDAsu0Rp3oJ0QxNbvvHRP
kVkLvgE0yUJrtiWBoX5Rf0dyhvBWha9iHEcmEaj+awmhh5pCcMaZ3HFagdVHal/1
LKbm+OVKjQMaXWO/2KMadCfyfnXwpQxTv7GcQ5LrUJuWATo9J8yOv3ZYV5z/ggJE
6iSAXRqa4aeAJKvrwVMVZwSW2JZYpQ==
=APRj
-----END PGP SIGNATURE-----

--UZUqh3wxv7F7FRGa2z9Ug9AGLIsQiwGzc--
