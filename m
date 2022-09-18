Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E875BBC4F
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Sep 2022 09:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiIRHfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Sep 2022 03:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIRHfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Sep 2022 03:35:18 -0400
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 00:35:04 PDT
Received: from mail4.tencent.com (mail12.tencent.com [61.241.47.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44612AC2
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Sep 2022 00:35:03 -0700 (PDT)
Received: from EX-SZ023.tencent.com (unknown [10.28.6.89])
        by mail4.tencent.com (Postfix) with ESMTP id C385764975;
        Sun, 18 Sep 2022 15:26:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1663485967;
        bh=3+EFfKUw6FFDJYtVNQ2Q3dHNFaNrOjYQRaUm9MccsM4=;
        h=From:To:CC:Subject:Date;
        b=j2cyDbQ4ZfsdUzmNQ5vOa+HJ/Z8LgdNYN1ER5y6DPo109pmf+4VvWNy6WW+JyS7jc
         uu3hWHpkus+xNsZwrOGlbssoBcFq6aPtlpIbgVEvH0BBp+NyWYm8JqqzOn/WjyYwJw
         olZY3dev55+9CWE53jRBL6S3ggixiCwabY0/rSLw=
Received: from EX-SZ051.tencent.com (10.28.6.106) by EX-SZ023.tencent.com
 (10.28.6.89) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Sep
 2022 15:26:07 +0800
Received: from EX-SZ049.tencent.com (10.28.6.102) by EX-SZ051.tencent.com
 (10.28.6.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Sep
 2022 15:26:07 +0800
Received: from EX-SZ049.tencent.com ([fe80::e0be:89c3:ec1:bef7]) by
 EX-SZ049.tencent.com ([fe80::e0be:89c3:ec1:bef7%8]) with mapi id
 15.01.2242.008; Sun, 18 Sep 2022 15:26:07 +0800
From:   =?utf-8?B?Zmx5aW5ncGVuZyjlva3mtakp?= <flyingpeng@tencent.com>
To:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH]  btrfs: remove redundant code
Thread-Topic: [PATCH]  btrfs: remove redundant code
Thread-Index: AQHYyy/q5hfXSYJgGUqdpf9fOxBvgA==
Date:   Sun, 18 Sep 2022 07:26:07 +0000
Message-ID: <FBF470E1-D893-4AC1-B7E7-4F1CC33020A9@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.218.225.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1117A9F088F79B4C8E7A0187B2B94C17@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

U2luY2UgbGVhZiBpcyBhbHJlYWR5IE5VTEwsIGFuZCBubyBvdGhlciBicmFuY2ggd2lsbCBnbyBm
YWlsX3VubG9jaywNCnRoZSBmYWlsX3VubG9jayBicmFuY2ggaXMgdXNlbGVzcy4NCg0KU2lnbmVk
LW9mZi1ieTogUGVuZyBIYW8gPGZseWluZ3BlbmdAdGVuY2VudC5jb20+DQotLS0NCiBmcy9idHJm
cy9kaXNrLWlvLmMgfCA1ICstLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlzay1pby5jIGIvZnMvYnRy
ZnMvZGlzay1pby5jDQppbmRleCA0YzMxNjZmM2M3MjUuLmYzOTE2NWFlYzE3NSAxMDA2NDQNCi0t
LSBhL2ZzL2J0cmZzL2Rpc2staW8uYw0KKysrIGIvZnMvYnRyZnMvZGlzay1pby5jDQpAQCAtMTI4
NCw3ICsxMjg0LDcgQEAgc3RydWN0IGJ0cmZzX3Jvb3QgKmJ0cmZzX2NyZWF0ZV90cmVlKHN0cnVj
dCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KICAgICAgICBpZiAoSVNfRVJSKGxlYWYpKSB7
DQogICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihsZWFmKTsNCiAgICAgICAgICAgICAgICBs
ZWFmID0gTlVMTDsNCi0gICAgICAgICAgICAgICBnb3RvIGZhaWxfdW5sb2NrOw0KKyAgICAgICAg
ICAgICAgIGdvdG8gZmFpbDsNCiAgICAgICAgfQ0KDQogICAgICAgIHJvb3QtPm5vZGUgPSBsZWFm
Ow0KQEAgLTEzMTksOSArMTMxOSw2IEBAIHN0cnVjdCBidHJmc19yb290ICpidHJmc19jcmVhdGVf
dHJlZShzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCg0KICAgICAgICByZXR1cm4g
cm9vdDsNCg0KLWZhaWxfdW5sb2NrOg0KLSAgICAgICBpZiAobGVhZikNCi0gICAgICAgICAgICAg
ICBidHJmc190cmVlX3VubG9jayhsZWFmKTsNCiBmYWlsOg0KICAgICAgICBidHJmc19wdXRfcm9v
dChyb290KTsNCg0KLS0NCjIuMjcuMA0KDQo=
