Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6A12ACFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 15:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLZOVG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 09:21:06 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34819 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfLZOVF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 09:21:05 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B4B024C1;
        Thu, 26 Dec 2019 09:21:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 26 Dec 2019 09:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=gxy3PObIABz06KwSpP3IYO0p3/V
        OgkAtnyyeIG3Ke+4=; b=iwlcfL9yINWCMnzVaTXHQN7yz46+SEDaaix5m5EhQQt
        FlL750A1eKfwBQYqh8o2IpuqMuLO3+votCa0tI/7jMFGoZiCFQTg7OYMTTEDNUri
        WC//EM9haE7d49rP0ScVl/nxFrErnlhlCVtv58iLXVRzXIvbXGGhsfVZAQbgLEAO
        P6bLlyLdJ2YJ5gB8M0AxZWc3lyDMK0N4wbh4xRlioPELPUdVZqf9db6PCvo10Ccw
        tuHPzLbgeJc71Ozbmqrw4Hj0ImIi5o6W45ygPO/Y45P4Pf09PZrYyYsbXTGuTOwy
        m5hnPmaiudNhtyjZdncap4ZrLaj4WacLvs192VbmlFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gxy3PO
        bIABz06KwSpP3IYO0p3/VOgkAtnyyeIG3Ke+4=; b=VSEw4+TYhD3lr+8tqsfWeD
        uT5uyW40dUPm5kv5sjQ4cMhDORq1pmnd/dDjsIzem8l5weUqB02+BIW8apd1R/8x
        SAgw4jX7Em2adH3EMbw0w5ilWhU9eJhDB+f3kCX7/KSqNVdJJGy/zge+clcME4bQ
        aM7RHXsGAuPQA8BID8XWz81Sb0AphMHMP9y8uhtOdwlqqpe7cj7vGs5ZEhFDlw+F
        y/NI8J6ZNnNGxhkeNMnPstfQOx35ji0FiDHO+zQoxhwNksUNq948I9kauvbXbgC0
        sXwmfebwmizi7d7uaR+GF/ixiRCSZW0glGPLmu/IggmDvDriKgoQnKpe5vvin07g
        ==
X-ME-Sender: <xms:0MEEXrS-g-QvJ2QIygVo6sumuRbYXpsbcBDtmhebAuYPM5QKca5p9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddviedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedvfe
    drvdeffedruddtvddrfeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgv
    ohhrghhirghnihhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:0MEEXmad8mqiFA18bFr-t3CtUWCNDAqkXYXOC2Zk0HnOEKzp47QPFQ>
    <xmx:0MEEXg2gkMJvUW5jffrmmkHJRpDyCK1_JRXIRqBKpn2_Yuzp_eRtQw>
    <xmx:0MEEXuXb2c0pem4q6VoS-afPUZXELbWoUDnc2fNKkA7xqyUu7iTUuA>
    <xmx:0MEEXnPLFwbecK6KdLZexfOh3wyZyqH3DtAXsGC29dU5bq5Wjvcglg>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 081B93060783;
        Thu, 26 Dec 2019 09:21:03 -0500 (EST)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
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
Message-ID: <5954540e-e7b0-e3c8-cbab-ad45f4467684@georgianit.com>
Date:   Thu, 26 Dec 2019 09:21:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="akYEsShATVKbtDIYlFVyEE5uPWZdaDuda"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--akYEsShATVKbtDIYlFVyEE5uPWZdaDuda
Content-Type: multipart/mixed; boundary="cIkP7fljxwJfrsuI9LkIIVzDqzGmoP1Dp";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Leszek Dubiel <leszek@dubiel.pl>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <5954540e-e7b0-e3c8-cbab-ad45f4467684@georgianit.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
In-Reply-To: <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>

--cIkP7fljxwJfrsuI9LkIIVzDqzGmoP1Dp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-12-26 9:05 a.m., Leszek Dubiel wrote:

>=20
> I didn't use Raid6, but Raid0.
>=20
>=20
> Yes I have chcecked dmesg in first place (see original mail).
>=20
> Btrfs no error logged.
>=20

I'm sorry, that was reading comprehension failure on my part.

But regardless, your dmesg clearly shows drive read failures, (to be
expected with a drive clearly in a failing state.)

Recovery of Raid0 with a faulty drive is a job for restore from backup,
(or attempt to scrape what you can with array mounted ro).. That's what
Raid0 *means*.



Dec 22 19:20:11 wawel kernel: [ 5912.116874] ata1.00: exception Emask
0x0 SAct 0x1f80 SErr 0x0 action 0x0
Dec 22 19:20:11 wawel kernel: [ 5912.116878] ata1.00: irq_stat 0x40000008=

Dec 22 19:20:11 wawel kernel: [ 5912.116880] ata1.00: failed command:
READ FPDMA QUEUED
Dec 22 19:20:11 wawel kernel: [ 5912.116882] ata1.00: cmd
60/00:38:00:00:98/0a:00:45:01:00/40 tag 7 ncq dma 1310720 in
Dec 22 19:20:11 wawel kernel: [ 5912.116882]          res
43/40:18:e8:05:98/00:04:45:01:00/40 Emask 0x409 (media error) <F>
Dec 22 19:20:11 wawel kernel: [ 5912.116885] ata1.00: status: { DRDY
SENSE ERR }
Dec 22 19:20:11 wawel kernel: [ 5912.116886] ata1.00: error: { UNC }
Dec 22 19:20:11 wawel kernel: [ 5912.153695] ata1.00: configured for
UDMA/133
Dec 22 19:20:11 wawel kernel: [ 5912.153707] sd 0:0:0:0: [sda] tag#7
FAILED Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
Dec 22 19:20:11 wawel kernel: [ 5912.153709] sd 0:0:0:0: [sda] tag#7
Sense Key : Medium Error [current]
Dec 22 19:20:11 wawel kernel: [ 5912.153710] sd 0:0:0:0: [sda] tag#7
Add. Sense: Unrecovered read error - auto reallocate failed
Dec 22 19:20:11 wawel kernel: [ 5912.153711] sd 0:0:0:0: [sda] tag#7
CDB: Read(16) 88 00 00 00 00 01 45 98 00 00 00 00 0a 00 00 00
Dec 22 19:20:11 wawel kernel: [ 5912.153712] print_req_error: I/O error,
dev sda, sector 5462556672
Dec 22 19:20:11 wawel kernel: [ 5912.153724] ata1: EH complete

I'm assuming that /dev/sda is the the drive you already identified as
failing,, if not, you're totally hosed.



--cIkP7fljxwJfrsuI9LkIIVzDqzGmoP1Dp--

--akYEsShATVKbtDIYlFVyEE5uPWZdaDuda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeBMHPAAoJEO9Tn/JHRWptBo0H/24P8ldJ5oe4pWljMgTBedUB
kZW8ihhsgaRMvKEh3QMcBHiZg565BWokk8ixgoeqnDgPthebJrTdS/+iweL46PRI
vZQltUXoynoRMTWY3HP2YOhjid4fNmONvCgMjR8u9WiT/BoA3Db1pp1t6zcC6VSC
lKHO2boJRww6dBNzT/NN8TJ5MZOWHAJ+/sPzOtwkc5LnzLxU//7Oox5GgIs+kli4
llC4MhaH2KHGLAChB7yQERqekfnWYE1qHQFMTXxFK2TPU7oQ/hThW27+MV12xuw9
WUTlwew4x+7uXB6eIpYk62SO1V8gBtcomWQQ22vm6JpIPFTlt46XZPuHAPfMJjY=
=iIHI
-----END PGP SIGNATURE-----

--akYEsShATVKbtDIYlFVyEE5uPWZdaDuda--
