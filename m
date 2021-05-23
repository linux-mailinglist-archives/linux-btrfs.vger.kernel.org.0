Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1B38DDAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhEWXG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 19:06:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29686 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhEWXG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 19:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621811127; x=1653347127;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aNSw2RFBISrKwU/xyqoD/AAYnPBIXn0N7f8dGOF57jM=;
  b=Uh+O5Po20KRw55CIIcn9pBylWK4fWlQSyoi0dhugkxl221gyZIXpa0Fa
   2MtEixqdUu8Y9vDSD82b3umVWoLaMNLvbTfO7rSLQz5ANrd0CxyjdRrDv
   nMyHKGeaUGdm983dKlvZMaDFMR3SsW10DfnZ2oVLti54XfB5HgzDUJ79E
   W17yvpGXjK3JWVOqe1CGDwvaoIAF7x+aZlAd7FXMYDxuoPVI7kbO+1n5l
   sv3a8rCe307Cv7jJOTpNovKuCWJvIkJ71xi9aQnQVrh4DczgE0ajJ9hvE
   TB/MBUnvzusASpwP5z//yF54yQRmQzn+5+B7R9VnhjOCbzlaWFz67ncxb
   g==;
IronPort-SDR: W7Auy1MvBTAikuCTzBoFjnoN1WuXSjU7l8424HOwY9e64ce87oZvSHEvrC5YUUFLIDZeCA3ZDu
 nzXst6Jw4l3ItFKGREK4+9KBXZIhsXQRllMEGBGm7kslNoeEbhT1KcEgU9Y5rceMF68l3fOobv
 6qwx5qU2kEJCEUVqn/v15Zd9yGbrIaNupzC00Eg3TaJGF1u1beMg/rc844/BiRQiAOys6kpA/8
 6JjCRu4kmaMWMLQtm6Rnfe2GIxGtBCJiWIh4X6iyOzqE7Flu8fTKBfwlKOZseWhrzFkDwWmq9x
 Upk=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="169181437"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2021 07:05:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSWiZZQPRyvB8TI+wuI8aTH2BqYL9qayA18yfyqnS8hUv3prFukLcJ+8zedx7/l9xzrRg4X9QiK+dJ/9BQI49vMc4v3luGqHtF+bhleXZUaTvxUKKUs5w6L9ew4Puu7XGYTopxglgyKckHdo7pxHrSxN4sswywaEp2ci2ENGWgnvxY04Gqy0Z0TNZWqJFARF5scXBql3TRDso/IjszRSjO7K30H4ZOTjqE8vBLLOVngYZajiHjfuBHCY2ta3vezNkD40an44uq74/oeYamvKhsxP4juT0hdm0qaP01FWPVJ0XIY2AKnauKwcaQHhRvMTflnIDFAYyVlgrhdvweiCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBt7zS1CzOKyLKaP7DtQfuJ+jJaLoOCHZKsLriwjCg4=;
 b=m8wGJmAE62RFvPuX0aitcvLZOu2KEOTJvqrDbenaWS3FR/6B5sVzYnmD/6l8Sc4qHCwUo/RRmE8JFE2I3BP3gSkzK+HQOE6EY4bINeehhut48QLh/L3OLeC4JeEWV5nUy8JYhjUhuvfBe511HVOM4DCfFX5znsMk5QPJXAZeIFMZblr0qL8WQ9EeZCnnhhgfeBWfWjCr3QtTnZN89Pqy/gz0+ekvYdTJHRcNygmMA3ywZvxd4KVKtrD1aN3imkFfpS/QL6GUcqTh4E4mL/IinqOm1dNf3fZJpW5+e3oSkJcE/FyCL/huDfzgnyzRO8AgZw2sVX0I6d3b3CeHmWBRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBt7zS1CzOKyLKaP7DtQfuJ+jJaLoOCHZKsLriwjCg4=;
 b=VCtyR0j/7iLii2BgG80peOyCNib55FrYxniGMCFZbPGrAUgl25erNeJM8TXDLG6NLQgoii7ngEN8ufZNgf/QHzzthINsGciiOy2NLbmO1oCweiq2FdbFoqptC1IQgBB9f7ttUDLV+sbTIwtALaWRpiH93DMuHnij0Y8VeQJKDmw=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4348.namprd04.prod.outlook.com (2603:10b6:5:9a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Sun, 23 May
 2021 23:05:27 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4150.027; Sun, 23 May 2021
 23:05:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Topic: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Index: AQHXTiFEZpVXeDolGk269PbjlyQw+g==
Date:   Sun, 23 May 2021 23:05:27 +0000
Message-ID: <DM6PR04MB7081AF42EBA082FD09A07BD5E7279@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
 <20210521163705.GO7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffede263-360e-4011-d0ea-08d91e3f4142
x-ms-traffictypediagnostic: DM6PR04MB4348:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4348DA85946222A856CD1ED7E7279@DM6PR04MB4348.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUyTsTD9Xj9oQjTWmdl5deis3o5lWZSZOiOt6ay9/ZqnNdJMgCQvVUis8qjriFhKtOUZOlDGfcZl5yYaj3N6ccBd5bMqOOXVw8cOEXELPGv986kS0X+8zb4G0GWQitYJnzDtn5OWO0Q5ZHXl0jbw58vFE92KRn613BVj4J6FgO1uHEhXOhml3WMrv6IhrqnXKbtWiY7p214TFk34vbdqzS39w2chL2M3i/VD3oUdRI5KnnshM33D2285tmtZTAGAFjfQB0/CiwwtBnq9NLH7Lbfmse20RhsC8ugAtkJ42sapSTNjK7K6HpOUeZcuZX7XZTfaA22aLOLWF6qZ71D9cDdyolog5q9V+9o1e0/T+q3KpYsBVvLgEyTW9+30jqoHR1+c800+qvLGoJeY2Lw3HGH3jK4usM+VyXhTzu8BtqK9fgXGs4phpHZxm7jq/L36XEojsP5KDa7V0NOm2G0abYumetbvaj21Gf+GDznzSOqwtElAZkXWF5LKWcKq31In8hVdbML1AejCWNUZtnfNXnGF0tLiLBD7OYDaYqAjruBX1QIpAXMW2rcWC1l8krYXkGHdn30nvscrjUHF2+KuBTAJySYo9q2sSmCFXtPqAy8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(8676002)(38100700002)(7696005)(55016002)(76116006)(26005)(8936002)(71200400001)(122000001)(6506007)(86362001)(83380400001)(9686003)(53546011)(54906003)(186003)(66476007)(66446008)(2906002)(66946007)(66556008)(64756008)(316002)(33656002)(6636002)(4326008)(110136005)(91956017)(5660300002)(478600001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Mniv1r0Ep/R7rWdDZl882ubbexefvAGjIeiKxkVwrSkU6tGZ+lhWYcdBGCad?=
 =?us-ascii?Q?JILnydIN4EyQrEJPp1A+8dOQu9VOsPS3TQsvJ6KCJPW3EXL0gXaooPFwGmgi?=
 =?us-ascii?Q?X0VzNtpCQN+N5rGfN8i/u9M1ZAJ69MmkS+fDTY+NZSz3JW7X+e9xws6pq+dw?=
 =?us-ascii?Q?jfsL0XGmOjHJhSVZkPbJdQKAsT1h69/z0UZxlS01T63DauAjegzw/sRYyJ25?=
 =?us-ascii?Q?CTDhEzxRyKhW1jq4A1ttVS9Z+zkj/UAuN1g+mbD0r9XVwbqrJLqtD4+dAdG0?=
 =?us-ascii?Q?wKo3jfs+yZYQSyCo/VYB2XJii32HdaRGBEAPQz4uxTsQTcRdbWXFhSfglPh0?=
 =?us-ascii?Q?j6RzwiB/bE5/06D2cFdZ07b1hQEB5clqgWPoi0C8QBMfIA/WUXoIoz8kmljU?=
 =?us-ascii?Q?DOH9agg2pvk5SQ8CAWGa9eNo2qa9w/0zDcmpdaCIywl2XaI6+cWJlPonOX1M?=
 =?us-ascii?Q?dHI6AVuc5++Trfnqrq/MzGmT49DjYpJYltdA2XDMTzcb1mUFyyQpjG/ZSbP3?=
 =?us-ascii?Q?JiuF0J4p/qOmblbR26K05L3DbdE9KCL/avjsMV3KiJV1f+Yfth30qB8VmHJ/?=
 =?us-ascii?Q?xMKyjgss8BLjIUNUdosV7f7FbHVzvzzXYv5I0H40wyAYJ/gDk324gmUMxjP1?=
 =?us-ascii?Q?LvdPPsHI2QvzMCHKzIAy9qNx73IwqGFge7Q9uGr3kBxq1t2RdD7qsP9RP5wQ?=
 =?us-ascii?Q?w9JRbjwA18Jond8tJMK572ve+OF/3xdGgYH90XaI2eXglnPem+o87FmaO2DU?=
 =?us-ascii?Q?fko2MYhUwpm77CmxEtetfPOzEE0ITpTbJ3IVM3Pddj8CECiZSO5nKBXQu04P?=
 =?us-ascii?Q?LflaAwmkODZZPfpcg8evvvsfCk38FG1ta2YavNVVwn1WPRryIuCrtvr4Cir6?=
 =?us-ascii?Q?C+7VD6OVFCtiGtVRHP0akJBoTXNHM+ErBfF0aLb/9EzFelGRILnTbHHgrQmo?=
 =?us-ascii?Q?mP0VNWTHwvaeFoUc3+oVNGbxV3j6RjOGW4ZeisFJ3zrZkE066skTwf3ueGWT?=
 =?us-ascii?Q?8Znu9SdTiYXD4WASQukxMTsEzl/5yMsIIfAgf/7EwPRuL2CxBjECesO8ZrsT?=
 =?us-ascii?Q?ntLqg8M7CGqTDK1+HAtzQrtccMAFm9Lfku2gjGPp2Awh5+JjXwJgCqwAY40O?=
 =?us-ascii?Q?sgPWd6/s0Jqwz2Fa/FXqXnf4uFoywNeoloVoRCI6ms+2Z5vA3ZXyQHww9FPV?=
 =?us-ascii?Q?zJcgmlEYhLrlvKR66tVyxHTY5nAnIaRDAr0gBHwoJIWGab9Y2XaLEkkBxT38?=
 =?us-ascii?Q?5uj3ckbhhZrZrHjqmWvugz3yJLkGAbiuG6ToyCE+CC2c/ol/KeO5nd/AhFEQ?=
 =?us-ascii?Q?HeaNl0sVb5mYAzIcWV6lONIKfCf1B1BXGt97rtuFJAS2IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffede263-360e-4011-d0ea-08d91e3f4142
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2021 23:05:27.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99mM/NNKwEnENPpfqDGt4v2muLLRZIXl3D/Mr2Ary0/T89uc4wg9uBk0KPwlf9Vm1DM8Tx/XeROqacglxb7N1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4348
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/05/22 1:39, David Sterba wrote:=0A=
> On Fri, May 21, 2021 at 06:11:04PM +0900, Johannes Thumshirn wrote:=0A=
>> Damien reported a test failure with btrfs/209. The test itself ran fine,=
=0A=
>> but the fsck run afterwards reported a corrupted filesystem.=0A=
>>=0A=
>> The filesystem corruption happens because we're splitting an extent and=
=0A=
>> then writing the extent twice. We have to split the extent though, becau=
se=0A=
>> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.=0A=
>>=0A=
>> When dumping the extent tree, we can see two EXTENT_ITEMs at the same=0A=
>> start address but different lengths.=0A=
>>=0A=
>> $ btrfs inspect dump-tree /dev/nullb1 -t extent=0A=
>> ...=0A=
>>    item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53=
=0A=
>>            refs 1 gen 7 flags DATA=0A=
>>            extent data backref root FS_TREE objectid 257 offset 786432 c=
ount 1=0A=
>>    item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53=
=0A=
>>            refs 1 gen 7 flags DATA=0A=
>>            extent data backref root FS_TREE objectid 257 offset 786432 c=
ount 1=0A=
>>=0A=
>> On a zoned filesystem, limit the size of an ordered extent to the maximu=
m=0A=
>> size that can be issued as a single REQ_OP_ZONE_APPEND operation.=0A=
>>=0A=
>> Note: This patch breaks fstests btrfs/079, as it increases the number of=
=0A=
>> on-disk extents from 80 to 83 per 10M write.=0A=
>>=0A=
>> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/extent_io.c | 4 ++++=0A=
>>  1 file changed, 4 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
>> index 78d3f2ec90e0..e823b2c74af5 100644=0A=
>> --- a/fs/btrfs/extent_io.c=0A=
>> +++ b/fs/btrfs/extent_io.c=0A=
>> @@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(s=
truct inode *inode,=0A=
>>  				    u64 *end)=0A=
>>  {=0A=
>>  	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;=0A=
>> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);=0A=
>>  	u64 max_bytes =3D BTRFS_MAX_EXTENT_SIZE;=0A=
>>  	u64 delalloc_start;=0A=
>>  	u64 delalloc_end;=0A=
>> @@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(s=
truct inode *inode,=0A=
>>  	int ret;=0A=
>>  	int loops =3D 0;=0A=
>>  =0A=
>> +	if (fs_info && fs_info->max_zone_append_size)=0A=
>> +		max_bytes =3D ALIGN_DOWN(fs_info->max_zone_append_size,=0A=
>> +				       PAGE_SIZE);=0A=
> =0A=
> Why is the alignment needed? Are the max zone append values expected to=
=0A=
> be so random? Also it's using memory-related value for something that's=
=0A=
> more hw related, or at least extent size (which ends up on disk).=0A=
=0A=
It is similar to max_hw_sectors: the hardware decides what the value is. So=
 we=0A=
cannot assume anything about what max_zone_append_size is.=0A=
=0A=
I think that Johannes patch here limits the extent size to the HW value to =
avoid=0A=
having to split the extent later one. That is efficient but indeed is a bit=
 of a=0A=
layering violation here.=0A=
=0A=
> =0A=
>>  again:=0A=
>>  	/* step one, find a bunch of delalloc bytes starting at start */=0A=
>>  	delalloc_start =3D *start;=0A=
>> -- =0A=
>> 2.31.1=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
