Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B311E26A10F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIOIkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:40:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64718 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIOIkI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159208; x=1631695208;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=W3urZ7eBxN9z0bgQM4854pw7AHgYDt6YhlqaWjAZFEfjIGJh0RTF1HAn
   k3628RZXbbf6Nrmic2MvDGWaLC0imbl/39e9TcqdtmVqXRHHGqhRy2yz0
   oUpuY6uj1X/NAIWYLjU1/HoGrZoUGeCOz0ao5HjvshTe+Irsn6VpTzzuM
   Tr2CrSlJQRUYYyC8ai+QUJMViYUuolhgeVv+cKi5ovenAq1cD18uM3Usx
   nOBeV8va1lQexC4BS5IRFZtO51hfWHCYwp1NL1rfdcaXyDpCROCbsNQqr
   fzRWGqJoU6QOWL3AWqmaw2lE/sQ6WFWQDmkMGMJ732zghPoQMPiusFpaI
   A==;
IronPort-SDR: v868Ruynx58Zg2Ut+MnsToWooowfa1bcxsU+02p9Gi3fx/gLjpzD8Q0bC+sVinoz/FlO+U+dE0
 dDNJyLC2W59ItnDq67JISGTrwC89XFGPRC6bgeEVTMVOpWPquwSNo2wpO7rF26fujjAlERn4kk
 79GO5M1mWzbc/7UtKcZK7nIL8leNQSB3/usVY8ZuFFw2xTPok6RxYz023sPo3hmLKsvWbFu0Tk
 +Gtto9svFfxyffjJYT/Dypv559AEAjfXVgVIf7VOfUbGbIGRxiJoXVf7fd0KiCj4h5/upGaWOI
 +tg=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="148635528"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:40:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9mYZZxa5m7KCvnNvJSYIblhxwhbgxE19OlYR10pjMSzqQuPKI2o1zYqMrKIj2vY8AallCnHthJrB9hRuoy9fLaj4Mg6LLsnMw7G8ngP+A5E8si2z7w9ibs7LgHpOHTTtaa3ayqmMNgclJbMJd1SUPbSUgpioLmva8npDBY4DIDD/LQnTXJ0sO2FXHkD+ff76iorKKoQBPG3dNaINGLbag7KNv3av+nuFflR1MjljoAnqKpDNt8uaxcWwamXxrBwOJ3iBp0OR4UgDiV5ovRtYByXo/NeZOjEhEIKhXAIBCEOIyId6BVsWdmACkC5SFaNSCPNZWCabUUcRdAcuWhrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ur2MbpFpMrjyQqvor+3o8Dlu5KZjF3ribaUYT38ZbS3OC9iNZOwIYdCa1BZbzbuefTUvKGAYE2LVm0lbCrCOtH5dfib4Q88SEz0lJjURzDld7dF2nPE7IxbTAhI8W9mXqfrOOXCtEgNTouSqPMjBkl0seFJjPSs2BKmXqNUNvO63LGZM96i+tN7dtID3/H4WGTF9usNfvwDFXl4dBh6gGoNXL7XjoUkgb6AkSW/rRviLzEa2GsGQ2gp5ejy/cri23TTmZftiaH9GLllKHh4C5MbgPh+aWMnEqxdc/6ljLfgRhU+9MozHDF7jsEb2ofhmf7jZ5qOsfV1U9MHXxLObMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=huwCkyIyNV8MdCRLYyFjW25EfUjYPp/oVwMhM91zp+c7+ZcePV8RXZIlXm81HOJBp77Y7KTc2599YZvrodK6UG86f+7PBG90JxIEuu77p+4kQCo7euy1ue9gcZyuHEIi/Axv9EBg0qbyWgSDKWxoQhFK0de3+dtoAWGRN20/xrk=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6459.namprd04.prod.outlook.com (2603:10b6:5:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 08:40:03 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:40:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 03/19] btrfs: calculate inline extent buffer page size
 based on page size
Thread-Topic: [PATCH v2 03/19] btrfs: calculate inline extent buffer page size
 based on page size
Thread-Index: AQHWiyITWVOBQQXpjkuZI00EV4lp+g==
Date:   Tue, 15 Sep 2020 08:40:03 +0000
Message-ID: <DM5PR0401MB3591316BBEAD22C119CD28B09B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af22fa30-0db7-43cb-8232-08d85952f0ad
x-ms-traffictypediagnostic: DM6PR04MB6459:
x-microsoft-antispam-prvs: <DM6PR04MB6459E971CA1AD97906FFB1709B200@DM6PR04MB6459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhUGWL4GDOBwMUhEURk8wZlFjZ1zKOjhjUS6x3a0Pg8pEoWiLJwsukMgd8a33zIilWcBRDTHf7LpNUiwgOUMXO0mKqHDvhjmnmsmeW5Qs4Xnmah0ZgtAjLPLr4MN5ar/yXKxTT7sssRp02eLOE+N3EH1Zzmg5ILZefvzySNMje1w0ftoyXfcZ6opTAqKsG8QnTxAruIwCb7uao+tHIOUq70pWuTdQValouhTfD3s5wHv2XLSdjo4/ePFQgR2zqPoa7jYbHOFxFqP7DAgYeK+295gJpTcVAenWTXwZoF32J5mNyWj5asLWafYUlRVKHxgjWfsu4zeCa18U4c7QW6zgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(186003)(478600001)(558084003)(8936002)(316002)(110136005)(76116006)(5660300002)(64756008)(91956017)(66446008)(66946007)(66476007)(66556008)(86362001)(9686003)(7696005)(52536014)(55016002)(8676002)(2906002)(4270600006)(19618925003)(71200400001)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G/+sLkg//C3FkbMuV64HRzwZRKyPKK3tq6TvFY5SKjS4p/xfkU1ACzImcYw0EgHkS3eV5mII4+mPytpN2UFMYO7R+8QCyS4EVmzIppLBOD5aIJaZfFWgJHKZrA+xSxKSaadNAWkxFHwQdO4u0RLK0U/hHLlbI3u92VXvh7Z2BfeAfyHtTIkPS6jSom7VTNDu/fwvCOMbYqlwHmD8AL6HjxIs8J/+GIc6lsv6QBq8ngDKs1+HTmmGAKKamIhszGbIQti+Mj3aWkaq4PFHiopar5oHzNXv9KjZFgPi/DDorQ1HfzTkQqeU8ls++v7RvAej2WGk9d26Q2nw6bf3FCwHzllT6/Nl9gbNspynMGKMH1E+Zbe6S/lGsQ6YIgpJ+t+jRTojRTboWevMZ7aaZBYCg+J38kHNCqnXjhQzqQcw2OsBmC+xEPGCBBFLOrX9f/3xKYMXZgPaXu6de5kcjBcYuwkXZ1zbAOwnVI9sJcU5YN8qFxkqsZWNvK3fqKuDPOg5pSLLty9EjgoTg98qvYiM4M8aJWSADDaseCldWoNbKMtmC9UczQ+W3yxC93d4I1YXcyBCAAr+QKLBjo/YAmfgDjKE1l49tdyB633u1gCNSspHqyE2oPPh0XCAgu1K64AcZxMbnfVA5JWKvu10Kvhm+YCaRd+qgsALaU+n86vA+4E4ofucpadc1548cB/tZ7QsTcGKPcdVNgayetanoK4MXA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af22fa30-0db7-43cb-8232-08d85952f0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:40:03.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BS5eRJeuY2eArRIyN2sb7FXBtsChUdrmMGd03NWYpLNwo2+bRDS3ufKlginpNvbJcxgoubo0SRCbEE6SHX9wNM1yXqKCUCvUzP2Q+Nj6c7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6459
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
