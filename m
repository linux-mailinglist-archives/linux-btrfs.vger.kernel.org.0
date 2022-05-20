Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31A352F454
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 22:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353434AbiETUVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352457AbiETUVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 16:21:35 -0400
Received: from mx2.b1-systems.de (mx2.b1-systems.de [159.69.135.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84414AF4A
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 13:21:33 -0700 (PDT)
Message-ID: <ea73d6b6-4e91-438e-6f9a-7377bb461bc3@b1-systems.de>
Date:   Fri, 20 May 2022 22:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: de-DE
From:   Johannes Kastl <kastl@b1-systems.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
 <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
 <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
 <e62b429d-358e-ec38-30ca-671d43a5b5be@gmx.com>
 <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
In-Reply-To: <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5CJKy0THMuG04J62Fg1l0mzB"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5CJKy0THMuG04J62Fg1l0mzB
Content-Type: multipart/mixed; boundary="------------0MdOX3GQsSGXYagQ39gDidy5";
 protected-headers="v1"
From: Johannes Kastl <kastl@b1-systems.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <ea73d6b6-4e91-438e-6f9a-7377bb461bc3@b1-systems.de>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
 <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
 <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
 <e62b429d-358e-ec38-30ca-671d43a5b5be@gmx.com>
 <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>
In-Reply-To: <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>

--------------0MdOX3GQsSGXYagQ39gDidy5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gUXUsDQoNCk9uIDIwLjA1LjIyIGF0IDE3OjE0IEpvaGFubmVzIEthc3RsIHdyb3Rl
Og0KDQo+IEkgYW0gdHJ5aW5nIHRvIGJ1aWxkIHRoaXMgYW5kIHdpbGwgdGVzdCBpdCwgaG9w
ZWZ1bGx5IHRvbW9ycm93LiBJJ2xsIGxldCB5b3UgDQo+IGtub3cgd2hhdCBoYXBwZW5zLi4u
DQoNCkkgd2FzIGFibGUgdG8gYnVpbGQgYW4gUlBNIGZvciBMZWFwIDE1LjMsIGJhc2VkIG9u
IHlvdXIgYnJhbmNoLg0KDQo+IGh0dHBzOi8vYnVpbGQub3BlbnN1c2Uub3JnL3Byb2plY3Qv
c2hvdy9ob21lOm9qa2FzdGxfYnVpbGRzZXJ2aWNlOmJ0cmZzX2RlYnVnZ2luZw0KDQpJIGlu
c3RhbGxlZCBpdCBvbiBteSBMZWFwIDE1LjMgc3lzdGVtLCBzdGFydGVkIHRoZSBmaXgtZGV2
aWNlLXNpemUgYW5kLi4uIGFmdGVyIA0Kb25seSBhIGNvdXBsZSBvZiBzZWNvbmRzIGl0IHdh
cyBkb25lLg0KDQpObyBlcnJvcnMsIGp1c3Qgb25lIGxpbmUgc2F5aW5nIHRoYXQgaXQgZml4
ZWQgc29tZXRoaW5nLg0KDQpJIGNvdWxkIG1vdW50IHRoZSBmaWxlc3lzdGVtIGRpcmVjdGx5
IGFmdGVyd2FyZHMuDQoNCkkgdW5tb3VudGVkIGFuZCBhbSBjdXJyZW50bHkgcnVubmluZyBh
IGJ0cmZzY2hlY2sgb24gdGhlIGZpbGVzeXN0ZW0sIGJhc2VkIG9uIA0KdGhlIGNvZGUgZnJv
bSB5b3VyIGJyYW5jaC4gSSBob3BlIHRoZSBmaWxlc3lzdGVtIGlzIHdvcmtpbmcgYWdhaW4s
IGFuZCBJIGNhbiANCnN0YXJ0IHVzaW5nIGl0IGFnYWluICh0b21vcnJvdywgdGhlIGNoZWNr
IHdpbGwgdGFrZSB+OCBob3VycykuLi4NCg0KSSBkb3VidCB0aGF0IHRoaXMgd2lsbCBnaXZl
IHZhbHVhYmxlIGlucHV0IHRvIGZpeCB0aGlzIGVycm9yIGluIGJ0cmZzcHJvZ3MuLi4NCg0K
S2luZCBSZWdhcmRzLA0KSm9oYW5uZXMNCg0KLS0gDQpKb2hhbm5lcyBLYXN0bA0KTGludXgg
Q29uc3VsdGFudCAmIFRyYWluZXINClRlbC46ICs0OSAoMCkgMTUxIDIzNzIgNTgwMg0KTWFp
bDoga2FzdGxAYjEtc3lzdGVtcy5kZQ0KDQpCMSBTeXN0ZW1zIEdtYkgNCk9zdGVyZmVsZHN0
cmHDn2UgNyAvIDg1MDg4IFZvaGJ1cmcNCmh0dHA6Ly93d3cuYjEtc3lzdGVtcy5kZQ0KR0Y6
IFJhbHBoIERlaG5lcg0KVW50ZXJuZWhtZW5zc2l0ejogVm9oYnVyZyAvIEFHOiBJbmdvbHN0
YWR0LEhSQiAzNTM3DQo=

--------------0MdOX3GQsSGXYagQ39gDidy5--

--------------5CJKy0THMuG04J62Fg1l0mzB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOjtDOPXdIVAWcUziyeav2MG3z/wFAmKH+EgFAwAAAAAACgkQyeav2MG3z/yI
2A//aUFjGbRiJYSvwcNZTHYko1GZf0N0NiEsLU/3ub8BbVXmMKupxqLhV5M84EZ6CK3IDNmm6CPj
vjwU5oOUaC8IR1R3yCGUyLFUhXDVEZCfuLuhARjQhMGswYFwMxY+u4+NCnkKGLSSIfd9VyvOTRNT
O+T7D4ENlwYARsRXwutrKJgLq+szuLjG8nwdSJ+ab2bn8hyZV0ZT8g+4mvwJm6pWb4EEYCWNZuYx
FlubSvApSZoDa9nSfHFhx7C/za+8ljYTHS9IdD0g9tBdWROM4qOwUiKWWgToGByNG7byQcP3n3ZG
FDE0e4q5DaYiqukLtBgRLy2INlrzlV/jbY3C7e80kuipvjT0ng6GPJaCGl/AKRxIIOd5vNwvoqXc
8o/QXaNcNcEnyxYOObrrxAfw3eJ9bbkY69eX88DORSWPxR38RiDKsPvw8vs/1mimyZydG/KLkYrx
1ZzLbZ2Fj/SqS/r22WcSltoFU046MUoh49eX5Ok+aYwHgkReeVbg/otUTMIKs0vLKNkLYAVkWwhY
UZ2upMqZzyZQtbewEBgrYua5u3Pr+nt02/G8Q45tfGelu47ooYZ6ngRls0CHO5rVUBJkZE6exHmZ
zL/89dOoth96KfrqaXxVcDv8Aa4e8E2++pD8M3oc4bMpEzpKdKDQeRBaiu93KzMAp0giTUcGBDYT
x2I=
=Hwoa
-----END PGP SIGNATURE-----

--------------5CJKy0THMuG04J62Fg1l0mzB--
