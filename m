Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24314377E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 08:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgAUHT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 02:19:29 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41196 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUHT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 02:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579591181; x=1611127181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gWAbzKEvZ7gVf+wLxCZ5S4Q10iMfMczzXNjSyBs34KM=;
  b=jaxcbGtJcYNzI7Q2GBIgSJ4J6MyHXnKHYi2kP6vHzayMcyZTgee851iY
   JIwJMm/5OffFskJmqb37g6yPL96n+J649ajKVNXSIA2HicAOjiPV5ARbq
   iHuC5A50l2cKNwsdpTAj+g7jkhZ0eYoQii7L4JFAUvkW01eJzUj8d9b1G
   u4OLGrWOmH6GvCzEKf+0AGgN4/vC1ooPVGfaK4EinWKc/p514Oc3xs54v
   X5/PIOEgcuOAtVgXo6OdxkAtfnS1DDlJac5T709Nz4CgQKiltv6zOid10
   jzsAPkAFi5mihdhIzfzmvAqpZFg4PWdeeI3aVnps163NFCP+Sx5L/Fmai
   w==;
IronPort-SDR: iZfDHZQEAgZiSEurgkeFgftoK9YIgOjnsm5Iz24Qtr9mODCOz7Y7xrBzIg4Lc1UB1c/vfARH97
 SKyyFGoI5RHY8E5n+CPwvz3wWJXGPwid8QtM1mj/npA+8vXgtlsNeja9Ta7w0Nl7xjdA58sc/a
 8hvWpZTWzK+DM9bKxnM4ChepCH6D1She+bwyaN72CZfNYHidfkkLE/qircfhukgz2NoB1qtmsr
 Znufym4wDBhSiOa5keMX5elQ2EoCW2ltfcnwmEoGWfj4FmKfYzxJ5TikEcOwtDOj+ZdNr2218b
 czI=
X-IronPort-AV: E=Sophos;i="5.70,345,1574092800"; 
   d="scan'208";a="229730856"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 15:19:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvJ4jT9Z0kriu8FXAg0JlZdyQ9Cuhlv4rHoobECFOCbVZCac1inttqwG5abb/hC9JgNiOM5CG/nSbw4XRWTcZWtgcicKFkBO7JR+cQ+AI+JWOn+qoteUqDSU/qbua8KP7QhKps8KYLiIzrA3ACuggiNOH1eGoyVQKst3mU6NGc94xOsb4SXb/rt7gFvvYR4vr4wxsBgWpvJUa4i+ehIc31mBE0bgKxJWxdAJMy04uKQ2esPyN7Y9EqSsTR0Zn3yH95A4soUXJ8yChxJMOEca7FGsuYZgsc1q7Xrf6k9AqOTKkGPj+qcA/AfPmwIrbyX3zoB0TakFHrR4qG3A8XgoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWAbzKEvZ7gVf+wLxCZ5S4Q10iMfMczzXNjSyBs34KM=;
 b=F0JV8Tj3GVMcXEBFCvSkLzFWaYtnfcP+DzbCzcD8+ESk85UjRLnAkqP7KyuvfePDOlwmTSUiAQWr1wA3YY6M3AbTCKd3qnhPtPcBV7ncvF+JBCFBn0IXT7VpAzeOgTFtcw9huDTzIVG/3+/GdvGa+7M9TOqasGCzEBnRzRi1quMdlLtxFVVcEjyczjA7oDwHNNqNG9blLDvoP/9VzfQhOgSimxqYb7rUGrFSL++KxkABI6w+osxRSQzG2xjfK2Od3QPKtY3pZG3TR4nDBhz1SVqeozOYvMNLxsYru1tIij1+dx2P/7lRLDaHEqt2FnSxIIU26u+rYFi0VsGmmytSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWAbzKEvZ7gVf+wLxCZ5S4Q10iMfMczzXNjSyBs34KM=;
 b=HH8umovuVjbpRWin4GlQ7KBHcJYFbWUOJpA/iuXjSlZ6qOAqNR3nrbZBXjvY8/LnW912duUfxYFBamu0M1NSBrPNw9IK1dT8AWd+F1T/zK8DbvcBk4p8Hu4syywH2OwictwGXOYRSQavsGcc5oQMbtA0xsPQze57mDwrTO5R7Ns=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3695.namprd04.prod.outlook.com (10.167.141.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Tue, 21 Jan 2020 07:19:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 07:19:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.cz>
Subject: Re: Next btrfs development cycle - 5.7
Thread-Topic: Next btrfs development cycle - 5.7
Thread-Index: AQHVz+pSUPX1juBSr06K7nlHRBW7/af0xyUA
Date:   Tue, 21 Jan 2020 07:19:25 +0000
Message-ID: <799E35AB-EF29-4ADF-A6BB-3E129A33310C@wdc.com>
References: <20200120233515.4209-1-dsterba@suse.com>
In-Reply-To: <20200120233515.4209-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.208.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 007f9c5e-4486-414e-f120-08d79e423ee3
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3695ACE079C8067C072D899E9B0D0@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(26005)(186003)(86362001)(6506007)(36756003)(53546011)(110136005)(316002)(2906002)(2616005)(64756008)(76116006)(4326008)(5660300002)(66556008)(91956017)(66476007)(66946007)(66446008)(6486002)(81166006)(6512007)(71200400001)(8676002)(81156014)(478600001)(45080400002)(8936002)(966005)(33656002)(16799955002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3695;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZJwfYsEX9+h2wEbYQZ8ouxHAjWQrBQ+cdPsjLVoOpRPhVUs9kameLwA0c0elIxS+nACefCy1AesElyDibrDU5VbxWmosIVd0jyqN1m2H1wt5dST3UhKPPYkyumdMlEdnyCyd0Z3H91doy0+OF9y8cVN8KW/JSYq39oy7xrLhFvOqtUT5gh0vC4NrqBWJsY0dgkCDU6wfAACoTfxL4noLWnf3ZsFd51Ifkmqaew/XbaUEQUNthtdkEJfmfR8lVs5xLa6umjYvEV7B98b0OKL4w6dMNXfv315t8mD++0nYoGRWCLi56Tk+x7idTp9YUHFAs6OD7slTTH8iB4AeGAJT1JvjIlxTmJB81vKI8vO81+9j0z+WxL7//+rP7WIWagP7IJ0UFAzKjl6o/+ffQUZfWGZCRCrI31o/vZudBQ7jlA97+SPgXZ04Tso1Yv5LgOrLK9DU6r5Zz4KvbWaSPyDhHieUz5Va+mw8i8mTFLd5Q/reKFs7uOmAwLek+r/un+3GObQYV0yaweCn1NBaC5eow==
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A4D489999BC140A5F449A1FD079094@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007f9c5e-4486-414e-f120-08d79e423ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 07:19:25.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2X+xs1+VWqxiYSHjO0st9jEgmaVk0qkgySoU1OFchLHFeCzCvAqnEi8jQY15l1wTog+jbAHwJzRmWgwWaag9EJ4ocMb/cvFA8DIY28jXJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjEvMDEvMjAyMCwgMDA6MzUsICJsaW51eC1idHJmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
b24gYmVoYWxmIG9mIERhdmlkIFN0ZXJiYSIgPGxpbnV4LWJ0cmZzLW93bmVyQHZnZXIua2VybmVs
Lm9yZyBvbiBiZWhhbGYgb2YgZHN0ZXJiYUBzdXNlLmNvbT4gd3JvdGU6DQoNCiAgICBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFdlc3Rlcm4gRGlnaXRhbC4g
RG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNv
Z25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGF0IHRoZSBjb250ZW50IGlzIHNhZmUuDQogICAg
DQogICAgDQogICAgRnJvbTogRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY3o+DQogICAgDQog
ICAgSGksDQogICAgDQogICAgYSBmcmllbmRseSByZW1pbmRlciBvZiB0aGUgdGltZXRhYmxlIGFu
ZCB3aGF0J3MgZXhwZWN0ZWQgYXQgdGhpcyBwaGFzZS4NCiAgICANCiAgICA1LjQgLSBjdXJyZW50
DQogICAgNS41IC0gdXBjb21pbmcsIHVyZ2VudCByZWdyZXNzaW9uIGZpeGVzIG9ubHkNCiAgICA1
LjYgLSBkZXZlbG9wbWVudCBjbG9zZWQsIHB1bGwgcmVxdWVzdCBpbiBwcmVwLCBmaXhlcyBvciBy
ZWdyZXNzaW9ucyBvbmx5DQogICAgNS43IC0gZGV2ZWxvcG1lbnQgb3BlbiwgdW50aWwgNS41LXJj
NiAoYXQgbGVhc3QpDQogICAgDQogICAgKGh0dHBzOi8vYnRyZnMud2lraS5rZXJuZWwub3JnL2lu
ZGV4LnBocC9EZXZlbG9wZXIlMjdzX0ZBUSNEZXZlbG9wbWVudF9zY2hlZHVsZSkNCiAgICANCiAg
ICANCiAgICBDdXJyZW50IHN0YXR1cw0KICAgIC0tLS0tLS0tLS0tLS0tDQogICAgDQogICAgVGhl
IGFtb3VudCBvZiBwYXRjaGVzIG1lcmdlZCBmb3IgNS41IGlzIGhlYXZpbHkgYWZmZWN0ZWQgYnkg
dGhlIGVuZCBvZiB5ZWFyDQogICAgYnJlYWssIHRoYXQgaXMgYWJvdXQgMiB3ZWVrcyBsb25nIGFu
ZCB0aGUgZm9sbG93aW5nIHdlZWsgaXQgdGFrZXMgdG8gZXZlcnlib2R5DQogICAgc3luYyB1cCBh
Z2Fpbi4gU28gdGhpcyBpcyAzIGxlc3Mgd2Vla3Mgb2YgdGVzdGluZyBhbmQgSSBnb3QgdGhlIGZl
ZWxpbmcgdGhhdA0KICAgIGV2ZXJ5Ym9keSBqdXN0IGR1bXBlZCBwYXRjaGVzIGJlZm9yZSBnb2lu
ZyBmb3IgdGhlIHZhY2F0aW9uLiAgU28gdGhlIHBhdGNoDQogICAgYmFja2xvZyBoYXMgZ3Jvd24g
YWdhaW4uDQogICAgDQogICAgQ3VycmVudCBtaXNjLW5leHQgaXMgcmVhc29uYWJseSBzdGFibGUs
IG9ubHkgc2VsZWN0ZWQgZml4ZXMgd2lsbCBiZSBtZXJnZWQgYnV0DQogICAgbm93IGl0J3MgZWZm
ZWN0aXZlbHkgZnJvemVuLiBUaGUgbWVyZ2Ugd2luZG93IHdpbGwgcHJvYmFibHkgb3BlbiBuZXh0
IHdlZWsgc28NCiAgICB0aGUgdGltaW5nIGlzIGFkZXF1YXRlLg0KICAgIA0KICAgIA0KICAgIEhp
bGlnaHRzIG9mIDUuNiBjaGFuZ2VzDQogICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAN
CiAgICBBc3luYyBkaXNjYXJkOg0KICAgIA0KICAgICogYW4gaW1wcm92ZWQgaW1wbGVtZW50YXRp
b24gb2YgdGhlIC1vIGRpc2NhcmQsIHRoYXQgbGVhdmVzIG1vcmUgdGltZSB0byBmcmVlZA0KICAg
ICAgZXh0ZW50cyB0byBjb2FsZXNjZSB0byBsb25nZXIgY2h1bmtzIHRoYXQgYXJlIG1vcmUgc3Vp
dGFibGUgZm9yIHRyaW1taW5uZyBhbmQNCiAgICAgIGFsc28gbGltaXRzIHRoZSBkaXNjYXJkIElP
IG5vdCB0byBpbnRlcmZlcmUgd2l0aCByZWd1bGFyIElPDQogICAgDQogICAgKiB0aGUgY3VycmVu
dCBkZWZhdWx0IElPIHN1Ym1pc3Npb24gcmF0ZSBzaG91bGQgYmUgZ29vZCBlbm91Z2ggZm9yIG1v
c3QNCiAgICAgIHVzZWNhc2VzLCBidXQgdGhpcyBtaWdodCBnZXQgdHVuZWQgZnVydGhlciwgcG9z
c2libHkgYWRkaW5nIHNvbWUgdHVuYWJsZXMgaWYNCiAgICAgIHJlcXVpcmVkDQogICAgDQogICAg
VHJlZS1jaGVja2VyIGdvdCBtb3JlIGItdHJlZSBsZWFmIGNoZWNrcywgYW5kIGZvciBsb2NhdGlv
biBrZXkgZm9yIHZhcmlvdXMNCiAgICBkaXJlY3RvcnkgaXRlbXMuDQogICAgDQogICAgDQogICAg
TWVyZ2Ugb3V0bG9vaw0KICAgIC0tLS0tLS0tLS0tLS0NCiAgICANCiAgICAxLiBmaXhlcywgbWlu
b3IgY2xlYW51cHMNCiAgICAyLiBmaXhlcyB0aGF0IG5lZWQgcmVmYWN0b3Jpbmcgb3IgY2xlYW51
cHMNCiAgICAzLiBzbWFsbC1zaXplZCBmZWF0dXJlcywgd2l0aCBhY2tlZCBpbnRlcmZhY2UNCiAg
ICA0LiB0aGUgcmVzdCAoYmlnIGZlYXR1cmVzLCBpbnRydXNpdmUgY29yZSBjaGFuZ2VzLCAuLi4p
DQogICAgDQogICAgSSBkbyB3YW50IHRvIHNoYWtlIGRvd24gdGhlIGJhY2tsb2csIGJ1dCBwbGVh
c2UgdW5kZXJzdGFuZCB0aGF0IGl0IHdpbGwgYmUgb25lDQogICAgdGhpbmcgYXQgYSB0aW1lLCBz
byBpdCBjYW4gYmUgdGVzdGVkIGFuZCByZXZpZXdlZC4gWW91IGRvbid0IGhhdmUgdG8gcGluZyBv
cg0KICAgIHJlc2VuZC4gV2lsZCByaWRlIGFoZWFkLg0KICAgIA0KICAgIA0KICAgIEdpdCBkZXZl
bG9wbWVudCByZXBvcw0KICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgIA0KICAgICAgay5v
cmc6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tkYXZl
L2xpbnV4LmdpdA0KICAgICAgZGV2ZWwxOiBodHRwczovL2dpdGxhYi5jb20va2RhdmUvYnRyZnMt
ZGV2ZWwNCiAgICAgIGRldmVsMjogaHR0cHM6Ly9naXRodWIuY29tL2tkYXZlL2J0cmZzLWRldmVs
DQogICAgDQoNCkhpIERhdmlkLA0KDQpJcyB0aGVyZSBhbnkgY2hhbmNlIHlvdSBjYW4gaGF2ZSBh
IGxvb2sgYXQgbXkgQXV0aGVudGljYXRlZCBGUyBQYXRjaChlcykgWzFdWzJdIGZvciB0aGUgNS43
IGN5Y2xlPw0KDQpTaGFsbCBJIHJlLXNlbmQgdGhlbSByZS1iYXNlZD8NCg0KWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIwMTkxMDE1MTIxNDA1LjE5MDY2LTEtanRodW1z
aGlybkBzdXNlLmRlLw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIw
MTkxMDE2MDg0MTU4Ljc1NzMtMS1qdGh1bXNoaXJuQHN1c2UuZGUvDQoNClRoYW5rcywNCglKb2hh
bm5lcw0KDQo=
