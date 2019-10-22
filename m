Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200BCE03D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbfJVM2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:28:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:47843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388383AbfJVM2I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571747280;
        bh=D5CpRNCJJfoQrbK+LMyegMnVU1/PuOkk2gMRVK/jrEs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eVRVbSNOztNYB10iUHSpXDO4Ga7uqp+9hB9+n6TzUdQ6PiDkCI862KfMT/n5d3EUn
         dZfCjrP6+N70MoeNTlMMrn883rDcjGXBgcryRjK/myoSJ/DIktRGVpgjmdaQqKDL90
         6SQa2bc50+UMJqhmZ8BMi/yeV6UmNFJtg1hZsgUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1hqYiu2Xjz-00fiid; Tue, 22
 Oct 2019 14:28:00 +0200
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
 <20191018172745.GD3001@twin.jikos.cz>
 <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
 <20191021154404.GP3001@twin.jikos.cz>
 <07b33628-2cec-7bd3-26a1-e3be2367774a@gmx.com>
 <7435bf0f-ffbc-6723-4383-d780522d5af8@gmx.com>
 <20191022122348.GV3001@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bba76399-6b60-b3fb-afdd-74b8561dec1c@gmx.com>
Date:   Tue, 22 Oct 2019 20:27:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022122348.GV3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iJmJp3q0HYjiIXtxzF8PPuUyVb8MrViIT"
X-Provags-ID: V03:K1:QBS0eZriH1AVl3fJhfCfk7AknIlcCAcTos7IaX5OjoORhSHiOxl
 6GS1CXmhjrtgyIkbIadDbJvJzm4U/qagIxluOSzwBhMwnWCHYTqlEXvzWZ8rZz3iXEtK+Pn
 PMXuEpGH50AGjI/AnijvCtPBsTleG0lCjMvT/tbLYVJn+lTp7VOQSJGGoiEd59GPinzgNKt
 LfTuU0zoOpjyA7fL1tcFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJJYpR7ABUA=:kHnDNsKQNUh9MuUhQYMBTX
 xpsemIgQ/4wjv0T6Y5U7360hfDx/9nwm1zlzss7TDUdNlxQxq+YjZ6AjYC70yZGsYxnF19fDO
 2zxUc/w3H9hTTNvtdWFMQyko64U0Eq14BD/V6J0uAyzRz31BgrDMr+aq/A73ijV822A15C24c
 Yq+HRHD0qQgWwWVHdi1BfVqN9O8HMVyuEqi6TqfH4JPU6P5LPSELuF2VhExN5U+lmVDBQZh+m
 AsCCTV5M9FLGaMRQzyZMSewllqaCldc9Z8hPv5vG+oZ+8jtES94/pO1vJ6TkzlJytl1ZKqg4U
 UguviIHQlq3ifT6qq2KtdJOBGxUoB/429Umny2knoNECzgRECL0tlP5pLLo08EYPoBmYT1jTr
 43oS0ZjWZWvMJOPKlkTQl00/hpKusGFNE9hliK/0n5Fl/um+WMWwKI93hD1FyUEgvqlHiE8Kj
 r3FlGSys6VK3r80rsAo27DM3VxPEiZwPcLL6BHfaooC3+Gry4450SnDO82StFg9fb8lsXSNpE
 v6DML81IGCGTcesK6JJjNy2ZTSA3YEDzkqdEW5bqNpsVYEFSPeUyEs29mFji41UMK/IX9jFfV
 6+Rj4XH96uuuDYgUW2+hbDH4g49InYzLBZ4+Lu+7WIhQGqPsWvt8QNzrTWzDHUewirYX4old9
 8v+MqJEQEW+YS6J2Hra8BuJy5UntM+pYwY3/Gh88ZbpsIObSGaF3yHX6eIA0Jy2yqhvjRRAez
 gX9aFrmR5+clx7s6zegB50qxjhUsaZJjlAlBtBKfWViZKJa4nq0JlMZ1yVzeu4DO13YRIRzCR
 7cVtRFkupZf13Qw8iRmunqwNgPOX6T5s/EKd8m9O3EbSe4f7rojx0uhyInkdmd/M241CGtXg8
 /kilPuDzWJabb4+V4Wb7nncixSp6zm2OpezFBJAVzYPuS2Prgh0nuk8zngtuDMP/Yl5tJTlgE
 Zhf3NNB4jLOVK13xpNiTr0GKXcZ0zGbRUlsZozUAvAytF8BJcnM5OjaSQr/Oa7WxcFhU+nQ2p
 zQRyOcaLVhMvcmIUNx5DkRYICiEp63BlINoW1gJ5+tm9Ma/RayFqxzYKwDJb4FZADd6ZlIJJU
 Gu95RtSR7jR/3na05o5QrKmBAiPGqjJXLAQnqp58QKw9JIH9P4XbKwaNVKRCbfIM/CUW7ILH8
 lxn7INRofu9GQxfJfUR28dIkZBsG7tfh7wt57obSUPMVJxmuj+/CyCV0KhmNITce7lXoh/PMB
 3tvRs790m4fueQprTW/8p+gBLFi88v2whHzoWaFOA2z0FRAUWq6NtK8o3f6w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iJmJp3q0HYjiIXtxzF8PPuUyVb8MrViIT
Content-Type: multipart/mixed; boundary="h4rxHWa8NVypywjFqWUOf4DijARHRUbM4"

--h4rxHWa8NVypywjFqWUOf4DijARHRUbM4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/22 =E4=B8=8B=E5=8D=888:23, David Sterba wrote:
> On Tue, Oct 22, 2019 at 02:30:22PM +0800, Qu Wenruo wrote:
>> BTW, there is one important compatibility problem related to all the B=
GI
>> related features.
>>
>> Although I'm putting the BG_TREE feature as incompatible feature, but =
in
>> theory, it should be RO compatible.
>=20
> It could be RO compatible yes.
>=20
>> As except extent/bg tree, we *should* read the fs without any problem.=

>>
>> But the problem is, current btrfs mount (including btrfs-check) still
>> need to go through the block group item search, even for permanent RO =
mount.
>>
>> This get my rescue mount option patchset to be involved.
>> If we have such skip_bg feature earlier, we can completely afford to
>> make all these potential features as RO compatible.
>>
>>
>> Now my question is,  should we put this feature still as incompatible
>> feature?
>=20
> In some way it would probably have to be incompat, either full or RO. A=
s
> unknown tree items are ignored, if the rest of the filesystem provides
> enough information to access the data, then incompat RO sounds like the=

> best option. And that's probably independent of how exactly the new BGI=

> is done.
>=20
But the problem is, older fs can't mount it at all, no matter RO or RW.

It's now completely dependent on how older kernel handles missing block
group items.

If current kernel has something like skip_bg or fall back to RO +
skip_bg by default, then it's really RO compatible.
But we all know how picky current btrfs is about missing block group
items...

So, I guess we will have a RO compatible feature that can't really be
mounted RO by older kernel at last?

Thanks,
Qu


--h4rxHWa8NVypywjFqWUOf4DijARHRUbM4--

--iJmJp3q0HYjiIXtxzF8PPuUyVb8MrViIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2u9ckXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhdcQf/cV61Dv7fAE6YL1EqzwFBljV4
M0Wbwtt2YWaibkdkaCG2ugR+I3TywIaPHKdncprzTcu3Zx6OiLMhbDpQgIfKLGIM
tV3ll24hScn1HcAeRBsSKDh6LaMgHPrZJfboxQHh6lAsjangVhdlxA32t0E/xZtM
EfqZ0C/bBshE4ts8zEdR0Tkc95zArkbLtwI3FE91aUOlCByOImTEjGTjkQBLTfCA
gYowsl9QrG7FyRjNICkco15NfnFdchih5i8ioMT0V4SDwO0vX9tcrQmcHIYGeb6S
/b6OVP70tukfb2kK34abcczQ1W+dEiMRU2iMAsd8WSMGmokrb+Fnz3+FNJf5zg==
=eHB9
-----END PGP SIGNATURE-----

--iJmJp3q0HYjiIXtxzF8PPuUyVb8MrViIT--
