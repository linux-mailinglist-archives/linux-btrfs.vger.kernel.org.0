Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABAD1469E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAWNyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:54:02 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52456 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgAWNyB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579787640; x=1611323640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q3oKMRrnhM8fN25uwBOdi42c+HZMgr28pgY3fvDN6u8=;
  b=T9LFcO0t6kz5/wmF/3vl2fCPGq/qEYxvz0w03Zt3vuz7iaG2hglwh8w9
   5d15xYANBF7Hqvucxi8wDDwjp02ND2QZ7tvlT8sAMT5RYkc44hY5uzENh
   pJcWeQ/VvTu/y3honlafArmboOmSh2eOP4WIwtquYo0hK9UML7sCC5V24
   7uoModRFiIXmATt2bpdFoF7BS76PHLReqTM57O1fEJpIg36QeNyiHWjyd
   ckMy9diqcPTSQBs5Flvas4PrZljJRt+yLUS7N68mP1s+kB+iMs1DaTg5g
   Wn/AqVuxHKibRA0WeP7Pm6SfMBHQdMXi49+S4tpZ5kOU/zR3SP7Bs9GVa
   A==;
IronPort-SDR: XxH0w0yf8ofAWDEGIYdQiS0NkKLRW5Z9V7sugSJ2Zxe3lkqm9vrBa7yrL/lXlSgiCEIvH1RdlM
 q7h+fUZow6s6WYJabRbTFF1M4gFrMk4V0+Bvn+tL1rZ7lBhi5GFMr4KllHQdQQlVB7MrARIpx2
 4r82aLUsxS6P/Lz8gIGo2GzZgHjMl0dSgXY4xoFiLC4v38pq1AYD0P/nCRioL0bICZXG+ZIpK/
 QA3mK31JIP/PJZePZgAI9d/8dR1CZoKMnUnYltWU0kYpSPet/WPLSKKDG1j5jBXY4IsTLGkpVX
 VCM=
X-IronPort-AV: E=Sophos;i="5.70,354,1574092800"; 
   d="scan'208";a="128265142"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 21:53:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf8ch1TLPak+neLAdC7XZaYQYqbbBVKBmpGPmWfOrNoswyfMn8A39Ap165pGL9DEWFhJsapmhK81q8khFTDzjxgou35PJq7QPRZtzUbPZgBbb4/rmd24UngV8Vj4BNIgHWYlUIFvJxoODfOASwTuQ6YdUrFHQGtGfj3RZcw17HmgshpBywYLyCOg+S4xudoxklLk4XloLwgjoxm3FqqCcaEKQNZDhafsHpsgmJpBrj6fhWlcKKwjZmIs5nKuVXBfRx0elagdqpR4yJ19SGoM/8dl5ZcTFVbPrO8NT1Zi8/SaHVHJQESbCKwLs7UzGeM/ewiN6ujqdu9tHb1H1Pyxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3oKMRrnhM8fN25uwBOdi42c+HZMgr28pgY3fvDN6u8=;
 b=oeMsEYDBI8mGozLJgfqErBElethrCkJIkvPbAk1wW2j4OV20OIOybNYvkh1Km9G8r0HblG8X37zUz2MFUdPHgBmQPF//aFwmffF65T2Bctji2gq+VRKMR1OwPa+swalESR7h8npySk14jBJPFvqUO1g6ntvLv6DjwJY0Pk7yvcNytWkjgilfJGMVA2baCK+P05d1fzljKGdebSfdfJE56YOS5BdYvYb85uRk+coIdWfAPLlACXkt4wlTBB8K7k8HRiAK4UI87jh6kNA4uSRamJU3PTfJJFkCHViHAMsm2DqNFNa+Hnlh8j3AOS4EmgaOwwPFAsCcQ7t6SenLk6A3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3oKMRrnhM8fN25uwBOdi42c+HZMgr28pgY3fvDN6u8=;
 b=WPJhUoJnl1ACBweOrw/v20RktM0WtlpbQigR9Q/m7QgaZ4/PltuvCvlzLIDKuqPJJSLA7zvIQwtvfPobSSbhG4ijw0Gm+uiKqpy1+G2Mvdd1B5og1T8e8lDMKQ+z9SJt2a3U9LE1K6pQUs6OcsdHSzusKnS9ENtkM/hC9zjDWlM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3709.namprd04.prod.outlook.com (10.167.140.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 13:53:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 13:53:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
Thread-Topic: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
Thread-Index: AQHV0cXHkUCI/FABkEap4YMcvpYhNqf4RN6AgAARdQA=
Date:   Thu, 23 Jan 2020 13:53:56 +0000
Message-ID: <EAD03B78-F757-4103-BC46-6F8A861D54C4@wdc.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-3-johannes.thumshirn@wdc.com>
 <9c65b644-6769-12f8-ba93-5f13f89f9bff@toxicpanda.com>
In-Reply-To: <9c65b644-6769-12f8-ba93-5f13f89f9bff@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8d82993-4e8a-4891-fd3f-08d7a00bb124
x-ms-traffictypediagnostic: SN4PR0401MB3709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3709F9BA5550DFB3DAEE755D9B0F0@SN4PR0401MB3709.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(4744005)(36756003)(110136005)(316002)(54906003)(2616005)(26005)(186003)(6506007)(53546011)(5660300002)(33656002)(64756008)(66556008)(66476007)(8936002)(66946007)(71200400001)(81166006)(76116006)(91956017)(81156014)(8676002)(6486002)(478600001)(2906002)(66446008)(6512007)(86362001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3709;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dAXKgN9XVZGMR7sDiarql6Ou8CKdyPRwrlljEp3o/YgKLZyKXtVh9le0QmRWgNkIgnYC6IsYZE6YM4lxW06nz7f1f0D0YQNK2CNVJIez+gCoq8SMDslfrMyn/pu/6fgTwedXlGb7VLgE/MouKg6jDiTp6+sy7rFkqSEyrhS0a5lgX7riALUD1EZu7yHMWjTXdjkFDLv4XTay5j25OHXAaFIemwgu+iCw8/qfVscHCloAW1wDOtm3BIZ0UoMVK4vG7ZhMQ8Imhj2Lw/1fuOsf/Pg5P87+Kg4sQZN35f63VVFW15trRdafZvVsWYHBSLosjyYZFvS0PpubTKJKGEWJ+uOaqWug47a/tTb0nGLgpXNTa88MMMpUPpCKXfpe55t6QrvMJ9flVfbaSha664JbPHWOSwIwaWKsS1jvrt38BK9rNDoOWky0IeBukmpJRVOr
Content-Type: text/plain; charset="utf-8"
Content-ID: <677CA50EEDE00E47BCA1C3C4BB5A33F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d82993-4e8a-4891-fd3f-08d7a00bb124
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 13:53:57.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maFQioDe0pxHV4OJzLa3ZKlQUACjPDSQgmgSYNW13xAfc2wU7LjEFKCcgGqgcCSwzS95C3axD27OPB6AfFEDdxn1YXuwNWNHSVz0yxT2SyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3709
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjMvMDEvMjAyMCwgMTQ6NTEsICJKb3NlZiBCYWNpayIgPGpvc2VmQHRveGljcGFuZGEuY29t
PiB3cm90ZToNClsuLi5dDQogICAgPiAtCQlicmVsc2UoYmgpOw0KICAgID4gKw0KICAgID4gKwkJ
YmlvLmJpX2l0ZXIuYmlfc2VjdG9yID0gYnl0ZW5yID4+IFNFQ1RPUl9TSElGVDsNCiAgICA+ICsJ
CWJpb19zZXRfZGV2KCZiaW8sIGJkZXYpOw0KICAgID4gKwkJYmlvX3NldF9vcF9hdHRycygmYmlv
LCBSRVFfT1BfV1JJVEUsIDApOw0KICAgIG5pdDogV2UncmUgbG9zaW5nIFJFUV9TWU5DIGhlcmUs
IG5vdCB0aGF0IGl0IG1hdHRlcnMgYnV0IGlmIHlvdSBoYXZlIHRvIHJlLXJvbGwgDQogICAgaXQg
bWF5IGJlIG5pY2UgdG8gaGF2ZS4gIE90aGVyd2lzZQ0KICAgIA0KTm8gYWN0dWFsbHkgd2UgZG9u
J3QuIHN1Ym1uaXRfYmlvX3dhaXQoKSBpbXBsaWVzIFJFUV9TWU5DLCBzbyB3ZSdyZSBhbGwgZ29v
ZC4NCg0KICAgIFJldmlld2VkLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+
DQoNClRoYW5rcywNCglKb2hhbm5lcw0KICAgDQoNCg==
