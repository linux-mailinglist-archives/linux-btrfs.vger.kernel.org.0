Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D681CB1AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgEHOXx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:23:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41161 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgEHOXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588947832; x=1620483832;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ozGxnrAVXomYgI69MCq0FjIArrULZD9pjoADJhOOAFAhhvNDRX69wpiY
   aXMJMsP0QFKbCi8T6TQbOl4rTvLJ9fEUJJm2iwhbp0A1srPf7aDrKoSRK
   /poT4HQo6VZTO21erGn/4W3UOBpWllh/5xLvcnWaZyOoN58Z28mYduNB0
   mW7KCwKygaEW2hf8ppY/ErLIoggPN8Vq4Y48bjhHPyOlpgAZuy8IqTGcZ
   E/xcssZmwuRJExBRWbYetJFp7USdXRB/QUNGM6yvjQdx2dmkmEAa5Uf4l
   Jm9fVdibv4jb7E9PLmS/cHVSkWhD0g0UhRpBN1h41gjTwe5CB6G7xFvZW
   g==;
IronPort-SDR: HrrnZYJ7OOsu49rzZSsEa3vJojfixJhUgplZUnMmerYdb55QNSFS0mF+UyM6BfxBzCbumQE6Ho
 mWVaS6QlnC/84Gl6gLv0OPEH31T1BXZl/BF3fuwfExujN0mMmsV18rKBf6h9tcY0UwtklwR851
 6mKTq4v2kYM4wh+WMc7j+F+o7JcFjgbFUNCKcWDRV5WKHfzwy/uRDXw/pNYPLt5+ivRgr1Y+TW
 4XqtJLWyvmSWfhwFBJACXQ/lA8vH1ZfxTVHT5zvzn/SVtbCD9VEVNxDNp85yrp2SLBtJkMkR2V
 1TQ=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="137568225"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:23:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPNB0P3fguj8v09YMUlU3Va6LxxY+9M6hZadEU+MEM1oMIj/aQtfyYRltSrPUN+DZl0+l7qkcPyRUZOjilh5ibL9K58s7lBfJMXUcMcdiPt0AIbOrgaRHv47VyvVUK9IwvpqwscwimICTm4mVbLdwE6BG0jH3YI99K56cpMUAJIONf/KJ1J9sa6+QjTSzMeY4X3Apv8lk/fSqF9PTlKflLoUsmN3hlzWuRDyr8WDCOXQ+4fLz9Yeq9YW0vvgddbLvDzBaocM2ytOCFVfhLwlb4GzjWr1jWAZMm/Cl/aL1YUPH+fhJIikEWn2w/LA2C7nPaQ3c+4X/wrfFmjkdYZtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ksbsi11mwvlHqdPJaoGcZY4FKfZxUKQ4ZURRIyTvKHC+72RrHEB6z4vZcA+st7J0emOAXaQjqziHf+A0R5QrEj4MNssEvHN7FY6nbK1rKtbaPUNwmXsB26QmZfv193hbk3BgJGkwxRhtSxJtXAy+bGe8PGmaxFRkV9rpKcB3hwBsSXPG6BZZxzI4ssAdfaifnwHwy1470g0+5CvLzlZfl8CoaGSZeIM/RILiPifkhMB9Zr38D8fEy8jLU3Cn9n/J3WISY+XOoXzXUPZXRqHj8nW4CfGT+la96QQXbmFYihwKe1hBnTPiP8gfM+yOmK8mhdJgZVQpuA98kimSMFQlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=alSGE1DluO+3TOnCwacQ8yvq2fdyzYId6wQRXhScEIuEroccvPS3Dcm6Vq2qRjDDAg5HbRGuPUBhtTBOrrivtK1T+Du88cCWMUIrnYUmkXCYakS8OrmMnmyuolqEEYqMRtJFq1p1JGRYur0FHde6Uch9xqtEFPxgO6L56tGMFxI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 14:23:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:23:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] btrfs-progs: block-group: Refactor how we insert
 a block group item
Thread-Topic: [PATCH v4 04/11] btrfs-progs: block-group: Refactor how we
 insert a block group item
Thread-Index: AQHWInCDWEUAF2Su50qa6cpOwEhJ2Q==
Date:   Fri, 8 May 2020 14:23:50 +0000
Message-ID: <SN4PR0401MB35987876F63DA91D3F40F7C79BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200505000230.4454-5-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bc60069-9284-4c86-ab3f-08d7f35b6da7
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB36806C566694E65B91FFF4EA9BA20@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FP2CdAMxtBK8kI6EXN5co1i39gl8mvBjHw49nNuazvJ96ZEkUQReNWt7VeYkQSKTAhJjnlCouujaXCBkZGeRyJKId6/17M5mz1146NXnFLrWQaAkk4YEj5ub/eAs2S68Z+OYeuLJZ4z4+T4r5UiPtSFVlu6NRSEhR6ibNkD1lPuqXhjdadXGf6CNOYLc8aoreYvcZfW4lJ1Qeq0972+7w5DcGK9yCqYJCAEAxARrHahk3NgISkbzKwcQbkCd/94zLhwc7DQmL9EmEPf/zIAyI/YNVnQMUcnb/Tev3ucw+QmAFn7N9Dwtyl71JB9jbZxJim9hPiQjYhZVHG3LfxWukw0GkdBLb3NbNFJ7z6dvH9rEjllX2dDTGsmcz49Vz0Wq1BZr1LYt3y5ZBrcaH38yHnDOj2nCqf93xfDpkJjQ0vEcbP5Pj3FgTs8tiH3iy+tGllYkfOHQ6AwsC4BADvbVz5yLzjC1MVVQzyp5wuos3pMDpR//LZn2lU39DRJ8YIN4OEE2s+IO/bbGe+JcUdVh3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(33430700001)(558084003)(91956017)(76116006)(316002)(478600001)(19618925003)(83300400001)(83280400001)(33656002)(83320400001)(6506007)(4270600006)(83310400001)(83290400001)(55016002)(9686003)(186003)(26005)(52536014)(66946007)(64756008)(66476007)(71200400001)(110136005)(33440700001)(66446008)(66556008)(86362001)(8676002)(8936002)(5660300002)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O/7118czCYTH05deF0EjPJv105ZNDnS1CZzY9rwHtDev5EONTZAoBBo8s9wc2BfoRbKQOniXik3Kb4OMaI5oRU2NW8FchNmRqdOMYBITq0QdRUQjndSq6a7qPxinSRpWeAuvt0aW/v5DSEiY1THLGxPVN1qqWhUraKGFKT64xzoKkYSubjIZtYBmup/QAgAZPfK8YtN1+wrg5Cqcs5LWKvnENVpfsbSTR7ZwtM3dpNOtXjhXdCQr/XCx01MCI0+5A2IB5fPNDkI4QN9UhzUl4Ertu9vmo/WtzmvhrOc3ansU9K6OimG5kY6ZNdZHuTxxdSdJ3N/DrMYiIS/i1lUtn4HRRszUX3yq+8LID5Uw08I6eR52Ezmp9yMXhkwgLkRwmf3SZS+gUhdyBZhipM8lEm1Wq3Cg9+z3sf7PS2N7KwHQk/fAkMzM8qqvHkynKnRUCArZEbVW1XcSAAkr2Tp+HNLqIRM85QK99r/7Bxa6bEt8juzleBLhw6aduzXc7O72
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc60069-9284-4c86-ab3f-08d7f35b6da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:23:50.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCkl0kACWOYjL41MfrodQKMKL5TVsSb9DISlF/rvbj1Bm+r348KyQxFJLljkeIPeu0ssj3gUbc49iqA88vSIrnJ+GtHnYi3eFjSkpX57kAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
