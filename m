Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89C1C2386
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEBGXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 02:23:34 -0400
Received: from mail-eopbgr1360083.outbound.protection.outlook.com ([40.107.136.83]:39552
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgEBGXd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 02:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekQN/04ocMtlP4NMW9JTYWwErn/UjAlaXI8ceQie9ZE31CrUKuzfP9Gake3PeSBPMSQRHzNl643xvE3ZuH4rS+Yibjzz+8DxXlCvkXXTPGrBArmS31GeTLh/pd0iYXmRBypm2glJ13gqcajqOLnCJLQ/SQh/jYAF67fvh8BqjkaFqorQw8XqCuiB+aHw3LtZBfu1BI6NAUL+rUoJKqPMLAmlTqQYZcDcc8fCi+xbxBRh5BiNtAQGcVjJW5VdGfttT4ZoGd413fwdHI4SthGq5jUI2wNk1A1MHp4WRtZxWNgfY1Ush9VrvDId7azQ1LyCDf2B3hi1ZFWRAvSG/kj14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0k/5LR6KT5d3UWPqr0p3ed/R/3L+FoM72WiqmSXbdI=;
 b=SO6WRK2HFgT5yGTtYYkfLoX9VuY/J9G1GhSGOuVT09dwifCCEKYYDyh2bx0Uq8VvqsAn1xBnRcyVJaV9BM04xT8i3PKMri+gGCev3b+B46utzb8zym8Pwkb+iUOVLh/dM4Mzli3XOxjy6LipVOP7p6771yr8OXTYycHfO6aCmpyc7xn4hPyvDAVN0/6RG1Uxqo8uUNyyZlmmGDSYJj9jJixjgtC3rCqOyidj5YmknY18/831yDoPMAXzksjz7q0SK/mU1hvofRHdK+pioMyIJVka2t+NtVcQnNhwxo2XyViYp1D+Cv8uGDAKdp+o7lahYuO8h5UKtzKCeej6QXzwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0k/5LR6KT5d3UWPqr0p3ed/R/3L+FoM72WiqmSXbdI=;
 b=nazvH6/TbhlNh+vdIcjoosP3sI8JEUdIRafsWKoiY5O5eKO/k/HewK8C4tMEe7CAdsRFf7jj5I7sWmW6zz0r6mZ4HuVD5rU6LD6vgEyVGXu5bCqpdwo6eVpbZXUvMEM50tUuuX2qC0CsH6ylI9Cx2IWqDC7+tt62tS0c3W4kB64=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB3321.ausprd01.prod.outlook.com (20.177.139.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sat, 2 May 2020 06:23:28 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664%4]) with mapi id 15.20.2958.027; Sat, 2 May 2020
 06:23:28 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Extremely slow device removals
Thread-Topic: Extremely slow device removals
Thread-Index: AQHWHxU9fUjJyg1lIUuFsK5nfSW3n6iR9/GAgADoaACAAUbYgIAAEiCQgAAWhQCAAAWQMA==
Date:   Sat, 2 May 2020 06:23:28 +0000
Message-ID: <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org>
In-Reply-To: <20200502060038.GK10769@hungrycats.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umail.furryterror.org; dkim=none (message not signed)
 header.d=none;umail.furryterror.org; dmarc=none action=none
 header.from=pauljones.id.au;
x-originating-ip: [60.242.55.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 251ae08f-6746-4dd9-01e2-08d7ee61543c
x-ms-traffictypediagnostic: SYBPR01MB3321:
x-microsoft-antispam-prvs: <SYBPR01MB33217D770823B9B3071B109B9EA80@SYBPR01MB3321.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 039178EF4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB3897.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(366004)(39830400003)(8936002)(66446008)(76116006)(66476007)(4326008)(66946007)(66556008)(64756008)(5660300002)(71200400001)(316002)(3480700007)(52536014)(2906002)(8676002)(33656002)(4744005)(86362001)(7696005)(6916009)(186003)(53546011)(9686003)(26005)(6506007)(55016002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ew8OT4fswOVEFZB1FzxY/ugIdlYC0rWBhyWomhfe4hSGODsqXci/k2CMOzfa1jxvHORPHGuOn0CHy4Fo/rySZh2Q4nN43wsbX6ypayJ69oDiMjkV9FPmE4Cx88JhD1HSxPYGpoFNSDwBItNalCjd+vLoK0j8nyrUBbxVnC5uvbtH+WyEdVNo8GH8cNJnO6dZiX/EjEC14ouAn8eu+c1Cg5d5UqTU05qDlqp1HBnxgRUywTocZGNlLlbcLS8fhWWqUhCm4RGc4SgWIh5zvOjNE+5HjPbG6QHc4RHZN7/EMGNWJN4hO+obVvZ7giwFiCb15Z2yasP+iC5t2O4h4xRlw3WIGjVARkHS4CE7U78sERdYTiVbPT99dkgfLoTNBsmz2KHEAWZ0ZrrY/An5zEur4/dBP5SXXuoih3H8nhg42EJ4BN/4Ok74y2VJkF4AIBn4
x-ms-exchange-antispam-messagedata: WxiR+ag2zKEDZz8D8bRgqIT8N1c8DbfDgK64Za3k9lti3vk0OR5/GblMquyx5ojRrFqx44ZvbRy/HnzXSKh+28NAfo+Fy9lcSFbr/ncY6tOlCgBPjadqhn887C0GQ63+ItBUFqsGoaI5XcM+WfV9hwTT3TUkubXN3pFvI68tXjCsFALhc7ujnHNsIPPk28xTT7/23cpzqehnlMi4FEKOPjKxSchIJHyrwwvl6Zl6jNqSy/F8M0tPcSY7gmbGxpJvXB1rKOHg1+quNnlFdlyUAp7fzDoO6m5+5v6SGaYK72ox1hkF/K8oAr1VOkkVj6dBohzH6BH8tdFhrHSx0iDMyDEnmbUEVPEEFwaJIvD5vczKw49wy4c2DGjnnFPmripxYLS+1nlzBjKosPcEio8/bhS1tTpoPNpEJBHH16pPgV9YrAXes/yNIPsp/t7iQiIdh61MshilTTVNXbyfdIrNFn0SVskhdGDKjxPohMolRCdwhGEYYoFGe/tJZt97l/2QgPzdwbfaTm1csag9N0hXF+4ujBpVtp/hWcXCzi+HtDGMVofm19Vpv1kwQtIBr+oAaYoiNRIev+7n0ep7Aqqvh2WsXJ6oetWSVsahofdDx+VhH16+FAy6mi+DZybYAVIe2Rl1Q60HV62Y4AN8STrUgK0sffYbFAr+4O0Xx+Tz88bkxp5kT7wRzOBk+6ZLjss2n6CGahL5rra61DXyfpZvtiwNIqi1+Lgv6ieiplc9s7NAYqR8MBlbm3AgT9lVjUo+xJFVpAGYbS3/rh4NKPKAXJYtyL6xd5niGJTkqv3i2q8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ae08f-6746-4dd9-01e2-08d7ee61543c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 06:23:28.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RKXDdSVyyUN8grkWEcCmuZbG2Jloms26GXJzFVJmyoluloSDqgS55B6RqRL8NEIhO93pqJWSyXBzydqoaxmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB3321
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Sent: Saturday, 2 May 2020 4:01 PM
> To: Paul Jones <paul@pauljones.id.au>
> Cc: Phil Karn <karn@ka9q.net>; Jean-Denis Girard <jd.girard@sysnux.pf>;
> linux-btrfs@vger.kernel.org
> Subject: Re: Extremely slow device removals
>=20
> >
> > Delete seems to work like a balance. I've had a totally unbalanced
> > raid 1 array and after removing a single almost full drive all the
> > remaining drives are magically 50% full, down from 90% and up from
> > 10%. It's a bit stressful when there is a missing disk as you can only
> > delete a missing disk, not replace it.
>=20
> Huh?  Replacing missing disks is what btrfs replace is _for_.

Oh I see where I went wrong. I used a command like=20
btrfs replace start missing /dev/sdf1 /mnt
when I should have used
btrfs replace start 999 /dev/sdf1 /mnt

Yet another quirk of BTRFS...
