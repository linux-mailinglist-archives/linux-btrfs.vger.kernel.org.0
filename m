Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C61490EA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 18:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiAQRLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 12:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbiAQRI0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 12:08:26 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F026C06176C
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 09:04:52 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Jcyv55TJ0zQklh;
        Mon, 17 Jan 2022 18:04:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1642439087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsmdrnwpVmGmL/sVHfQIf8Z0to3OL1n2yu3FcbQYQUM=;
        b=sKHIpErN36fZcF7lBp4GcVIF1dHjJ3c62ZcPXK24FQTGlIr09fXmghKkl/ZOiywEcLF16D
        4HYexOJ3XvSd66uaht9zqT0+BcbH3ioFmjL74gLO7ETQ4eVyFWLjYKrhOSywW07AVsWDaQ
        29Ldw0wOZZulv/XN9kErpLaE6MQEI4Bm/c1X9o7J+xvQy1BPcq8sAiDnHYcOasr+fOx8mJ
        STsP6bV014BAsyKfm6b/zKCPasgrSVxSnfx7WJN9ff8o/RezEMONkPdWVWXZypO6jAG5qd
        IRjFv/ZQ4+Qhlkz/VW2PxdnR1kF82ERt5283fGJaG4OawiVzie2NiW1impw+ng==
Message-ID: <254c8e30-6692-3f3c-59ea-e3456ca9a266@mailbox.org>
Date:   Mon, 17 Jan 2022 18:04:40 +0100
MIME-Version: 1.0
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
 <YeVc0r7lLtns0Bch@debian9.Home>
 <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
 <YeWetp7/1q/4bU1O@debian9.Home>
From:   Anthony Ruhier <aruhier@mailbox.org>
In-Reply-To: <YeWetp7/1q/4bU1O@debian9.Home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------67qAfkmUY6MeBLGWxmJ3jSNz"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------67qAfkmUY6MeBLGWxmJ3jSNz
Content-Type: multipart/mixed; boundary="------------8UtCw0R0RFV06VvfzFgBd1ER";
 protected-headers="v1"
From: Anthony Ruhier <aruhier@mailbox.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <254c8e30-6692-3f3c-59ea-e3456ca9a266@mailbox.org>
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
 <YeVc0r7lLtns0Bch@debian9.Home>
 <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
 <YeWetp7/1q/4bU1O@debian9.Home>
In-Reply-To: <YeWetp7/1q/4bU1O@debian9.Home>

--------------8UtCw0R0RFV06VvfzFgBd1ER
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SSdtIGdvaW5nIHRvIGFwcGx5IHlvdXIgcGF0Y2ggZm9yIHRoZSAxQiBmaWxlLCBhbmQgcXVp
Y2tseSBjb25maXJtIGlmIGl0IA0Kd29ya3MuDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcGF0
Y2ghDQoNCkFib3V0IHRoZSBhdXRvZGVmcmFnIGlzc3VlLCBpdCdzIGdvaW5nIHRvIGJlIHRy
aWNraWVyIHRvIGNoZWNrIHRoYXQgeW91ciANCnBhdGNoIGZpeGVzIGl0LCBiZWNhdXNlIGZv
ciB3aGF0ZXZlciByZWFzb24gdGhlIHByb2JsZW0gc2VlbXMgdG8gaGF2ZSANCnJlc29sdmVk
IGl0c2VsZiAob3IgYXQgbGVhc3QsIGJ0cmZzLWNsZWFuZXIgZG9lcyB3YXkgbGVzcyB3cml0
ZXMpIGFmdGVyIA0KYSBwYXJ0aWFsIGJ0cmZzIGJhbGFuY2UuDQpJJ2xsIHRyeSBhbmQgbG9v
ayB0aGUgYW1vdW50IG9mIHdyaXRlcyBhZnRlciBzZXZlcmFsIGhvdXJzLiBNYXliZSBmb3Ig
DQp0aGlzIG9uZSwgc2VlIHdpdGggdGhlIGF1dGhvciBvZiB0aGUgb3RoZXIgYnVnLiBJZiB0
aGV5IGNhbiBlYXNpbHkgDQpyZXByb2R1Y2UgdGhlIGlzc3VlIHRoZW4gaXQncyBnb2luZyB0
byBiZSBlYXNpZXIgdG8gY2hlY2suDQoNClRoYW5rcywNCkFudGhvbnkNCg0KTGUgMTcvMDEv
MjAyMiDDoCAxNzo1MiwgRmlsaXBlIE1hbmFuYSBhIMOpY3JpdMKgOg0KPiBPbiBNb24sIEph
biAxNywgMjAyMiBhdCAwMzoyNDowMFBNICswMTAwLCBBbnRob255IFJ1aGllciB3cm90ZToN
Cj4+IFRoYW5rcyBmb3IgdGhlIGFuc3dlci4NCj4+DQo+PiBJIGhhZCB0aGUgZXhhY3Qgc2Ft
ZSBpc3N1ZSBhcyBpbiB0aGUgdGhyZWFkIHlvdSd2ZSBsaW5rZWQsIGFuZCBoYXZlIHNvbWUN
Cj4+IG1vbml0b3JpbmcgYW5kIGdyYXBocyB0aGF0IHNob3dlZCB0aGF0IGJ0cmZzLWNsZWFu
ZXIgZGlkIGNvbnN0YW50IHdyaXRlcw0KPj4gZHVyaW5nIDEyIGhvdXJzIGp1c3QgYWZ0ZXIg
SSB1cGdyYWRlZCB0byBsaW51eCA1LjE2LiBXZWlyZGx5IGVub3VnaCwgdGhlDQo+PiBpc3N1
ZSBhbG1vc3QgZGlzYXBwZWFyZWQgYWZ0ZXIgSSBkaWQgYSBidHJmcyBiYWxhbmNlIGJ5IGZp
bHRlcmluZyBvbiAxMCUNCj4+IHVzYWdlIG9mIGRhdGEuDQo+PiBCdXQgdGhhdCdzIHdoeSBJ
IGluaXRpYWxseSBkaXNhYmxlZCBhdXRvZGVmcmFnLCB3aGF0IGhhcyBsZWFkIHRvIGRpc2Nv
dmVyaW5nDQo+PiB0aGlzIGJ1ZyBhcyBJIHN3aXRjaGVkIHRvIG1hbnVhbCBkZWZyYWdtZW50
YXRpb24gKHdoaWNoLCBpbiB0aGUgZW5kLCBtYWtlcw0KPj4gbW9yZSBzZW5zZSBhbnl3YXkg
d2l0aCBteSBzZXR1cCkuDQo+Pg0KPj4gSSB0cmllZCB0aGlzIHBhdGNoLCBidXQgc2FkbHkg
aXQgZG9lc24ndCBoZWxwIGZvciB0aGUgaW5pdGlhbCBpc3N1ZS4gSQ0KPj4gY2Fubm90IHNh
eSBmb3IgdGhlIGJ1ZyBpbiB0aGUgb3RoZXIgdGhyZWFkLCBhcyB0aGUgcHJvYmxlbSB3aXRo
DQo+PiBidHJmcy1jbGVhbmVyIGRpc2FwcGVhcmVkIChJIGNhbiBzdGlsbCBzZWUgc29tZSB3
cml0ZXMgZnJvbSBpdCwgYnV0IGl0IHNvDQo+PiByYXJlIHRoYXQgSSBjYW5ub3Qgc2F5IGlm
IGl0J3Mgbm9ybWFsIG9yIG5vdCkuDQo+IE9rLCByZWFkaW5nIGJldHRlciB5b3VyIGZpcnN0
IG1haWwsIEkgc2VlIHRoZXJlJ3MgdGhlIGNhc2Ugb2YgdGhlIDEgYnl0ZQ0KPiBmaWxlLCB3
aGljaCBpcyBwb3NzaWJseSBub3QgdGhlIGNhdXNlIGZyb20gdGhlIGF1dG9kZWZyYWcgY2F1
c2luZyB0aGUNCj4gZXhjZXNzaXZlIElPIHByb2JsZW0uDQo+DQo+IEZvciB0aGUgMSBieXRl
IGZpbGUgcHJvYmxlbSwgSSd2ZSBqdXN0IHNlbnQgYSBmaXg6DQo+DQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1idHJmcy9wYXRjaC9iY2JmY2UwZmY3
ZTIxYmJmZWQyNDg0YjE0NTdlNTYwZWRmNzgwMjBkLjE2NDI0MzY4MDUuZ2l0LmZkbWFuYW5h
QHN1c2UuY29tLw0KPg0KPiBJdCdzIGFjdHVhbGx5IHRyaXZpYWwgdG8gdHJpZ2dlci4NCj4N
Cj4gQ2FuIHlvdSBjaGVjayBpZiBpdCBhbHNvIGZpeGVzIHlvdXIgcHJvYmxlbSB3aXRoIGF1
dG9kZWZyYWc/DQo+DQo+IElmIG5vdCwgdGhlbiB0cnkgdGhlIGZvbGxvd2luZyAoYWZ0ZXIg
YXBwbHlpbmcgdGhlIDEgZmlsZSBmaXgpOg0KPg0KPiBodHRwczovL3Bhc3RlYmluLmNvbS9y
YXcvRWJFZmsxdEYNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lvY3RsLmMgYi9mcy9i
dHJmcy9pb2N0bC5jDQo+IGluZGV4IGE1YmQ2OTI2ZjdmZi4uZGI3OTVlMjI2Y2NhIDEwMDY0
NA0KPiAtLS0gYS9mcy9idHJmcy9pb2N0bC5jDQo+ICsrKyBiL2ZzL2J0cmZzL2lvY3RsLmMN
Cj4gQEAgLTExOTEsNiArMTE5MSw3IEBAIHN0YXRpYyBpbnQgZGVmcmFnX2NvbGxlY3RfdGFy
Z2V0cyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLA0KPiAgIAkJCQkgIHU2NCBuZXdlcl90
aGFuLCBib29sIGRvX2NvbXByZXNzLA0KPiAgIAkJCQkgIGJvb2wgbG9ja2VkLCBzdHJ1Y3Qg
bGlzdF9oZWFkICp0YXJnZXRfbGlzdCkNCj4gICB7DQo+ICsJY29uc3QgdTMyIG1pbl90aHJl
c2ggPSBleHRlbnRfdGhyZXNoIC8gMjsNCj4gICAJdTY0IGN1ciA9IHN0YXJ0Ow0KPiAgIAlp
bnQgcmV0ID0gMDsNCj4gICANCj4gQEAgLTExOTgsNiArMTE5OSw3IEBAIHN0YXRpYyBpbnQg
ZGVmcmFnX2NvbGxlY3RfdGFyZ2V0cyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLA0KPiAg
IAkJc3RydWN0IGV4dGVudF9tYXAgKmVtOw0KPiAgIAkJc3RydWN0IGRlZnJhZ190YXJnZXRf
cmFuZ2UgKm5ldzsNCj4gICAJCWJvb2wgbmV4dF9tZXJnZWFibGUgPSB0cnVlOw0KPiArCQl1
NjQgcmFuZ2Vfc3RhcnQ7DQo+ICAgCQl1NjQgcmFuZ2VfbGVuOw0KPiAgIA0KPiAgIAkJZW0g
PSBkZWZyYWdfbG9va3VwX2V4dGVudCgmaW5vZGUtPnZmc19pbm9kZSwgY3VyLCBsb2NrZWQp
Ow0KPiBAQCAtMTIxMyw2ICsxMjE1LDI0IEBAIHN0YXRpYyBpbnQgZGVmcmFnX2NvbGxlY3Rf
dGFyZ2V0cyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLA0KPiAgIAkJaWYgKGVtLT5nZW5l
cmF0aW9uIDwgbmV3ZXJfdGhhbikNCj4gICAJCQlnb3RvIG5leHQ7DQo+ICAgDQo+ICsJCS8q
DQo+ICsJCSAqIE91ciBzdGFydCBvZmZzZXQgbWlnaHQgYmUgaW4gdGhlIG1pZGRsZSBvZiBh
biBleGlzdGluZyBleHRlbnQNCj4gKwkJICogbWFwLCBzbyB0YWtlIHRoYXQgaW50byBhY2Nv
dW50Lg0KPiArCQkgKi8NCj4gKwkJcmFuZ2VfbGVuID0gZW0tPmxlbiAtIChjdXIgLSBlbS0+
c3RhcnQpOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIElmIHRoZXJlJ3MgYWxyZWFkeSBhIGdv
b2QgcmFuZ2UgZm9yIGRlbGFsbG9jIHdpdGhpbiB0aGUgcmFuZ2UNCj4gKwkJICogY292ZXJl
ZCBieSB0aGUgZXh0ZW50IG1hcCwgc2tpcCBpdCwgb3RoZXJ3aXNlIHdlIGNhbiBlbmQgdXAN
Cj4gKwkJICogZG9pbmcgb24gdGhlIHNhbWUgSU8gcmFuZ2UgZm9yIGEgbG9uZyB0aW1lIHdo
ZW4gdXNpbmcgYXV0bw0KPiArCQkgKiBkZWZyYWcuDQo+ICsJCSAqLw0KPiArCQlyYW5nZV9z
dGFydCA9IGN1cjsNCj4gKwkJaWYgKGNvdW50X3JhbmdlX2JpdHMoJmlub2RlLT5pb190cmVl
LCAmcmFuZ2Vfc3RhcnQsDQo+ICsJCQkJICAgICByYW5nZV9zdGFydCArIHJhbmdlX2xlbiAt
IDEsIG1pbl90aHJlc2gsDQo+ICsJCQkJICAgICBFWFRFTlRfREVMQUxMT0MsIDEpID49IG1p
bl90aHJlc2gpDQo+ICsJCQlnb3RvIG5leHQ7DQo+ICsNCj4gICAJCS8qDQo+ICAgCQkgKiBG
b3IgZG9fY29tcHJlc3MgY2FzZSwgd2Ugd2FudCB0byBjb21wcmVzcyBhbGwgdmFsaWQgZmls
ZQ0KPiAgIAkJICogZXh0ZW50cywgdGh1cyBubyBAZXh0ZW50X3RocmVzaCBvciBtZXJnZWFi
bGUgY2hlY2suDQo+IEBAIC0xMjIwLDggKzEyNDAsOCBAQCBzdGF0aWMgaW50IGRlZnJhZ19j
b2xsZWN0X3RhcmdldHMoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwNCj4gICAJCWlmIChk
b19jb21wcmVzcykNCj4gICAJCQlnb3RvIGFkZDsNCj4gICANCj4gLQkJLyogU2tpcCB0b28g
bGFyZ2UgZXh0ZW50ICovDQo+IC0JCWlmIChlbS0+bGVuID49IGV4dGVudF90aHJlc2gpDQo+
ICsJCS8qIFNraXAgbGFyZ2UgZW5vdWdoIHJhbmdlcy4gKi8NCj4gKwkJaWYgKHJhbmdlX2xl
biA+PSBleHRlbnRfdGhyZXNoKQ0KPiAgIAkJCWdvdG8gbmV4dDsNCj4gICANCj4gICAJCW5l
eHRfbWVyZ2VhYmxlID0gZGVmcmFnX2NoZWNrX25leHRfZXh0ZW50KCZpbm9kZS0+dmZzX2lu
b2RlLCBlbSwNCj4NCj4NCj4gVGhhbmtzLg0KPg0KPg0KPj4gVGhhbmtzLA0KPj4gQW50aG9u
eQ0KPj4NCj4+IExlIDE3LzAxLzIwMjIgw6AgMTM6MTAsIEZpbGlwZSBNYW5hbmEgYSDDqWNy
aXTCoDoNCj4+PiBPbiBTdW4sIEphbiAxNiwgMjAyMiBhdCAwODoxNTozN1BNICswMTAwLCBB
bnRob255IFJ1aGllciB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+IFNpbmNlIEkgdXBncmFkZWQg
ZnJvbSBsaW51eCA1LjE1IHRvIDUuMTYsIGBidHJmcyBmaWxlc3lzdGVtIGRlZnJhZyAtdDEy
OEtgDQo+Pj4+IGhhbmdzIG9uIHNtYWxsIGZpbGVzICh+MSBieXRlKSBhbmQgdHJpZ2dlcnMg
d2hhdCBpdCBzZWVtcyB0byBiZSBhIGxvb3AgaW4NCj4+Pj4gdGhlIGtlcm5lbC4gSXQgcmVz
dWx0cyBpbiBvbmUgQ1BVIHRocmVhZCBydW5uaW5nIGJlaW5nIHVzZWQgYXQgMTAwJS4gSQ0K
Pj4+PiBjYW5ub3Qga2lsbCB0aGUgcHJvY2VzcywgYW5kIHJlYm9vdGluZyBpcyBibG9ja2Vk
IGJ5IGJ0cmZzLg0KPj4+PiBJdCBpcyBhIGNvcHkgb2YgdGhlIGJ1Z2h0dHBzOi8vYnVnemls
bGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE1NDk4DQo+Pj4+DQo+Pj4+IFJlYm9v
dGluZyB0byBsaW51eCA1LjE1IHNob3dzIG5vIGlzc3VlLiBJIGhhdmUgbm8gaXNzdWUgdG8g
cnVuIGEgZGVmcmFnIG9uDQo+Pj4+IGJpZ2dlciBmaWxlcyAoSSBmaWx0ZXIgb3V0IGZpbGVz
IHNtYWxsZXIgdGhhbiAzLjlLQikuDQo+Pj4+DQo+Pj4+IEkgaGFkIGEgY29udmVyc2F0aW9u
IG9uICNidHJmcyBvbiBJUkMsIHNvIGhlcmUncyB3aGF0IHdlIGRlYnVnZ2VkOg0KPj4+Pg0K
Pj4+PiBJIGNhbiByZXBsaWNhdGUgdGhlIGlzc3VlIGJ5IGNvcHlpbmcgYSBmaWxlIGltcGFj
dGVkIGJ5IHRoaXMgYnVnLCBieSB1c2luZw0KPj4+PiBgY3AgLS1yZWZsaW5rPW5ldmVyYC4g
SSBhdHRhY2hlZCBvbmUgb2YgdGhlIGltcGFjdGVkIGZpbGVzIHRvIHRoaXMgYnVnLA0KPj4+
PiBuYW1lZCBSRUFETUUubWQuDQo+Pj4+DQo+Pj4+IFNvbWVvbmUgdG9sZCBtZSB0aGF0IGl0
IGNvdWxkIGJlIGEgYnVnIGR1ZSB0byB0aGUgaW5saW5lIGV4dGVudC4gU28gd2UgdHJpZWQN
Cj4+Pj4gdG8gY2hlY2sgdGhhdC4NCj4+Pj4NCj4+Pj4gZmlsZWZyYWcgc2hvd3MgdGhhdCB0
aGUgZmlsZSBSZWFkbWUubWQgaXMgMSBpbmxpbmUgZXh0ZW50LiBJIHRyaWVkIHRvIGNyZWF0
ZQ0KPj4+PiBhIG5ldyBmaWxlIHdpdGggcmFuZG9tIHRleHQsIG9mIDE4IGJ5dGVzIChzbGln
aHRseSBiaWdnZXIgdGhhbiB0aGUgb3RoZXINCj4+Pj4gZmlsZSksIHRoYXQgaXMgYWxzbyAx
IGlubGluZSBleHRlbnQuIFRoaXMgZmlsZSBkb2Vzbid0IHRyaWdnZXIgdGhlIGJ1ZyBhbmQN
Cj4+Pj4gaGFzIG5vIGlzc3VlIHRvIGJlIGRlZnJhZ21lbnRlZC4NCj4+Pj4NCj4+Pj4gSSB0
cmllZCB0byBtb3VudCBteSBzeXN0ZW0gd2l0aCBgbWF4X2lubGluZT0wYCwgY3JlYXRlZCBh
IGNvcHkgb2YgUkVBRE1FLm1kLg0KPj4+PiBgZmlsZWZyYWdgIHNob3dzIG1lIHRoYXQgdGhl
IG5ldyBmaWxlIGlzIG5vdyAxIGV4dGVudCwgbm90IGlubGluZS4gVGhpcyBuZXcNCj4+Pj4g
ZmlsZSBhbHNvIHRyaWdnZXJzIHRoZSBidWcsIHNvIGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBk
dWUgdG8gdGhlIGlubGluZQ0KPj4+PiBleHRlbnQuDQo+Pj4+DQo+Pj4+IFNvbWVvbmUgYXNr
ZWQgbWUgdG8gcHJvdmlkZSB0aGUgb3V0cHV0IG9mIGEgcGVyZiB0b3Agd2hlbiB0aGUgZGVm
cmFnIGlzDQo+Pj4+IHN0dWNrOg0KPj4+Pg0KPj4+PiAgIMKgwqDCoCAyOC43MCXCoCBba2Vy
bmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10gZ2VuZXJpY19iaW5fc2VhcmNoDQo+Pj4+ICAg
wqDCoMKgIDE0LjkwJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBmcmVlX2V4
dGVudF9idWZmZXINCj4+Pj4gICDCoMKgwqAgMTMuMTclwqAgW2tlcm5lbF3CoMKgwqDCoMKg
wqDCoMKgwqAgW2tdIGJ0cmZzX3NlYXJjaF9zbG90DQo+Pj4+ICAgwqDCoMKgIDEyLjYzJcKg
IFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBidHJmc19yb290X25vZGUNCj4+Pj4g
ICDCoMKgwqDCoCA4LjMzJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBidHJm
c19nZXRfNjQNCj4+Pj4gICDCoMKgwqDCoCAzLjg4JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKg
wqDCoMKgIFtrXSBfX2Rvd25fcmVhZF9jb21tb24ubGx2bQ0KPj4+PiAgIMKgwqDCoMKgIDMu
MDAlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqAgW2tdIHVwX3JlYWQNCj4+Pj4gICDC
oMKgwqDCoCAyLjYzJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSByZWFkX2Js
b2NrX2Zvcl9zZWFyY2gNCj4+Pj4gICDCoMKgwqDCoCAyLjQwJcKgIFtrZXJuZWxdwqDCoMKg
wqDCoMKgwqDCoMKgIFtrXSByZWFkX2V4dGVudF9idWZmZXINCj4+Pj4gICDCoMKgwqDCoCAx
LjM4JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBtZW1zZXRfZXJtcw0KPj4+
PiAgIMKgwqDCoMKgIDEuMTElwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGZp
bmRfZXh0ZW50X2J1ZmZlcg0KPj4+PiAgIMKgwqDCoMKgIDAuNjklwqAgW2tlcm5lbF3CoMKg
wqDCoMKgwqDCoMKgwqAgW2tdIGttZW1fY2FjaGVfZnJlZQ0KPj4+PiAgIMKgwqDCoMKgIDAu
NjklwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqAgW2tdIG1lbWNweV9lcm1zDQo+Pj4+
ICAgwqDCoMKgwqAgMC41NyXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10ga21l
bV9jYWNoZV9hbGxvYw0KPj4+PiAgIMKgwqDCoMKgIDAuNDUlwqAgW2tlcm5lbF3CoMKgwqDC
oMKgwqDCoMKgwqAgW2tdIHJhZGl4X3RyZWVfbG9va3VwDQo+Pj4+DQo+Pj4+IEkgY2FuIHJl
cHJvZHVjZSB0aGUgYnVnIG9uIDIgZGlmZmVyZW50IG1hY2hpbmVzLCBydW5uaW5nIDIgZGlm
ZmVyZW50IGxpbnV4DQo+Pj4+IGRpc3RyaWJ1dGlvbnMgKEFyY2ggYW5kIEdlbnRvbykgd2l0
aCAyIGRpZmZlcmVudCBrZXJuZWwgY29uZmlncy4NCj4+Pj4gVGhpcyBrZXJuZWwgaXMgY29t
cGlsZWQgd2l0aCBjbGFuZywgdGhlIG90aGVyIHdpdGggR0NDLg0KPj4+Pg0KPj4+PiBLZXJu
ZWwgdmVyc2lvbjogNS4xNi4wDQo+Pj4+IE1vdW50IG9wdGlvbnM6DQo+Pj4+ICAgwqDCoMKg
IE1hY2hpbmUgMToNCj4+Pj4gcncsbm9hdGltZSxjb21wcmVzcy1mb3JjZT16c3RkOjIsc3Nk
LGRpc2NhcmQ9YXN5bmMsc3BhY2VfY2FjaGU9djIsYXV0b2RlZnJhZw0KPj4+PiAgIMKgwqDC
oCBNYWNoaW5lIDI6IHJ3LG5vYXRpbWUsY29tcHJlc3MtZm9yY2U9enN0ZDozLG5vc3NkLHNw
YWNlX2NhY2hlPXYyDQo+Pj4+DQo+Pj4+IFdoZW4gdGhlIGVycm9yIGhhcHBlbnMsIG5vIG1l
c3NhZ2UgaXMgc2hvd24gaW4gZG1lc2cuDQo+Pj4gVGhpcyBpcyB2ZXJ5IGxpa2VseSB0aGUg
c2FtZSBpc3N1ZSBhcyByZXBvcnRlZCBhdCB0aGlzIHRocmVhZDoNCj4+Pg0KPj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzL1llVmF3QkJFM3I2aFZoZ3NAZGViaWFu
OS5Ib21lL1QvI21hMWM4YTk4NDhjOWI3ZTRlZGI0NzFmN2JlMTg0NTk5ZDM4ZTI4OGJiDQo+
Pj4NCj4+PiBBcmUgeW91IGFibGUgdG8gdGVzdCB0aGUgcGF0Y2ggcG9zdGVkIHRoZXJlPw0K
Pj4+DQo+Pj4gVGhhbmtzLg0KPj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4gQW50aG9ueSBSdWhp
ZXINCj4+Pj4NCj4NCj4NCj4NCj4NCg==

--------------8UtCw0R0RFV06VvfzFgBd1ER--

--------------67qAfkmUY6MeBLGWxmJ3jSNz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTNQhfAcx4Jlo6lbanXMzk8hoTszwUCYeWhqAAKCRDXMzk8hoTs
zzEdAQDh5KH1NVS2M3R509oaFDxsccniZOWbp/TonC1CpcBovQD+O3/WCQwoIquv
2RhOdvKd517zg7czrajJFCmZN4lOpws=
=ksdT
-----END PGP SIGNATURE-----

--------------67qAfkmUY6MeBLGWxmJ3jSNz--
