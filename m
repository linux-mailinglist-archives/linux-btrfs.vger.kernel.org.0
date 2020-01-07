Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FEA131D58
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 02:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgAGBtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 20:49:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42055 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbgAGBtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 20:49:19 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3452422116;
        Mon,  6 Jan 2020 20:49:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 Jan 2020 20:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=wO5IFg+mAJkO3eICRKGfWIfLSFW
        IaF3ZO8vTOhBPlKY=; b=qBTZ9JYW+eGTQi5/gzEd6sTMCm8sH088/047SRSmlLN
        LMC/xOwlox450x1OMVTeE9oormrLMVFHm481fpi3cRLRrpWENUfz1IlZAm07FOri
        ScHWhXZ7E2UCEOO5XPumU3HerqhnaNhPPjNwdHoCZ+6eU4qumgDpLcVeoqd3/97k
        StvNYTirBtG8B0MMBQcsimq2C75CB0g/1DUAkJncfN83NfqxB6FhlHPhdkClOxLm
        YDX0nFvkE6pBsX+zJiqu7klAZBw+AA8HNtdbFha3GJLohc2xlCazOHgNNLwkXn+s
        SoNpmj9vvjeZtBvMRyasFqyxKudSnkGSWsM7UdiMoeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wO5IFg
        +mAJkO3eICRKGfWIfLSFWIaF3ZO8vTOhBPlKY=; b=Xc4X0SvsArq823nuHHJbJf
        dZZorWZi0NmWLWNdAF7rZ/hpG0hsCfDPWd8Xcig2BJfJFgIkmaHMZpwj+c2XItyA
        /R2IThIX3epgnVKXR1D/LhKHbXGuzCTwcNo6TGuTA1ittJ4UJpLrYZxlgbo4HEH0
        T/j8f4uSXdhZ0icfO96WHF4iIX1V1GazUrD9j7inVIkH6DS12trdAczn52KyBnAW
        fvoJ7QQb0jllrl8+TsWQCW555c0v2mp9oEBJHpIT0GU/SxPz2T8oaSg7QF3nsFBD
        11JoXG4prkIKgZkQCY4jGJleskiYWhRkeVbCQOWREAcSTrEE5yTzWuHihY4msWcg
        ==
X-ME-Sender: <xms:nuMTXm7W07nStBfkiQY_p5gySOwgraXxtX5ySe5V4IohpmQEmiaMUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeehnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedvfe
    drvdeffedruddtvddrfeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgv
    ohhrghhirghnihhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:nuMTXscHDfv5uqXWoZP85TEnbn7BzQ4h3jlAiPeGIBWNB48SHEUCkg>
    <xmx:nuMTXp5So8pEydTdjxVQbO_FAM5ky4KuRBehblcxp-b9gb6xTp2oQw>
    <xmx:nuMTXp8i4WEwcOqp29ijtltLLoAoa5Ip8DYjfd2zkJJSzDNksFTvpA>
    <xmx:nuMTXgk2j7EAkNtAAtpZsm_pzBm0IVZT5lLhSorj9OxoJ2A-fQ6jTQ>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id B583E80061;
        Mon,  6 Jan 2020 20:49:17 -0500 (EST)
Subject: Re: Errors after SATA hard resets: parent transid verify failed, csum
 mismatch on free space cache
To:     Stephen Conrad <conradsd@gmail.com>, linux-btrfs@vger.kernel.org
References: <1794842.PFUSC7HjHz@paca>
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
Message-ID: <45ce42d0-f49a-5f0b-b0ff-a1ce46808003@georgianit.com>
Date:   Mon, 6 Jan 2020 20:49:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1794842.PFUSC7HjHz@paca>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m4nu9rjvPsKoDfo84zAtbXnssg9QutULI"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m4nu9rjvPsKoDfo84zAtbXnssg9QutULI
Content-Type: multipart/mixed; boundary="zDgcp0SiSaxtw12sWx8t1iY66ounimij2";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Stephen Conrad <conradsd@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <45ce42d0-f49a-5f0b-b0ff-a1ce46808003@georgianit.com>
Subject: Re: Errors after SATA hard resets: parent transid verify failed, csum
 mismatch on free space cache
References: <1794842.PFUSC7HjHz@paca>
In-Reply-To: <1794842.PFUSC7HjHz@paca>

--zDgcp0SiSaxtw12sWx8t1iY66ounimij2
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-01-06 12:32 p.m., Stephen Conrad wrote:

>=20
> 4) What steps should I take to clean up the file system errors/messages=
?  Start=20
> fresh after full backup, (though I hate the idea of migrating off a red=
undant=20
> array onto a single disk in the process)?  Scrub etc?  Evaluate each di=
sk=20
> independently and rebuild one from the other?


I'm not really an expert, so this is just my understanding of btrfs so fa=
r:

Assuming these two devices are in a btrfs raid 1, only one of the two
devices has errors, (which is what I would expect for a device that
disconnected while the filesystem was running.)

With Millions of failed writes, i don't think it's appropriate to count
on scrub to have fixed up all the potential data errors.  Scrub on BTRFS
will check the CRC independently on both drives, and copy over data
where CRC fails, but CRC isn't perfect.  To the best of my knowledge,
BTRFS does not actually compare the data between mirror copies.

So my suggestion, to fix this safely, is to do a btrfs replace, and
replace /dev/mapper/K1JG82AD with a new device.


btrfs replace -r /dev/mapper/K1JG82AD /dev/new_device_partition /btrfs

The -r switch will ensure data is only copied from the drive that is not
full of potentially bad data with CRC collisions.

If you determine that /dev/mapper/K1JG82AD is actually physically fine,
you can re-add to the array.. maybe even use it to replace the spare
drive we just put in.

One note about using btrfs replace,, I don't know if this might be fixed
with newer kernels,, but I find that the error count from the old device
will re-appear on the new device, but only after a reboot, (or maybe
unmount/mount.) you should check for that, and if the new device
inherits your old errors, you should zero it with btrfs dev stats -z







--zDgcp0SiSaxtw12sWx8t1iY66ounimij2--

--m4nu9rjvPsKoDfo84zAtbXnssg9QutULI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeE+OdAAoJEO9Tn/JHRWptmMIIANnn0u5mXo8VEx4n50jBuZko
KqCLwnq+T7zwut9bsH4jyle/O0hX7q576lLTxldC3QzTHfq3qXu4SOgOG4OVS6i+
rxlBTi+TT88ce8Ivco7hQZLutR86RHSTdwLW225rp44JQ2rHktfvARpuiRHzX6GP
NXBA8Zx1i9wsdCyktGKrdvR/s0iS+zGfE0e0fsvc81pJR2GbJJGBSmOC9AHo1qBL
WZRsmoagXmAvr4cwDtjk/5H6UVzrTcEhEtoXcT4zgKzVetP8XrZBdgv5O+Es8s2/
HhAkQlUviSq/Np4lXY/CjJlWVtRjskPz3vjtyvQ9RU3SXW620iEOSRgf44xRnHY=
=qS6D
-----END PGP SIGNATURE-----

--m4nu9rjvPsKoDfo84zAtbXnssg9QutULI--
