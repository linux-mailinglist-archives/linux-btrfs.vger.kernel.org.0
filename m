Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13F34C50C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhC2HgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 03:36:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49787 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC2HgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 03:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617003371; x=1648539371;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2cGUaspp+JBB8JPPPtUQmpuOpeUuFWCUCT+zawpe/4E=;
  b=V+zRmS1PkaNZE3FNmDFyRPfQOuS1IrH5o7twQ1Z/qSfhpTQlGbHEwkOw
   JA5W/T/3mMW/W4nPcQAfAOfvn2l40HQhOeSLQfRpJ6ZxUr0DMp38FGcQD
   XNTZeGAiJr8wYmd6zwYZbyBgBXyiw2hy0QJBW8amTInUlpZOj6bSpl2GI
   g5bkPGbPGsE3/BmCQspR3KfLNVnXnDLZJuNMwQKkp3k63t5rB/ftprAV/
   i5EevnOOUb7XvS2ax7bnYcur1aRJ18d8d1PvN/kEgmJKYnFeO150m8+sW
   j8m5JMTyuopQlr9cYBxKcM1z1Yn/iYPQ1zdc/erR3jpD9Pto52uVSbf+6
   Q==;
IronPort-SDR: 7rXFeBCAh3ZFGNImeuTzJisXf2S4JGaDOGtBHNcNs0PfmdnnFYNsFJue6KewUK5x6kMHBmMJsa
 zp0gu2cMKNxT+PYYO1mTPpqHQt6fC0bMKzmGKLzmQkioldi0c3HS6ETTt/E3NTWPjn135Dwold
 Qf7oYYeqVnb7hoanswzZZYrJF2Z+2EUaBC9ZgiXctN2C2JRiM+5dUC5L/tOO7g+lGLhJu9b03C
 iIEh6dpluY1CfapU4mBtdZZ3l61zXXpmCXpgudKlF18d7hTRE3mzFWRhMlTFNO6ah3/JHI7PSV
 Efg=
X-IronPort-AV: E=Sophos;i="5.81,287,1610380800"; 
   d="scan'208";a="163221107"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2021 15:36:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqnKpY6oFZ3aBpn1gk5K9jxuzkL/HBjDD23St1shkncFGdsaVoia11m8dX8bJxmZscT8wjOM4Mc83y8HSVVc/mpbgydnyQ70+74SLNJmqh5D4QbtYWx0Coh1I2BI6io9uU8KYet5jl72unLr3bWtjuPgepFzQRKvcPm13UzvcinhJg3OM1lESnGTMtYtB10DAgn/68YcgEwald0SSJEMpy/b5zSsBtEsR0WSNLkVpM5lhVd69GonpimG6+iZEJbbsBk4mIiotNUj5AkzEDPV35MkMpQKJGGGZ/Gin6OBTU6jQZd+IFRrG7btSZfY2CJ8bJPlsDukx7hi0G0jdWFW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAvne0iskGomdE8ofk4cWchX9rpfRevtgtlJqay+S4c=;
 b=jSfvAKoRwisqRI9Qgp7VBfQZ9ZKuO/DsTQbefadXDLXd4YF18SCICh+hdZyVtAEfqIwC1w7ZFoFQxrGLxlTkys1r2KhzynVmJl2EwyLQg4ELOwEnNw0rTTjP/1vPZnT8SyXxW/rCaMPI34T9rnpFrkT11sEoPvRVVFVwOpzPjNjhq6FhV/laHLFqx1VFbBWqLgYQD1CdYV2uDVXqgY1QCQ44zK2bLfK5x4Irsv9StR2MJ5yW00Ypl9M/8JGpTVmHrTWTE3sgzNsSJuZllPFMbULVcU4BWTcFMdVrzUz4jQQbkhxYe/heWziCS8Si/58ogaOenjdTBBgiOg8DIzm4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAvne0iskGomdE8ofk4cWchX9rpfRevtgtlJqay+S4c=;
 b=CbNgtkqJqLXLBQxhRpW6+A09HdUEyMHyTMBgVAHKkkqKgeKgNYH4kV8D1SVTwF1Iws7Z5GYbLpXWgn03gDuxaaSDs+nVQuVY11uZAb3wZlWs2OGLX5O5lNE2i3kWndLPfYFzBQHSnJzgWvyjurcEu/xkB00rs2s1a9KkjkOLMGc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6352.namprd04.prod.outlook.com (2603:10b6:208:1ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Mon, 29 Mar
 2021 07:36:05 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 07:36:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH 0/1] zoned: moving superblock logging zones
Thread-Topic: [PATCH 0/1] zoned: moving superblock logging zones
Thread-Index: AQHXGV/O21Uszgiz9ECwVkRv5CqopA==
Date:   Mon, 29 Mar 2021 07:36:05 +0000
Message-ID: <BL0PR04MB6514A9AAD4C124BF7BCE0AEBE77E9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <814c44b8-b700-7878-a881-f89cd99982e8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8539:9440:76cc:73ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d17be9a-1813-4132-2389-08d8f2854fe9
x-ms-traffictypediagnostic: MN2PR04MB6352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB635267D0BD2F6953540B5A71E77E9@MN2PR04MB6352.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E99epIT8c8GnPp53Z+6SjBU+smf/K11cecb6NRynws1RP5jpSfw1hMV1HrZ0l1y/h1U4frVRpN5CgcpChfiDgrBWyXT1YEtxnQN2Jc1hPEIVYZVHSiz8Gn/7vIHofE75ib1VpYE1Vpi1JaBt/4M4HjWTZ6LVXKDj0EXDNU6cdz8rx0+rr+RMDTt6o2ATBS1s83PRco3Di4JfYOIcVhN0eUWbnGdiYS/8lO7eLvLGNZ5vFxsiGLFipk8TopK1HkTnlQwPHULpVcyAp0z7NFfIb9MxYa5JNV8lsCIi+pRxzZf6aTjiRWwnjC4Lzgg6SLnXKxqqTX3BsJrXvWY4qGyzhWfdRsdpiRTWaWZjUlyVczCJqTg2VN3/q+vaKAleDWWm0ddl/VVeM/RTo8dM4KUmyBJ+0ALi5koekcSDZbJEFmccYQI/VeguULl6K2kg32A1sLu9ipNmL5tTlvVhWUrviRv0Qesy0yZ+9AuAn6zJzgK5r4qD/4jJDpUgCyZSxmUCWmlZIJBOiEujFxQtgGbKfttKSXTQeCOE5RAzVP7eiNAQta7Y6s5abH/ahUKZb0PqUoQY8+pDVD9wyn3Uu9mCVElsa2uzf9JgTvMsc6aA9Q496wGqeEvLbcAh/uiCJPhGjoAEX1wpBwcL7BE7kYp7A82f3xPj3zTk+hEsGhpscfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(316002)(7696005)(478600001)(91956017)(8676002)(2906002)(5660300002)(86362001)(110136005)(186003)(66446008)(8936002)(52536014)(55016002)(38100700001)(66946007)(83380400001)(53546011)(76116006)(6506007)(66556008)(9686003)(71200400001)(66476007)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H6z8UHMpk14VE6roJnrrWN6nLUpnro98PZqFgijK1RVBbasax5O9sdP2+rTN?=
 =?us-ascii?Q?GjxDmiTp/aAOE78owTCp+tW8qDseQaqi7A4YyraWpkxvf5bMOKaH0flukrpB?=
 =?us-ascii?Q?BC9YZPTRDjvt8groLgfUfs94wVdCkmefmogPWTM0CZudiW2CixNjJdPmhcxm?=
 =?us-ascii?Q?fpgCLum2LK9KE3pIs8bQP6J397jg9XCED/5U0gECdFd/oUHgDu29Fab9ddc4?=
 =?us-ascii?Q?ErmZ/Mb0VQCubLAxXdSxcRQlGtHFy3xY+ifYy40xFeFMQkN5YE9msmk2xHk9?=
 =?us-ascii?Q?mH8PHdnUd/YINBGgFX9Ykh1tTcNZfMIbCBe8SfugiaJqLiiY5Cq6ChmgF5pb?=
 =?us-ascii?Q?QIRgnTScVyDkFfHicoIXe46VJJZ5uOiwl371oFt7d59tMOiWC2LPRh6p2wFt?=
 =?us-ascii?Q?dGW/VjS5XacnFX+LC3Eh02HBbI380ANAJhCGanuJ8ZBjOpupbrlH5GoKYxaa?=
 =?us-ascii?Q?+IdJxCLgZV1Muerr1E+aXGddOHZIGjGXb6/bVhxge520vxMgjFIhYaXfgN8G?=
 =?us-ascii?Q?5zVhE77fFAR1AyNntvyd2605dtg1SmAxFTKoL8zvsvWpSXN4PjrF37vKnRH8?=
 =?us-ascii?Q?f1Yiw0K1vONHNso8AIo6EATeGvHX0QZoMrFgIUilKailFLDPm+sZTJU8hsqB?=
 =?us-ascii?Q?CvOzRrMPXEHFiN9yOXswNwdShWjdkrR4REmmf/tvG0h/gvHU663792r2t45u?=
 =?us-ascii?Q?1HxKhWupfpzAEKXu/okZKJaNhhU6THHS5thLdPFe5wjnzXskrPt9yivffRIX?=
 =?us-ascii?Q?CVduPKwA8MYLcDnVMohXpcEesKwuQkKEAmoEnJZQD1q/vkQKa4HIvB5RkmEa?=
 =?us-ascii?Q?cU0lNtkiXG9AZgGfWCp1nMmrL4sHrfx+ytZ9Jevp5M2c7IjK29XkMcZFs4OH?=
 =?us-ascii?Q?HhVO/tBvb7g4G7j7xaF5CIaH8C66Y/86Cvi8GtfqVk/MMhUv3PeecLdko9uy?=
 =?us-ascii?Q?q2mr3mSVazWldBrQ1awT6V9vbNQCBeHnzx8351yQvdznhg9aUs83mW0pkJ7D?=
 =?us-ascii?Q?hkV2gDwGucTOeDgrOkbMnUr6OxlPPJ0Q2vhvu+TOptcVr0boL2hVBY25mcHA?=
 =?us-ascii?Q?w62ZNLdtPfIrH8UvHiVM9CnNa4iPSzHEegSAJL50HHtyfRiEoexOyXg5O+0k?=
 =?us-ascii?Q?Z0/FHtlaLcclJc3pXCTvI6Se86GbjU23rmONBoSOJGwWD0Gz0yFgncrV4iMa?=
 =?us-ascii?Q?wu7r8VBSw4xBh/M61VgOsYEkgvStjnBDU0pNAmOwCL6zWXnrTtMV/HO/47Do?=
 =?us-ascii?Q?dHfM6SDoWxXXTSQqkoyMnNy8OPoEWvkwKRob4YEhIlvF1Ujzlttt9T8e6iNY?=
 =?us-ascii?Q?e2MuiV5meqbfeTgP4aIT/x+c5HJJ+G6xJRWRT05s9X4EV1sPUunc/17StakH?=
 =?us-ascii?Q?kmBHxHcnzsXOYLMfLC+kWMmPdvu3jFd/D81LuH6dXl1y4eQHYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17be9a-1813-4132-2389-08d8f2854fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 07:36:05.6822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZtEb+fqXEITyRbtEw/E9ttFYoxa975EQEYbJJQ3hrabppw4y9IReWnZVVbLd8clR9gGwzzHB/WqkxnYHa0S1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6352
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/03/29 12:34, Anand Jain wrote:=0A=
> On 15/03/2021 13:53, Naohiro Aota wrote:=0A=
>> The following patch will change the superblock logging zones' location f=
rom=0A=
>> fixed zone number to fixed LBAs.=0A=
>>=0A=
>> Here is a background of how the superblock is working on zoned btrfs.=0A=
>>=0A=
>> This document will be promoted to btrfs-dev-docs in the future.=0A=
>>=0A=
>> # Superblock logging for zoned btrfs=0A=
>>=0A=
>> The superblock and its copies are the only data structures in btrfs with=
 a=0A=
>> fixed location on a device. Since we cannot overwrite these blocks if th=
ey=0A=
>> are placed in sequential write required zones, we cannot use the regular=
=0A=
>> method of updating superblocks with zoned btrfs.=0A=
> =0A=
>   Looks like a ZBC which does the write pointer reset and write could =0A=
> have helped here.=0A=
=0A=
Yes and no. A two-part command like this could fail either on the reset par=
t or=0A=
the write part (which would leave the zone empty). So in the end, the possi=
ble=0A=
error patterns are very similar to using 2 commands, and for the SB logging=
, we=0A=
would still need 2 zones to make sure we do not end up with an SB log that =
is empty.=0A=
=0A=
> =0A=
>> We also cannot limit the=0A=
>> position of superblocks to conventional zones as that would prevent usin=
g=0A=
>> zoned block devices that do not have this zone type (e.g. NVMe ZNS SSDs)=
.=0A=
>>=0A=
>> To solve this problem, we use superblock log writing. This method uses t=
wo=0A=
>> sequential write required zones as a circular buffer to write updated=0A=
>> superblocks. Once the first zone is filled up, start writing into the=0A=
>> second zone. When both zones are filled up and before start writing to t=
he=0A=
>> first zone again, the first zone is reset and writing continues in the=
=0A=
>> first zone. Once the first zone is full, reset the second zone, and writ=
e=0A=
>> the latest superblock in the second zone. With this logging, we can alwa=
ys=0A=
>> determine the position of the latest superblock by inspecting the zones'=
=0A=
>> write pointer information provided by the device. One corner case is whe=
n=0A=
>> both zones are full. For this situation, we read out the last superblock=
 of=0A=
>> each zone and compare them to determine which copy is the latest one.=0A=
>>=0A=
>> ## Placement of superblock logging zones=0A=
>>=0A=
>> We use the following three pairs of zones containing fixed offset=0A=
>> locations, regardless of the device zone size.=0A=
>>=0A=
>>    - Primary superblock: zone starting at offset 0 and the following zon=
e=0A=
>>    - First copy: zone containing offset 64GB and the following zone=0A=
>>    - Second copy: zone containing offset 256GB and the following zone=0A=
>>=0A=
>> These zones are reserved for superblock logging and never used for data =
or=0A=
>> metadata blocks. Zones containing the offsets used to store superblocks =
in=0A=
>> a regular btrfs volume (no zoned case) are also reserved to avoid=0A=
>> confusion.=0A=
>>=0A=
>> The first copy position is much larger than for a regular btrfs volume=
=0A=
>> (64M).  This increase is to avoid overlapping with the log zones for the=
=0A=
>> primary superblock. This higher location is arbitrary but allows support=
ing=0A=
>> devices with very large zone size, up to 32GB. But we only allow zone si=
zes=0A=
>> up to 8GB for now.=0A=
>>=0A=
>> ## Writing superblock in conventional zones=0A=
>>=0A=
>> Conventional zones do not have a write pointer. This zone type thus cann=
ot=0A=
>> be used with superblock logging since determining the position of the=0A=
>> latest copy of the superblock in a zone pair would be impossible.=0A=
>>=0A=
>> To address this problem, if either of the zones containing the fixed off=
set=0A=
>> locations for zone logging is a conventional zone, superblock updates ar=
e=0A=
>> done in-place using the first block of the conventional zone.=0A=
>>=0A=
>> ## Reading zoned btrfs dump image without zone information=0A=
>>=0A=
>> Reading a zoned btrfs image without zone information is challenging but=
=0A=
>> possible.=0A=
>>=0A=
>> We can always find a superblock copy at or after the fixed offset locati=
ons=0A=
>> determining the logging zones position. With such copy, the superblock=
=0A=
>> incompatible flags indicates if the volume is zoned or not. With a chunk=
=0A=
>> item in the sys_chunk_array, we can determine the zone size from the siz=
e=0A=
>> of a device extent, itself determined from the chunk length, num_stripes=
,=0A=
>> and sub_stripes.  With this information, all blocks within the 2 logging=
=0A=
>> zones containing the fixed locations can be inspected to find the newest=
=0A=
>> superblock copy.=0A=
>>=0A=
>> The first zone of a log pair may be empty and have no superblock copy. T=
his=0A=
>> can happen if a system crashes after resetting the first zone of a pair =
and=0A=
>> before writing out a new superblock. In this case, a superblock copy can=
 be=0A=
>> found in the second zone of a log pair. The start of this second zone ca=
n=0A=
>> be found by inspecting the blocks located at the fixed offset of the log=
=0A=
>> pair plus the possible zone size (4M [1], 8M, 16M, 32M, 64M, 128M, 256M,=
=0A=
>> 512M, 1G, 2G, 4G, 8G [2])[3]. Once we find a superblock, we can follow t=
he=0A=
>> same instruction above to find the latest superblock copy within the zon=
e=0A=
>> log pair.=0A=
>>=0A=
>> [1] 4M =3D BTRFS_MKFS_SYSTEM_GROUP_SIZE. We cannot mkfs on a device with=
 a=0A=
>> zone size less than 4MB because we cannot create the initial temporary=
=0A=
>> system chunk with the size.=0A=
>> [2] The maximum size we support for now.=0A=
>> [3] The zone size is limited to these 11 cases, as it must be a power of=
 2.=0A=
>>=0A=
>> Once we find the latest superblock, it is no different than reading a=0A=
>> regular btrfs image. You can further confirm the determined zone size by=
=0A=
>> comparing it with the size of a device extent because it is the same as =
the=0A=
>> zone size.=0A=
>>=0A=
>> Actually, since the writing offset within the logging buffer is differen=
t=0A=
>> from the primary to copies [4], the timing when resetting the former zon=
e=0A=
>> will become different. So, we can also try reading the head of the buffe=
r=0A=
>> of a copy in case of missing superblock at offset 0.=0A=
>>=0A=
>> [4] Because mkfs update the primary in the initial process, advancing on=
ly=0A=
>> the write pointer of the primary log buffer=0A=
>>=0A=
>> ## Superblock writing on an emulated zoned device=0A=
>>=0A=
>> By mounting a regular device in zoned mode, btrfs emulates conventional=
=0A=
>> zones by slicing the device with a fixed size. In this case, however, we=
 do=0A=
>> not follow the above rule of writing superblocks at the head of the logg=
ing=0A=
>> zones if they are conventional. Doing so would introduce a chicken-and-e=
gg=0A=
>> problem. To know the given btrfs is zoned btrfs, we need to read a=0A=
>> superblock to see the incompatible flags. But, to read a superblock=0A=
>> properly from a zoned position, we need to know the file-system is zoned=
 a=0A=
>> priori (e.g. resided in a zoned device), leading to a recursive dependen=
cy.=0A=
>>=0A=
>> We can use the regular super block update method on an emulated zoned=0A=
>> device to break the recursion. Since the zones containing the regular=0A=
>> locations are always reserved, it is safe to do so. Then, we can natural=
ly=0A=
>> read a regular superblock on a regular device and determine the file-sys=
tem=0A=
>> is zoned or not.=0A=
>>=0A=
>> Naohiro Aota (1):=0A=
>>    btrfs: zoned: move superblock logging zone location=0A=
>>=0A=
>>   fs/btrfs/zoned.c | 40 ++++++++++++++++++++++++++++++----------=0A=
>>   1 file changed, 30 insertions(+), 10 deletions(-)=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
