Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F7157304
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJKvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 05:51:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30587 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgBJKvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 05:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581331863; x=1612867863;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NSg4Kzt+tI71jGIKVkEfYxvFsFhh2lTKGrljvCp+Tv+X6QXIxSKZXD+P
   IdAfD7hRsMC4ZpKlL6VJNszFxSi2aVgflbQ7GISs5AtM3uCfD0rQMRNzJ
   4NbhiP2T9Q/QqXMUSzyo376I1CorC/1KNH4K1PHGQLqD0r9nIH+iRCFxK
   3yR+Qwzzg8PfqR86zSV65zOsu6EbTOmi7gge2wRnMVTiilw+ws9crUg5z
   VqxgOSuJjRQqhX3PQPfoLrXCUBQPbhpWZ/NI7XCUdXIj8A9LXnMcI7vrJ
   RJwvmLX9UrhnPyKmFq1M69yKcqLUndy9ioQCrCy34wiQQtg8XzRar6KYL
   g==;
IronPort-SDR: ePT+00mxDz99Gw8qj+Tn73fgd0xwJ4H793V2hmiLVJK2o7ZRwdq89hNY2JUMTG35IRaWiH8nr3
 DRuLFhcTPmwqFapm6rjOC3voL2sYwBkWNOYQYRd1Ks//h6L2Is/x9to+ROvBNMntexFBcQTxPh
 esPfwSAQ8kV2xPTQid6765JLstZYU1OuPjxOGhR/i/KuPDP0MHKcmodQXIkQyQtyEh9BJg6Mbk
 YmYSHwCyGGucqZOD5Uo3QtRv94yFYpVGFjdeW/2MBFvHubvUQ3FAmucV2v7D1lomnhRpK3H5cs
 kk4=
X-IronPort-AV: E=Sophos;i="5.70,424,1574092800"; 
   d="scan'208";a="237500670"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2020 18:51:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5z8mgIWT4BFLJvKlSQKynhFXCDy9CRgM+dVqKTU7sULHr0NNlCqBK3H5p0on7FA56758wJFI/+O4m0Xaqc5s62VDd9Kl0xmVL+eCrKf7R2J6yon4TOXQGt/+j5CRrY7rDZjaG4or+JysNACXJMbddF2SJ7EUU4aGjkGepIQZvjzUifqlNzOi3zahrDCZcGFVSvFvrCRXaIHCpG5mYtkL66FZB5n1aK2eYZKyPWAfeOtJCvq9akwSXC51Rh+6NXosvNBr5h13AmdlqK9yu/D84qlyZO7aiOLkNcMKg6o11q5UfcCxJJPhp815ooKFJalMrmEADhlur0eruZSHNCKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=co7OOMX4knHjYP2ExkZ35s9lyXPjeJNgHHvDosby+ckjNlNDEaCv6Kq3Vt8bNvUnvhLIo7kbc5QM6XFoZ7aq7RwlAz+AYj3MRwe1bg77LJji8mGgtc01klL+S24TzV4JA0tigTi3ynovkDCqkATlPm9Lwd+NYULP1s4ItH/qcSy/HqRjtPncaMyM+5/BtfYIcqsqL7DJbGbJiMDZKhlcp2MzXlXdO+Ez2Cgn40vjb/NqcFOJITZcEyTR8bIF3Dqy7++XHLjvgv8kcqRBpSsSd57LNTXblOMo0jd9+Kg0sVG7S+MP1H0WnpcS2Bq7MWwHDeIsprMZotdoRLo6qa0tJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Jwh2BEf0CJemwpWvNorBWrHPV2QN9MkLH5PKvCE9Jbx5ueEdJBad0eEfvf94wZM93A8zRLtzJ0QF6rXgS+vDO587zbysSwuzk09yCf63E9rTyxKVe1GyIfucZ0fXVDZCnDhG1mjDkmVk/bzyno7m2UAlNp5E7H6XY4NXjEQKNmw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3599.namprd04.prod.outlook.com (10.167.150.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Mon, 10 Feb 2020 10:51:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 10:51:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     ethanwu <ethanwu@synology.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] btrfs: backref, not adding refs from shared block
 when resolving normal backref
Thread-Topic: [PATCH 2/4] btrfs: backref, not adding refs from shared block
 when resolving normal backref
Thread-Index: AQHV3Zp2OdpfFZyCa0aBncpuJVvtVA==
Date:   Mon, 10 Feb 2020 10:51:00 +0000
Message-ID: <SN4PR0401MB359808406D6CE916F81AA8989B190@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-3-ethanwu@synology.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1690a4e6-792f-42a7-f0fa-08d7ae171e03
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-microsoft-antispam-prvs: <SN4PR0401MB35994F5D0E68742538A439789B190@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(189003)(199004)(316002)(71200400001)(64756008)(7696005)(2906002)(81156014)(81166006)(66446008)(66476007)(66946007)(66556008)(55016002)(19618925003)(33656002)(86362001)(52536014)(478600001)(9686003)(91956017)(76116006)(8936002)(186003)(558084003)(5660300002)(4270600006)(110136005)(6506007)(8676002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3599;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: toeDbdTUPCwu8vGJevATqfMvGT3he9sRiy9tAT5kyS9qzUphAVooGNyPdzXDneOf4ziOQYdZpwhCXbY7YJHODm6SQiIttC1XRpwd73VDS5GYJQnjUKmBzajhkm+gwsHPsp/Kqog1nHsiiCFCS/3nhshS6zIwtK9uUOzDGAD1VdEtcXRCWiQOMFkG87xroQK6TZ+MYATo0KU4WsXiqllopqIXqhuAFJUjObHapDfRhLZRK+WupGnXc+XZPdPtqw1PyBnvxA0awB6uh4p2TbnWSyz8hpagi65juPRuFSZU9S5OLcQEQ6q95O7fT3WoWFsgBh4fyjebYIxcrl3g5XJadqtvAX0k8f826r5pECCj/uZByh9MOBy2G4GwGMfky2aBlJolk5ICXOacpQ+Cl6w9RetQkG1fySfFrcBIbj3maXUzH8ifv5OCC+661D4LxlfJ
x-ms-exchange-antispam-messagedata: q039CLX/7vn69Gy0qVD0KDB5pz5zQBxgrujKZvy3nNGtYvuBIDR+00KCfYWzO4RBGhpLCjICBNx+6PI6V6UnuZR0pjvEIWVEDwHw7NfwB/iFGJYu1otuFj+vofX2C7YJLw4+1y2/u96OWPaD1c1wqA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1690a4e6-792f-42a7-f0fa-08d7ae171e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 10:51:00.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yv8O4tPMGWfmrHKl13OEqKpwPPWtujFtTv5l3mPzBKwltq/5Dr8CBONnHfNo7ZdUfTqe65LVUl8VqiXsanaDzJ9ZlwmF9VtA/70yDS+BeQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
