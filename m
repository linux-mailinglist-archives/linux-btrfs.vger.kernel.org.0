Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942EC32C507
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377885AbhCDAS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:18:58 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:21441 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1843019AbhCCKYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:09 -0500
IronPort-SDR: 44OMffNQnyXP1gR8MhMwnRWqHWJ2zDeL02PVmTya0xCGBy1ilm1Z1Qld9s6Vf9ExPQjV91/l05
 RQcoFENYI48UKAE0ui6i9hVDnmuZ9TfKNeHGdjG1CwnxVYhh/tD2tMzV4TzE1YNWIGMVdUaQWj
 OzI8UtA9Jol85U7wxT+H1EAKKhqfS41neI4q1e0oLngZ5xK5XY5S5EVSFzF314qU5GdlehY/Iy
 JFqBfE79EgW/P8/qt5Hgyi5aRqhUxdtbZVEtuhckgibvRRk0zh2qd7MbY5SxtdKohpKKtFg6VX
 fGo=
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="27498756"
X-IronPort-AV: E=Sophos;i="5.81,219,1610377200"; 
   d="scan'208";a="27498756"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 17:45:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrD17N0fCoFw1DiKd41pb6c3BBNf3+/2zvYRD84lFhK76NGUo2Airfbb3CbH4XY3q2WAdF84lceXhuXpTHXPOqRXfS3ggbEtEISj58wejHJgH/OkpKDrnsKQ+HosXnLXn4ODkediaCbmpQc8AyFRjdzYa7L4Y2wTp5HqcFBE+p4cM8joyLIyRMPUEAr/4Jv1Z0i/gRgS/eWZhl+SvpqqBtIAoQQq8I8zb1weIqfT8vmkU8DXyZO9u/Nv2Q6fYY2JaS/Dd2HrBl/ZN/HxR178Qr44qtU4X/VEi+RM73pdXXkgDf4uR7PeAfiKNTtgCv9SspQZOrvMVWmpDLEj7Wd+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52k4wHevKWKquqJiQ+jcLO4k8mciicv+dMAw1ZUM0xw=;
 b=BObBbCUBAhuyGchZ5Igm3XcSE7czWleu76jGwhi+Oxf81GEApxWpJoRZMBqO37tcJ9sFvxHgKcWgAyOJXhKTEQXnqkrI9c/Qq8Lj5y3hX1Z7j3uO5znf3GqOUsoAqvTSMiv3T0CEdS2BOu2fzoMDSq4chj3LiZ+armKPbvAGr7UWkWPT4iHEPWbfa+qIemJRXJxZNeN0QkRl3ptBnFKAf16CmKuI5Se0is4wFuWZvMSh4lTYOIUuHiP9CSLttMExAeE0Q81HlIJ5ufoWd/mXY7rc3FsMDILuNPsOqRFHLVNNmCCSRwM2t0W4INW0WqHZ5FIlQ1f/IgCocYWcH6D8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52k4wHevKWKquqJiQ+jcLO4k8mciicv+dMAw1ZUM0xw=;
 b=LTFZiRf9dFZ1geQey+GeZwjPweclTlI38yxgqHvv+UHsQnSJFQnbys4Ga63jaX1vJBSE8cfsgoDUPKnKKHOlCvLGTnC5S3Iw6qcYb1pPFjd0teXQ591rIsToSYkWy3dMy7BMEfVNH/nwZE2jM7Swombh9jGV48uKlugKr9KTErc=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB5794.jpnprd01.prod.outlook.com (2603:1096:604:b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 08:45:14 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 08:45:14 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Joe Perches <joe@perches.com>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Topic: [PATCH v2 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Index: AQHXC9ViwxeQhGIw4Eetxx4lR6H52qpx9GcAgAAD9Rk=
Date:   Wed, 3 Mar 2021 08:45:14 +0000
Message-ID: <OSBPR01MB2920D986D605EE229E091601F4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
         <20210226002030.653855-9-ruansy.fnst@fujitsu.com>,<aed5d2b78c4ac121ca0cf46107334673a3c9a586.camel@perches.com>
In-Reply-To: <aed5d2b78c4ac121ca0cf46107334673a3c9a586.camel@perches.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12705e02-5bca-4ea4-04b4-08d8de20a9c3
x-ms-traffictypediagnostic: OS0PR01MB5794:
x-microsoft-antispam-prvs: <OS0PR01MB5794565BD85DE951DB21B55FF4989@OS0PR01MB5794.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N76uqLBuJ3NmA+j6Xu1frkrJGN2Dz+xnLu2uIMbJ+u1F65oFqVPvhCzpbRPZrXMNKTdSKTkZ2MAm88WmBLYa2IuQjt8DNCjJvXVoDedKpGlzczb0Gg45zzqYBIsdfMvEBjR744R8FAw4JcInKEwxSr3/XvpWonli2pDbZMkIFR5Z9i1lUuLaLtzXbK+z+y3lF6oucNCnHq/XjHDkgJhj3trYNwq6QYJkcye07gZgK/3RCDB8lUKEnHtkUg8OGVdF8Li5t2ZCG40KpIcS7NOPA2xLhOBtQfJOCydW3zpKuJHD2ervaAYbDleKWny4TnmyVUY6sEqipmKKHGLE1ngPLq8ElVQpxGVstYdY7hENITm44+ixX8MMts8e8lF433mQcAEZGeRQ22K0o+ydV1E49Oa9ZL32Jq+VPfTX8GUk3NnN+17uDBxXTK93/EP6KTy0G84Sgi/1dCIskB26+D8v+261cfcxUXAJdRZ/KLjalJGJcmdXvMQeWsaUsAwHfcpaPrIEkZ2x60nFdOzp1+0Dvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(91956017)(8936002)(33656002)(5660300002)(7696005)(4326008)(66446008)(6506007)(2906002)(66476007)(7416002)(86362001)(316002)(66946007)(26005)(64756008)(66556008)(85182001)(6916009)(71200400001)(186003)(8676002)(55016002)(9686003)(76116006)(52536014)(478600001)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mmhvT39BFeUQDVpU6mILhhhXw1LWcv9ho73ewGuiEkQgX3gWkyiHDpp4Qz78QSSU/a2LMxnhNTqQQmbW63Zn2jMuEPrCZ2nEspY2FcmD5pt5t7wA32SaiB1iw57y3iNL9jjShEBMBn29/CJ5W/7Zgk68Q2rUR5wt2SLKvCeTwAgj4j3+vYdLjKCOMfxV3BpXcw9Mca9iI/zi7DeJS1xVkr1YssXvTJ7dX02Mv/6jQvvqPLlczFJFVht1gYKWGAFNy0LosOwWXhO3f4k3kVaMKHAB6T+606Y2UOAVrcuZe6IFXhTyHyeCnIOW9+S6m4XQpxd7zr2Mx0AiTU+Q8+wJbSP/cmBxpwGBDstW1xvDH90rkETcbXR21K1c8RbvWldXrIPvwBvXT/5eH3GnOyDWVjhG2UCbJARfM4sdeR8UcfeDTvH5Ge9k5Why3N8/WgVpgXmTVkWehWjn0eYed2b7muW3HAOMZfPgMZdqrt7GHM5CXMP8hNV94WYktqY2MEuzLXcSfSUGsDEvhgZ0EK5nYHrD2mn5zIVMr0dDkEiZRLVuxUZhYInFpZLdgqpZPpNkhKktOjABp0lZ8VxzBaWm4WUICQAXIMyYvJS+y4XDfbZkusz4XlVawhertQ62XZlmj9BMHEo3ssPHIM7us/6alTaAqBQ5sdJTtAtECD0a3RhLDXHPWQB2DCW27OMPpyA9kv0JAHTAZrP3bNPV/E+qOg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12705e02-5bca-4ea4-04b4-08d8de20a9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 08:45:14.0525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFoMG4+bfpop5yVorYb75Pot2jRZezK526qxRVzgBms9/B8AMqSRnxyg60H6sVrGu9glLQg74QDGEjMAybTSWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5794
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAKPiBUaGlzIGNvZGUgbG9va3MgbmVlZGxlc3NseSBjb21wbGV4Lgo+IAo+IGxlbiBpcyBuZXZl
ciBkZWNyZW1lbnRlZCBpbnNpZGUgdGhlIHdoaWxlIGxvb3Agc28gdGhlIHdoaWxlIGxvb3AKPiBp
dHNlbGYgbG9va3MgdW5uZWNlc3NhcnkuICBJcyB0aGVyZSBzb21lIG1pc3NpbmcgZGVjcmVtZW50
IG9mIGxlbgo+IG9yIHNvbWUgb3RoZXIgcmVhc29uIHRvIHVzZSBhIHdoaWxlIGxvb3A/Cj4gCj4g
SXMgZGF4X2lvbWFwX2RpcmVjdF9hY2Nlc3Mgc29tZSB1Z2x5IG1hY3JvIHRoYXQgbW9kaWZpZXMg
YSBoaWRkZW4gbGVuPwo+IAo+IFdoeSBub3QgcmVtb3ZlIHRoZSB3aGlsZSBsb29wIGFuZCB1c2Ug
c3RyYWlnaHRmb3J3YXJkIGNvZGUgd2l0aG91dAo+IHVubmVjZXNzYXJ5IGluZGVudGF0YXRpb24/
Cj4gCj4gewo+ICAgICAgICAgdm9pZCAqc2FkZHI7Cj4gICAgICAgICB2b2lkICpkYWRkcjsKPiAg
ICAgICAgIGJvb2wgKnNhbWUgPSBkYXRhOwo+ICAgICAgICAgaW50IHJldDsKPiAKPiAgICAgICAg
IGlmICghbGVuIHx8Cj4gICAgICAgICAgICAgKHNtYXAtPnR5cGUgPT0gSU9NQVBfSE9MRSAmJiBk
bWFwLT50eXBlID09IElPTUFQX0hPTEUpKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPiAK
PiAgICAgICAgIGlmIChzbWFwLT50eXBlID09IElPTUFQX0hPTEUgfHwgZG1hcC0+dHlwZSA9PSBJ
T01BUF9IT0xFKSB7Cj4gICAgICAgICAgICAgICAgICpzYW1lID0gZmFsc2U7Cj4gICAgICAgICAg
ICAgICAgIHJldHVybiAwOwo+ICAgICAgICAgfQo+IAo+ICAgICAgICAgcmV0ID0gZGF4X2lvbWFw
X2RpcmVjdF9hY2Nlc3Moc21hcCwgcG9zMSwgQUxJR04ocG9zMSArIGxlbiwgUEFHRV9TSVpFKSwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzYWRkciwgTlVMTCk7Cj4g
ICAgICAgICBpZiAocmV0IDwgMCkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87Cj4gCj4g
ICAgICAgICByZXQgPSBkYXhfaW9tYXBfZGlyZWN0X2FjY2VzcyhkbWFwLCBwb3MyLCBBTElHTihw
b3MyICsgbGVuLCBQQUdFX1NJWkUpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmRhZGRyLCBOVUxMKTsKPiAgICAgICAgIGlmIChyZXQgPCAwKQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTzsKPiAKPiAgICAgICAgICpzYW1lID0gIW1lbWNtcChzYWRkciwgZGFk
ZHIsIGxlbik7Cj4gCj4gICAgICAgICByZXR1cm4gMDsKPiB9Cj4gCj4gSSBkaWRuJ3QgbG9vayBh
dCB0aGUgcmVzdC4KPiAKClNvcnJ5IGZvciBtYWtpbmcgeW91IGNvbmZ1c2VkLiBUaGlzIGlzIGJl
Y2F1c2UgSSBtaXN1bmRlcnN0b29kIGhvdyBJIHNob3VsZAp1c2UgaW9tYXBfYXBwbHkyKCkuIEkg
aGF2ZSByZS1zZW50IHR3byBuZXcgcGF0Y2hlcyB0byBmaXggdGhpcyhQQVRDSCAwOC8xMCkKYW5k
IHRoZSBwcmV2aW91cyhQQVRDSCAwNy8xMCkgd2hpY2ggYXJlIGluLXJlcGx5LXRvIHRoZXNlIHR3
byBwYXRjaCwgcGxlYXNlCnRha2UgYSBsb29rIG9uIHRob3NlIHR3by4gIE1heWJlIEkgc2hvdWxk
IHJlc2VuZCBhbGwgb2YgdGhlIHBhdGNoc2V0IGFzIGEKbmV3IG9uZS4uLgoKCi0tClRoYW5rcywK
UnVhbiBTaGl5YW5nLgo=
