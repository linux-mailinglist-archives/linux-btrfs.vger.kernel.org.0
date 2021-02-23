Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A05322791
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhBWJNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 04:13:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56143 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhBWJMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 04:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614071675; x=1645607675;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Seq+xhCW8JzjHFnN2VsMid6Uiwdxbw0h/b06sqw195I=;
  b=kj5b+dNm2YDBZ/BZ+OdVEXmX+YJiQMLyIF0Nri/wgGt51uoUwVuQLl18
   0V9ekBHwG4w21oghRzZ8YrwZ2IaXtr1LOKSFxChkwcxzHBb6c3S/Y6TPx
   ggpxM9vrGmfRLt8Sw8rFpIPIRwtlWP+0NAz1kZX+G6CSFQEAyKbjTG3f3
   YlKayV/XhhnSPfVqmBGdUxR/i9Iu0DgxJzySZSmmRzj0KncMfvw25lMv6
   7FH6VrCoo3G8rZoNaOiqMaxLiw17lzGldJYXkfYgIdWE+otUN22DMRWUw
   WkW8cu5bafSi3nhFgPsab2KQn+S7EcoLql4/pMc6tqiFMqp/+M0E5In/M
   g==;
IronPort-SDR: PQhrXLjhvTCQBK7zIN5WUW6524pzCz3xKoLqsbMA1FGO6iQTGRLeNba8B2nQaGiJdtHxAMKZZ4
 H+T7HLrByHJFYdLYCOQSqwFtHnkwzulcix56Cnk1CxOAXwKVMKUnbDwmrBKZHXRLn/N8Vs3EW/
 WrTcy4YbT5LdsgnXLEg+1TmGe7d8yLx+1igbZMdQqrJ8ZjlkHdZnKL0sd2AYrUA2grkYWhVl1p
 EKLRYAFWznjkTeMgWfYZL0wKcNVvAJKSSkMcp5R3jvLh/Yua64c8f6gpaHnPVjXCH6ILfs2DB9
 BtY=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="264775412"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 17:12:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBKp5Py1FgaXA9YUnkEYrooE/W0uqTa+tNltGcnOojY+JClpY5rVQZ543kB5v9eUSauP3rlzADXoWHWvYeb1PUk+bNHAjp8ToZbOc4fnAUg0bAe+BW4dMGONIFgVV20Mvy665m8DJpwT/6X8H0bQbtMw/SvEiVYDfoGG/q3f0KvGIN7XKu7pGf2f3skh8mMZblFDIpaZkTplvnd8sFrJrBvgTv6IMCeTHCCKtJEK0rYgJzhBiOXeItf+9VAAipXAA1loPnQjpNt1O3/zyww3bE7OafzKgYh7CnuXhJkmjwMJLch5REBLZW6NKGYNFv9rJnfTZ3wwu39tWfDEvkSyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/VUsJgHSQvqmJTuACIZelu2BAn5CBmMiPATg57eOH0=;
 b=FmlQHVkN0Gl+CFmteMXhrtjCDCvVIWKN4J2CJO4PcD95U8/Eg0JHMIW9kzDXhdVfEONIvuwxPGngz9Qo1VZcWPSbH1dtWB08/O8Q8Bm2rKEF2BlXhyU3VCXR44uOLhzpR6Lo9jG/dB02O6oAZGo3Xtg/0bQzfxzq2jPL1QK3ULv9iqMnEFlcCSBfL4jlvy74QORBNwt4CBQzJNknT6tflsG/SHXgQb0F15elhUmM/o5sUS1tNWv5zThtk1KjoT/8HBVrK2x2eAmT2hlKFVJHeVjO4VecUEjSsR1sdqpXILKU0pVVFDEFVqVSpcfCWO7zwE6ixV9iLp4Rr8kE6JeNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/VUsJgHSQvqmJTuACIZelu2BAn5CBmMiPATg57eOH0=;
 b=SVomVzYdTOKoqYSXJY/Wod8dauDuOd9/MikoxzBincIARWbjfAdceYPGFoErVqnxlT2YE+zD7Vi9zjNlOZPkD14+rXwG36eZItL0P+TTs+s8w1AS2BR+d82BX1WLK1rvAW8ClaQxZj5WrCn98VIOo77y2xD2HG+KmfSC4LwE2VM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7669.namprd04.prod.outlook.com (2603:10b6:510:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 09:11:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 09:11:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Steven Davies <btrfs-list@steev.me.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: 5.11.0: open ctree failed: devide total_bytes should be at most X
 but found Y
Thread-Topic: 5.11.0: open ctree failed: devide total_bytes should be at most
 X but found Y
Thread-Index: AQHXCVZZbch6GFpjTEmrkxrdQ5iSyA==
Date:   Tue, 23 Feb 2021 09:11:36 +0000
Message-ID: <PH0PR04MB7416AA577A3ED39E4C5833819B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: steev.me.uk; dkim=none (message not signed)
 header.d=none;steev.me.uk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:41af:77a9:fe21:4e5e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f008fb0-d879-4751-7a37-08d8d7db05ea
x-ms-traffictypediagnostic: PH0PR04MB7669:
x-microsoft-antispam-prvs: <PH0PR04MB766907843F3F80405B1DD38D9B809@PH0PR04MB7669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKYA+tf8tJTs24wN4h94rKRtSZ8uunNsP9UbTfYVL8Q5vsqQSEqVZgLDUoZ4USHNeWAeA60FJoXCy+odxWSydacYNYMgdqXGo2GVrtvNkjCld/6MQWy/4oqQ6kPAlyE39uY4nOzvgMOnA+GyE56J02qwLVqM/FpXX8jLa0DEh/LRBnNH4l3Y8yhI4eU6+kDfCpKSvr3GA8wMLTtsamR24jAp4QidL8HimqTOkI3eMZgrIfeEmYfMAoFQFu7pxfEpra3QAuMERf9IWqSvmO9/sFxdzHbkjt7SxTJ6KmYIllGlxaihAvWwzqdqUGj4pw0WgB2V7cT8uq1uJl2D5V4VJg7W1pHLALuIpSa20fuv2Px6Pkde4emj5iY3nHTI81/9R/levDNvwnj4mCRWEsPpCTyQIELGXJcNTZgoH228Whn8U65Huf3JfmNVhyJ/1BLtR0adHfjU27rCoVaZqeYdvupvF5WTVGIioyyx0pni7KgrsIn5VGRyFq5I/Uz6ftRrxfJZWHPYk7+WtEmJkyve8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(6506007)(66556008)(66446008)(91956017)(76116006)(71200400001)(5660300002)(53546011)(8936002)(2906002)(55016002)(66476007)(86362001)(7696005)(64756008)(8676002)(66946007)(9686003)(186003)(33656002)(110136005)(478600001)(316002)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?X9dI+4VFA2s+e1h+aOyX14NCuRmVAC3NlHEhh833Co+PqolN8IR/P8bOra?=
 =?iso-8859-1?Q?vpX4bsgIwGaaHQBHrOXd21xcTI7sHmuYHPFTgyefH6+Ps7RJysom493zms?=
 =?iso-8859-1?Q?eGhCRB0xwTfk4i1jgaftl79I8dud9dk5prYJeUhxklMYZpAgSYjpl+ZOpu?=
 =?iso-8859-1?Q?rdPUBhRcjnznYgxQWsa5WNmEO4HjpVrIR4+z9xfBcrA+onbddbgJlCXbeC?=
 =?iso-8859-1?Q?0FZRmZ5k9yX06OKYj2DDEQLnv6P6UWPwOKeKeDgUE5mh3Z25WYJrxQgeCJ?=
 =?iso-8859-1?Q?slbyOaEDhaGaDH2u+m0bwvFOeEEnyvxTd/+rXAN1tU7AV16peLlgokqV8t?=
 =?iso-8859-1?Q?Bnh8AKGPDUrbnNB3xO5fq4uy9Gau3ybShKN8kF82n0btvnV6JhOhBTXlGc?=
 =?iso-8859-1?Q?Ll0niSFbvOU7GShn0YpCMoBc88xjhBCsMrUujBfGuB2eSNz+A5Ch/bzFWI?=
 =?iso-8859-1?Q?gJynvcVmQGChYTujaBcOus3XqX8/LlozC0Jrj/jAfDU4AJ4kWvGnVH//YE?=
 =?iso-8859-1?Q?dCtkGm9LQqh1WSJlw09AJFyt51HpzearCF6YdrBTL8V2nZlbFqgskwuQaI?=
 =?iso-8859-1?Q?7GCS7GNw7W3IE54xrzMLT3n4/o4Tr9g42CG9iaZ2TGDVbtIe3EisBQRuz9?=
 =?iso-8859-1?Q?a8E5R0HSqg6YzLO1qevtAAmCGZ/lkmKac4pyfhPCNE+KfNU4Z61ZMgDzGQ?=
 =?iso-8859-1?Q?3ILUJrt/oKnE8OSQl7jwBBhiQm9B4+uK2hsUNJvTJ9LIVfMhSNE6oAN/9Q?=
 =?iso-8859-1?Q?MhkV35m8lOlXoLTMeSj4W7FVxqAvZueWOdy9jD43HYqK85hTh0PZ7Wo/Qf?=
 =?iso-8859-1?Q?0RKvHF6umEceAqO/IlEZN+f3T0mOrL5TSWUPxswf0BQA6OsO0A4zhOAxgU?=
 =?iso-8859-1?Q?cmr0WK4bqlVXWMnbvhaOXhdrLQxAKhwdIj3xZzo8m7OSoEt+J9KDESuTdm?=
 =?iso-8859-1?Q?yVs2O6rpGSJadMM5zfohPK4cWZA/8NfGS19larJhJnCZtfdwff5qzDdz2P?=
 =?iso-8859-1?Q?M5TKS5zzZtDdpgPc8AtIaqtP9o6xLXpV8mu2NuTa85SiLP5f45G5sC17ez?=
 =?iso-8859-1?Q?5BQaWPUNEmgSolPYc4FopkBsHXPNLPfMA1OPEAR1TXGquUJdZRL6+Mkt6R?=
 =?iso-8859-1?Q?lAzs9JyrbTnTnaB+Mka7CjZLaEyhrLWypBeCtG8zO8g37s06a/rbH4bEZZ?=
 =?iso-8859-1?Q?ouk7gU6fQnF5Y2VTEsbQXzRnvl/QOW2Obag3IpBxe9Z1AIPh9DcwHyS5Wf?=
 =?iso-8859-1?Q?3h+WuwK5jsFSjGuId1BD1vaQTbl0NAzCK1ZQtWanqjwlOpWB+L3OyiuH6k?=
 =?iso-8859-1?Q?5JI37cONZdJlFriSdGfAOOdvIIfLZpTvemIvuG5LeI4eX209npd/RMPb0T?=
 =?iso-8859-1?Q?h+guLP2tazU2HrzY27IIllRRdoLBgsji85Ry97MOBMGx+z8Xj85aZHpisr?=
 =?iso-8859-1?Q?4piqEtyqZobg/GgRcEuRGoX0l1hr1TB33BESPw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f008fb0-d879-4751-7a37-08d8d7db05ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 09:11:36.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JHKZ/HINCcZWRdyy2C5pCRZMz6My5W/B26hq1dx9lJHV95ZeZZmsPlrv+oMlk2+TtPVxudsBEPBwTiTVfiYCdWmim/0r+dWiLyjBGd0HRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7669
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/02/2021 21:07, Steven Davies wrote:=0A=
=0A=
[+CC Anand ]=0A=
=0A=
> Booted my system with kernel 5.11.0 vanilla with the first time and recei=
ved this:=0A=
> =0A=
> BTRFS info (device nvme0n1p2): has skinny extents=0A=
> BTRFS error (device nvme0n1p2): device total_bytes should be at most 9647=
57028864 but found =0A=
> 964770336768=0A=
> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22=0A=
> =0A=
> Booting with 5.10.12 has no issues.=0A=
> =0A=
> # btrfs filesystem usage /=0A=
> Overall:=0A=
>  =A0=A0=A0 Device size:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8=
98.51GiB=0A=
>  =A0=A0=A0 Device allocated:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 620.06GiB=
=0A=
>  =A0=A0=A0 Device unallocated:=A0=A0=A0=A0=A0=A0=A0=A0=A0 278.45GiB=0A=
>  =A0=A0=A0 Device missing:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0.00B=0A=
>  =A0=A0=A0 Used:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 616.58GiB=0A=
>  =A0=A0=A0 Free (estimated):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 279.94GiB=
=A0=A0=A0=A0=A0 (min: 140.72GiB)=0A=
>  =A0=A0=A0 Data ratio:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 1.00=0A=
>  =A0=A0=A0 Metadata ratio:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 2.00=0A=
>  =A0=A0=A0 Global reserve:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 512.00M=
iB=A0=A0=A0=A0=A0 (used: 0.00B)=0A=
> =0A=
> Data,single: Size:568.00GiB, Used:566.51GiB (99.74%)=0A=
>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0 568.00GiB=0A=
> =0A=
> Metadata,DUP: Size:26.00GiB, Used:25.03GiB (96.29%)=0A=
>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0=A0 52.00GiB=0A=
> =0A=
> System,DUP: Size:32.00MiB, Used:80.00KiB (0.24%)=0A=
>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0=A0 64.00MiB=0A=
> =0A=
> Unallocated:=0A=
>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0 278.45GiB=0A=
> =0A=
> # parted -l=0A=
> Model: Sabrent Rocket Q (nvme)=0A=
> Disk /dev/nvme0n1: 1000GB=0A=
> Sector size (logical/physical): 512B/512B=0A=
> Partition Table: gpt=0A=
> Disk Flags:=0A=
> =0A=
> Number=A0 Start=A0=A0 End=A0=A0=A0=A0 Size=A0=A0=A0 File system=A0=A0=A0=
=A0 Name=A0 Flags=0A=
>  =A01=A0=A0=A0=A0=A0 1049kB=A0 1075MB=A0 1074MB=A0 fat32=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 boot, esp=0A=
>  =A02=A0=A0=A0=A0=A0 1075MB=A0 966GB=A0=A0 965GB=A0=A0 btrfs=0A=
>  =A03=A0=A0=A0=A0=A0 966GB=A0=A0 1000GB=A0 34.4GB=A0 linux-swap(v1)=A0=A0=
=A0=A0=A0=A0=A0 swap=0A=
> =0A=
> What has changed in 5.11 which might cause this?=0A=
> =0A=
> =0A=
=0A=
This line:=0A=
> BTRFS info (device nvme0n1p2): has skinny extents=0A=
> BTRFS error (device nvme0n1p2): device total_bytes should be at most 9647=
57028864 but found =0A=
> 964770336768=0A=
> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22=0A=
=0A=
comes from 3a160a933111 ("btrfs: drop never met disk total bytes check in v=
erify_one_dev_extent")=0A=
which went into v5.11-rc1.=0A=
=0A=
IIUIC the device item's total_bytes and the block device inode's size are o=
ff by 12M, so the check=0A=
introduced in the above commit refuses to mount the FS.=0A=
=0A=
Anand any idea?=0A=
=0A=
Byte,=0A=
	Johannes=0A=
