Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE09532457
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiEXHo6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEXHo5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:44:57 -0400
Received: from mx2.b1-systems.de (mx2.b1-systems.de [159.69.135.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC96EC58
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 00:44:55 -0700 (PDT)
Message-ID: <88a253ee-4dfd-5e3f-8622-63321f7d6e35@b1-systems.de>
Date:   Tue, 24 May 2022 09:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: de-DE
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
 <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
 <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
 <e62b429d-358e-ec38-30ca-671d43a5b5be@gmx.com>
 <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>
 <ea73d6b6-4e91-438e-6f9a-7377bb461bc3@b1-systems.de>
 <9941f4d1-4eb2-4efb-0e24-09b28f2e185d@gmx.com>
From:   Johannes Kastl <kastl@b1-systems.de>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
In-Reply-To: <9941f4d1-4eb2-4efb-0e24-09b28f2e185d@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------baxY9zEHRINkQZw7orWf3had"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------baxY9zEHRINkQZw7orWf3had
Content-Type: multipart/mixed; boundary="------------tMp3OkT2UGqQPIy8XFnS2vG1";
 protected-headers="v1"
From: Johannes Kastl <kastl@b1-systems.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <88a253ee-4dfd-5e3f-8622-63321f7d6e35@b1-systems.de>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
 <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
 <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
 <e62b429d-358e-ec38-30ca-671d43a5b5be@gmx.com>
 <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>
 <ea73d6b6-4e91-438e-6f9a-7377bb461bc3@b1-systems.de>
 <9941f4d1-4eb2-4efb-0e24-09b28f2e185d@gmx.com>
In-Reply-To: <9941f4d1-4eb2-4efb-0e24-09b28f2e185d@gmx.com>

--------------tMp3OkT2UGqQPIy8XFnS2vG1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXUsDQoNCk9uIDIxLjA1LjIyIGF0IDAzOjEwIFF1IFdlbnJ1byB3cm90ZToNCg0KPiBB
dCBsZWFzdCB3ZSBrbm93IHRoZSBuZXcgd2F5IHRvIGZpeCBpdCBpcyB3b3JraW5nLg0KPiAN
Cj4gQlRXLCBtaW5kIHRvIHNoYXJlIHRoaW5ncyBsaWtlIGBidHJmcyBmaSB1c2FnZWAgYW5k
IGBidHJmcyBmaSBkZmAgd2hlbg0KPiB5b3UgY2FuIG1vdW50IHRoZSBmcz8NCg0KU3VyZSwg
aGVyZSB0aGV5IGFyZToNCg0KPj4gcm9vdCBkdW1ibzovcm9vdCAjIGJ0cmZzIGZpbGVzeXN0
ZW0gZGYgL21udC9EVU1CT19CQUNLVVBfNFRCDQo+PiBEYXRhLCBSQUlEMTogdG90YWw9My4z
NlRpQiwgdXNlZD0zLjI0VGlCDQo+PiBEYXRhLCBEVVA6IHRvdGFsPTEzLjUwTWlCLCB1c2Vk
PTIuODFNaUINCj4+IERhdGEsIHNpbmdsZTogdG90YWw9MS4wMEdpQiwgdXNlZD0wLjAwQg0K
Pj4gU3lzdGVtLCBSQUlEMTogdG90YWw9MzIuMDBNaUIsIHVzZWQ9NTYwLjAwS2lCDQo+PiBT
eXN0ZW0sIHNpbmdsZTogdG90YWw9MzIuMDBNaUIsIHVzZWQ9MC4wMEINCj4+IE1ldGFkYXRh
LCBSQUlEMTogdG90YWw9Mjg0Ljk0R2lCLCB1c2VkPTExMS44NEdpQg0KPj4gTWV0YWRhdGEs
IERVUDogdG90YWw9NTEyLjAwTWlCLCB1c2VkPTQ4LjAwS2lCDQo+PiBNZXRhZGF0YSwgc2lu
Z2xlOiB0b3RhbD0xLjAwR2lCLCB1c2VkPTAuMDBCDQo+PiBHbG9iYWxSZXNlcnZlLCBzaW5n
bGU6IHRvdGFsPTUxMi4wME1pQiwgdXNlZD0wLjAwQg0KID4+IHJvb3QgZHVtYm86L3Jvb3Qg
Iw0KDQo+PiByb290IGR1bWJvOi9yb290ICMgYnRyZnMgZmlsZXN5c3RlbSBzaG93IC9tbnQv
RFVNQk9fQkFDS1VQXzRUQg0KPj4gTGFiZWw6ICdEVU1CT19CQUNLVVBfNFRCJyAgdXVpZDog
NTA2NTFiNDEtYmYzMy00N2U3LThhMDgtYWZiYzcxYmEwYmY4DQo+PiAgICAgICAgIFRvdGFs
IGRldmljZXMgMiBGUyBieXRlcyB1c2VkIDMuMzVUaUINCj4+ICAgICAgICAgZGV2aWQgICAg
MSBzaXplIDcuMDBUaUIgdXNlZCAzLjY0VGlCIHBhdGggL2Rldi9zZGQxDQo+PiAgICAgICAg
IGRldmlkICAgIDIgc2l6ZSA3LjAwVGlCIHVzZWQgMy42M1RpQiBwYXRoIC9kZXYvc2RjMQ0K
Pj4NCj4+IHJvb3QgZHVtYm86L3Jvb3QgIw0KDQpOb3Qgc3VyZSB3aHkgb25lIG9mIHRoZSBk
ZXZpY2VzIGhhcyAzLjY0VGlCIHVzZWQsIHRoZSBvdGhlciBvbmUgMy42M1RpQi4NCg0KPj4g
cm9vdCBkdW1ibzovcm9vdCAjIGJ0cmZzIGZpbGVzeXN0ZW0gdXNhZ2UgL21udC9EVU1CT19C
QUNLVVBfNFRCDQo+PiBPdmVyYWxsOg0KPj4gICAgIERldmljZSBzaXplOiAgICAgICAgICAg
ICAgICAgIDE0LjAwVGlCDQo+PiAgICAgRGV2aWNlIGFsbG9jYXRlZDogICAgICAgICAgICAg
IDcuMjdUaUINCj4+ICAgICBEZXZpY2UgdW5hbGxvY2F0ZWQ6ICAgICAgICAgICAgNi43M1Rp
Qg0KPj4gICAgIERldmljZSBtaXNzaW5nOiAgICAgICAgICAgICAgICAgIDAuMDBCDQo+PiAg
ICAgVXNlZDogICAgICAgICAgICAgICAgICAgICAgICAgIDYuNjlUaUINCj4+ICAgICBGcmVl
IChlc3RpbWF0ZWQpOiAgICAgICAgICAgICAgMy40OFRpQiAgICAgIChtaW46IDMuNDhUaUIp
DQo+PiAgICAgRGF0YSByYXRpbzogICAgICAgICAgICAgICAgICAgICAgIDIuMDANCj4+ICAg
ICBNZXRhZGF0YSByYXRpbzogICAgICAgICAgICAgICAgICAgMi4wMA0KPj4gICAgIEdsb2Jh
bCByZXNlcnZlOiAgICAgICAgICAgICAgNTEyLjAwTWlCICAgICAgKHVzZWQ6IDAuMDBCKQ0K
Pj4NCj4+IERhdGEsc2luZ2xlOiBTaXplOjEuMDBHaUIsIFVzZWQ6MC4wMEINCj4+ICAgIC9k
ZXYvc2RkMSAgICAgICAxLjAwR2lCDQo+Pg0KPj4gRGF0YSxSQUlEMTogU2l6ZTozLjM2VGlC
LCBVc2VkOjMuMjRUaUINCj4+ICAgIC9kZXYvc2RjMSAgICAgICAzLjM2VGlCDQo+PiAgICAv
ZGV2L3NkZDEgICAgICAgMy4zNlRpQg0KPj4NCj4+IERhdGEsRFVQOiBTaXplOjEzLjUwTWlC
LCBVc2VkOjIuODFNaUINCj4+ICAgIC9kZXYvc2RkMSAgICAgIDI3LjAwTWlCDQo+Pg0KPj4g
TWV0YWRhdGEsc2luZ2xlOiBTaXplOjEuMDBHaUIsIFVzZWQ6MC4wMEINCj4+ICAgIC9kZXYv
c2RkMSAgICAgICAxLjAwR2lCDQo+Pg0KPj4gTWV0YWRhdGEsUkFJRDE6IFNpemU6Mjg0Ljk0
R2lCLCBVc2VkOjExMS44NEdpQg0KPj4gICAgL2Rldi9zZGMxICAgICAyODQuOTRHaUINCj4+
ICAgIC9kZXYvc2RkMSAgICAgMjg0Ljk0R2lCDQo+Pg0KPj4gTWV0YWRhdGEsRFVQOiBTaXpl
OjUxMi4wME1pQiwgVXNlZDo0OC4wMEtpQg0KPj4gICAgL2Rldi9zZGQxICAgICAgIDEuMDBH
aUINCj4+DQo+PiBTeXN0ZW0sc2luZ2xlOiBTaXplOjMyLjAwTWlCLCBVc2VkOjAuMDBCDQo+
PiAgICAvZGV2L3NkZDEgICAgICAzMi4wME1pQg0KPj4NCj4+IFN5c3RlbSxSQUlEMTogU2l6
ZTozMi4wME1pQiwgVXNlZDo1NjAuMDBLaUINCj4+ICAgIC9kZXYvc2RjMSAgICAgIDMyLjAw
TWlCDQo+PiAgICAvZGV2L3NkZDEgICAgICAzMi4wME1pQg0KPj4NCj4+IFVuYWxsb2NhdGVk
Og0KPj4gICAgL2Rldi9zZGMxICAgICAgIDMuMzZUaUINCj4+ICAgIC9kZXYvc2RkMSAgICAg
ICAzLjM2VGlCDQo+PiByb290IGR1bWJvOi9yb290ICMNCg0KDQoNCg0KDQotLSANCkpvaGFu
bmVzIEthc3RsDQpMaW51eCBDb25zdWx0YW50ICYgVHJhaW5lcg0KVGVsLjogKzQ5ICgwKSAx
NTEgMjM3MiA1ODAyDQpNYWlsOiBrYXN0bEBiMS1zeXN0ZW1zLmRlDQoNCkIxIFN5c3RlbXMg
R21iSA0KT3N0ZXJmZWxkc3RyYcOfZSA3IC8gODUwODggVm9oYnVyZw0KaHR0cDovL3d3dy5i
MS1zeXN0ZW1zLmRlDQpHRjogUmFscGggRGVobmVyDQpVbnRlcm5laG1lbnNzaXR6OiBWb2hi
dXJnIC8gQUc6IEluZ29sc3RhZHQsSFJCIDM1MzcNCg==

--------------tMp3OkT2UGqQPIy8XFnS2vG1--

--------------baxY9zEHRINkQZw7orWf3had
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOjtDOPXdIVAWcUziyeav2MG3z/wFAmKMjPMFAwAAAAAACgkQyeav2MG3z/wH
uA//Uj38XF2bY3xc1pDU3UThtgj3QNOuzYC+BTlwPkL7B4sB6xwD8UB9SwaBPtpK+Fx7ZH3MF/ZY
Msdsu6hxh2oszHbZfNkxI1r20+ElIgFj5dH3vCera9auM15nSGTMaPQnxJKoLgFUoVajL9xnXKfo
pb123VigsB1aOUIlHIGANXWEjuCfA4+y2/20iRbS1ql6aLJ3MyWqCZJAvffPTK5iBY+GT1WDmzNM
7PM1uNxnZMIVNKmhtxXsexrrpGTNhJgkWdk5xeXFbfLg18ye3ZYySRfUlsUXTPqL8g93EuqjFG4r
O37gtQQM1yYHVLFXtyNqNdtTIhWOPRQnoj5UY0gtx6XfgApQ2k3v2BPS6WK5SANqX5K/Sh6UoJ7Z
+kNnENMasVP4zuYCBjHtXMyFaX3wznPuu6p29uox3RmlJ4153LOgd1uMdN4qeKWF4yiNIFKzQorW
/oImbgWJ2Bup6OKLlFjW0nVApLVzjjmDqnPhb/Kf/MuAN0lSoFK/n12tM2NMPf5uhEfIMFf6JtC0
8nn+1aJAMm1tfTlMvLzssWPVpOkVNdFVC7726Ehg/lG0DzPeEGOxc8ZfGhaKbuuUfZuWac4tG+3D
8pUWDbwPBWizZYkbV+MYo0jiv8wroQcsOBRcCXtwO60KCGs0JXdEQPjuT/hYVhhgdXyKL6WAhedP
XXc=
=hjJH
-----END PGP SIGNATURE-----

--------------baxY9zEHRINkQZw7orWf3had--
