Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB421C1BB5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgEARcD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 13:32:03 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:45503 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEARcC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 13:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4212; q=dns/txt; s=iport;
  t=1588354320; x=1589563920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VYMvtf0CEu22uqFWOfQFDiCIXZc+AYW/NQfcJ0L/3Rw=;
  b=RajO2fkHCKgr+dV3OsTXJaHGoRucdl40dbd+GgTfnAE451opuZqFTsH2
   oOn5AvHeQeOu2xjxEjs2Dgtbnr25TU+uFlbJS+Tbm62ANT1GEqVRAsROi
   DZNY7DvSjz256rVKoDkJkgrbH6GtT6xVAVJc4v+y31cC1q8WC83aQOgu4
   Q=;
IronPort-PHdr: =?us-ascii?q?9a23=3AkrYpTB9g66cykP9uRHGN82YQeigqvan1NQcJ65?=
 =?us-ascii?q?0hzqhDabmn44+7ZxaN7vJpi0XTUIDW5/NJkKzdtKWzEWAD4JPUtncEfdQMUh?=
 =?us-ascii?q?IekswZkkQmB9LNEkz0KvPmLklYVMRPXVNo5Te3ZE5SHsutbFrWpWeo4DsfFh?=
 =?us-ascii?q?TyLkx+IeGmUoLXht68gua1/ZCbag5UhT27NLV1KhjTz03Ru8AajJEkJLw2z0?=
 =?us-ascii?q?7Co2BDfKJdwmY7KA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BKAAAao6te/4UNJK1mHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTMHAQELAYFTUQWBRi8qhCKDRgOEWIhtmDKBLoEkA1QLAQE?=
 =?us-ascii?q?BDAEBGBUCBAEBgVCCdAIXghkkNAkOAgMBAQsBAQUBAQECAQUEbYVWDIVxAQE?=
 =?us-ascii?q?BAQIBAREREQwBATcBDwIBCA4KAgIfBwICAiYKFRACBA4FIoMEgkwDDiABqGA?=
 =?us-ascii?q?CgTmIYXaBMoMAAQEFhU0Ygg4JgQ4qAYJiiV4aggCBOByCHy4+hE6DEjOCCyK?=
 =?us-ascii?q?RRaEDCoJGkgyFfh2CW41ZjGCEb6g2AgQCBAUCDgEBBYFSOYFWcBVlAYI+UBg?=
 =?us-ascii?q?NkEI4gzqKVnQ2AgYBBwEBAwl8jj8BAQ?=
X-IronPort-AV: E=Sophos;i="5.73,338,1583193600"; 
   d="scan'208";a="753164205"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 May 2020 17:31:59 +0000
Received: from XCH-RCD-005.cisco.com (xch-rcd-005.cisco.com [173.37.102.15])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 041HVxIN002081
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 1 May 2020 17:31:59 GMT
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by XCH-RCD-005.cisco.com
 (173.37.102.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 May
 2020 12:31:59 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-rtp-003.cisco.com
 (64.101.210.230) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 May
 2020 13:31:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 1 May 2020 12:31:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3uJD+KsAc6SaAdPiPDm+ixkdnHkipfsPmpVCwvZIjeNkW3iaV5nLbpZ91X4fcgpNll1E8JHbpjtSKeGMNoEhR376Vc7+M1+p4pRCa3TdBJK555or5/7bQu0Ue9+YK9Ucbnh/TT+J9cxcN8n3U0tYOnX58QGWS/wgvYviwlTJTrqkHEH4I3TxisX2vHcdGpUnMy9YETw4vTb5bwy0xhXkOBv4WqEVjjQEsR3b0BXtBa5vAJMiQIfdgfolY9HUmFgI8T54j76m6lu0ZBRHlMYs0CI+lyPwIbgDiw+RtwI9S0+uA1uYpsmPNu6gOwvYlio1SBQs8FUN5Wp28fPJLfl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYMvtf0CEu22uqFWOfQFDiCIXZc+AYW/NQfcJ0L/3Rw=;
 b=CfFqy51AHZeoYqLrKHw01mhh5Dz1BrGsO87iQV5u3WRF2TfY2T9JsR38+y7HxpZo6PWkHvwwx73R+9w+mRQLnYxNWK4+7ui57eXLVVZIKU8TFC8WN0axBuGodJEexfzpSqG5f7aAUnRnwRhslaPH6qwSMh8hIQS5mBK08gMy1wOBlof6eYwjuhvT3KdSGF6DzvA+wBUlk2zoQHiEAdKSxf9f1NgEEeolQfSX7J+ufR9o7UqH5QeAKg5zSZdAvDKpaHOb1At0hN/afplJIKnc3uo34gCjQQrT/xzJGssEV4TSF9qKyUZaX1S60EIDoBvt99O4A8eRgrh+53TALLanoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYMvtf0CEu22uqFWOfQFDiCIXZc+AYW/NQfcJ0L/3Rw=;
 b=aMofklgOWK1PUdhtIy66QgMP62AVD8K8cG4eBBVakgSoRDKckCsjePUU7suPUscuLMCVIWOcd3+txLIn/QfaLWFckOrTl0gLP2hp2NqI5CM/J5LTJyeLZ15UD/YCAlSTMk+XRRo6bc9ctkTs6FiHx3qJqqZ3HWvb1s27ddHKTM0=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (2603:10b6:a02:c7::20)
 by BYAPR11MB3191.namprd11.prod.outlook.com (2603:10b6:a03:79::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 17:31:56 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::459e:e317:d860:200d]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::459e:e317:d860:200d%4]) with mapi id 15.20.2937.028; Fri, 1 May 2020
 17:31:56 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     Chris Murphy <lists@colorremedies.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Can I create a new fileystem, using Read-only Seed device, to
 change the ownership of the files in the seed device.
Thread-Topic: Can I create a new fileystem, using Read-only Seed device, to
 change the ownership of the files in the seed device.
Thread-Index: AQHWHyEO38Nbh3MK7UKCU8L20P44B6iTCTOA
Date:   Fri, 1 May 2020 17:31:56 +0000
Message-ID: <4BC25537-83B2-45D3-89BB-BC560DDBE708@cisco.com>
References: <8B7A1A74-4AFC-4B85-AF99-5EEDBB3B94ED@cisco.com>
 <CAJCQCtRSt5pi=H5Ohy=zv-pu71Cbc9vWjnQeJSX80HDvkiaLhg@mail.gmail.com>
In-Reply-To: <CAJCQCtRSt5pi=H5Ohy=zv-pu71Cbc9vWjnQeJSX80HDvkiaLhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.35.20030802
authentication-results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none
 header.from=cisco.com;
x-originating-ip: [2601:647:4900:b0:e866:5b5f:d77d:4110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 187183dc-2e8c-4bf6-bd70-08d7edf58bbf
x-ms-traffictypediagnostic: BYAPR11MB3191:
x-microsoft-antispam-prvs: <BYAPR11MB319159045DB24C36CE70DE91BFAB0@BYAPR11MB3191.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKVMSsnXBieg0dY3/gYrL+2yb/5ail1AzLuEXfg/z8fmTMu/OJES7mhrKYCvudJb6PN4k9PDP7N2vBwgtB9QKt28yG7n3ArWPgHCYG/mW2fImRBAH6g6IJh8r+bG2ys1EF8HkoleuYz6VOcP6RjazMGjq+Zi/U8va177o3FZPE03DE+xxejuzTI/qkBMEvaLz/8v43bIsD3xPo0YiZMXbcFW7yAAGupjhAAc6NBLhct9zvM5FcIA/3kfMr/0CS+Rb36CHF0ISw/wh7Qqt1hkyXHI/jaitmNlvCUUjLXMIMJv/9VZSKWPQ8s77BrDsCw7Cp6QZxuFsCMXIwEunJAMjOiznjIOlYmpiAsrNHQObeYKot0LC6wVzXL12gyyi3RbbDHkLvn//1SZl6TRyCFSCP7HpsyHPvRcuzlA7PzCV/ul8nJZjfde+JEf1shwkz32
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2694.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(6512007)(316002)(2616005)(2906002)(478600001)(4326008)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(86362001)(36756003)(6486002)(186003)(53546011)(6506007)(71200400001)(33656002)(8936002)(8676002)(6916009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: O2R3FQfcufb892RX10wlXK0CqDLpL+dsm9a6EvAHsEsC4Zeg/ov455sqdYaLONmn8FE+GuSLH7pJr2M99mc2nOFCZnhrKhnvOZ/Y8gDN3zdDx2tnivD/upAPkLIu6zcZIfJRjSVYnBZikjdDdjdn8ViB0LR6mS7HZVpmxmrPuYnAMcmRTbu8SfqCoiJLe3nwYy54Cqf1MBhjGy73V+bwOSCmVFiJ5fbUVC1nsJUePwSdtJld4hJ03VCUhB6rgxUdoM8rnSFnc4Cgi/Bvq3Qac9EevuZPFaRayjS4vxTeYI4sj01evRTJ/zlOGeWFSIFQAxrkdZvC6CaMRygj0yOn+qu7uJB8JKlRFVt34eQHdO2DaGrYwt9EdUP/RrZIZibvMM+wlq1qVAhl01kA1LApKtYQ1hEp1X2p+pH44wVubBYdWuJxUX+BKkHmFK0uS43Og6RznfXBWB0RE5xB1XlDWLJibFFiB+8xO6G2qCDYoVrgxcZbkvAI6yH+ekXRCP+jID4/yegLa/Z5nos0OeZ4y2pOm3VLGkjl62vDgGJLzrAZrThLW7pz/0eXyF0LnoKbBCeX96lBJGYde6TP6WnqM5YAl5L+lDbi3QOlFQqR9tzGp1p3pYsF4VRi3gJe3JnSJjjn+y4RxZ7YCZE9De59PrX2hxyZKWNdKQRwMwx4fwTEsK2eAMSchhGkeOeEh79pghMImSjVZt3REKbTN6rcpI5gjoFMygHCTISoNdGCZfBI7FfPfwbz0EXYJvtcTZ5WueUTnNw3jgO2xyoGCJ7Jy0/HNnhtN1JoYI8T6Og44kNsjutucSns0TWwIFglkGab635eDGXeqFqAwVD+2p7Y+Q16we4urWyQUV0uBw8ZJrM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D9B122B6066704F8BE1709D57946D07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 187183dc-2e8c-4bf6-bd70-08d7edf58bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 17:31:56.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3ZljPqBRxp3Ilx1X6O80+36FtX32N9Mz0bNO01sFcd+n1oEz16NACrUWslXAVfM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3191
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.15, xch-rcd-005.cisco.com
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T25lIHVzZSBjYXNlIGZvciAiY2xvbmVkIiB3b3Jrc3BhY2VzIG9yICJzZWVkZWQiIHdvcmtzcGFj
ZXMsIGlzICJwcmVidWlsdCB3b3Jrc3BhY2VzIiBmb3IgdmVyeSBsYXJnZSBidWlsZHMuDQoNCldo
YXQgd291bGQgaXQgdGFrZSB0byBhZGQgdGhpcyBjYXBhYmlsaXR5IHRvIHRoZSBidHJmcyByb2Fk
bWFwPyBUaGlzIHdvdWxkIGJlIHZlcnkgdXNlZnVsbC4NCg0KT3VyIHVzZSBjYXNlIGlzIGFzIGZv
bGxvd2luZw0KICAgMS4gT3VyIGZ1bGx5IGJ1aWx0IHNvZnR3YXJlIGJ1aWxkIHdvcmtzcGFjZXMg
Y2FuIGJlIDgwMEdCKw0KICAgMi4gV2UgaGF2ZSBhIG5pZ2h0bHkgYnVpbGQgdGhhdCBidWlsZHMg
dGhlIHdob2xlIHdvcmtzcGFjZSA4MDBHQiwgZG9uZSBieSBhIGdlbmVyaWMgdXNlciAiYnVpbGR1
c3IiDQogICAzLiBXZSB0aGVuIHNuYXBzaG90IHRoYXQgd29ya3NwYWNlIHdpdGggYnRyZnMgc25h
cHNob3R0aW5nIGNhcGFiaWxpdHkuDQogICAzLiBXZSB3YW50IHRoZSBkZXZlbG9wZXIsICJzYXJ2
aSIsIHRvIGJlIGFibGUgdG8gY2xvbmUgZnJvbSB0aGF0IHNuYXBzaG90IGFuZCBiZSBhYmxlIHRv
IGluY3JlbWVudGFsIHNvZnR3YXJlIGJ1aWxkIGFuZCBkZXZlbG9wbWVudCBpbiB0aGUgY2xvbmVk
IHdvcmtzcGFjZSBvciB0aGUgc2VlZGVkIGZpbGVzeXN0ZW0vd29ya3NwYWNlLg0KDQpQcm9ibGVt
OiANCkFsbCB0aGUgY29udGVudCwgZmlsZXMsIGRpcmVjdG9yaWVzIGluIHRoZSBjbG9uZWQgd29y
a3NwYWNlIGFyZSBzdGlsbCBvd25lZCBieSAiYnVpbGR1c3IiIGFuZCBub3QgInNhcnZpIiwgd2hp
Y2ggY2F1c2VzIG15IGJ1aWxkcyB0byBmYWlsIHdpdGggcGVybWlzc2lvbiBwcm9ibGVtcy4NCklz
IHRoZXJlIGFueXRoaW5nIGluIGJ0cmZzIHRoYXQgY2FuIGhlbHAuIA0KRm9yIHRoYXQgbWF0dGVy
IGFueSBvZiB0aGUgb3BlbiBzb3VyY2UgZmlsZXN5c3RlbXMgc3VwcG9ydCBzZWVkaW5nIG9yIHNu
YXBzaG90L2Nsb25pbmcgdGhhdCB5b3UgbWlnaHQgYmUgYXdhcmUgb2YuDQoNClNvIGZhciB0aGUg
b25seSBmaWxlc3lzdGVtIHRoYXQgc2VlbXMgaGF2ZSB0aGUgY2FwYWJpbGl0eSBtYXAvY2hhbmdl
IHRoZSBmaWxlIG93bmVyc2hpcCBhcyBwYXJ0IG9mIHRoZSBjbG9uZSBvcGVyYXRpb24gaXMgTmV0
YXBwLiANCkFuZCB1bmZvcnR1bmF0ZWx5IHRoYXQgaXNu4oCZdCBvcGVuIHNvdXJjZSBhbmQgd29u
dCBzZXJ2ZSBvdXIgcHVycG9zZS4NCiANClRoYW5rcywNClNhcnZpDQpPY2NhbeKAmXMgUmF6b3Ig
UnVsZXMNCg0K77u/T24gNC8zMC8yMCwgMTE6NTYgQU0sICJDaHJpcyBNdXJwaHkiIDxsaXN0c0Bj
b2xvcnJlbWVkaWVzLmNvbT4gd3JvdGU6DQoNCiAgICBPbiBUaHUsIEFwciAzMCwgMjAyMCBhdCAx
Mjo0NCBQTSBTYXJhdmFuYW4gU2hhbm11Z2hhbSAoc2FydmkpDQogICAgPHNhcnZpQGNpc2NvLmNv
bT4gd3JvdGU6DQogICAgPg0KICAgID4gSSBoYXZlIGEgcHJvYmxlbSB0aGF0IG5lZWRzIHNvbHZp
bmcgYW5kIEkgYW0gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgaWYgQlRSRlMgY2FuIHNvbHZlIGl0Lg0K
ICAgID4NCiAgICA+IEkgaGF2ZSBkaXNraW1hZ2UoY3VycmVudGx5IHVzaW5nIGV4dDQpLiAgQW5k
IEkgYW0gY29uc2lkZXJpbmcgYnRyZnMgZm9yLA0KICAgID4gTGV0cyBjYWxsIHRoaXMgZmlsZXN5
c3RlbUENCiAgICA+IFRoaXMgY29udGFpbnMgYSBzb2Z0d2FyZSBidWlsZCB0cmVlIGRvbmUgYnkg
dXNlckEgYW5kIGhlbmNlIGFsbCBmaWxlcyBhcmUgb3duZWQgYnkgdXNlckENCiAgICA+DQogICAg
PiBJIHdhbnQgYW4gYWxtb3N0IGluc3RhbnRhbmVvdXMgd2F5IHRvIGNyZWF0ZSBvciBjb3B5IG9y
IGNsb25lIG9yIHNlZWQgYSBuZXcgZmlsZXN5c3RlbSBvciBkaXJlY3RvcnkgdHJlZSBmaWxlc3lz
dGVtIEIsIHdpdGggYWxsIHRoZSBjb250ZW50IGluIGZpbGVzeXN0ZW0gQSBidXQgaXMgb3duZWQg
YnkgdXNlckINCiAgICA+DQogICAgPiBRdWVzdGlvbjoNCiAgICA+IDEuIGlmIEkgY3JlYXRlZCBm
aWxlU3lzdGVtQSBpbiBidHJmcyBhbmQgdXNlZCBpdCBhcyBhIHNlZWQgZGV2aWNlIGluIGNyZWF0
aW5nIGZpbGVzeXN0ZW0gQiwgV2hhdCBmaWxlIG93bmVyc2hpcCBkb2VzIHRoZSBmaWxlc3lzdGVt
IEIgaGF2ZT8NCiAgICANCiAgICBZb3UgbWVhbiB1bml4IG93bmVyIGFuZCBncm91cD8gSXQgd2ls
bCBzdGlsbCBiZSB1c2VyQS4gVGhlIG9ubHkgdGhpbmcNCiAgICB0aGF0IGNoYW5nZXMgd2hlbiBt
YWtpbmcgYSBzcHJvdXQgZmlsZSBzeXN0ZW0gaXMgdGhlIHZvbHVtZSBhbmQgZGV2aWNlDQogICAg
VVVJRHMuDQogICAgDQogICAgPiAyLiBDYW4gdGhhdCBiZSBjaGFuZ2VkIHRvIHVzZXJCIHdpdGgg
YW55IG9wdGlvbi4NCiAgICANCiAgICBZZXMsIHlvdSBjYW4gdXNlIGNob3duLiBUaGUgc2VlZCBp
cyBub3QgY2hhbmdlZCwganVzdCB0aGUgc3Byb3V0ICh0aGUNCiAgICByZWFkIHdyaXRlIGRldmlj
ZSkuDQogICAgDQogICAgDQogICAgPiAzLiBXaGF0IGhhcHBlbnMgd2hlbiB1c2VyQiB0cmllcyB0
byBtb2RpZnkgYSBmaWxlWCBvbiBmaWxlc3lzdGVtQiB0aGF0IHdhcyBzZWVkZWQgd2l0aCBmaWxl
c3lzdGVtQSBhbmQgaGFzIGZpbGVYIG93bmVkIGJ5IHVzZXJBDQogICAgDQogICAgdXNlckIgbmVl
ZHMgcGVybWlzc2lvbiB0byBtYWtlIHRoZSBjaGFuZ2UsIHVuaXggb3duZXIgb3IgZ3JvdXAgb3Ig
QUNMLA0KICAgIHNhbWUgYXMgYW55IGZpbGUuDQogICAgDQogICAgDQogICAgPiAzLiBJIHVuZGVy
c3RhbmQgYnRyZnMgc3VwcG9ydHMgc25hcHNob3RzIGFuZCBjbG9uZXMuIERvZXMgdGhlIGNsb25l
ZCB2b2x1bWUgYW5kIGFsbCBpdHMgZmlsZXMga2VlcCB0aGUgb3JpZ2luYWwgb3duZXJzIGFzIGlu
IHRoZSBvcmlnaW5hbCB2b2x1bWUvc25hcHNob3QsIG9yIGNhbiBpdCBiZSBzcGVjaWZpZWQgYXMg
cGFydCBvZiB0aGUgY2xvbmluZyBwcm9jZXNzLg0KICAgIA0KICAgIEl0J3MgdW5jaGFuZ2VkLCB5
b3UgY2FuIGNoYW5nZSBpdCBiZWZvcmUgb3IgYWZ0ZXIgcmVtb3ZpbmcgdGhlIHNlZWQgZGV2aWNl
Lg0KICAgIA0KICAgIA0KICAgIA0KICAgIC0tIA0KICAgIENocmlzIE11cnBoeQ0KICAgIA0KDQo=
