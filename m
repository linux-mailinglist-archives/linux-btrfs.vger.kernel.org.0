Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A050D0BC
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiDXJNd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiDXJNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 05:13:30 -0400
Received: from mx2.b1-systems.de (mx2.b1-systems.de [159.69.135.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13384644E4
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 02:10:29 -0700 (PDT)
Message-ID: <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
Date:   Sun, 24 Apr 2022 11:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: de-DE
To:     linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
From:   Johannes Kastl <kastl@b1-systems.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
In-Reply-To: <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------o185Zeno2510r0yg7tE6x8jC"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------o185Zeno2510r0yg7tE6x8jC
Content-Type: multipart/mixed; boundary="------------7d6WXI6aghw5ophwdNj6i11B";
 protected-headers="v1"
From: Johannes Kastl <kastl@b1-systems.de>
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
In-Reply-To: <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>

--------------7d6WXI6aghw5ophwdNj6i11B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXUsDQoNCk9uIDI0LjA0LjIyIGF0IDAxOjA3IFF1IFdlbnJ1byB3cm90ZToNCg0KPiBO
byBuZWVkIHRvIHJ1biBidHJmcyBjaGVjayBvbiBlYWNoIGRldmljZS4NCj4gDQo+IEJ0cmZz
IGNoZWNrIHdpbGwgYXNzZW1ibGUgdGhlIGFycmF5IGF1dG9tYXRpY2FsbHkgKGp1c3QgbGlr
ZSBrZXJuZWwpLA0KPiBhbmQgY2hlY2sgdGhlIGZzIG9uIGFsbCBpbnZvbHZlZCBkZXZpY2Vz
Lg0KPiBUaHVzIG5vIG5lZWQgdG8gcnVuIHRoZSBzYW1lIGNoZWNrIG9uIGFsbCBkZXZpY2Vz
Lg0KDQpPSywgZ29vZCB0byBrbm93LiBUaGF0IHNhdmVzIGhhbGYgdGhlIHRpbWUgOi0pDQoN
Cj4+IFRoZSBvdXRwdXQgb2YgdGhlIGNoZWNrIGlzIGJlbG93LiBUaGUgVEw7RFIgd2FzIHRo
YXQgSSBzaG91bGQgcnVuICdidHJmcw0KPj4gcmVzY3VlIGZpeC1kZXZpY2Utc2l6ZScgdG8g
Zml4IGEgIm1pbm9yIiBpc3N1ZS4NCj4+DQo+PiBVbmZvcnR1bmF0ZWx5LCBydW5uaW5nIHRo
aXMgY29tbWFuZCBmYWlsczoNCj4+DQo+Pj4gcm9vdCBkdW1ibzovcm9vdCAjIGJ0cmZzIHJl
c2N1ZSBmaXgtZGV2aWNlLXNpemUgL2Rldi9zZGMxDQo+Pj4gVW5hYmxlIHRvIGZpbmQgYmxv
Y2sgZ3JvdXAgZm9yIDANCj4+PiBVbmFibGUgdG8gZmluZCBibG9jayBncm91cCBmb3IgMA0K
Pj4+IFVuYWJsZSB0byBmaW5kIGJsb2NrIGdyb3VwIGZvciAwDQo+IA0KPiBUaGlzIGlzIGFu
IHVuaXF1ZSBlcnJvciBtZXNzYWdlLCB3aGljaCBjYW4gb25seSBiZSB0cmlnZ2VyZWQgd2hl
bg0KPiBidHJmcy1wcm9ncyBmYWlsZWQgdG8gZmluZCBhIGJsb2NrIGdyb3VwIHdpdGggZW5v
dWdoIGZyZWUgc3BhY2UuDQoNClNvIHdvdWxkIHJlc2l6aW5nIHRoZSBmaWxlc3lzdGVtICh0
byA4R2lCKSB3b3JrYXJvdW5kIHRoaXMgImxpbWl0YXRpb24iLCBzbyANCmFmdGVyd2FyZHMg
aXQgY291bGQgcHJvcGVybHkgZml4IHRoZSBkZXZpY2Ugc2l6ZT8NCg0KPj4+IGJ0cmZzIHVu
YWJsZSB0byBmaW5kIHJlZiBieXRlIG5yIDI5NTkyOTUzODE1MDQgcGFyZW50IDAgcm9vdCAz
wqAgb3duZXINCj4+PiAxIG9mZnNldCAwDQo+Pj4gdHJhbnNhY3Rpb24uYzoxNjg6IGJ0cmZz
X2NvbW1pdF90cmFuc2FjdGlvbjogQlVHX09OIGByZXRgIHRyaWdnZXJlZCwNCj4+PiB2YWx1
ZSAtNQ0KPiANCj4gU28gYXQgbGVhc3Qgbm8gZGFtYWdlIGRvbmUgdG8gdGhlIGdvb2QgYW5k
IGlubm9jZW50IChidXQgYSBsaXR0bGUgb2xkKSBmcy4NCg0KUHV1dWgsIG5pY2UgdG8gaGVh
ciB0aGF0LiA6LSkNCg0KPj4gU28sIG15IHF1ZXN0aW9uIGlzIHdoYXQgSSBzaG91bGQgZG86
DQo+Pg0KPj4gRG8gSSBuZWVkIHRvIHJ1biBhbm90aGVyIGNvbW1hbmQgdG8gZml4IHRoaXMg
aXNzdWU/DQo+IA0KPiBOb3QgcmVhbGx5Lg0KPiANCj4gQnV0IGlmIHlvdSB3YW50IHRvIHJl
YWxseSByZW1vdmUgdGhlIHdhcm5pbmcsIHBsZWFzZSB1cGRhdGUgYnRyZnMtcHJvZ3MNCj4g
Zmlyc3QsIHRvIHRoZSBsYXRlc3Qgc3RhYmxlIHZlcnNpb24gKHY1LjE2LjIpLCBhbmQgdHJ5
IGFnYWluLg0KDQpJJ2xsIGhhdmUgYSBsb29rIGlmIEkgY2FuIGVhc2lseSBpbnN0YWxsIGEg
bmV3ZXIgdmVyc2lvbiBvZiBidHJmc3Byb2dzIG9uIHRoaXMgDQptYWNoaW5lLg0KDQo+IFRo
ZSBpbnZvbHZlZCBwcm9ncywgdjQuMTkgaXMgYSBsaXR0bGUgb2xkLCBhbmQgSUlSQyB3ZSBo
YWQgc29tZSBFTk9TUEMNCj4gcmVsYXRlZCBmaXhlZCBpbiBwcm9ncywgdGh1cyBpZiBhYm92
ZSBwcm9ibGVtIGEgYnVnIGNhdXNlZCBmYWxzZSBFTk9TUEMsDQo+IGl0IHNob3VsZCBiZSBm
aXhlZCBub3cuDQoNCklmIEkgY2FuIGluc3RhbGwgYSBuZXdlciB2ZXJzaW9uLCBJJ2xsIGxl
dCB5b3Uga25vdyBpZiB0aGUgYnVnIGRpc2FwcGVhcnMuDQoNCj4gWW91IGNhbiBpZ25vcmUg
aXQgZm9yIG5vdy4NCj4gSXQncyBub3QgYSBiaWcgZGVhbCBhbmQga2VybmVsIGNhbiBoYW5k
bGUgaXQgd2l0aG91dCBwcm9ibGVtLg0KDQpUaGF0J3MgZ29vZC4NCg0KPj4gU2hvdWxkIEkg
Y29weSBhbGwgb2YgdGhlIGRhdGEgdG8gYW5vdGhlciBkaXNrLCBhbmQgY3JlYXRlIGEgbmV3
IEJUUkZTDQo+PiBSQUlEMSBmcm9tIHNjcmF0Y2g/IChXaGljaCBvZiBjb3Vyc2UgSSB3b3Vs
ZCBsaWtlIHRvIGF2b2lkLCBpZiBwb3NzaWJsZS4uLikNCj4gDQo+IERlZmluaXRlbHkgbm8u
DQoNClBlcmZlY3QuDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSEgSGF2ZSBhIG5pY2UgZGF5
Lg0KDQpLaW5kIFJlZ2FyZHMsDQpKb2hhbm5lcw0KDQotLSANCkpvaGFubmVzIEthc3RsDQpM
aW51eCBDb25zdWx0YW50ICYgVHJhaW5lcg0KVGVsLjogKzQ5ICgwKSAxNTEgMjM3MiA1ODAy
DQpNYWlsOiBrYXN0bEBiMS1zeXN0ZW1zLmRlDQoNCkIxIFN5c3RlbXMgR21iSA0KT3N0ZXJm
ZWxkc3RyYcOfZSA3IC8gODUwODggVm9oYnVyZw0KaHR0cDovL3d3dy5iMS1zeXN0ZW1zLmRl
DQpHRjogUmFscGggRGVobmVyDQpVbnRlcm5laG1lbnNzaXR6OiBWb2hidXJnIC8gQUc6IElu
Z29sc3RhZHQsSFJCIDM1MzcNCg==

--------------7d6WXI6aghw5ophwdNj6i11B--

--------------o185Zeno2510r0yg7tE6x8jC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOjtDOPXdIVAWcUziyeav2MG3z/wFAmJlFAIFAwAAAAAACgkQyeav2MG3z/wA
lQ/+IbpToe8E8Wsn8CVZiCKayft6gpg1rX16lTt81IIjzyJvXB+yxU5i96I9DwzVo48xmoKe7MBX
4JP7EBwtERuJQOXbE9hznc4wY3QgnrGSjnx58lQ2XgRTgVMc8Ej9Jn7alD3wN5w6eCJ2/gNu2MN4
hYZxlhCVnyRk9b30USPaJdMocot4s7MVrUg8JfZH40v4I+xOH7tz7yMb9NnWqLKUa1sjyW7rYgzu
8zCFXOTS/T8GaogMiupTXs1YiND8hpFKTAPD21U7BjCt6Rsk3AIUYgFTX7DtYXQA2/BHKXmn1s2h
Y7dfPL7B5SefboHtyhnM2KAobdWx+ITUW25TsF905vDAepTko2MHqpvORS8ytZlCv88zMH25l2Ag
VRi0gvpd6knp2vshkGtoqg6DVu7cEgRm3qIExhF7fRQcy9hRj5yEpQ80TFjlqpX8j0Npd0x9nDcT
oACSBVL0MUgYde3cKBgDarTrTUI6sA6z95/UvEP9MMSVCr6QkShyLSFqgyYNaBiMSVQgML8AIgPK
4JwRVP+pxdhm3PmXeripj+OyOysMrPd5mlzB9sgDphJLGqzIsYc/N/u4zXQcpb2/O5ag6JtyPXz/
/caFBboftwf1a3WtZRSahxy+m9gXjf6qIAp+I8zhl/45CxQJ8lmUMqovbWYqEbmhAguv0hBumTPJ
5s4=
=zXKB
-----END PGP SIGNATURE-----

--------------o185Zeno2510r0yg7tE6x8jC--
