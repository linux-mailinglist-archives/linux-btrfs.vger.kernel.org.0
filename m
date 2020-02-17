Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB4160C8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 09:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgBQILr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 03:11:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22373 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgBQILr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 03:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581927106; x=1613463106;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=iAH9L87AiYPaCpK2Svvx8ZdQ+2DtEGWp2faXkzedaPmc8gD34CbR11Il
   7n2UxaCdV7lXRsErc3QKRiQzoP2VwIFigwQD8el9b1Y7RmHWbw5iNBSMC
   LaaqHObLrSAnk9hREEI2B1BNrAa7TsD+4GCVqaE2R/LZyQb+K/TiG2pi1
   UkidTgG2YLsntUD3BPYNlZCbu9KZnd0KQPAvNUGiTAexMQKjOVNoxUcP/
   MxnnRVLRWlA9U36r/yfoo/czWQIV10L6V4rr6vjxT/MItgr9Xnm649WMC
   9I0EBJom8ZGVofKc8tR0RO0HgFOpt4TmXqyqBbFkmkoehbJrBuXq3N2nM
   g==;
IronPort-SDR: eSjvN0pSoAo4MVhQ8nqB9JxE1wxlllrhH2FpESxAqQpmmfpecjvpIO+AGXnhMaSdWdScs5whig
 CHRss0KUUzUK3N6LLXkf4KKKIOtUNalwLMKqRayzzriTN6MniKbHaKOSgfftz6rFWyiNw77Hgz
 fSqT322OBiJl8nqD00kBP5miKjAPwhN/HxZKpRoFsfdQeiyul4Oh09fzSugvPIXYtvmef7yI+E
 ZRITu3FRd3c7c/wLM52Ri9Oh0U5CAMi8pAUB01sz0Kcj8jpvz1ACAlg60nXFe7xOTc7bR0HxYf
 h1o=
X-IronPort-AV: E=Sophos;i="5.70,451,1574092800"; 
   d="scan'208";a="238067322"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 16:11:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/tRMuvSsp7F24hO+qitkReOrmnT0VnDQemdCbCt+g83q4uFnb1WmPdopeS6dnbbob+5wttfl4E6Tca0n9ihj5Il59dMhp90b0tsMF1l+T0ivgrhiZeSw+pLIWL0SPL2xjqNz/A8AiUTFJx/3/BLQF/D4R2t/bBFY6Whetn43oRN+bUN7DddXF0QKgvvGxdqh7+A+umnK7VKX99aGp++XE8Q50k71qBGRqfI1WcJZ+CkC3PuYlW1Iab9tFiTltVag6Qq16tDTJxZSf97XzN3MDn+H8DNvOczP/FZtn2lZLgQDCibMnRdnWG8M7lXNGotn7Wig42tE9ppz7L+pp4+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UQaISnU8X0PEIzA7DCKJxy4E0qpf7B1LU8OSwKt3SepuCxiJ4M1DxFBmw2NLRSeV08OxwV5HMMgdCq3kz6XSfyst5u0/9q1nIllVf7UtRvf+pnwnwnuLhRZW9qPkSW+lQo6YFs+/OvQSaDk49FCTJw8QCeqT4DveyrqEfndLtwgyU37wFd5j8AOJkfmeB1n0MG2cv0JV7UbOR5H32DGBHuiDPxOkGx/qJLxsFpiAYbzJcyja1fSFRJqZC8eqsf6HUSK+ntQRAeFzqDSakBgfdRoW7JSRcr1Tpky5LZ0R1JO6+HOeO9VLuKiHz1JMDbp15em30i9CM5emHd9CxXclFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qiLGydOlh4m4tdciS8vyL58eVXW/3HTK43mYe2iOlxeh8v0QoOd6thVlPKZMJnw6niFI1vZpYzt9hhh4GH54ubyrFT1qWYe5rBDALkqNvVePdgzcXOShyP39Co9Uf+3zJ7ckS0oVq6O4cSY1xEksRmL4d88n2o//MxmNa/t2i/Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3534.namprd04.prod.outlook.com (10.167.133.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Mon, 17 Feb 2020 08:11:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 08:11:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: bail out of uuid tree scanning if we're closing
Thread-Topic: [PATCH] btrfs: bail out of uuid tree scanning if we're closing
Thread-Index: AQHV43IPZOezMYRVS0u2ftUiMaLqrg==
Date:   Mon, 17 Feb 2020 08:11:44 +0000
Message-ID: <SN4PR0401MB3598F22E309F3930756DA9179B160@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200214200501.2524-1-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86a950a9-4e91-4b44-51a6-08d7b3810732
x-ms-traffictypediagnostic: SN4PR0401MB3534:
x-microsoft-antispam-prvs: <SN4PR0401MB353468C61C80C647A8B71D0C9B160@SN4PR0401MB3534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(189003)(199004)(316002)(86362001)(26005)(110136005)(186003)(6506007)(66946007)(64756008)(66446008)(19618925003)(66556008)(76116006)(478600001)(66476007)(558084003)(91956017)(55016002)(5660300002)(9686003)(71200400001)(2906002)(8676002)(81166006)(81156014)(33656002)(7696005)(4270600006)(52536014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3534;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YrRNvumUucHytpOg0Rq6Rerj6SFnfzHJ5qkH7jkttETKSYEjKjW+bD7jEtL4b2E3C/5soiZYcQksH9zfIzvVt81MVQK/Y2lsfGWqhpTf035x/s6XGtmfAZi/tmwkkf0t6a+mfCvbmBebcGB22qrku+S9vHKuRP6XL8EcXutVFzvYGv19OfDrkeBtY3OZhwxqHBuRdIuTgSTeZg9S2ymK9rrXrrTbVvwYQ5Klr35PTPxWUEDi8qbfzek/G+yu/Wxge/d+eYAFERuDrT1iot/5BybrI2MlSWs+8a3v+DUOIr+5DBxcf4BxtXTXfmsksAeot8hD0sMqu6OC303ilwmYrSgiHzMN2Vtow67V/m7ZRqdEJCDqQ4dyGZQENFyCY4NmGm349MMHUS3zUC5dkE/LfwwhSL609Fnk6YeSgFSGnVK9MxtGqyL4FFI6JR02+3a
x-ms-exchange-antispam-messagedata: ABnVjF7mI2hd5xNKSzx60rru2mzQwjDOcX/oA1na3/vfz+aJP/9ypW3FjOnuOARekcYiFrzBb0lmOAVDa0neKZ8sUDIossCQd7XwPDMyp2uepou8rdUEU9CU7ZGdX+MgmAiPvNcrZWacLsgWlgsF9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a950a9-4e91-4b44-51a6-08d7b3810732
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 08:11:44.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkU1E1y+8l2cC5j5rb5fQCHMMr5DoXL2gHw8I1PW9Qyzymax0fwKcKqJYCGq6NeVaA820eTVHkyCz/C/0/r2NZhTiuDW2ch7ZWkJvSXobsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3534
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
