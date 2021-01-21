Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44F62FE1AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 06:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbhAUDq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 22:46:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:54059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbhAUAvY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 19:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611190174;
        bh=6vJ1MvcXnoJzuN/ZybcvetJpR8HzPC51zZamh5RagKM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=W1AElLaYF4IBcsoBFHtvIyS/3MsOT1hs7qVQJ3qf5kqNYeLvMmq977Xw8iXKkXq6i
         1J4UWhL8UFJ9DfN5cZ6PFsyxI/sKQvgMLAzYf6VB1/+secXoWndnJSMX0ffGjMRX2Z
         xy33nGCjzNNj69fusXICwIbDH9Gpe7j9FyW08abU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbBk-1luce31a9G-00saXy; Thu, 21
 Jan 2021 01:49:34 +0100
Subject: Re: [PATCH v4 08/18] btrfs: introduce helper for subpage uptodate
 status
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-9-wqu@suse.com>
 <812a4f48-3210-926f-cf59-de63bfcc4c0d@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3118cc60-2337-49da-648d-aa3b8cdcd70d@gmx.com>
Date:   Thu, 21 Jan 2021 08:49:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <812a4f48-3210-926f-cf59-de63bfcc4c0d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:yZWix0AiIL7C6u9kMA3yvHNvwct7ZXDKb73rzBaq/KUu7UzLnlY
 ju++TdDty15A2T7ymGvdRD7VXU1JuuWq0NDEyqyNTwYAyjuwm2ngd939Vvwb5Wnuhg3NKOq
 T61aKu3u+Ztw1KcQYWKgQZZa+g7RgJ5oSFhCeIeOMvta3cD7xE9N2dVzquP5NUh+eQ8U10J
 vcb5m4u+oJIBmUhKPXWDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XDd9Uaj2s7M=:6FiWKXrHr1KlLnzEEoKu1b
 2XrZWzggRoSE/zRpdNyPHjXdF4Avlh8uUN+9iErlmh2DQlL2MrKPH+5sLoLM0Xohco66rgvpM
 Do2lntBFsTJuq683skbIL91DtYCFA4DfohOdIqhtpSkz9raCtdjhfCfSVd27DrimcOM3RxJoe
 SK3Es3OeJlWJ+44rhUim8QIRRCxHPjFTjp4o4k9P2mYQX2Hyp+d1e+5X74mcI8FbbtlqMfBSj
 vQS7pBqzoHNhjGdBOZnEPsQdUZ8wbB1EwSdJjAjTl7R/yqcZL4gEV2hQB/IbvZjaXjH+y4oPS
 M0GPGp85sOLNJ19a2UZ5twDsGp24i+IqJeTR3HscD1H8VMLFW3oVqn2y0LO9mdbpRkL+IltAf
 8spc42oT+0Rc6i/K7kADxjK5On76rKTlOCVkgJ1lCv56/1ylms2chUxY3ATyk9L4eC77gqU7o
 OK+0iT1jbb6eenD/Pj+AC73tbVICr3U0UwOamWgruiNReEqJh0H11W/E69q0cZuSLe/oFDzu8
 LEfIrN7x0eetzmazhisEeMSXKAOrPEWxnVD5IDi+UZ0s22/IJKlVsCDIbTon6CDofq+7Yg7sY
 B3oWMly51cTLN8mzqwyT7NUiRqSDO8LX9XsQFJjnctxzvBdk+R30iKwkhXOPUtsb/UZHF36MJ
 eFyawiR7nYM0o/tHJ+z/CSPXW7aMAZFosRk6xydX1cKtXZZw4UbzxoDQEL6Kg67cHIMH46k+9
 e47Q4T5sSoupHVqsyNSlvHUVjCO2bx9ve5XQ/ar3ffMAN+eNZwsAHAUF7M/pkO+68yoOZPYlw
 F5g0QGFv6f0EWGNjuCzhO4J7Z+FVcqrC2tZibe1MUVLVJgTZNB9YceMhRsp2T8R2y96fvumXm
 xTem+BeKCgF8+jsKmQbA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjEvMS8yMCDkuIvljYgxMTowMCwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+IE9uIDEv
MTYvMjEgMjoxNSBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2Ug
dGhlIGZvbGxvd2luZyBmdW5jdGlvbnMgdG8gaGFuZGxlIGJ0cmZzIHN1YnBhZ2UNCj4+IHVwdG9k
YXRlIHN0YXR1czoNCj4+IC0gYnRyZnNfc3VicGFnZV9zZXRfdXB0b2RhdGUoKQ0KPj4gLSBidHJm
c19zdWJwYWdlX2NsZWFyX3VwdG9kYXRlKCkNCj4+IC0gYnRyZnNfc3VicGFnZV90ZXN0X3VwdG9k
YXRlKCkNCj4+IMKgwqAgVGhvc2UgaGVscGVycyBjYW4gb25seSBiZSBjYWxsZWQgd2hlbiB0aGUg
cmFuZ2UgaXMgZW5zdXJlZCB0byBiZQ0KPj4gwqDCoCBpbnNpZGUgdGhlIHBhZ2UuDQo+Pg0KPj4g
LSBidHJmc19wYWdlX3NldF91cHRvZGF0ZSgpDQo+PiAtIGJ0cmZzX3BhZ2VfY2xlYXJfdXB0b2Rh
dGUoKQ0KPj4gLSBidHJmc19wYWdlX3Rlc3RfdXB0b2RhdGUoKQ0KPj4gwqDCoCBUaG9zZSBoZWxw
ZXJzIGNhbiBoYW5kbGUgYm90aCByZWd1bGFyIHNlY3RvciBzaXplIGFuZCBzdWJwYWdlIHdpdGhv
dXQNCj4+IMKgwqAgcHJvYmxlbS4NCj4+IMKgwqAgQWx0aG91Z2ggY2FsbGVyIHNob3VsZCBzdGls
bCBlbnN1cmUgdGhhdCB0aGUgcmFuZ2UgaXMgaW5zaWRlIHRoZSBwYWdlLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4gLS0tDQo+PiDCoCBmcy9idHJm
cy9zdWJwYWdlLmggfCAxMTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTE1IGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZnMvYnRyZnMvc3VicGFnZS5oIGIvZnMvYnRyZnMvc3VicGFnZS5oDQo+PiBp
bmRleCBkOGIzNDg3OTM2OGQuLjMzNzNlZjRmZmVjMSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZz
L3N1YnBhZ2UuaA0KPj4gKysrIGIvZnMvYnRyZnMvc3VicGFnZS5oDQo+PiBAQCAtMjMsNiArMjMs
NyBAQA0KPj4gwqAgc3RydWN0IGJ0cmZzX3N1YnBhZ2Ugew0KPj4gwqDCoMKgwqDCoCAvKiBDb21t
b24gbWVtYmVycyBmb3IgYm90aCBkYXRhIGFuZCBtZXRhZGF0YSBwYWdlcyAqLw0KPj4gwqDCoMKg
wqDCoCBzcGlubG9ja190IGxvY2s7DQo+PiArwqDCoMKgIHUxNiB1cHRvZGF0ZV9iaXRtYXA7DQo+
PiDCoMKgwqDCoMKgIHVuaW9uIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBTdHJ1Y3R1cmVz
IG9ubHkgdXNlZCBieSBtZXRhZGF0YSAqLw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgdW5k
ZXJfYWxsb2M7DQo+PiBAQCAtNzgsNCArNzksMTE4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCANCj4+
IGJ0cmZzX3BhZ2VfZW5kX21ldGFfYWxsb2Moc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8s
DQo+PiDCoCBpbnQgYnRyZnNfYXR0YWNoX3N1YnBhZ2Uoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8sIHN0cnVjdCBwYWdlIA0KPj4gKnBhZ2UpOw0KPj4gwqAgdm9pZCBidHJmc19kZXRhY2hf
c3VicGFnZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgc3RydWN0IHBhZ2UgDQo+PiAq
cGFnZSk7DQo+PiArLyoNCj4+ICsgKiBDb252ZXJ0IHRoZSBbc3RhcnQsIHN0YXJ0ICsgbGVuKSBy
YW5nZSBpbnRvIGEgdTE2IGJpdG1hcA0KPj4gKyAqDQo+PiArICogRS5nLiBpZiBzdGFydCA9PSBw
YWdlX29mZnNldCgpICsgMTZLLCBsZW4gPSAxNkssIHdlIGdldCAweDAwZjAuDQo+PiArICovDQo+
PiArc3RhdGljIGlubGluZSB1MTYgYnRyZnNfc3VicGFnZV9jYWxjX2JpdG1hcChzdHJ1Y3QgYnRy
ZnNfZnNfaW5mbyANCj4+ICpmc19pbmZvLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IHBhZ2UgKnBhZ2UsIHU2NCBzdGFydCwgdTMyIGxlbikNCj4+ICt7DQo+PiArwqDCoMKgIGlu
dCBiaXRfc3RhcnQgPSBvZmZzZXRfaW5fcGFnZShzdGFydCkgPj4gZnNfaW5mby0+c2VjdG9yc2l6
ZV9iaXRzOw0KPj4gK8KgwqDCoCBpbnQgbmJpdHMgPSBsZW4gPj4gZnNfaW5mby0+c2VjdG9yc2l6
ZV9iaXRzOw0KPj4gKw0KPj4gK8KgwqDCoCAvKiBCYXNpYyBjaGVja3MgKi8NCj4+ICvCoMKgwqAg
QVNTRVJUKFBhZ2VQcml2YXRlKHBhZ2UpICYmIHBhZ2UtPnByaXZhdGUpOw0KPj4gK8KgwqDCoCBB
U1NFUlQoSVNfQUxJR05FRChzdGFydCwgZnNfaW5mby0+c2VjdG9yc2l6ZSkgJiYNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoCBJU19BTElHTkVEKGxlbiwgZnNfaW5mby0+c2VjdG9yc2l6ZSkpOw0K
Pj4gKw0KPj4gK8KgwqDCoCAvKg0KPj4gK8KgwqDCoMKgICogVGhlIHJhbmdlIGNoZWNrIG9ubHkg
d29ya3MgZm9yIG1hcHBlZCBwYWdlLCB3ZSBjYW4NCj4+ICvCoMKgwqDCoCAqIHN0aWxsIGhhdmUg
dW5hbXBwZWQgcGFnZSBsaWtlIGR1bW15IGV4dGVudCBidWZmZXIgcGFnZXMuDQo+PiArwqDCoMKg
wqAgKi8NCj4+ICvCoMKgwqAgaWYgKHBhZ2UtPm1hcHBpbmcpDQo+PiArwqDCoMKgwqDCoMKgwqAg
QVNTRVJUKHBhZ2Vfb2Zmc2V0KHBhZ2UpIDw9IHN0YXJ0ICYmDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdGFydCArIGxlbiA8PSBwYWdlX29mZnNldChwYWdlKSArIFBBR0VfU0laRSk7DQo+
PiArwqDCoMKgIC8qDQo+PiArwqDCoMKgwqAgKiBIZXJlIG5iaXRzIGNhbiBiZSAxNiwgdGh1cyBj
YW4gZ28gYmV5b25kIHUxNiByYW5nZS4gSGVyZSB3ZSANCj4+IG1ha2UgdGhlDQo+PiArwqDCoMKg
wqAgKiBmaXJzdCBsZWZ0IHNoaWZ0IHRvIGJlIGNhbGN1bGF0ZWQgaW4gdW5zaWduZWQgbG9uZyAo
dTMyKSwgdGhlbg0KPj4gK8KgwqDCoMKgICogdHJ1bmNhdGUgdGhlIHJlc3VsdCB0byB1MTYuDQo+
PiArwqDCoMKgwqAgKi8NCj4+ICvCoMKgwqAgcmV0dXJuICh1MTYpKCgoMVVMIDw8IG5iaXRzKSAt
IDEpIDw8IGJpdF9zdGFydCk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBi
dHJmc19zdWJwYWdlX3NldF91cHRvZGF0ZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyANCj4+ICpmc19p
bmZvLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2UsIHU2NCBz
dGFydCwgdTMyIGxlbikNCj4+ICt7DQo+PiArwqDCoMKgIHN0cnVjdCBidHJmc19zdWJwYWdlICpz
dWJwYWdlID0gKHN0cnVjdCBidHJmc19zdWJwYWdlIA0KPj4gKilwYWdlLT5wcml2YXRlOw0KPj4g
K8KgwqDCoCB1MTYgdG1wID0gYnRyZnNfc3VicGFnZV9jYWxjX2JpdG1hcChmc19pbmZvLCBwYWdl
LCBzdGFydCwgbGVuKTsNCj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+ICsNCj4+
ICvCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJnN1YnBhZ2UtPmxvY2ssIGZsYWdzKTsNCj4+ICvC
oMKgwqAgc3VicGFnZS0+dXB0b2RhdGVfYml0bWFwIHw9IHRtcDsNCj4+ICvCoMKgwqAgaWYgKHN1
YnBhZ2UtPnVwdG9kYXRlX2JpdG1hcCA9PSBVMTZfTUFYKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIFNl
dFBhZ2VVcHRvZGF0ZShwYWdlKTsNCj4+ICvCoMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
c3VicGFnZS0+bG9jaywgZmxhZ3MpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIHZv
aWQgYnRyZnNfc3VicGFnZV9jbGVhcl91cHRvZGF0ZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyANCj4+
ICpmc19pbmZvLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2Us
IHU2NCBzdGFydCwgdTMyIGxlbikNCj4+ICt7DQo+PiArwqDCoMKgIHN0cnVjdCBidHJmc19zdWJw
YWdlICpzdWJwYWdlID0gKHN0cnVjdCBidHJmc19zdWJwYWdlIA0KPj4gKilwYWdlLT5wcml2YXRl
Ow0KPj4gK8KgwqDCoCB1MTYgdG1wID0gYnRyZnNfc3VicGFnZV9jYWxjX2JpdG1hcChmc19pbmZv
LCBwYWdlLCBzdGFydCwgbGVuKTsNCj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+
ICsNCj4+ICvCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJnN1YnBhZ2UtPmxvY2ssIGZsYWdzKTsN
Cj4+ICvCoMKgwqAgc3VicGFnZS0+dXB0b2RhdGVfYml0bWFwICY9IH50bXA7DQo+PiArwqDCoMKg
IENsZWFyUGFnZVVwdG9kYXRlKHBhZ2UpOw0KPj4gK8KgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZzdWJwYWdlLT5sb2NrLCBmbGFncyk7DQo+PiArfQ0KPj4gKw0KPj4gKy8qDQo+PiArICog
VW5saWtlIHNldC9jbGVhciB3aGljaCBpcyBkZXBlbmRlbnQgb24gZWFjaCBwYWdlIHN0YXR1cywg
Zm9yIHRlc3QgDQo+PiBhbGwgYml0cw0KPj4gKyAqIGFyZSB0ZXN0ZWQgaW4gdGhlIHNhbWUgd2F5
Lg0KPj4gKyAqLw0KPj4gKyNkZWZpbmUgREVDTEFSRV9CVFJGU19TVUJQQUdFX1RFU1RfT1AobmFt
ZSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK3N0YXRpYyBpbmxpbmUgYm9v
bCBidHJmc19zdWJwYWdlX3Rlc3RfIyNuYW1lKHN0cnVjdCBidHJmc19mc19pbmZvIA0KPj4gKmZz
X2luZm8sIFwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpwYWdlLCB1
NjQgc3RhcnQsIHUzMiBsZW4pwqDCoMKgwqDCoMKgwqAgXA0KPj4gK3vCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwN
Cj4+ICvCoMKgwqAgc3RydWN0IGJ0cmZzX3N1YnBhZ2UgKnN1YnBhZ2UgPSAoc3RydWN0IGJ0cmZz
X3N1YnBhZ2UgDQo+PiAqKXBhZ2UtPnByaXZhdGU7IFwNCj4+ICvCoMKgwqAgdTE2IHRtcCA9IGJ0
cmZzX3N1YnBhZ2VfY2FsY19iaXRtYXAoZnNfaW5mbywgcGFnZSwgc3RhcnQsIGxlbik7IFwNCj4+
ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAgYm9vbCByZXQ7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwNCj4+ICvCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJnN1YnBhZ2UtPmxvY2ssIGZsYWdz
KTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAgcmV0ID0gKChzdWJwYWdlLT5u
YW1lIyNfYml0bWFwICYgdG1wKSA9PSB0bXApO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4g
K8KgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzdWJwYWdlLT5sb2NrLCBmbGFncyk7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+PiArwqDCoMKgIHJldHVybiByZXQ7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICt9DQo+PiAr
REVDTEFSRV9CVFJGU19TVUJQQUdFX1RFU1RfT1AodXB0b2RhdGUpOw0KPj4gKw0KPj4gKy8qDQo+
PiArICogTm90ZSB0aGF0LCBpbiBzZWxmdGVzdCwgZXNwZWNpYWxseSBleHRlbnQtaW8tdGVzdHMs
IHdlIGNhbiBoYXZlIGVtcHR5DQo+PiArICogZnNfaW5mbyBwYXNzZWQgaW4uDQo+PiArICogVGhh
bmtmdWxseSBpbiBzZWxmdGVzdCwgd2Ugb25seSB0ZXN0IHNlY3RvcnNpemUgPT0gUEFHRV9TSVpF
IGNhc2VzIA0KPj4gc28gZmFyLA0KPj4gKyAqIHRodXMgd2UgY2FuIGZhbGwgYmFjayB0byByZWd1
bGFyIHNlY3RvcnNpemUgYnJhbmNoLg0KPj4gKyAqLw0KPj4gKyNkZWZpbmUgREVDTEFSRV9CVFJG
U19QQUdFX09QUyhuYW1lLCBzZXRfcGFnZV9mdW5jLCANCj4+IGNsZWFyX3BhZ2VfZnVuYyzCoMKg
wqAgXA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ZXN0X3BhZ2Vf
ZnVuYynCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK3N0YXRpYyBpbmxpbmUg
dm9pZCBidHJmc19wYWdlX3NldF8jI25hbWUoc3RydWN0IGJ0cmZzX2ZzX2luZm8gDQo+PiAqZnNf
aW5mbyzCoMKgwqAgXA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBh
Z2UsIHU2NCBzdGFydCwgdTMyIGxlbinCoMKgwqDCoMKgwqDCoCBcDQo+PiAre8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXA0KPj4gK8KgwqDCoCBpZiAodW5saWtlbHkoIWZzX2luZm8pIHx8IGZzX2luZm8tPnNlY3Rv
cnNpemUgPT0gUEFHRV9TSVpFKSB7wqDCoMKgIFwNCj4+ICvCoMKgwqDCoMKgwqDCoCBzZXRfcGFn
ZV9mdW5jKHBhZ2UpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAg
YnRyZnNfc3VicGFnZV9zZXRfIyNuYW1lKGZzX2luZm8sIHBhZ2UsIHN0YXJ0LCBsZW4pO8KgwqDC
oMKgwqDCoMKgIFwNCj4+ICt9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+PiArc3RhdGljIGlubGluZSB2b2lk
IGJ0cmZzX3BhZ2VfY2xlYXJfIyNuYW1lKHN0cnVjdCBidHJmc19mc19pbmZvIA0KPj4gKmZzX2lu
Zm8sIFwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpwYWdlLCB1NjQg
c3RhcnQsIHUzMiBsZW4pwqDCoMKgwqDCoMKgwqAgXA0KPj4gK3vCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+
ICvCoMKgwqAgaWYgKHVubGlrZWx5KCFmc19pbmZvKSB8fCBmc19pbmZvLT5zZWN0b3JzaXplID09
IFBBR0VfU0laRSkge8KgwqDCoCBcDQo+PiArwqDCoMKgwqDCoMKgwqAgY2xlYXJfcGFnZV9mdW5j
KHBhZ2UpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm47wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAgYnRyZnNf
c3VicGFnZV9jbGVhcl8jI25hbWUoZnNfaW5mbywgcGFnZSwgc3RhcnQsIGxlbik7wqDCoMKgwqDC
oMKgwqAgXA0KPj4gK33CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgYnRy
ZnNfcGFnZV90ZXN0XyMjbmFtZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyANCj4+ICpmc19pbmZvLCBc
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFnZSAqcGFnZSwgdTY0IHN0YXJ0
LCB1MzIgbGVuKcKgwqDCoMKgwqDCoMKgIFwNCj4+ICt7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+PiArwqDC
oMKgIGlmICh1bmxpa2VseSghZnNfaW5mbykgfHwgZnNfaW5mby0+c2VjdG9yc2l6ZSA9PSBQQUdF
X1NJWkUpwqDCoMKgIFwNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gdGVzdF9wYWdlX2Z1bmMo
cGFnZSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAgcmV0dXJu
IGJ0cmZzX3N1YnBhZ2VfdGVzdF8jI25hbWUoZnNfaW5mbywgcGFnZSwgc3RhcnQsIGxlbik7wqDC
oMKgIFwNCj4+ICt9DQo+IA0KPiBBbm90aGVyIHRoaW5nIEkganVzdCByZWFsaXplZCBpcyB5b3Un
cmUgZG9pbmcgdGhpcw0KPiANCj4gYnRyZnNfcGFnZV9zZXRfdXB0b2RhdGUoZnNfaW5mbywgcGFn
ZSwgZWItPnN0YXJ0LCBlYi0+bGVuKTsNCj4gDQo+IGJ1dCB3ZSBkZWZhdWx0IHRvIGEgbm9kZXNp
emUgPiBQQUdFX1NJWkUgb24geDg2LsKgIFRoaXMgaXMgZmluZSwgYmVjYXVzZSANCj4geW91J3Jl
IGNoZWNraW5nIGZzX2luZm8tPnNlY3RvcnNpemUgPT0gUEFHRV9TSVpFLCB3aGljaCB3aWxsIG1l
YW4gd2UgZG8gDQo+IHRoZSByaWdodCB0aGluZy4NCj4gDQo+IEJ1dCB3aGF0IGhhcHBlbnMgaWYg
ZnNfaW5mby0+bm9kZXNpemUgPCBQQUdFX1NJWkUgJiYgZnNfaW5mby0+c2VjdG9yc2l6ZSANCj4g
PT0gUEFHRV9TSVpFP8KgIFdlIGJ5IGRlZmF1bHQgaGF2ZSBmcydlcyB0aGF0IC0+bm9kZXNpemUg
IT0gLT5zZWN0b3JzaXplLCANCj4gc28gcmVhbGx5IHdoYXQgd2Ugc2hvdWxkIGJlIGRvaW5nIGlz
IGNoZWNraW5nIGlmIGxlbiA9PSBQQUdFX1NJWkUgaGVyZSwgDQo+IGJ1dCB0aGVuIHlvdSBuZWVk
IHRvIHRha2UgaW50byBhY2NvdW50IHRoZSBjYXNlIHRoYXQgZWItPmxlbiA+IA0KPiBQQUdFX1NJ
WkUuwqAgRml4IHRoaXMgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nIGluIGVpdGhlciBvZiB0aG9zZSBj
YXNlcy4gIA0KPiBUaGFua3MsDQoNCkltcG9zc2libGUuDQoNCk5vZGVzaXplIG11c3QgYmUgPj0g
c2VjdG9yc2l6ZS4NCg0KQXMgc2VjdG9yc2l6ZSBpcyBjdXJyZW50bHkgdGhlIG1pbmltYWwgYWNj
ZXNzIHVuaXQgZm9yIGJvdGggZGF0YSBhbmQgDQptZXRhZGF0YS4NCg0KVGhhbmtzLA0KUXUNCg0K
PiANCj4gSm9zZWYNCg==
