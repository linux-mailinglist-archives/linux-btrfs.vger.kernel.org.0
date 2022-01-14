Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1B48E1C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiANAwk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:52:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63636 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiANAwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642121559; x=1673657559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QodWgz94nDP+DHLXuVVMygl2m9Ij89Rq6LbB5uME0CQ=;
  b=JMW0P5GdAsXjx87TOFcmNsvess6UN0scngLEx/PwUr5QjDuVf6I/IiSX
   8Qg6hJmC1apDg+01bYw0xSC1EOhVn3Gyd7NxGq9ejRiYGNwjo8NQgU35p
   JXtIuJrQyZlF9bi2pWHIweOnT/3DuH4bvLl/VfDVw6oFaQCpd78Y8WXm+
   WUtCccUojjPx4HIwwSqwCsdanU4Af3j0LSG/YvW47d1ZUoXeNV/otiNhr
   489iASyEPozSOv9rM2cDNRY1c7NU93Giw1MvkNX8i5DfEYW7RhU6NP2+0
   0J1JOwU4+2IHU+FbK1B/p/6DlC7h2gVFFWFun4PVITDkoa78u9AoAeizC
   A==;
X-IronPort-AV: E=Sophos;i="5.88,287,1635177600"; 
   d="scan'208";a="189388879"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2022 08:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHpYvbNo8KM1TmSkDyApqMb0z8eMWJeIh0SFx9wyRzjiagrnCBJtq2SHeHs64P/k1THD5nC+u1EK5DpOAQc3YIbY+TqgsGo1nzsQNtnaujgolLKua/wrarM8bTDmSpK3OS39IP3W3KJmpLpcJR3L+yVqwmo4zDBMjrC4dcQNIfAhZMbA4gDCNIEZtVwM+I88kBdOZgyyW59kbJnlm5kBaLjH2pgHHbPO9M6E2gIcpXHRKTf7PTn/TxURFwVD6r7k9KewHB5ydEOMNFwdnSdx248OjtWvwhxDiJqy2zEdNBGBiim6eWv/8SDK11pxOYCuLsYw1WR/UlqBOSgSt7mgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QodWgz94nDP+DHLXuVVMygl2m9Ij89Rq6LbB5uME0CQ=;
 b=fwC2zCEUaAbsNToRZi0hN9vTOz8DwNCZ5+VhoTKWUfg9i6kJl0ABwNPsKTZmjR/4BIaaQV/9Kl3pR5iNHe26ysJWg7OmsLxoUe1kHfaz2T2Nu1jL6YgPG2D21Q75khDCrx2wkadj08vTGQe9tZYQM+2bPkPxwI20eINk/zKJA0aj5yxa/xw10dUbgeUZs8HgooHhMF6NNPw6oXMa6/NFbfS4XlJAyzBz/NAWT49YacIA53bN17CDLAwEbTuIzDOOIFZ6RsrnF4L/i0ViMBPkGJj1CPDWb/L1VNkW+f1gHkdj9tomsSh4ZmYpYDW9ATO/cjj7AOVud7nUyXpPQdBpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QodWgz94nDP+DHLXuVVMygl2m9Ij89Rq6LbB5uME0CQ=;
 b=bDz1OEQ/cY0jQ0ElTpLpM87lhHuJylxhAM+vKFwpWmF1Y9NOogYg7XegO7uDHCCi2sqNvkDMMLPMju9pfoDmL0z2qfjQ7bzqTLOv0aGMDx825v5bl1LdHJjT7J5jAQ2l/tOAC4SbCaPaTJIpmZT0YoivGt9Y4kwX2Bs+YuTkS6k=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7869.namprd04.prod.outlook.com (2603:10b6:a03:305::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 00:52:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd%7]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 00:52:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Thread-Topic: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Thread-Index: AQHYCGn+Q1quPPNsLk6Wk9uNZEhSIqxg6DiAgADI/gA=
Date:   Fri, 14 Jan 2022 00:52:37 +0000
Message-ID: <20220114005236.yrvqqzpegik4xhm3@shindev>
References: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
 <fa15b470-c2ad-152a-9398-17bf65be4eba@suse.com>
In-Reply-To: <fa15b470-c2ad-152a-9398-17bf65be4eba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df3e111b-7fda-49f0-5e6b-08d9d6f8290b
x-ms-traffictypediagnostic: SJ0PR04MB7869:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB78699CF55B287A6CE1424EFEED549@SJ0PR04MB7869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8kIyn6Fzo9NQm07oGNHF4GrgAt5Ei4HXsUl8ZhjNTVsX8Z1fioSmaghD4u2WgrfPzljCE5xlCa4BaZEB0pIbrz0aela+UR9ur752GDrIIbZxHRzhkOXY9Ik2d0VwXp0dQrByFNVYb49u3gZuhyznPmWWMJPB9X8UKAaKR4E+P8/Zk0cFc9XLOlylXOM863sr2Nf7dIEpNLiGWulECK0vTUoPDxourcwOI7SYeDAUHzWFsZur1UD8aTwe62b6A1h3DWsCr06zoFA12b1tbJITh1I9xu3VWU6gaUIL1uyjI0hNeVEg1M//TW8hEIdv6U1ByOQArGTO7Ad0gipT8AaiPSEI8JKJO65REAOz7MNQrrmPYVVVq92JOwunMgi3MJipnwt9d2rzjm6FgZvU1IFhrWunJVPsridFwsmaG0obBUQYQM9N8uTB9BzmrmU+pwgVi450NH57HT4oBaarHUOHLOGdeWF1GN0SfH7fBNBmRyzVGXv8G3oaVJQD9j3vLhPZWp/TOJhIf0WPgpZkOLYmF7JdUfUZWit5A2OHMmVeqtpDlPPqCVrnIuKsd2yrp/2U0KPVlYd1Rt9gzSTL9isAVtAcrfwYeUOfulFGJz4OtdsZQL1+mjwPf13KxJbS8AfD8rogGybb1jlB0pl0uZk8de1fnK1P4WDL1BjTUV5Bl+FP7dlOe1xO5XmhVUL9uv/U7yC6MqHbvUWw9OxF0u8VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(316002)(66946007)(9686003)(8936002)(6512007)(76116006)(91956017)(508600001)(26005)(66446008)(6506007)(5660300002)(2906002)(8676002)(83380400001)(54906003)(66476007)(82960400001)(86362001)(38070700005)(122000001)(186003)(71200400001)(1076003)(38100700002)(6916009)(33716001)(15650500001)(44832011)(64756008)(66556008)(6486002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blM0aUR3M0JOdjBZS0tvaDYwUi9iWm9pZy9peWl3bWt4SEdEb1VlcVh4d0lC?=
 =?utf-8?B?amtKZ2RjUmxQdDRJTlhYQmNRWlozYzJrMmV4MGZtLzg3LzlrTTB6QUlEK01t?=
 =?utf-8?B?WFFFS1NBbWlIUVhXRE5LQ21vd29PQkdneDlrMjBwSy9xR2FYN3JiNElYaTcr?=
 =?utf-8?B?VlJ2RTA3ZUNBSTJlMlhlZWFlMk5tRnM5MnhjdXdGc3duYkp2aFBCd1N4bVFt?=
 =?utf-8?B?Ui96MktOUFFOV2NMa3Q4T2w4NE4rV0pBNk4wd3BnTFZQYVQ4ME5QR3l2UWhZ?=
 =?utf-8?B?a3NEc0JlSnVSRG83aUFON05DSSthd2FiMW11akN6dmQ3YVFjbkgxYmF0bXdS?=
 =?utf-8?B?WEo3THBKNVZaZTRveS9JMFhVOHFETlV5RUFGcFVTcjd3ZS8zaXRBTU5aWHpY?=
 =?utf-8?B?WDVuWEtFUFNmekxnaGxua1BXTU1iYVJXNVZGelFYbnIrdi8vbGkrVEMrZXJH?=
 =?utf-8?B?VzNWRnBuRjZxM1A5TlNwRWptWlZxUmNHaUJRYXhteVpVNXRNZXlMWnZENWtS?=
 =?utf-8?B?RUdlRS8vV0ovR2pzVHVOOWFTNTV0ZGtleUpzNjhpWmZvQzQyRk1lSFgzditW?=
 =?utf-8?B?ZVFqZkh0ZDVNUURHS1ZSdHNOMnJWTUtndWJ6NGliOVUvaXo5U1BYeXdBVUpS?=
 =?utf-8?B?SklwcTd1N1NtaXRkU1VjWHJiaWR0T1FUb3RGR214ZHJpUGdQditDaGNZMlNu?=
 =?utf-8?B?eFpxZVBwUWZQUFQwQnUvS3BiL1RDd01WYTFQTVZBQW9wWVpyWGwvMzd6NWVE?=
 =?utf-8?B?c0Z5QUdEQXdER1picitxOWFDNHNUZGZhWXcreUlPelFmWTVZRmZuZHkwUWEw?=
 =?utf-8?B?K00veTJyTXY4U1dPTU9xQzdRd2FabFBKSkxaMFNWYWZwOXd1T1ZSS1hNZmtR?=
 =?utf-8?B?ZzA2ZkhROVJDb1B5NFY5TkVhRUlaVC8vKzVVVWZxUXpLT3ZHNkZod3pITTBw?=
 =?utf-8?B?Q3JEaEZvY3FSUmFBN2NrcFBra28zS2JQRHlqcjVuUUx1YlU0OFlZMzFQUlF6?=
 =?utf-8?B?VWZobU1PSUg5OHJSM2oyTnJoWHNXT1huYVVDRzl2RW14bi9mVGpIN3pxcm9I?=
 =?utf-8?B?R0psa3NGeHNIUnc4RzV6b1N3R21CdG50UmpLamNkVXVIVkhxK3ZJZ2hPWEJT?=
 =?utf-8?B?Y2ZLRGRLMEFaNWRVOHN1YW9sckN0aTYvdXBPWklGanF3MkdoaW0rZXk3TERZ?=
 =?utf-8?B?QWVsbCtMOUw0ZWNRaldmWFRraGp5cmFtZm9INjZDYXhJdmVoWm5qZjhLYSt0?=
 =?utf-8?B?OWZzT3ZZM2VZRGlFTVZCSUdPai96RzRLY1pKQ0F3SVlDMnlISmNZOGNkd3dx?=
 =?utf-8?B?dFJHL0UxKzlDeTg2MzBsNGd1TXhXeDhTYndBUHo5QzlQYVpIYWk2Y0NvUVdO?=
 =?utf-8?B?YnZqY25neWFqbXQxMEFwN0V5WVJRazIvaFZiQ1d1NitGa1lCa1pVRENqV3JN?=
 =?utf-8?B?akJVb0MwUzhwNXg2QmpkQituTWVJdzlzSUlQRlJSM0cxelhoSTlncFBGN1hT?=
 =?utf-8?B?eG1yMk5LNHcvUzVlSEVaYWV2RU9Kc0dRcFJqRmdVMERMaUtmemtTQTNSUlNa?=
 =?utf-8?B?cmRkQnBsZXBLNUg2L2FpYitNOWxzUXVBU1BoS1BHZzhURENDc1FydlRtTXc1?=
 =?utf-8?B?YnkrZXRpWDZCSDdOL3N1WDR5Skk2bGlkY1FFQUcwdXpTbUsxSTdMZEE3QUpO?=
 =?utf-8?B?U1Z0Q0xQUUhwRWY4ZmtNSWZkaVJGQ0hxRFNYS05NSm9xK1o4Tit0L3lrOURB?=
 =?utf-8?B?dVlDM0RuQmpGV0NVamJZRkRvMnFYZ1cxSk4zdmRBb1Jqdkhxc0ViL0p5K2NJ?=
 =?utf-8?B?TTRMWStFTEZ0RmRXT0pFMkl5dE1NbWZGQW5zMDhXN202NDEvS0EyUlhMN1pi?=
 =?utf-8?B?MzhUMUZ1R0lvS3hzc2lWYXV0T3p2NXNmOTN0Qk5IYnRVbEZLN0RpSjB1NVpr?=
 =?utf-8?B?TnZQSnQxemVxUk5QcGpNTWZLdTRZb1hNM2lhL2Vmbk5vMkp0QUYxS21ITG1J?=
 =?utf-8?B?cXlTY01BbDA5UGdqUjBNV3hmTTlKaDZjNU1ieEpBMk1lRzVhd081SDZRS2g4?=
 =?utf-8?B?YkY5REFXMVYxTUhKVUZ3czdpaGJLd2JyWXBhdjNiQ3J1VXdSOHRtelE3WW9t?=
 =?utf-8?B?SkFtN25wUlUweUc0SG9HNmZuNDNBOHpKMXAxdFNnLzVBK2k3OTNSMVFVV3lD?=
 =?utf-8?B?QVArNXI5Wi9jWjJxaVNMM0YwZGp0YldyNzhNNnlvanBMTmJYMmh0bStDUFIy?=
 =?utf-8?Q?yKbEeebBFiBY7JY09+Gre5RE9SO1KyxKGc8GmwA5ho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3122E35476AB7C4CA105991157FEFE9C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3e111b-7fda-49f0-5e6b-08d9d6f8290b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 00:52:37.7386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vduM8oJ3pVKmSrBzMVhrxPtDypYVae6Y4hCI0XKwfkRwxWFLpI4G4Ih7ac+ZcmP7yb3wLJ9k+tmbUEoUXCfnLoFzBhlJJjhhUvzKz9AgVKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7869
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gSmFuIDEzLCAyMDIyIC8gMTQ6NTMsIE5pa29sYXkgQm9yaXNvdiB3cm90ZToNCj4gDQo+IA0K
PiBPbiAxMy4wMS4yMiDQsy4gMTI6NDAsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiA+
IFF1b3RhIGRpc2FibGUgaW9jdGwgc3RhcnRzIGEgdHJhbnNhY3Rpb24gYmVmb3JlIHdhaXRpbmcg
Zm9yIHRoZSBxZ3JvdXANCj4gPiByZXNjYW4gd29ya2VyIGNvbXBsZXRlcy4gSG93ZXZlciwgdGhp
cyB3YWl0IGNhbiBiZSBpbmZpbml0ZSBhbmQgcmVzdWx0cw0KPiA+IGluIGRlYWRsb2NrIGJlY2F1
c2Ugb2YgY2lyY3VsYXIgZGVwZW5kZW5jeSBhbW9uZyB0aGUgcXVvdGEgZGlzYWJsZQ0KPiA+IGlv
Y3RsLCB0aGUgcWdyb3VwIHJlc2NhbiB3b3JrZXIgYW5kIHRoZSBvdGhlciB0YXNrIHdpdGggdHJh
bnNhY3Rpb24gc3VjaA0KPiA+IGFzIGJsb2NrIGdyb3VwIHJlbG9jYXRpb24gdGFzay4NCj4gDQo+
IDxzbmlwPg0KPiANCj4gPiBTdWdnZXN0ZWQtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3Rh
QHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5p
Y2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvYnRyZnMvY3RyZWUuaCAg
fCAgMiArKw0KPiA+ICBmcy9idHJmcy9xZ3JvdXAuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0t
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvY3RyZWUuaCBiL2ZzL2J0cmZzL2N0cmVl
LmgNCj4gPiBpbmRleCBiNGE5YjFjNThkMjIuLmZlMjc1Njk3ZTNlYiAxMDA2NDQNCj4gPiAtLS0g
YS9mcy9idHJmcy9jdHJlZS5oDQo+ID4gKysrIGIvZnMvYnRyZnMvY3RyZWUuaA0KPiA+IEBAIC0x
NDUsNiArMTQ1LDggQEAgZW51bSB7DQo+ID4gIAlCVFJGU19GU19TVEFURV9EVU1NWV9GU19JTkZP
LA0KPiA+ICANCj4gPiAgCUJUUkZTX0ZTX1NUQVRFX05PX0NTVU1TLA0KPiA+ICsJLyogUXVvdGEg
aXMgaW4gZGlzYWJsaW5nIHByb2Nlc3MgKi8NCj4gPiArCUJUUkZTX0ZTX1NUQVRFX1FVT1RBX0RJ
U0FCTElORywNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICNkZWZpbmUgQlRSRlNfQkFDS1JFRl9SRVZf
TUFYCQkyNTYNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvcWdyb3VwLmMgYi9mcy9idHJmcy9x
Z3JvdXAuYw0KPiA+IGluZGV4IDg5MjgyNzU4MjNhMS4uNmY5NGRhNDg5NmJjIDEwMDY0NA0KPiA+
IC0tLSBhL2ZzL2J0cmZzL3Fncm91cC5jDQo+ID4gKysrIGIvZnMvYnRyZnMvcWdyb3VwLmMNCj4g
PiBAQCAtMTE4OCw2ICsxMTg4LDE3IEBAIGludCBidHJmc19xdW90YV9kaXNhYmxlKHN0cnVjdCBi
dHJmc19mc19pbmZvICpmc19pbmZvKQ0KPiA+ICAJbXV0ZXhfbG9jaygmZnNfaW5mby0+cWdyb3Vw
X2lvY3RsX2xvY2spOw0KPiA+ICAJaWYgKCFmc19pbmZvLT5xdW90YV9yb290KQ0KPiA+ICAJCWdv
dG8gb3V0Ow0KPiA+ICsJLyoNCj4gPiArCSAqIFJlcXVlc3QgcWdyb3VwIHJlc2NhbiB3b3JrZXIg
dG8gY29tcGxldGUgYW5kIHdhaXQgZm9yIGl0LiBUaGlzIHdhaXQNCj4gPiArCSAqIG11c3QgYmUg
ZG9uZSBiZWZvcmUgdHJhbnNhY3Rpb24gc3RhcnQgZm9yIHF1b3RhIGRpc2FibGUgc2luY2UgaXQg
bWF5DQo+ID4gKwkgKiBkZWFkbG9jayB3aXRoIHRyYW5zYWN0aW9uIGJ5IHRoZSBxZ3JvdXAgcmVz
Y2FuIHdvcmtlci4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKHRlc3RfYW5kX3NldF9iaXQoQlRSRlNf
RlNfU1RBVEVfUVVPVEFfRElTQUJMSU5HLA0KPiA+ICsJCQkgICAgICZmc19pbmZvLT5mc19zdGF0
ZSkpIHsNCj4gPiArCQlyZXQgPSAtRUJVU1k7DQo+ID4gKwkJZ290byBidXN5Ow0KPiA+ICsJfQ0K
PiA+ICsJYnRyZnNfcWdyb3VwX3dhaXRfZm9yX2NvbXBsZXRpb24oZnNfaW5mbywgZmFsc2UpOw0K
PiANCj4gQWN0dWFsbHkgeW91IGRvbid0IG5lZWQgdG8gaW50cm9kdWNlIGEgc2VwYXJhdGUgZmxh
ZyB0byBoYXZlIHRoaXMgbG9naWMsDQo+IHNpbXBseSBjbGVhciBRVU9UQV9FTkFCTEVELCBkbyB0
aGUgd2FpdCwgc3RhcnQgdGhlIHRyYW5zYWN0aW9uIC0gaW4gY2FzZQ0KPiBvZiBmYWlsdXJlIGku
ZSBub3QgYWJsZSB0byBnZXQgYSB0cmFucyBoYW5kbGUganVzdCBzZXQgUVVPVEFfRU5BQkxFRA0K
PiBhZ2Fpbi4gU3RpbGwsIG1vdmluZyBRVU9UQV9FTkFCTEVEIGNoZWNrIGluIHJlc2Nhbl9zaG91
bGRfc3RvcCB3b3VsZCBiZQ0KPiB1c2VmdWwgYXMgd2VsbC4NCg0KTmlrb2xheSwgdGhhbmsgeW91
IGZvciB0aGUgY29tbWVudC4NCg0KVGhlIHJlYXNvbiB0byBpbnRyb2R1Y2UgdGhlIG5ldyBmbGFn
IGlzIHRoYXQgcWdyb3VwX2lvY3RsX2xvY2ssIHdoaWNoIGd1YXJkcw0KUVVPVEFfRU5BQkxFRCBz
ZXQgYnkgcXVvdGEgZW5hYmxlIGlvY3RsLCBpcyB1bmxvY2tlZCBkdXJpbmcgdGhlIHF1b3RhIGRp
c2FibGUNCmlvY3RsIHByb2Nlc3MgdG8gc3RhcnQgdGhlIHRyYW5zYWN0aW9uLiBRdW90ZSBmcm9t
IGJ0cmZzX3F1b3RhX2Rpc2FibGUoKToNCg0KCS4uLg0KCW11dGV4X3VubG9jaygmZnNfaW5mby0+
cWdyb3VwX2lvY3RsX2xvY2spOw0KDQoJLyoNCgkgKiAxIEZvciB0aGUgcm9vdCBpdGVtDQoJICoN
CgkgKiBXZSBzaG91bGQgYWxzbyByZXNlcnZlIGVub3VnaCBpdGVtcyBmb3IgdGhlIHF1b3RhIHRy
ZWUgZGVsZXRpb24gaW4NCgkgKiBidHJmc19jbGVhbl9xdW90YV90cmVlIGJ1dCB0aGlzIGlzIG5v
dCBkb25lLg0KCSAqDQoJICogQWxzbywgd2UgbXVzdCBhbHdheXMgc3RhcnQgYSB0cmFuc2FjdGlv
biB3aXRob3V0IGhvbGRpbmcgdGhlIG11dGV4DQoJICogcWdyb3VwX2lvY3RsX2xvY2ssIHNlZSBi
dHJmc19xdW90YV9lbmFibGUoKS4NCgkgKi8NCgl0cmFucyA9IGJ0cmZzX3N0YXJ0X3RyYW5zYWN0
aW9uKGZzX2luZm8tPnRyZWVfcm9vdCwgMSk7DQoNCgltdXRleF9sb2NrKCZmc19pbmZvLT5xZ3Jv
dXBfaW9jdGxfbG9jayk7DQoJLi4uDQoNClRoZW4gZXZlbiBpZiB3ZSB3b3VsZCBjbGVhciBRVU9U
QV9FTkFCTEVEIGFuZCB3YWl0IGZvciBxZ3JvdXAgd29ya2VyIGNvbXBsZXRpb24NCmJlZm9yZSB0
aGUgdHJhbnNhY3Rpb24gc3RhcnQsIFFVT1RBX0VOQUJMRUQgY2FuIGJlIHNldCBhZ2FpbiBieSBx
dW90YSBlbmFibGUNCmlvY3RsIGFuZCBhbm90aGVyIHFncm91cCB3b3JrZXIgY2FuIHN0YXJ0IGF0
IHRoZSBwb2ludCBvZiB0aGUgdHJhbnNhY3Rpb24gc3RhcnQuDQpFdmVuIHRob3VnaCB0aGlzIHNj
ZW5hcmlvIGlzIHZlcnkgcmFyZSBhbmQgdW5saWtlbHksIGl0IGNhbiBoYXBwZW4uIFNvIElNTywg
d2UNCmNhbiBub3QgcmVseSBvbiBRVU9UQV9FTkFCTEVEIHRvIHdhaXQgZm9yIHFncm91cCB3b3Jr
ZXIgY29tcGxldGlvbi4NCg0KPiANCj4gPiAgCW11dGV4X3VubG9jaygmZnNfaW5mby0+cWdyb3Vw
X2lvY3RsX2xvY2spOw0KPiA+ICANCj4gPiAgCS8qDQo+ID4gQEAgLTEyMTIsNyArMTIyMyw2IEBA
IGludCBidHJmc19xdW90YV9kaXNhYmxlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQ0K
PiA+ICAJCWdvdG8gb3V0Ow0KPiA+ICANCj4gPiAgCWNsZWFyX2JpdChCVFJGU19GU19RVU9UQV9F
TkFCTEVELCAmZnNfaW5mby0+ZmxhZ3MpOw0KPiA+IC0JYnRyZnNfcWdyb3VwX3dhaXRfZm9yX2Nv
bXBsZXRpb24oZnNfaW5mbywgZmFsc2UpOw0KPiA+ICAJc3Bpbl9sb2NrKCZmc19pbmZvLT5xZ3Jv
dXBfbG9jayk7DQo+ID4gIAlxdW90YV9yb290ID0gZnNfaW5mby0+cXVvdGFfcm9vdDsNCj4gPiAg
CWZzX2luZm8tPnF1b3RhX3Jvb3QgPSBOVUxMOw0KPiA+IEBAIC0xMjQ0LDYgKzEyNTQsOCBAQCBp
bnQgYnRyZnNfcXVvdGFfZGlzYWJsZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4g
PiAgCWJ0cmZzX3B1dF9yb290KHF1b3RhX3Jvb3QpOw0KPiA+ICANCj4gPiAgb3V0Og0KPiA+ICsJ
Y2xlYXJfYml0KEJUUkZTX0ZTX1NUQVRFX1FVT1RBX0RJU0FCTElORywgJmZzX2luZm8tPmZzX3N0
YXRlKTsNCj4gPiArYnVzeToNCj4gPiAgCW11dGV4X3VubG9jaygmZnNfaW5mby0+cWdyb3VwX2lv
Y3RsX2xvY2spOw0KPiA+ICAJaWYgKHJldCAmJiB0cmFucykNCj4gPiAgCQlidHJmc19lbmRfdHJh
bnNhY3Rpb24odHJhbnMpOw0KPiA+IEBAIC0zMjc3LDcgKzMyODksOCBAQCBzdGF0aWMgdm9pZCBi
dHJmc19xZ3JvdXBfcmVzY2FuX3dvcmtlcihzdHJ1Y3QgYnRyZnNfd29yayAqd29yaykNCj4gPiAg
CQkJZXJyID0gUFRSX0VSUih0cmFucyk7DQo+ID4gIAkJCWJyZWFrOw0KPiA+ICAJCX0NCj4gPiAt
CQlpZiAoIXRlc3RfYml0KEJUUkZTX0ZTX1FVT1RBX0VOQUJMRUQsICZmc19pbmZvLT5mbGFncykp
IHsNCj4gPiArCQlpZiAodGVzdF9iaXQoQlRSRlNfRlNfU1RBVEVfUVVPVEFfRElTQUJMSU5HLA0K
PiA+ICsJCQkgICAgICZmc19pbmZvLT5mc19zdGF0ZSkpIHsNCj4gPiAgCQkJZXJyID0gLUVJTlRS
Ow0KPiA+ICAJCX0gZWxzZSB7DQo+ID4gIAkJCWVyciA9IHFncm91cF9yZXNjYW5fbGVhZih0cmFu
cywgcGF0aCk7DQo+ID4gQEAgLTMzNzgsNiArMzM5MSw5IEBAIHFncm91cF9yZXNjYW5faW5pdChz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgdTY0IHByb2dyZXNzX29iamVjdGlkLA0KPiA+
ICAJCQlidHJmc193YXJuKGZzX2luZm8sDQo+ID4gIAkJCQkgICAicWdyb3VwIHJlc2NhbiBpcyBh
bHJlYWR5IGluIHByb2dyZXNzIik7DQo+ID4gIAkJCXJldCA9IC1FSU5QUk9HUkVTUzsNCj4gPiAr
CQl9IGVsc2UgaWYgKHRlc3RfYml0KEJUUkZTX0ZTX1NUQVRFX1FVT1RBX0RJU0FCTElORywNCj4g
PiArCQkJCSAgICAmZnNfaW5mby0+ZnNfc3RhdGUpKSB7DQo+ID4gKwkJCXJldCA9IC1FQlVTWTsN
Cj4gPiAgCQl9IGVsc2UgaWYgKCEoZnNfaW5mby0+cWdyb3VwX2ZsYWdzICYNCj4gPiAgCQkJICAg
ICBCVFJGU19RR1JPVVBfU1RBVFVTX0ZMQUdfT04pKSB7DQo+ID4gIAkJCWJ0cmZzX3dhcm4oZnNf
aW5mbywNCj4gPiANCg0KLS0gDQpCZXN0IFJlZ2FyZHMsDQpTaGluJ2ljaGlybyBLYXdhc2FraQ==
