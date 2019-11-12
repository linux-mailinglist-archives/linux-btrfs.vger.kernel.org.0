Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5CF997C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 20:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLTOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 14:14:52 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:41795 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfKLTOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 14:14:51 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D1953611
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 14:14:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Nov 2019 14:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=mIxzm805lttYO2ZKyjmlJjL15sM
        a6ooOMWsRxwolpMw=; b=K1xdhPSDKfSO8SO1PMfGyjI8Eu6rnPvNDz9P6n0Jhmu
        FC2h5T9d1wl3wIDMiuqEiHjdmb4ynP8/QHPoVraUqLTYgkUe2i1x/i9eQ1M9iCEV
        AfaN2GyeZxCwVb3hVfKbxQaPiq47jYHeceK8n+VeSpBHfYKlxXlcDanfk8pD1g8n
        6VKiL0X4F0zlki1IKKIhEUQv5oou6WNjK60eDghBOEwDECvLaLjwzQHcRhZhyeol
        khujW+c1499wKgXozqAjZ4WJtSoB6wNSF4aihRZCdg/yfuv3yaUeqfAepng099zc
        ELq7E5iOWnQ61/BejVXQhiH3knKpG/hQfdzGScSzbSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mIxzm8
        05lttYO2ZKyjmlJjL15sMa6ooOMWsRxwolpMw=; b=feU99nqRRYcqKexOxTOvy7
        5nvDeNTH7UhIJEJ//CQmP4WuZU2qatAzDKaYN4PnvxeketAI/aSwFrohvBmK7i2H
        WaAeXDMPK6kwCamYO57oazsdIrfs1iNWaJvK0muMpm4PJCxtoKotGgagHw1vv5Ol
        bvqxKwUxaF9B/bWi1ZtzFRKcKMJ4htDpiLrGIycMpi/CMLVQKOtZVDZSpZo5twYX
        JKHpThH9clMoJLxM+s+qehf7P2ZJtxqiTY0jAued1hbFpzpz0zidMZUSduF6EnZx
        zNy3T3on4uP1bwjyRodB5Njqmoh3CxAMuLVfza0owEyx9B3O0GkdrFeGS2KUNqCA
        ==
X-ME-Sender: <xms:qgTLXRHqM_lEj5Oj2FrUSAOUnaUvPUXPcoI-ypiYCJYCJzZN4yw59A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvledguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtd
    erofdtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:qgTLXZ3U06t4WORO33EgWTt9_2GOnZJq7fLE1FM0csFZ-RHwDEESZg>
    <xmx:qgTLXbo7BGcCYMkV0j5kfQylobbCjx-d94Q1IBFskZwT0UvaGAn9AQ>
    <xmx:qgTLXZ4m6dPcqsSv9DrU8DLiRTV9GfOW9l_3K6NWlVycSSknmSZR_w>
    <xmx:qgTLXcSqFvFQoPpIlCW-bRPO6-DTT8hHnb7ZBjlgcbNHYw_iYs4S_g>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C25180066
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 14:14:50 -0500 (EST)
Subject: Re: btrfs based backup?
To:     linux-btrfs@vger.kernel.org
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
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
Message-ID: <6df82661-81c5-e0aa-57ab-91f0e069b475@georgianit.com>
Date:   Tue, 12 Nov 2019 14:14:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I8fcSSLrWSYo0osstmXq2i5twMKBUeOZp"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I8fcSSLrWSYo0osstmXq2i5twMKBUeOZp
Content-Type: multipart/mixed; boundary="nfpF7pjZB47HKdc25McDIdzPJMje4PJPu";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: linux-btrfs@vger.kernel.org
Message-ID: <6df82661-81c5-e0aa-57ab-91f0e069b475@georgianit.com>
Subject: Re: btrfs based backup?
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>

--nfpF7pjZB47HKdc25McDIdzPJMje4PJPu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-11-12 1:34 p.m., Ulli Horlacher wrote:

> Set up a backup server with btrfs storage (with compress mount option),=

> the clients do their backup with rsync over nfs.
>=20
> For versioning I make btrfs snapshots.
>=20

My KISS script to do exactly this looks like so:
(Permissions on the backup are handled by default ACL's on the receiving
end.)

/usr/bin/rsync \
	-a --no-o --no-g --no-p --chmod=3Dugo=3DrwX --info=3DSTATS \
	--inplace --exclude=3D'.snapshots' --delete \
	/nas/  \
	backup.server:/backups/server/nas/ \
    || exit 1

/usr/bin/ssh backup.server \
  "/bin/btrfs file defrag -r -t 32M /backups/server"


/usr/bin/ssh backup.server \
  "snapper -c server create -c number" \
  || exit 1


--nfpF7pjZB47HKdc25McDIdzPJMje4PJPu--

--I8fcSSLrWSYo0osstmXq2i5twMKBUeOZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdywSpAAoJEO9Tn/JHRWptYrcH/21qn0A2cI/SyZl6RUKRT+kq
AvHs9IzW+gbECtvLM56uspkiMWzqqhlIQjpnEgiZLaLY2o5zsAIfi2WnplFHgyBO
zERG6C38PAAtQE2x1AeeegNN/9CPekN9un+x9TpxukKPrGFzf3iFFNSakMh+nFnv
Qc8s2gd0a7PpygfUT1bT+QLfh7btCzGhi/uOVH1w8kQcr+qOH31lWewwuDegQ6B0
ajsYJlke3Y5RxRgkVQrTugq2G3gNDWn1vvFqamOtOx+DaQO3kSfdcDDsIRa5zAMD
x0BQC/ybV8NRrMhtoXu8Uu3Mu7FxbQN4Y/GNn2IyiF+9RdOacYLfQY4epQG36p8=
=RQRo
-----END PGP SIGNATURE-----

--I8fcSSLrWSYo0osstmXq2i5twMKBUeOZp--
