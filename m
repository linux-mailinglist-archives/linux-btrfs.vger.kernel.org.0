Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7531CB156
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHOF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:05:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39376 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHOF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588946801; x=1620482801;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NpkFE5UwqAkF13stUwymJcs9M/akt9SwT7mHfaCuzys=;
  b=XnDWmojYfpOjtaGAO+qeCmohLt4R0DrvY/+SrRltIEwdBRpGEYPs/5Z9
   zfNXr7NR6mytDkKfjDWw6CGhmoN5vSmFVj9DItZEg5v70Rx144hK/ed/3
   f+OMtss3YUm5wPOY7WKhsBZ32P9+LNrZ+Vkvis5658bRyw9YtijLEzg+k
   fyv9P9bxlHE11qBbyqPjpVsmXHKKkKCdGV7f5NDYMKhd5J80/JUIeFeS+
   AhoxaVP76Bpv9wEZYnUOHrjoKNzy8n1AG8rHwcdRNdcpdz7zLnqGrsJgP
   93u+gyC+P/vGxa3q9e7HuHMB092fGiNgTb6zrj1ciEKnWUoOnln/dhCuZ
   A==;
IronPort-SDR: 057UINq3BAip3IaZEVYycoVwGSgWAFZh/SDOS773LPOfH7x8J6yDALbGfvUhQYaqjYu8R1T3sF
 5GhpbHG77dd2xdIpAPBoDCBxhrVAk+NMSrZRxb+ZOtKErdhHF3/mYEqEpBzh9DegUsj3fcezf9
 Lx2CGneLiV9bu8MYxIdvdk3Jm+8erOd/3j+1ObKjxNt+2SLnuEXhj6q+KbpMf/XQP0CBeJ/KjC
 LZMY8hEr0y6uHI8FcZcEnNN8D3c/8r5ZeMtyv3yy7AXai3oXY6cjDtulSYgDNzBZTZSz1rZ1Ci
 9gM=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="239886016"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGwhGE8Duc0B2bcPHHyQNysBK3GZTd0y8T5HGrU54kyPx2Xv6gikKkgNwcF7CR38pC4Owg5g/1EWF3tOTmfAsu2OQAsDVS1Us3QTExiFQM+VeOu+MhUKkVJkbKt7kqtM5vst4MHnI2KDPf8RPrHZDEP6PtORUFrBKunS7lmMVJZTyvoFs8CaEWnJ68ZLgbrtrfgk3LtaEEGIutcxthaQ4GEqt9HkqDVP80KBGASl7lJReu8m5k2MEHghA1OkaXqvF8xyWDJ+DUZ6GLa2guRecXXlmY/1Ya/nmjrRrIdDg5qY/9EzZ2zz8//pBMalYmbe1AvZ27oSQslTsZN/UeVp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpkFE5UwqAkF13stUwymJcs9M/akt9SwT7mHfaCuzys=;
 b=ZYbBUHj0vo6zK5tqWcsP09d5LVg9V/Ie+rSbipqft4m/ch7GxN58MejApjHF4szP8ZLtMS2t0Aj8dk7IUiPXdQwsbqw2p2FLKFXAmIwYPFYr/rBbu9OSKgurY5ea+6WuwbeB9+dh0H579osqCb/1S1NqLEcjllDUt4ziGOUZrUJsMkWijo2ebKEisgYUU54q8aGtRKKGwubMIMWWdTpx0xrRS15znxZ+rM3s3hiwZEEjllSOKT7DlTiPheKS3v+pqEFszCsQrIoC/BA/4F3YFRgeCjbcA0pRzVhQliM6FdLoSG+8YdjK9KnMBVeZ3+dz8rCppJdyqdNKHvihh8XeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpkFE5UwqAkF13stUwymJcs9M/akt9SwT7mHfaCuzys=;
 b=ZxWweypuOo1DxsWFfWlE6taqUqx7+5kv5NyTKubZjiAa7YuzpGS4y5qLm7jZsa5OdKRGr7JFCdH5Md29pUe76x/+PRFP/nUb9zU2sBpzgzmUmBCO2zZS/ZLzNGSJIQ5HSEp/TE2vA8fcYRaQXk24Pmr9wTaeu3wtdSg2j5PK0CY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3584.namprd04.prod.outlook.com
 (2603:10b6:803:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Fri, 8 May
 2020 14:05:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:05:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/19] btrfs: remove unused map_private_extent_buffer
Thread-Topic: [PATCH 12/19] btrfs: remove unused map_private_extent_buffer
Thread-Index: AQHWJK0BiDwG08dL+kiSXYq8yUfmfQ==
Date:   Fri, 8 May 2020 14:05:54 +0000
Message-ID: <SN4PR0401MB3598B2149241E3804359A46A9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <301e4ce1e53eb6044ceb412c44ff439210911491.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5bc74f4-0509-4f3b-2d4b-08d7f358ec99
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-microsoft-antispam-prvs: <SN4PR0401MB35849384E1888E9F1A659DAF9BA20@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDGixqIMn2jQGt0WnNDaaxqYfNPzXcmZ5Dun31IXmfMmnFO9e8YL8OBA9OWCrSxl4QH0/kaJQ6pm0fwBFq/MbzVrfKkYwthbhI0EKD8h0twO7hLugtvUXQ+pTXstNEGcx4EYlimTg6u0TL+aZHBVLT7YSnTXGx39uFvNeOKozka7SwvEHCHndLLp3e8MNzQ23/Z41Xp6GoNiG36z2V752VUs/idS56ScmDvJOWI7hTb5wMHd9Rr63MtdUpcl8L32Jjv/KN7G/n+5kjfborYq6G+7saud/JvUiXaCrdgxpWbvBnhtj+Uvgxh+5o4aVe6/DvkuycNeDj05XsbXRVlXNE6ykQ0Cvwu1qK5ux4Fm8Yi1uTPqz+aP0MAamtTcTHGcJ45CLEUt3aDL9Q7cbOwUXB/nd8KenJoRAWMEV4cmq6/ACdR4+Dcl9mnBxBYym5unFkCRfdKzohzPgNLHRqFUECtqVJ7WFYbt8X/VwYYFU3jvxcZmL0qVpaiQsyPZYgCUHBQxVZ+q7yp9W7US2HVACg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(33430700001)(8676002)(8936002)(66946007)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(52536014)(33656002)(33440700001)(83280400001)(478600001)(83320400001)(558084003)(83290400001)(83300400001)(83310400001)(7696005)(26005)(186003)(6506007)(9686003)(316002)(55016002)(110136005)(2906002)(86362001)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zwulwmlOyVNzHeisRCCW+9WlLHfWnh/0R4aJwTGzowD3ZTz7UXf0UmjcBpOxGs+Ume20yQS1UIE9jeicgokuZ+0k8guTI/iwYLoCvmKwRkmegydFoBgjdn41oMdARvh6rrHZkd3GfBcex5BclsAcMzI9VI1LlPZ4/B5m6iIVl3nIaMP+EFc5trfhxuniAMCAN5sEXgIuZRs2C5kok8wrmX28NpcVu7eVAhkM1Ps2X2ppF/oXpObyMWGWJ3ouRWpostfrZV42Ojz7Pa0SxBLd7kp8sJW9DwIYiShuBut8KmTmr8ggFJytr7JeVJ+1aEq89H+J4x0TPSGiXyqc+V6tCYFGKT6l2IIuHKEcaHUpFPxfLqM5ScLd1ULiU/pv71f956smaCbk/ST15TbKZ/22ASf8C7SnGr0DNB7160G81TvWue7bYIXADHnqcgFFgil8OE5mWpxhPvhoOW0X6SDw8Dm+UZF89hyc6mSuh4R02CL/7fDNwEicghfn5a6NoalB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bc74f4-0509-4f3b-2d4b-08d7f358ec99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:05:54.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeGigq2budQO5UVTLBQMWrVSmJ9ihLylPfie3C3sfBV9AbBuhQUBN4+CwEcUDWTgPmJmmrH6TFyfokMsMzqjXDa2czArVS14csIU2ixnspQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So long and thanks for all the fish ;-)=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
