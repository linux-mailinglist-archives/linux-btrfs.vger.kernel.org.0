Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF87529C20
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiEQIRv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbiEQIPv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:15:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC83CA7F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652775203; x=1684311203;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vX/8co8UUxUVogCXKoHntk6dkG91tnFrx0/f3fDcbRM=;
  b=A2w2QZG+nV8rrrWWmTni4TiHReT3iYDElfi5M5FKghHyHUxy/RpECSMU
   0VKaPHOWMBEgNJyh3l2iMweId5F7ULrfrKFp54jWYiD0fsVAMegloSRu7
   j0iqdSUgIASHlc5HYEZzpIPezUWiDxwjX2M3lJEV/eum8i8aNcs32nB4B
   QzVTGozlFwm+aWOZzjDWj8q3UJVAJHeY92K0EnpFoZxZWF48vpArnX+Tf
   K/Ywy3Ohh/LeUJv7ffRJQYOFw5wVZ/nE2zRk0tRaepcxQl7HOI+ognKGd
   GtWkNhjnSgYAWHmJI3V9FaJDOGL9++wLyIJZO4niHZlJCa559DCLybEZD
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="200538345"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 16:13:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhDO2k1LwCcE/nEIjPiYckywASvAj2F8V07W5QcfWMzCqWTeZgqkXMyqgnzZed+T+bFWKwT+c8daWHxEfKA0YXlrv92a5XGOhtbAx9DEh34UuwXPeuT79MdDFXVpfAgszak79I/5ycqjNwVN+ddzq9TyA6240vChtqrhykuocqRr6ttTSgMBRCozEGwpkNLaYJl5ky4U8gKn3ucNGBRgJAtnqwiTz8ieAmUwFULA8jfXLG84KtR3a72qZw5hSU7rbDn/AuF5aeftETOAkKOmoSe/rzeINpQ+xNM3kfcxoRoB5pb4QBJQrqSlLRUWoCYDQPt5pKIhQa3UDhP1Xiy0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrdipEZ663qQJc4huRcm2s6mGaB6Q+MdVSnySL4hTK4=;
 b=aUHOQq5jv/XWVLtg3XPYk3KvVBPPIYUsr7NGMcv83zqwe0+gf8OUZBk9qVPKXWM35pa9h9EYDxuKSkL3BWHK/GPbXM9PdUR/8LaeiFfBFCNJuuUvEaFUHtRJ8/zlIxXMGNDShC1GTd9fdRw7yguzTzSB7YRyqHsi32hIuposLD+ti4vkr04/fWMjN7FdCGiKjUfOqvBQECd7svw87T3EgZC2z2ztqU5BWoUJ3Ugq1Ao7QJjcnq6TZm7NsDo0rAfgNBt91kzxIzQYJzfFE3eQ/gU2R1YVFVTVHeXEyVMdlD2ROHtA+a2nG32Dy7L38Q4x4NiHfLDPHrFuMnwAejvcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrdipEZ663qQJc4huRcm2s6mGaB6Q+MdVSnySL4hTK4=;
 b=JlUnF4Gn43FyxdHuSGwMGt0cfKO3W4zEK8LNz0WFATb7kUtH354SgwWGAL8wfw7xtvaeMTMmJORAEySixaCqwVo1GVczNonu70PjmktlONTLqofbFkl5BjNx7Vc7D4GKfTGPSWLmszs8uL53uOvKY1DuyuTAp2p3vd80NoAvzB8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4938.namprd04.prod.outlook.com (2603:10b6:5:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 08:13:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:13:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Tue, 17 May 2022 08:13:22 +0000
Message-ID: <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0555b88f-2124-4d6c-03a8-08da37dd1c34
x-ms-traffictypediagnostic: DM6PR04MB4938:EE_
x-microsoft-antispam-prvs: <DM6PR04MB49380D3D57FC86C76A8B526F9BCE9@DM6PR04MB4938.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTvrz9aJKX/rpvCTI5YIHuI1LjqllU5MsujKhnYKXaIkwKFNZxvv4hI1QVe1boxN8/6AoukJ05ynsa0PVHNOkTGpj+D2o8YZrO6T32CxvhlEgud65AQYMq5k0PG+Bs409PDF1CEkOy2Rn12+fUtN2BqbN6bEUlu1raqZVtZlDPv7JTjDlTG9uqDKTzLV81mqt6YMt7kIOozcNU0lHfld0BpcyWbgK0RJ0lNPWgTxs13qTL3slaki5qEsr714edUmf5O6CcYFxzo6YFsAkJ2L6oNpPNk1HfPw0oUWvxnTdoYbSSXoCEkbl4hUkBJQGiNUV5RZ41Ote8bAQbtExyv6aYL31SEOdQ56HQQq0I6FbWf+XfRaRduh78vU3QQwGvFIDA65LUaKJHcHUV0RpOhhRkFl9ruW6G5HQYNryLnXVYbyMMFpxBkO+v8/Xjcl/18qjRiXwUE3nO71CidaCGaNo4nV8M/qz2cqvoPDRXQvR8ylGy4ePPa0WUoYnQEiaTn0Cy18Bm2olessS1is8Hr2vSI6uGBo0NvobR+nLyJikXWAY2efhdPlK3rkwGyEnk/yEPNFXkQFSf6Kir/Eyn/Fr+TASTp6LwMpKkdW4g0s7SqoKeTERijWm3YUmHCfxwdSO24s4GKW6wFY5vgvvYjM/yJSvG6f8BleDzd5BL+3yCz+gTCTJ39xDfsdNvIRhDx2zbp3lcDQzlA1rzJ8I7CN4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(9686003)(83380400001)(82960400001)(33656002)(8676002)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(8936002)(55016003)(38070700005)(71200400001)(186003)(86362001)(5660300002)(38100700002)(52536014)(7696005)(110136005)(6506007)(53546011)(122000001)(508600001)(2906002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sOaPNW2/l7sUoJQw+LileMY889sFxFadi7hJrW6ujADy9/91XxdkgIuMZUdf?=
 =?us-ascii?Q?UzL/iuWs6deJLWEZcm4wVN/i3420zJ29BmsqNu+hIGl1ruR/xwsjEZqQzf0C?=
 =?us-ascii?Q?PPowHRaxIF88M85EPx9Z12FA+PTzJD7I0nfHsVT24amwKiaz9w00wlBLzr/V?=
 =?us-ascii?Q?/z/XqqnSaizGG1yUO6syDTfjSaQw5NMn4TPiHwhFoCPl+t44MxL1tZSmWaG7?=
 =?us-ascii?Q?j5o4nNP7Va8t8HwobK71Dv1Ak5zx03kmwMaNoefEIrat5GoNzSMQIow+vnH9?=
 =?us-ascii?Q?BiIyPvG6fyumvjA6o0NU7OD1ZKDfNhGJIOONCIQwYRUTqR3tYLpHwAy1VApA?=
 =?us-ascii?Q?RTn6Ai3kLm2CSn7Ee2tsESLW80pUTzzRL/lIaqza0aTJELMHkCVeqD0mNewh?=
 =?us-ascii?Q?SngQL12Vfn03zaP2tVs4QfjQzpDSMpMj8nt7dqzbYdVajnPSbPojO9CJdfm2?=
 =?us-ascii?Q?LHkudb56kcdcZda3mpRCAGJr8WMToENnuN+ekMXc80HNREw82X7FoxxzOfxz?=
 =?us-ascii?Q?wpi1qWSW0NYVbdYyphadWf8zQv+15QIwKzF+LLLmuEPX7eAOKjGIlOz9/Lv5?=
 =?us-ascii?Q?wpssYDLiI0teD9qLADWrskCoEZ5n9Rql7JRaGq/0T0nD9SZahkh8Ab7hYrBL?=
 =?us-ascii?Q?2FNHS2cR9qzd63BP7LqM+ou8BLhrMpaIb+kjB5LD5ItlcHkXTqc4KhpI1W5a?=
 =?us-ascii?Q?Z8On5NahSJmXGM70fbxfYFlPtPI1tdmriceXR2nvPagUG+0S3+9aRPg9AHpG?=
 =?us-ascii?Q?Vf3lZvVs/aBaRZwu9RsgKz0TU9mI3Mue7BqCQFFBHO+qAnwphRp6X59HuOK2?=
 =?us-ascii?Q?ELRs2vRWMcrAGUCN6O2l9pxRTkJFssWiJHbG0x4AG+iEd+2m7TUyaSyXM9CW?=
 =?us-ascii?Q?s1MbicDEMaY86NsKTLX9dU/2MmsNHTXjJ3bH0oywD4F9V+2gP+YK//Fh7sXV?=
 =?us-ascii?Q?Wo6GeRfw8PRv9wqNJXZn9Q+ahqi4riYxeIoZm8TrLjtBSB5JfwatjBc5xj9w?=
 =?us-ascii?Q?Ox25RsrvA/LAo0y9R3/IgPxNxduLfTRDqonrNkoYLBvk47Ktu2JWcKqOviDu?=
 =?us-ascii?Q?LOgetCEfjoB1coRQO2DcwN8ckQG+vfM9b//QykvWEZiR9aGV1/FbmKJohEMj?=
 =?us-ascii?Q?LFSAUGr5WWiGnB7hX5gJmdQLQHO3C/PaYKijfSl7QBW/NPXPWBV8o55RZE2c?=
 =?us-ascii?Q?cQtC4O55YkvzWeGo4gXDBU/b4IQNMo8VjvJchiyt65n4r+uIo6ZE1lupU5vr?=
 =?us-ascii?Q?DT96FLe27qMiw5SNFyoHzxfy5fFz5hzZYJon/zJZOSW9Ih6wdGHkhrDamLrW?=
 =?us-ascii?Q?ptoA37XXwsS5A6RckzZs6Mr2mjM1nXHrKohe1839ISwAuzZDSLcdrGpQQVSS?=
 =?us-ascii?Q?ojwUgvXiw1VCqz/xB4We8TMteWCGvqRxbPuVZnbvCIdt1UPYmMZCkwvqhy3K?=
 =?us-ascii?Q?7MGDRSUjnhVD1INnJ9774MQV/J7eDQYUKHvgY29QT7yk8vkJafZknn6dUPnw?=
 =?us-ascii?Q?rxYSBSTJ/wFp+L3YUn06uyGbsMpx5Yzy+0FTwRIr8I7bmJgFuurwnbAoxwaw?=
 =?us-ascii?Q?NHJSLUTNvDEu6GfDRvDeMZuClNd5jrTlYOSQdJixZ2Z8pzVcrlRmC3XOyDIW?=
 =?us-ascii?Q?biPdOQEaPRsgIUsxIbv1ZwnBoDAVrA2Z3iv/LzU3BQiaNkylKrI6N52kRSml?=
 =?us-ascii?Q?t85Gz3JnuTl+86Lg9vUO2XjT6twmInqNhiiR0Wl+FHTJdkoLRN/MGM3v9O09?=
 =?us-ascii?Q?F2C0dK4sqHuta2IPe6je2kw06p5c0GVmcHtt7fJAduuC/fJiJyg8gsbxTzrN?=
x-ms-exchange-antispam-messagedata-1: jk7NX/NO95MNm/qElF1euNh05wLCXszAgUsYTeRfVYwQvDZXyh5rilh5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0555b88f-2124-4d6c-03a8-08da37dd1c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:13:22.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQl7qOhK3M0jTvqWNCeo+GM7LpjtBjJ+gJ8DXk/8UvDQ89J3IYKH6gmVmRk+dEAxYnmeyPmVD6a5dZNWlRyWo1/FTIaa7A0TcH+pwOejods=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4938
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 10:10, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/16 22:31, Johannes Thumshirn wrote:=0A=
>> If we're discovering a raid-stripe-tree on mount, read it from disk.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/ctree.h           |  1 +=0A=
>>   fs/btrfs/disk-io.c         | 12 ++++++++++++=0A=
>>   include/uapi/linux/btrfs.h |  1 +=0A=
>>   3 files changed, 14 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>> index 20aa2ebac7cd..1db669662f61 100644=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -667,6 +667,7 @@ struct btrfs_fs_info {=0A=
>>   	struct btrfs_root *uuid_root;=0A=
>>   	struct btrfs_root *data_reloc_root;=0A=
>>   	struct btrfs_root *block_group_root;=0A=
>> +	struct btrfs_root *stripe_root;=0A=
>>=0A=
>>   	/* the log root tree is a directory of all the other log roots */=0A=
>>   	struct btrfs_root *log_root_tree;=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index d456f426924c..c0f08917465a 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -1706,6 +1706,9 @@ static struct btrfs_root *btrfs_get_global_root(st=
ruct btrfs_fs_info *fs_info,=0A=
>>=0A=
>>   		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);=0A=
>>   	}=0A=
>> +	if (objectid =3D=3D BTRFS_RAID_STRIPE_TREE_OBJECTID)=0A=
>> +		return btrfs_grab_root(fs_info->stripe_root) ?=0A=
>> +			fs_info->stripe_root : ERR_PTR(-ENOENT);=0A=
>>   	return NULL;=0A=
>>   }=0A=
>>=0A=
>> @@ -1784,6 +1787,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_i=
nfo)=0A=
>>   	btrfs_put_root(fs_info->fs_root);=0A=
>>   	btrfs_put_root(fs_info->data_reloc_root);=0A=
>>   	btrfs_put_root(fs_info->block_group_root);=0A=
>> +	btrfs_put_root(fs_info->stripe_root);=0A=
>>   	btrfs_check_leaked_roots(fs_info);=0A=
>>   	btrfs_extent_buffer_leak_debug_check(fs_info);=0A=
>>   	kfree(fs_info->super_copy);=0A=
>> @@ -2337,6 +2341,7 @@ static void free_root_pointers(struct btrfs_fs_inf=
o *info, bool free_chunk_root)=0A=
>>   	free_root_extent_buffers(info->fs_root);=0A=
>>   	free_root_extent_buffers(info->data_reloc_root);=0A=
>>   	free_root_extent_buffers(info->block_group_root);=0A=
>> +	free_root_extent_buffers(info->stripe_root);=0A=
>>   	if (free_chunk_root)=0A=
>>   		free_root_extent_buffers(info->chunk_root);=0A=
>>   }=0A=
>> @@ -2773,6 +2778,13 @@ static int btrfs_read_roots(struct btrfs_fs_info =
*fs_info)=0A=
>>   		fs_info->uuid_root =3D root;=0A=
>>   	}=0A=
>>=0A=
> =0A=
> I guess in the real patch, we need to check the incompatble feature first=
.=0A=
=0A=
Or at least a compatible_ro. For regular drives it should be sufficient, fo=
r=0A=
zoned drives mounting with raid without a stripe tree will fail.=0A=
=0A=
> =0A=
> Another problem is, how do we do bootstrap?=0A=
> =0A=
> If our metadata (especially chunk tree) is also in some chunks which is=
=0A=
> stripe-tree mapped, without stripe tree we're even unable to read the=0A=
> chunk tree.=0A=
> =0A=
> Or do you plan to not support metadata on stripe-tree mapped chunks?=0A=
=0A=
I do, but I have no clue yet how to attack this problem. I was hoping to ge=
t some=0A=
insights from Josef's extent-tree v2 series.=0A=
=0A=
Metadata on the stripe tree really is the main blocker right now.=0A=
