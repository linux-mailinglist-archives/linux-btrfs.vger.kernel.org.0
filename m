Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608F520DB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfEPRJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 13:09:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45497 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfEPRJv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 13:09:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id DB43025C81;
        Thu, 16 May 2019 13:09:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 May 2019 13:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=kJCebyoXJ4pfLoW6dMW5VWgERxj
        0cKVnJhL9eSEzVPQ=; b=YvRLZMZG03ejiEdpuuzsp4VD4ZHgs/wP196TgBP1gfo
        GDTEKni0qLJ/yqtfTU4kYCrYwOufHT2eZdst1XpMyGlRjGK9I3qAMRITZ/gGzcym
        OgPPlYNtd2+Uih8FLJjsdYVyfNWON5UEDoOEit7jONDhI3DiTe2VWd1fjkIgNbC4
        RN5U7K/jmEHUghDTws4bkPZCHI+MgobD8rlAtxMEgCobFdd5N9/yaBd733fuqjFU
        KUdez0gtiySY6UI4iV31h5SAdVKsR1bW3OfS+ltLam3zWnAtIXDygec4wscJaVAE
        /JQRUBL8oC/Lz/HRyOW2Nomlk/L4AfJ70xXnZBsb7jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kJCeby
        oXJ4pfLoW6dMW5VWgERxj0cKVnJhL9eSEzVPQ=; b=HMZssvvHp0xPYMF5T8hkx8
        SBLg5WQY+yorrbrqFuMMfirpl8AF6OizuUx7mwoCbI6u7eauDqcpPMyyPvYj1c2p
        XnCJ6W41/kkOh32IZ5VCwF9YvfYjmGY/DWHLn7c/x/uKeip3ajaclgJ0ev24LcKx
        WUMdeVhORuBVsZSELdAhVyWQ2DNW1gROHK0rDzmNL+CFIrB3xIq03laJNuuHvULj
        kE976l5vgt/mccWPDHJarf4qYZZVM6kf6bgPDo4fAOYO0UVfTWuquxbBitzLjc7F
        isAcKqgDZIXsEGg5ns0gT9wHCu39FhxLBkMAUyQl33XXd8hl8ziQIywrbDKj/vVw
        ==
X-ME-Sender: <xms:XpndXFezyRZxNNN4OL7Czq4Wr0DoGln046i-uKUYJgX1WIBoWxYrZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddttddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgesghdtrefotdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucfkphepud
    efhedrvdefrddvgeeirddufedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihes
    ghgvohhrghhirghnihhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:XpndXD-PqPJJrO9pKIoQ5rIJVjzG6wlZ5it22ITcXqw5yjnzSc70Qg>
    <xmx:XpndXHbHUKBQQmHMvnwdU-u3QkvlFHkpe7tznRN7iPffuvWuiBcazA>
    <xmx:XpndXG2H_08lrlNyTAUYE5x-MvpFNy3w_Sfc7IdwEXRGOS_0gWDlUA>
    <xmx:XpndXL9WAmUV4dQnLBG_5e9IgCgSYv5sf4Gg114UOXNGDaSRk9F8PQ>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06140103CB;
        Thu, 16 May 2019 13:09:49 -0400 (EDT)
Subject: Re: Used disk size of a received subvolume?
To:     Axel Burri <axel@tty0.ch>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
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
Message-ID: <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
Date:   Thu, 16 May 2019 13:09:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vIrDP4pZvm9glbvLvYzX3xBZYXUhgzPwP"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vIrDP4pZvm9glbvLvYzX3xBZYXUhgzPwP
Content-Type: multipart/mixed; boundary="RylAgZK74IkSuc4aDTH7XqGvU1OaqTa2A";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Axel Burri <axel@tty0.ch>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
Subject: Re: Used disk size of a received subvolume?
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
In-Reply-To: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>

--RylAgZK74IkSuc4aDTH7XqGvU1OaqTa2A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-05-16 10:54 a.m., Axel Burri wrote:

>=20
> Any thoughts? I'm willing to implement such a feature in btrfs-progs if=

> this sounds reasonable to you.
>=20


BTRFS qgroups are where this is implemented.  You have to enable quotas,
and leaving quotas enabled has lots of problems, (mostly performance
related), so I would not suggest leaving them on when there is lots of
activity, (ie, multiple send/receive, or deletion of many snapshots.)

But you can enable quotas as any time (btrfs quota enable /path)

Wait for the rescan to finish

btrfs quota rescan -s /path  (to view status of scan)

And then:

btrfs qgroup show /path to list the space usage, (total, and what you're
looking for: Exclusive)

Note that the default groups correspond to subvolume ID, not filename,
(someone did make a utility somewhere that will display this output with
corresponding directory names.)

btrfs sub list /path is used to find the relevant ID's.. (I find the -o
option useful, so it only displays the subvolumes that are children to
the /path)

As stated above, I would suggest disabling quotas when you are finished:

btrfs quota disable /path



--RylAgZK74IkSuc4aDTH7XqGvU1OaqTa2A--

--vIrDP4pZvm9glbvLvYzX3xBZYXUhgzPwP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJc3ZlcAAoJEO9Tn/JHRWptNgYIAIdWpHP6z9G0rgsDkGZ7AoHX
W/n1K+d8c4EVis530oUdew2OYk84rSWUIc+hY94FO7u7rJEYLSPApF2YPbHy7Kqg
/i3gM19UGNQpeUbrEYnkHaldPzXQ5zZDfb5noQsgJeiOs7QF3kkPLuIGQNii0dKX
vyULQyw2U0QqOPjqi+EVOYHIEWdllHNHu3EptxoDPM8ddcV1A4kC1H/s0bW7g4xu
LNXHDfB5GN9EOhnWDCtjh6/n7fp03GK7ZMRCLcQ6b6XwxtB+TdEcOK+JRNEq7hTm
WyCzObubsAH5hMvODNYgTAnBT2SvGUJX9zO58fYm/2aLZbyhoQpS5Y18KS7MLwg=
=fiOB
-----END PGP SIGNATURE-----

--vIrDP4pZvm9glbvLvYzX3xBZYXUhgzPwP--
