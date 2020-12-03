Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23662CD0D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgLCILG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:11:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58306 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgLCILF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606983065; x=1638519065;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IuUefpezfOFeSYX1HuX7d1iziw+lfo/c5qg81nTmb/s=;
  b=rH9rKI8rM5q3Lo4yoazwdQs1dtbHzm9Z0LmoNAjuZYG/u4lmL64lWoW/
   YcVTnLBA68JSDkUDdH+DA5kR5UbsPlvZVhhJGeO4wlVQs1lkjWISZU4MY
   b7q4MPUSmPnCaAVZt3tOcVBLQlhmsOFmFB+mkExkfalYdbBku0W5MNvOw
   hB7fONxnbsXFu/xk3zz0S4ZpApZdxlFjg8jJTXMmtOKxvWfNLRhU09v0C
   h0yz+W4QzTXSmduMFOasWs+H5D/JYjz44gh8SGNHHuxWRyip9m6916dKZ
   2Eh78TMLL4FUtzrAmNNtndRH5DJfaH+uR3pOPE9VlAcM+oPvcUtBCqoIY
   g==;
IronPort-SDR: 3eeW3C+0Z5K9IbDixzNqqOo5avouF5ecKtg21jUcvfF4C46yD439OwLydRxy5LB3RhfRcfFWbt
 eoBgMxudItIWI3oCX5fKGacSiUPxOcv4csfxlOMGYsL6adaDfOkgxqldrInc3mZukN7V5uc4qK
 /cBi7ckY7STmJykR/LCP/+5Akgrv/pbb4lqTMsaHC+q9tM9/WwtaS1tu+l0MSjfJLM2Gf3akRL
 AOCmT+IuD4xFwgaOS/bj1CYMTYKMwuPliFzby49AlVmW5/HvATBFbZvIYfvnX70u76RypKfTnf
 QiM=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="155440844"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:09:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro63i0gPa5o46aAqlfnzimshlxl85Gx/WAEBlKnL6W7fAnh/7AggwLtbjmBeplmKuM7SCnd0/nSK8kv+d3aFWidHPbnPV1bkeHAFuuqtfDafffPxYwO68ALkbHpY0mGrdwIMKpYGWYRviem0YnnjtTRv3IO4/AHs3/YRJs+7A3mOfHnmbqdL3M9SSiRnYPZV+RSfcgUMkVpbYBxMf1dER6OW+vrSSzuBUXC/Khx7Py9g26NyGB1Hw0YyoZo0SziuQial/Kt7/+AGaOLccjAcjluXjAhH2Q+eOeCtaCu3wJob0bEDSe7Sg/QzFrJLrZA5B8E0IEWjWODBuBl3XlD4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFq+lHfrGSNoc8evvEDDGo/o2TUT/9/Bao7WYsI3clM=;
 b=XLvONhViBA8fRvtUPjHYB96RnJH6yKrfcOMkghzf/+IhV0iapiH/EsUZNVuAjHIvUIJpxdJ+b34K2tRwjatjUJqVMQtSro8I23S+z/jwqReH9tzyLWkaYRZ87xHY54pNxexbcukFdPoUY0Glau2/Lurbeb5A9yXlBhoTeKdffiOCYaeUZhNRQPE4M+m+QbYzbjLm/9gWLR4pXka+um0F7zIKRgHo+G6aGz++eYxVAcPB8NcoTUn8A+tuxeD99VbDt3yqRB3Vcc6tKX0MfxqFKbK4V4ACNRduSpk6/LV5NOBhqTTWbWAVW9484jexGqffToDlNuHl3lDD28ZsirBC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFq+lHfrGSNoc8evvEDDGo/o2TUT/9/Bao7WYsI3clM=;
 b=s+QD1VZrvyqdT3MEudkhShUgoDtfGEoxMcYOwPRkInjHsh6oPs2DVbjsmeKxqFeGzvi7j8Ib8fvZDn19jhq9/KLaemQsF85pPF1i0DUAqq8i+HNwu3gKymdWZcfQzIYFlwlPCOnAIkL5bPZFMYdIcg8DlKDfoActh7lgRh/k7u8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3806.namprd04.prod.outlook.com
 (2603:10b6:805:45::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 08:09:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 08:09:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 01/54] btrfs: fix error handling in commit_fs_roots
Thread-Topic: [PATCH v3 01/54] btrfs: fix error handling in commit_fs_roots
Thread-Index: AQHWyOTzhSXy0TJY1EKB0lxzv3aPAA==
Date:   Thu, 3 Dec 2020 08:09:57 +0000
Message-ID: <SN4PR0401MB359848C78A336C2C34A3BDF99BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <502d2273052e95e19366d785ee85e542e86fe61e.1606938211.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:10b1:51e8:1aa8:b188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c498f331-45fd-404b-0927-08d89762d307
x-ms-traffictypediagnostic: SN6PR04MB3806:
x-microsoft-antispam-prvs: <SN6PR04MB38068BE4EA3FCB6D3D74C4799BF20@SN6PR04MB3806.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRrmsSR4MFe7FHUMqIed9CGzbmUDbB2C/Zs4EDGRAWiOtomu970kflYaInAtunmXRz/iV5DSVXVH7amoRX0IiGNDrNewoJDA8sIokRULi7xAGpKZ/7EgqVtB+9vrs//ZTCAVvFe8Le0zTAei9APyU4+VFx2zSxB8nb9FM6gkEPN7/8INV3XR5FrQt7fwCPVtOF93KEBWLrfV7gcq4YGeNLUGcECrY4uWWvexb/urXlECbMQCY+KQyFVQeJyEpBX2LNlc22CBpIRq6pgFvortdt5PK7hzA63FYkPeLR4m5Yz/4/8/kDT4NIOYOBDWsNqD95LapDEp4IwE+Aff3GrHGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(478600001)(66556008)(66446008)(186003)(64756008)(7696005)(66476007)(4744005)(316002)(66946007)(110136005)(2906002)(71200400001)(91956017)(33656002)(6506007)(53546011)(76116006)(83380400001)(86362001)(8676002)(52536014)(5660300002)(8936002)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r4pfXqUmxUsmm5vUVEwTvdSJEp+ICZdxGC2vXZEBMEeGSe+j7KgeQGPLwA03?=
 =?us-ascii?Q?aF0ZVxURdPJwCjyGdrHo5YBq1ebjSwed6AWi1M5zX6hpC+nj+K+P6zWKTHTX?=
 =?us-ascii?Q?u0bLcoyqoOC8X6OBAzltcjFA09YwQ50CVwh3tqq48dFhZkKxcX65LSIwsoTk?=
 =?us-ascii?Q?2aaSwc6WczHCYyakUdruhsR161PxWXVKrgLa4HVhwb9OGrJXNSb8BWT+kY9X?=
 =?us-ascii?Q?66/rGrDT9foBwgx2WUOWOW/kLr96xhNr9ZcTxETJrO9Z4MIapeAtkp/8x49q?=
 =?us-ascii?Q?GZ4pgUX33+L5k/ItbbnNMbZfvnzM872/k1VT1zY/wk9LgkkzGXOU58cNEAeZ?=
 =?us-ascii?Q?rr7S30ZdK2ahwnbmueBeiFxgM4MP0qgZU4cAPccYH4Yeq79DWyULY/ka4NWl?=
 =?us-ascii?Q?xexkcBLY4e4mj+mqq+vQhY5XefxaNb+FsV1SspiGLgvPhLIMVMmguAplARUV?=
 =?us-ascii?Q?YRFuLu65t3+AFBuwIbowBFyHJb5I1cCiKOvVoID5nCM2tGYGBM/oChWDHY5r?=
 =?us-ascii?Q?4toCPTC0G9N4Xm49v1/AbWi/bAJ0Xxq69DdPJEHoZ/o0DlT67nhIzZO9TjyW?=
 =?us-ascii?Q?ZqBVaNSYvo5809CQ2x+IXpKUhErFUq+tyPQd/EB5iejllRovEIZLiP7EKsbL?=
 =?us-ascii?Q?uPCPwGhqHv/ET/uCCZwYM87/gCib2rWbHYaNk9W/qm1IT+0GFXdLgxez3qY5?=
 =?us-ascii?Q?aOmwe10n14BVMl4gTsuoOC0THYsoigfsU+OwqSPlnYw+vTfnMC0T2kpAIt52?=
 =?us-ascii?Q?URRSiEQ7oayIEt+UOrvlOmoxAxHQdKehCEydnQ88aDhfKRrBr2Y3J8ZNDVMp?=
 =?us-ascii?Q?DGZT08g38/IdH38YOEkc/Yb41MfE/YTb921q0Pekb4RSPnZlvyS+Zm0X3qfb?=
 =?us-ascii?Q?VDVY0VJG9NZXifwrclK6s6Qzy+SqkzwCY4AAmos/ZE7uriDD/zC3DRUuhCUQ?=
 =?us-ascii?Q?3ngZu3HA9T4W3MBkTJLPnbHkQeoqkilBEPGpDnnUp63nAhaq01mKpNgFcVwg?=
 =?us-ascii?Q?AYx9ydboFybHp3ViJ/sb7zN6h5xcMGgdSP1+dLsK51vcDD+ps4IgMW10HCNS?=
 =?us-ascii?Q?zDgOz1BH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c498f331-45fd-404b-0927-08d89762d307
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:09:57.5238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7OxDZHVvb+IRK2lHNBlvcyLXY18ynNoRrlxj85kRodJmv3sSubA37d8JFjdHwjgFY+0hV8noRlOQOt+LNVbITLycOR9xWUuCVhdHasW+6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3806
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/12/2020 20:54, Josef Bacik wrote:=0A=
> While doing error injection I would sometimes get a corrupt file system.=
=0A=
> This is because I was injecting errors at btrfs_search_slot, but would=0A=
> only do it one time per stack.  This uncovered a problem in=0A=
> commit_fs_roots, where if we get an error we would just break.  However=
=0A=
> we're in a nested loop, the main loop being a loop to find all the dirty=
=0A=
> fs roots, and then subsequent root updates would succeed clearing the=0A=
> error value.=0A=
> =0A=
> This isn't likely to happen in real scenarios, however we could=0A=
> potentially get a random ENOMEM once and then not again, and we'd end up=
=0A=
> with a corrupted file system.  Fix this by moving the error checking=0A=
> around a bit to the nested loop, as this is the only place where=0A=
> something will fail, and return the error as soon as it occurs.=0A=
> =0A=
> With this patch my reproducer no longer corrupts the file system.=0A=
=0A=
Better to abort the transaction than to corrupt the FS,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
