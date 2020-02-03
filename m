Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47C3150514
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBCLTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:19:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39729 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgBCLTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580728827; x=1612264827;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=AH7gwg3uBumIN024vza+AaAP5KIoAb0tItMFsfSelRlacaAuCtdKrwLy
   wPZt8BrSvWnaLqifkpHtdrzcQt86w8iahvY5g/w8YVOCwnvskKT7bmabA
   ikiDyhN3GTAG4jDSxOo6aOnlpM1tgtK/dyU2yeUAR+6WGPnrIVb5AbBT6
   VbRMdGyr2HGMXxE9BCyr1N9FC2mxxvRlWftuQx2uIAF2obpM3fisyfHRp
   m3FlqOc44ZiLOkWTS/QNLDXeRzkcgXjYlb6Pqq4bT82PutdF781V2C/HC
   ySp0uyCq/BIaWFFR/O/TeodzRHzg2hi5PC/kVvTy7sq6TBU3oHEUjqPkI
   A==;
IronPort-SDR: 81Tzec1Owl3d6r1KYSDavumJHIl4jIHLQy6qnQygXYUIdxmVdVqLhzIVC96h3JUZIElBI83EvU
 Wh6+9eyyANTY48IQNzFEf4VsCooMlB0OG8IGMS4SFYUl02xTuSsi8DHXBWY/TfRs7Of4AdGARc
 ygcafA4aP29cVnNKtC0MXAZgXMiZGrSRc+3EF83Jkoc4J2jxslk2Fb1GyGRu/j2mGMOopnYVvD
 7PC8bswfosd8v7W97HHGn7DzcjfSmPIdvvFHgOjyFtD/lJFOxuc5gqSTzSkf9vsWo/ZG9c0SqC
 c5Y=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="230704899"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 19:20:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsj0sxn6Aw0GqHwGVCOfMgV885renKz8Lop3c+UWGBC6jOyFn+bZAYyzYGHs25WuiuN3DW5HLOK/A9HTxsDMZ3YwiHpdNyDT08BQIoaWez0klXntzeRFRIe6av2zr5aly8UKDa5QomJ7VZCUFYnJ9+YeaE5lBAlbJXI+y4XgwgpelGgCJeu/eY2LKFSJoo+eJjBXIfNUMYmE31JJDVVsGsgaX+/1eh1w+RZx5JyNsrhkMpvFqcALPyAjxwOvMiP6yfEg0aKTPNN4xkH/i2GP1BdXYWr/TPAI4F9D6Resg62Nq3o2po9WLUJwRQyCcSv+6BdItugCc8wwpZvoOgj1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZPs25npIPjvuy0kR7PwK1DZ0zqjrB2/1Zy4aMGrLzUrzMcV3gywmw87bO75rrvhh2P1qHMRXqojSS6VlEFml21KUCOasf7AwqUmFxl+/IvOjTM/24QlbdlC5NiE6WOzG8QsnRD1QVygvBNprsiq43j1F/oOCLRJYj8qhe4cKeOKZ5B7IUQpjU3cwbRss8RyMHXTgspDD6r9JfsFLLutF+GKdYNMRw3XoM671JCR73wC/uF054lw69HXpWK0RjHScCpDHbkMCpiVqd9TYr5P9RTML0tQnEgg7qwtm9MIbDVHgLKyJof2LKX0OhYQuZbUt892LGM6wafOfBvYXd3BiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cBmhjvxoHxHJc30vlPsxeNDZ9/Q3ecahPbrsvfWLSg6oZGfp2PkCJVnALBDecC1WkfsSy9oV0pNxFHRHnpbXEPAyHfjb9pGKLcz9+vcXEav64hI2zfxstyBn5pMTVlZ+PjzEvP5YT1hV6+o/eSDUrrnnnn0GvG7LkW74s9SfcYQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3567.namprd04.prod.outlook.com (10.167.141.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 11:19:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 11:19:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Thread-Topic: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Thread-Index: AQHV2Ibj+ihFlaImcU60odVI31WC+A==
Date:   Mon, 3 Feb 2020 11:19:30 +0000
Message-ID: <SN4PR0401MB3598621868EE04B6E0F3E7609B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-6-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31ac6f7d-94a0-4a51-65b2-08d7a89af036
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB3567B2E8046E6EAB62191AF49B000@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(91956017)(76116006)(64756008)(66946007)(4270600006)(66476007)(66556008)(4326008)(66446008)(8936002)(55016002)(71200400001)(9686003)(2906002)(110136005)(316002)(186003)(26005)(33656002)(19618925003)(86362001)(558084003)(5660300002)(81166006)(81156014)(8676002)(478600001)(6506007)(7696005)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gn9JHow+gThAtCMWLXu4LUX3bKL+xyvbQ90gX1vkI/ub2iUhWa+32qw010AkjVmLiSlGpboREhJJoHIyNSKFcPxsXlKrfGURP7ONSM25Wq98hNnA6fPjzhKT8vjtIpqbMdmZOeRleV0eOu4cgsN2ExhZtivqLkgKPgdc9RC3Ptya28/eKRWhMyf0pB3DVtQBKTvuBtV3EgF2SmTr4MB4ZfUVVavFhBdS80jH7CWwpkbRKOxvNgX3luL/AE5PP2KRRPPloC0umaNFHqpiTavTsGk+QjZQPQd1FPRFiN9XaUSVIHrXXgGmSnuVq22KOiMr48pHKIqxAvL1AkmhaKYxM+Fcx3G90ao5f/VKe8lTno4RRQpJfK9SwV3rpqcBiLeegXAFAxikYYYzk7LWk8LlOR0Dn1s8K4edVT8ueGzIgdE9UoXuIdjvuPsBuI2JeUhs
x-ms-exchange-antispam-messagedata: VOdfc3WQHyXbdZOfds6ikQSw23rcZ5icbE5qSofLmOSrUfKSa4QA6MV5sPSRZ4m9d7lEZ6Dghs7qpk5HMg/O3adFHDsIqLw56eCaRhFdjOiRdD8DgX0K46p5Q3F5xano7LUIYQdD8wAI+DRzBdJ99w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ac6f7d-94a0-4a51-65b2-08d7a89af036
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 11:19:30.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rsyRZnlmry52dzkMDa8Zs5q82x3J6peX8d1y2HArKPRbpRaxlVYFqv+kA0moPNJUv/51macszS6OgrJ4knG+2jo4LvQtk49EKiNcvubhtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
