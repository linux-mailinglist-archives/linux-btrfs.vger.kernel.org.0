Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D179A32C52B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442919AbhCDATi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:38 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:32234 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235177AbhCCKxO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 05:53:14 -0500
IronPort-SDR: yctzRGRJQxeNn+DOt4bhjZZJ0+fra1vaW1E+O/Pub1kiD+gWMqqlyiSEX1oVvCHjCijwLzinxr
 /Yil94nlHFbfAZ0tm3DJ0jKNPBtK811UGdas6dS0tnjb/hYSHKf7TU3HxMEeAmDDC377b3fx37
 dwSW41wZugp6sUPgVkJMBVzWb6VREn4XSXvEvFspbGyPhpeyEKmHYJFCJzW5BozTcgzzsyTGwW
 SlWVOpBThK6zd4VWgNqzm/uV5mQTQsZoq/G0d33Rd2AJs+eytwehm0KY6Po3nN1TdsVL/f3jom
 eY4=
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="35093408"
X-IronPort-AV: E=Sophos;i="5.81,219,1610377200"; 
   d="scan'208";a="35093408"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 18:46:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBnR37yhlox/AhrSVP+KXCMCUDIkzz+REOxtDT0EYHIBOlfNGkdwrSPcVaGhXF8JVIO/v/MKibPS0FKTWaxQSMCdqv3FZe/3aVfAIsd+eW2zTxUClf/ggEITO7AMVAHLpxt1eXw76+AQ29U7rnRHoIYxR3FveB40ImRbJl2K1gStFH9CbH9/EL7Sw/8X2ksS3veuXVbnOtoPK2/qRlrRG4w+W4DUNMAjh2NCvoVSPFE/VhIV4Zf4zpqNK4QvSPb+QjLBKjrGuIPr7ONCj5GpkMzYtwZWRygBmC1KV2y5GYN2Vk71T6KCQ7mjdaI/ZDmAiUElXEXOEXaAugw6JlgZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Ywr7Kr8al55wruB/Uo5VT4c/2G+65OYMagM8NovhE=;
 b=F2C8epHABhQpDHK7up1JWT+Rgg39xKG0oOreMj0t1BdjTIroSJUSXvk9aHFA3iTPncqlrA+o/U07sCeZmcIiu0bOypuerLofzLVSWPub/Xrctc4EEV2Q+Pl+nqqx+TWrOOTlcWpoa3+9ynC65qE6p5chhCNz46tvB1ap712PXzqCFS2vFflPjW3OD+bmcobnC8ZtdNe/OFmy/3ayDQ4JR7W13rFqV7lhyhEc4+QYhuUfHf0Ef+2aBxCYjd+luCjZpmUdsnLxmXweEOJT9UuUtwla9L4OdWuNxxEsH4hdf1aDz7zHjKTALnDr728XGQDKc7EJogBcf7nsJ3IZP+LABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Ywr7Kr8al55wruB/Uo5VT4c/2G+65OYMagM8NovhE=;
 b=b/85qJF1Y5VKoF+rCWKV8WZTKv7tivgRQ31KJeE4s8t+zVTzfblOmABv4hu2kVbm9AVusipcwSOxWwobE2gRLvnJ22wsKQQ8wt+IjGXvWVLMPQkiLbyOAXjpdIyUuF/WOYOkMH1mAnBQXbdUMDsoiLSz3Oh9JOK/phvYMi9twtA=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB6099.jpnprd01.prod.outlook.com (2603:1096:604:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 09:46:37 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 09:46:37 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "hch@lst.de" <hch@lst.de>, Joe Perches <joe@perches.com>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Topic: [PATCH v2 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Index: AQHXC9ViwxeQhGIw4Eetxx4lR6H52qpx9GcAgAAD9RmAABJQAIAAAN+o
Date:   Wed, 3 Mar 2021 09:46:37 +0000
Message-ID: <OSBPR01MB292019E204E147E125FC9FC2F4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920D986D605EE229E091601F4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>,<20210303093956.GA15389@lst.de>
In-Reply-To: <20210303093956.GA15389@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1deacfc1-9495-460e-b90a-08d8de293d53
x-ms-traffictypediagnostic: OS0PR01MB6099:
x-microsoft-antispam-prvs: <OS0PR01MB6099F59D2DD7AE01E9CEC9A4F4989@OS0PR01MB6099.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRyGqhmpyR6Ofe5s/EIGKYFcTakNMDBMC7t5qTKJZXUCVmcPlaD+tPhtGK7iqOwRY4dSZdRnsJCmlRBuV4IEldOsxFGnBgcZLLabwqlfd3OBZd0mVG/qMhG1jic15PZ47e2XQkUhNdXvkXrM0OImwb7nKKtS7iM8x4bTRNzys24yAHf+eiI/s4W85RZIq4c3CPqx/eMngHXuUQrd/lUxqR3o+J2w8NeH0eReK20kPOUHI2QpzzVkKejnHSCWe21rKyWa+U4JfxDjD5cApRSy2rz/R9UtAHQnJbWrSHJiXi/6hQqKodjTPnXWSaAh1ppvNfH+giAPNb1QFiqos21Gdr8PoiGg1+daIhRVdHy7e0sEptXqzO8qrDPmjTevuZ7XuSjbSd4+jvKzY3WWtie8JSa+8I67J4No1F/qFEW+iAF2bsYJQFUVd0mJ5NzihS+6aP78SrzNapyBgMTmGx5igmWPP6jZmZJaomZtPW7Yui80/KdGugwM9S+0NrjQRibzlXxoLXJiH76WZ2NNymiHBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(86362001)(66556008)(4326008)(7416002)(66446008)(83380400001)(7696005)(66946007)(91956017)(76116006)(33656002)(64756008)(66476007)(8936002)(55016002)(71200400001)(8676002)(26005)(2906002)(186003)(4744005)(9686003)(478600001)(5660300002)(85182001)(6506007)(52536014)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?TklTVXhmQk82RkcvSlNqK2ZmT0JHeG5ma1Fhbi9GcC96c3djUk9BK1FkaE4r?=
 =?gb2312?B?dlhpeWxjaFMzVG9jeElPbWdvdWgwd2daNlQ0eUgrWjZ1eDE0eDA4Ymx1Q2xl?=
 =?gb2312?B?STI1TXpJZmh5cCtNdENMVVpJRUkwQkxjNTVEeXFra3lHd1dPdHpUaHV3STlh?=
 =?gb2312?B?RTlkUHg1S1l1SGxaZlJvYTV2Mzg3L2FhelExS0pPamVnNko5OWh1OVp6dlFt?=
 =?gb2312?B?VnpTUlo3T1VDeC9EbU9zejM2dmhnNHFuaFNCVE1GdHFxOTVKNUFIMTNIcnBv?=
 =?gb2312?B?c0xpejhURFBobk1RK2ZJb1ViTDFENnZwWUVPMTE5bHVKQVRJMUl2ckNjSXdh?=
 =?gb2312?B?ZWJxMjdyVjd6MHRUMkZGNlBIV1NqUDBIZWhDUE5wRTdjVVArdS8rWVBBTEdo?=
 =?gb2312?B?WlBGVFd1T0ZSU1lybmZpWkNxem9vT1RrZFQyYllvQTRIYXRqRjJvc1dLVW5v?=
 =?gb2312?B?aFFINEpZQ1QrdlgvWXIxazY5MTR1bXpqcmtYZFUxUm9vR2NkQmRBOHQvb3Mv?=
 =?gb2312?B?YlFGUDFjK056YlZwdE45anUxbkQxYVo0RTNiY3d5TzBUR1g4TVV2cko5cVIv?=
 =?gb2312?B?MGk5ZkdOcVhONlorWW9EVVpiaDNmdFZtcHhFei8vakRSSVBtYzdrWmdCcFVC?=
 =?gb2312?B?QTlTZnBucno1ZnQwNUV0bk1wS2h3eVB2cGZuNU05MnhEb3VzaXBRQ21sMVY4?=
 =?gb2312?B?U3dBbFJSb05iaDdLZGx4ZVFkdHpaNnJTWkFUcmlyUFNQSmJ2d3JOK1RYVmpy?=
 =?gb2312?B?ZTlRNCt5VTMwRUhMbnZTZ2NUd0JFUC9wL0JTb0VwQ29BMGhEQTJ1Y1dhV1Q1?=
 =?gb2312?B?MFVxN3RQYVIwZHJobGI3ckVMQkdTYW1Ya2lpb2xyVEtpdUppZ0ZEQTBlM2Fl?=
 =?gb2312?B?S1ZGUTJiYVJ0WXQ4L0IwMWEvNUY1c2YyTUloUVozd0cyREhZRnBBMlFBcG1Y?=
 =?gb2312?B?bWJJKzRmejhIN3o2NVVNQjF1MGF3cnA5OG5BYmN2ZnBOamM5NTdSVzFoTith?=
 =?gb2312?B?YzVLcGxpenNYQWhXenpDYUlNUktNcDZSZFpuQkhNMXJ6U0l3RHQxWHliY0FV?=
 =?gb2312?B?TldJYjI2M21lSGlsSjh4QmhqbFhhV0l5cWtlbTZUaGJGQ3Y2YzlWZk5SQUto?=
 =?gb2312?B?OWJocFhaVUVKNkZacHZqdzFnWGxZTUdpZ1ZxMzBWRWRZcW1LQ2ZaOEE3T0xF?=
 =?gb2312?B?amtCVEMzemlUNWlTQlZqWThzUk5NOG5mODdYYXBoaHZaclpvQkhpNjNkSmwr?=
 =?gb2312?B?VHIxM1RLL2lRY2kyMjYrbEdETWd6VjNRNmdiYnBlbit1eUJGems2OTR0bmVt?=
 =?gb2312?B?TU44QWJXRlNEUHdmYWxPbDJGOE44a0Q4SHdtRksrMjBVSXB5TTUrOFdBWWtC?=
 =?gb2312?B?TmFITmM3L0JqQ0pyWHNkMjNPSHptSHBmbjVXZzhNRjJjVUlzVnUrMjdDM1F1?=
 =?gb2312?B?WUJwNzRma1Z1Z3FkU0txdTZwaWFiMEFoaWtmV2hieDV6VVYwQ0htNlJWMkdZ?=
 =?gb2312?B?bHUwWHR4ZXlkM0JuaEZOS2ZPbWFtK3N5Q25UdzkyWHNwc0FmVlkzRnc5QlVl?=
 =?gb2312?B?MlA4bHVLTXNHTG5Vd2JRZGpQdjNLNG10bUErNWRPa0k0ZnozQzV0QmFhM1I2?=
 =?gb2312?B?TnliYUhVZEhBM01UZEJ5LzJUcjRINWxnNDArc3J6Tm50Y1pJaERENFpHemc2?=
 =?gb2312?B?V21Xa3VGak10WUNkS2M4aFQzM0l2M0FuMzRVQzlONUVEeWtUWmJ5OGEvWnd1?=
 =?gb2312?Q?N5igAnQTE6kQKXmZLI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deacfc1-9495-460e-b90a-08d8de293d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 09:46:37.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5tc4gfzH9AAHKQs4E9Jjhco1qZ4IaBipZFbD2V0OgX99VAtQ6Es6gtw6A6Q+2NlnTSzOD2wJ2ZIBf9SJ5Vb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6099
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cj4gCj4gT24gV2VkLCBNYXIgMDMsIDIwMjEgYXQgMDg6NDU6MTRBTSArMDAwMCwgcnVhbnN5LmZu
c3RAZnVqaXRzdS5jb20gd3JvdGU6Cj4gPiBTb3JyeSBmb3IgbWFraW5nIHlvdSBjb25mdXNlZC4g
VGhpcyBpcyBiZWNhdXNlIEkgbWlzdW5kZXJzdG9vZCBob3cgSSBzaG91bGQKPiA+IHVzZSBpb21h
cF9hcHBseTIoKS4gSSBoYXZlIHJlLXNlbnQgdHdvIG5ldyBwYXRjaGVzIHRvIGZpeCB0aGlzKFBB
VENIIDA4LzEwKQo+ID4gYW5kIHRoZSBwcmV2aW91cyhQQVRDSCAwNy8xMCkgd2hpY2ggYXJlIGlu
LXJlcGx5LXRvIHRoZXNlIHR3byBwYXRjaCwgcGxlYXNlCj4gPiB0YWtlIGEgbG9vayBvbiB0aG9z
ZSB0d28uICBNYXliZSBJIHNob3VsZCByZXNlbmQgYWxsIG9mIHRoZSBwYXRjaHNldCBhcyBhCj4g
PiBuZXcgb25lLi4uCj4gCj4gSSBoYXZlbid0IGZvdW5kIGFueSByZXNlbnQgcGF0Y2ggaW4gbXkg
aW5ib3ggeWV0LCBidXQgdGhlbiBhZ2Fpbgo+IHZhcmlvdXMgbWFpbCBzZXJ2ZXJzIHNlZW0gdG8g
bWFsZnVuY3Rpb24gaW4gdGhlIGxhc3QgZGF5cy4uCj4gCgpTb3JyeSBhZ2FpbiBmb3IgdGhhdC4g
IExldCBtZSBpbmNyZWFzZSB0aGUgdmVyc2lvbiBudW1iZXIgYW5kIHJlc2VudCB0aGVtIGFnYWlu
LgoKCi0tClRoYW5rcywKUnVhbiBTaGl5YW5nLg==
