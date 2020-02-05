Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC241152458
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 02:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgBEBAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 20:00:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:54755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgBEBAn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 20:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580864438;
        bh=9K09YZItbnNQZWu58KdVHyCTs7nKGQCru4Ngym1ZbpQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CMyw6HtUlcO46gZu7pGlAKA91pQia1/rmdnSnPvs6T8ZUAzbR9TCChf4ubYUI9Bna
         4lVkmUsr2MWhGN2c6OFIJ/MR+Bl8gzaL957oEse4XE+VseJYjs27tOqDph4HNnG5hk
         zAbGoRd1TkRvkJY6qp1pD38nxPjmXb2ByqHV0y3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYXs-1jO4jr26RS-00m1Pn; Wed, 05
 Feb 2020 02:00:38 +0100
Subject: Re: About stale qgroup auto removal behavior change
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2dfbf017-9c82-1224-bdfc-73d0c0111e40@gmx.com>
 <4cc678c3-1472-1432-7314-53e22129f757@toxicpanda.com>
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
Message-ID: <b43a07d2-566e-5900-fa46-cf7392cd47ef@gmx.com>
Date:   Wed, 5 Feb 2020 09:00:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4cc678c3-1472-1432-7314-53e22129f757@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EnsmqUjq4HeuPGFgxPfwRa6DkkDr1PKK6"
X-Provags-ID: V03:K1:yRItzEfe1TYJbD4HPmA6SSp5HFL4yqjmg0yZ56JfL1kE6VkQD1N
 7RZDosS7rcEYdCVmjnnaMUsP3OdeB+upsaJcWnWjSwCMOKu8n/kKvHS1ivb/pXY+uVbV/Sc
 HavL8NecQ4HySk3zBBgYk0zoACwzGisaqPClewrUb4cb/VQvLC1AZbm6qOVGPIPPVjFBPXE
 mO//qk/nlhZDWfgS9Y83Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7jVnem35WII=:k8DUpfUjibMD7o5+PyRGdr
 TH7Io336Ww/n59+jH5D9qELldF2E9ZqiLmYGE6rZGWfGzpEzIM6aqlmlN2Mz5UwczmIrK1J0U
 Gul9197uFNa5uM+tKFZyCw1MeUqemuUgH9dcKE2+vnNRRBXoPCRCYGN25a6IyYZV6NFF00Qs5
 62FmIRBco+ybZhVHUmk0CGq1mFDw4sVR76yup+pQDdn0yFEAgvLv81ZQ7xtPmP4v1SCWrBRU4
 PMkxTPW1FbRo5FSWhB4/gQl0oHlF/JJ6d42N7CkaqfRbRWopM2ENoqJB5e0IIkvyrpxIar+O/
 ICgUVx/Xpir6N+5C6F78AtGJ6WiLFBDo1Gthhv8nbC+Az4UKQ0JGkf8nD5bYbTvP0fYkILeGS
 RkYPHo1fVq3uFg7iKJnvhXCtwJFMTFeLe4HkoErcVnO+5husM5DMBHnUrqVR8VevCJ2zTfK66
 aU3/qtE+q4uc5gvjx+2o3yJyXrf9+a8XGjiIhGQBkpj9xzNuLhUNItHxup0MEKYm8bWMe/wUS
 1QXKW5+I0gFjZ4wVMouiPYolJ7XdFYMp6TASPHkgS9fA8vR1NWjaK9Zx8Y1Ik/9mrmLNWkWG6
 r6EPjLDwnxxJk/dHzHxZ2pS9l23eMJItif9cCf2atsghE/nJeLqhGNCtU1IoWjmU/j0csZmz1
 5hX90+W5srWnrO8UPxcl0QkZQ0k2RPdzEYcSFMhBXoFbATWF6XRHg2awtXl2Jw/9eMIfjDZan
 AiF7XC2hH48KUUkAiyDOk4lBPMYbyJxRni6K8QlBT1RzdnLLebNlRfrE1jSY1UgL6RKf0NVV6
 yWi8XXeTtLkbB6fEV/GChM/GieBXi99sqVybn/3TH0J0ZLqd+WCJB8DyVTP17XzQz/kpc7Rpv
 b+yXs5+z3cvjJxB2ZbbRCM4EgvSZ9h+zAZGuky3lYIDi0kgfmOVpyRoO1gP+9NT7owrrZCUmv
 qCaLcT2bPLmr4NAWqIu/GuWsj8xnuHPqIAVktbaZWy+4CEOesXRgqX/4NxmNE06MYsZqtvgtp
 qy/RG0jxCxDEB7czG/O9CnCq+3BgTFS6mna5Nm4sWT2b6DnIQ/JfAURnPmW/LZ5/HTa7aLN6u
 shQz6iA1LcUDOlliUXW9Ie6BBRlYSKftjvV0qOKObT5z+diFL/njq7QcAB7R27FPAB5vwd4u5
 Tfggv7UBxT33x6Sr31m99v4v2KEpVpe1uNAdrzcWT4mBZEjD7d+BfvCK0EGpSYQRNKALMsY5b
 tSQp9GKNv4JPCSy0T
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EnsmqUjq4HeuPGFgxPfwRa6DkkDr1PKK6
Content-Type: multipart/mixed; boundary="3QhDObKEQbqPyrAHipLvdHz7hkdgt57Dw"

--3QhDObKEQbqPyrAHipLvdHz7hkdgt57Dw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/5 =E4=B8=8A=E5=8D=882:20, Josef Bacik wrote:
> On 2/3/20 7:37 PM, Qu Wenruo wrote:
>> Hi David,
>>
>> This is the reminder of how we could handle the behavior change of
>> staled qgroup auto removal.
>>
>> [PROBLEM]
>> If btrfs has dropped one subvolume, it will not delete the level 0
>> qgroup automatically, leaving the qgroup still hanging there, with all=

>> numbers set to 0.
>> This needs manual user interaction to delete all those staled qgroups.=

>>
>> [SOLUTIONS]
>> There are several way to solve it, all with its advantage and
>> disadvantage.
>>
>> - Auto remove them by default, and no way to keep the the staled qgrou=
ps
>> =C2=A0=C2=A0 Pro: Easy to implement (already submitted)
>> =C2=A0=C2=A0 Con: User has no choice to keep staled qgroups. But I cou=
ld argue that
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no one sane would want to k=
eep them anyway.
>=20
> This should have been what was done in the first place.=C2=A0 Nobody is=
 using
> qgroups right now anyway as they do not work, might as well do it the
> correct way now so when they are in use we don't have to worry about
> it.=C2=A0 Thanks,
>=20
> Josef
David, what's your idea?
Still want to push the enable ioctl way?

Thanks,
Qu


--3QhDObKEQbqPyrAHipLvdHz7hkdgt57Dw--

--EnsmqUjq4HeuPGFgxPfwRa6DkkDr1PKK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl46E7IACgkQwj2R86El
/qgLtwgArcBKSgCSJdKh2LFG6wFKbzwstEAZ/6iryS6A7qLd1UDxv4+Fg3aR/YGw
gHp5mTDk2Qdt0NXHEN5dEkhv2XS6s7VR0RhqGXq3gUUoQ52+StLuR1dk56KWEr+z
9IBueQfQk8/b3tzJIdq+nOoGdVpelbf/w/a8iM9ckQZ1j2QdoPF7BRIP1NoGb68z
aaVlD1WfEHtdNI+eHtlT9r6KEjLjXwjjxuA+923WlELd7WvhhcUlfAyCaQwtBQv3
SVqRdJ7wE6aS+hcX8pk5IREalzgHYpB+LSj8B+gk+lfuw9lVtZXGGTOwFDj4lw0t
hq8BHRtiD37YR4h4XaztniXAudJyyg==
=rF/z
-----END PGP SIGNATURE-----

--EnsmqUjq4HeuPGFgxPfwRa6DkkDr1PKK6--
