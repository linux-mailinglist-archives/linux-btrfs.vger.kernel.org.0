Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74EB6B7825
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCMM5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCMM5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 08:57:07 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 05:57:04 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE569228
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 05:57:03 -0700 (PDT)
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
        by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4PZxJm6dHWz8YLk
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 12:47:52 +0000 (UTC)
Authentication-Results: mors-relay8204.netcup.net; dkim=permerror (bad message/signature format)
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4PZxJm5w3Kz8YLS
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 12:47:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from mxe217.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4PZxJl2lxDz8t3q
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:47:51 +0100 (CET)
Received: from [10.0.77.4] (wireguard.unfug.hs-furtwangen.de [141.28.77.251])
        by mxe217.netcup.net (Postfix) with ESMTPSA id 0E276808C6
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:47:47 +0100 (CET)
Message-ID: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
Date:   Mon, 13 Mar 2023 13:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   4censord <mail@4censord.de>
Subject: Corruption with hibernation and other file system access.
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------A1KJV90E5Gi9GmSc8QicqLps"
X-Rspamd-Queue-Id: 0E276808C6
X-Spamd-Result: default: False [-6.50 / 15.00];
        BAYES_HAM(-5.50)[100.00%];
        SIGNED_PGP(-2.00)[];
        MIME_BASE64_TEXT_BOGUS(1.00)[];
        MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
        MIME_BASE64_TEXT(0.10)[];
        MIME_UNKNOWN(0.10)[application/pgp-keys];
        RCVD_COUNT_ZERO(0.00)[0];
        MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
        ASN(0.00)[asn:553, ipnet:141.28.0.0/16, country:DE];
        FROM_EQ_ENVFROM(0.00)[];
        HAS_ATTACHMENT(0.00)[];
        TO_DN_NONE(0.00)[];
        RCPT_COUNT_ONE(0.00)[1];
        FROM_HAS_DN(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        ARC_NA(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: kKQDU+PDzwcWLWre5olPHQlEQOKWbOX7qfrf7R0cbXHb/J6Y+qu7uov9
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------A1KJV90E5Gi9GmSc8QicqLps
Content-Type: multipart/mixed; boundary="------------2fVuZot2KpOYGst05covYbk0";
 protected-headers="v1"
From: 4censord <mail@4censord.de>
To: linux-btrfs@vger.kernel.org
Message-ID: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
Subject: Corruption with hibernation and other file system access.

--------------2fVuZot2KpOYGst05covYbk0
Content-Type: multipart/mixed; boundary="------------Z0PKqS0YSRMoxkY2CAz1XcC6"

--------------Z0PKqS0YSRMoxkY2CAz1XcC6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

TGV0IG1lIHByZWZhY2UgdGhpczoNCg0KSSB3aWxsIG5vdCBiZSBsb3NpbmcgYW55IGRhdGEg
aWYgdGhpcyBpc24ndCBmaXhhYmxlLiBNeSBiYWNrdXBzIGFyZQ0KdXAtdG8tZGF0ZSBhbmQg
d29ya2luZywgaXRzIGp1c3QgaW5jb252ZW5pZW50IGhhdmluZyB0byByZXN0b3JlLg0KDQpJ
IGFtIGN1cnJlbnRseSB3b3JraW5nIG9uIGEgYmluYXJ5IGNvcHkgb2YgdGhlIGZpbGUgc3lz
dGVtLCBhcyB0aGUNCm9yaWdpbmFsIGlzIGluIGEgbGFwdG9wIGFuZCB0aGF0IGlzIGluY29u
dmVuaWVudC4NCg0KSG93IHRoZSBjb3JydXB0aW9uIG1hbmlmZXN0czoNCg0KJCBzdWRvIG1v
dW50IC9kZXYvc2RjIC9tZWRpYS8NCg0KbW91bnQ6IC9tZWRpYTogd3JvbmcgZnMgdHlwZSwg
YmFkIG9wdGlvbiwgYmFkIHN1cGVyYmxvY2sgb24gL2Rldi9zZGMsIG1pc3NpbmcgY29kZXBh
Z2Ugb3IgaGVscGVyIHByb2dyYW0sIG9yIG90aGVyIGVycm9yLg0KICAgICAgICBkbWVzZygx
KSBtYXkgaGF2ZSBtb3JlIGluZm9ybWF0aW9uIGFmdGVyIGZhaWxlZCBtb3VudCBzeXN0ZW0g
Y2FsbC4NCg0KV2l0aCBtYXRjaGluZyBlcnJvcnMgaW4gZG1lc2c6DQoNCls0NzQ1Mi42MDAz
NDBdIEJUUkZTOiBkZXZpY2UgZnNpZCA1M2VmZjllZC01NGU4LTQ3YzEtOGEzZi0xOWNhN2Rh
M2IyZDAgZGV2aWQgMSB0cmFuc2lkIDE4OTE1MTMgL2Rldi9zZGMgc2Nhbm5lZCBieSBtb3Vu
dCAoMzMyNTYpDQpbNDc0NTMuNjU0MjU2XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RjKTogdXNp
bmcgY3JjMzJjIChjcmMzMmMtaW50ZWwpIGNoZWNrc3VtIGFsZ29yaXRobQ0KWzQ3NDUzLjY1
NDI2OF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYyk6IGRpc2sgc3BhY2UgY2FjaGluZyBpcyBl
bmFibGVkDQpbNDc0NTMuNzAyMzgzXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IGxldmVs
IHZlcmlmeSBmYWlsZWQgb24gbG9naWNhbCAyNDM2MDUzNzYyMDQ4IG1pcnJvciAxIHdhbnRl
ZCAxIGZvdW5kIDANCls0NzQ1My43MDIzOTldIEJUUkZTIHdhcm5pbmcgKGRldmljZSBzZGMp
OiBmYWlsZWQgdG8gcmVhZCByb290IChvYmplY3RpZD00KTogLTUNCls0NzQ1My43MDQyNzNd
IEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQNCg0KDQokIGJ0
cmZzIGNoZWNrIC9kZXYvc2RjDQoNCk9wZW5pbmcgZmlsZXN5c3RlbSB0byBjaGVjay4uLg0K
cGFyZW50IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiAyNDM2MDUzNzYyMDQ4IHdhbnRlZCAx
ODkxMTE1IGZvdW5kIDE4OTE0NjUNCnBhcmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24g
MjQzNjA1Mzc2MjA0OCB3YW50ZWQgMTg5MTExNSBmb3VuZCAxODkxNDY1DQpJZ25vcmluZyB0
cmFuc2lkIGZhaWx1cmUNCkVSUk9SOiByb290IFs0IDBdIGxldmVsIDAgZG9lcyBub3QgbWF0
Y2ggMQ0KDQpDb3VsZG4ndCBzZXR1cCBkZXZpY2UgdHJlZQ0KRVJST1I6IGNhbm5vdCBvcGVu
IGZpbGUgc3lzdGVtDQoNCg0KJCBidHJmcyByZXN0b3JlIC9kZXYvc2RjICRwYXRoDQoNCnBh
cmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gMjQzNjA1Mzc2MjA0OCB3YW50ZWQgMTg5
MTExNSBmb3VuZCAxODkxNDY1DQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFpbGVkIG9uIDI0
MzYwNTM3NjIwNDggd2FudGVkIDE4OTExMTUgZm91bmQgMTg5MTQ2NQ0KSWdub3JpbmcgdHJh
bnNpZCBmYWlsdXJlDQpFUlJPUjogcm9vdCBbNCAwXSBsZXZlbCAwIGRvZXMgbm90IG1hdGNo
IDENCg0KQ291bGRuJ3Qgc2V0dXAgZGV2aWNlIHRyZWUNCkNvdWxkIG5vdCBvcGVuIHJvb3Qs
IHRyeWluZyBiYWNrdXAgc3VwZXINCnBhcmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24g
MjQzNjA1Mzc2MjA0OCB3YW50ZWQgMTg5MTExNSBmb3VuZCAxODkxNDY1DQpwYXJlbnQgdHJh
bnNpZCB2ZXJpZnkgZmFpbGVkIG9uIDI0MzYwNTM3NjIwNDggd2FudGVkIDE4OTExMTUgZm91
bmQgMTg5MTQ2NQ0KSWdub3JpbmcgdHJhbnNpZCBmYWlsdXJlDQpFUlJPUjogcm9vdCBbNCAw
XSBsZXZlbCAwIGRvZXMgbm90IG1hdGNoIDENCg0KQ291bGRuJ3Qgc2V0dXAgZGV2aWNlIHRy
ZWUNCkNvdWxkIG5vdCBvcGVuIHJvb3QsIHRyeWluZyBiYWNrdXAgc3VwZXINCnBhcmVudCB0
cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gMjQzNjA1Mzc2MjA0OCB3YW50ZWQgMTg5MTExNSBm
b3VuZCAxODkxNDY1DQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFpbGVkIG9uIDI0MzYwNTM3
NjIwNDggd2FudGVkIDE4OTExMTUgZm91bmQgMTg5MTQ2NQ0KSWdub3JpbmcgdHJhbnNpZCBm
YWlsdXJlDQpFUlJPUjogcm9vdCBbNCAwXSBsZXZlbCAwIGRvZXMgbm90IG1hdGNoIDENCg0K
Q291bGRuJ3Qgc2V0dXAgZGV2aWNlIHRyZWUNCkNvdWxkIG5vdCBvcGVuIHJvb3QsIHRyeWlu
ZyBiYWNrdXAgc3VwZXINCg0KDQokIGJ0cmZzLWZpbmQtcm9vdCAvZGV2L3NkYw0KDQpwYXJl
bnQgdHJhbnNpZCB2ZXJpZnkgZmFpbGVkIG9uIDI0MzYwNTM3NjIwNDggd2FudGVkIDE4OTEx
MTUgZm91bmQgMTg5MTQ2NQ0KQ291bGRuJ3Qgc2V0dXAgZGV2aWNlIHRyZWUNClN1cGVyYmxv
Y2sgdGhpbmtzIHRoZSBnZW5lcmF0aW9uIGlzIDE4OTE1MTMNClN1cGVyYmxvY2sgdGhpbmtz
IHRoZSBsZXZlbCBpcyAxDQpGb3VuZCB0cmVlIHJvb3QgYXQgMjQzNjgwNTgzNjgwMCBnZW4g
MTg5MTUxMyBsZXZlbCAxDQpXZWxsIGJsb2NrIDI0MzY3NzYxOTgxNDQoZ2VuOiAxODkxNTEy
IGxldmVsOiAxKSBzZWVtcyBnb29kLCBidXQgZ2VuZXJhdGlvbi9sZXZlbCBkb2Vzbid0IG1h
dGNoLCB3YW50IGdlbjogMTg5MTUxMyBsZXZlbDogMQ0KV2VsbCBibG9jayAyNDM2NzUzNTU1
NDU2KGdlbjogMTg5MTUxMSBsZXZlbDogMSkgc2VlbXMgZ29vZCwgYnV0IGdlbmVyYXRpb24v
bGV2ZWwgZG9lc24ndCBtYXRjaCwgd2FudCBnZW46IDE4OTE1MTMgbGV2ZWw6IDENCldlbGwg
YmxvY2sgMjQzNjcyMjc2OTkyMChnZW46IDE4OTE1MTAgbGV2ZWw6IDApIHNlZW1zIGdvb2Qs
IGJ1dCBnZW5lcmF0aW9uL2xldmVsIGRvZXNuJ3QgbWF0Y2gsIHdhbnQgZ2VuOiAxODkxNTEz
IGxldmVsOiAxDQpXZWxsIGJsb2NrIDI0MzY3MjI3NTM1MzYoZ2VuOiAxODkxNTEwIGxldmVs
OiAwKSBzZWVtcyBnb29kLCBidXQgZ2VuZXJhdGlvbi9sZXZlbCBkb2Vzbid0IG1hdGNoLCB3
YW50IGdlbjogMTg5MTUxMyBsZXZlbDogMQ0KV2VsbCBibG9jayAyNDM2NzIyNzM3MTUyKGdl
bjogMTg5MTUxMCBsZXZlbDogMCkgc2VlbXMgZ29vZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwg
ZG9lc24ndCBtYXRjaCwgd2FudCBnZW46IDE4OTE1MTMgbGV2ZWw6IDENCldlbGwgYmxvY2sg
MjQzNjcxODI0NzkzNihnZW46IDE4OTE1MTAgbGV2ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBn
ZW5lcmF0aW9uL2xldmVsIGRvZXNuJ3QgbWF0Y2gsIHdhbnQgZ2VuOiAxODkxNTEzIGxldmVs
OiAxDQpXZWxsIGJsb2NrIDI0MzY3MTgyMzE1NTIoZ2VuOiAxODkxNTEwIGxldmVsOiAwKSBz
ZWVtcyBnb29kLCBidXQgZ2VuZXJhdGlvbi9sZXZlbCBkb2Vzbid0IG1hdGNoLCB3YW50IGdl
bjogMTg5MTUxMyBsZXZlbDogMQ0KV2VsbCBibG9jayAyNDM2NzE3Mjk3NjY0KGdlbjogMTg5
MTUxMCBsZXZlbDogMCkgc2VlbXMgZ29vZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwgZG9lc24n
dCBtYXRjaCwgd2FudCBnZW46IDE4OTE1MTMgbGV2ZWw6IDENCldlbGwgYmxvY2sgMjQzNjcx
Mzc3NTEwNChnZW46IDE4OTE1MTAgbGV2ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0
aW9uL2xldmVsIGRvZXNuJ3QgbWF0Y2gsIHdhbnQgZ2VuOiAxODkxNTEzIGxldmVsOiAxDQpX
ZWxsIGJsb2NrIDI0MzY3MTM0OTY1NzYoZ2VuOiAxODkxNTEwIGxldmVsOiAwKSBzZWVtcyBn
b29kLCBidXQgZ2VuZXJhdGlvbi9sZXZlbCBkb2Vzbid0IG1hdGNoLCB3YW50IGdlbjogMTg5
MTUxMyBsZXZlbDogMQ0KV2VsbCBibG9jayAyNDM2NDgxNDk5MTM2KGdlbjogMTg5MTUwOCBs
ZXZlbDogMSkgc2VlbXMgZ29vZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwgZG9lc24ndCBtYXRj
aCwgd2FudCBnZW46IDE4OTE1MTMgbGV2ZWw6IDENCldlbGwgYmxvY2sgMjQzNjA2MjI4MTcy
OChnZW46IDE4OTE1MDcgbGV2ZWw6IDEpIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0aW9uL2xl
dmVsIGRvZXNuJ3QgbWF0Y2gsIHdhbnQgZ2VuOiAxODkxNTEzIGxldmVsOiAxDQpXZWxsIGJs
b2NrIDI0MzYwOTcwMzIxOTIoZ2VuOiAxODkxNTA2IGxldmVsOiAxKSBzZWVtcyBnb29kLCBi
dXQgZ2VuZXJhdGlvbi9sZXZlbCBkb2Vzbid0IG1hdGNoLCB3YW50IGdlbjogMTg5MTUxMyBs
ZXZlbDogMQ0KV2VsbCBibG9jayAyNDM2MDgxOTI2MTQ0KGdlbjogMTg5MTUwNSBsZXZlbDog
MCkgc2VlbXMgZ29vZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwgZG9lc24ndCBtYXRjaCwgd2Fu
dCBnZW46IDE4OTE1MTMgbGV2ZWw6IDENCldlbGwgYmxvY2sgMjQzNjA2MzkwMzc0NChnZW46
IDE4OTE1MDUgbGV2ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0aW9uL2xldmVsIGRv
ZXNuJ3QgbWF0Y2gsIHdhbnQgZ2VuOiAxODkxNTEzIGxldmVsOiAxDQpXZWxsIGJsb2NrIDI0
MzYwNjI2OTEzMjgoZ2VuOiAxODkxNTA1IGxldmVsOiAwKSBzZWVtcyBnb29kLCBidXQgZ2Vu
ZXJhdGlvbi9sZXZlbCBkb2Vzbid0IG1hdGNoLCB3YW50IGdlbjogMTg5MTUxMyBsZXZlbDog
MQ0KV2VsbCBibG9jayAyNDM1OTczNDMxMjk2KGdlbjogMTg5MTUwMyBsZXZlbDogMCkgc2Vl
bXMgZ29vZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwgZG9lc24ndCBtYXRjaCwgd2FudCBnZW46
IDE4OTE1MTMgbGV2ZWw6IDENCldlbGwgYmxvY2sgMjQzNTk3MzM4MjE0NChnZW46IDE4OTE1
MDMgbGV2ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0aW9uL2xldmVsIGRvZXNuJ3Qg
bWF0Y2gsIHdhbnQgZ2VuOiAxODkxNTEzIGxldmVsOiAxDQpXZWxsIGJsb2NrIDI0MzU5NzMz
NjU3NjAoZ2VuOiAxODkxNTAzIGxldmVsOiAwKSBzZWVtcyBnb29kLCBidXQgZ2VuZXJhdGlv
bi9sZXZlbCBkb2Vzbid0IG1hdGNoLCB3YW50IGdlbjogMTg5MTUxMyBsZXZlbDogMQ0KV2Vs
bCBibG9jayAyNDM1OTczMzE2NjA4KGdlbjogMTg5MTUwMyBsZXZlbDogMCkgc2VlbXMgZ29v
ZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwgZG9lc24ndCBtYXRjaCwgd2FudCBnZW46IDE4OTE1
MTMgbGV2ZWw6IDENCldlbGwgYmxvY2sgMjQzNTk3MzA3MDg0OChnZW46IDE4OTE1MDMgbGV2
ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0aW9uL2xldmVsIGRvZXNuJ3QgbWF0Y2gs
IHdhbnQgZ2VuOiAxODkxNTEzIGxldmVsOiAxDQpXZWxsIGJsb2NrIDI0MzU5NzI5MDcwMDgo
Z2VuOiAxODkxNTAzIGxldmVsOiAwKSBzZWVtcyBnb29kLCBidXQgZ2VuZXJhdGlvbi9sZXZl
bCBkb2Vzbid0IG1hdGNoLCB3YW50IGdlbjogMTg5MTUxMyBsZXZlbDogMQ0KDQoNCkFzIGZv
ciBob3cgaSB0aGluayB0aGUgY29ycnVwdGlvbiBoYXBwZW5lZDoNCg0KVGhpcyBpcyB0aGUg
cm9vdGZzIGZyb20gYSBsYXB0b3AuIEJ0cmZzIGluIGEgbHVrcyBjb250YWluZXIgb24gYSBu
b3JtYWwgcGFydGl0aW9uLg0KT25seSBvdGhlciB0aGluZyBvbiB0aGlzIGRpc2sgaXMgYSBl
ZmkgcGFydGl0aW9uLg0KDQpUaGUgc3lzdGVtIHdhcyBpbiBoaWJlcm5hdGlvbiB3aGlsZSBz
b21lIG1haW50ZW5hbmNlIHRvb2sgcGxhY2UuDQoNClRoZSBzeXN0ZW0gd2FzIGJvb3RlZCB2
aWEgYW4gZXh0ZXJuYWwgbWVkaXVtIHRvIG1ha2Ugc29tZSBjaGFuZ2VzIHRvIHRoZQ0KYm9v
dGxvYWRlci4gRm9yIHRoaXMsIHRoZSByb290ZnMgaGFkIGJlZW4gbW91bnRlZCBydywgYnV0
IG5vIG1heW9yDQpjaGFuZ2VzIHRvb2sgcGxhY2UuIE1vc3Qgd3JpdGVzIHNob3VsZCBoYXZl
IGJlZW4gb24gYSBzZXBhcmF0ZSBFRkkgcGFydGl0aW9uLg0KDQpBZnRlciB0aGlzIHdhcyBj
b21wbGV0ZWQgdGhlIHN5c3RlbSB3YXMgcmVib290ZWQgYW5kIHJlc3VtZWQgZnJvbSBoaWJl
cm5hdGlvbi4NCg0KSSBhc3N1bWUgdGhhdCBhdCB0aGlzIHBvaW50IHRoZSBjb3JydXB0aW9u
IGhhcHBlbmVkLCB3aGVuIGVpdGhlcg0KKiBzb21lIHdyaXRlIHRoYXQgd2FzIHN0aWxsIGlu
IG1lbW9yeSB3YXMgY29tbWl0dGVkIHRvIGRpc2sNCiogVGhlIHN5c3RlbSBjb250aW51ZWQg
d29ya2luZyB3aXRoIHNvbWUgaW5kZXgvbWV0YWRhdGEgdGhhdCBubyBsb25nZXINCiAgIG1h
dGNoZWQgd2hhdCB3YXMgcHJlc2VudCBvbiBkaXNrDQoNCg0KSSB0aGVyZSBtYXkgYmUgc29t
ZSBsb2dzIGFib3V0IHRoaXMgb24gdGhlIGJyb2tlbiBmaWxlc3lzdGVtLg0KDQpJIGhhdmUg
ZG9uZSBiYXNpYyBjaGVjayBmb3IgZGlzayBoZWFsdGgsIGFuZCBuZWl0aGVyICdzbWFydGN0
bCcgbm9yDQpgbnZtZSBlcnJvci1sb2dgIHNob3cgc2lnbnMgb2YgZGlzayBmYWlsdXJlLg0K
DQoNClZlcnNpb24gaW5mb3JtYXRpb24gYXMgcmVxdWVzdGVkIG9uIHRoZSB3aWtpOg0KDQpU
aGlzIGlzIG15IGN1cnJlbnQgc3lzdGVtLCBub3QgdGhlIGJyb2tlbiBvbmUuIFZlcnNpb25z
IHNob3VsZCBoYXZlIGJlZW4NCnNpbWlsYXIsIHdpdGhpbiBhdCBtb3N0IDIgV2Vla3Mgb2Yg
ZGV2aWF0aW9uLg0KDQokIHVuYW1lIC1hDQoNCkxpbnV4IHRoZWFyY2ggNi4yLjItYXJjaDEt
MSAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSwgMDMgTWFyIDIwMjMgMTU6NTg6MzEgKzAw
MDAgeDg2XzY0IEdOVS9MaW51eA0KDQoNCiQgYnRyZnMgLS12ZXJzaW9uDQoNCmJ0cmZzLXBy
b2dzIHY2LjEuMw0KDQoNCiQgYnRyZnMgZmkgc2hvdw0KDQpMYWJlbDogJ252bWUtMXRiLTAx
JyAgdXVpZDogMjIzMzNiZjctYzkwNy00Y2FmLTljNmYtNTJjOWMyYzY0NWIzDQogICAgIFRv
dGFsIGRldmljZXMgMSBGUyBieXRlcyB1c2VkIDM4Ny44NUdpQg0KICAgICBkZXZpZCAgICAx
IHNpemUgOTMxLjUxR2lCIHVzZWQgMzk0LjAzR2lCIHBhdGggL2Rldi9udm1lMG4xcDENCg0K
TGFiZWw6ICdleG9zLTE4dGItMDEnICB1dWlkOiA2YjhiYjY5OC1kZjJhLTRmMjUtODQxMS0y
ZmZhM2ZmMzljYzcNCiAgICAgVG90YWwgZGV2aWNlcyAyIEZTIGJ5dGVzIHVzZWQgMTEuMzFU
aUINCiAgICAgZGV2aWQgICAgMSBzaXplIDE2LjM3VGlCIHVzZWQgMTEuMzhUaUIgcGF0aCAv
ZGV2L3NkYg0KICAgICBkZXZpZCAgICAyIHNpemUgMTYuMzdUaUIgdXNlZCAxMS4zOFRpQiBw
YXRoIC9kZXYvc2RhDQoNCkxhYmVsOiAnY3J5cHRyb290JyAgdXVpZDogYmQ2OWI2ZTYtMDQy
Ni00ODM0LTlmNDktMjNhODBlNzYwOWM3DQogICAgIFRvdGFsIGRldmljZXMgMSBGUyBieXRl
cyB1c2VkIDEuMTRUaUINCiAgICAgZGV2aWQgICAgMSBzaXplIDEuNzVUaUIgdXNlZCAxLjU1
VGlCIHBhdGggL2Rldi9tYXBwZXIvY3J5cHRyb290DQoNCkxhYmVsOiBub25lICB1dWlkOiA1
M2VmZjllZC01NGU4LTQ3YzEtOGEzZi0xOWNhN2RhM2IyZDANCiAgICAgVG90YWwgZGV2aWNl
cyAxIEZTIGJ5dGVzIHVzZWQgMS4yNFRpQg0KICAgICBkZXZpZCAgICAxIHNpemUgMS43NVRp
QiB1c2VkIDEuMzBUaUIgcGF0aCAvZGV2L3NkYw0KDQpUaGUgZmlsZXN5c3RlbSB0aGlzIGlz
IGFib3V0IGlzIGF0IC9kZXYvc2RjLCB1dWlkOiA1M2VmZjllZC01NGU4LTQ3YzEtOGEzZi0x
OWNhN2RhM2IyZDANCg0KDQokIGJ0cmZzIGZpIGRmICMgUmVwbGFjZSAvaG9tZSB3aXRoIHRo
ZSBtb3VudCBwb2ludCBvZiB5b3VyIGJ0cmZzLWZpbGVzeXN0ZW0NCg0KRmlsZXN5c3RlbSBp
cyBub3QgbW91bnRhYmxlLg0KDQokIGRtZXNnID4gZG1lc2cubG9nDQoNCkxvZ3MgZnJvbSB0
aGUgZXZlbnQgaXRzZWxmIGFyZSBvbiB0aGUgYnJva2VuIGZpbGVzeXN0ZW0uDQpBcyBmb3Ig
dGhlIGN1cnJlbnQgZGV2aWNlLCBJIGhhdmUgaW5jbHVkZWQgZXhjZXJwdHMgYXMgYXBwcm9w
cmlhdGUNCg0K
--------------Z0PKqS0YSRMoxkY2CAz1XcC6
Content-Type: application/pgp-keys; name="OpenPGP_0xC8E54F9D13822E41.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC8E54F9D13822E41.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
JccEarFwGBAe14QkEqsqGQGKIwqE
=3DXDSM
-----END PGP PUBLIC KEY BLOCK-----

--------------Z0PKqS0YSRMoxkY2CAz1XcC6--

--------------2fVuZot2KpOYGst05covYbk0--

--------------A1KJV90E5Gi9GmSc8QicqLps
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEErmmOPvRONHTVJIQYyOVPnROCLkEFAmQPG3IACgkQyOVPnROC
LkGpLQv/SdEYYt077XFtnLGFvrV1rNmcPA3Ib+gza7WcnAuloJU5UAQgoQeVQaPa
a5CehxDU8sGzV7GbA2igMRa08HLWCn7MfelgLU9x/h0vLhYaYiLq/Dm858UVCcs8
X2lxPt0eyaorufCuU+6L0gHSxJilbSLtYZ4HqhuGOgvWtT9X7AIOpZkNNNeex1nw
9yaKLKbiQH19stWW/fAsXo6GY/OAQ6mRYaxr83rizdaglrJCEPBK/YwgjMaWMcoa
ZwWApfpEvEmFkkiLaupll8hvApETbJBI34PLRl4CfDClQ2b9VH2ljyiKzqVVWOrI
wY6O79Qs0fH6Aet4JEx46ozDX9xuNvXucKiIg3yx4rgPozSe73drQCW/zkhzER5C
McWmJXM9Aebf8ZWMHpgsUSViT9wX5YkcjubmdLcsjFOHouRzmR4X+Tb9zX4UNg1H
RsO+nynVImg14TMecEmyKP4MnyhEoUm4vk5GBjf7GHhx7EOvmUk98MbNGAoV8eEh
2xG99YfC
=rGw1
-----END PGP SIGNATURE-----

--------------A1KJV90E5Gi9GmSc8QicqLps--
