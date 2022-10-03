Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2D5F39D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 01:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJCX2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJCX2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 19:28:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1B1EC6F
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664839721;
        bh=6HnCOc8T55ecYISyQ3uuh8ygDV4eiwrR73KqlchwQE8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QabgXMJ9ZPL2KQ46cTF54V/u96g74bT0wxTFxbJ0wkrxOJ5EYnziQLpT878jO6BjF
         31tvkHRL4IDphGgBBoiRV7TQpWYFc5hQzsvvsB3wdlP2f/1/AZg6O64sT7vLVYSiBC
         l6P705sC5usuqhUKAqID0+VV/d+VQd7Xpa/N4V6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1oVImL0ZuH-00COt7; Tue, 04
 Oct 2022 01:28:40 +0200
Message-ID: <2741b7c3-4036-50d7-26ea-aa32dd8ae466@gmx.com>
Date:   Tue, 4 Oct 2022 07:28:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from extent
 tree v2
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
 <6a15fb3d-a769-1ffd-72b5-a3492b91919f@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6a15fb3d-a769-1ffd-72b5-a3492b91919f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:L9ttgs15kzepjIw6cJ4MxW9ZxGBWlV72T3X3W/rdR94gPIP7cIK
 MsSrwwxrW1PiII88UEk4OjEr9h4v9qkp8p03iXkP7IEZr2GgeaiQCK+3SKnqFfb4AbvVo3T
 gjGMlKIgjgaerYOcIFAdqeYkEHsgXPnne6GBjRgaEh5kbYiRG3QuUbvuRkJfnGAfpYL7up0
 1Pif6qbNXnSG2j+hPjQdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A0CI/Rlr0ic=:qGm4mDaVGnz0p1tf+a07Lh
 EckfgBQnU4+/x1xW/YlIUG0jqXURyGo5x7qXYrWa0fp5Tu8Mp/1YIZNCtRGTwkSct7/sSJDMg
 PwQjt/kRl0Erpa52EKtqPTzyoEYoTDm6y4R/xrBfIc70x5uuBjqAnU1xLW/02sLr56jOePU3t
 Pylw/iEmXZHVZ46IreHoDwMtW8Z1dZltgsgWSzw+Kiv4j0nkYXKbX87cWppLrXJqNP7C71u9d
 tWe1saO/aypvnoKh0UYyMZhp68LTYU+ETR1X/fDcEzLjM+p00Qn1p0STkEPw8tluiHxI73osa
 jzvEpVNVXfmBGVvgHx76N37nJ9q3+PXzQAbET4MLZfVXZGYxQw+RraVxGkqSnw5yEb0fXeUzA
 dkqfuqHOjQ8mQUDPmCdTt+0CHJaJCekyyRvrLaTzIjQ2zjkLLYSr7nQQoE30+Of3zmyK5je9S
 tZW/Y7SzWkRzN33s99stM/Bu7xZgi3XaVtVJ5mUFRd9JRgiC5mOLVhM90PXQ4GFee8IrgHYbl
 PJD6uC0F/V9uQpfysb0/yJjPPD/fdvKJdN94HC/0AVa2EtUgDJbQDCjRzi7/n4EZONlQcVNag
 LAYXOPvKnpwQYkjDaNF7r8aTVaWCYXsbVyjAgRwvTckq6iMa6u+WI5v/Caz+rSU48iFkqNKPm
 s7+W+WkwzDFaBMA6bX/Lj3GRIcjiIZ01cR5lMuxKewSazMNoyiEOv5A0ezA4KCrv+hnRCSl9w
 Ve/gxcP+JV4Ephe71K06EPZm4JoJgvPQ7usZb9f0HD07oVMt18fdLPWvvZf7rhwWBwx5qy6hl
 w22iYMiDasRBQeuHl0JuN7tjs2K0/iokNGZse31PdV1iSsc9jhtik4juoTBRQlB4nfoC2n3yH
 ENdXr2OCvTRgp8k/RfZNxJ3qqoXCeG3fSiD/92vxWxhrz2e95fiYkpUJpfx/bjOKh2s1JgkAf
 HRDxftgmRC3o4nOvFuTao7XkptM2U6Y4CvCCsGgIeLaHH3mxw0Hk55pOn1UG46bibTFwGQhcu
 uDxaBg+9gw6N7KRXAyFt/YfV/JAUuEy3sZDCPeHmmZFgOY11T/TlgCDLiFMulQaoqg4C9MdN5
 W3+s1rycvI/Ht+ccJnDmCgxBnHZUozQEkMKmn951LISSB03KovIhpszUhcgRo6PR3ZVpGimZz
 MrwOFQs+9Pwr45KYEIidV8EE3C
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjIvMTAvMyAyMjo0OCwgQW5hbmQgSmFpbiB3cm90ZToNCj4gDQo+IFRoaXMgcGF0
Y2ggaXMgY2F1c2luZyByZWdyZXNzaW9uczsgbm93IGNhbid0IG1rZnMgd2l0aCBleHRlbnQtdHJl
ZS12Mi4NCg0KSSdtIGFscmVhZHkgbG9va2luZyBhdCBpdC4NCg0KPiANCj4gDQo+ICQgbWtmcy5i
dHJmcyAtZiAtTyBibG9jay1ncm91cC10cmVlwqAgL2Rldi9udm1lMG4xDQo+IGJ0cmZzLXByb2dz
IHY1LjE5LjENCj4gU2VlIGh0dHA6Ly9idHJmcy53aWtpLmtlcm5lbC5vcmcgZm9yIG1vcmUgaW5m
b3JtYXRpb24uDQo+IA0KPiBFUlJPUjogc3VwZXJibG9jayBtYWdpYyBkb2Vzbid0IG1hdGNoDQo+
IEVSUk9SOiBpbGxlZ2FsIG5vZGVzaXplIDE2Mzg0IChub3QgZXF1YWwgdG8gNDA5NiBmb3IgbWl4
ZWQgYmxvY2sgZ3JvdXApDQo+IA0KPiANCj4gDQo+ICQgbWtmcy5idHJmcyAtZiAtTyBleHRlbnQt
dHJlZS12MsKgIC9kZXYvbnZtZTBuMQ0KPiBidHJmcy1wcm9ncyB2NS4xOS4xDQo+IFNlZSBodHRw
Oi8vYnRyZnMud2lraS5rZXJuZWwub3JnIGZvciBtb3JlIGluZm9ybWF0aW9uLg0KPiANCj4gRVJS
T1I6IHN1cGVyYmxvY2sgbWFnaWMgZG9lc24ndCBtYXRjaA0KPiBOT1RFOiBzZXZlcmFsIGRlZmF1
bHQgc2V0dGluZ3MgaGF2ZSBjaGFuZ2VkIGluIHZlcnNpb24gNS4xNSwgcGxlYXNlIG1ha2UgDQo+
IHN1cmUNCj4gIMKgwqDCoMKgwqAgdGhpcyBkb2VzIG5vdCBhZmZlY3QgeW91ciBkZXBsb3ltZW50
czoNCj4gIMKgwqDCoMKgwqAgLSBEVVAgZm9yIG1ldGFkYXRhICgtbSBkdXApDQo+ICDCoMKgwqDC
oMKgIC0gZW5hYmxlZCBuby1ob2xlcyAoLU8gbm8taG9sZXMpDQo+ICDCoMKgwqDCoMKgIC0gZW5h
YmxlZCBmcmVlLXNwYWNlLXRyZWUgKC1SIGZyZWUtc3BhY2UtdHJlZSkNCj4gDQo+IFVuYWJsZSB0
byBmaW5kIGJsb2NrIGdyb3VwIGZvciAwDQo+IFVuYWJsZSB0byBmaW5kIGJsb2NrIGdyb3VwIGZv
ciAwDQo+IFVuYWJsZSB0byBmaW5kIGJsb2NrIGdyb3VwIGZvciAwDQo+IEVSUk9SOiBubyBzcGFj
ZSB0byBhbGxvY2F0ZSBtZXRhZGF0YSBjaHVuaw0KPiBFUlJPUjogZmFpbGVkIHRvIGNyZWF0ZSBk
ZWZhdWx0IGJsb2NrIGdyb3VwczogLTI4DQo+IA0KPiANCj4gDQo+IA0KPiBPbiAwOS8wOC8yMDIy
IDE0OjAzLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBCbG9jayBncm91cCB0cmVlIGZlYXR1cmUgaXMg
Y29tcGxldGVseSBhIHN0YW5kYWxvbmUgZmVhdHVyZSwgYW5kIGl0IGhhcw0KPj4gYmVlbiBvdmVy
IDUgeWVhcnMgYmVmb3JlIHRoZSBpbml0aWFsIGludHJvZHVjdGlvbiB0byBzb2x2ZSB0aGUgbG9u
Zw0KPj4gbW91bnQgdGltZS4NCj4+DQo+PiBJIGRvbid0IHJlYWxseSB3YW50IHRvIHdhc3RlIGFu
b3RoZXIgNSB5ZWFycyB3YWl0aW5nIGZvciBhIGZlYXR1cmUgd2hpY2gNCj4+IG1heSBvciBtYXkg
bm90IHdvcmssIGJ1dCBkZWZpbml0ZWx5IG5vdCBwcm9wZXJseSByZXZpZXdlZCBmb3IgaXRzDQo+
PiBwcmVwYXJhdGlvbiBwYXRjaGVzLg0KPj4NCj4+IFNvIHRoaXMgcGF0Y2ggd2lsbCBzZXBhcmF0
ZSB0aGUgYmxvY2sgZ3JvdXAgdHJlZSBmZWF0dXJlIGludG8gYQ0KPj4gc3RhbmRhbG9uZSBjb21w
YXQgUk8gZmVhdHVyZS4NCj4+DQo+PiBUaGVyZSBpcyBhIGNhdGNoLCBpbiBta2ZzIGNyZWF0ZV9i
bG9ja19ncm91cF90cmVlKCksIGN1cnJlbnQNCj4+IHRyZWUtY2hlY2tlciBvbmx5IGFjY2VwdHMg
YmxvY2sgZ3JvdXAgaXRlbSB3aXRoIHZhbGlkIGNodW5rX29iamVjdGlkLA0KPj4gYnV0IHRoZSBl
eGlzdGluZyBjb2RlIGZyb20gZXh0ZW50LXRyZWUtdjIgZGlkbid0IHByb3Blcmx5IGluaXRpYWxp
emUgaXQuDQo+Pg0KPj4gVGhpcyBwYXRjaCB3aWxsIGFsc28gZml4IGFib3ZlIG1lbnRpb25lZCBw
cm9ibGVtIHNvIGtlcm5lbCBjYW4gbW91bnQgaXQNCj4+IGNvcnJlY3RseS4NCj4+DQo+PiBOb3cg
bWtmcy9mc2NrIHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSB0aGUgZnMgd2l0aCBibG9jayBncm91
cCB0cmVlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0K
Pj4gLS0tDQo+PiDCoCBjaGVjay9tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA4ICsrLS0tLS0tDQo+PiDCoCBjb21tb24vZnNmZWF0dXJlcy5jwqDCoMKgwqDCoMKgwqAgfMKg
IDggKysrKysrKysNCj4+IMKgIGNvbW1vbi9mc2ZlYXR1cmVzLmjCoMKgwqDCoMKgwqDCoCB8wqAg
MiArKw0KPj4gwqAga2VybmVsLXNoYXJlZC9jdHJlZS5owqDCoMKgwqDCoCB8wqAgOSArKysrKysr
Ky0NCj4+IMKgIGtlcm5lbC1zaGFyZWQvZGlzay1pby5jwqDCoMKgIHzCoCA0ICsrLS0NCj4+IMKg
IGtlcm5lbC1zaGFyZWQvZGlzay1pby5owqDCoMKgIHzCoCAyICstDQo+PiDCoCBrZXJuZWwtc2hh
cmVkL3ByaW50LXRyZWUuYyB8wqAgNSArKy0tLQ0KPj4gwqAgbWtmcy9jb21tb24uY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0K
Pj4gwqAgbWtmcy9tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKyst
DQo+PiDCoCA5IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9jaGVjay9tYWluLmMgYi9jaGVjay9tYWluLmMNCj4+IGlu
ZGV4IDRmN2FiOGIyOTMwOS4uMDJhYmJkNTI4OWY5IDEwMDY0NA0KPj4gLS0tIGEvY2hlY2svbWFp
bi5jDQo+PiArKysgYi9jaGVjay9tYWluLmMNCj4+IEBAIC02MjkzLDcgKzYyOTMsNyBAQCBzdGF0
aWMgaW50IGNoZWNrX3R5cGVfd2l0aF9yb290KHU2NCByb290aWQsIHU4IA0KPj4ga2V5X3R5cGUp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsNCj4+IMKgwqDCoMKgwqAgY2FzZSBCVFJGU19CTE9DS19HUk9VUF9JVEVN
X0tFWToNCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoYnRyZnNfZnNfaW5jb21wYXQoZ2ZzX2luZm8s
IEVYVEVOVF9UUkVFX1YyKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChidHJmc19mc19jb21w
YXRfcm8oZ2ZzX2luZm8sIEJMT0NLX0dST1VQX1RSRUUpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAocm9vdGlkICE9IEJUUkZTX0JMT0NLX0dST1VQX1RSRUVfT0JKRUNUSUQp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyOw0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAocm9vdGlkICE9IEJUUkZTX0VYVEVOVF9UUkVFX09C
SkVDVElEKSB7DQo+PiBAQCAtOTA3MSwxMCArOTA3MSw2IEBAIGFnYWluOg0KPj4gwqDCoMKgwqDC
oCByZXQgPSBsb2FkX3N1cGVyX3Jvb3QoJm5vcm1hbF90cmVlcywgZ2ZzX2luZm8tPmNodW5rX3Jv
b3QpOw0KPj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIG91dDsNCj4+IC3CoMKgwqAgcmV0ID0gbG9hZF9zdXBlcl9yb290KCZub3JtYWxfdHJlZXMs
IGdmc19pbmZvLT5ibG9ja19ncm91cF9yb290KTsNCj4+IC3CoMKgwqAgaWYgKHJldCA8IDApDQo+
PiAtwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+PiAtDQo+PiDCoMKgwqDCoMKgIHJldCA9IHBh
cnNlX3RyZWVfcm9vdHMoJm5vcm1hbF90cmVlcywgJmRyb3BwaW5nX3RyZWVzKTsNCj4+IMKgwqDC
oMKgwqAgaWYgKHJldCA8IDApDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+PiBA
QCAtOTU3NCw3ICs5NTcwLDcgQEAgYWdhaW46DQo+PiDCoMKgwqDCoMKgwqAgKiBJZiB3ZSBhcmUg
ZXh0ZW50IHRyZWUgdjIgdGhlbiB3ZSBjYW4gcmVpbnQgdGhlIGJsb2NrIGdyb3VwIA0KPj4gcm9v
dCBhcw0KPj4gwqDCoMKgwqDCoMKgICogd2VsbC4NCj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4gLcKg
wqDCoCBpZiAoYnRyZnNfZnNfaW5jb21wYXQoZ2ZzX2luZm8sIEVYVEVOVF9UUkVFX1YyKSkgew0K
Pj4gK8KgwqDCoCBpZiAoYnRyZnNfZnNfY29tcGF0X3JvKGdmc19pbmZvLCBCTE9DS19HUk9VUF9U
UkVFKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGJ0cmZzX2ZzY2tfcmVpbml0X3Jv
b3QodHJhbnMsIA0KPj4gZ2ZzX2luZm8tPmJsb2NrX2dyb3VwX3Jvb3QpOw0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChyZXQpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZwcmlu
dGYoc3RkZXJyLCAiYmxvY2sgZ3JvdXAgaW5pdGlhbGl6YXRpb24gZmFpbGVkXG4iKTsNCj4+IGRp
ZmYgLS1naXQgYS9jb21tb24vZnNmZWF0dXJlcy5jIGIvY29tbW9uL2ZzZmVhdHVyZXMuYw0KPj4g
aW5kZXggMjNhOTJjMjFhMmNjLi45MDcwNDk1OWIxM2IgMTAwNjQ0DQo+PiAtLS0gYS9jb21tb24v
ZnNmZWF0dXJlcy5jDQo+PiArKysgYi9jb21tb24vZnNmZWF0dXJlcy5jDQo+PiBAQCAtMTcyLDYg
KzE3MiwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGJ0cmZzX2ZlYXR1cmUgDQo+PiBydW50aW1l
X2ZlYXR1cmVzW10gPSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgVkVSU0lPTl9UT19TVFJJTkcy
KHNhZmUsIDQsOSksDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgVkVSU0lPTl9UT19TVFJJTkcyKGRl
ZmF1bHQsIDUsMTUpLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5kZXNjwqDCoMKgwqDCoMKgwqAg
PSAiZnJlZSBzcGFjZSB0cmVlIChzcGFjZV9jYWNoZT12MikiDQo+PiArwqDCoMKgIH0sIHsNCj4+
ICvCoMKgwqDCoMKgwqDCoCAubmFtZcKgwqDCoMKgwqDCoMKgID0gImJsb2NrLWdyb3VwLXRyZWUi
LA0KPj4gK8KgwqDCoMKgwqDCoMKgIC5mbGFnwqDCoMKgwqDCoMKgwqAgPSBCVFJGU19SVU5USU1F
X0ZFQVRVUkVfQkxPQ0tfR1JPVVBfVFJFRSwNCj4+ICvCoMKgwqDCoMKgwqDCoCAuc3lzZnNfbmFt
ZSA9ICJibG9ja19ncm91cF90cmVlIiwNCj4+ICvCoMKgwqDCoMKgwqDCoCBWRVJTSU9OX1RPX1NU
UklORzIoY29tcGF0LCA2LDApLA0KPj4gK8KgwqDCoMKgwqDCoMKgIFZFUlNJT05fTlVMTChzYWZl
KSwNCj4+ICvCoMKgwqDCoMKgwqDCoCBWRVJTSU9OX05VTEwoZGVmYXVsdCksDQo+PiArwqDCoMKg
wqDCoMKgwqAgLmRlc2PCoMKgwqDCoMKgwqDCoCA9ICJibG9jayBncm91cCB0cmVlIHRvIHJlZHVj
ZSBtb3VudCB0aW1lIg0KPj4gwqDCoMKgwqDCoCB9LA0KPj4gwqDCoMKgwqDCoCAvKiBLZWVwIHRo
aXMgb25lIGxhc3QgKi8NCj4+IMKgwqDCoMKgwqAgew0KPj4gZGlmZiAtLWdpdCBhL2NvbW1vbi9m
c2ZlYXR1cmVzLmggYi9jb21tb24vZnNmZWF0dXJlcy5oDQo+PiBpbmRleCA5ZTM5YzY2N2I5MDAu
LmE4ZDc3ZmQ0ZGEwNSAxMDA2NDQNCj4+IC0tLSBhL2NvbW1vbi9mc2ZlYXR1cmVzLmgNCj4+ICsr
KyBiL2NvbW1vbi9mc2ZlYXR1cmVzLmgNCj4+IEBAIC00NSw2ICs0NSw4IEBADQo+PiDCoCAjZGVm
aW5lIEJUUkZTX1JVTlRJTUVfRkVBVFVSRV9RVU9UQcKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDAp
DQo+PiDCoCAjZGVmaW5lIEJUUkZTX1JVTlRJTUVfRkVBVFVSRV9GUkVFX1NQQUNFX1RSRUXCoMKg
wqAgKDFVTEwgPDwgMSkNCj4+ICsjZGVmaW5lIEJUUkZTX1JVTlRJTUVfRkVBVFVSRV9CTE9DS19H
Uk9VUF9UUkVFwqDCoMKgICgxVUxMIDw8IDIpDQo+PiArDQo+PiDCoCB2b2lkIGJ0cmZzX2xpc3Rf
YWxsX2ZzX2ZlYXR1cmVzKHU2NCBtYXNrX2Rpc2FsbG93ZWQpOw0KPj4gwqAgdm9pZCBidHJmc19s
aXN0X2FsbF9ydW50aW1lX2ZlYXR1cmVzKHU2NCBtYXNrX2Rpc2FsbG93ZWQpOw0KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC1zaGFyZWQvY3RyZWUuaCBiL2tlcm5lbC1zaGFyZWQvY3RyZWUuaA0KPj4g
aW5kZXggYzEyMDc2MjAyNTc3Li5kODkwOWIzZmRmMjAgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwt
c2hhcmVkL2N0cmVlLmgNCj4+ICsrKyBiL2tlcm5lbC1zaGFyZWQvY3RyZWUuaA0KPj4gQEAgLTQ3
OSw2ICs0NzksMTIgQEAgQlVJTERfQVNTRVJUKHNpemVvZihzdHJ1Y3QgYnRyZnNfc3VwZXJfYmxv
Y2spID09IA0KPj4gQlRSRlNfU1VQRVJfSU5GT19TSVpFKTsNCj4+IMKgwqAgKi8NCj4+IMKgICNk
ZWZpbmUgQlRSRlNfRkVBVFVSRV9DT01QQVRfUk9fRlJFRV9TUEFDRV9UUkVFX1ZBTElEwqDCoMKg
ICgxVUxMIDw8IDEpDQo+PiArLyoNCj4+ICsgKiBTYXZlIGFsbCBibG9jayBncm91cCBpdGVtcyBp
bnRvIGEgZGVkaWNhdGVkIGJsb2NrIGdyb3VwIHRyZWUsIHRvIA0KPj4gZ3JlYXRseQ0KPj4gKyAq
IHJlZHVjZSBtb3VudCB0aW1lIGZvciBsYXJnZSBmcy4NCj4+ICsgKi8NCj4+ICsjZGVmaW5lIEJU
UkZTX0ZFQVRVUkVfQ09NUEFUX1JPX0JMT0NLX0dST1VQX1RSRUXCoMKgwqAgKDFVTEwgPDwgNSkN
Cj4+ICsNCj4+IMKgICNkZWZpbmUgQlRSRlNfRkVBVFVSRV9JTkNPTVBBVF9NSVhFRF9CQUNLUkVG
wqDCoMKgICgxVUxMIDw8IDApDQo+PiDCoCAjZGVmaW5lIEJUUkZTX0ZFQVRVUkVfSU5DT01QQVRf
REVGQVVMVF9TVUJWT0zCoMKgwqAgKDFVTEwgPDwgMSkNCj4+IMKgICNkZWZpbmUgQlRSRlNfRkVB
VFVSRV9JTkNPTVBBVF9NSVhFRF9HUk9VUFPCoMKgwqAgKDFVTEwgPDwgMikNCj4+IEBAIC01MDgs
NyArNTE0LDggQEAgQlVJTERfQVNTRVJUKHNpemVvZihzdHJ1Y3QgYnRyZnNfc3VwZXJfYmxvY2sp
ID09IA0KPj4gQlRSRlNfU1VQRVJfSU5GT19TSVpFKTsNCj4+IMKgwqAgKi8NCj4+IMKgICNkZWZp
bmUgQlRSRlNfRkVBVFVSRV9DT01QQVRfUk9fU1VQUMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0K
Pj4gwqDCoMKgwqDCoCAoQlRSRlNfRkVBVFVSRV9DT01QQVRfUk9fRlJFRV9TUEFDRV9UUkVFIHzC
oMKgwqAgXA0KPj4gLcKgwqDCoMKgIEJUUkZTX0ZFQVRVUkVfQ09NUEFUX1JPX0ZSRUVfU1BBQ0Vf
VFJFRV9WQUxJRCkNCj4+ICvCoMKgwqDCoCBCVFJGU19GRUFUVVJFX0NPTVBBVF9ST19GUkVFX1NQ
QUNFX1RSRUVfVkFMSUR8IFwNCj4+ICvCoMKgwqDCoCBCVFJGU19GRUFUVVJFX0NPTVBBVF9ST19C
TE9DS19HUk9VUF9UUkVFKQ0KPj4gwqAgI2lmIEVYUEVSSU1FTlRBTA0KPj4gwqAgI2RlZmluZSBC
VFJGU19GRUFUVVJFX0lOQ09NUEFUX1NVUFDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+IGRp
ZmYgLS1naXQgYS9rZXJuZWwtc2hhcmVkL2Rpc2staW8uYyBiL2tlcm5lbC1zaGFyZWQvZGlzay1p
by5jDQo+PiBpbmRleCA4MGRiNTk3NmNjM2YuLjZlZWI1ZWNkMWQ1OSAxMDA2NDQNCj4+IC0tLSBh
L2tlcm5lbC1zaGFyZWQvZGlzay1pby5jDQo+PiArKysgYi9rZXJuZWwtc2hhcmVkL2Rpc2staW8u
Yw0KPj4gQEAgLTEyMDMsNyArMTIwMyw3IEBAIHN0YXRpYyBpbnQgbG9hZF9pbXBvcnRhbnRfcm9v
dHMoc3RydWN0IA0KPj4gYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBiYWNrdXAgPSBzYi0+c3VwZXJfcm9vdHMgKyBpbmRleDsNCj4+IMKgwqDCoMKgwqAgfQ0K
Pj4gLcKgwqDCoCBpZiAoIWJ0cmZzX2ZzX2luY29tcGF0KGZzX2luZm8sIEVYVEVOVF9UUkVFX1Yy
KSkgew0KPj4gK8KgwqDCoCBpZiAoIWJ0cmZzX2ZzX2NvbXBhdF9ybyhmc19pbmZvLCBCTE9DS19H
Uk9VUF9UUkVFKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZyZWUoZnNfaW5mby0+YmxvY2tf
Z3JvdXBfcm9vdCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZnNfaW5mby0+YmxvY2tfZ3JvdXBf
cm9vdCA9IE5VTEw7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB0cmVlX3Jvb3Q7DQo+PiBA
QCAtMTI1Niw3ICsxMjU2LDcgQEAgaW50IGJ0cmZzX3NldHVwX2FsbF9yb290cyhzdHJ1Y3QgYnRy
ZnNfZnNfaW5mbyANCj4+ICpmc19pbmZvLCB1NjQgcm9vdF90cmVlX2J5dGVuciwNCj4+IMKgwqDC
oMKgwqAgaWYgKHJldCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4gLcKg
wqDCoCBpZiAoYnRyZnNfZnNfaW5jb21wYXQoZnNfaW5mbywgRVhURU5UX1RSRUVfVjIpKSB7DQo+
PiArwqDCoMKgIGlmIChidHJmc19mc19jb21wYXRfcm8oZnNfaW5mbywgQkxPQ0tfR1JPVVBfVFJF
RSkpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBmaW5kX2FuZF9zZXR1cF9yb290KHJv
b3QsIGZzX2luZm8sDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUUkZT
X0JMT0NLX0dST1VQX1RSRUVfT0JKRUNUSUQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZzX2luZm8tPmJsb2NrX2dyb3VwX3Jvb3QpOw0KPj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC1zaGFyZWQvZGlzay1pby5oIGIva2VybmVsLXNoYXJlZC9kaXNrLWlvLmgNCj4+IGluZGV4
IGJiYTk3ZmMxYTgxNC4uNmM4ZWFhMmJkMTNkIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsLXNoYXJl
ZC9kaXNrLWlvLmgNCj4+ICsrKyBiL2tlcm5lbC1zaGFyZWQvZGlzay1pby5oDQo+PiBAQCAtMjMy
LDcgKzIzMiw3IEBAIGludCBidHJmc19nbG9iYWxfcm9vdF9pbnNlcnQoc3RydWN0IGJ0cmZzX2Zz
X2luZm8gDQo+PiAqZnNfaW5mbywNCj4+IMKgIHN0YXRpYyBpbmxpbmUgc3RydWN0IGJ0cmZzX3Jv
b3QgKmJ0cmZzX2Jsb2NrX2dyb3VwX3Jvb3QoDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykN
Cj4+IMKgIHsNCj4+IC3CoMKgwqAgaWYgKGJ0cmZzX2ZzX2luY29tcGF0KGZzX2luZm8sIEVYVEVO
VF9UUkVFX1YyKSkNCj4+ICvCoMKgwqAgaWYgKGJ0cmZzX2ZzX2NvbXBhdF9ybyhmc19pbmZvLCBC
TE9DS19HUk9VUF9UUkVFKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZnNfaW5mby0+
YmxvY2tfZ3JvdXBfcm9vdDsNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIGJ0cmZzX2V4dGVudF9yb290
KGZzX2luZm8sIDApOw0KPj4gwqAgfQ0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC1zaGFyZWQvcHJp
bnQtdHJlZS5jIGIva2VybmVsLXNoYXJlZC9wcmludC10cmVlLmMNCj4+IGluZGV4IGJmZmUzMGI0
MDVjNy4uYjJlZTc3YzJmYjczIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsLXNoYXJlZC9wcmludC10
cmVlLmMNCj4+ICsrKyBiL2tlcm5lbC1zaGFyZWQvcHJpbnQtdHJlZS5jDQo+PiBAQCAtMTY2OCw2
ICsxNjY4LDcgQEAgc3RydWN0IHJlYWRhYmxlX2ZsYWdfZW50cnkgew0KPj4gwqAgc3RhdGljIHN0
cnVjdCByZWFkYWJsZV9mbGFnX2VudHJ5IGNvbXBhdF9yb19mbGFnc19hcnJheVtdID0gew0KPj4g
wqDCoMKgwqDCoCBERUZfQ09NUEFUX1JPX0ZMQUdfRU5UUlkoRlJFRV9TUEFDRV9UUkVFKSwNCj4+
IMKgwqDCoMKgwqAgREVGX0NPTVBBVF9ST19GTEFHX0VOVFJZKEZSRUVfU1BBQ0VfVFJFRV9WQUxJ
RCksDQo+PiArwqDCoMKgIERFRl9DT01QQVRfUk9fRkxBR19FTlRSWShCTE9DS19HUk9VUF9UUkVF
KSwNCj4+IMKgIH07DQo+PiDCoCBzdGF0aWMgY29uc3QgaW50IGNvbXBhdF9yb19mbGFnc19udW0g
PSBzaXplb2YoY29tcGF0X3JvX2ZsYWdzX2FycmF5KSAvDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCByZWFkYWJsZV9mbGFn
X2VudHJ5KTsNCj4+IEBAIC0xNzU0LDkgKzE3NTUsNyBAQCBzdGF0aWMgdm9pZCBwcmludF9yZWFk
YWJsZV9jb21wYXRfcm9fZmxhZyh1NjQgZmxhZykNCj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4gwqDC
oMKgwqDCoCByZXR1cm4gX19wcmludF9yZWFkYWJsZV9mbGFnKGZsYWcsIGNvbXBhdF9yb19mbGFn
c19hcnJheSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbXBhdF9yb19mbGFnc19udW0sDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBCVFJGU19GRUFUVVJFX0NPTVBBVF9ST19TVVBQIHwNCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUUkZTX0ZFQVRVUkVfQ09NUEFUX1JPX0ZS
RUVfU1BBQ0VfVFJFRSB8DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBCVFJGU19GRUFUVVJFX0NPTVBBVF9ST19GUkVFX1NQQUNFX1RSRUVfVkFMSUQpOw0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQlRSRlNfRkVBVFVSRV9D
T01QQVRfUk9fU1VQUCk7DQo+PiDCoCB9DQo+PiDCoCBzdGF0aWMgdm9pZCBwcmludF9yZWFkYWJs
ZV9pbmNvbXBhdF9mbGFnKHU2NCBmbGFnKQ0KPj4gZGlmZiAtLWdpdCBhL21rZnMvY29tbW9uLmMg
Yi9ta2ZzL2NvbW1vbi5jDQo+PiBpbmRleCBiNzIzMzg1NTFkZmIuLmNiNjE2ZjEzZWY5YiAxMDA2
NDQNCj4+IC0tLSBhL21rZnMvY29tbW9uLmMNCj4+ICsrKyBiL21rZnMvY29tbW9uLmMNCj4+IEBA
IC03NSw2ICs3NSw4IEBAIHN0YXRpYyBpbnQgYnRyZnNfY3JlYXRlX3RyZWVfcm9vdChpbnQgZmQs
IHN0cnVjdCANCj4+IGJ0cmZzX21rZnNfY29uZmlnICpjZmcsDQo+PiDCoMKgwqDCoMKgIGludCBi
bGs7DQo+PiDCoMKgwqDCoMKgIGludCBpOw0KPj4gwqDCoMKgwqDCoCB1OCB1dWlkW0JUUkZTX1VV
SURfU0laRV07DQo+PiArwqDCoMKgIGJvb2wgYmxvY2tfZ3JvdXBfdHJlZSA9ICEhKGNmZy0+cnVu
dGltZV9mZWF0dXJlcyAmDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEJUUkZTX1JVTlRJTUVfRkVBVFVSRV9CTE9DS19HUk9VUF9UUkVFKTsNCj4+IMKgwqDCoMKgwqAg
bWVtc2V0KGJ1Zi0+ZGF0YSArIHNpemVvZihzdHJ1Y3QgYnRyZnNfaGVhZGVyKSwgMCwNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBjZmctPm5vZGVzaXplIC0gc2l6ZW9mKHN0cnVjdCBidHJmc19oZWFk
ZXIpKTsNCj4+IEBAIC0xMDEsNiArMTAzLDkgQEAgc3RhdGljIGludCBidHJmc19jcmVhdGVfdHJl
ZV9yb290KGludCBmZCwgc3RydWN0IA0KPj4gYnRyZnNfbWtmc19jb25maWcgKmNmZywNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoYmxrID09IE1LRlNfUk9PVF9UUkVFIHx8IGJsayA9PSBNS0ZT
X0NIVU5LX1RSRUUpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWJsb2NrX2dyb3VwX3RyZWUgJiYgYmxrID09IE1LRlNfQkxP
Q0tfR1JPVVBfVFJFRSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4g
Kw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJ0cmZzX3NldF9yb290X2J5dGVucigmcm9vdF9pdGVt
LCBjZmctPmJsb2Nrc1tibGtdKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBidHJmc19zZXRfZGlz
a19rZXlfb2JqZWN0aWQoJmRpc2tfa2V5LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVmZXJlbmNlX3Jvb3RfdGFibGVbYmxrXSk7DQo+PiBAQCAtMjE2LDcgKzIyMSw4IEBAIHN0YXRp
YyBpbnQgY3JlYXRlX2Jsb2NrX2dyb3VwX3RyZWUoaW50IGZkLCBzdHJ1Y3QgDQo+PiBidHJmc19t
a2ZzX2NvbmZpZyAqY2ZnLA0KPj4gwqDCoMKgwqDCoCBtZW1zZXQoYnVmLT5kYXRhICsgc2l6ZW9m
KHN0cnVjdCBidHJmc19oZWFkZXIpLCAwLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNmZy0+bm9k
ZXNpemUgLSBzaXplb2Yoc3RydWN0IGJ0cmZzX2hlYWRlcikpOw0KPj4gLcKgwqDCoCB3cml0ZV9i
bG9ja19ncm91cF9pdGVtKGJ1ZiwgMCwgYmdfb2Zmc2V0LCBiZ19zaXplLCBiZ191c2VkLCAwLA0K
Pj4gK8KgwqDCoCB3cml0ZV9ibG9ja19ncm91cF9pdGVtKGJ1ZiwgMCwgYmdfb2Zmc2V0LCBiZ19z
aXplLCBiZ191c2VkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBC
VFJGU19GSVJTVF9DSFVOS19UUkVFX09CSkVDVElELA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjZmctPmxlYWZfZGF0YV9zaXplIC0NCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBidHJmc19ibG9ja19n
cm91cF9pdGVtKSk7DQo+PiDCoMKgwqDCoMKgIGJ0cmZzX3NldF9oZWFkZXJfYnl0ZW5yKGJ1Ziwg
Y2ZnLT5ibG9ja3NbTUtGU19CTE9DS19HUk9VUF9UUkVFXSk7DQo+PiBAQCAtMzU3LDYgKzM2Myw3
IEBAIGludCBtYWtlX2J0cmZzKGludCBmZCwgc3RydWN0IGJ0cmZzX21rZnNfY29uZmlnICpjZmcp
DQo+PiDCoMKgwqDCoMKgIHUzMiBhcnJheV9zaXplOw0KPj4gwqDCoMKgwqDCoCB1MzIgaXRlbV9z
aXplOw0KPj4gwqDCoMKgwqDCoCB1NjQgdG90YWxfdXNlZCA9IDA7DQo+PiArwqDCoMKgIHU2NCBy
b19mbGFncyA9IDA7DQo+PiDCoMKgwqDCoMKgIGludCBza2lubnlfbWV0YWRhdGEgPSAhIShjZmct
PmZlYXR1cmVzICYNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVFJG
U19GRUFUVVJFX0lOQ09NUEFUX1NLSU5OWV9NRVRBREFUQSk7DQo+PiDCoMKgwqDCoMKgIHU2NCBu
dW1fYnl0ZXM7DQo+PiBAQCAtMzY1LDYgKzM3Miw4IEBAIGludCBtYWtlX2J0cmZzKGludCBmZCwg
c3RydWN0IGJ0cmZzX21rZnNfY29uZmlnICpjZmcpDQo+PiDCoMKgwqDCoMKgIGJvb2wgYWRkX2Js
b2NrX2dyb3VwID0gdHJ1ZTsNCj4+IMKgwqDCoMKgwqAgYm9vbCBmcmVlX3NwYWNlX3RyZWUgPSAh
IShjZmctPnJ1bnRpbWVfZmVhdHVyZXMgJg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQlRSRlNfUlVOVElNRV9GRUFUVVJFX0ZSRUVfU1BBQ0VfVFJFRSk7DQo+PiAr
wqDCoMKgIGJvb2wgYmxvY2tfZ3JvdXBfdHJlZSA9ICEhKGNmZy0+cnVudGltZV9mZWF0dXJlcyAm
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUUkZTX1JVTlRJTUVf
RkVBVFVSRV9CTE9DS19HUk9VUF9UUkVFKTsNCj4+IMKgwqDCoMKgwqAgYm9vbCBleHRlbnRfdHJl
ZV92MiA9ICEhKGNmZy0+ZmVhdHVyZXMgJg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEJUUkZTX0ZFQVRVUkVfSU5DT01QQVRfRVhURU5UX1RSRUVfVjIpOw0KPj4gQEAg
LTM3Miw4ICszODEsMTMgQEAgaW50IG1ha2VfYnRyZnMoaW50IGZkLCBzdHJ1Y3QgYnRyZnNfbWtm
c19jb25maWcgDQo+PiAqY2ZnKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihl
bnVtIGJ0cmZzX21rZnNfYmxvY2spICogQVJSQVlfU0laRShkZWZhdWx0X2Jsb2NrcykpOw0KPj4g
wqDCoMKgwqDCoCBibG9ja3NfbnIgPSBBUlJBWV9TSVpFKGRlZmF1bHRfYmxvY2tzKTsNCj4+IC3C
oMKgwqAgLyogRXh0ZW50IHRyZWUgdjIgbmVlZHMgYW4gZXh0cmEgYmxvY2sgZm9yIGJsb2NrIGdy
b3VwIHRyZWUuKi8NCj4+IC3CoMKgwqAgaWYgKGV4dGVudF90cmVlX3YyKSB7DQo+PiArwqDCoMKg
IC8qDQo+PiArwqDCoMKgwqAgKiBBZGQgb25lIG5ldyBibG9jayBmb3IgYmxvY2sgZ3JvdXAgdHJl
ZS4NCj4+ICvCoMKgwqDCoCAqIEFuZCBmb3IgYmxvY2sgZ3JvdXAgdHJlZSwgd2UgZG9uJ3QgbmVl
ZCB0byBhZGQgYmxvY2sgZ3JvdXAgaXRlbQ0KPj4gK8KgwqDCoMKgICogaW50byBleHRlbnQgdHJl
ZSwgdGhlIGl0ZW0gd2lsbCBiZSBoYW5kbGVkIGluIGJsb2NrIGdyb3VwIHRyZWUNCj4+ICvCoMKg
wqDCoCAqIGluaXRpYWxpemF0aW9uLg0KPj4gK8KgwqDCoMKgICovDQo+PiArwqDCoMKgIGlmIChi
bG9ja19ncm91cF90cmVlKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbWtmc19ibG9ja3NfYWRk
KGJsb2NrcywgJmJsb2Nrc19uciwgTUtGU19CTE9DS19HUk9VUF9UUkVFKTsNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBhZGRfYmxvY2tfZ3JvdXAgPSBmYWxzZTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4g
QEAgLTQzMywxMiArNDQ3LDE1IEBAIGludCBtYWtlX2J0cmZzKGludCBmZCwgc3RydWN0IGJ0cmZz
X21rZnNfY29uZmlnIA0KPj4gKmNmZykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBidHJmc19zZXRf
c3VwZXJfY2FjaGVfZ2VuZXJhdGlvbigmc3VwZXIsIC0xKTsNCj4+IMKgwqDCoMKgwqAgYnRyZnNf
c2V0X3N1cGVyX2luY29tcGF0X2ZsYWdzKCZzdXBlciwgY2ZnLT5mZWF0dXJlcyk7DQo+PiDCoMKg
wqDCoMKgIGlmIChmcmVlX3NwYWNlX3RyZWUpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCB1NjQgcm9f
ZmxhZ3MgPSBCVFJGU19GRUFUVVJFX0NPTVBBVF9ST19GUkVFX1NQQUNFX1RSRUUgfA0KPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQlRSRlNfRkVBVFVSRV9DT01QQVRfUk9fRlJFRV9TUEFDRV9U
UkVFX1ZBTElEOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHJvX2ZsYWdzIHw9IChCVFJGU19GRUFUVVJF
X0NPTVBBVF9ST19GUkVFX1NQQUNFX1RSRUUgfA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEJUUkZTX0ZFQVRVUkVfQ09NUEFUX1JPX0ZSRUVfU1BBQ0VfVFJFRV9WQUxJRCk7
DQo+PiAtwqDCoMKgwqDCoMKgwqAgYnRyZnNfc2V0X3N1cGVyX2NvbXBhdF9yb19mbGFncygmc3Vw
ZXIsIHJvX2ZsYWdzKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBidHJmc19zZXRfc3VwZXJfY2Fj
aGVfZ2VuZXJhdGlvbigmc3VwZXIsIDApOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiArwqDCoMKgIGlm
IChibG9ja19ncm91cF90cmVlKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJvX2ZsYWdzIHw9IEJUUkZT
X0ZFQVRVUkVfQ09NUEFUX1JPX0JMT0NLX0dST1VQX1RSRUU7DQo+PiArwqDCoMKgIGJ0cmZzX3Nl
dF9zdXBlcl9jb21wYXRfcm9fZmxhZ3MoJnN1cGVyLCByb19mbGFncyk7DQo+PiArDQo+PiDCoMKg
wqDCoMKgIGlmIChleHRlbnRfdHJlZV92MikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBidHJmc19z
ZXRfc3VwZXJfbnJfZ2xvYmFsX3Jvb3RzKCZzdXBlciwgMSk7DQo+PiBAQCAtNjk1LDcgKzcxMiw3
IEBAIGludCBtYWtlX2J0cmZzKGludCBmZCwgc3RydWN0IGJ0cmZzX21rZnNfY29uZmlnICpjZmcp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4+IMKgwqDCoMKgwqAg
fQ0KPj4gLcKgwqDCoCBpZiAoZXh0ZW50X3RyZWVfdjIpIHsNCj4+ICvCoMKgwqAgaWYgKGJsb2Nr
X2dyb3VwX3RyZWUpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBjcmVhdGVfYmxvY2tf
Z3JvdXBfdHJlZShmZCwgY2ZnLCBidWYsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzdGVtX2dyb3VwX29mZnNldCwNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzeXN0ZW1f
Z3JvdXBfc2l6ZSwgdG90YWxfdXNlZCk7DQo+PiBkaWZmIC0tZ2l0IGEvbWtmcy9tYWluLmMgYi9t
a2ZzL21haW4uYw0KPj4gaW5kZXggY2UwOTZkMzYyMTcxLi41MThjZTBmZDc1MjMgMTAwNjQ0DQo+
PiAtLS0gYS9ta2ZzL21haW4uYw0KPj4gKysrIGIvbWtmcy9tYWluLmMNCj4+IEBAIC0yOTksNyAr
Mjk5LDggQEAgc3RhdGljIGludCByZWNvd19yb290cyhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxl
IA0KPj4gKnRyYW5zLA0KPj4gwqDCoMKgwqDCoCByZXQgPSBfX3JlY293X3Jvb3QodHJhbnMsIGlu
Zm8tPmRldl9yb290KTsNCj4+IMKgwqDCoMKgwqAgaWYgKHJldCkNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gcmV0Ow0KPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChidHJmc19mc19pbmNvbXBh
dChpbmZvLCBFWFRFTlRfVFJFRV9WMikpIHsNCj4+ICsNCj4+ICvCoMKgwqAgaWYgKGJ0cmZzX2Zz
X2NvbXBhdF9ybyhpbmZvLCBCTE9DS19HUk9VUF9UUkVFKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IF9fcmVjb3dfcm9vdCh0cmFucywgaW5mby0+YmxvY2tfZ3JvdXBfcm9vdCk7DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7DQo+IA0K
