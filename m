Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4F32C542
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450078AbhCDATw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7962 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359401AbhCCOTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Mar 2021 09:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614781146; x=1646317146;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ysT+gORhwXqTx714K5K9Yixa25b7eifBd6NYgGYojmM=;
  b=ShEZXvbUNbgx+kQIVGYyv/XcDyPn/fVRuMN2OV7iBjSF8wbQTazXhqOQ
   zTc6KktCaCLViX3z2+3QCyktvchmPQDZb6zqwqF3frqkxYy7tOPdaCXpF
   gBguzJrAXLG6iuQx0ZLvHcHytwBe6a9h5HrvqGqN2tRS2nxxVq/fGXs7i
   Tl3iG+5dUOUpqaN98jizW4W0laqnsScxn0dywuwl8FbJ6WYS1lu9jtZyq
   Wvnvi/28PXW0Nem4bpgBH+IA/PB0nAVsKNINY+ZD71ZqyAG+tO89+3/w2
   NVD7D3Xwv1rOpF1TNub4lVmr0zd9iL/TTPivDEMFUwQcOyNsSbIjGXJLx
   w==;
IronPort-SDR: /P38i7sgBsTsRWt2Wjt1tICBWDHRw79ZBVtu7byr0eOgyub7QFdjki7STFGR0D/DZ6lxlygdTA
 t4YlwEBP0hgN0C8BKx1eUX+1iPCjyMy0dADA02Z1GI1UZvEmubzFsiUKRIcYvbDoQI2XeWJ839
 spkwFAL5KtlZce0haKzbbCKTj2SYsnk/2m6SDcW7yS3Dlv+F+uOiyArG+hAqrSl1nEUYjsKUB+
 a1+Xs47t4qu9PsYwaXt0HLBUVtopLbfG8pslldFRDc+6ylFyFTKGtZ94rz1n/VV79PFcbU/Uir
 wkA=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="271878621"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 22:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/dtOQO5H0ulx2VXS3FK36m+UCepN8A/Em9qxwUa/dXEzczC635YI8I3nYrAhi93+dL3MKwm2gZfj8f3yp7qM+r9hcF998Ka3QNMt5tK5p9A8XePRtaNJ17jNLuKATAvIo0QqfRLAJXmx/oHftqg4joaps55hSPfA+yvbel4tK8A3ySlt3dV6e5UozYEcVMyav/45u52sxtXomvW3udIwCDJE/XXdlDp4geTHVDCvpQCTN+p4H7zmrXjoKlF9MmG2UDiSfhvFZvbRr+QMlAO2Pbd1C1SJLrO5f0p3up4g2AzKltkTWN14m90A26+25rdzYD2xdrd7SfOSOJ4vOJ0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpB/iCIPzEo3MjVb0C+7BqNRi75LxMthE6yqRctWRqM=;
 b=OyBdtyDzhslrugxLXaDwZSf3IGTGpq5Z4tqhiV9qvDAyldzxdlsWXHHN362t1WuB5A7CIMvRNXPRoQekvqYDZqdUoOAKo5IwWTuHDgzCawa2h49bNzuVIq4avoJVzxzcBBP2edjWkTRpGzNuHOOX1ETHm4PAq6AED2n3rL9UNILfduRtA2E1e2xch9sinFuIqSY96bab62skMy8DQ7smD0YlCfOvgg+VeZ44VLNSuPDH09Qdh+Gcat/3dCqSrnxlpwAd3DBaboVQbXYAZm78TYeP8wgMjHsVrd9VrKgtr18PU85hPvN9aop1YOCD3De5mGGVz6K7XeJKj++7C+SCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpB/iCIPzEo3MjVb0C+7BqNRi75LxMthE6yqRctWRqM=;
 b=ergDvo02xdE2PmqjemriPJvhzkW+GLGY6k7GgAmlThOQMmREaHaDigo3cYu3vKQaaqR49sHq1LcWTmLB4AF3yPoN0Hs7qNphyOnsbVaUeGQIdTYPDbT6khwAmDYOzQgshhwMJ7QVZS/zZMxT8BYF9rEI93u9EDiyhUtcvP9YlCo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7237.namprd04.prod.outlook.com (2603:10b6:510:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 3 Mar
 2021 14:17:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 14:17:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: fix nocow sequence in btrfs_run_delalloc_range()
Thread-Topic: [PATCH] btrfs: fix nocow sequence in btrfs_run_delalloc_range()
Thread-Index: AQHXECxZxq2Lgt7unku/+gCs7a/Zhw==
Date:   Wed, 3 Mar 2021 14:17:56 +0000
Message-ID: <PH0PR04MB74161EFA312CD9F7B58C61309B989@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210303125440.lub5c4qymhxo7mgh@fiona>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ccec:1858:7740:59e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67323c6d-142a-4c9d-9422-08d8de4f2473
x-ms-traffictypediagnostic: PH0PR04MB7237:
x-microsoft-antispam-prvs: <PH0PR04MB7237EAD524B4D51C2DC8DC9A9B989@PH0PR04MB7237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBudAV5rfgz89XbitliQaDZxJ8HRNaWnvyyaq3PMLvE+fL0eDNcGq4Qj1i1r3RaPcyxEIYb6eCE/7x6yowOmvAgTD6P0glQWAEsEBn55wSVRLP0GPTT733HzwLiyulzMkaolD4zElk7upBR1p6YOlww1S+tfVfrEkz3X0jEtgzXNypp4wzxUw+cUW2VHJPX95miRIDVF1HIIPcDwOv0lFUWlu3MFe4Hrr8H1CBvD7e5PsV9p/8A1ET26u6Tkmg4ACRBWxosu9s4bOeJ9cWfb8CoqpU9yIquR6vMppvHlFMRDnmk6a4K5TGLjOWaVuzwU3muGTCMdo3EiY2Oqp8PH/Ll1y59+p4MSByxPTbbk+Mu/Pa9XXpWsZBfcLanIVFT/dEjha4oJaTcvP6MnXrbllxSkAagO+qrDKhWdmZO1B7a2LiplRZ7Iag7Ahi3kaJa/3m6jIQgAo5YSoNkRBfPa3LDaXcD+QgGiM4zOaPm1ovLQ/YhjD21NfqGSFub3MOHkiGDBJb7Zue0HrChiKIYyrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(9686003)(76116006)(55016002)(4744005)(8936002)(5660300002)(66946007)(2906002)(86362001)(66476007)(66446008)(91956017)(66556008)(186003)(53546011)(6506007)(8676002)(64756008)(33656002)(316002)(478600001)(71200400001)(52536014)(110136005)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fTX+TyAdZ4Q2fgNkk9iOz42Lmo5HuKUC0mICWvsnCYcuoUgDYV1qdpStNHxe?=
 =?us-ascii?Q?S8vRv+/wlC83rVcegYhgh24axe3278Fy0DUMPEKx6hJ+5EmmlP64pmMYuPhG?=
 =?us-ascii?Q?zZhhUbv5pjkXv0Qb+iVI28fAceeqTt0/rHuaAUJshWqO3gSKoX25chj4+iYh?=
 =?us-ascii?Q?qIFnMELZ2Hv45lhmE+eKogPn03qi89W8ymHESNfm1tdF7gVCb2Aw4FzYakNt?=
 =?us-ascii?Q?9A27xGSllZzt4QJ1gU3LLReEStSWRtNFracf/rbEdELxnvZb2BYOpPlaaCoC?=
 =?us-ascii?Q?ZtHr9IXcoN3JX1POKrkae/+qmFczj2q4jWyIWEqf9ej5CBQXopcjD6gP23qW?=
 =?us-ascii?Q?NxDqxk/JdOWsByi303ChfYOAuWukGFqFii1s++5QIrRIDW/oIl+rTHna+K3a?=
 =?us-ascii?Q?ASIFjWZYOO4qvHNxYoIK8/+3MGuFEUdmTDIAi2v3b4oitHSYx+oul++ILzqY?=
 =?us-ascii?Q?4gAM2QIFvQ5NeKMCqZ12zGe+R0JKVGZWkAuoDOIBovw9ve+FNGN3MMtwEFyx?=
 =?us-ascii?Q?Z/VEK1Kl53vPVGRqPvbRfPafehvni2jF0HxkGgkgMxPhSvE9THeFooKNLyZg?=
 =?us-ascii?Q?D2lLj95zhwuDBND2SDNVh0rtiCKIxOA7i/7jybE/gV+P4+/jNoHGpLquXjsE?=
 =?us-ascii?Q?YieubOiOr5jFZC+1nGWPTuBRNyutySrGPKI/GuuiB0zAdLE2Kg0jrcdmoGM3?=
 =?us-ascii?Q?HHKxKNHuor3jpXMvv9nawM9sHVogymVcbcAEL6S35Rp0UAoEtZtKUYNFHF3h?=
 =?us-ascii?Q?D47+MpcFRqId2KVvBNrzVi+/j38AkHKnEtZp7Rw2Ugh17TYDouYfTBjZ+4Pj?=
 =?us-ascii?Q?+mEsYrk8cz5Qz0QCHNpRjueBN3eTcnbx26GC+7usOhZ2h5JFkn1Nhk7KAi4b?=
 =?us-ascii?Q?6Qi3aYNJzvvskMe55eKyyKPOm1sGSHFCq3dV3xbexNvdp/J+IzZrCCA2jvI4?=
 =?us-ascii?Q?z1iudb7EgP/G6V1hEt2wR9K0N1F5eb3DzH6unniKquihNMko2YBtGf2rLLwq?=
 =?us-ascii?Q?Z53lkB/QOJNRQkvtrXrnK+YqA40VTufNNq5XIumZt2mNUwGndX8Yzk3fQ2kv?=
 =?us-ascii?Q?0QYFyUQODBt8GxI8JsjiBb21qrwN2zajm1KOLu5vli/iEApGl67Nr3uukF4v?=
 =?us-ascii?Q?mjRYV3dIhRMwOIasLpl6m/3i/NS4aMZvF8iVMppaCMavptcnNUP7zd36v6yg?=
 =?us-ascii?Q?kqZrsZo8NhDxoNTByio5RB5/WAgARnKSX2h9xPQs+eKVjVZVx/is9UzLiNWd?=
 =?us-ascii?Q?RB8UdL0IUfrVQaVi82S+p8IZVhBOXkkcYqpYQLypFKWa4kV6BBy/eseXyjQT?=
 =?us-ascii?Q?B3D0WZY+gQ1yH2NIrzYtZA6jW5wChZJpsULBnnD7ZA0/IX8uWlDf0nn2OqDz?=
 =?us-ascii?Q?65tRCsMPmWzCVyEJAhxqoYb1uduHCP/ngTp4GHnXQ2856hgd4g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67323c6d-142a-4c9d-9422-08d8de4f2473
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 14:17:56.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osNHb6Z1g87ZRTv7iT/R2ygKycSNoY1fR6DSfma12oCcxvQwZ0nmpLZs9kYmTdIaHqhoTTyu8Z4l7Vm4gW/Bw8DgZjwBhLYHdHxfwA98bUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7237
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/03/2021 13:54, Goldwyn Rodrigues wrote:=0A=
> need_force_cow will evaluate to false if both BTRFS_INODE_NODATACOW and=
=0A=
> BTRFS_INODE_PREALLOC are not set. Change the function to should_cow()=0A=
> instead and correct the conditions so should_nocow() returns true if=0A=
> either BTRFS_INODE_NODATACOW or BTRFS_INODE_PREALLOC, but it is not a=0A=
> defrag extent.=0A=
> =0A=
> Fixes: 7e33213f8ccc btrfs: remove force argument from run_delalloc_nocow(=
)=0A=
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>=0A=
=0A=
This fixes the ASSERT() I've seen with zoned filesystems.=0A=
=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
