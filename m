Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041055687C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGFMFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiGFMFH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 08:05:07 -0400
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 05:05:03 PDT
Received: from ares.xsec.at (ares.xsec.at [IPv6:2a03:f80:ed15:149:154:154:192:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011A28E3C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 05:05:03 -0700 (PDT)
Received: from [10.137.0.18] (84-113-43-82.cable.dynamic.surfer.at [84.113.43.82])
        by ares.xsec.at (Postfix) with ESMTPSA id A06CC40463
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 13:59:21 +0200 (CEST)
Message-ID: <36ad3a51-3629-06b0-2a04-a106bf571a91@xsec.at>
Date:   Wed, 6 Jul 2022 13:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Nicolas Averesch <naveresch@xsec.at>
Autocrypt: addr=naveresch@xsec.at; keydata=
 xjMEX0zqThYJKwYBBAHaRw8BAQdAPDYG+dIyPil1fPszx7HNG2SnO0QaRG1wSZf3Vq5Tbu/N
 JE5pY29sYXMgQXZlcmVzY2ggPG5hdmVyZXNjaEB4c2VjLmF0PsKQBBMWCAA4AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEE23Uj6aolNJFO9UTyj64aOSyurjgFAl9M6pEACgkQj64a
 OSyurjg3lQEArLrp3qngBcLdOIYNf22N4j2cWXn8LF/20Rx8i4SyZqMBAIiVgYH0PEulHrhU
 u/gqssLUnRTym102hqWHRwk/MXULzjgEX0zqThIKKwYBBAGXVQEFAQEHQDFZuzwI1Q3jRogP
 8nh0MIzDksviVt/gRr0hy4y4tVkUAwEIB8J4BBgWCAAgAhsMFiEE23Uj6aolNJFO9UTyj64a
 OSyurjgFAl9M6pEACgkQj64aOSyurjiy8gEAr7ESHlBjC/F9GKguemmeBUdz04av2KJISOq1
 HBmEhcIA/iwfI/Qp+rm2/FQxN4aeltP9W1e/rrYRHy0vazzOv6cH
To:     linux-btrfs@vger.kernel.org
Subject: lost page write due to IO error on [...]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------atXc64LyB2F00SmLHcBgXhSS"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------atXc64LyB2F00SmLHcBgXhSS
Content-Type: multipart/mixed; boundary="------------6h8vucvWLpaXCHJnX2rE0sOn";
 protected-headers="v1"
From: Nicolas Averesch <naveresch@xsec.at>
To: linux-btrfs@vger.kernel.org
Message-ID: <36ad3a51-3629-06b0-2a04-a106bf571a91@xsec.at>
Subject: lost page write due to IO error on [...]

--------------6h8vucvWLpaXCHJnX2rE0sOn
Content-Type: multipart/mixed; boundary="------------q5eXHkoTygxWfWGwqtS7AaG5"

--------------q5eXHkoTygxWfWGwqtS7AaG5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgKiwNCg0Kd2UgYXJlIHNlZWluZyBCVFJGUy1FcnJvcnMgb24gdHdvIG9mIG91ciAobmV3
KSBoYXJkZHJpdmVzLg0KDQpPdXIgY3VycmVudCBzZXR1cCBmb3IgdGhlc2UgaGFyZGRyaXZl
cyBpcyBCVFJGUyBvbiB0b3Agb2YgTFVLUyBvbiB0b3Agb2YgDQpMVk0uDQoNClRoZSBlcnJv
cjoNCg0KWyA0MDI3LjM4NTUzOF0gYmxrX3VwZGF0ZV9yZXF1ZXN0OiBJL08gZXJyb3IsIGRl
diBzZGMsIHNlY3RvciAzNjk5MiBvcCANCjB4MTooV1JJVEUpIGZsYWdzIDB4MjM4MDAgcGh5
c19zZWcgMSBwcmlvIGNsYXNzIDANClsgNDAyNy4zODU2MjBdIEJUUkZTIHdhcm5pbmcgKGRl
dmljZSBkbS02KTogbG9zdCBwYWdlIHdyaXRlIGR1ZSB0byBJTyANCmVycm9yIG9uIC9kZXYv
bWFwcGVyL3ZnMy1sdjNfY3J5cHQgKC01KQ0KWyA0MDI3LjM4NTYzMF0gQlRSRlMgZXJyb3Ig
KGRldmljZSBkbS02KTogYmRldiAvZGV2L21hcHBlci92ZzMtbHYzX2NyeXB0IA0KZXJyczog
d3IgMSwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KWyA0MDI3LjM4NTY5OF0g
QlRSRlMgZXJyb3IgKGRldmljZSBkbS02KTogZXJyb3Igd3JpdGluZyBwcmltYXJ5IHN1cGVy
IA0KYmxvY2sgdG8gZGV2aWNlIDENClsgNDAyNy4zODU4MjldIEJUUkZTOiBlcnJvciAoZGV2
aWNlIGRtLTYpIGluIHdyaXRlX2FsbF9zdXBlcnM6NDI1NTogDQplcnJubz0tNSBJTyBmYWls
dXJlICgxIGVycm9ycyB3aGlsZSB3cml0aW5nIHN1cGVycykNClsgNDAyNy4zODU4NzNdIEJU
UkZTIGluZm8gKGRldmljZSBkbS02KTogZm9yY2VkIHJlYWRvbmx5DQoNCklzIHRoZXJlIGFu
eSB3YXkgdG8gZmlndXJlIG91dCB3aGF0IGV4YWN0bHkgaXMgZ29pbmcgd3Jvbmc/IENvdWxk
IHRoaXMgDQplcnJvciBiZSBkdWUgdG8gbWlzY29uZmlndXJhdGlvbiBvZiBidHJmcz8gKE9y
IGp1c3QgYSBzaW1wbGUgaGFyZHdhcmUgDQppc3N1ZT8pDQoNCldlIGhhdmUgYWxyZWFkeSBz
ZXQgL3N5cy9ibG9jay9zZGMvZGV2aWNlL3RpbWVvdXQgYW5kIA0KL3N5cy9ibG9jay9zZGQv
ZGV2aWNlL3RpbWVvdXQgdG8gMTgwLg0KDQpGb3IgbW9yZSBkZXRhaWxzIHBsZWFzZSBmaW5k
IGRtZXNnIGhlcmU6IA0KaHR0cHM6Ly9iaW4uMHhmYy5kZS8/ZjY2ZjUzMzcyMzhiMDZiYyMz
a2dUQlZZdDFva1JlWUF2eWF3RVd5N0xpVXF1dVoxalpMNmJHeHpIZFlWWA0KDQojIHVuYW1l
IC1hDQpMaW51eCBob3N0bmFtZSA1LjE1LjM5LTEtcHZlICMxIFNNUCBQVkUgNS4xNS4zOS0x
IChXZWQsIDIyIEp1biAyMDIyIA0KMTc6MjI6MDAgKzAyMDApIHg4Nl82NCBHTlUvTGludXgN
CiPCoCBidHJmcyAtLXZlcnNpb24NCmJ0cmZzLXByb2dzIHY1LjE2LjINCiMgYnRyZnMgZmkg
c2hvdw0KTGFiZWw6IG5vbmXCoCB1dWlkOiBmOGMzN2I0NS1kY2FmLTQ1NTMtYWQ0Zi0zNzli
NDcyODY4ZjQNCiDCoMKgIMKgVG90YWwgZGV2aWNlcyAyIEZTIGJ5dGVzIHVzZWQgMzUuMDVH
aUINCg0KIMKgwqDCoCA8dGhvc2UgZGV2aWNlcyAodmcxLWx2MV9jcnlwdCBhbmQgdmcyLWx2
Ml9jcnlwdCkgYXJlIE9TIGRyaXZlcyBhbmQgDQpub3QgYWZmZWN0ZWQgYnkgYWZvcmVtZW50
aW9uZWQgaXNzdWVzPg0KDQogwqDCoMKgIGRldmlkwqDCoMKgIDEgc2l6ZSA5MzAuNTZHaUIg
dXNlZCAzNy4wM0dpQiBwYXRoIC9kZXYvbWFwcGVyL3ZnMS1sdjFfY3J5cHQNCiDCoMKgIMKg
ZGV2aWTCoMKgwqAgMiBzaXplIDkzMC41NkdpQiB1c2VkIDM3LjAzR2lCIHBhdGggL2Rldi9t
YXBwZXIvdmcyLWx2Ml9jcnlwdA0KDQpMYWJlbDogbm9uZcKgIHV1aWQ6IGU2NDFjMTRiLWEw
OWMtNGU2YS04M2I4LTcxNzY3MjhkOGYwMQ0KIMKgwqAgwqBUb3RhbCBkZXZpY2VzIDEgRlMg
Ynl0ZXMgdXNlZCAxNzYuMDBLaUINCiDCoMKgIMKgZGV2aWTCoMKgwqAgMSBzaXplIDMuNjRU
aUIgdXNlZCAyLjAyR2lCIHBhdGggL2Rldi9tYXBwZXIvdmc0LWx2NF9jcnlwdA0KDQpMYWJl
bDogbm9uZcKgIHV1aWQ6IGI1MGViZjM4LWJjYmQtNDM4ZC05ZjA0LTIyYjQ5NDZjZDY1Yw0K
IMKgwqAgwqBUb3RhbCBkZXZpY2VzIDEgRlMgYnl0ZXMgdXNlZCAxOTIuMDBLaUINCiDCoMKg
IMKgZGV2aWTCoMKgwqAgMSBzaXplIDMuNjRUaUIgdXNlZCAyLjAyR2lCIHBhdGggL2Rldi9t
YXBwZXIvdmczLWx2M19jcnlwdA0KDQojIGJ0cmZzIGZpIGRmIC9oZGRzDQpEYXRhLCBzaW5n
bGU6IHRvdGFsPTguMDBNaUIsIHVzZWQ9MC4wMEINClN5c3RlbSwgRFVQOiB0b3RhbD04LjAw
TWlCLCB1c2VkPTE2LjAwS2lCDQpNZXRhZGF0YSwgRFVQOiB0b3RhbD0xLjAwR2lCLCB1c2Vk
PTEyOC4wMEtpQg0KR2xvYmFsUmVzZXJ2ZSwgc2luZ2xlOiB0b3RhbD0zLjI1TWlCLCB1c2Vk
PTMyLjAwS2lCDQoNCldlJ2QgYXBwcmVjaWF0ZSBhbnkgaGVscCB3ZSBjYW4gZ2V0Lg0KDQpC
ZXN0IHJlZ2FyZHMsDQoNCk5pY28NCg0K
--------------q5eXHkoTygxWfWGwqtS7AaG5
Content-Type: application/pgp-keys; name="OpenPGP_0x8FAE1A392CAEAE38.asc"
Content-Disposition: attachment; filename="OpenPGP_0x8FAE1A392CAEAE38.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEX0zqThYJKwYBBAHaRw8BAQdAPDYG+dIyPil1fPszx7HNG2SnO0QaRG1wSZf3
Vq5Tbu/NJE5pY29sYXMgQXZlcmVzY2ggPG5hdmVyZXNjaEB4c2VjLmF0PsKQBBMW
CAA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE23Uj6aolNJFO9UTyj64a
OSyurjgFAl9M6pEACgkQj64aOSyurjg3lQEArLrp3qngBcLdOIYNf22N4j2cWXn8
LF/20Rx8i4SyZqMBAIiVgYH0PEulHrhUu/gqssLUnRTym102hqWHRwk/MXULzjgE
X0zqThIKKwYBBAGXVQEFAQEHQDFZuzwI1Q3jRogP8nh0MIzDksviVt/gRr0hy4y4
tVkUAwEIB8J4BBgWCAAgAhsMFiEE23Uj6aolNJFO9UTyj64aOSyurjgFAl9M6pEA
CgkQj64aOSyurjiy8gEAr7ESHlBjC/F9GKguemmeBUdz04av2KJISOq1HBmEhcIA
/iwfI/Qp+rm2/FQxN4aeltP9W1e/rrYRHy0vazzOv6cH
=3DLFMb
-----END PGP PUBLIC KEY BLOCK-----

--------------q5eXHkoTygxWfWGwqtS7AaG5--

--------------6h8vucvWLpaXCHJnX2rE0sOn--

--------------atXc64LyB2F00SmLHcBgXhSS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTbdSPpqiU0kU71RPKPrho5LK6uOAUCYsV5GAUDAAAAAAAKCRCPrho5LK6uOKGr
AQDp1Nw1lFGC85N6ZPX68eiOgHCv7oMpXSg97hKfG43obQEAltWuh1Xp25EYfDubU8TfeETIFIG1
1MGfTgei0pRviQg=
=wdGI
-----END PGP SIGNATURE-----

--------------atXc64LyB2F00SmLHcBgXhSS--
