Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9989F1CB194
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgEHOSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:18:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41335 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgEHOSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588947537; x=1620483537;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ckOzWNXRHpxFCr3C45AbVF9BGG7Lign9TmaPtUJ+Hcnyu4o9/ACmYljZ
   ncXDREscZdBdFsZ87noW0vgQqS1HC9U4hfcgxgf+blxGYxcPIvyHRPoQW
   qzkyVzlE0Hg85h1Am9jmb2RXsLfzzsJ+q/7FO/bZ7aqLaE09/rwoGGWMo
   zRPsHYGqNpDORNJRaALjVquqotr2+KbZcx/Q/mDtb6y8CShK3zXWFbBft
   GGx1zy6v7pqolh7kuLnLrr95IYo2L3qtVZF7rwoPb8x3iwJ+a+UIqoz3t
   9+goIJLCc0wqR0Dt+t6vEtGXeZrZadSUpWy7w+ihriG2+ATJ3v2GM5Lrn
   Q==;
IronPort-SDR: bAf2NPjkyMgCZTjif3CXL3ERTK8Kb5gl0Eob1CSHYT9JxjuBJXQ+QLWQ1QDCWw7IPyIikSNqUe
 PO5DGJG22UR9Nlg7O/0wuKpL4MMgJLZ48q2iEKX2dN3mjdeRNXOAGVT3T8lnJaPGAZaBzeg5vb
 3yFeFAlIEDl8e8W2mZ1lLl3hiPg27faqG9HysE4pL7JAsYlczJ30b/3WkRjWE/fHEJnJPL8AnR
 jiY7avdcd6ShPhX+VCXgtdj8TkOSqjt4FiAe+H5/gqBGSINycMu4oaz+E8NIEJRM1E4djWlhHl
 +SA=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="239886950"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:18:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsb2U2zEeiC6PabCS+0y2/AAQ7v+P74gIZlyXhLKitw5CTOwPwdpQ+t3rrtPPmg9As91RsEn24keO4uLILZ9fGfBfKpGgL1+T/tyO2HXoXj5fH8M7PrvmIsB9qz2yJyfXPYRGEX1LJUitBugUq+JmLWZ3fv05P3fNjtlDFP1G1/TalCb7ZQ/6a1slTPHAhGW+dpyWVyA7PIe/klx4D9d3GTCGKmWS8aPptA84/QM4AONgxtv2EObm9smvDDqH/mTAU7KEs73Q2j7JBnmZz4yvM1EMroHYd0Ak+gob9uNCCKB+CbX5xWDEBy+gXp/hY94mE98eDDIX5yCsQGM7/JdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ci6m5FOclgx4b2ngKh9xf9SjUnqP+jhfYrJxIljSFfjuXi4bs/YLDdj3PXr065gBEO0zB8RrfW1c6R7vcrYIO6jbaNNvov51r5bgBikXWd/lL/9TQFmSX/K4BzEtR2HzjDWMmao24mG/x4jbcYp8zh3fp0o4QgkkPnzrCHpTe1/wW015pZTMx5m2prG6cqiZg6xCushGrkkG/fCf9AX9IAd4aqwSfDmcnpIN8sCaDxXYMw8cA88JSf9mwK25qdluiVXSVGDlsjtSF5JYzTLdf3174LOf00SYOrdrM6AywY+3rZXhmpsonD9FOhxr93iTYe/QEz02FqIdmBj9n1b3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=wI6DmPJpb7omUNEv7oexMGaA7UN2iYgPxibwIM7cG0vrZAThI/+bfjfvAadPGu/X0kUjnS2U3weeLQOL3qQpKSstfUz681S6SDKk0PJrp/xClZqY04PwwgXajMipO2bm0xcl5jRbhcfK3hSjy0lBKwwdaDoCQ6iSpGViyRzuE28=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 8 May
 2020 14:18:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:18:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 16/19] btrfs: optimize split page read in
 btrfs_get_token_##bits
Thread-Topic: [PATCH 16/19] btrfs: optimize split page read in
 btrfs_get_token_##bits
Thread-Index: AQHWJK0JBds2bonpD02AhiS59V/wKQ==
Date:   Fri, 8 May 2020 14:18:36 +0000
Message-ID: <SN4PR0401MB3598BC4B1A6C55D4DF63C0679BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <1237ad8249d4016f90b7aca807efb8887ef791f7.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ce473f9-ee30-425a-3b01-08d7f35ab269
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB366218EC58C8813AD01B57119BA20@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u84t3Bfq6TuXn8TrgQQ/A0AcUVy/U9pkIQ+iC+ofWJnF0BhTOPb1ux4ZjgA6etUuatVZ5scDw2iBUStGXwLN+Ftvb/gOw/qu23LZKQMunmYRZOXWwD32H+AH2xkD5n4CZMWhtNLitb+/qH1FkyhqjrXATDdr/CRhBnX1xTXTb70M4BQgWMFWbiET8NxP+w8bSQrevC4Fgel0961koXM/LWT0HalgVbZEIDw5vdoU05lidJOatuPNp9jdFii7FK50HDR9BKZ2WCMCS0ARrokG1eTVbl63qlxITfBom+05d/XmnOc2ODBygKsMAxWi+WWFMQWfqGzVG8PmDYpoV7qVMff4hovyBjZcdlCbvkgiZQwi2dTpX5SGuC3x+9oArPkrsWjxJVJsHYDEgkljIhuiH5rdsBJHKosQsoqG4aiptbG1zzt/2FraEeh7HJUmKq3KbLxN4gXDB+yE3+NVtaNP3dtQq45EFqan6GelpAEOCK2YR+Ktyqs5DH/GJ/uZS2Y2gWR3jm2dEVIsvoTTyn32UA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33430700001)(6506007)(19618925003)(91956017)(52536014)(7696005)(5660300002)(71200400001)(55016002)(76116006)(86362001)(66446008)(64756008)(33656002)(9686003)(8676002)(66946007)(2906002)(8936002)(66476007)(66556008)(316002)(558084003)(110136005)(83310400001)(83320400001)(83290400001)(186003)(83280400001)(26005)(478600001)(4270600006)(83300400001)(33440700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S6MitlBUPi7aOKC4LZiAI8ku5VI7TuErVQQ6mOMaLCU5uw07NEXMFRn9HrI4irea8MjvIIYi3Smhj0dk1fN9pO3i61294wBcZjO2+DkcrbFu8CaLWYjI24Z9FbpyqZDCgNaZZIoPqixSD/vK6vkaO24vsqY67QNehBUkT1l8hKjw435f1IT65JeiRq/Avj6pNbsi4krwpGyXKiXcvN77bZgBjrJOe4w2bvOuZFuBXGEH8EmOTxlYA/eLjNO8wRyKVW5/hvq2xbAkRUv0ou7E0SnBa64CabHnoKVFy5d0qoEZX9qIm3afORgxKTdkj3/vqmsiko3A6lQlezTmtMpXr4AaPf9zfxhHtKw+kSpxG6e6YANKWACk9DlE0KO7PaG6O5nbrQ0HsQCAfS5oL06KzY8pA/52GfJ0I6p56HmYPC4xLcr0VzTG7HM9zBK7BvstgQBvvkXntoV1fy/xfNuKGQsoXMgoTbTp9vp/XxqviD+vgLsjfnWm0R2DYy8wsu5/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce473f9-ee30-425a-3b01-08d7f35ab269
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:18:36.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkXWsykj2XgE+3ZwI52f4LvwoHltNLjgEaikKo7L85Si+iIznNk3BpmC47+hmvp/30gISub/79m5soa20Fe8FaaYbWXgasapXNkSd0cUVUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
