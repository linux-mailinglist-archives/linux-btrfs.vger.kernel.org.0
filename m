Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC73A3B97
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFKGEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 02:04:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:36753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhFKGEn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 02:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623391359;
        bh=2xgoGa1/BbkDDpkVALi9GTfq6RlXFVf+LHgq5L+oj/o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j2Jg7Mp6mjLblrNOdo2vhah9Li9XL1wANU8mXWXn2OZUrrSKGdr6F39qnfL+duD8N
         +MMeniCta4c87PlInecIvv8WZe+/I6K8soxUJcYP7UiHa/l95O/aWOre3upfjlOHk7
         6r17TV0eL0vhfvP9HVLz1L39t/VyLO5NI1Sap9ZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QFB-1lsxIJ148D-001PGk; Fri, 11
 Jun 2021 08:02:38 +0200
Subject: Re: [PATCH 2/9] btrfs: add compressed_bio::io_sectors to trace
 compressed bio more elegantly
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-3-wqu@suse.com>
 <1d315909-b51c-c74a-a7f2-60d71b637886@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ec916f2a-80fd-f456-0073-e3c42bd6034b@gmx.com>
Date:   Fri, 11 Jun 2021 14:02:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d315909-b51c-c74a-a7f2-60d71b637886@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:3zQl8lYiCKIe80Fw+c9vTjMz4uXDa9w41aHAh+bDBje9Fplzaxt
 bWkOEGFJKZXcjKXZADbxkn554rP/wWsxSb4knwlNqYNEXTz1N3psiW2ElOai2absYRfjAjM
 gMdmHdKFNUr5AHKN5uUqcHFYA0t81Mit5fMATzI3jZK2iNx9d54pBvIBKkXskafwhAlKMQC
 oRseo2oIIJUflvxvGhZKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tnmxHMRDXCk=:ZN2J1xlNwIZUUOB6W81nFr
 C5LpgwsjnCOP2bXZxI5EeE+K4sjpZXRm8ouPbogDytXf8pYO15YIstq99vp6MINgPFEOkR2lO
 /tO0S4g4eBqLXsxru6U0g4SjYh+rRV1mwpBg1kP97wfKxvBjbWYkn13Z8OsPTt2+EzOn1gu0m
 a66LFwYvQYq/+jqd6BK0M7OEpHd9CT5yZCxKYRsdXnyvAlby6EXOAnzQzjTt7k9X/IVmOHcSg
 LnjxRd1QyCiMJlNectejOFcnndgmtFvkyYEDrwHnf5TbGRJiP3Sopu/ubDVMqNX8Oaa/0fxKM
 p2bQ68FNifP/63p/OJsur+sai7c3DHwVJxUJGOaY1ZacztwFMjl4EtJkogGgYwPpSLpew0JCQ
 r/0+GybdDoLpUqFgQ6PFf7GqvYqy0UOqL0MTbx/vLC75TmIPjsZ7zv7PEf8DLa02TK13BPlul
 RapScH+Fbigun6iuM7xZv7rtOWGwijLIWAIjZsTeWwenYAGU/WIj/WZAPbxQMO8xV88cebF/k
 FIcp8+wSnH2a2s8NgJd0iaz+unCe4gxJcWBnXtiOsa7JYiz8mTu/xjol9aggI79Sk509rDyIJ
 ZCZ25WUsLeKWS9r8IlKbcdO9yxFMcp9dgietPZapUccm+g6/u2s56YTaxoURHvpbrNgGO105O
 CePhMyVTjAMEx4I3FS16t9aaOQZW/jM9Qm5Ofz67LHUe9wYU9eamAg4KSIK8HP3YhGrJ2KI4l
 iKkY2t1Lby3S81Bym2iY/73qRiW1pBgybzxhrH5lB55+hDOV9F31UL9u2K053FLjACBnsWsoN
 mgI9n2y3w5eHmAxbSBc7d0aSozgLbvYJQc1Lb0vP76SIuhCw77tLzO5GG3hDwlX6bptk72d2Z
 qyKrtKRdQIpmzFYR0/1XijB1A5Bbd0yNEXTjbKim+oPI4ewK2KK76u3aPjLJCGRAUQYOzNrAy
 iyRG4yf9CN2ANW73a6Wg7Xb/M4vtjdTyyOFKfOr6kpGhUuu5mYDj11O3juElyqbanPlK5XlKJ
 TDxBiZqA9vCX1ByfogPHHnQhvqpd/DNQ6QJoEQmYh7DmCgDwlWvg069LfgSKfYXM8w14K5u1r
 XaEq2DYaHsl26bSR1hrnbubLMVHK9ioeDZQ6WhMYo/M6wwL+cRLIH+lMw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjEvNi8xMSDkuIvljYgxMjoxOCwgQW5hbmQgSmFpbiB3cm90ZToNCj4gT24gMTEv
Ni8yMSA5OjMxIGFtLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBGb3IgYnRyZnNfc3VibWl0X2NvbXBy
ZXNzZWRfcmVhZCgpIGFuZCBidHJmc19zdWJtaXRfY29tcHJlc3NlZF93cml0ZSgpLA0KPj4gd2Ug
aGF2ZSBhIHByZXR0eSB3ZWlyZCBkYW5jZSBhcm91bmQgY29tcHJlc3NlZF9iaW86OmlvX3NlY3Rv
cnM6DQo+IA0KPiBJIGRvbid0IHNlZSBpb19zZWN0b3JzIG1lbWJlciBmb3IgdGhlIHN0cnVjdCBj
b21wcmVzc2VkX2JpbyBpbiB0aGUgDQo+IGN1cnJlbnQgbWlzYy1uZXh0LiBJdCBpcyBub3QgbWVu
dGlvbmVkIGluIHRoZSBjb3ZlciBsZXR0ZXIsIGJ1dCBpcyB0aGlzIA0KPiBzZXJpZXMgYSBwYXJ0
IG9mIHNvbWUgb3RoZXIgcGF0Y2ggc2V0IHlldCB0byBpbnRlZ3JhdGUgaW50byBtaXNjLW5leHQ/
IA0KPiBPUiBjYW4gdGhpcyBzZXJpZXMgYmUgcmUtYmFzZWQgb24gY3VycmVudCBtaXNjLW5leHQ/
DQoNCk15IGJhZCwgdGhlIHdyb25nIHZhcmlhYmxlIG5hbWUgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KDQpJdCBzaG91bGQgYmUgY29tcHJlc3NlZF9iaW86OnBlbmRpbmdfYmlvcy4NCg0KVGhlIGlv
X3NlY3RvcnMgaXMgYWRkZWQgdG8gYWRkcmVzcyB0aGUgcHJvYmxlbS4NCg0KVGhhbmtzLA0KUXUN
Cj4gDQo+IFRoYW5rcywgQW5hbmQNCj4gDQo+IA0KPj4NCj4+IMKgwqAgYnRyZnNfc3VibWl0X2Nv
bXByZXNzZWRfcmVhZC93cml0ZSgpDQo+PiDCoMKgIHsNCj4+IMKgwqDCoMKgY2IgPSBrbWFsbG9j
KCkNCj4+IMKgwqDCoMKgcmVmY291bnRfc2V0KCZjYi0+cGVuZGluZ19iaW9zLCAwKTsNCj4+IMKg
wqDCoMKgYmlvID0gYnRyZnNfYWxsb2NfYmlvKCk7DQo+Pg0KPj4gwqDCoMKgwqAvKiBOT1RFIGhl
cmUsIHdlIGhhdmVuJ3QgeWV0IHN1Ym1pdHRlZCBhbnkgYmlvICovDQo+PiDCoMKgwqDCoHJlZmNv
dW50X3NldCgmY2ItPnBlbmRpbmdfYmlvcywgMSk7DQo+Pg0KPj4gwqDCoMKgwqBmb3IgKHBnX2lu
ZGV4ID0gMDsgcGdfaW5kZXggPCBjYi0+bnJfcGFnZXM7IHBnX2luZGV4KyspIHsNCj4+IMKgwqDC
oMKgwqDCoMKgIGlmIChzdWJtaXQpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogSGVy
ZSB3ZSBzdWJtaXQgYmlvLCBidXQgd2UgYWx3YXlzIGhhdmUgb25lDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBleHRyYSBwZW5kaW5nX2Jpb3MgKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmVmY291bnRfaW5jKCZjYi0+cGVuZGluZ19iaW9zKTsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0ID0gYnRyZnNfbWFwX2JpbygpOw0KPj4gwqDCoMKgwqDCoMKgwqAgfQ0KPj4g
wqDCoMKgwqB9DQo+Pg0KPj4gwqDCoMKgwqAvKiBTdWJtaXQgdGhlIGxhc3QgYmlvICovDQo+PiDC
oMKgwqDCoHJldCA9IGJ0cmZzX21hcF9iaW8oKTsNCj4+IMKgwqAgfQ0KPj4NCj4+IFRoZXJlIGFy
ZSB0d28gcmVhc29ucyB3aHkgd2UgZG8gdGhpczoNCj4+DQo+PiAtIGNvbXByZXNzZWRfYmlvOjpw
ZW5kaW5nX2Jpb3MgaXMgYSByZWZjb3VudA0KPj4gwqDCoCBUaHVzIGlmIGl0J3MgcmVkdWNlZCB0
byAwLCBpdCBjYW4gbm90IGJlIGluY3JlYXNlZCBhZ2Fpbi4NCj4+DQo+PiAtIFRvIGVuc3VyZSB0
aGUgY29tcHJlc3NlZF9iaW8gaXMgbm90IGZyZWVkIGJ5IHNvbWUgc3VibWl0dGVkIGJpb3MNCj4+
IMKgwqAgSWYgdGhlIHN1Ym1pdHRlZCBiaW8gaXMgZmluaXNoZWQgYmVmb3JlIHRoZSBuZXh0IGJp
byBzdWJtaXR0ZWQsDQo+PiDCoMKgIHdlIGNhbiBmcmVlIHRoZSBjb21wcmVzc2VkX2JpbyBjb21w
bGV0ZWx5Lg0KPj4NCj4+IEJ1dCB0aGUgYWJvdmUgY29kZSBpcyBzb21ldGltZXMgY29uZnVzaW5n
LCBhbmQgd2UgY2FuIGRvIGl0IGJldHRlciBieQ0KPj4ganVzdCBpbnRyb2R1Y2UgYSBuZXcgbWVt
YmVyLCBjb21wcmVzc2VkX2Jpbzo6aW9fc2VjdG9ycy4NCj4+DQo+PiBXaXRoIHRoYXQgbWVtYmVy
LCB3ZSBjYW4gZWFzaWx5IGRpc3Rpbmd1aXNoIGlmIHdlJ3JlIHJlYWxseSB0aGUgbGFzdA0KPj4g
YmlvIGF0IGVuZGlvIHRpbWUsIGFuZCBldmVuIGFsbG93cyB1cyB0byByZW1vdmUgc29tZSBCVUdf
T04oKSBsYXRlciwNCj4+IGFzIHdlIG5vdyBrbm93IGhvdyBtYW55IGJ5dGVzIGFyZSBub3QgeWV0
IHN1Ym1pdHRlZC4NCj4+DQo+PiBXaXRoIHRoaXMgbmV3IG1lbWJlciwgbm93IGNvbXByZXNzZWRf
YmlvOjpwZW5kaW5nX2Jpb3MgcmVhbGx5IGluZGljYXRlcw0KPj4gdGhlIHBlbmRpbmcgYmlvcywg
d2l0aG91dCBhbnkgc3BlY2lhbCBoYW5kbGluZyBuZWVkZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+PiAtLS0NCj4+IMKgIGZzL2J0cmZzL2NvbXBy
ZXNzaW9uLmMgfCA3MSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+IMKgIGZzL2J0cmZzL2NvbXByZXNzaW9uLmggfCAxMCArKysrKy0NCj4+IMKgIDIgZmlsZXMg
Y2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL2NvbXByZXNzaW9uLmMgYi9mcy9idHJmcy9jb21wcmVzc2lvbi5jDQo+
PiBpbmRleCBmYzRmMzdhZGI3YjcuLmM5ZGJlMzA2ZjZiYSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0
cmZzL2NvbXByZXNzaW9uLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL2NvbXByZXNzaW9uLmMNCj4+IEBA
IC0xOTMsNiArMTkzLDM0IEBAIHN0YXRpYyBpbnQgY2hlY2tfY29tcHJlc3NlZF9jc3VtKHN0cnVj
dCANCj4+IGJ0cmZzX2lub2RlICppbm9kZSwgc3RydWN0IGJpbyAqYmlvLA0KPj4gwqDCoMKgwqDC
oCByZXR1cm4gMDsNCj4+IMKgIH0NCj4+ICsvKg0KPj4gKyAqIFJlZHVjZSBiaW8gYW5kIGlvIGFj
Y291bnRpbmcgZm9yIGEgY29tcHJlc3NlZF9iaW8gd2l0aCBpdHMgDQo+PiBjb3Jlc3BvbmRpbmcg
YmlvLg0KPj4gKyAqDQo+PiArICogUmV0dXJuIHRydWUgaWYgdGhlcmUgaXMgbm8gcGVuZGluZyBi
aW8gbm9yIGlvLg0KPj4gKyAqIFJldHVybiBmYWxzZSBvdGhlcndpc2UuDQo+PiArICovDQo+PiAr
c3RhdGljIGJvb2wgZGVjX2FuZF90ZXN0X2NvbXByZXNzZWRfYmlvKHN0cnVjdCBjb21wcmVzc2Vk
X2JpbyAqY2IsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGJpbyAqYmlvKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8gPSBidHJmc19zYihjYi0+aW5vZGUtPmlfc2IpOw0KPj4gK8KgwqDCoCB1bnNpZ25lZCBp
bnQgYmlfc2l6ZSA9IGJpby0+YmlfaXRlci5iaV9zaXplOw0KPj4gK8KgwqDCoCBib29sIGxhc3Rf
YmlvID0gZmFsc2U7DQo+PiArwqDCoMKgIGJvb2wgbGFzdF9pbyA9IGZhbHNlOw0KPj4gKw0KPj4g
K8KgwqDCoCBpZiAoYmlvLT5iaV9zdGF0dXMpDQo+PiArwqDCoMKgwqDCoMKgwqAgY2ItPmVycm9y
cyA9IDE7DQo+PiArDQo+PiArwqDCoMKgIGxhc3RfYmlvID0gYXRvbWljX2RlY19hbmRfdGVzdCgm
Y2ItPnBlbmRpbmdfYmlvcyk7DQo+PiArwqDCoMKgIGxhc3RfaW8gPSBhdG9taWNfc3ViX2FuZF90
ZXN0KGJpX3NpemUgPj4gZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZjYi0+aW9fc2VjdG9ycyk7DQo+PiAr
DQo+PiArwqDCoMKgIC8qDQo+PiArwqDCoMKgwqAgKiBXZSBjYW4gb25seSBmaW5pc2ggdGhlIGNv
bXByZXNzZWQgYmlvIGlmIG5vIHBlbmRpbmcgYmlvIGFuZCANCj4+IGFsbCBpbw0KPj4gK8KgwqDC
oMKgICogc3VibWl0dGVkLg0KPj4gK8KgwqDCoMKgICovDQo+PiArwqDCoMKgIHJldHVybiBsYXN0
X2JpbyAmJiBsYXN0X2lvOw0KPj4gK30NCj4+ICsNCj4+IMKgIC8qIHdoZW4gd2UgZmluaXNoIHJl
YWRpbmcgY29tcHJlc3NlZCBwYWdlcyBmcm9tIHRoZSBkaXNrLCB3ZQ0KPj4gwqDCoCAqIGRlY29t
cHJlc3MgdGhlbSBhbmQgdGhlbiBydW4gdGhlIGJpbyBlbmRfaW8gcm91dGluZXMgb24gdGhlDQo+
PiDCoMKgICogZGVjb21wcmVzc2VkIHBhZ2VzIChpbiB0aGUgaW5vZGUgYWRkcmVzcyBzcGFjZSku
DQo+PiBAQCAtMjEyLDEzICsyNDAsNyBAQCBzdGF0aWMgdm9pZCBlbmRfY29tcHJlc3NlZF9iaW9f
cmVhZChzdHJ1Y3QgYmlvICpiaW8pDQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBtaXJyb3Ig
PSBidHJmc19pb19iaW8oYmlvKS0+bWlycm9yX251bTsNCj4+IMKgwqDCoMKgwqAgaW50IHJldCA9
IDA7DQo+PiAtwqDCoMKgIGlmIChiaW8tPmJpX3N0YXR1cykNCj4+IC3CoMKgwqDCoMKgwqDCoCBj
Yi0+ZXJyb3JzID0gMTsNCj4+IC0NCj4+IC3CoMKgwqAgLyogaWYgdGhlcmUgYXJlIG1vcmUgYmlv
cyBzdGlsbCBwZW5kaW5nIGZvciB0aGlzIGNvbXByZXNzZWQNCj4+IC3CoMKgwqDCoCAqIGV4dGVu
dCwganVzdCBleGl0DQo+PiAtwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqAgaWYgKCFyZWZjb3VudF9k
ZWNfYW5kX3Rlc3QoJmNiLT5wZW5kaW5nX2Jpb3MpKQ0KPj4gK8KgwqDCoCBpZiAoIWRlY19hbmRf
dGVzdF9jb21wcmVzc2VkX2JpbyhjYiwgYmlvKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3Rv
IG91dDsNCj4+IMKgwqDCoMKgwqAgLyoNCj4+IEBAIC0zMzYsMTMgKzM1OCw3IEBAIHN0YXRpYyB2
b2lkIGVuZF9jb21wcmVzc2VkX2Jpb193cml0ZShzdHJ1Y3QgYmlvIA0KPj4gKmJpbykNCj4+IMKg
wqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2U7DQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcg
aW5kZXg7DQo+PiAtwqDCoMKgIGlmIChiaW8tPmJpX3N0YXR1cykNCj4+IC3CoMKgwqDCoMKgwqDC
oCBjYi0+ZXJyb3JzID0gMTsNCj4+IC0NCj4+IC3CoMKgwqAgLyogaWYgdGhlcmUgYXJlIG1vcmUg
YmlvcyBzdGlsbCBwZW5kaW5nIGZvciB0aGlzIGNvbXByZXNzZWQNCj4+IC3CoMKgwqDCoCAqIGV4
dGVudCwganVzdCBleGl0DQo+PiAtwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqAgaWYgKCFyZWZjb3Vu
dF9kZWNfYW5kX3Rlc3QoJmNiLT5wZW5kaW5nX2Jpb3MpKQ0KPj4gK8KgwqDCoCBpZiAoIWRlY19h
bmRfdGVzdF9jb21wcmVzc2VkX2JpbyhjYiwgYmlvKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIG91dDsNCj4+IMKgwqDCoMKgwqAgLyogb2ssIHdlJ3JlIHRoZSBsYXN0IGJpbyBmb3IgdGhp
cyBleHRlbnQsIHN0ZXAgb25lIGlzIHRvDQo+PiBAQCAtNDA4LDcgKzQyNCw4IEBAIGJsa19zdGF0
dXNfdCBidHJmc19zdWJtaXRfY29tcHJlc3NlZF93cml0ZShzdHJ1Y3QgDQo+PiBidHJmc19pbm9k
ZSAqaW5vZGUsIHU2NCBzdGFydCwNCj4+IMKgwqDCoMKgwqAgY2IgPSBrbWFsbG9jKGNvbXByZXNz
ZWRfYmlvX3NpemUoZnNfaW5mbywgY29tcHJlc3NlZF9sZW4pLCANCj4+IEdGUF9OT0ZTKTsNCj4+
IMKgwqDCoMKgwqAgaWYgKCFjYikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX1NU
U19SRVNPVVJDRTsNCj4+IC3CoMKgwqAgcmVmY291bnRfc2V0KCZjYi0+cGVuZGluZ19iaW9zLCAw
KTsNCj4+ICvCoMKgwqAgYXRvbWljX3NldCgmY2ItPnBlbmRpbmdfYmlvcywgMCk7DQo+PiArwqDC
oMKgIGF0b21pY19zZXQoJmNiLT5pb19zZWN0b3JzLCBjb21wcmVzc2VkX2xlbiA+PiANCj4+IGZz
X2luZm8tPnNlY3RvcnNpemVfYml0cyk7DQo+PiDCoMKgwqDCoMKgIGNiLT5lcnJvcnMgPSAwOw0K
Pj4gwqDCoMKgwqDCoCBjYi0+aW5vZGUgPSAmaW5vZGUtPnZmc19pbm9kZTsNCj4+IMKgwqDCoMKg
wqAgY2ItPnN0YXJ0ID0gc3RhcnQ7DQo+PiBAQCAtNDQxLDcgKzQ1OCw2IEBAIGJsa19zdGF0dXNf
dCBidHJmc19zdWJtaXRfY29tcHJlc3NlZF93cml0ZShzdHJ1Y3QgDQo+PiBidHJmc19pbm9kZSAq
aW5vZGUsIHU2NCBzdGFydCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBiaW8tPmJpX29wZiB8PSBS
RVFfQ0dST1VQX1BVTlQ7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAga3RocmVhZF9hc3NvY2lhdGVf
YmxrY2coYmxrY2dfY3NzKTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gLcKgwqDCoCByZWZjb3VudF9z
ZXQoJmNiLT5wZW5kaW5nX2Jpb3MsIDEpOw0KPj4gwqDCoMKgwqDCoCAvKiBjcmVhdGUgYW5kIHN1
Ym1pdCBiaW9zIGZvciB0aGUgY29tcHJlc3NlZCBwYWdlcyAqLw0KPj4gwqDCoMKgwqDCoCBieXRl
c19sZWZ0ID0gY29tcHJlc3NlZF9sZW47DQo+PiBAQCAtNDYyLDEzICs0NzgsNyBAQCBibGtfc3Rh
dHVzX3QgYnRyZnNfc3VibWl0X2NvbXByZXNzZWRfd3JpdGUoc3RydWN0IA0KPj4gYnRyZnNfaW5v
ZGUgKmlub2RlLCB1NjQgc3RhcnQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZS0+bWFwcGlu
ZyA9IE5VTEw7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN1Ym1pdCB8fCBsZW4gPCBQQUdF
X1NJWkUpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogaW5jIHRoZSBjb3VudCBiZWZvcmUgd2Ugc3VibWl0IHRoZSBiaW8gc28N
Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB3ZSBrbm93IHRoZSBlbmQgSU8gaGFuZGxl
ciB3b24ndCBoYXBwZW4gYmVmb3JlDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2Ug
aW5jIHRoZSBjb3VudC7CoCBPdGhlcndpc2UsIHRoZSBjYiBtaWdodCBnZXQNCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBmcmVlZCBiZWZvcmUgd2UncmUgZG9uZSBzZXR0aW5nIGl0IHVw
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZWZjb3VudF9pbmMoJmNiLT5wZW5kaW5nX2Jpb3MpOw0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYXRvbWljX2luYygmY2ItPnBlbmRpbmdfYmlvcyk7DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXQgPSBidHJmc19iaW9fd3FfZW5kX2lvKGZzX2luZm8sIGJpbywNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBC
VFJGU19XUV9FTkRJT19EQVRBKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJVR19P
TihyZXQpOyAvKiAtRU5PTUVNICovDQo+PiBAQCAtNTA2LDYgKzUxNiw3IEBAIGJsa19zdGF0dXNf
dCBidHJmc19zdWJtaXRfY29tcHJlc3NlZF93cml0ZShzdHJ1Y3QgDQo+PiBidHJmc19pbm9kZSAq
aW5vZGUsIHU2NCBzdGFydCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjb25kX3Jlc2NoZWQoKTsN
Cj4+IMKgwqDCoMKgwqAgfQ0KPj4gK8KgwqDCoCBhdG9taWNfaW5jKCZjYi0+cGVuZGluZ19iaW9z
KTsNCj4+IMKgwqDCoMKgwqAgcmV0ID0gYnRyZnNfYmlvX3dxX2VuZF9pbyhmc19pbmZvLCBiaW8s
IEJUUkZTX1dRX0VORElPX0RBVEEpOw0KPj4gwqDCoMKgwqDCoCBCVUdfT04ocmV0KTsgLyogLUVO
T01FTSAqLw0KPj4gQEAgLTY4OSw3ICs3MDAsOCBAQCBibGtfc3RhdHVzX3QgYnRyZnNfc3VibWl0
X2NvbXByZXNzZWRfcmVhZChzdHJ1Y3QgDQo+PiBpbm9kZSAqaW5vZGUsIHN0cnVjdCBiaW8gKmJp
bywNCj4+IMKgwqDCoMKgwqAgaWYgKCFjYikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dDsNCj4+IC3CoMKgwqAgcmVmY291bnRfc2V0KCZjYi0+cGVuZGluZ19iaW9zLCAwKTsNCj4+ICvC
oMKgwqAgYXRvbWljX3NldCgmY2ItPnBlbmRpbmdfYmlvcywgMCk7DQo+PiArwqDCoMKgIGF0b21p
Y19zZXQoJmNiLT5pb19zZWN0b3JzLCBjb21wcmVzc2VkX2xlbiA+PiANCj4+IGZzX2luZm8tPnNl
Y3RvcnNpemVfYml0cyk7DQo+PiDCoMKgwqDCoMKgIGNiLT5lcnJvcnMgPSAwOw0KPj4gwqDCoMKg
wqDCoCBjYi0+aW5vZGUgPSBpbm9kZTsNCj4+IMKgwqDCoMKgwqAgY2ItPm1pcnJvcl9udW0gPSBt
aXJyb3JfbnVtOw0KPj4gQEAgLTczNCw3ICs3NDYsNiBAQCBibGtfc3RhdHVzX3QgYnRyZnNfc3Vi
bWl0X2NvbXByZXNzZWRfcmVhZChzdHJ1Y3QgDQo+PiBpbm9kZSAqaW5vZGUsIHN0cnVjdCBiaW8g
KmJpbywNCj4+IMKgwqDCoMKgwqAgY29tcF9iaW8tPmJpX29wZiA9IFJFUV9PUF9SRUFEOw0KPj4g
wqDCoMKgwqDCoCBjb21wX2Jpby0+YmlfcHJpdmF0ZSA9IGNiOw0KPj4gwqDCoMKgwqDCoCBjb21w
X2Jpby0+YmlfZW5kX2lvID0gZW5kX2NvbXByZXNzZWRfYmlvX3JlYWQ7DQo+PiAtwqDCoMKgIHJl
ZmNvdW50X3NldCgmY2ItPnBlbmRpbmdfYmlvcywgMSk7DQo+PiDCoMKgwqDCoMKgIGZvciAocGdf
aW5kZXggPSAwOyBwZ19pbmRleCA8IG5yX3BhZ2VzOyBwZ19pbmRleCsrKSB7DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgdTMyIHBnX2xlbiA9IFBBR0VfU0laRTsNCj4+IEBAIC03NjMsMTggKzc3NCwx
MSBAQCBibGtfc3RhdHVzX3QgYnRyZnNfc3VibWl0X2NvbXByZXNzZWRfcmVhZChzdHJ1Y3QgDQo+
PiBpbm9kZSAqaW5vZGUsIHN0cnVjdCBiaW8gKmJpbywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoc3VibWl0IHx8IGJpb19hZGRfcGFnZShjb21wX2JpbywgcGFnZSwgcGdfbGVuLCAwKSA8IA0K
Pj4gcGdfbGVuKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQg
bnJfc2VjdG9yczsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0b21pY19pbmMoJmNiLT5w
ZW5kaW5nX2Jpb3MpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gYnRyZnNf
YmlvX3dxX2VuZF9pbyhmc19pbmZvLCBjb21wX2JpbywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVFJGU19XUV9FTkRJT19EQVRBKTsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJVR19PTihyZXQpOyAvKiAtRU5PTUVNICov
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIGluYyB0aGUgY291bnQgYmVmb3JlIHdlIHN1Ym1pdCB0aGUgYmlvIHNvDQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2Uga25vdyB0aGUgZW5kIElPIGhhbmRsZXIgd29uJ3Qg
aGFwcGVuIGJlZm9yZQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHdlIGluYyB0aGUg
Y291bnQuwqAgT3RoZXJ3aXNlLCB0aGUgY2IgbWlnaHQgZ2V0DQo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogZnJlZWQgYmVmb3JlIHdlJ3JlIGRvbmUgc2V0dGluZyBpdCB1cA0KPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVm
Y291bnRfaW5jKCZjYi0+cGVuZGluZ19iaW9zKTsNCj4+IC0NCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldCA9IGJ0cmZzX2xvb2t1cF9iaW9fc3Vtcyhpbm9kZSwgY29tcF9iaW8sIHN1
bXMpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQlVHX09OKHJldCk7IC8qIC1FTk9N
RU0gKi8NCj4+IEBAIC03OTgsNiArODAyLDcgQEAgYmxrX3N0YXR1c190IGJ0cmZzX3N1Ym1pdF9j
b21wcmVzc2VkX3JlYWQoc3RydWN0IA0KPj4gaW5vZGUgKmlub2RlLCBzdHJ1Y3QgYmlvICpiaW8s
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY3VyX2Rpc2tfYnl0ZSArPSBwZ19sZW47DQo+PiDCoMKg
wqDCoMKgIH0NCj4+ICvCoMKgwqAgYXRvbWljX2luYygmY2ItPnBlbmRpbmdfYmlvcyk7DQo+PiDC
oMKgwqDCoMKgIHJldCA9IGJ0cmZzX2Jpb193cV9lbmRfaW8oZnNfaW5mbywgY29tcF9iaW8sIEJU
UkZTX1dRX0VORElPX0RBVEEpOw0KPj4gwqDCoMKgwqDCoCBCVUdfT04ocmV0KTsgLyogLUVOT01F
TSAqLw0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2NvbXByZXNzaW9uLmggYi9mcy9idHJmcy9j
b21wcmVzc2lvbi5oDQo+PiBpbmRleCA4MDAxYjcwMGVhM2EuLjNkZjMyNjJmZWRjZCAxMDA2NDQN
Cj4+IC0tLSBhL2ZzL2J0cmZzL2NvbXByZXNzaW9uLmgNCj4+ICsrKyBiL2ZzL2J0cmZzL2NvbXBy
ZXNzaW9uLmgNCj4+IEBAIC0yOSw3ICsyOSwxNSBAQCBzdHJ1Y3QgYnRyZnNfaW5vZGU7DQo+PiDC
oCBzdHJ1Y3QgY29tcHJlc3NlZF9iaW8gew0KPj4gwqDCoMKgwqDCoCAvKiBudW1iZXIgb2YgYmlv
cyBwZW5kaW5nIGZvciB0aGlzIGNvbXByZXNzZWQgZXh0ZW50ICovDQo+PiAtwqDCoMKgIHJlZmNv
dW50X3QgcGVuZGluZ19iaW9zOw0KPj4gK8KgwqDCoCBhdG9taWNfdCBwZW5kaW5nX2Jpb3M7DQo+
PiArDQo+PiArwqDCoMKgIC8qDQo+PiArwqDCoMKgwqAgKiBOdW1iZXIgb2Ygc2VjdG9ycyB3aGlj
aCBoYXNuJ3QgZmluaXNoZWQuDQo+PiArwqDCoMKgwqAgKg0KPj4gK8KgwqDCoMKgICogQ29tYmlu
ZWQgd2l0aCBwZW5kaW5nX2Jpb3MsIHdlIGNhbiBtYW51YWxseSBmaW5pc2ggdGhlIA0KPj4gY29t
cHJlc3NlZF9iaW8NCj4+ICvCoMKgwqDCoCAqIGlmIHdlIGhpdCBzb21lIGVycm9yIHdoaWxlIHRo
ZXJlIGlzIHN0aWxsIHNvbWUgcGFnZXMgbm90IGFkZGVkLg0KPj4gK8KgwqDCoMKgICovDQo+PiAr
wqDCoMKgIGF0b21pY190IGlvX3NlY3RvcnM7DQo+PiDCoMKgwqDCoMKgIC8qIHRoZSBwYWdlcyB3
aXRoIHRoZSBjb21wcmVzc2VkIGRhdGEgb24gdGhlbSAqLw0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
cGFnZSAqKmNvbXByZXNzZWRfcGFnZXM7DQo+Pg0KPiANCg==
