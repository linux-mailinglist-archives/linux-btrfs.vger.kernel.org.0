Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274F81C4A8E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgEDXs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:48:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:53495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgEDXsZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588636101;
        bh=Fkwd9i7p4OJTBVNF/9JoBbvPv5a0gusCm4YCNVkfwkI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OoaoADXiXMks2spUjhgZK50fPTcWiQe60ymq4yaSOH7SgIHlXWmob/GsPy9AC/MIf
         k8fu6eESX9FiM+0kxqblKUsrJnmbIpTlio3GvKs9kGmC8H3iZgJI+StL1UQkrmhvh4
         QHirXTWUvNJ8B6wG9o4uXXxdJ0UsqOs+bE5qk5hY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzQg6-1j9hfI1ls8-00vQnJ; Tue, 05
 May 2020 01:48:21 +0200
Subject: Re: Balance loops: what we know so far
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
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
Message-ID: <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com>
Date:   Tue, 5 May 2020 07:48:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7dilOQVQ3I6BmnXtqtQCRn1X5QH9VjZiX"
X-Provags-ID: V03:K1:J6SfDGcA0E5DHZbovn3VGaBM5iQUQLEL9bVbufeGbk9EKK/Wfeh
 do3s/0Vt8iXKbU2V5sGPIyc3zGMZDum65XpateBxNWv3wlZY9tRojH6fYtdIhskUaxErgWV
 /h6/gL/ZVwmrz+/i1YROsewGEtwWHrs6GRpyKqKRFjI3IWQ0Xap3b5J6eYdx6JjIGWwvBHL
 /8r9M8vs/9ODAVGo5PrHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mexJTtrIR+w=:HuwIc47eXl8hVAfT4ZM07s
 4WmGbU0KG3R7dxTuphLSp7yWVH7iYi+J+khvpPOnmz9YRbqh9fJmiQXXm9NZQV8ifatHi5DEK
 dAxi75wyvYDsIswOydmaKAKz6yeZ9iSxlzxqRvEVCYAmkLWwHFlVceE/W5iCjadlSaUC4cFan
 nITUNG7ypnwaBQGrky6DCKYSYS9D7XTGIPGrcsQ5tDN88eBzGXYjy166A0BboVJFOYu+7yfbC
 xWUTzKhuUjz7So1WHPliJXNZwDvammWnKZz5ChRIh8hq13trYDWLbnsKwW5kzLL57JgiXfjUE
 lW7nX/U1yRljVEQM7GpxzKDwj8CUSyFE+xA32spdxAr4m2QB+/qqA60lTL59P2/02s/bvNlpY
 j+SXxExLX979EUs0Qmd88Q/jp5XVlMmpjEYhdCL8qlsOzrjiNS0ZdI11CrELAtIBfOPZ+ADCE
 3RjjA7mIhYu48jvd8awIWUhK/r6p/AIZC6d7Q3oX8qYp5MX9cR/XucljFI04og1erG6wikcjX
 9rgNQlt1h+BnffsOjjz19T8rVwCIebrwEIZqrSJMq8/h782lY7l3xpUgJ4s47MLUctGUeM36E
 ZxULCbLoigum3EQa9jhd5yoa83btf+AySPnzGjrVRZ1C9STzfvb686WP1rbLV6jrckaG6FsSc
 EXj5/RVYOUYMFt4p2ax9fLVv+tabyPsYb9LfE7vYhLjWNfeG/HkDq/1yEOw3UrAUfbYQhlhNU
 fwGwrJU1ZhGmSOUJcQjwKEGyWwVSwZrGgl3/ov+p3/yGXtaF0vw4NZlEYLngUVU+CC0USCwq6
 YwOKORedvF+H2MmP9/EbfJMe8uniSAifUENeN0/NusWrvYiZoBUerr3De8AN+jwtpGTx4j8Vp
 UZQ1hBf0NfIPbPp4LcWACPXdfc3T6SFbq4V+PoolauZBVUab91qTrf/dhxiMW++HuH/RnBBMH
 ed4L5dH53CEqkkQ/eXo4J5mT6bkSkGIuLdoQiHqxbsH7r76N84Oq3PnXsYzgHG9gnsAr6O3ty
 1+8i8xp9Wgd3yjXHNb6d8QXsZJNLClT8JWynb7biQjhKMMvjabHJyl8dvCJnNpYBSVA9HkFxB
 nboOj/Z7J/Dc7miILuSh0OT0NdMbtw6GM9K362lqP6XS3OUpNMheJ3rpkF2macsJme/IyA8Zf
 DRA8alXOlx/4/bBw7ByL9RVNmSQ2BwZ8dl1+Aq3ndWSdc7Ma2eLGh8pUzrBH08bC2pcANTzv2
 BvFwo3Y3KzaWQj1af
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dilOQVQ3I6BmnXtqtQCRn1X5QH9VjZiX
Content-Type: multipart/mixed; boundary="bUKffpsDhSMntmjBUI97dBfjRPTdyAZVd"

--bUKffpsDhSMntmjBUI97dBfjRPTdyAZVd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8A=E5=8D=882:54, Andrea Gelmini wrote:
> Il giorno mar 28 apr 2020 alle ore 12:00 Qu Wenruo
> <quwenruo.btrfs@gmx.com> ha scritto:
>=20
>>
>> Would you please take an image dump of the fs when runaway balance hap=
pened?
>>
>> Both metadata and data block group loop would greatly help.
>=20
> Hi Qu, and thanks a lot for your work.
>=20
> I have a VirtualBox machine (in save-state) with the problem running.
>=20
> So, I can send it to you, if you are comfortable with VirtulBox, or we
> can work together on my machine.

I mean, btrfs-image dump of the umounted fs.
(btrfs-image can compress the metadata, and won't include data, thus it
can be way smaller than the image)

>=20
> Short story:
> a) system running is live CD ubuntu 20.04 with kernel 5.4.0-21
> b) partition of 10 giga (not /) mounted;
> c) shrinked to 4 giga;
> d) then removed files and left just 59 mega of data;
> e) started balance -m (not -d), then it loops forever (or, at least, I
> left it running for hours, guess it should be enough).

At this stage, the image should be pretty small.
You can try restart the system and boot into liveCD and dump the image.

It won't matter that much even you can't reproduce the loop after
restart, the point is to find out what's preventing the metadata balance
to continue. So the image-dump should be good enough.

Thanks,
Qu

>=20
> If I reset it, at restart no more loop.
>=20
> Thanks again,
> Gelma
>=20


--bUKffpsDhSMntmjBUI97dBfjRPTdyAZVd--

--7dilOQVQ3I6BmnXtqtQCRn1X5QH9VjZiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6wqcEACgkQwj2R86El
/qiZeAgApqkM7ONNqpwZuUoACBlYnF99QQ/OFg4Gx0VMz5xF7gEEKFAKvKSmowtr
19BDos8KswcwtBVNmvFoszn5xpdUGmdWeb9fTM+p4TRgBWuh1jWvT57nNzMcyp2R
7jOfGNKSfptdIZ6AgYfCaZ+GjqnWZLOZo23pKCHaEZvjxC6//hdmskKoUIaS6NtN
3YO/QKf88SY6bgtd8GSSMiYh/F7j8y9hWzphc1rBHKXyK/DiSV+30k7xN4NeYfgR
qvUI+fget/DySPKMH0iAQ88J53rY2sp6q+uKDJGU9gIRq5YFX5q4Nk/O2o6S65jS
E40lnKIvTRUoLAuHhmOyXscIrCPnwg==
=peGQ
-----END PGP SIGNATURE-----

--7dilOQVQ3I6BmnXtqtQCRn1X5QH9VjZiX--
