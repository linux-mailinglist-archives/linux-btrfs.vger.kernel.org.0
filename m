Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048001800DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCJO5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 10:57:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21633 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCJO5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583852233; x=1615388233;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6LM1QjKvHl9Jz67oAILxozTCVP5WPZulvZQaojbmq6E=;
  b=J29PCJYg+dIFJ3qL6PFs2arnMqDxjqYo+32Ubnm2Ojtp50tgDd78gksH
   6j2ByPl253jjei1hVSkII005YoEhUpo2QlDAtN3NVrD49Ksui+D04nV7U
   l2/i7hdseZnykOhtDUVknoMdu6KSdiG/iGIXvur2fXzhTlhonUyPWHP4/
   /ia88J6nJ8WBO/M4BPeXybzulIzDp2/LzwjNnfYOgV5ySMo1Ym/tpcxYy
   40WbUksJSqyjTKUEM4Hvy3QntS3VuvBqKnzGMvM/g4eTLLk5PstV58Q6J
   DmxBC1+ru8l7BA1arkncYv2xXISwUlKLxt3jNDLlKfiJ3B5diWP4pBuBv
   w==;
IronPort-SDR: C5adC9dZUe2u/OaG5JV7TVjUvngD/p1GS3uvC9/QvdzP/7d63vjTf5UyWZJ1gstiDhMFFtI1Vu
 FhhJlcfWhO86vfTciIcdBZLd/xegCqKHiwL6ps97b8NRJw0CSyXWXFQITNPJkJvTrNFtz6nxBr
 OHRUrVaJ7OiF0jfK+jzo+h2rOxVfnlatW14kYyEF1Gr0Sr0CDmmGK5qqq6Maya3KIHGtGgmkOD
 NJCOFVHWZWSAVYhSU48LxXL0cYZrjJ6BlQmBU7X3WpzSngcab7/7YZG2Zcjz2gs9bbOtMjXBuz
 tk4=
X-IronPort-AV: E=Sophos;i="5.70,537,1574092800"; 
   d="scan'208";a="234104076"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 22:57:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUiWT3loAGqlT5CZ6/AN9qCQfq/tEfUOmesHohtFTi6ymUg2q6uZqyfF3LDN5OdN8xXi3P65RWYJBrk8kB/lirZKHjbuM+BJyVWYSPveSwlGZH9QXWPIth7FM/GyGMdA9aFUI5x75IFpQx7qSed9p4CsJuSeYyQGsKKUZbvzh0KLFyOx15acMWYTiqrCLO+weZJB9TZNM7L/8ncUV7tmslaG0oIK9ix/5kR7LdfK+EXLaj0i1mGbAMp2Y76GQVXL/+3YhgqRlr4i6UJVADAOhskIrsZtA1pnrAqSwL8otxOxIc/X3PdJ7+sg8ct74JY8NqgalW98uZsByT3W/yfGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LM1QjKvHl9Jz67oAILxozTCVP5WPZulvZQaojbmq6E=;
 b=nA9LELE6eVj9rJfRGE14wGK+hBDIbm3W9ej3k8ZmFO86rNIR3V4Ux6aEQOrn55DpdlVCZ6wDSzZwuOZPkQi+qXemtHYOpP04ONi8LhKL3D9p1PFU/CTSDOsNMk0ifg5LWbtTunRRIRAb92cRH7UjSFobk9ImpVL3ub3wo05ZDBP9gIX+WD4OGgDRHFgdIYn4gsq8kQc9OxQYiGUKnoArr8jX6X2ItGUrn038Yi0kmlOvw51RsmIFmyXTb54bXPlzmNs53FpxP9KQbdZZr7WoXmq1BlU5CuNq3bBB0aefHNQ3MjKg8gc+fwhoibI+adHbwAt2e2q2jYz7Ah//5VYSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LM1QjKvHl9Jz67oAILxozTCVP5WPZulvZQaojbmq6E=;
 b=bDnkoGQFs8Bj0rYsUHUTYDv7hv6eO/f9WHu8CKcMDvDlmmOf36+Cg5uMLc0pYF9rKlvJnF2TGYeTpvz2uWrVXqBZt5BHzyEFOLN+Zt4G/Lzs/4+o2bT6iQA6ixD0Ew5dBWxOJ7RzZTChOe6kNKpLz1/DfqkP0f8ftyLVrqjLn0o=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3533.namprd04.prod.outlook.com
 (2603:10b6:803:45::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 14:56:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:56:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/15] btrfs: move btrfs_dio_private to inode.c
Thread-Topic: [PATCH 08/15] btrfs: move btrfs_dio_private to inode.c
Thread-Index: AQHV9lpUu+lbR4Nxk069TzyuzoQBRw==
Date:   Tue, 10 Mar 2020 14:56:55 +0000
Message-ID: <SN4PR0401MB359894547AE34B1ABE590D409BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1583789410.git.osandov@fb.com>
 <7cb31cf9673d1d232e770145924ef779d3681058.1583789410.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 139d61ef-0a9c-4eb2-78de-08d7c50346ec
x-ms-traffictypediagnostic: SN4PR0401MB3533:
x-microsoft-antispam-prvs: <SN4PR0401MB353363268A87B9EEA53DC1F99BFF0@SN4PR0401MB3533.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(81156014)(81166006)(66476007)(66556008)(478600001)(66446008)(33656002)(4326008)(558084003)(86362001)(91956017)(76116006)(66946007)(64756008)(8936002)(71200400001)(52536014)(316002)(6506007)(55016002)(9686003)(2906002)(7696005)(186003)(5660300002)(110136005)(54906003)(26005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3533;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sI3FENgJVJRFEzJiO/VnZ+LZgwy91EvoX3u6umdmDp3kjtsCUEItYaXp9I/tJE8i5E6J3FJ4wMVoEcgihHjdfB8eFccz+IapFsWN06w1W66x0RkffD3xDPrk7IEWfdWOC/t8bmhT3tGqZQbStQRzit6PjRXfo567x6++vc2apgR0wsyG8z3DI+EIIR3iBR6+32oJz2FHR0Jix/JaOUUomCcxtoEwiFiUHAqP8Z2sqaXb1O/5XFOrqsTxlI7J0XY7XyMmsdrJDxHvrZnG+52Rrg5/Oo0WNbF0zRCWCIc0wxvUbtCnCKuYtuuT3IzuKItMfcBZJ8WbXGyhp6iMDiKguczVGBe/cLhD+6EVu/7skOHEvYIJAd97yJTwFDsNexmriNGRK6vJ8q99ETCJOYCdwtctQlVOLszZOmNZf8OWqsvUT6qCf/iYTyk+P5WxmuP
x-ms-exchange-antispam-messagedata: w9jPXA/UyFpX/e/ue6bF+V3yPmep92SaWlnuCCaYGEzMPyhCrRGELfZVJdYUM7lZubTe5hwS+oW8UE6NhqHEo7yGoRHeF24DShT0jMO9XDpGh7FlgMN1efVI9zIm014XcUQ6lyhEQvOXRJ9u2bKT+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139d61ef-0a9c-4eb2-78de-08d7c50346ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 14:56:56.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPr9EbZW3cwf3NRzEnyY+lRRAv4GKMvacFXc8LmGMJwAlXmjR61yBJ7s1Ia+sIp8jwSG0UKa7fFGXiCrAVCo2Gn1SxOAphqIOvNg2LzXDKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3533
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's still a forward declaration in ctree.h:=0A=
johannes@redsun60:linux(btrfs-misc-next)$ git grep -n btrfs_dio_private=0A=
[...]=0A=
fs/btrfs/ctree.h:2808:struct btrfs_dio_private;=0A=
[...]=0A=
