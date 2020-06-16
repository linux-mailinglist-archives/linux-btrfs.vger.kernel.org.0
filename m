Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6602B1FB305
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgFPN5c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 09:57:32 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:55564 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgFPN5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 09:57:31 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 49mVBc344Bz4f3lwj;
        Tue, 16 Jun 2020 15:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1592315848;
        bh=+cBBLyQ3snJr5bs8t67neROVHmNHR8X3WD8bkKQGu/M=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=BUSQG0WAFRjR4hEpeiWta0uyaEPxFb8X4pR6TaVVZitQfN1jQ7lA4nfI1qb9J/Hoz
         bSg8LYuDcOOI6xxLRezzj6vGULq9oRic1XBO5p1RjsQZNPGeYpE9Jk9bVRVr9IZHGC
         gpDdVXTrXhXV8KsQETK43QsSHcHA1LzltkrpRXaM=
Received: from si0vm2082.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 49mVBc1Zb9z6Pt;
        Tue, 16 Jun 2020 15:57:28 +0200 (CEST)
X-AuditID: 0a3aad16-845ff700000077c5-58-5ee8cfc8d9dd
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2082.rbesz01.com (SMG Outbound) with SMTP id B6.5A.30661.8CFC8EE5; Tue, 16 Jun 2020 15:57:28 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (fe-mbx2029.de.bosch.com [10.3.231.39])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 49mVBc13DYz6CjZP1;
        Tue, 16 Jun 2020 15:57:28 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2029.de.bosch.com (10.3.231.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Tue, 16 Jun 2020 15:57:27 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b]) by
 FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b%3]) with mapi id
 15.01.1979.003; Tue, 16 Jun 2020 15:57:27 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Having troubles to disable inline extents
Thread-Topic: Having troubles to disable inline extents
Thread-Index: AdZD4YpxwA3ZaANaT02rXcz/vOG1Vf//5CCA///cyOA=
Date:   Tue, 16 Jun 2020 13:57:27 +0000
Message-ID: <fab7af8e7c2d4201b4e1a0a0cdbecda3@rs.bosch.com>
References: <2e956e490f6a430f9aa82fed3c8be08c@rs.bosch.com>
 <e77dbead-308f-94f6-cd98-2abd524a863d@gmx.com>
In-Reply-To: <e77dbead-308f-94f6-cd98-2abd524a863d@gmx.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.151.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsXCZbVWVvfE+RdxBh8m8lhceryC3WJx9xsW
        ByaPu/cXMnl83iQXwBTFZZOSmpNZllqkb5fAlXH+RHrBNIGKJd/XszYwPuDvYuTgkBAwkbi1
        L7WLkYtDSGAGk8SU7ydYuxg5gZx9jBKbf6dDJN4ySsxofcAM4exhlHg36xsLSBWbgLPE+YuL
        mUFsEYFUiWu7dzKC2MICZhKrjqxihIibS3zcPoUdwraSuDihCcxmEVCVuP75OVgvr4C1RFfb
        JnaQi4QEciRWzrABCXMChXc9bAMbwyggK9HZ8I4JxGYWEJe49WQ+mC0hICCxZM95ZghbVOLl
        43+sELaixNrVjUwgI5kFNCXW79KHaFWUmNL9kB1iq6DEyZlPWCYwis1CMnUWQscsJB2zkHQs
        YGRZxShanGlQlmtkYGGkV5SUWlxlYKiXnJ+7iRESN2I7GLd3fdA7xMjEwXiIUYKDWUmE992e
        F3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVV4NsYJCaQnlqRmp6YWpBbBZJk4OKUamNhKjolK
        spx0m7vKfp9z/5QSn237vp0+d+tvb8YKWR19//Or7Hy5uSVaw8M7GCpv8E0XsPN4LFjEbOMd
        b7qt5tupFHFrx/+/9puujYu66xG0P77SbUbYpohlfx8ee7POav9Z1d06jo/rlqgo6xqoGXFt
        EmbLWyJif9nthGrkvrmK79dKFtm4RiSGX/4l+PgZc5Hc2xfPjwgnxH7hifJZ4vZk+SVms0Vv
        +JIUnjhJLKhz1/qmu1Yv2PjyU6mE4uzEWgUXT/fuVx4uPzzSr2fXp5dM4tXXPBXHtiVxV4H0
        I/lklQPMFzouv1ytfaWT51jVzPCljrEF19a+9l01bW+urYjOy6x/F3P9ptzfX7VNiaU4I9FQ
        i7moOBEASZ+GQQoDAAA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T2ssIEkgdW5kZXJzdGFuZC4NCg0KQW5kIGlzIHRoZXJlIGEgd2F5IHRvIGRpc2FibGUgdGhlbSBk
dXJpbmcgZmlsZXN5c3RlbSBjcmVhdGlvbiAoZS5nLiBzb21lIG9wdGlvbiBpbiBta2ZzLmJ0cmZz
KT8NCg0KVGhhbmtzLA0KRGVqYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT4gDQpTZW50OiB1dG9yYWssIDE2LiBq
dW4gMjAyMC4gMTU6NDUNClRvOiBSZWJyYWNhIERlamFuIChCU09UL1BKLUVTMS1CZykgPERlamFu
LlJlYnJhY2FAcnMuYm9zY2guY29tPjsgbGludXgtYnRyZnNAdmdlci5rZXJuZWwub3JnDQpTdWJq
ZWN0OiBSZTogSGF2aW5nIHRyb3VibGVzIHRvIGRpc2FibGUgaW5saW5lIGV4dGVudHMNCg0KDQoN
Ck9uIDIwMjAvNi8xNiDkuIvljYg5OjQxLCBSZWJyYWNhIERlamFuIChCU09UL1BKLUVTMS1CZykg
d3JvdGU6DQo+IEhpLA0KPiANCj4gV2UgYXJlIHRyeWluZyB0byBhZGQgc3VwcG9ydCBmb3IgQlRS
RlMgaW4gb3VyIHByb2plY3QsIHNvIHdlIHN0YXJ0ZWQgdG8gZXhhbWluZSB0aGlzIGZpbGVzeXN0
ZW0uDQo+IEZvciB0aGUgbW9tZW50LCB3ZSBkb24ndCB3YW50IGlubGluZSBleHRlbnRzIGZvciBv
dXIgdGVzdHMsIGJ1dCB3ZSBoYXZlIGRpZmZpY3VsdGllcyB0byB0dXJuIHRoZW0gb2ZmLiBJJ20g
dXNpbmcgJ21heF9pbmxpbmU9MCcgbW91bnQgb3B0aW9uIHRvIGRpc2FibGUgdGhlbSwgYnV0IEkg
c3RpbGwgc2VlIHRoZW0gZm9yIHNtYWxsIGZpbGVzICg8IDUwIEJ5dGVzKSB1c2luZyBGU19JT0Nf
RklFTUFQIGlvY3RsLiBLZXJuZWwgbG9nIHdoZW4gZXhlY3V0aW5nIG1vdW50Og0KDQptYXhfaW5s
aW5lIG9ubHkgYWZmZWN0cyBuZXcgd3JpdGVzLg0KU28gZXhpc3RpbmcgaW5saW5lZCBleHRlbnQg
d29uJ3QgYmUgYWZmZWN0ZWQuDQoNCllvdSBuZWVkIHRvIGRlZnJhZyBzdWNoIHNtYWxsIGZpbGVz
IHRvIGNvbnZlcnQgdGhlbSBiYWNrIHRvIHJlZ3VsYXIgZXh0ZW50cy4NCg0KVGhhbmtzLA0KUXUN
Cg0KPiBbMTEwNTEuNjQyOTc2XSBCVFJGUyBpbmZvIChkZXZpY2UgbG9vcDApOiBtYXhfaW5saW5l
IGF0IDAgDQo+IFsxMTA1MS42NDI5NzhdIEJUUkZTIGluZm8gKGRldmljZSBsb29wMCk6IGRpc2sg
c3BhY2UgY2FjaGluZyBpcyANCj4gZW5hYmxlZCBbMTEwNTEuNjQyOTc5XSBCVFJGUyBpbmZvIChk
ZXZpY2UgbG9vcDApOiBoYXMgc2tpbm55IGV4dGVudHMNCj4gDQo+IEVudmlyb25tZW50Og0KPiAt
IDQuMTUuMC05Ni1nZW5lcmljICM5N34xNi4wNC4xLVVidW50dSBTTVAgV2VkIEFwciAxIDAzOjAz
OjMxIFVUQyAyMDIwIA0KPiB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCj4gLSBidHJm
cy1wcm9ncyB2NC40DQo+IA0KPiBJIHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIHlvdXIgc3VwcG9y
dCBvbiB0aGlzLg0KPiBUbnguDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IA0KPiBEZWphbiBSZWJy
YWNhDQo+IEJTT1QvUEotRVMxLUJnDQo+IA0KDQo=
