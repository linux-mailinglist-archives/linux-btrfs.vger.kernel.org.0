Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E03332C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 02:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCJBcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 20:32:19 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:35928 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhCJBcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 20:32:13 -0500
IronPort-SDR: uGmgEVTvCk9IdXr3oi6JHwfkSmMWiaRolmpMDc8EWib5wIQZcexxZzrSDey+HaHexW8B0akCSE
 rRmQucCiLvM0mJXA8xPWA2aji61rtJ/IdTINwpgmgoWcfrjIOPuj1lL/3ufmFXuVI1T/DAvo0V
 FOzBvAUhwUacdEHM+O7Y8l/TeMasTxFJnfLZNiy5VXn0qsFQLz/gP8v3vfu58NfnXvRBDsDazq
 DJIV/7CAdlGPKdNDqd/oUh058x0tj3iYGNXE5VjKSy1US1zj0MN51kPHKKsRRg6E0r38z9wMAn
 mVw=
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="27600804"
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="27600804"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 10:32:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVM8yxalTTCFrYm73gZmIK1QpxyBs65d3ufF/kQfg6p3J3DmPnECYKvB6ZChlZQmjMz1IT+sbn6dNYX1oE92znfsioxuRCwxElQqFgvhLpI+gt0XzYR0dwIIPn7PHOsmWFu+F9UdatYOrTgtmRtFpYzOhKGbem/ZDRLFVPA1WfaF28WJaoQjUT4f+E2qyw31a7qrxbXQvmjn9BWpqJhGN4KhZR/arNk7/ZsLbOW8D3EhqaIiEyGx0lWCPJNkEdErtunwoWEqZv6RMJJPDrlWVwz1E0v2Oct+eKE2R7CfKbZd6OGoJR2T5tkQxX88U7aOhPm4WJT8W261fj7pZixjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O6l3Y7WFSImo1hs70TFqZGvPYCOTe2plLbqDWwqpuY=;
 b=CSNwG0uYupbLz7Qc44VbWUwglFMqHi+p2bmTeU0dSw+6PAiUOY+PLKmoqObewn8DjzvIG4JCS6udaJ4Rn65ZzBxOWmQdBvy8qHRM4fVxs1qje94bkWwS0nfOsrYiqlEeTTsCVx2frsdtX+rA7qUV7bK74LYlzhLUNMvHHq/5k7uxhCKnCRrk8rovsi9suwccGped2v5BfvUhsyne2XRr8WJuRPSB2iLHQZckQW4mt5eWySQpPPaER2TFk7+Rn1MRqxLsHnnjw313B89otb02MUQTlqe1VORR64kS6tXufL4o+HrZwQNsJVmBoW75iu/80Pgo4KqhmnaWkM96uubZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O6l3Y7WFSImo1hs70TFqZGvPYCOTe2plLbqDWwqpuY=;
 b=iVJnFPTUNEII3y8yNtqxTK/i2f2jTdQtdSVPeR0meiayaYvJSTF7ADp14aDisElOPBHvi0JrENdlDvg+Qu/56h/CO+JiHEF4SuEf8wHh+3nGvdD+DPf8dGs5b4ZvTX1P/DYsis3Jr/yxaRY2XShFDIgZbjk6jP5uKUbw6XzIYC0=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB4961.jpnprd01.prod.outlook.com (2603:1096:604:61::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 10 Mar
 2021 01:32:06 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 01:32:06 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Topic: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Index: AQHXC9VDEDtEjiYaB0es2cWhy94QfKp7RVSAgAE8CpA=
Date:   Wed, 10 Mar 2021 01:32:06 +0000
Message-ID: <OSBPR01MB2920DF9A7F459A9ED441A238F4919@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>,<5e7766f9-0224-10be-6810-2e516e610191@linux.alibaba.com>
In-Reply-To: <5e7766f9-0224-10be-6810-2e516e610191@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [49.74.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 506e2e6d-d4d7-435a-4d6d-08d8e36450e7
x-ms-traffictypediagnostic: OSAPR01MB4961:
x-microsoft-antispam-prvs: <OSAPR01MB4961837B001471F56163CCECF4919@OSAPR01MB4961.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46B4Ac2iufM4QJcftnB4uRVWivDHxQHA9/LUcf9p4wJNGdBNnDcYLtvf8DXQYBsrCLrC3oEdaCCvRmnLzslHiZElsatVQ0Df5+TVq7egOe2gfCcmN5Xbm+IMDtpwEeccEAxW1PxCwEzDzTKDSttkEz7qXViOmWkDRs5OBdyKIMELXcKykBo7wGjPjmjKTSPZnIMQscD5i9v5ypSfvuRFJiimZE7MFp/3Lz2bIy/Od4YWtwJmPeRKpAu7NiGqUNrClt34XpxvR8UHWuXy00cFoqJg3OrpFjYzSTzibiprBvrHZKo+9X2zIYHjYmjmhzq5UtSBFz9j1w0V2O7cAX2Cnmbiu0bGev97UqGmlbPTCUA8IqtPxRNMfYZ/v8o9hLK7pTlCyvrV351Yq3lUj7CA3JilaHpZJsPbwKmW/Qeal0QAT6Rq+hQXXvsoLvdWvfkkR+OEjcIMz1hZTyVZI7djJrBr7gYt7Ku3jK8E+f6Ywel/dsdhEsEz54wD2hR7XFDyJpBD49zGPS6AHRx0RPYx4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(66946007)(478600001)(66476007)(52536014)(6916009)(4744005)(6506007)(71200400001)(316002)(54906003)(76116006)(33656002)(8676002)(7696005)(5660300002)(8936002)(9686003)(26005)(186003)(55016002)(86362001)(64756008)(66556008)(66446008)(7416002)(4326008)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?UitLYzhodXI0UjNydWNmRy91Rk01UGM0QU1XNFE1OERDNXV6UXJoK2JDTGRB?=
 =?gb2312?B?U1NteUZOWkFITU9zR3R3UE5GTys4dWhXblNOa2NQUWtCTW9tRUw0ZVRSL1Y5?=
 =?gb2312?B?eldLc1RmRUt4NTkxVUFpM010a1dKQml5N0Y1VkxQdzlCV1NsM3dqVHVibzRi?=
 =?gb2312?B?MUQzaHVybjFQMEZtNERXL0txeEJqMTZDNENLKzJLdmxxc2ptOFhMalcyZWM3?=
 =?gb2312?B?L1hJamFOQk9wWG14THZVUmJ2aU5MQ1JaZEU0RElYWFp6WU1VSEdkK0xXYXE1?=
 =?gb2312?B?c0tMV0RhcStoSU92R0FkbGl6S1U0Z0pUVnNkUlVYUmFDTGRNK3BQRnY0NS8y?=
 =?gb2312?B?TGlpVTdRa2gwZysvY0hPaTFkeWRJSzd4Z0YzanFzSlZjY2FxaVRDNUxnSVFF?=
 =?gb2312?B?THZCd2xWSGtMYW9uSVJTTnJHcUd5M0IxOEp0M1VhamtjREo5d2lNNkRyRUow?=
 =?gb2312?B?M1VpZmpBYTd2anJ4L29NamNCZm55WlRacFlGbjRtbS9HMWFYMnpRVjk3NHAw?=
 =?gb2312?B?M2FiZG1jTXJndzVvMW5zTUxPS25XaEp4anlkSkpscXh0aVpnN1dOOTJSSWt3?=
 =?gb2312?B?dGd1V2xjL2tkRWJUaENHMnVSZ2pUZkpZQTFkUlYzUEUzbTN1MXM0b2ZKazlL?=
 =?gb2312?B?L0hKRjAvc2NLSFdSYzc1UWVvYjFHTGRsdzg5ZGVnYS9SUjNIZktKcjlkQlhI?=
 =?gb2312?B?TlBaYWdaMUgxZ2lqK1RnSXBrL21mVHV5eC9xUUIvQ1V1dDlFUW9lb21oZmNJ?=
 =?gb2312?B?K0FvUXYyOFpBWElRM1BsdGVqZDV6TnozWUsvdloya1RGK1A5SWJiQmdESnlq?=
 =?gb2312?B?ZTd6NDhJNmVra1ZlaHNPNnkwdm5YbFRuRy85bmlNWnB6QjZ0SW04RE44SnI0?=
 =?gb2312?B?eEhPMzE4OHQwL2hicjZDUmNWUHVpdGcxRXB1REZSRit2VEFBOVFjRHJVZkNM?=
 =?gb2312?B?c3RydjlDVnRWWVY5cmsraGlDV3FuVTVXWWNHUWpUNDJ3M0NmbmlyV2c3VXEx?=
 =?gb2312?B?MkxOVDE3WDJ5cksza2dWb2M2NGNJUStaY2hLV25HTGtadU41eEZFVUtQSjhQ?=
 =?gb2312?B?SkR5eXFEY1lDbGZlcWhDNVJ2dU1QUUwvcHVRc3U3WFMrcTVkUm9SZnVDaTBB?=
 =?gb2312?B?NGN4dWV3UFpQdlRSMjhhTUNYd082eWZhQ0FvTjJoSjk5ZEt2SHpFeG90ejdE?=
 =?gb2312?B?MHlwelFlbkdlTWFzN1ZMVWoyeGRyZXRISndvQm5GMWJRUkZwWFhlZzlvREVa?=
 =?gb2312?B?VXFiMVVRdlRtSzhQSXI2N1ZoTjNrN1pSZk1icC9XcWxzOWpOZzdIa3RuQkVV?=
 =?gb2312?B?SG44eTdCYU0yWHM4aGZCa3Z2WjhReU5lRGJmME53RElhYTgycUVicmNhMi9u?=
 =?gb2312?B?UWpTYm44c3Y2VGpxWXVPZHZGM0dzNEVSMFU3SGozOXg1NlNQYVpFWlN1VGNS?=
 =?gb2312?B?MzNLNzRzRFJjRVBHbmRsT3JiaGlUQ3oxK09yc1h6aFBSNndEajFYcnFGTE5J?=
 =?gb2312?B?R2cxVXNzMkMwSWZrZDMwVE9RQU1zVTdMeXQxU0trU2JDR1VETkhuVVQwdlhS?=
 =?gb2312?B?MmtELy82RGpodkFlWGwzWXZIV0hzY2RNVitQVUtzdUpoc1NtTTJydFlhT0lX?=
 =?gb2312?B?a2xBTE1lZW1RcjJmZEdZem90TFFQYzVZQ1cyWGpCbzJLeWtoNnFMbHVTejkr?=
 =?gb2312?B?cklEd011bmVxcGFzdVNFU2trUEVtSjVBOGcyZTF2ZGdiREQvYS9mRnlvamZD?=
 =?gb2312?Q?XdElnuRvTfd7wPG7uo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506e2e6d-d4d7-435a-4d6d-08d8e36450e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 01:32:06.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqwk0KvHzdZ9fE70PNAjQQP1+aDCIzaAHP/+q040wzvO7k/++lBrHQDpWodJnfDFJ7bXhmnF9CawMZar9wAX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4961
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiBoaSwKPiAKPiBGaXJzdCB0aGFua3MgZm9yIHlvdXIgcGF0Y2hzZXQuCj4gSSdkIGxpa2UgdG8g
a25vdyB3aGV0aGVyIHlvdXIgcGF0Y2hzZXQgcGFzcyBmc3Rlc3RzPyBUaGFua3MuCgpJdCBoYXMg
YmVlbiB0ZXN0ZWQgYnkgeGZzdGVzdHMgd2l0aCBxdWljayBhbmQgY2xvbmUgZ3JvdXBzLiAgSSBk
aWQgbm90IHRlc3QgaXQgd2l0aCBvdGhlciBncm91cHMgeWV0LgoKCi0tClRoYW5rcywKUnVhbiBT
aGl5YW5nLgoKPiAKPiBSZWdhcmRzLAo+IFhpYW9ndWFuZyBXYW5nCj4gCj4gPiBUaGlzIHBhdGNo
c2V0IGlzIGF0dGVtcHQgdG8gYWRkIENvVyBzdXBwb3J0IGZvciBmc2RheCwgYW5kIHRha2UgWEZT
LAo+ID4gd2hpY2ggaGFzIGJvdGggcmVmbGluayBhbmQgZnNkYXggZmVhdHVyZSwgYXMgYW4gZXhh
bXBsZS4KPiA+Cj4gPiBDaGFuZ2VzIGZyb20gVjE6Cj4gPiAgIC0gRmFjdG9yIHNvbWUgaGVscGVy
IGZ1bmN0aW9ucyB0byBzaW1wbGlmeSBkYXggZmF1bHQgY29kZQo+ID4gICAtIEludHJvZHVjZSBp
b21hcF9hcHBseTIoKSBmb3IgZGF4X2RlZHVwZV9maWxlX3JhbmdlX2NvbXBhcmUoKQo+ID4gICAt
IEZpeCBtaXN0YWtlcyBhbmQgb3RoZXIgcHJvYmxlbXMKPiA+ICAgLSBSZWJhc2VkIG9uIHY1LjEx
Cj4gPg==
