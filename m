Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C611C237B
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 08:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEBGEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 02:04:05 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60065 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbgEBGEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 02:04:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F0745C0233
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 02:04:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 02 May 2020 02:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=from:subject:to:references:message-id:date:mime-version
        :in-reply-to:content-type; s=fm2; bh=d0xNsz4gIcEHvGPTvT3Z6b+gSme
        yaHnGZ+VwimOUySc=; b=ekS3QRt7GxAwMqDKqT/xiiKfbGywCsVoQisSMNjwkxm
        OZeG6iTu1AmQsu9Xb2m2Ovl13QJDJ81YZZ7ZFJq7KCnVYIEy9Hypzk9E8qRs56jR
        ZHJRKTTqSDK+12cz56Y6ol0KO2MinHniBilRpjZ2xHUHfm+CLOty7Oxq6J/RDi+E
        Lz3T22TJmXnLkMwwb0C5Pd7e03IZGi6y9h2Fed2MQiJBD9L2NrCh7bVZEzcSKYLp
        BXLpCODt6749HYG6g4f/X9yf/5fYzRWMV/mQKARgL5CNAzuie11KIvSbbbufTWJT
        QzHrwUE029eAdXH9ANk13fVdoT+nhPoK4EdM6A9x89w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=d0xNsz
        4gIcEHvGPTvT3Z6b+gSmeyaHnGZ+VwimOUySc=; b=b2JxTMYg5eHqen2xXp3XCB
        K6sggh4zvz+ob4bzTCi+ag/A/MVtngjNd+M+jsb2oJOwVMDXOg7MAebySYne0mmT
        bQhXHRFMU+pyMsFxTprq9MmBoNoiwAggyCweZKkcZUsttXHSCDfKGFkbxjZrgfEy
        9MPF2iJP4F55XSatwoJQx6Q76um0sb/HeyZTT4pM9Qj4qm5AzHCCPoAPyhektwES
        yJ66S+BDVwgiItnSo3n1I1bK72f8CFwRHrRDcOJ4pp8EMmVlsRrt+gqthiItlUzN
        KQ+qMMrk8Z4YDQ2610yPHCl4OWhfABB0xxt/Gcwruf1bD4YNN1L2pTLNBeYyasTg
        ==
X-ME-Sender: <xms:Uw2tXojGzXamvNOfB7Z1BhEArqQNY9SAnGkxHLQPAs9ueFrN4O1L4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieekgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhuffvfhfkffgfgggjtgesghdtre
    fotdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeigfetjeejffdtueeuiedtuefhfe
    dtudehgfdvvdettdefhedtgeeutdetvdelfeenucfkphepudelvddrtddrvdefledrudef
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvg
    hmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:Uw2tXpZAuXDvwyZIxjnhEGYE8r3oaChf_puUCoSM40Oi1PNWDjF0eg>
    <xmx:Uw2tXqWJZq7nQC19Tg7ExSGnx2F_z191_46yi2RyOU4tSEe2ieViIg>
    <xmx:Uw2tXt3iTXN5vj1hT5pjUyhx7-RSWz6Wvsl7dkbQoxabYLg4RVCzcw>
    <xmx:Uw2tXpcPsfxpxNqGj6v-tkRQVGYojj0FqKRwau1lF50z970rldsDhA>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFC4F3065F89
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 02:04:02 -0400 (EDT)
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: Extremely slow device removals
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
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
Message-ID: <9f7fb923-50b2-a5ee-c0bf-f6d0bd14c5de@georgianit.com>
Date:   Sat, 2 May 2020 02:04:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0NRM22AOm6JFrCfgTdioE2r6bruFnBiHP"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0NRM22AOm6JFrCfgTdioE2r6bruFnBiHP
Content-Type: multipart/mixed; boundary="GKNo3xzNmoSAC6Qy3cU01vzLmn8ze0Yuc";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <9f7fb923-50b2-a5ee-c0bf-f6d0bd14c5de@georgianit.com>
Subject: Re: Extremely slow device removals
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
In-Reply-To: <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>

--GKNo3xzNmoSAC6Qy3cU01vzLmn8ze0Yuc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-05-02 1:25 a.m., Phil Karn wrote:
> I'm still not sure I understand what "balance" really does. I've run
> it quite a few times, with increasing percentage limits as
> recommended, but my drives never end up with equal amounts of data.
> Maybe that's because I've got an oddball configuration involving
> drives of two different sizes and (temporarily at least) an odd number
> of drives. It *sounds* like it ought to do what you describe, but what
> I read sounds more like an internal defragmentation operation on data
> and metadata storage areas. Is it both?

BTRFS tries to balance the free space, not the Used space.  When the
drives are balanced, the Unallocated space across the drives should be
even.



--GKNo3xzNmoSAC6Qy3cU01vzLmn8ze0Yuc--

--0NRM22AOm6JFrCfgTdioE2r6bruFnBiHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJerQ1SAAoJEO9Tn/JHRWptCOAH/jKGP1NX+pR1+5Hk/xYDnIL5
+NTP+OEL65dqnU23c09yob/l2xzbdj8S9Ck/oQNCFhPWWAwdCnXnn6nlt4TgDR4D
r6oBl0LtMAOr4z4DCwZBEUe93sMskNXxASEYeeqkJXXNWHOFF+/HgRVcd06zZaT5
lxetQFx2SDUzVOTlcMXlUeNKyq2BGjxwJ3duebAgYiAzPldwzt9i0GSG9WL97LHn
m9cQLu0pE2kwOM0U6EQYnD3VioFJ1Q1iokqrnKW0EagkYRfXBroopdGxVEV378iX
lWFKDGYW0Q/gSw8FHP5lJ8+QoC/ps97JwH+WfD1kuw7PgmvE1xQNlnGlHCoUW38=
=jv2W
-----END PGP SIGNATURE-----

--0NRM22AOm6JFrCfgTdioE2r6bruFnBiHP--
