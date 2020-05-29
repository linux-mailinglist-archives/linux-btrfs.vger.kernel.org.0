Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432861E8024
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgE2OZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 10:25:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12489 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgE2OZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 10:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590762334; x=1622298334;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HhCSpF+Pe0lJ7/A41xod4JSYzNsYqAGAOXZ7alQNuWk=;
  b=TNfamK3V9HTJj+5MD5SV4Hqtju/UetrCvZ9XIEmikLbtbLLteKJ6R7MO
   JXilrqV4E7Yl/Knf4UXo5AWSG/0/NMdIdyIFGpl+zn6DK3/eR3i9JBWIj
   cYvmTLzDjO+f+KetXqY4Kj6L5IY1NPRbnSMwb6I1vRWPtAraBEOsV9rsW
   KYUq2HejYlnf1SX+uZO0tSfNgeMSircDS+cxWnaAlBYE6D9UAToctSNgO
   u8ncPc4qU5GhcysNBQmivieI2pdBt33mnR2l/lvSblxQCzFKirBiXLuLr
   TYNz2gtJfWVRWSSquLGmGGpDnSYaSnKHxnRA7UK4aB9rhkjjyHPTfuFkG
   w==;
IronPort-SDR: eJkwXhBMw+rWyLaKN3s/cOk3E4McgOgQDGq3Fw9/sJN69NAH1e4fL2e4BNux1YjNjiPlKAvIfo
 ZUy/EFCjxITDxH5qcov42+FeeGVmJoiCO3MlRcprNOO8rsjbEk8o0I9//LU1HB0MTLJe3mUNSr
 qo48xPYN9pcvUD2iYPTjeC+gDzWnzj4+Fbs7FGJGH9fpTXhVNgyF8hyR4X1gPZsVwVKFJuxsGS
 fWPo9e3dRk9/zGn+8Czu3JvaUrrTPn2qUPYda96DdZY4F8CSPRv32HQksYyi8lvLP3685WYudR
 Nmg=
X-IronPort-AV: E=Sophos;i="5.73,448,1583164800"; 
   d="scan'208";a="140227875"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 22:25:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvDu/EcYhSKF0EWwusJlmQcfJ7k5cOmNadv1vL3cy56xvsrtaZAw7k6FhwthGTJjMJyFNhKLlAqq8HFFY4G/4+4fmBsRc7U4siSvOsSFj/ZzCY/5rWL1Qm/Pe0hhN30qMneoNdv6DIHDZXRnSsMKpW4hxxeWhJ/3/5fjVtdp4L32wFkAw++c7QvDUolpXtnCxR9nZM83RJqVD5IDSIwUxtngGRQ1HCTu/QZUJp3o9s/dZnYV04Vvku8EqKMfhbcmUWWZOc2CTAH69lLMfkTiykMJj85l1UXbBTQnvq6FeFGQXUd+BO9x8CcAuKXNm0L39itjml+RSC47NGQMN8uuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JBNDwt107Z8B6wRdyyfDt93zqZDVXuos4N3NhC0e34=;
 b=aFs8ZEQBnfe5brcDy/eSm+MaCVQLn4QNY+zrn/3K67gfioSS+Hft0Njm0m52NMYGIH4sB6Sl1V1l3lCxtMHWtF3F0h2RTcaswLFpOjYXZZBs9hNmgJ6dvPOV+9lJ+WfHX/AtW8itRtzOkmtI9p3BlQfhEHNZ0vyjwMM4ClaUnHPO0Vz5xKUGREQrERUuU1FsyhuPSSY2UQXn8pKXN/0yaje15pJpw5NqAVQmg0Cu0W8B6qxb7PTWbkrKPvOI7Dr1GAtSKqWEOrx9aO86mB1HXr6VODJEEiAYaJLLwGlO0DNpb8WsqtwdJzTpQ/XWoV6mcZqZuA8CLLvVk0zTxgEfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JBNDwt107Z8B6wRdyyfDt93zqZDVXuos4N3NhC0e34=;
 b=LRc7oea0vUz8vkq+Nzot7u0o5tGCu6/bhB2MBhy6DEiix5TyVMQsASJRhXtZmyQkKoo0jh9yVNafylXudMxN2v+WlZBZVspJUXGLhHuo92ywApWUxszP1P/iUScF498SXBTmygi5JWPfNx4P8TKl4lub67TVrKtIgdz6C5mJwqM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 29 May
 2020 14:25:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 14:25:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] 3 small cleanups for find_first_block_group
Thread-Topic: [PATCH v2 0/3] 3 small cleanups for find_first_block_group
Thread-Index: AQHWM/6TOk7YXxg3vkqm0cSKk7xRyQ==
Date:   Fri, 29 May 2020 14:25:32 +0000
Message-ID: <SN4PR0401MB3598731CEEA486E8601766999B8F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44e2e34d-3e00-41f7-6dec-08d803dc250b
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB3519FC5EA9164278EFD00F8C9B8F0@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NvUvQm2Gs5M+76dcA+Rek0zDAMkch1uRvEcCfCPD6zkFVuzpHZZU1/CCTthwU134T5wo4WL9CkCCKHNUL2Nwl3WnrcIB07nVtyjOh4OzOpYz+/UrKJYsRqlIiNgYBDk6U3SZ0DKLnuHlEAvSafe5WA4IYyu4RVvPH4A8zOvDydSJTNk6R7ckGEZa4aihCiDWEJWz86qxOtov+qHJ9x0KK4euqlN1PL0Q5kYt3c5y215g2Oa14sTKnkxOKZQ1iMx6uHXJ/iYQ1tG2y5T3C3z64UTX8cOov2aGe0UKXyJUhOPFiQJuzBYbx2xqg4dte0vNrV3XwrN2mJT14k4dhbvSLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(83380400001)(186003)(91956017)(52536014)(4326008)(5660300002)(2906002)(66476007)(66556008)(66446008)(9686003)(33656002)(478600001)(76116006)(64756008)(66946007)(6916009)(71200400001)(53546011)(6506007)(7696005)(8676002)(26005)(55016002)(316002)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a96u2bZjIlPK0PEBtg60krHAy0V8DGjx/DEfpj55sr22SsgJUxZn3tYW/wBUqcimWyZ20OtqOrm9nFZsOr/YXGfnZvvPJnzndLdSXYy0cbv5+6X+UnJ56KgLPSECDZgPPJByREatGSUhBR5uTRws0lshmSECrbN3GVlUp2P0WXs8T3IpLniy9VhIfuA12jn3X4v4l7t0BKR1cfpVMtoaREj/f2Ef3ABVW9e8CDEsecycD2xPbIzVDX5MdOhmVEEdm/7SclQlFZjlp32GNUjKQEI4xI7yis2QfVcPPEKFN1uJezZTAp9C2wnHj7UNFxvXn1Yj7swvl1v0W2GjQrQ5QOdagqTS6pL+QDX8uzOsG6qUL8RrsadATOHgOCl8Zes695U9dPxxOx9aSOgM62EJdnIbQKjYJB5dGtDIQFcn5laMHsP55ne1hz3ctuL7KSz35Ghqqrl/Rrqio1p3Uc2TB+awMO6GCSveInenZLi0rs0y65Q5SWj3dBNTCaMrSJLQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e2e34d-3e00-41f7-6dec-08d803dc250b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 14:25:32.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifgC2Jbd5PmfnUZizSgYgVKPno8M0603v23g3oFSadqzTnTOSDDQO3SK8NAJiXgOEvU8VM2kQqOWb3t4L5sF9yGB9c6lVWA7x3nAKx20Wy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/05/2020 10:12, Johannes Thumshirn wrote:=0A=
> While trying to learn the Block Group code I've found some cleanup=0A=
> possibilities for find_first_block_group().=0A=
> =0A=
> Here's a proposal to make $ffbg a bit more easier to read by untangling t=
he=0A=
> gotos and if statements.=0A=
> =0A=
> The patch set is based on misc-next from May 26 morning with =0A=
> HEAD 3f4a266717ed ("btrfs: split btrfs_direct_IO to read and write part")=
=0A=
> and xfstests showed no regressions to the base misc-next in my test setup=
.=0A=
> =0A=
> Changes to v1:=0A=
> - Pass btrfs_path instead of leaf & slot to read_bg_from_eb (Nikolay)=0A=
> - Don't comment about the size change (Nikolay)=0A=
> - Add Nikolay's Reviewed-by's=0A=
> =0A=
> Johannes Thumshirn (3):=0A=
>   btrfs: remove pointless out label in find_first_block_group=0A=
>   btrfs: get mapping tree directly from fsinfo in find_first_block_group=
=0A=
>   btrfs: factor out reading of bg from find_frist_block_group=0A=
> =0A=
>  fs/btrfs/block-group.c | 108 ++++++++++++++++++++++-------------------=
=0A=
>  1 file changed, 58 insertions(+), 50 deletions(-)=0A=
> =0A=
=0A=
David, any comment if you will consider this series? Patch 2/3 actually mak=
es =0A=
the function more complainant to the kernel's coding style.=0A=
