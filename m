Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FA6058B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfGELr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 07:47:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56761 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfGELr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 07:47:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5680220A82;
        Fri,  5 Jul 2019 07:47:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 05 Jul 2019 07:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:cc:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=2Ixz+pkoDZnmG3ElujSNNtfgQQK
        w8mnnJ2ebZqkezlo=; b=X9dUQUWj6QZ3yiH/MNPlpXq77Q9ukS6I0jqy66HD1Y/
        MJyDr0vKJeO+BtN9XSCOOXM9fLs7y34ZEmvN2A3B8Bkt8rdrSrocKAbOUmfWybaD
        7gCqBA/uzMOF5ebbL9zjZv/O5OzVIQoOkZ001k7wwvyGyoUIHFIBEuGiA2NWKTwV
        AlewnwRbxZaqn2lQRfrnKyMGkBSTgvxcjRMsALFBcuU+K5w7BiTNQvCpBbM798tO
        tlrX200NMAGKBmzfwgPM244JVGgBITq1a/m0fG6+kRu75GOuVLRHc97karC2JMmO
        sT9h8L0rZJhm9rxF0Di1XCtbjKLTFlTRivWmtUdNjNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2Ixz+p
        koDZnmG3ElujSNNtfgQQKw8mnnJ2ebZqkezlo=; b=c3+bWjJXtZ+4vIoFyjgZHI
        uujEKiYYXmy8XjhFK83VPRwMDfaL4FQNGXULK09ApPIoxCicTFwaCrhfudZroSi2
        Cl0im6miS+gymBAnw+NQfCVXgTo60OTJU0wT6dOuSSrZ91ypGc/Dj3pcXfHa4vmz
        HOGG1jVJOMOY/aA+KyLg8WJB4Evm0mIpUKNsWAlhrnUJZVb7IQikXMN7dF8GHwsD
        eLP2CnjKBC23nOtWKwUw8Y2KUSAKD0oQvyKme9HngdGNHSqolca44490VkU+LGoP
        FtFRc/kkApaF80UL9qV6JQZeU933W2uFJW33nY7gR9v+5QGeL9PoEBgsJFkQdcZg
        ==
X-ME-Sender: <xms:zTgfXYeY3iEv2u1WoJiD0S0PscB_oa5ptbQ7CfX8ByUE43f2pVWiTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfeeggdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:zTgfXZmSeNhr2z22uSeZwBocF0X8Bn0lLXo-n73Jw8H3iehUBhr9og>
    <xmx:zTgfXcFN8RPDMvBABr93RBUUejIo85UkVQcPvQtC9uPlLHiy9MDAkg>
    <xmx:zTgfXfJF5YEs1qpeGIPTESN0CCeFCRfCO0STHRLCbXonBUmQC4kpfw>
    <xmx:zjgfXa23Kt9MpQtSA0jFDRa9DEBcpZdHzT2f6J8sIIQ4-8SMo7gTbw>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CBC9380085;
        Fri,  5 Jul 2019 07:47:25 -0400 (EDT)
Subject: Re: snapshot rollback
To:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>
References: <20190705103823.GA13281@tik.uni-stuttgart.de>
 <20190705110614.GA14418@tik.uni-stuttgart.de>
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
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <f0f13684-8975-721f-5c91-fe3043065634@georgianit.com>
Date:   Fri, 5 Jul 2019 07:47:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190705110614.GA14418@tik.uni-stuttgart.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IYA2Mn9ZAp0V8sTl0YzwWk3N4ynsZYFxK"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IYA2Mn9ZAp0V8sTl0YzwWk3N4ynsZYFxK
Content-Type: multipart/mixed; boundary="FxWRTNgkxtSDaK27eZn8v9TeGpd73tclg";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <f0f13684-8975-721f-5c91-fe3043065634@georgianit.com>
Subject: Re: snapshot rollback
References: <20190705103823.GA13281@tik.uni-stuttgart.de>
 <20190705110614.GA14418@tik.uni-stuttgart.de>
In-Reply-To: <20190705110614.GA14418@tik.uni-stuttgart.de>

--FxWRTNgkxtSDaK27eZn8v9TeGpd73tclg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-07-05 7:06 a.m., Ulli Horlacher wrote:

>=20
> Ok, it seems my idea (replacing the original root subvolume with a
> snapshot) is not possible.=20
>=20

Disclaimer: You probably want to wait at least 24 hours before trying my
directions in case anyone has am important correction to make.  You
should have a means of recovering in case I got it completely wrong.
(ie. good backups)

It is common practice with installers now to mount your root and home on
a subvolume for exactly this reason.  (And you can convert your current
system as well.  Boot your system with a removable boot media of your
choice, create a subvolume named @.  Move all existing folders into this
new subvolume.  Edit the @/boot/grub/grub.cfg file so your Linux boot
menu has the @ added to the paths of Linux root and initrd.

Ex:

linux   /@/boot/vmlinuz-4.15.0-43-generic
root=3DUUID=3D78d04a41-3786-4140-aeb8-5f2f809e7ba7
initrd  /@/boot/initrd.img-4.15.0-43-generic

(you can make this change directly into the grub menu at boot time
instead of editing  the grub.cfg file, if you prefer.)

Edit the @/etc/fstab file so that mount points to the device we are
changing have the subvol=3D@ option.

Example:

UUID=3D78d04a41-3786-4140-aeb8-5f2f809e7ba7 /               btrfs
noatime,nossd,subvol=3D@ 0       1


Reboot, and if the system successfully boots, you should run update-grub
to fix up the grub.cfg file.

=46rom a running system, if you need to see the root subvolume again, (so=

you can see and manipulate the @ subvol,), mount it somewhere else:

mkdir /mnt/sda1
mount /dev/sda1 /mnt/sda1

=46rom that point forward, it's easy to rename /mnt/sda1/@ and replace it=

with a snapshot of your choice,. (then reboot.)





--FxWRTNgkxtSDaK27eZn8v9TeGpd73tclg--

--IYA2Mn9ZAp0V8sTl0YzwWk3N4ynsZYFxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdHzjMAAoJEO9Tn/JHRWptjzQH/A/4Z6ghqn5jAWuDnOzbQK4p
TK9saIyDC3g1K4wTB338as/7LBqGweFHcsZ5klgZrdmA44Oaf/38GxyDGI/UJiKq
88BvJUJAnEA1QyHPizbuZjQQPcMyg2MDbbj8BspeDeePZCst5g96xrW4vxBa/Hb1
JxnUyg7tNtL/wPOZBKNNjwDUT9ADYtYD5gr30+acnjKxt0tajdzqVaiJyVCyB1qs
zd2vpL5Xeufg93PNwW8+0bbpNHJqAooxStOoXgvti1BqZEUd1jQZaz03flwjFj4p
hQCRVlPC/LFLuVP4okDqBslHnTS6UsBW2UU4gg+IWn4YJjVkybrh3VYusMbo95k=
=wO7T
-----END PGP SIGNATURE-----

--IYA2Mn9ZAp0V8sTl0YzwWk3N4ynsZYFxK--
