Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C91C1C2745
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgEBRdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 13:33:43 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:32088 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgEBRdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 13:33:42 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 May 2020 13:33:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3272; q=dns/txt; s=iport;
  t=1588440821; x=1589650421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J3lX9i32Xn6UQ08GIrv60VxALj2l12Shmy9e/z50B7Y=;
  b=kIkimAL60Wrga9YEcsQ9EfrTZxX494yQJ6vngh1j4z38/x/Dazb3qVbz
   K0gbS+A96IFsVlslKR0CglqDoOGhjuf/0dSD1UOep0vY0tVupu1On0Sn0
   llkK4VCEvm/qYEnKeAbQhJV/EHrhv+AxSoQhQx1j4YkajMr/O3lXp56Hp
   M=;
IronPort-PHdr: =?us-ascii?q?9a23=3AoQnAXxcDmlom0fHzISib4E1blGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaSB9fQ7PZDkfDbtq3sWGEbp52GtSNKfJ9NUk?=
 =?us-ascii?q?oDjsMb10wlDdWeAEL2ZPjtc2QhHctEWVMkmhPzMUVcFMvkIVGHpHq04G0ZHR?=
 =?us-ascii?q?H4LxB4I+n5G4PJyc+w0rP695jaeQ4dgj27bPt7Jwm3qgOEsM4QjO4AYqY8wx?=
 =?us-ascii?q?fEuD1GYeNTkGhpPlmU2R3745S9?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BMAADHrK1e/5RdJa1mHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTMHAQELAYFTJC0FgUYvKoQig0YDhFiISiWYNYEugSQDVAs?=
 =?us-ascii?q?BAQEMAQEYFQIEAQGBUIJ0AheCGSQ0CQ4CAwEBCwEBBQEBAQIBBQRthVYMhXE?=
 =?us-ascii?q?BAQEBAgEBERERDAEBLwgBDwIBCA4KAgIfBwICAiYKFRACBA4FIoMEgkwDDiA?=
 =?us-ascii?q?BqCoCgTmIYXaBMoMAAQEFhTEYgg4JgQ4qAYJiiWEaggCBOAwQgh8uPodgM4I?=
 =?us-ascii?q?LIpFIoQUKgkaSDoV/FgeCW41ZjGeEcKg4AgQCBAUCDgEBBYFSOYFWcBVlAYI?=
 =?us-ascii?q?+UBgNkEIMBBMVgzqKVnQ2AgYBBwEBAwl8jicBAQ?=
X-IronPort-AV: E=Sophos;i="5.73,343,1583193600"; 
   d="scan'208";a="486055382"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 May 2020 17:26:33 +0000
Received: from XCH-RCD-001.cisco.com (xch-rcd-001.cisco.com [173.37.102.11])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 042HQWva004251
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 2 May 2020 17:26:33 GMT
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by XCH-RCD-001.cisco.com
 (173.37.102.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 2 May
 2020 12:26:32 -0500
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-rcd-003.cisco.com
 (173.37.227.248) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 2 May
 2020 12:26:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sat, 2 May 2020 12:26:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFF4oCPKPJH3Rbc68lD/6EUeZl/QeSR+5fmZKZmFziESpYmHH+1poCncEJUuKvZxg3jyz3h/9ByHliErIIKWSbZld10rDy+oV4KylXNupLC+6+mZ4LiD70UiXxgQLA/q/nc2+sl/dSYtwCFkfCMaWwM1/VV/ofLMGZ0VbB0on3gxOX9vr2NQKDhZGdjWn+R7kTvmUoO1IGhkVfOgy7l4sIGYPMq84+FlxEr1+Z+2oaDAOhpqwU2tbv8EbrdR9tg9CjQsEHbSxHBSuYsIt5QlftfgQdffErsupDIMKqZ4VqA/9XnPe1cEiaDPsw0Go/DZ1hs3pFrGyBMOdRsUknHAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3lX9i32Xn6UQ08GIrv60VxALj2l12Shmy9e/z50B7Y=;
 b=lxLGAjy20+sv6jhXgdSa8WNFI0tO7pqaI2G9A1Zip5d/wTLBJgFKdG0Hr2B4H3m3mrtF6A6dTpHvltXBCD1WY4QF2hbCEEI6SwRM+QKRSNeIQoDNPoUM8ECZZGjPHqVJlJU6HxzkbWwl7xclqWr7cYgrQBP3nFDrqtXE5WOtG7mBpkqIyNiMltmirbAbso092xGOVtc2X+ZJNmq1/nVlMblHRj9J3WugtII3/KFzEnFocMoU37GCKZ1ma+Cv9CtQXDf50+VPkfKH8aeYCaSxXu5TkJXcPVvOp0I8KFranqtpoq10uFxx47OHfFmRdw53HZEWHF8HpOQdaU9ykCYNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3lX9i32Xn6UQ08GIrv60VxALj2l12Shmy9e/z50B7Y=;
 b=lYOx2AcWRq3tdxWC9kAnHXSHa6ZuSq6uxGisnqL6JHKp5lQxd49yXVkbTdYPD4GLc8Bk9cGIJA8O59QIhCSLHoOk020nNeqGq0gOXDbT/K4Gw20VrwULC2PClgnwCao7zc+HYVTpjqk24r9pX8PkedzyZxy6Jo7VfkS5f5jFRoc=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (2603:10b6:a02:c7::20)
 by BYAPR11MB3158.namprd11.prod.outlook.com (2603:10b6:a03:1c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 17:26:29 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::cd4c:ef45:5701:d29d]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::cd4c:ef45:5701:d29d%3]) with mapi id 15.20.2958.027; Sat, 2 May 2020
 17:26:29 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     Chris Murphy <lists@colorremedies.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Can I create a new fileystem, using Read-only Seed device, to
 change the ownership of the files in the seed device.
Thread-Topic: Can I create a new fileystem, using Read-only Seed device, to
 change the ownership of the files in the seed device.
Thread-Index: AQHWHyEO38Nbh3MK7UKCU8L20P44B6iUmf+A
Date:   Sat, 2 May 2020 17:26:29 +0000
Message-ID: <E187A775-3645-4530-9A59-37FBDA9DF31C@cisco.com>
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
x-originating-ip: [2601:647:4900:b0:25a7:fc22:2151:1f72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2f01b6b-ed3d-4bf5-e9ad-08d7eebdf327
x-ms-traffictypediagnostic: BYAPR11MB3158:
x-microsoft-antispam-prvs: <BYAPR11MB315854223007162DE3CBC7F5BFA80@BYAPR11MB3158.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 039178EF4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2694.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(5660300002)(6486002)(6506007)(6916009)(6512007)(53546011)(316002)(71200400001)(8676002)(8936002)(2616005)(4326008)(2906002)(86362001)(76116006)(66446008)(478600001)(66556008)(66946007)(36756003)(33656002)(64756008)(66476007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AohxUXVhoVp4EWSoBCLkID+Qf9uqqWarIPAVpJs2gOoFlHs0/rlyMtQt3d8fNsvz+NYOxEjbaupVnCyRsnTjL9FqcD4IpXNRt93Y6eGlzFca8LXdLJUE8qN+OVmCgc7niI3vLM4zSOwCY/fbB9Ydbd/CrxKQKP8D/L9WpeRzBbom5x9Z0DRoEBdAy8CiTaYQIBmf7D3Yoi5JaIAdqqfMRoF9t8/5vdMjjwveKvQHPPWKbhx9SyB9GWPQh9jhXAdZ/PUNkUFECUbedsVy0Vkn2q8Xfsuh12tV72+7AAYxDA460j+AbQawRQ9SqNBwmoVwnjHiJhD8N3wPwn+E+thOQpsqiXO8IKTqWyk9zIvTr55PHHNcAFyR/NmkU69aeOWwn+4XKwaXt9sRRkze2tmOn3h4HKrqP9Qd81ZJRmyB8gXrc+4o1yO0ra+OfxU6GbKT
x-ms-exchange-antispam-messagedata: RjYWe2fUY6xyP+3W/Rw2RlrA5L7mPCT2x3h3Ur5WN0LEhDzns0ZMJiMu1rPRIofi8z8d+tNEXHN/JUa/wok0KMAFYaEmhppdVrORlZUOqykyYkdx0QNKdG3BkXJ/6FAzQLMHPgdlWlOAyOWFvi3pHnt7XriWMZnsmrYDx0w30vriDUCzbmWQ7EvfNETjQgCR1NSw8iQ84XmhDu5ep8D4iI7hoGrrud2pvtuyMwDF12cBTB+BuBcAqGUN0TSoJ3OpspOUn+m9EXV/QChqvoInIMdiDp8JhdNrnuLVEqg0MAi2oNisNUrfOqGnl7/lDGTkbabnB5ifLhCrTLfkFKuPw5QA+ZmL9KkndAjiKNLcmwhp7EZjgrSzyXsm3F8HWhlPG9REHl8YRkFGP/ZuKz4FhEsFXC2oySgREj2O/4NBZGeOLrh1F/YoULkGPih2vN01ubzmJgjUttNCJ3nCnQzxBuTyImr60LrBJQTGPgFQZEeqCoo7dKInrIHemRFue5RTc5PA6IvfDNvVZBCKMpmzWsdofzWnptFJgxNNkeO4avrvEuuhK/ngKPMEzlaEc6BMP4cjncfIz2VxSPROlAK1q5/bxwJaEjJMEx4YQUSPGay5IZqHoL1HIQJPxtcdBcalc9HfVVQi2zRo+DEqVOuoObnEM4bYYtjzjGDpI+4n/aghhnOfynu8DZzMEgLIfeHwW/I2nr1q71Mb0fWpVKm/+I+i/QCDkSwuow+qVyS9Lgie1UloCDlhT0EbiCEfQa+56L0IQcGC1TF5aoovjSiGoXaITFBNi5RhzN4y7fxRB/jdwRC7qdT4eYEROOOCWensid8LkEZHDs18HBTcuaN/Ny6bCpJkTvXiid5onOkv1Lk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF780241FD02E34195EA6BB29E18CF56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f01b6b-ed3d-4bf5-e9ad-08d7eebdf327
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 17:26:29.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgcwMcBSQUI0MtzKET2juOQ/b4N+szcPAGXOIN0I5EvifD7JZNhju9wFGkXJMzGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3158
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.11, xch-rcd-001.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SSBqdXN0IGZvdW5kIHRoYXQgdGhlcmUgaXMgc29tZXRoaW5nIGNhbGxlZCBzaGlmdGZzLCB0aGF0
IHdhcyBidWlsdCBmb3IgdGhlIExYRCBjb250YWluZXIgd29ybGQsIHdoZXJlIGEgdXNlcnNwYWNl
IGNvbnRhaW5lciBtYXkgd2FudCBiZSBzZWVkZWQgd2l0aCBhIHJvb3QgZmlsZXN5c3RlbS4NClRo
aXMgYWxsb3dzIHRoZSByb290IGZpaWxlIHN5c3RlbSB0byBiZSAibWFwcGVkIiB0byBhICJ1aWQ6
Z2lkIiBpbiB0aGUgY29udGFpbmVyIG5hbWVzcGFjZS4NCg0KQ29uc2lkZXJpbmcgQlRSRlMgd2l0
aCBpdHMgc25hcHNob3QvY2xvbmluZyBjYXBhYmlsaXR5IGlzIGEgcGVyZmVjdCBwYXJ0bmVyIGZv
ciBjb250YWluZXJpemF0aW9uLCANCkkgd291bGQgaGF2ZSB0aG91Z2h0IHRoaXMgc29ydCBvZiBz
aGlmdGluZy9jaGFuZ2luZyBvZiB1aWQvZ2lkIGluIHRoZSBjbG9uZSB2b2x1bWUgZmlsZXN5c3Rl
bSB3b3VsZCBiZSBhIGdvb2QgZmVhdHVyZSBmb3IgQlRSRlMgZm9yIHRoZSBjb250YWluZXIvbHhk
IHVzZSBjYXNlcyB3ZWxsLg0KDQogDQpUaGFua3MsDQpTYXJ2aQ0KT2NjYW3igJlzIFJhem9yIFJ1
bGVzDQoNCu+7v09uIDQvMzAvMjAsIDExOjU2IEFNLCAiQ2hyaXMgTXVycGh5IiA8bGlzdHNAY29s
b3JyZW1lZGllcy5jb20+IHdyb3RlOg0KDQogICAgT24gVGh1LCBBcHIgMzAsIDIwMjAgYXQgMTI6
NDQgUE0gU2FyYXZhbmFuIFNoYW5tdWdoYW0gKHNhcnZpKQ0KICAgIDxzYXJ2aUBjaXNjby5jb20+
IHdyb3RlOg0KICAgID4NCiAgICA+IEkgaGF2ZSBhIHByb2JsZW0gdGhhdCBuZWVkcyBzb2x2aW5n
IGFuZCBJIGFtIHRyeWluZyB0byB1bmRlcnN0YW5kIGlmIEJUUkZTIGNhbiBzb2x2ZSBpdC4NCiAg
ICA+DQogICAgPiBJIGhhdmUgZGlza2ltYWdlKGN1cnJlbnRseSB1c2luZyBleHQ0KS4gIEFuZCBJ
IGFtIGNvbnNpZGVyaW5nIGJ0cmZzIGZvciwNCiAgICA+IExldHMgY2FsbCB0aGlzIGZpbGVzeXN0
ZW1BDQogICAgPiBUaGlzIGNvbnRhaW5zIGEgc29mdHdhcmUgYnVpbGQgdHJlZSBkb25lIGJ5IHVz
ZXJBIGFuZCBoZW5jZSBhbGwgZmlsZXMgYXJlIG93bmVkIGJ5IHVzZXJBDQogICAgPg0KICAgID4g
SSB3YW50IGFuIGFsbW9zdCBpbnN0YW50YW5lb3VzIHdheSB0byBjcmVhdGUgb3IgY29weSBvciBj
bG9uZSBvciBzZWVkIGEgbmV3IGZpbGVzeXN0ZW0gb3IgZGlyZWN0b3J5IHRyZWUgZmlsZXN5c3Rl
bSBCLCB3aXRoIGFsbCB0aGUgY29udGVudCBpbiBmaWxlc3lzdGVtIEEgYnV0IGlzIG93bmVkIGJ5
IHVzZXJCDQogICAgPg0KICAgID4gUXVlc3Rpb246DQogICAgPiAxLiBpZiBJIGNyZWF0ZWQgZmls
ZVN5c3RlbUEgaW4gYnRyZnMgYW5kIHVzZWQgaXQgYXMgYSBzZWVkIGRldmljZSBpbiBjcmVhdGlu
ZyBmaWxlc3lzdGVtIEIsIFdoYXQgZmlsZSBvd25lcnNoaXAgZG9lcyB0aGUgZmlsZXN5c3RlbSBC
IGhhdmU/DQogICAgDQogICAgWW91IG1lYW4gdW5peCBvd25lciBhbmQgZ3JvdXA/IEl0IHdpbGwg
c3RpbGwgYmUgdXNlckEuIFRoZSBvbmx5IHRoaW5nDQogICAgdGhhdCBjaGFuZ2VzIHdoZW4gbWFr
aW5nIGEgc3Byb3V0IGZpbGUgc3lzdGVtIGlzIHRoZSB2b2x1bWUgYW5kIGRldmljZQ0KICAgIFVV
SURzLg0KICAgIA0KICAgID4gMi4gQ2FuIHRoYXQgYmUgY2hhbmdlZCB0byB1c2VyQiB3aXRoIGFu
eSBvcHRpb24uDQogICAgDQogICAgWWVzLCB5b3UgY2FuIHVzZSBjaG93bi4gVGhlIHNlZWQgaXMg
bm90IGNoYW5nZWQsIGp1c3QgdGhlIHNwcm91dCAodGhlDQogICAgcmVhZCB3cml0ZSBkZXZpY2Up
Lg0KICAgIA0KICAgIA0KICAgID4gMy4gV2hhdCBoYXBwZW5zIHdoZW4gdXNlckIgdHJpZXMgdG8g
bW9kaWZ5IGEgZmlsZVggb24gZmlsZXN5c3RlbUIgdGhhdCB3YXMgc2VlZGVkIHdpdGggZmlsZXN5
c3RlbUEgYW5kIGhhcyBmaWxlWCBvd25lZCBieSB1c2VyQQ0KICAgIA0KICAgIHVzZXJCIG5lZWRz
IHBlcm1pc3Npb24gdG8gbWFrZSB0aGUgY2hhbmdlLCB1bml4IG93bmVyIG9yIGdyb3VwIG9yIEFD
TCwNCiAgICBzYW1lIGFzIGFueSBmaWxlLg0KICAgIA0KICAgIA0KICAgID4gMy4gSSB1bmRlcnN0
YW5kIGJ0cmZzIHN1cHBvcnRzIHNuYXBzaG90cyBhbmQgY2xvbmVzLiBEb2VzIHRoZSBjbG9uZWQg
dm9sdW1lIGFuZCBhbGwgaXRzIGZpbGVzIGtlZXAgdGhlIG9yaWdpbmFsIG93bmVycyBhcyBpbiB0
aGUgb3JpZ2luYWwgdm9sdW1lL3NuYXBzaG90LCBvciBjYW4gaXQgYmUgc3BlY2lmaWVkIGFzIHBh
cnQgb2YgdGhlIGNsb25pbmcgcHJvY2Vzcy4NCiAgICANCiAgICBJdCdzIHVuY2hhbmdlZCwgeW91
IGNhbiBjaGFuZ2UgaXQgYmVmb3JlIG9yIGFmdGVyIHJlbW92aW5nIHRoZSBzZWVkIGRldmljZS4N
CiAgICANCiAgICANCiAgICANCiAgICAtLSANCiAgICBDaHJpcyBNdXJwaHkNCiAgICANCg0K
