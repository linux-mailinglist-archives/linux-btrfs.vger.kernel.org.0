Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74395BBC7A
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Sep 2022 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIRIGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Sep 2022 04:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIRIGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Sep 2022 04:06:20 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 01:06:07 PDT
Received: from mail11.tencent.com (mail11.tencent.com [14.18.178.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FBCC1
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Sep 2022 01:06:06 -0700 (PDT)
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail11.tencent.com (Postfix) with ESMTP id BBDC7FC079;
        Sun, 18 Sep 2022 15:56:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1663487816;
        bh=m56SytcDR21FyGSlAJy03TLknvHNKTBzoiVRUF9pIlQ=;
        h=From:To:CC:Subject:Date;
        b=bIm3j8wjo0T4NwTHONKPLB3rrn4A7tIVKKo6lFqd3Odb3CACaNcNHrwxK1TvQ2JIi
         gtIj5YF6QR7ixnAZmJ/VDxlubKSTZ+EDvH0aso9gJyM8n2a9yJmtkiTvgj7D+3DU9d
         wc/0pAotvuKFxuOkjY5de7fBMVM4XfKNHe6AtW4Q=
Received: from EX-SZ052.tencent.com (10.28.6.108) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Sep
 2022 15:56:56 +0800
Received: from EX-SZ049.tencent.com (10.28.6.102) by EX-SZ052.tencent.com
 (10.28.6.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Sep
 2022 15:56:56 +0800
Received: from EX-SZ049.tencent.com ([fe80::e0be:89c3:ec1:bef7]) by
 EX-SZ049.tencent.com ([fe80::e0be:89c3:ec1:bef7%8]) with mapi id
 15.01.2242.008; Sun, 18 Sep 2022 15:56:56 +0800
From:   =?utf-8?B?Zmx5aW5ncGVuZyjlva3mtakp?= <flyingpeng@tencent.com>
To:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH]  btrfs: adjust error jump position
Thread-Topic: [PATCH]  btrfs: adjust error jump position
Thread-Index: AQHYyzQ41TCWjtAGRkOT/Oz1xUVwDg==
Date:   Sun, 18 Sep 2022 07:56:56 +0000
Message-ID: <B03D6703-1496-4172-9A36-B90000372BDD@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <442FF82E05E5B84382A8F9E8113AAC3E@tencent.com>
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

U2luY2UgJ2VtJyBoYXMgYmVlbiBzZXQgdG8gTlVMTCwgeW91IGNhbiBqdW1wIGRpcmVjdGx5IHRv
IG91dF9lcnIuDQoNClNpZ25lZC1vZmYtYnk6IFBlbmcgSGFvIDxmbHlpbmdwZW5nQHRlbmNlbnQu
Y29tPg0KLS0tDQogZnMvYnRyZnMvaW5vZGUuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lub2Rl
LmMgYi9mcy9idHJmcy9pbm9kZS5jDQppbmRleCBmMGM5N2QyNWI0YTAuLmI1YzQwOGVkODg4YSAx
MDA2NDQNCi0tLSBhL2ZzL2J0cmZzL2lub2RlLmMNCisrKyBiL2ZzL2J0cmZzL2lub2RlLmMNCkBA
IC04MTQ2LDcgKzgxNDYsNyBAQCBzdGF0aWMgdm9pZCBidHJmc19zdWJtaXRfZGlyZWN0KGNvbnN0
IHN0cnVjdCBpb21hcF9pdGVyICppdGVyLA0KICAgICAgICAgICAgICAgIGlmIChJU19FUlIoZW0p
KSB7DQogICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSBlcnJub190b19ibGtfc3RhdHVz
KFBUUl9FUlIoZW0pKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGVtID0gTlVMTDsNCi0gICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2Vycl9lbTsNCisgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gb3V0X2VycjsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgcmV0
ID0gYnRyZnNfZ2V0X2lvX2dlb21ldHJ5KGZzX2luZm8sIGVtLCBidHJmc19vcChkaW9fYmlvKSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9naWNhbCwgJmdl
b20pOw0KLS0NCjIuMjcuMA0KDQo=
