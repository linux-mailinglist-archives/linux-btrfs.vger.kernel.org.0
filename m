Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A7565733
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiGDNbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 09:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiGDNbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 09:31:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298C654D
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656941140; x=1688477140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xpiSvdvwsBn3QfK51hyJ6wuHShfr1x0iWonE028ei/8=;
  b=PkafsSI/cPyobmT01kIFqnuOPLA53+s60dwC/jzZJO8JYa6YrEKrGqif
   bb6L8UFkUEiNf7B9YaC8f04lhmryKjwuptN7YJML/uRk0kYJ/bAJTGXvh
   jvVdPE0Nr+W+7w6e2NS2lwv4URo+ASUeBdHs1j6nNjLHej7gOq7JdgKec
   0nWknXOmHsT2sTHSdUy7O1KneJtcojbyrIL5V31vbibHKUPctfDRLorW+
   TqIz8VZNaCZPXAH6ha/5/tLvDShnJ7+uFQOE6GaEzQTmCdPF7giGaokIK
   ke6n+HzAu4uUKzzs2CjEX10+IiVMf4OQ+Pwxu3eMnflnkPrg4EyQiLL2o
   w==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209660943"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 21:25:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKXUbn3lkG9gq4/TA4f9uyViqhFEMfQ/0EHxMm0MjpKPCH5LuAy9iEyMP7N6svfZHysGmp4LLDkJIbP+xoQXFABG//Nruq5mh1MDDKWVJ+sG8sMKLMyn1W8Q9ZQOd8X+xR8n/qrj6pSfT1RkFOjIHLzPgi1GXqmnMQ02MTIeKuUXY8hSsI4pG05pL03eL2Y1CuScmbheJ1wdtR43GxspK0SxdLeRrmo5aRORacdiMsAgCyfclwyyI1as5O1Jz0xCT02vZDa4vRWkdKLIDXNXgVg3afu4k6Zbkq2Q6GjkM9Q+iqsX7+VngUensLv3p/4HzY7bpx2FymG3GnOje2Kg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8r/fz32GTqTIrNpq8ew7lRB2hX8+/twGhCdphoeG7g=;
 b=RmTqgMruKGSQmYIoMIUSHrmy3R/xxfU44ROJSmEew7tnoEjNh6KmF+2JAOwbWWAxGQHSo28D18Vq+rD5AmjdivGbOE02Vj7y5hiXdW+1x2gquaZCVf4tkFg4RevvhEd0Ch+ULp1WmdvBF5tBAI7QGyQq3K51Ja2ebmM0y+Fcz5q67YPHwynOvh6wEnIKA7KAhVwE6t8HNq1E9GOV9pM+XHhWd1xKqrAbu3S+8bug+8HhYMOys91OeLZg2GNjldxuZJmSR4oPiBgKbigOZ1Cp2FKUyayV6Jj9ohxNN3bu4oq5Wtv5/G8ly/7GCNBvlNbZXL9UuuPv9ghqrR6EPzIr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8r/fz32GTqTIrNpq8ew7lRB2hX8+/twGhCdphoeG7g=;
 b=WruK6jTnqCwSZ2C3dqTm6qyJ7klUHTQtitMP5foArpwoZChO8nHxD4CSDRLW/f1Hy51vAXk7y/JGvKMLrP6U0t1RfRBZdMoeGxLfCImoi97mkU3cbmtntiFAGKOa9mfZmkZxBN9fnTO74IitNYPZdEJKOM+yrXyQwDRG8aeVmQI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6492.namprd04.prod.outlook.com (2603:10b6:610:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:25:39 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:25:39 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/13] btrfs: zoned: finish least available block group on
 data BG allocation
Thread-Topic: [PATCH 07/13] btrfs: zoned: finish least available block group
 on data BG allocation
Thread-Index: AQHYj2LCgv9G8+T0v0OE7eenW7rxAK1uNFKA
Date:   Mon, 4 Jul 2022 13:25:39 +0000
Message-ID: <20220704132537.7egophhnu7yamlsf@naota-xeon>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <f246521cb4a2720f8f3663679d6331d2b4b13f17.1656909695.git.naohiro.aota@wdc.com>
 <PH0PR04MB74167D03DCDC030A680101A79BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74167D03DCDC030A680101A79BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 521b0cb0-a549-48d4-84c7-08da5dc0aff8
x-ms-traffictypediagnostic: CH2PR04MB6492:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3m+WW22ETd1w/sDOANoHJG8zOWxrkPpuCCp88sFHHNJWw6L7isvzj5qVN7igVXbAY9/CIgRz+VRY3CCYuqTcyIEB4+QOubh9Zw8utOIWT6ITF6yhT4Qruk4ekKVfWyq6ZRKFOOpkICQuG6486Ok+HBzARpfOZ1ltmWm69N6P+EBYThla4TeDPJ1eH/B5PetmyN0/yLxeWu1HWvKNdyR/X7YNznk34U9cafdTnIA9xh7zL8+wyErxoDkM2c7kGg/lMdXqOVgUb7Sl4bOksl/MnJ6zyb5f8D7x1yJeGTu2kScS7+c6zNFSqLS3gRCzDod+KOUePtAk5ltGNSHRYJRr1FjkdE85IcT5h6q8k3ORNwRfJJfx9OLh3C/B4nPaqYPitKApxei4PRSWIAp05QVMeEMEobVbXfYWbfDiHHGPEp0sJliliC3lbGDE+Ye8H2LSBAno/VDGJf2pRLQ7BXk12kYD/lkcGLHeA1QaBfISq0dWBSOqI5yVS5I/kcGeaycMuKlXGs/X5Qbn0xXEN+PjX8DDqUiedZMhgb/G02GGGV+AGAGmGeRBRqPDL1HYHNDR7VxPvtjrTc6r6uvc0w72eEhw63RUlyrLVPHC2piLqyKk/hvKQFz450lbms1HpdTvaPJQ0iIgLqRuSC+VLPud94RGoli8e8j9ysKyDLzmVIvyZmKXHZ9+KEJoDk6DfQK7wTaljId2QTgotaQxwwFNwpwG2XW36+SVQgFoYtWXTJ/kq3bVDDONQ062LoQVXjm4rFCDvZoICFyQTX2zTaGiA7zbureySGAp9AEmvx2dOE4iFkhIuCauyAJ3kTCaFII3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(2906002)(66476007)(316002)(41300700001)(6486002)(53546011)(5660300002)(8936002)(478600001)(1076003)(91956017)(83380400001)(64756008)(66556008)(76116006)(66446008)(66946007)(86362001)(4326008)(8676002)(71200400001)(186003)(6506007)(6862004)(38070700005)(82960400001)(33716001)(6636002)(122000001)(4744005)(26005)(38100700002)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TJPCFHTSpFPSYzBs84JtMRvGK75u5FcQBhK8QyZH2wCumU+eVigLHD9WgByj?=
 =?us-ascii?Q?H5HjnR60xeb/RYRCh6sAZCCdLmvXl+uFaUhvuKguzKoWarFZjFFuwneH1eW5?=
 =?us-ascii?Q?LONgtrAyhQloXdLdJl3d1Y6t/ZSqu7zilv10fn78AJvNh4BL1VcvrjIGra3r?=
 =?us-ascii?Q?nEVLRrBRXb7OHP1hYlgqkZ+R0i2G7kbqBoxrHMnuErqozu9RYfK6vOQ5HnhZ?=
 =?us-ascii?Q?F73i7vUhiCU842OCR2LD6mOQaOGGbNHF7Nw1qHyxunvLfWOkzk9BZg0Ita1P?=
 =?us-ascii?Q?77vSPkhcWHV5ctpEiVCdtvN8ihHmpbhVQ96yxwflLKEvsLzaGR1mY9nzhx2l?=
 =?us-ascii?Q?YjmWMLrKTWAkDrYF66VlsKfK09JTE+CAJ2MmAaE3BhiSWxNnMcL/xKjahkcg?=
 =?us-ascii?Q?003xGEieWv8Ks1mRpfSAY1CpZ5TtS96bvF0XqA7AzAjpbIqscJO9cQbea7Jn?=
 =?us-ascii?Q?iQ94EUVDGUTmGYvBKp/+WWF8a3rvokqj5shPvviZoY6rDGCawBsNljIzN80W?=
 =?us-ascii?Q?BHNL77g7iHjxie+GiZ9vnoHrP7ljgxLv47GitLtscf8Ri7OFjnxeQPn4v4w5?=
 =?us-ascii?Q?2ugZoK6VC7jIC+VQNztXvIFdZqAmz/VU4z/CPXIZxeBw9pXumwTkW7cZT1ZZ?=
 =?us-ascii?Q?LqYeAtIFbapSho182a99sOV21W2UR3/Q2Agg+apXkAd3oJGmlx0WYiuQ5znO?=
 =?us-ascii?Q?KfsUdhdjcwHK0jz2Yk4oBEGxXntErKm5Re8pcfZhR02zSehe7n2WQDx+F/cQ?=
 =?us-ascii?Q?Ya5D7I9mc2syTat0IXLHmHSJykgWxEn2VCD7MoFG1UzKszsv7Dy9rwoWA7cy?=
 =?us-ascii?Q?CsIDuRJuDDebcUImL519Idm/2AbuLZZPPWo1juDDcutkRMovVwEHIGUzTUVC?=
 =?us-ascii?Q?7Dlyj85gfwqNOHCuuvsz/IA75H2j1GTNJu8FNLyluVu48exdkn5sC9129xMb?=
 =?us-ascii?Q?+QagHBS/uaplgUF/4ETu+9X9GCof0eyJK17QmZRkANWOcuiKdwx8WFSYw4Nl?=
 =?us-ascii?Q?uFUXExYGgeGETcfGZrgxvOPXLL61IrBYalkl7EFRGbw7hldLZJ89BoLBRQqa?=
 =?us-ascii?Q?VreYKEAx8y4A9IRdE/tbiGsyOSBzhklfUTkPxTE5QdRiUWlqojZgF8luASBQ?=
 =?us-ascii?Q?2dEHlxVsDUtBUf3Fy0aKbPa48jbmyuJowNfLuwu1yVSbrCP35YvwdVL7kdtv?=
 =?us-ascii?Q?JdeTtqCHem6iBZq9KUfIsvqFubH1KlBTKIa1Jk4J5CtnJ1VLGNHh07hWSDou?=
 =?us-ascii?Q?QNEBqgc2e5CYudJFb4sfsKtnQxY8Bdn21JsQfiS2DDA8z5+lmEmFjq2Fdb6c?=
 =?us-ascii?Q?lh80pHrDFT28CWKIA+Djnx+X3nKPjrLxl209OAb5Hsh6rqfraddks4lnTpNp?=
 =?us-ascii?Q?tuAPVWvqvEH8kFw+xfKD596dHk5+CMqahPhmZWSPA8JAfOyaJ5rxQuJfak9j?=
 =?us-ascii?Q?KNSysDvYeDSUAwP/MxIVyEmRA8q1dpjIUjgQ9x509tEG7P3J9Kq2f8NXgn4e?=
 =?us-ascii?Q?ocaLj8k8MkD8LiBnQveLBPm3XClaFuvRLTXrMYN9WLBnxNI08DQG98x3+nRS?=
 =?us-ascii?Q?ZtsPHtU2YVigyE/NeP4EuTBhwrijVeQa9c4MZF9hI2nof33AooYHjaTZw2Zj?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50933D1239469C41974A807470576622@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521b0cb0-a549-48d4-84c7-08da5dc0aff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:25:39.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNv+Tj1eXzVD4SlDTkcAtEBaS8dpcGdsehRxSfi5eF+fNizHxXfW6MBDSnhS87K9uRSbim1bBN6INRBuIr+amA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6492
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 07:25:14AM +0000, Johannes Thumshirn wrote:
> On 04.07.22 06:59, Naohiro Aota wrote:
> > +
> > +	ret =3D btrfs_zone_finish(min_bg);
> > +	btrfs_put_block_group(min_bg);
> > +
> > +	return ret =3D=3D 0;
>=20
> Why aren't you propagating the error from btrfs_zone_finish()
> back to the caller?

Ah, yeah. We should propagate it. I'll fix in the next version.

Thanks.=
