Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71E361983
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhDPFwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 01:52:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48295 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbhDPFwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 01:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618552329; x=1650088329;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frsk3Ef7H1lXpNPT8c17iMSAafcPd4qnNZWY5w7YbB0=;
  b=bGE6RcwcsapVFRGpAFh4lOoIFT60uRr65e6QUXQb0xJbW6VBMtjZpwW1
   5HmdgAjqKybP+vrG6/NkiXcHFqqbrmovvbUxU0LT0BXe1UAm84GRfRmwA
   c5DMh6QcG02h9tNEtDSjXkSkMyj23RdzoXxYj/sHLMX1SjvV60rt6Lh6o
   bcZeOMhdMUW1j4tUq95a5TyhVtaKF72deKHnTCuwdM5lFNYIVUkb2w9En
   SGzqlpvd/Ta/8GYdgmLtZIS2VmwlQlT1v+XK1n1YHsnIiX0ex5GYeTAR/
   RRn7es2/owiR3+0lu2Sk8q/b05FTrh6duj/fiT/sVFu3FalOeof1kErC2
   w==;
IronPort-SDR: iY+KlXMJm3ufFHcrEbi6KUYTSqFVX2Lg6Ooe48VPGGkdK3FOXuCV1byZepW5/BaMbKNzgrpCqk
 mTeZAk2hMew5T13z6cAKexa/lsJm4U/PpZYWclD7sFMWlPFtvCJLGdM/aPUmApcwD9FTmBlTun
 PI3FBLaNViWx990q721SG/J7qvNOfegbHePv7ccTqKX/pbMxw/JyybBYOY9pXxbOJYRPm0IYqJ
 pCd9XdrpdKcHCGq3WBl+RKp+H7a3Jxg2KPhqlQBHsbQwdzMvTXTVmP59wtOlOYrRgCU5JJecSK
 MNg=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="165613741"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 13:51:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKCaA7oX/5+m54WLdYVMLCji0fGj/ZwHlutIkYztbyO8pS5WyPZ0XU9WUNNxDnSMEPSXEtx0x7INA8zlIf3bZYWtb9HVJ7F1bJMIeQYVuY3CXViJmYQtFkhN7Jew65jZqDDp1MI0kET2ZUqrMqfCpYIr5XzakbbJjxZmT5vcsnOPBqKMBK7t17AYMSC2eaJOROW0isTuy2jj0XndaWAnCQsiuUCHKWvynQBClPvofshErlqkzdH7U2fGgMvkc4xVsjsoH82fHhQ4Zs+cq9l5rMEK/C8Y5e4Dd1v/ND7H7mfEXqdfFLRidAGes7ZjLDer0nUsPGY0NW2YzfL2GhwqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBqlFqJSewRDmnvJiUBqzKR3te2P65wiZf9oJ1y79oI=;
 b=WXbpouz93e/5r6Mbqh0gqgGRvsgbgyLZQxzZeTO4lv5zHVBxvb24srwAL92+RBXJgu/YkVxQi//Ht2S/XFR19FOT0nE7zhvcaLyRAs+FUxjLAD6jrASsH851HM8IGKI89ANTB+9ISyRcSuHkCsg2U+iGtiauXGwAdq6Nwqbmwvz2/diibgJKnH9vtTYoOXvgW4Nll+6CvMe/jg3qn94y3mabAd7BD6Pl/pg769jMLslDbgoc+do7CcW8rB5i9X2UbN2jJ35DL11bpJoVXnS88eR1oNC0uf/rxr3dbL7TjF2oMjVtYEd4G4ssodV6YTAkXxMQSbL4bGH0yd52bmTg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBqlFqJSewRDmnvJiUBqzKR3te2P65wiZf9oJ1y79oI=;
 b=WYfWfW0ePUuZvbZWUi46xfVk9gLM1PMf9VoHvlmsMXR9PDkpu8jJ//rj7xJ8OomDMA6POeG3SvfMuuWtGId7X11IpRV7WQWSuGBZxLAzq4ZO+yDFH88CnY8ioIcsE3LvLHMs0aCUtl9+ZbxblqEdO+FDFDlHUZUwn/5+qK2r1js=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7286.namprd04.prod.outlook.com (2603:10b6:510:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 05:50:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 05:50:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 3/3] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH v4 3/3] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXMf95vk2qE5XEakS9XTLzZcFnkQ==
Date:   Fri, 16 Apr 2021 05:50:48 +0000
Message-ID: <PH0PR04MB7416CE5BBED2BC4A6CF0A2FA9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <920701be19f36b4f7ed84efd53a3d0550700f047.1618494550.git.johannes.thumshirn@wdc.com>
 <63c82817-751c-b200-abfc-b7e669affa93@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d142fba1-2586-459d-f3c9-08d9009b9616
x-ms-traffictypediagnostic: PH0PR04MB7286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72865F7BC9EDE715008327619B4C9@PH0PR04MB7286.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:422;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JPfWKti9BiN1k3TP+XaIQSWezZYVQb5UVQsigBDW4NbYxoJCiFsIOyuNb0opaSY3UKmXu+Sz0BCXCEgdDNZVnWRnCwqObBbomh/YDybAnxHa5bhz+cVgnA47W9mw6Ur0Up8VieRei2nPVcdF/oNFnyRFC1T9NWgdOXrS6rLeTfqNsAdboHTM7uhwRpTPoMZgb0bDs+3g0ci/Nbtd2crPwfskQhwjKXCC0Sa+XssPHrT3F+FJxVSWqw97BqvZWDq9u0sveIW0pBE+0/YFUz7niFl7rWXrLgd02rvHEBuYJ8QN3ZiGTVy/w/agQJK1Rx3vR1MDlqUVpMd8kiPS8j/VHpYy9AT9RCSYvY1mWbtOduxe2YxM6ilzWWg0AL1/bBRSZ0CI2Pf6eugNxnsE0N5ptcsklHjvQz+DZwW7MjvQcegMUo8lwIJF+CdH3P+G+AbYpRuUM29xN6ptlAzIukb/gs6Hllv0Ug4IqtX/BaweMkT8oAuHjPeDXP1kHV8H/oV4238XppKDrkk6PDlQN/kmozGBHjJMFeV//650kYjDLC/vhYp7iYgDcIu/Nu6/IDvQULbUEQjUBqqOdOWbjPlamPWmHCFm+ASd6XBOJu1pxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(33656002)(7696005)(2906002)(71200400001)(38100700002)(5660300002)(122000001)(478600001)(4326008)(54906003)(8936002)(8676002)(86362001)(52536014)(83380400001)(76116006)(66446008)(64756008)(186003)(66946007)(66556008)(66476007)(55016002)(316002)(53546011)(110136005)(9686003)(91956017)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UjrfOROUNkeDCIoMyNWqCYsqDM1Fla9mT2iq95owtsFV3mTFCGblLEpH32Gz?=
 =?us-ascii?Q?Wv57YId7uq7+aPFQV2iPaXXngnS2YWu7Z9nBOZ0oPjCxrmrfqeHHUoCNmj/t?=
 =?us-ascii?Q?V9VEln19u1ZSBsY+E44y04MtGD/XI2wbs84LkqXv5A6+WDBe0flsBcXR2JLu?=
 =?us-ascii?Q?iZgoRaGJZiyM9d1HdR2lBYviCAZVreCZIY1kF+NzZrqx5g6Z9/nIzKdJA1Xi?=
 =?us-ascii?Q?l4EpXDt9vcJQgBn/oCow8Y13qxS/f4iHTsGj3JvvEBzDBde+rkTdHkErBDyk?=
 =?us-ascii?Q?koff+8hGen6W0OT5t3XkpEUMrS5lsyyVQSt7krFsyLNp5RC0Lq4dyBZaJsIz?=
 =?us-ascii?Q?+7rQeLwa1LdTfZFtRjv5/GQoGDnodGpQcfs1UBpkXffaUw/QDeW3MtnQcDPo?=
 =?us-ascii?Q?701HJPeHN8rJQt+48qyPm1HZXMcxqUdDwkW/Z+w1FY7ygHW3dSCGl2ygRicA?=
 =?us-ascii?Q?GzvybM2yNmbMV67/u36mHaKLFIfatxBxRXmxl9TIxlql2h3PjeE/JCG3o8tI?=
 =?us-ascii?Q?G8kopZ9JKcyS2l5HjY720U/l/8LJsvesvDcSwGofq7vHm0IIENy/Zs6hk8JL?=
 =?us-ascii?Q?LaI9McGaYsHgDK3wLpk9OepTF77wTnvaOyV8xpjvAspaJotVAB26HogEXVKk?=
 =?us-ascii?Q?fqg4XqYFe8unCF3k24Z9KvOmZHIP8WhoILghmjKcOj8+kbDLk9owbOYELBaG?=
 =?us-ascii?Q?IwLKiRdpP7qArehrbHLHf5e3B+NcAXM8mUu5/xPBG4Q3vxegMDPXzMrYFtPQ?=
 =?us-ascii?Q?rkHKiBcdGxQpQjKG7WlCx7p6l86FeciB5xHrrAYz9UV9Oy3qrmbVerOyNIuX?=
 =?us-ascii?Q?FUbkFQek31ZDxi5EBO0j+EkWkTlU0rBrERWW2A+QqAvBXKx2a2W4tHjL095T?=
 =?us-ascii?Q?KngDL+FWFDdJrLvwqJ28DGrDSKlwyRxgZ2YKqiGeub0Sqh6Lx6S7mBjDiivp?=
 =?us-ascii?Q?NcGRzRoh/sv+3uPNO41/Fq5sZmP+BgmFsZrFjOa5BsnTOPD4Du4tcfndeSGp?=
 =?us-ascii?Q?qAcOOhP57EcFF25AfCrji3CldwN57esc5zqI64lKhh8NkpBpCaCTtY+Nr15S?=
 =?us-ascii?Q?WwWxPKSYTpt8vXMix0dCY00T7NV5nD3XPbdeMulq0cBBtr2hcUqBYkcUZhH9?=
 =?us-ascii?Q?bTFzl9eyRW+mu0glbgaXh1QOFlX/Upav9lzw9iJiAM0AV8t5fH+R1bN+Tc75?=
 =?us-ascii?Q?Ezo9VTUAfHKw0VitCwKW+tgqAxcjSJZNoq/lsHjSgW3MS93T8KQ3PGekwlbD?=
 =?us-ascii?Q?G52U5g4Cn9i3xVmhfqqgo/pFuNrrJLvEuVHW8tcQzd3ksgAdluAURaCVIYPp?=
 =?us-ascii?Q?790qU8WT7M+GVGaeJiwG3gAcX6t3j5D//zDHio+HsSwDR3YMfmCyN9qfuhrt?=
 =?us-ascii?Q?JWf0bdiWeXTs7vGzFsjweAhKs61r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d142fba1-2586-459d-f3c9-08d9009b9616
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 05:50:48.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxhsLcm4rDdLscAvBYxbnCgFzPVwhIK/0ILRGvKJ5i7UZHA9tYpJ8x2Fs2P/hupdA8dHiQ98UOtqRWZHWpVXmeySsp+C5/hNuql9NwwmDLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7286
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/04/2021 20:37, Josef Bacik wrote:=0A=
> On 4/15/21 9:58 AM, Johannes Thumshirn wrote:=0A=
>> When a file gets deleted on a zoned file system, the space freed is not=
=0A=
>> returned back into the block group's free space, but is migrated to=0A=
>> zone_unusable.=0A=
>>=0A=
>> As this zone_unusable space is behind the current write pointer it is no=
t=0A=
>> possible to use it for new allocations. In the current implementation a=
=0A=
>> zone is reset once all of the block group's space is accounted as zone=
=0A=
>> unusable.=0A=
>>=0A=
>> This behaviour can lead to premature ENOSPC errors on a busy file system=
.=0A=
>>=0A=
>> Instead of only reclaiming the zone once it is completely unusable,=0A=
>> kick off a reclaim job once the amount of unusable bytes exceeds a user=
=0A=
>> configurable threshold between 51% and 100%. It can be set per mounted=
=0A=
>> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75=
%=0A=
>> per default.=0A=
>>=0A=
>> Similar to reclaiming unused block groups, these dirty block groups are=
=0A=
>> added to a to_reclaim list and then on a transaction commit, the reclaim=
=0A=
>> process is triggered but after we deleted unused block groups, which wil=
l=0A=
>> free space for the relocation process.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/block-group.c       | 96 ++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/block-group.h       |  3 ++=0A=
>>   fs/btrfs/ctree.h             |  6 +++=0A=
>>   fs/btrfs/disk-io.c           | 13 +++++=0A=
>>   fs/btrfs/free-space-cache.c  |  9 +++-=0A=
>>   fs/btrfs/sysfs.c             | 35 +++++++++++++=0A=
>>   fs/btrfs/volumes.c           |  2 +-=0A=
>>   fs/btrfs/volumes.h           |  1 +=0A=
>>   include/trace/events/btrfs.h | 12 +++++=0A=
>>   9 files changed, 175 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index bbb5a6e170c7..3f06ea42c013 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1485,6 +1485,92 @@ void btrfs_mark_bg_unused(struct btrfs_block_grou=
p *bg)=0A=
>>   	spin_unlock(&fs_info->unused_bgs_lock);=0A=
>>   }=0A=
>>   =0A=
>> +void btrfs_reclaim_bgs_work(struct work_struct *work)=0A=
>> +{=0A=
>> +	struct btrfs_fs_info *fs_info =3D=0A=
>> +		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);=0A=
>> +	struct btrfs_block_group *bg;=0A=
>> +	struct btrfs_space_info *space_info;=0A=
>> +	int ret =3D 0;=0A=
>> +=0A=
>> +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>> +		return;=0A=
>> +=0A=
>> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))=0A=
>> +		return;=0A=
>> +=0A=
>> +	mutex_lock(&fs_info->reclaim_bgs_lock);=0A=
>> +	spin_lock(&fs_info->unused_bgs_lock);=0A=
>> +	while (!list_empty(&fs_info->reclaim_bgs)) {=0A=
>> +		bg =3D list_first_entry(&fs_info->reclaim_bgs,=0A=
>> +				      struct btrfs_block_group,=0A=
>> +				      bg_list);=0A=
>> +		list_del_init(&bg->bg_list);=0A=
>> +=0A=
>> +		space_info =3D bg->space_info;=0A=
>> +		spin_unlock(&fs_info->unused_bgs_lock);=0A=
>> +=0A=
>> +		/* Don't want to race with allocators so take the groups_sem */=0A=
>> +		down_write(&space_info->groups_sem);=0A=
>> +=0A=
>> +		spin_lock(&bg->lock);=0A=
>> +		if (bg->reserved || bg->pinned || bg->ro) {=0A=
>> +			/*=0A=
>> +			 * We want to bail if we made new allocations or have=0A=
>> +			 * outstanding allocations in this block group.  We do=0A=
>> +			 * the ro check in case balance is currently acting on=0A=
>> +			 * this block group.=0A=
>> +			 */=0A=
>> +			spin_unlock(&bg->lock);=0A=
>> +			up_write(&space_info->groups_sem);=0A=
>> +			goto next;=0A=
>> +		}=0A=
>> +		spin_unlock(&bg->lock);=0A=
>> +=0A=
> =0A=
> Here I think we want a=0A=
> =0A=
> if (btrfs_fs_closing())=0A=
> 	goto next;=0A=
> =0A=
> so we don't block out a umount for all eternity.  Thanks,=0A=
=0A=
Right, will add.=0A=
