Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F5A5E63
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 02:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICAKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 20:10:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38985 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfICAKx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 20:10:53 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CA47222BD;
        Mon,  2 Sep 2019 20:10:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 Sep 2019 20:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=I7zyH8Jh9mXlAfo+zVKvOSneOx6
        1+YjAtihmgxuJbF8=; b=beq+SbCSUiZO90eYmfJ7K2jwt6TaGuZWrNxyct6DZ3p
        Vg5rQKxq6WsLzKkiBCxyuJFtFn58L2NrPCYcNiyRjlOLOUKhV09DHzP3Yf8tNJvN
        G6Id1yN0d1arycqP69EciPKECgazDU6A41Yg4RYCNp2iT2Eof0txDQKzKZ9injJO
        /K1v5vwK/GPYEdFOx+SKXa5TIAMYomI5tjG3hsSuQOqVmB/H92CVXVP1Nkjm5ZNK
        HICSx/q6x+ewZ4oQijy7Jnv4jlU1tPdabU37ct1tyEICD0PlLz1ZLRmD4fcj99YS
        xapWBloAkHQ4rBxnv/OnO8JIecWuXm4mHFVQ0ppz1Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=I7zyH8
        Jh9mXlAfo+zVKvOSneOx61+YjAtihmgxuJbF8=; b=HxvMLWd9Mj2PhaTGT2zied
        o+cHTk1t82PolC8oKUtRk7+DWdCD2kbTiiBrF/Bkhxg+5KZPes6/DAih3k5IL7NK
        FllUnIYGuyzod87CO+zPTdnVMgHCYv3Jx8kSSeSUL4DKx0l+/pBFGcX4h1jIEkdS
        nHJRPpqB/Pg3EwMk6avjt7pWl04jLk7+OpPhE5gUVcmxX9SqkSJK9GM2Ml3MFAC3
        QIT5pTkrjUhG97thJHQ1jSafP6EQNl1IlE5JrpgTeeG1DzILpgZUglMgOcB+3CkB
        P1FlD7xIQf4uWYfDLjM7uXE4ueULhfSL9SOu4cFRUumyDvr6k8y544B3P9E7P2uw
        ==
X-ME-Sender: <xms:i69tXbkr2eBwcedHoWM3YYqmc2W8Fy1McJJ7qrdcdKpuww85WMLz4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedufe
    ehrddvfedrvdegiedrudefudenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehg
    vghorhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:i69tXTHJcDc98aUWct95cdLIrqvCTpnPqlNbqHR_e69vf477yksQ0g>
    <xmx:i69tXcqcnqiD2f0jXAEJzFMjOMvE2SQ8IkJfT3S7vONQ9kQ4sJtT0w>
    <xmx:i69tXX5HnRH7GV3aiCYw1CfZiF2edXyGgVydxeOKg-cgSPGO1Ahj2Q>
    <xmx:jK9tXayniPglS2KyMJChKkapd4kgYQks-9tQFEFQVhAJmzficNTbmg>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 757088005C;
        Mon,  2 Sep 2019 20:10:51 -0400 (EDT)
Subject: Re: BTRFS state on kernel 5.2
To:     waxhead@dirtcellar.net,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
From:   Remi Gauvin <remi@georgianit.com>
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <704e10b8-b609-281c-07cd-51fcc6f78445@georgianit.com>
Date:   Mon, 2 Sep 2019 20:10:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vbIS0vOo0PTSxbmiOhEh3PslHzGygAAA8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vbIS0vOo0PTSxbmiOhEh3PslHzGygAAA8
Content-Type: multipart/mixed; boundary="WHC5MfCr2MN17aGJLURepUT8iorh9KXwP";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: waxhead@dirtcellar.net,
 Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Message-ID: <704e10b8-b609-281c-07cd-51fcc6f78445@georgianit.com>
Subject: Re: BTRFS state on kernel 5.2
References: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
In-Reply-To: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>

--WHC5MfCr2MN17aGJLURepUT8iorh9KXwP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-02 1:21 p.m., waxhead wrote:

> 5. DEVICE REPLACE: (Using_Btrfs_with_Multiple_Devices page)
> It is not clear what to do to recover from a device failure on BTRFS.
> If a device is partly working then you can run the replace functionalit=
y
> and hopefully you're good to go afterwards. Ok fine , if this however
> does not work or you have a completely failed device it is a different
> story. My understanding of it is:
> If not enough free space (or devices) is available to restore redundanc=
y
> you first need to add a new device, and then you need to A: first run
> metadata balance (to ensure that the filesystem structures is redundant=
)
> and then B: run a data balance to restore redundancy for your data.
> Is there any filters that can be applied to only restore chunks which
> are having a missing mirror / stripe member?

If you are adding a new device of same size or larger than the device
you are replacing, do  not do balances.. you can still just do a device
replace.  The only difference is, if the failed device is missing
entirely, you have to specify the device id of the missing device,
(rather than a /dev/sd?)


>=20
> 6. RAID56 (status page)
> The RAID56 have had the write hole problem for a long time now, but it
> is not well explained what the consequence of it is for data -
> especially if you have metadata stored in raid1/10.
> If you encounter a powerloss / kernel panic during write - what will
> actually happen?
> Will a fresh file simply be missing or corrupted (as in partly written)=
=2E
> If you overwrite/append to a existing file - what is the consequence
> then? will you end up with... A: The old data, B: Corrupted or zeroed
> data?! This is not made clear in the comment and it would be great if
> we, the BTRFS users would understand what the risk of hitting the write=

> hole actually is.

The Parity data from an interrupted write will be missing/corrupt.  This
will in turn affect old data, not just the data you were writing.  The
write hole will only be of consequence if you are reading the array
degraded, (ie, a drive is failed/missing, and though unlikely, would
also be a problem if you just happen to suddenly have a bad sector in
the same range of data as the corrupt parity).

If the corrupted data affects metadata, the consequences can be anything
from minor to completely unreadable filesystem.

If it affects data blocks, some files will be unreadable, but they can
simply be deleted/restored from backup.

As you noted, Metadata can be made Raid1, which will at least prevent
complete filesystem meltdown from write hole.  But until the patches
increase the number of devices in a Mirrored Raid, there is not way to
make the pool tolerant of 2 device failuers, so Raid 6 is mostly
useless..  (Arguably, Raid 6 data would be much more likely to recover
from an unreadable sector while recovering from a missing device.)

It's also important to understand that unlike most other (all other?)
raid implementations, BTRFS will not, by itself, fix parity when it
restarts after an unclean shutdown.  It's up to the administrator to run
a scrub manually..  Otherwise, parity errors will accumulate with each
unclean shutdown, and in turn, result in unrecoverable data if the array
is later degraded.

>=20
> 13. NODATACOW:
> As far as I can remember there was some issues regarding NOCOW
> files/directories on the mailing list a while ago. I can't find any
> issues related to nocow on the wiki (I might note have searched enough)=

> but I don't think they are fixed so maybe someone can verify that.
> And by the way ...are NOCOW files still not checksummed? If yes, are
> there plans to add that (it would be especially nice to know if a nocow=

> file is correct or not)
>

AFAIK, checksum and Nocow files is technically not possible, so no plans
exist to even try adding that functionality.   If you think about it,
any unclean filesystem stop while nocow data is being written would
result in inconsistent checksum, so it would self defeating.

As for the Nocow problems, it has to do with Mirrored Raid.  Without COW
or checksums, BTRFS has no method whatsoever of keeping Raid mirrored
data consistent.  In the case of unclean stop while data is being
written, the two copies will be different, and which data gets read at
any time is entirely up to the fates.  Not only will BTFS not
synchronize the mirrored copies by itself on next boot, it won't even
fix it in a scrub.

This behaviour, as you noted, is still undocumented after my little
outburst a few months back.  IMO, it's pretty bad.






--WHC5MfCr2MN17aGJLURepUT8iorh9KXwP--

--vbIS0vOo0PTSxbmiOhEh3PslHzGygAAA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdba+KAAoJEO9Tn/JHRWptKQIH/i9ZHWUSi2CTxPdIawIKGflZ
CgmArqmLim8ZtjifQFJcqP62r+fbElnI//h0vBktoQ47rIKytzQa6HI0MiH9evR8
/UbioJQpQSxYpKPoTtDOOF13M+bGIhvc0t04h1LhMCfspKZeA22GuPBeemx9q+yz
W6vshFTmdkX5sO61qTKS4mWIdnq5Xo0t4kRHt/Vgs+0mANMvkaVvnC6Z+JoQFAl9
jt/zgN8heze9pm1wLA9QWbI1sjAyn103GbeY29huVdtEA8vkA5fIHMnDALJKZDqU
w7Ge9frs2T+U5O87a3tynIE1ER3nrNjF3xAvjLsKvMgqBALKqnkAwATkQ1H8+Co=
=JBHv
-----END PGP SIGNATURE-----

--vbIS0vOo0PTSxbmiOhEh3PslHzGygAAA8--
