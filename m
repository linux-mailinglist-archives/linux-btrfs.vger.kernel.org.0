Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC22F172B5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgB0Wdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 17:33:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28796 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgB0Wdc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 17:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842812; x=1614378812;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=iFcoNeZBp8igaXfxjnYMTq0ITL1/xQGExbtr/TnbxFXJyL9pxzwedSpL
   S5cOsBUqGSEM2Dpgky2FM8d138Qe5COG+aNeQI3IBveMLHBZxZj28i4QC
   mHZe8nXWx775cFkVJ7ERpruoluSdTqcGFXuUv+VFRDtSK7ywI9N6CAmEQ
   E/JD5wGvMX92ItEy4+l78X11dk6ddXB50k/KarmvmeQaNgGVwOPExyC7O
   shcUKygUJBGRvdmJtX2N0htV63R3yitoph4Mb/ygNTVavXojTePHDi2Yt
   pnA320o8nKp4d8QAj5ojjQQejv0VHg0RIfSp+0ApUD/ydNlI5f9pRvRkr
   Q==;
IronPort-SDR: fTt2SZ1+XM/rLNovB6yll7n5kgpQYd1rfWbL1Uj6mOGaSK/l+bjxMoWqhz9YroWgusjJ+aRIh8
 W1PTY7kDnc6WKVi4Q2w+R/fR5vfo8SpcdFmvSTCOJqWqTY1j0+CMoFrxZDowKF3gli8Zfp+EXt
 Vfq5NOGX8R5n4Y/k0G40OUrxw9SUkn5gnWUW+oflGfNIMxu+5IgR/c4RY4hIr/tm/To5oIl332
 wncb6AQBEGPqVX3ZwdC+8bP7nM8jo10X6UsZbVuDxNmY0o6lKYH7InkYXsCUaOf5gBpGO0xLGY
 tdk=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="131460401"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:33:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOXnpgCGx7oXCB0HhC/OG2QMkG4GgQ6VxNp94YicIusCLSST6l3fzMWI+GTJaKDLpO6WNagnNnwz9UnbNS4G2jZ4vnzjztng0KsUasmyvw7FzCuA40v+qSN9ayfit91LG8fnEps/rUqN+d2CIwpCx0C4gA/evygS8vZXn3dOaMTSbJreB/JZCw6BnuXMbTHRAWm20zvw/Rk59CR17UhnWdmml25s9HdXfEdyuXcGQc7LwVTHyx7zD0jrCfzgnmqzFZgX0V8F+/YRXVilvFAtGh7NjmhfufSzOJz+qOL1GCTR634D7JunPpyyX/9Ix2QfWHAaObxNsvl945SRj++yJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h0mVffe23orkC4einTF6kkZN12UQVDp/K2OUOMWpgG/S2VvJbP4SX/3oUibMPKjXDr8aee+O8mSqxmaoxJpmwYUnb/tb615vh3wZtsDfUE2Th4g0ThWM6+JKXKph7xTk4Nr8tfQi/guqpQLpWpha8f+CD95hhw555MJZKn2/mLTLPTFNkGie6h4y9uOnXGJAlMP8ZE5M5WHIz8Cncs9udifbeuA7dvG9pybgxwla+kJC9syplY6QhP9908bTR3chXM4xaI37i0IXsUc10Xd7uixvykyWgoUEX8gyq6Mw2S654IfP1AP+qAjp96/HcFRPg18aJLAEqLgAzqsewAo5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DBoaiBxYcnoRgJ1wiNay9NdmTg769YlblkquoSwKhWYDhwdUt/mT5gMR9ClUnD238X7YEIAtLhqHiYAFQEUIrhmIxP1/J3DeQQeWZZTD8+ez+fShsFXN+cLoVXAtUW/FzQ9UkkywFg8ShREETD7LXInfeMNZyP89/9/HPaqEWss=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 22:33:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 22:33:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: balance: factor out convert profile validation
Thread-Topic: [PATCH 4/4] btrfs: balance: factor out convert profile
 validation
Thread-Index: AQHV7aitDVGUdo56G0Sqbwb5cG78EA==
Date:   Thu, 27 Feb 2020 22:33:27 +0000
Message-ID: <SN4PR0401MB3598FDDE538C09B73269B2C69BEB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582832619.git.dsterba@suse.com>
 <0432001929a87bd8fc75019ca67257d21d1b1315.1582832619.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97909746-f3be-447d-e53a-08d7bbd510c9
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB35513C37E0FB997061822DA19BEB0@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(316002)(7696005)(5660300002)(8936002)(478600001)(4270600006)(52536014)(71200400001)(26005)(6506007)(186003)(558084003)(86362001)(81166006)(2906002)(8676002)(66946007)(9686003)(33656002)(55016002)(19618925003)(66476007)(66556008)(91956017)(76116006)(64756008)(66446008)(110136005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3551;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Gv0YKI2IceU9jQwl3OTF41i4Wv0kaoeODjJN3N9bB7uJQbFX2Bp3PpySUwSxvo5sxqkGYuZSfqjAluJ31+PbhrzVVot2yFVqmQA48KcGVEBq3nlIVUusU7ysWW2/B1pSBUUQODQc1tz67oUm79harP/bSMjNCsXpwEnEGVQI8cmpikt9YVjn9YQy1Y8lSmeDCirLKp3TN3nMBIZ0b+qz/230Xf7V1VifTkZfzsN4oWojhrMY00E1NKopWpbn2yCOOw0/MCbHJmTf/jP6D/sVtXAA0C9q6Xieo1A5gHNguoA3IxdeziSD28b7Kon+lf6Sh3fO+CVygCyNFDP4Y8u9eU5WdNA73F2SGJ9mKqqvJxWIWCyAqCvonVOpABtNgD7FiWGymxNou1TFj3d6ibTykc0Z2F4ph+WqP5aVaRIc/RFh8J+uKwityWZNiamCy3L
x-ms-exchange-antispam-messagedata: P7CaFs0aIq6RMcVGfMeNCpuv11T6BXIe8aBvf2MHVNnP/1K8wB31riCrS4zfJFmSx+lNdFCyhpkUs1t6mCkKOgO6oPzbvhqp/XYv1kJB3EVx1wOZV9EdyZNeiY60mX38bg604bnhvTxJUookiX3l/w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97909746-f3be-447d-e53a-08d7bbd510c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 22:33:27.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjCrBLqs212eObIlVCwdhv718EW38sCGx2bUaWv9S2LcHHy579viDI4zFESPBnElG2BICOuCVTZGftLDDzZhQvXa1ZY5TgvQDj8US8jZgmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
