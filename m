Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E11AE435
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgDQSEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 14:04:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5290 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbgDQSEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 14:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146640; x=1618682640;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
  b=aYfTfysgasJcjjPOMAX9Qy7zyKGwoxER4ZQcGzJL5WLcr20rAK+7ahqK
   JRDh79ZUEbv8MwttLOULlz3zGYK94/dIAyKbWJGitkYVmWUnXcxcEoNtL
   nl4OoN5ux0q/tiJzfXNv9OCzA0AS/xHdAj6YdBBS6pzWbJ/Q45U0qsRUA
   P+TFB2SQaKg1zJJYqtaAG5McjAY5/ng+crrnQZIxpmOVijxzzv5MNRaYM
   x1wcxwPcyEjDJQHKUKLeUiR0/ecGbTkmMxBDTLeX92jXJuBMlDYNyJkzk
   6yxXPeyhTxM8G/oZDogZ9rVfjW6FHmunhd2yWxXwQEx3CtCAkiPwTPs/n
   w==;
IronPort-SDR: T5VlqxBqCock79QPrKyGUWWfSQxP2/EgMr9ZMum2oPRxDRAfZJ0p27q/2f5IoqRe37lrk850zh
 5gyJa5RR0UpivaDuxDB4Dge21xHRNuKG/jak/gdqgiejhgmpXEQ8kf23A2EznEJhYU5d72eLZS
 APJ8abg0OglFOGczLrg0BTu2g2iriInk7RaRz9KRpvfqXW7IjLI75P+tMAsB+mgYhAEoYJH5wu
 3CT5hVhG/NHY8Ibm2Ex5WGtvZoD07VxbETYfAJRpiNI/Ar/rWcjW3xvQmw6FXHnavaAZRALTZa
 TFs=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="139922585"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 02:03:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOgQIfy4MkDmVhZ9kDrP7SiAIdg8Iwh08/2ypDyHjXmiEbpTYtoat+2epiLEUanLPfsJ2NCQjJmWMoWXZ+rJ4W9lFuMbxSRUciDnO0WAT9p677mJgML0gIzQLd20Eu8W8d0aQ+RflCHTQgbWDn23tnVirPIOUAQe9mBrZVFulo5BiOgm6IGG1Aohp30aH30vBrKBcsY78NDAcSQ6AMpOnRNvRm8AfLhpO2Ibfzhrcs1e/j2ehm66iFLHuuj+228tJk0FNNwV2NZL4kNuUUjn7fAvTEo+wO2eO5J4v+UL7uP7nE9HdIugzu3Hk30OUypIswxKDmVvaVlSTlU/i5EvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=I8a7K/zvh4qaPCEmyprsx30FN+CAC68+nI4oQzXbwzIOE/sCcff2S39Mi4FR8z/djlFpbj+himDDcy8H7n3e6nzZ9BW5lP8nZ02a0UdkPOD9PUIr9ZTG33dpapBvfx+g6rscfT4VYNVxq86F3CT+DlIe9hQp7ANoCB3Neq/7aZimygS6iLPSJb/vQRk74ay+iyrvgBV6rKB4jHgj45blnkzSLV83yWlh12Sgwv1jyee9VJL4JRmKx9p+TznyKpcgRB8pEycnfyPKrdxNRiw2nIniZkdJjhGd9RTkgGnIYL3N9KDQMHdb79ZxFwbERA/u+ch/HGIu45k7iOJJ14rYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=0LcNqBXxXPNP2U6O6obju41tVul0YCAK3SiE9uaOF4ZVKbTvsd5qzvm+yegmkvakLG750BR2ka9P80weDFt5ve5mqyWnW2NBQb3+m+RI03Mu0i9nT48NLWoYiYLfbo9b8ubf9J4an/03RZqs5GK5UM5OfMIAUoLP7/Ana1+p6Bc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 18:03:43 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 18:03:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/15] btrfs: convert btrfs_dio_private->pending_bios
 to refcount_t
Thread-Topic: [PATCH v2 10/15] btrfs: convert btrfs_dio_private->pending_bios
 to refcount_t
Thread-Index: AQHWFDiy/YwCdNJAEU+/r/7Cegs2kQ==
Date:   Fri, 17 Apr 2020 18:03:42 +0000
Message-ID: <SN4PR0401MB359813C63E0CA5D3003549A19BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <14a8c9acc19ad08c31615616d007cc23e70ae0d0.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee2d657e-0819-4c69-f49a-08d7e2f9aa6c
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-microsoft-antispam-prvs: <SN4PR0401MB3630713CCFF3C6E981DA06DD9BD90@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(4326008)(478600001)(26005)(5660300002)(66556008)(66946007)(64756008)(66476007)(316002)(7696005)(8936002)(8676002)(558084003)(186003)(52536014)(76116006)(4270600006)(33656002)(66446008)(6506007)(91956017)(54906003)(55016002)(2906002)(86362001)(9686003)(110136005)(19618925003)(71200400001)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pz57zRFS9CKpsoA9vS8wbjgrJC7JT3xHnDqd/umFvDgaxzlbrRNaM/zi7pKDbxFShmqaOkN3xegEPe6jTqyH0KYFTxt1XzvnBzDcIH7EvMBxY0YfnaQMetT8o4N5kPNzJSq6/BF1u32S0/BvkGD/qJtu8hq2AnIs2pMdLioZoubTItH0E+41+hOfrv6eCvdX/Uk4yj0xz1UVe1Qc2/UH4TDCgpcMV24nc4ioEuDNcdUxm+z934pVOECzwSE+8KNrimFYt3iaU2xT9v9KbEp22BzAk69rsco4Am8kPZFBA3pBgZ18Upkf8xukMJlibz1E6oU36XPuokSqYP0r/7VleCu2Bb1LusDaVWaUB2k5J8xJCpQwUn3DrAsMkpoB0+NQ7sTgq1LWwcZjWoroEOPlwolnGRJR7ZBPD+G/1k63tctdRDbJ/1dH/PgR7GAB7waO
x-ms-exchange-antispam-messagedata: ZKBu5A176iIt0dUYMSLeR+H5Y8cgbrsQkAhoPXhvVUZpRWR6Sn+ugZBOxiJ7gKQnkqlnqfLu9zNXDw4cSB/Shny9RpLRWRvUK33yegpESFmBNr1Tw3ynSb4BlfFpChs0rXN0VGK9qNxYqGcFjANCvA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2d657e-0819-4c69-f49a-08d7e2f9aa6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 18:03:42.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfty9BZiKPzLuobmzv2alSEvaalEf5ogKqrU8isGY7BZuTPJ1RVcrRuLnsZpCuVAuDGqoRW2LafIjyTs9vDc+DRK5CThb/hhOvxEZAczLxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Easy enough,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
