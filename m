Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C6528925
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiEPPrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiEPPrp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:47:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4882B1B8
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652716063; x=1684252063;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pannXtw5zpjhdp/4CRWTbU3xB2mlz3woFGoKMkTLXvw=;
  b=Nda7mMs5HIsaDDdJ//AVQ1sdVe6CFggNoIN1a9usGeiS0mJrntX9uDNC
   cZt60H+O/kkMHMBTCiMVcjzJ7Una5lQBE1sKipW/KAZgteqf6RwRdOGBg
   ZlM/4QrDajo3m/wgj/bkIkpJVMl2owNhvdkS4m19VX4D1bM2Iy886Odoz
   UgHXtmrgiPusRAWSpNkLruuIkDuQPbCXzN60itKxLVVKV5T6AlWn9+xZ+
   43EbFcScyWbnZI4CXzLM1lTb4QrIf9peoj1dvAXW2EYgTNn+qizCQ8MoN
   hh3lfiQu+H5NMWT4+1wn8eqwoaBu0dIDpDp1AIUFFp5T6GZXOaufKk2sV
   A==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="200450803"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 23:47:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh0QlRtKw3nhqczv5kRbA2caf6QqtRFTipYlZtyDhQZcHAoyJvX2XsWsZlL7Tkp7zXnSLOtkoLR3kjeCi7yFej1I1ifgNhMuk6FFQRRtxvgpg8TFPOluJNJc5boy81c1sN7/GCTS54B1lNaq2sQlQy/naWV4nS5CqTGG/JTYJHsi2n09uWBEEFZjlRcIXXOzsABNtU/RgrHEYzDkwXK80ncGT8Qns1G4Wp5vj1EKyEYb7UD/f3OL0GM/wqovFWlbiIlkD2b2qeWs7Rf3a1DVdrHIt55rce/gyn6OO9OMSOvx9yjuUreDxgyNEojKDceKCNxJ+ksafloEgieDLMaWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xLGv/660tNNPnhC/tSt7QdxL7v51j2/2IEoWgWxai4=;
 b=KPXiygbach7HxAWYfpwOwOBJbzm4xvBQw8CEN3+8ILy/mZyGIHwAd+PIQzBq8LArZnK08GdYTN2zpXQCrQwd3yzHia07hfxmtNKCL3etWKYAjgJz92zvUZp//IOz7XrlvdgUXQLpVdMT0OKjRkfQ4v5AkXUmNrui1fcGQkHnV3woTFX31YwlJlQc529cMmQene5HKVI/DmzyFseKH9363qUyvm3xDhvvtEKvb/uDIXfoW5E/6B0GxzUzpA3bSfva1qcRZYbv4TbjE26lSM4uLA3lFQHK6QhrI131dSNUj0Rj95PeiPAZZP/OOYEZrb6rxpeXwxbkjmkGTEU9zkn2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xLGv/660tNNPnhC/tSt7QdxL7v51j2/2IEoWgWxai4=;
 b=vzN2/7KwmL30ZkDHnNYQHHCxvlzMc5+lGZkMPYG6P89dbusloZb96UfUkYL4ToL7Gl1kmpGjF8bmOJBYIemW6Pqds1I3iJn9ySSuFffxay+FsY0KsqzX2eaewj9tkAN5irkKy8jcaRCQEIvWzpXWT6WFXO5runyRtPXuRWmOmX0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5449.namprd04.prod.outlook.com (2603:10b6:5:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 15:47:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 15:47:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Topic: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Index: AQHYaTGyNcHorGSGJ0SpCqziAWVW1w==
Date:   Mon, 16 May 2022 15:47:42 +0000
Message-ID: <PH0PR04MB7416F8082825C2CFD2D0FE119BCF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <YoJmpxKoIUKWyevt@localhost.localdomain>
 <PH0PR04MB74166206230DEAF4BED182B99BCF9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YoJpbIKbwEwweAup@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c38fff78-a47e-4b29-2129-08da375369c3
x-ms-traffictypediagnostic: DM6PR04MB5449:EE_
x-microsoft-antispam-prvs: <DM6PR04MB544957A225E8B868F4795B739BCF9@DM6PR04MB5449.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtTArGY8jlBso9Sfkfiz9zNnKQCShpiJGm7BAvgnSs/643ArgBjndOZESv7tPC0mfPz/xvpU2yao7h3TOxtcCzFgN5om2GpECt7iiCqjOKVnZgeDaKhMGwdyhgyeXgeEjobl0jd39qOy9QvYGFESUx/x0aI0Ht7igM6Zqa2PFe/EwXxA5eTIWXNbX10XXthLfk+Ub5v4lcJ7u5n6njcuwyX8pu03eZLaHjy5x1GjKfpeYkkoeBYbAh4QGeEyy+QBwCTxxFJVPUiV8hDFxmonR+xCSy6sCR7Ebl4oqTnBVsfaOm6yOAO8kuA9CCWLhbPQ2X7h0uQoIGZxmhkNNe/W1xiBfPLTfGbOoemfydKAnSb1qhkIj0sfVaJYqD/amvQGMBI6aNpvW0RR5ltJnrWjPPHRtpOvWPx16/a6wYLceLEp4+0cp6QJ/lr5uq+8lZI7frS+zjGFf3/Brll80pVJaug+azCCwqDq3E/ns38b6e2mLSn5rlsBI4Qv2lRsvxBjhTFDT8uPVIzRD/GSMWV2I0PAa+RZMvCFu0gp+uHCL8dI+H9YHGgdq0RVZ3ZNCzqf6uRITIqG0ab74qmcS1QEkgsD0mMD+Er62RJ/lMSiIZg7zH9tUh7aa9cU8JWjSV+RnDFmx2AGRMB5UEGyq8dGCbYkVOjtyWv+mpHr3T0Cpf7lYZg2iZNkjXK/SDnxJjBwtWxjmFueOiJT1fsSlb8Fwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(8676002)(66556008)(66446008)(91956017)(66946007)(66476007)(86362001)(4326008)(6916009)(76116006)(38100700002)(38070700005)(5660300002)(6506007)(316002)(52536014)(7696005)(53546011)(9686003)(55016003)(508600001)(8936002)(82960400001)(71200400001)(33656002)(186003)(83380400001)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TuZ9Kte8n3MVJd2evvrPKXhRfHIM0X37xWqXpwaVEG1NSQWUiMXJE6eMGDjy?=
 =?us-ascii?Q?I/pV/Rk7NJJ8sLw7nYlOCm2PeL6ieR73AlLZk2xf1tHOC+YpqKGDJCbwCAvo?=
 =?us-ascii?Q?O+AP9nTPKA3DvhDwWf1/FIVYY43bFW0aDllp2EqZXcML7sndQUAsGyBnnOAw?=
 =?us-ascii?Q?8ej2EmzEgYFpH3BhFBDiIE4gLi3nnK+LMDlDpAIqYTIXn90wlkOJNcZ/SZhn?=
 =?us-ascii?Q?Vj4U41EmoiH7DTGhR0SPx5KNA6mHHKikEUCmASAWwSXhurt6gzKWhiGy9aeV?=
 =?us-ascii?Q?ly36MZHB0lpVJ58U1uiGndUxrPHFx7496X9XAPh48geandO04AmBsDj3L3js?=
 =?us-ascii?Q?bm+Pu9iTHhBKqWjVp5h4cqQsOLVTzTmW1N+fK7MgY3j22pyQ5nRDxH+3uI41?=
 =?us-ascii?Q?b9Zw2+074iP7BJoYAb2vJs8dLMPgXzrfkUwh5kkgdoh5lmPtHx+OGXoJqADq?=
 =?us-ascii?Q?19O/6a0Sr6vgNk5wmPF6/L0FACelCxH4CNBhdUVH4uRN3KBua+TKkP9ug4g+?=
 =?us-ascii?Q?KL97++vy4pIBYRQvL4AtzRFKOpUnRea2zHLrktniykqqIP/r21Y2Nyy8a9Au?=
 =?us-ascii?Q?xjs+XQHfaLp4EY1MXz1q8Jswhqs/3NRPKKoW3seavpQcncQk9SiyBw7pwwWV?=
 =?us-ascii?Q?WcdVDZy9Cav1cyPzExcfiTmbyGxBS7JcKFlc+3NhLD0b4Gqitad4GZ3ZEbJe?=
 =?us-ascii?Q?Jd8WnegP0VqJl/+PD25AEsEFr8Ap3/RdW14ElT+nOm6Veqdw/ZFaHljn7QJU?=
 =?us-ascii?Q?J82dNYwgLhwH82BG6BXEqCfeMKAJ4NFMIieC1SbUgP4fCzrUpr6Ss3py+/NK?=
 =?us-ascii?Q?h8OiwXhWV0W+kOc8/c9o4vx7w2DyHnrIi8AfkLA4XjO0EvXXCqMLxgjdJXc2?=
 =?us-ascii?Q?dz6PyYTy0rHA1rAO7fm57s7ps8yDapv1wZtuxeEYA3zvU5PYE7m6r/WvduE9?=
 =?us-ascii?Q?pW7vcrbploSoRAvNnRpbSB7hfbc6IREPywcH+GRFHe9Q83fYQwevGHZnhxd4?=
 =?us-ascii?Q?nZc808ciKf6WrymshBB4jfDtUEohlA6XVFcg3T+Nl4de0WNZXXxJSrPG2Ds3?=
 =?us-ascii?Q?9q3pqEq8H/3T6hBmY8cnSLvCinO2GihDim606BpQUcDKH6/LI1uhsKlyyy/T?=
 =?us-ascii?Q?xLcIHkAr0MHke/4BjCoD/TZsgo8lSq36Ci2/qPVwUsYz+8WnrfLE3S9AqqlP?=
 =?us-ascii?Q?4SrvAIDrmhyKxdLStK/39J2iNCN4zqip3lKZ/Fydb37YvZwpdl68mefc9g2V?=
 =?us-ascii?Q?jn5B/p5m8AW8CbPZFt0QV1WR79f+aWvyiRy8wgE3QpO3eXjMoFxjE8pRj4fC?=
 =?us-ascii?Q?X2uAkYFYZew1tixw4FMnLdZ9T+plW3P54Mh3Z7SwhEFNyd7IX0GSiCaJI+Cg?=
 =?us-ascii?Q?sg8icTduCns4H+W3nrt1/+QnbjpjOJRg/hkaPknCd+gYUWs5A+pPYCTt8HJ6?=
 =?us-ascii?Q?CXigXcIGYWcwxGaCZ/9ZAWXEib2Ul61tVdgZJD9Yh8MHUeuXN4kd1E/A0vfW?=
 =?us-ascii?Q?1HWPRFNofuK4W5rFGkuXMjemboU1mW9Zj9I/Gc+NP6yer2lTVcF1MC0H5NQI?=
 =?us-ascii?Q?9pSNYGQG5KMWdW9NJx534JLRoK1FEH+yPjn8eG0oTTScsWX2ZTOAQkGXQHLg?=
 =?us-ascii?Q?wZBKMATyLHtp9uzdZjypp1/yyxfIfvZtB/K9n6J4cms1ASkBsNMEb9GNtVGF?=
 =?us-ascii?Q?ypOrEiof+yZ1k05I+OwsCbRCFKd+SctN37bEIWIfscIrR6c/lhdqqrh4xHIw?=
 =?us-ascii?Q?yl8YPV99p+eFbhz87UQ0rjx6DTTvz1v86p1IFH7ICZWPrhWNU+mSQvxpqTlM?=
x-ms-exchange-antispam-messagedata-1: XjtIhkbNtMIfvzv4xCiHIT01fc9Dsmpn36hWbtAdoyey+arm7K3eTHjb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38fff78-a47e-4b29-2129-08da375369c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 15:47:42.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUPKhyyYlg9BVWVrTXHvWjKMk9YG0V21Ot5I7sAvBRO/OFNs4z77KSTuuPaNi756vv6vCpxEDP9MlKZd1L19GwF+t7cLDfcCbmj8u6a5+7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5449
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/05/2022 17:10, Josef Bacik wrote:=0A=
> On Mon, May 16, 2022 at 03:04:35PM +0000, Johannes Thumshirn wrote:=0A=
>> On 16/05/2022 16:58, Josef Bacik wrote:=0A=
>>> On Mon, May 16, 2022 at 07:31:35AM -0700, Johannes Thumshirn wrote:=0A=
>>>> Introduce a raid-stripe-tree to record writes in a RAID environment.=
=0A=
>>>>=0A=
>>>> In essence this adds another address translation layer between the log=
ical=0A=
>>>> and the physical addresses in btrfs and is designed to close two gaps.=
 The=0A=
>>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and t=
he=0A=
>>>> second one is the inability of doing RAID with zoned block devices due=
 to the=0A=
>>>> constraints we have with REQ_OP_ZONE_APPEND writes.=0A=
>>>>=0A=
>>>> Thsi is an RFC/PoC only which just shows how the code will look like f=
or a=0A=
>>>> zoned RAID1. Its sole purpose is to facilitate design reviews and is n=
ot=0A=
>>>> intended to be merged yet. Or if merged to be used on an actual file-s=
ystem.=0A=
>>>>=0A=
>>>=0A=
>>> This is hard to talk about without seeing the code to add the raid exte=
nts and=0A=
>>> such.  Reading it makes sense, but I don't know how often the stripes a=
re meant=0A=
>>> to change.  Are they static once they're allocated, like dev extents?  =
I can't=0A=
>>> quite fit in my head the relationship with the rest of the allocation s=
ystem.=0A=
>>> Are they coupled with the logical extent that gets allocated?  Or are t=
hey=0A=
>>> coupled with the dev extent?  Are they somewhere in between?=0A=
>>=0A=
>> The stripe extents have a 1:1 relationship file the file-extents, i.e:=
=0A=
>>=0A=
>> stripe_extent_key.objectid =3D btrfs_file_extent_item.disk_bytenr;=0A=
>> stripe_extent_type =3D BTRFS_RAID_STRIPE_EXTENT;=0A=
>> stripe_extent_offset =3D btrfs_file_extent_item.disk_num_bytes;=0A=
>>=0A=
>>=0A=
>>> Also I realize this is an RFC, but we're going to need some caching for=
 reads so=0A=
>>> we're not having to do a tree search on every IO with the RAID stripe t=
ree in=0A=
>>> place.=0A=
>>=0A=
>> Do we really need to do caching of stripe tree entries? They're read, on=
ce the=0A=
>> corresponding btrfs_file_extent_item is read from disk, which then gets =
cached=0A=
>> in the page cache. Every override is cached in the page cache as well.=
=0A=
>>=0A=
>> If we're flushing the cache, we need to re-read both, the file_extent_it=
em and =0A=
>> the stripe extents.=0A=
> =0A=
> Yup ok if we're 1:1 with the file-extents then we don't want the whole tr=
ee=0A=
> striped.=0A=
> =0A=
> Since we're 1:1 with the file-extents please make the stripe tree follow =
the=0A=
> same convention as the global roots, at least put the load code in the sa=
me area=0A=
> as the csum/fst/extent tree, if your stuff gets merged and turned on befo=
re=0A=
> extnet tree v2 it'll be easier for me to adapt it.  Thanks,=0A=
=0A=
Sure. I know that there once will be the need to have meta-data in the RST,=
 but=0A=
then page cache should do the trick for as us well, as it's hanging off the=
 btree=0A=
inode, isn't it?=0A=
