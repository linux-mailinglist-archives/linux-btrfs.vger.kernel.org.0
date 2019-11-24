Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94E710813F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2019 01:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKXAi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Nov 2019 19:38:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:50505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfKXAi7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Nov 2019 19:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574555937;
        bh=wGgWIhVVFwe6SYbE+OyJyTllD9xJr8HEgIx9BJa0+io=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VYrFsNeMCs3MnZ3kJbukqbqAIVzFb4W3TAt9fbtBTjxBjvtHSbOiUg5aA0j6SAhzP
         gf18QmaNWTHd5BlSqGax6xKe7gikRmceW4jsPqWbH8/zO5c3WOdBIJhjUDcvANGZTm
         hh4UJphLpQK9ECHCVVe0P6JXFgHJo4sNqhTz3/84=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mq2nA-1i4JFa16hu-00nDjn; Sun, 24
 Nov 2019 01:38:56 +0100
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
 <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
 <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com>
 <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
 <d362cbc6-2138-2efc-00d2-729549a03886@gmx.com>
 <CAKbQEqG362x12PyDUjiz96kGn15xZY_PRdAknS60kKvDDkKktw@mail.gmail.com>
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
Message-ID: <75349379-56b2-7381-4201-dbf53e7a111b@gmx.com>
Date:   Sun, 24 Nov 2019 08:38:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqG362x12PyDUjiz96kGn15xZY_PRdAknS60kKvDDkKktw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vNlXImukQ3SRBqLCIaa61j7GzSVieDdo8"
X-Provags-ID: V03:K1:JguHrv+GrrbX9I4eSHaQ0aEMwsodLMTXVXAwS2H0xJV82hyiDwT
 9oVktAb3ntFmYnt7yKCbQhiCOsRj6qTzxra/8k4DcN3t33I7SY99Dhfat2tW6kdRP4UseNK
 ysnQT6BJcIM8hGRk4vkCZSPeCER3ksbPTmzZFB9QYAeE5dVCMTdHDK1ZzLTWTU0kDEqCr7B
 4/HdlzsF/1jBppTTdlB6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JurkU8NYp80=:cwq8MIcKSHJDvv0r8iJ7Hc
 u9PSAwvENBXbkx3xYWTJ1Om+gN9GQHkUOojG8N7WQ5K6fU/LHy59ESdVPawwzaF3MW82HqFaH
 YTfb/+cShkEdUCD7/hAwKUW/8bunPEThBG3rdLqbuvhsN08TiyhvHpX+5bvBvRTOZfo1IpUpk
 e1qmik6SmkXLtKWp09H42qGOWubkzcyQCWJ8D+wlb6zcj38sWgHe+cYyLKDPoC+VgspKzuSgo
 Gs+esYXGZb/iFzvfqPhFXOiF3dR4xaov3NC1OiGtlYcJf3kjKoC+QxE1SqeUIoZnyVTXRkaXQ
 8E9gWJoFr7cQexVe4Pc0LxR1A2VVkdBdWq4CQB2U5uLMZaQ2hmtYIhfXzA+tNuFJuZKPTC7Ga
 hMELnrlBPI9ZJlB8bJjsY/GLXtogatz+UXiEWBLoxWbd66jbVpUMXiDLCIUpAUj6I2K9F83P/
 ImTiaADhRVNsQTZNJzt4sJpKZRjKLQLH5QQzScsit2iwaKx7cmL5pqqOe7g0JE0qjCoiZbM7z
 TghWFTd8jAKTsrjYwqluSruAWUQvX6AF/Rqw5x3qtNuJ9GAsH8xb5Jn54fyc66vveVbNi0q1n
 XTLr8StRp1PmG9pJB1ExiHBJBxld11oVeYurDDMcdoHH1xAFByWRQ4q9QMbVzc+TnjojSYdj4
 0no8ESVOJlD3g+Qx2liO+kvYI9zYmdMLcy/tBnZE3Gk/Xd8mBCeX0CNveDD7ND7+vOl+K5YMW
 elqaBTDD+LtycbESQBjSpEStEcYtMt15z4R85CrZOTF+3SJ8YHQbdDUwgyKcCxx/AcGbi+diG
 Sy0V1Zbpemi30SIoTd1xUHT24owXxmTXnw+sHZsyaSoFZyCfOrTVuJuJ1uJW+JSz7SJZ+NIKw
 X1XuQz1kjfS8bxUUs/J2Rrt1NC9HMmZcejrUct4DIz2oILiCDCKAVOgW8kmF0isGLpC7dsCVO
 TnIEZTAbXE20fcr5jb0OFjVIWTRrVxz823tnhZvqtFWTjArmqsCTrY3oGX4W7zuQrY01UWXTm
 /bagvekXoOIUQfsidlxva5AIIdIshgAtd+O+BdrFGakMa4HVuGaNFytbOtVdNKWwy54QUUjyW
 +xmlpTNJf0KnX78LE9PGPMa79HboIuyk68zEraWuOBEIZxOKDWA4mlkd8Neh8VGK/bmRH4EbD
 sZu4oYCcf/JRuHfPQfH8ejCswFK32cBfm2WZ5ieas9+H5VMVF0u6sernjY4B3bfvIR7zCB1FT
 TC8ZLwRqH/4tPEmRwY/TM25WF4JLTPPMbbSu9W6KxBc9s+cBsuRXGEp/y3zM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vNlXImukQ3SRBqLCIaa61j7GzSVieDdo8
Content-Type: multipart/mixed; boundary="eLXhRd4ZsxOgL56n0BjhMCBf8HkdI3ixA"

--eLXhRd4ZsxOgL56n0BjhMCBf8HkdI3ixA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/22 =E4=B8=8B=E5=8D=8810:43, Christian Pernegger wrote:
> Am Fr., 22. Nov. 2019 um 13:34 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> But still, for snapshot deletion part, there is still a performance im=
pact.
>=20
> Ok. It's just that I'd have expected *slower* write and read
> performance until everything's settled, maybe sync writes taking
> noticeably longer than usual, not that all user input blocks across
> the whole system regardless of fs activity.

The slowdown happens in commit transaction, and with commit transaction,
a lot of operation is blocked until current transaction is committed.

That's why it blocks everything.

We had tried our best to reduce the impact, but deletion is still a big
problem, as it can cause tons of extents to change their owner, thus
cause the problem.


In short, unless you really need to know how many bytes each snapshots
really takes, then disable qgroup.

And BTW, for "many" subvolumes/snapshots, I guess we mean 20.
200 is already prone to cause problem, not only qgroups, but also send.

So it's also recommended to reduce the number of snapshots.

Thanks,
Qu
>=20
> Cheers,
> C.
>=20


--eLXhRd4ZsxOgL56n0BjhMCBf8HkdI3ixA--

--vNlXImukQ3SRBqLCIaa61j7GzSVieDdo8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Z0R0ACgkQwj2R86El
/qhtNAf3TKyfmNwGzy9bHVrrJ24Z/6+az2AVpDSWqtf9UkBjcyoJKRejKvyGImWD
pC1jNDlSg9TrEssXP1Ehgu+bnq1KAv/SeWICIKN2oPSr2PNgxi8POlUZstSwO63w
Kzfo1pJqLFlKiO7sspL0t0TEPo8p+jcc2tiY366cJD2O1RMzQGUAJBD/0/HMQ5Rs
3UcJ9hkDM2qc2WoIsdpC0j1OHa4eLJvSCU/7fD/ejGitAjn5wB0XijCJb+je/gj7
ZF+kAG32GOos3gJMPAxRC6F52lSqiIqtfsRJa775jtUuXfs0QH98Pi445FEsBneO
D3ekUyuKEv9WCbtFTlu0xJv46hg2
=a+MB
-----END PGP SIGNATURE-----

--vNlXImukQ3SRBqLCIaa61j7GzSVieDdo8--
