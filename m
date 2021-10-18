Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E65B432358
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhJRPx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:53:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26444 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhJRPx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634572305; x=1666108305;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sRYNWVI2pTwnSpfUliQ4qFgCuBV2Za83MWL/msp8CWc=;
  b=pnfhbihDoAvEvxJCXtEyYXLdufU9/LBr2ctuLxNoj/V54pPFqEfZj4Vk
   DjDux/keq2iDAl2AhqIffdhIXytcPRncniXAiDxJo4kX2fD8vRBad90VF
   n/8+zsQw/r51vtZXgOEnp3Wg0ORj7ZOHJ5UG5qv6T4rv1Cfxu2HSuysgL
   +A1ifP1dRqVFYbanKRq6hzquCHcR0v9zaKn0krSzPZuklMQO+V+WfBIbp
   /VCPZ87AJrIbTOU04IJBYsmIJeitXOnI5aeWzjhqie9ZT28S2mc5mPmdD
   hbutE4CkxdsnZdXbUozuouMfyLhlE1oQHcumDJTa9ACHuHkk2F6VyqIcY
   w==;
X-IronPort-AV: E=Sophos;i="5.85,382,1624291200"; 
   d="scan'208";a="183197778"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2021 23:51:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZaCXGyIN+2ksh9YVz3Y1M7SD8bWDpAXZXkqmrGeFHQV2ikH0S5vDo7fsKqcJrhn2vCJ2GARgjqYxrycV+99Ylpwvujmww4stMzSZqn9BEerTksqmsN3XCQdmzDd08HXTXHQefLiF3UsQ769S/8TzfsGRlaXAyf3ZFwPoek621SstB67Ibn8DekEppMPuNTgL0/JhMIDfUOoTpqhm7Ki1zo5loItoUV0tfITncEl3ALoQEbWrOeROTOehlahjufuvkhaQRf1dA2FD5w+pETXLMrO78AFJjBHla0YGq9zkGLzZ5Kjy07gvh90NeHAAFSDYuiERzKFkbwlu+JxP3+dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E6dUSc4jFOhTjS67czZdFFBxhOjy4hR7lKea5EAuaM=;
 b=f98ewwTfZo70R4EJTrVlgqRfDlttoZNRnteoeaS9X7vFm2cPHf33W2uQleWc15K8cmBOdRBleiTYVXHYXpDr65JpLnzeiY2Th5n+Xrust8rFvHWacf7RxnqfPvxWsiKCs8HMy9obHx01PWETp5PGVULs1Gjff4OJUCuMWOT1Mz3cBmoypV3Psh3JjFM5SMW5aNEbmB0heSnyI7fx7K9cyEB2vXSf6+7mQdQR4RjGXPToz6LfPMedvD5AMIvVeWkW/A3qHVt4322zwJ1qAeDriezFboppm6lLwdAOXRClG/FLr7n6kouwLEMJbGbU2/WlwHKOuBDAwNM9mjAFaTnagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E6dUSc4jFOhTjS67czZdFFBxhOjy4hR7lKea5EAuaM=;
 b=NmYnLhUIAo43ewiJHQfE0JT0TxfQefG9tZ8soa7Q7nhtadEOEMzgnTA26533MCWtViBNfnT8dKjKh7PpOVRf0n2gXN2aQPbUxm43EhBK40mY2ivyeHzyOI8CbkKVOsYDV6iWupdWQSkir96CjErRqvNtyPeu8NJeJcAWwtB9JNQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 15:51:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:51:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Thread-Topic: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Thread-Index: AQHXwN9XEE3aBb2vGkG/7XnB1gVLHQ==
Date:   Mon, 18 Oct 2021 15:51:44 +0000
Message-ID: <PH0PR04MB74162F3F81A0639E55807BC39BBC9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
 <20211018154202.GM30611@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 542e0b2d-bd8b-4e7a-8df6-08d9924f2f96
x-ms-traffictypediagnostic: PH0PR04MB7653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7653A029F0E859D2D5BBC3079BBC9@PH0PR04MB7653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:226;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZPg2EKBiGm+IX0T9grYZrsajifHsv6euwdmzkeQwm4FF2NkSSBpHbniLhidvwJvCPYjsqAb8swKaQmnWNcXkWrVCDECh+gp2ZrHjbjWuWXEBYASdgqUA5Mzb/JfnFKlq43LSrwHbzW7r45oa6MjEfttuUpYDPXShCNs2KTtpvLLVbO34Cx83cgWWYt++4fcbkmX2B6mfDSsmlBtP/1mcBV67X6dCshDoFC/EgMSD8A3XofAhJ7AWq8oYomGQW+vSf33thb8gH6qPAzbKj4vJneC34wknrVtwxrAMpAjIBXzDdiPCJoUPo4gkKJUFjEkuC2sZsSyE6DdC1CDpEkozG/WwFoPRDm5QSbIC2Kq4xL7F8Zd1npn56c+1bv3UfpX+MItyvsEeIulrgE8RRBxf9cuP1H9IPbX1RsAtYNfmiosKLpbD8pYh0RqpvDjU9KiyNkhigOYH/IAIPMeDPF8I7WjHVceHl3Wx4wEFBzcLbJM1Y34ZL4gnOKfEe7Bw1jFd/8rX8osz/35jKTTKeFkHpKbExVxwoaVtBw3jyLfumS3FI4CvdbCArYrlJtARcXZe9TETUHnv8L2ji1LEZLRPLB89hrcBqoyqVBR2wVok4m7Y+1mwG2a/K+JVFvdmMcA1fTEJawai2MxfjT/p/aNkX4fcmHOz+I2qi2DjExiKhUUSRaTRPc5GDebxYKSLMXior8tcITP640bngsdyaCDaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(2906002)(52536014)(4326008)(6916009)(38100700002)(5660300002)(38070700005)(122000001)(83380400001)(508600001)(54906003)(64756008)(9686003)(55016002)(91956017)(76116006)(71200400001)(316002)(186003)(66476007)(66446008)(66556008)(82960400001)(66946007)(8676002)(7696005)(6506007)(33656002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GuwmJftsyIrn8CC4a5ddpENZMS/lXTzfsPN0Wj7FWJxBBNdXyFoG1i/IEZZa?=
 =?us-ascii?Q?LNb3KKWSbHTxuzGZdH4TwgkW4vEscKldrRNFUaW1TDdmLGTiKdeJhbnb8NFR?=
 =?us-ascii?Q?u1SvVU9YNwSOPkWzwxaDx9l/yLotAZVTsQQBk1geJPrEXT/DSZ6LXD60xjE0?=
 =?us-ascii?Q?NHio8B+ueqLn6lbGUcpLqwy0pdYI9Gu5jfcHtMl09XOyZfkLonnQcXBOWRjk?=
 =?us-ascii?Q?kafK548rW0T87NXlHlZhETuFWKldx14q/jIYD2gCVx9bzhKznbzuPUlwoslo?=
 =?us-ascii?Q?UEopRaW0Fqrpfs80Lv/ANAIPg8jQexWK9ayrGdvgKP/2C77lmH9SOb7btUdK?=
 =?us-ascii?Q?jLU1KfIjckDz2nbOALrvbLvhamOSJ/JMU+a5LXxn9tK/VmWx7FQKaOllmMXg?=
 =?us-ascii?Q?xq6fVcRC6I5XcHM+l4VHRqDL997EC8YHfFGr0vOLkmyZVTakac81OSLVdpFJ?=
 =?us-ascii?Q?KWNbXbNoOtoBQfswSbCUrvPfmht88FOHiyUN+oIfrs9LhOjPxu17DeSys6u/?=
 =?us-ascii?Q?K8BQ/SIzZ61woWRzlerUQU6pacLnN55WnZuIQx2IsYqlddxveyC9Dfeeh3KT?=
 =?us-ascii?Q?Pb2nxh4ZrYsBlmcB5zSCXTNkqtpIuDaWKwA+5b10xfl9p22nYqDlu0tzwUwU?=
 =?us-ascii?Q?RMtYDeWb0X7ma2CSww2cuN3nBSi4JjOr+Vmau107jas7qUwhQPuLVlwFuQ4L?=
 =?us-ascii?Q?m0PRKZCuOeotPlmX774d//L5sf+AXxOEZRR3Ei9I/SAkczuQADJWMusVXViL?=
 =?us-ascii?Q?Fi3tewn8bojW4z6cO/LqQVT0nWA+j+CnQMrRF0joEwe8yWqv0e1DuGRxcEJb?=
 =?us-ascii?Q?64tOnUhjdnMmrJkaKBNmENaXrGLudz1vy4YIZiDuiRluGNKBknBUZd7cEDG5?=
 =?us-ascii?Q?x7yfIzHV0V4uRFPSjpXalYaQJ6gSkPRPGY41Hj0CGaszj1c0jVEou96QOxJe?=
 =?us-ascii?Q?5i2L3e2JAYy1MGRZM9ojMRv4pi8HlUJKunBYCtUd5s73dw0uWo5b/pfvwcZw?=
 =?us-ascii?Q?pZsZPUbSat0vJsy7+paXY45RP23jZ05fL0lQWtHBbB8bqcInCdfsPlQI9pB2?=
 =?us-ascii?Q?ZHuj3JXU7D7m768bo/lGzZFo6MC1NvjRQFED1Zxs2a54wRDdQWFMzrNElPh5?=
 =?us-ascii?Q?wA3YBwmV1fL20TXWzWlfa1PfKzhuT0sbpxzqalC8eqXuN7xNCXoLkl7vYwBd?=
 =?us-ascii?Q?OYe50gSkoy2hHfHmrlDp5o2t5BG9c9tusAn/7b1Arzr7GVsoftZ7NpgsZ/hG?=
 =?us-ascii?Q?3dxcuVjweO3QA+IyOauusJrZ66Xzr7i1rznwrCjO4NqtmXBWWAgeq/srOXPG?=
 =?us-ascii?Q?RLO9trykjIUl6DMiCNR48iL3MF3wIVwYuo/mKaw4CcAlJv4NtLmsX+uKK88x?=
 =?us-ascii?Q?6WEeI2z6Ly8tJCMLjUv4ZkAhtwF2gBe8R4UbUmXc5iZKNbXhfw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542e0b2d-bd8b-4e7a-8df6-08d9924f2f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 15:51:44.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9AVVITSE7eqnWP6soPAPYvChQ4GYYmf2eXoC7RCSsyZrBFLmGXfDGIZDNmDQfqnwuzYghDjPkxO33g9cECeNyK9p8MQSxn3TD/W4nYuR0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/10/2021 17:42, David Sterba wrote:=0A=
> On Thu, Oct 14, 2021 at 06:39:02PM +0900, Johannes Thumshirn wrote:=0A=
>> Currently auto reclaim of unusable zones reclaims the block-groups in th=
e=0A=
>> order they have been added to the reclaim list.=0A=
>>=0A=
>> Change this to a greedy algorithm by sorting the list so we have the=0A=
>> block-groups with the least amount of valid bytes reclaimed first.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> ---=0A=
>> Changes since v2:=0A=
>> - Go back to the RFC state, as we must not access ->bg_list=0A=
>>   without taking the lock. (Nikolay)=0A=
>>=0A=
>> Changes since v1:=0A=
>> -  Changed list_sort() comparator to 'boolean' style=0A=
>>=0A=
>> Changes since RFC:=0A=
>> - Updated the patch description=0A=
>> - Don't sort the list under the spin_lock (David)=0A=
>> ---=0A=
>>  fs/btrfs/block-group.c | 18 ++++++++++++++++++=0A=
>>  1 file changed, 18 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index 7dba9028c80c..77e6224866c1 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1,5 +1,7 @@=0A=
>>  // SPDX-License-Identifier: GPL-2.0=0A=
>>  =0A=
>> +#include <linux/list_sort.h>=0A=
>> +=0A=
>>  #include "misc.h"=0A=
>>  #include "ctree.h"=0A=
>>  #include "block-group.h"=0A=
>> @@ -1486,6 +1488,21 @@ void btrfs_mark_bg_unused(struct btrfs_block_grou=
p *bg)=0A=
>>  	spin_unlock(&fs_info->unused_bgs_lock);=0A=
>>  }=0A=
>>  =0A=
>> +/*=0A=
>> + * We want block groups with a low number of used bytes to be in the be=
ginning=0A=
>> + * of the list, so they will get reclaimed first.=0A=
>> + */=0A=
>> +static int reclaim_bgs_cmp(void *unused, const struct list_head *a,=0A=
>> +			   const struct list_head *b)=0A=
>> +{=0A=
>> +	const struct btrfs_block_group *bg1, *bg2;=0A=
>> +=0A=
>> +	bg1 =3D list_entry(a, struct btrfs_block_group, bg_list);=0A=
>> +	bg2 =3D list_entry(b, struct btrfs_block_group, bg_list);=0A=
>> +=0A=
>> +	return bg1->used - bg2->used;=0A=
> =0A=
> So you also reverted to v1 the compare condition, this should be < so=0A=
> it's the valid stable sort condition.=0A=
> =0A=
=0A=
Ah damn, want me to resend with fixed commit message, subject and compare f=
unction?=0A=
