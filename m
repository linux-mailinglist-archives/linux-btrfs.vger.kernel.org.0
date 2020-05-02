Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDE1C27D8
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgEBStr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 14:49:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55469 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgEBStq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 14:49:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 17BF35C021A;
        Sat,  2 May 2020 14:49:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 02 May 2020 14:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm2; bh=dm/eLBOIjHUYeFVJBfL3Mo/0hF1
        kZnpxHqEnonq6Szc=; b=pBTAulfZxTd75PyW2CSUvTDLLYtaitplgP+2sdCZafB
        bImEe+NrHnfpWvseWyKkPuruVOcLV88zeuSI4j2aP5CmKIkKZU5I1qSWT60S/8gm
        ecC9ITI0/15sT50+DxM19p1E8JJqDmP7uGJyAgMwWpsvFYsMRD0x2vychF9z6BMK
        srzharXKcFR2dUTvWuDO+LSPHdR55r2wYEFMoVLHVyZGgObRaC7JA+qILua9UBO6
        Nse/DB+YLPokuWJBhquRoGMCWIydyG5iYPNigWo90B7gVECDr9e+220iDrMOCSjX
        rxgVc/vGrhkIaWLimf4q12gzd0hgTTzvsGJB7apQw8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dm/eLB
        OIjHUYeFVJBfL3Mo/0hF1kZnpxHqEnonq6Szc=; b=lRBAvkwxNTZfH+xLNxbIGL
        jGgkDGXZzE5tn+Ggo8NI8GC+JXCy0yq/M3q8R1/qDh+9UlIjSMj/csROPq2vAYqT
        W5GNJoN+G2gMW9hWhAQo2SeKSN7uIT/EZzWpIu/WLwhd6DhaOD6inK9rOw3qB6yG
        oGIVPXCxEIYcBbWtpaw44+h3LUlS6OSgZbCBMzT18KTv974FMzPDjrxPPFjo3k7z
        /aF2tBuHr/sSoDWnNHPwXejLoA5k0MvQ2r65Rp/uYCHLOG7UMOy7ZXZCCNza21q6
        CoiCvIx+jaziAjTtJ+fQUDSRxFPTkInpFq4CSwvm1ZHD/3eNxnG/Zbi2PfFAeBOg
        ==
X-ME-Sender: <xms:yMCtXh1oauj1-ovXe_oGfffWOttpK6yih9WoL8T0EjNk2DuojECPeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieelgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgesghdtre
    fotdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegfedvgeetudefuddvleetvdelvd
    evgfeljedvtedtueefueefiedvledugfeijeenucfkphepudelvddrtddrvdefledrudef
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvg
    hmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:yMCtXrambQT33EGj8cpKgkxnFm3n8dn4De-Ii0g-Itw0oUbRKn1tKQ>
    <xmx:yMCtXttt0eCPUd-TPBdZPlCiKLzKSa971fI4vnxYxpakLlRFTi-5OQ>
    <xmx:yMCtXiAy-h_eyGeGlRqpJcm21MrlWS_oVfKxiF4AB0ETDgSPVmshPQ>
    <xmx:ycCtXp3nA1dqs90rMFiiqPWIp36yZ-oEgPq3pwicMYLBGNgQYWn6Kw>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 759723065FB0;
        Sat,  2 May 2020 14:49:44 -0400 (EDT)
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org> <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org> <20200501015520.GA8491@schmorp.de>
 <20200501033720.GF10769@hungrycats.org> <20200502182316.GD1069@schmorp.de>
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
Message-ID: <ccc7bf7f-9ef1-c1fa-c1c1-12497f272715@georgianit.com>
Date:   Sat, 2 May 2020 14:49:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20200502182316.GD1069@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="92csbYjyUy2KOMWEvj2FVQJEvtB8EnzcT"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--92csbYjyUy2KOMWEvj2FVQJEvtB8EnzcT
Content-Type: multipart/mixed; boundary="vpeX83ptR3umr7qJxi3psLWzGj9SAbv7r";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <ccc7bf7f-9ef1-c1fa-c1c1-12497f272715@georgianit.com>
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org> <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org> <20200501015520.GA8491@schmorp.de>
 <20200501033720.GF10769@hungrycats.org> <20200502182316.GD1069@schmorp.de>
In-Reply-To: <20200502182316.GD1069@schmorp.de>

--vpeX83ptR3umr7qJxi3psLWzGj9SAbv7r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-05-02 2:23 p.m., Marc Lehmann wrote:

>=20
> That's interesting - last time I used pvmove on a source with read erro=
rs,
> it didn't move that (that was a hwile ago, most of my volumes nowadays =
are
> raid5'ed and don't suffer from read errors).
>=20
> More importantly, however, if your source drive fails, pvmove will *not=
*
> end up with skipping all the rest of the transfer and finish successful=
ly
> (as btrfs did in the case we discuss), resulting in very massive data
> loss, simply because it cannot commit the new state.
>=20
> No matter what other tool you look at, none behave as btrfs does
> currently. Actual behaviour difers widely in detail, of course, but I
> can't come up with a situation where a removed disk will result in uppe=
r
> layers continuing to use it as if it were there.
>=20

I agree with the core of what you said, but I also think you're
overcomplicating it a bit.  If BTRFS is unable to write a single copy of
data, it should go R/O. (god knows, it has enough triggers to go R/O on
it's own already,, it seems odd that being unable to write data is not
included.)

A more strict mode of raid error could be used to go R/O if any of the
writes fail, (rather than btrfs continuing in a degraded mode
indefinately until reboot,), but that would be something that could be a
mount option.



--vpeX83ptR3umr7qJxi3psLWzGj9SAbv7r--

--92csbYjyUy2KOMWEvj2FVQJEvtB8EnzcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJercDHAAoJEO9Tn/JHRWptmNkIALo2GW3nmPiFDXS/KRpk83nS
Gz+AploHChMXcByruMnKYv8XJKi7zxEDJHLc1tLx6Bhgjl5BwEL8u9dr2c3vT0Dc
tJTuQNXyV/PMX65P20OtQlchQCsCtlYZEmI0fcroPpCpcBtBi5/b6njoDoVyouWm
jtEKOFzMsh6Bg0/8VkdkKxs/G12eg33Ozx0Q2crH7lKnnSJYapVu+WN0KkpLZCMj
kBfx0oMClDt3paHOj9yqsSNZ7N0zytMMl74HCRmtpO+spX23mafGJ+utHsNSrQVD
SGHCZaUbQYfwI61/JkT95L7XaLNuXWhSb5tWVnaAYRvAVTp5tjNRkISGbf9eQ8A=
=C7V/
-----END PGP SIGNATURE-----

--92csbYjyUy2KOMWEvj2FVQJEvtB8EnzcT--
