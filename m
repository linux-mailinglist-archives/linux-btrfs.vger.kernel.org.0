Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB03C95E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhGOC3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 22:29:00 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:26664 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhGOC27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 22:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626315965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKF29hax+BoS77eqtTqR+c7+rCUdLvav0AIJciCHGvY=;
        b=mkOpmKYbY2S9lhEemWBY4H8v8Z6SoRAG42JrxSXORnx6LjjN3MQzjzMPP7Wl9gdZCIbyaf
        qroQAwyJxP/GXlxY9SyF6c6EZKTRp9tzmmBn3ZXjRSloVoONy+J4HAMjLQ4MyTB3eiQBbs
        BTSiYyEZsvHuQga2XU2Q3Otk6mt/sA4=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-ixgZTt7dMcWXVt9eeoQa0g-1; Thu, 15 Jul 2021 04:26:04 +0200
X-MC-Unique: ixgZTt7dMcWXVt9eeoQa0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WscZOgqD4jVjwQb4NwV0Ze/pAgXaC8FMAeKeWZ4lKx1XMTHKENj45KTrwHf6JAOl1W5alKdRmhgJNPviB6Q/GRtaMbSfpCYUcf3O+nCsEmCS/0lWlawoJznrMKsaO2qZ8PGzDkBPYTELteBXdA+TECoZZu8cPe1fR5b4LYyO5TvXGEVVRQtpKcyrobShqPfyShqLBzw9Se0kjRGt4gk61XQ9Hl9truOwXIzYXiVVCkHkSbhg3877jLILSUJiVKC9fProBK4Mj7DpIHUh6QVbW3L/LRQMq/VfkG7gITnel0qafzAJ5o7sp7FjCnWjwtkSdj3dwTtXsu0rfK6k5gRnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t3NXbGxgaBZhSuB6V5tiXkSmEnVnViKPG5jT0yIT6c=;
 b=fxBisQiDhHNERAbJb6rGOq/edxN4uvTM0sko9KxfaCrsyV3dlzeh8NRqEMfJEH9uDPYVIMIU8kQJSLd9pyrc04YdqK3WwmGJ6Hb13Uh5rJCsj/2ohIt0Kvbml9PrBbCBWXiygGjGlXJPp1mBg34TLdvHj5YG3pBSAzdZ2QuaF2DJQoEpkj5oq9loBWtYTTsPFItg2JFf/Yc1ln4FW/YyZFlzumGE+s4AJjsrRw7+ThlPggM9dqGdSzF9tUPb3rRoLJrjt3HvlzP3tgaPRQKax+swjMOBNbwMydmkqmHd77UsxaWECq29D0iGwzCUdFW4TlnrnzSDNWvGKQkQQEeapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3336.eurprd04.prod.outlook.com (2603:10a6:209:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 02:26:03 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 02:26:02 +0000
Subject: Re: [PATCH] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Anand Jain <anand.jain@oracle.com>
CC:     Zhenyu Wu <wuzy001@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210715012430.111567-1-wqu@suse.com>
 <5efd4bfe-2d62-aaf3-cd2d-e6d6e13d42b0@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <235a08ca-2c67-3cd5-1b22-1f64ccb0f67a@suse.com>
Date:   Thu, 15 Jul 2021 10:25:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <5efd4bfe-2d62-aaf3-cd2d-e6d6e13d42b0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12 via Frontend Transport; Thu, 15 Jul 2021 02:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1667eddb-6ca6-476e-64e7-08d94737e436
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3336:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB333608D23CF409D57EC3649DD6129@AM6PR0402MB3336.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tucSBZFcwpHkoulWBvmWYPFfMyhgwT1megqqI+wdP2j6+84L8VanWDI3kVWAMmDB1ybLuH97Nwt7h1cF5p32k7Np2E/KHHVO+c0WWHeGHEpDrBz2EfNKBe6Kw0MUA7sfkRQKSPhVQ3uXLikJjk0+skvfpJstG3WpEr0NOI2+KKb9IlWWCXke3R1HYSB9Vipr4FkRYgUEMc2SbkJvyyYBhWYLCPbR0B6ZJ7I82LDHjxGbBM8nxC6r1MJIzMWeNmVOXdoOeDRLienRs64pckaLyRrfBLBpnexoByfOv5o5a3Q54Zb/Bf+9wmOhJDxVq5CgwqIv3KkqU5Wa3Eb1rCG83Pby3FFgXF01MgDxsA/elf4+ai3a07VFdTZNd//3GipdvY+8D1ohcQvRHqP2jqtFlWj1Ol5+o3oo/z+zhqAAbe+jQ/GPo87bmAivIJHcdY+Y1Zm6Kcf41ZX7gcIvT+Irpx5+Guec3vlVh9dIcR392xK7lAvD0gXlYs2K9rWB02YaChW0lAExFM4i6L/Yyiod0YArKyw3Q+Svo43WUfcTa/QD7Oe8ApWRdV2SnYsKWnjTZHCf4qY6WOLYn1ZQILPrca8RQML1N1myK6d1TYlcF89B4JWtA/rO/DGDF1cYGkjynx13ut3gchZ52lMpj0OMfwrPcGPqpVo826eePQXuKMPwzDzkQ+yDdb8nim52WyRF31hJ6bQd/H2CcFS7492+C/s567kWp0KqApA09GRnoRCCGzZD+NZf1jBKCb8+sXe9CfI9Mk3FAb49yGC/anJc1mjFW4iuwoWiTusTWUu8Uboh19+iGics4oxEKAHTs6LnnHTlQkZ1agGrU5FMgI59AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(366004)(136003)(376002)(31696002)(36756003)(31686004)(956004)(6486002)(478600001)(2906002)(316002)(26005)(8676002)(2616005)(83380400001)(66946007)(16576012)(186003)(38100700002)(66476007)(966005)(6666004)(66556008)(86362001)(5660300002)(4326008)(6706004)(6916009)(8936002)(53546011)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSoe1AyM847fqF2uziRRO6ZGCZ72I8SBzHrUJLKpXttCrvRDEZoWAtnsPu4e?=
 =?us-ascii?Q?uUlcnjfttpuouoBNZzrNInaPLmdtRDy8HcZ8/xx6zm9kFHW7qktUu8po01mo?=
 =?us-ascii?Q?C6dJazZHLq0ggy0K38JLZWTYqDeAR3XKqyq+RY3hnASAXCQZosqye1vC/Jfb?=
 =?us-ascii?Q?YCE+ZdWdhBsFfTNL4M5nH1BsV5gJlLOd9poiuJwGSFswbmnOzkPLLW4r9vMa?=
 =?us-ascii?Q?hbQTqQTRYlKrAGTATbRq9NqXjyNfrQ/80mhg4z+lM4UJ/QTXf6vK3nCqgnps?=
 =?us-ascii?Q?P1oEhTDcNRiIkYpMuThiANPwkozzjyossDX+U8lRNh8Ws0NxHNEoHDEeyUIu?=
 =?us-ascii?Q?iQNWbS1Usaj20Luzb691Mp9QSrQaEtXgDfoFKJCn40+Gz6wOm/sHBPT+esw6?=
 =?us-ascii?Q?iHTuivdM9xqBftUaD/uM6WaTruQTAHBJIAleR6kGSAP1OZ0j+5wCZvV9d//a?=
 =?us-ascii?Q?EEKmyJBGVRxN9fB9Vr2LarLVid3zJCTM1y7O9LNnXG+3iWCRurkNfPkyMRZe?=
 =?us-ascii?Q?FsbNYpJTnfGeYyXUwkvXpHQhdl6v0W2GvF0KGUOsFAb9HNs7+WV7h8cGLQkO?=
 =?us-ascii?Q?bPH8fPJD5pnEvPxWOPxOjhYxkeZZziQl9NsQri277E048ExWNMXcEmwjUCCN?=
 =?us-ascii?Q?5ACzfXLbrZONXooQ+c8IOEWl7a9aV1gUt+8gCBJTk9dA7iy4MnLnmtyZicN8?=
 =?us-ascii?Q?eYr9mF1OjHLr9/gOGI7U+XdhIThSynH1btEmucLPhhK27qtGWuh+FlqFCVsw?=
 =?us-ascii?Q?OKqYEJ96Ure54IKDaT9MtCfsGXScpdtb5W6tpdZIjEdR6JQ7QcagkFi7BJD7?=
 =?us-ascii?Q?/4QSLU2JOB48qbDwr7he7ihnvpMKVzwVj1BbeLGdmXxJANeYP3+Pb6+LFrXK?=
 =?us-ascii?Q?4MsRgJeyOL0onFygMNfP+HIYbserbqOEEfkxZU8RR2LK5j/LI/aJfEHUfg6G?=
 =?us-ascii?Q?F8+GDWdr/BjDT/F0pRnrQZQ8a+19FFz5xMcZlJtUQjGdgBbuQGCjIHyq4Lh9?=
 =?us-ascii?Q?3PbFTW/uLOG/HEEb/hnpL2deXihNZ1NDWpfw7mRsiq8x8/7rmcf5xyWi/472?=
 =?us-ascii?Q?9iSzWVNR++E3mMbbG8OVMssVW3AtqjRtG1t0vMWqfkXXb9C0kUkfVfwIG8Og?=
 =?us-ascii?Q?Kp4i17k1Gj06fgTwsIlIPXXifRtvwayi2knfIKfO1YcvD6za9WwZrLfC73Em?=
 =?us-ascii?Q?xylCPL3lNtKhiSrXgO8p7ZaGsp+alfi2TDJoqPfAPOzw1DcY20Sy3I+4NuJG?=
 =?us-ascii?Q?BpA2HFE1bS5yZVLNt9IZ1O7/e6+HntVwneMxayuvPW+tb6/7KIWywtEJkvIG?=
 =?us-ascii?Q?gJRJ2O0Q8owCetL4zAdvB7fG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667eddb-6ca6-476e-64e7-08d94737e436
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 02:26:02.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw8E0RjJP917RKUYqVz2V/CrUVLyDXciGdlrUibWKLcj+xxLI3UKV1NshN4DzeBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3336
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8A=E5=8D=8810:17, Anand Jain wrote:
> On 15/07/2021 09:24, Qu Wenruo wrote:
>> When extent tree gets corrupted, normally it's not extent tree root, but
>> one toasted tree leaf/node.
>>
>> In that case, rescue=3Dibadroots mount option won't help as it can only
>> handle the extent tree root corruption.
>>
>> This patch will enhance the behavior by:
>>
>> - Allow fill_dummy_bgs() to ignore -EEXIST error
>>
>> =C2=A0=C2=A0 This means we may have some block group items read from dis=
k, but
>> =C2=A0=C2=A0 then hit some error halfway.
>>
>> - Fallback to fill_dummy_bgs() if any error gets hit in
>> =C2=A0=C2=A0 btrfs_read_block_groups()
>>
>> =C2=A0=C2=A0 Of course, this still needs rescue=3Dibadroots mount option=
.
>>
>> With that, rescue=3Dibadroots can handle extent tree corruption more
>> gracefully and allow a better recover chance.
>>
>> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
>> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/block-group.c | 20 +++++++++++++++++---
>> =C2=A0 1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 5bd76a45037e..33086b882fe8 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info=20
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->used =3D em->=
len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->flags =3D map=
->type;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_add=
_block_group_cache(fs_info, bg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We may have some blo=
ck groups filled already, thus ignore
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the -EEXIST error.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && ret !=3D -EEXIST)=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 btrfs_remove_free_space_cache(bg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 btrfs_put_block_group(bg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_update_spac=
e_info(fs_info, bg->flags, em->len, em->len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, &space_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->space_info =
=3D space_info;
>=20
>=20
>> @@ -2139,8 +2144,10 @@ int btrfs_read_block_groups(struct=20
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>> -=C2=A0=C2=A0=C2=A0 if (!path)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 if (!path) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0 Return -ENOMEM; is correct as alloc failure is not part of the=20
> corruption?

Oh, right. In that case we shouldn't try to fill dummy eb, especially it=20
will also fail with -ENOMEM anyway.

Thanks,
Qu
>=20
> Thanks, Anand
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache_gen =3D btrfs_super_cache_generatio=
n(info->super_copy);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_test_opt(info, SPACE_CACHE) &&
>> @@ -2212,6 +2219,13 @@ int btrfs_read_block_groups(struct=20
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_chunk_block_group_mappings(=
info);
>> =C2=A0 error:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_path(path);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Either we have no extent_root (already impli=
es=20
>> IGNOREBADROOTS), or
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we hit error and have IGNOREBADROOTS, then w=
e can try to use=20
>> dummy
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bgs.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!info->extent_root || (ret && btrfs_test_opt(inf=
o,=20
>> IGNOREBADROOTS)))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fill_dummy_bgs(info)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>=20

