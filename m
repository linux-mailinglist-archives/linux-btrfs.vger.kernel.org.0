Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA14015E2
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 07:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhIFFVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 01:21:30 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:29644 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230340AbhIFFV1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 01:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630905622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccusdhvIS+tSwuU+CYlJcPILCgeM1L4LIzn9BIiXfOI=;
        b=nq+vadlEsVGfsyyOjfsWFyomeA2MZM51v8qW3mZZWXT0fhZ1lUx+kU/d4cZ9xGUmk5O56E
        3w17fcAGDDPMKUAxyOneUmHBdJK3ErrZJKpGt3WumVBb1FPH4tBoabydbp/GsCLgLJbLgn
        F8yI+dfTKiRH4KzrvzshQbhDuDb7GM4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-v2jjVYVFO4S07y9NSCvZEQ-1; Mon, 06 Sep 2021 07:20:21 +0200
X-MC-Unique: v2jjVYVFO4S07y9NSCvZEQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFvEh2XUES403wpTK5RnCKmmOoczKM4mmL+ir8DxV4uaRaYeKMWo2xj+mIBOBT2kUmz4Kzdowmwe3nYY64mZRW85rYx2Q6gNIt0jobMQ7yOPpykulo79Vh/TfCIljVy8tISFh01zbH8bxuKmNk+WmQguVaVRn2iv8UyMF7mTzxY4C4L6E0WP55Rz/F700atyDhWAz3VSxqOjS9pwlPnzgLQKfuSfXfnHqKIBjK21j00NLW7x4Fbck2iVN2Tu/8EJwASpCmgoFmJI6/fmYHHJcKwVnl4gMXexOqyXx3Y2sKwVM1Q2K/jeEiQhsQbqNM9nGmjPq2Dj/9UNdnQ4foLIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WhuWtzoH8cdFcidulHdRsvkYQvXrVRPeAR//GwJfwxs=;
 b=Q6yqNpfXaBqral7tU4diy9l5dgwMF3y1rq8o9U/2FV8dJ/HycE/3LnhKpVeOZns4gGzP0hf2DXgS5k5gMv3HjQhHd41QUtBU5AFm0dGE159W8LBwI/Om/Pq/+aJ106gUSL1/s5GgRlBXNGEkpMFPYdXWhZvKUQUPx0T9xH+ViEyMOnxFHmun8oGQXEhYu2YmV2sAOXWrGSMnW4YHSqstBSRDp8QkTkWTYsaXNDeldUD5w1YiHAp/7+2dseShql8pFybBtCW8y4ITQkkS12hIbOyfZ3lW002eGkthJXZ7Oz+V5kraeFNx4QuTj+WFDVw0+JIabi4K2l1S+8Ajg5Ziug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3669.eurprd04.prod.outlook.com (2603:10a6:209:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Mon, 6 Sep
 2021 05:20:19 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 05:20:19 +0000
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected
 csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
To:     ahipp0 <ahipp0@pm.me>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
 <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
 <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me>
 <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com>
 <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me>
 <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com>
 <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com>
Date:   Mon, 6 Sep 2021 13:20:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Mon, 6 Sep 2021 05:20:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed8349e-fc90-42a3-b86a-08d970f6047f
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3669:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB36691291C385DA46C938F440D6D29@AM6PR0402MB3669.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Zn9KMehB4X4hlRuDmNP0AgJB4+NZOtdlusjCO9MeGpxtMhYV5cNgNHELXdlIFDWJrFwJISSmsPooUj8zX0i6syyvk7c6hbk0vS4Ib7MRxooPIOlkAN+A91V1bs0pEw2OukgJB/2Mm7RBOzE1UPAtU/Re43p7GzBrsoHLQqWrIsDrfLovg2yFa+GqJk5C/Uix077m2iR4uek++2QeMBACwz1+JKZWpJr2qzaJyt100/6pVgrPZmTeKwHz+xTC4y5oG/n3JGiv+43/g82agDNafukfiayroIV+2OvYQo8SIhvu7kNtwjMkzqaeR6fjB1/rATW46SP57XYF9lfpmLAmbuSiiETPzoeNel1TtgNOFXboIGm5msPVb8xh6YJgjptACNRBViDMQ3M5WwoCetHvZWDzKf37Mh5aC9wwbNo2JuzXSzO+OvEXz2nzeDqzVtvWd/Bx+L6D0T6x5DrK1OpjR4iPQ7lP+QOv5c8Nh2uavRGak/5F+RdcXkJFFp3pWOCB7VPK/N8qENeQQLBwHQjPr/2gwjLcNfikAjyH4NwuaRyWhrSOzCHp7+e050izvnn6+WKKuDql9/rwyC/o/4OCBFz8m4G2ebEgxZdtlPj0069b0vTXDcCIj/21HPbRihl5/h4ZXzZkvH8NkzRwTE8ZjY7JeIMmBasbbahOGrQFUMxp8wgAGpEWumvbFhrSJRi1GSiR8uDl6wGH6Y5eiSXKw9Qf10T3KOWzh9PkvP912VAcuv3ajI8ppiiHBmrXc6cRkA/HwVzgfcDnXMVc5u5vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(366004)(39850400004)(6666004)(38100700002)(66476007)(66556008)(6916009)(6486002)(478600001)(31686004)(6706004)(31696002)(66946007)(186003)(86362001)(2616005)(956004)(83380400001)(4326008)(54906003)(316002)(2906002)(8936002)(16576012)(36756003)(26005)(5660300002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osQKn5JjyRQFcfBcMRMRvFgb39DlvgoNETaCLDyDr0X9uO6/i1fyEMaAXkYB?=
 =?us-ascii?Q?SxQveXzGe97xTmHyHkThCVTsMa1I7ikDk+zFc0vSszOdD8g8IjszGa90p8MI?=
 =?us-ascii?Q?cWhiPe64ZG8HgnKflv1G29D0nkUvxf3MIP0NJ0uSSaLQsgV23Hk+BESkpORk?=
 =?us-ascii?Q?YyumAtNp5wSSaumNeb4UULRO5thFq8WWCixxo/RW4/rgql7ow7lx68eUBaLa?=
 =?us-ascii?Q?bvtd4nIBGvd0KlkxuR75PG6e0L6syCPngv5TtlxmdKxNVZ5i02BCjaBnBDXB?=
 =?us-ascii?Q?TNC8UkLAB/3VEC5XhlnQpED9NKZWR/uOSWWAgX/f+aX2NnvlXhKXSDHU0ZlG?=
 =?us-ascii?Q?fO2ercUvLv26PlMlfBZtI7H6Jgz/HYEpLONVCkzLc55wHAKbY+MaTeAlKuI0?=
 =?us-ascii?Q?IJjBAhRW84Lnkr8FQFvxBdfDEM9EkBKkUe73Nm9sfHzls+DhTZR/zwuwF9Y+?=
 =?us-ascii?Q?qv9fYOTCMvKsjbapES7Taj6VOOK3LTcpEFlCUOqtGTjlc43ZVTncTtCsfHJ4?=
 =?us-ascii?Q?yuM7FkNWVQIVz5rYzXpmhB07mFlMMtCwK5r3HhqL4000pPcB2IdbgDfgc1Vf?=
 =?us-ascii?Q?g5phBo6omfjLXZnGba4oYQH+YAIiSfjy4BNwmBXK6rOFBhqncEB2DVKGOQtD?=
 =?us-ascii?Q?S6i0flMc2jLgOCk/G2qDtl6wK55EHi4IuQjowHrff9HVHiugtmNxQE10tsmA?=
 =?us-ascii?Q?nOaRzOLbge/68W7t3MT6aw1ULdazo1cYXqoi/tUY3RYY2bYYeMDQszELRHRw?=
 =?us-ascii?Q?Nj9ibdEwdW36Hhmxa2XuOMxrCFDBxNGIX4SDpRJrF4wKMwL2CqTo9nDAjqBN?=
 =?us-ascii?Q?OjPaAbXuoYnxew83DaxhjL6zxX64/GGBdDaaa3reJ/i0k5gDA3cF6uCaksuf?=
 =?us-ascii?Q?wxd9Dai+4QxxPKU4EMZt28p6IXbyM6WunWQ0caf6gao94XDJ4zuRw5+0iKXy?=
 =?us-ascii?Q?aEn7QhuNnMXodDtRvDl2w0RuSxD5YKI4dvIOV21y6iB0ZAI8FYcAAfFMrgtp?=
 =?us-ascii?Q?fqn0Z4+/Ax7/QgT6Vh+uJgBlQRZShSGahvtO7DFZVpBjS8qwEItlaW3wb/6j?=
 =?us-ascii?Q?6XoX2kFOImI+5TGXpgguQU95Pvhg4cyB8Iv/a3a9lfFwhDLdwNymo0OFxcAf?=
 =?us-ascii?Q?nCqqzlsre/FE0d9uoPYvJzicFGNsonb1eCvqgih+m0Y/1sdtr3WpftTANlGL?=
 =?us-ascii?Q?cY4SBar6elWyGYbHpSCwKooKik+RyMq2g8HFrcEBzcjziU0HVTycG5JA6MoY?=
 =?us-ascii?Q?MB5EP6exENwZWSa+4uk8scJ1n3ONEJo0rDVH+Q+JuCfx4w/Cpu2cr2/E8VD/?=
 =?us-ascii?Q?3nNNUw/LgCx7o1ygD5p9FqBQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed8349e-fc90-42a3-b86a-08d970f6047f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 05:20:19.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79rSM3W5H3v2JqYWG93LSOpkh6RZ+ugTaT98fuWT1gDLXoGMBfuZitvh1FwNbDDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3669
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8B=E5=8D=8812:07, ahipp0 wrote:
[...]
>=20
>> Those offending blocks are some data extents.
>=20
> $ sudo ./btrfs inspect-internal logical-resolve 3109511168 /mnt/hippo/
> /mnt/hippo/home-andrey/.config/SpiderOakONE/tss_external_blocks_pandora_s=
qliite_database/00000011
>=20
> $ sudo ./btrfs inspect-internal logical-resolve 3121950720 /mnt/hippo/
> /mnt/hippo/home-andrey/.config/SpiderOakONE/tss_external_blocks_pandora_s=
qliite_database/00000011
>=20
> I remember it was complaining about the file when I was backing things up=
.
> This file can be easily dropped -- I already rebuilt SpiderOak database a=
nyway since I couldn't back it up.

You can try to delete them, but the problem is, if it doesn't work well,=20
it can cause btrfs to abort transaction (aka, turns into read-only mount).

Thus you may want to delete them, sync the fs, check the dmesg to make=20
sure the fs is still fine.

If that works, then btrfs-check again to make sure the problem is gone.


The csum missing problem is not a big deal, that can be easily deleted=20
by finding inode 31924 of subvolume 257 and delete it.
Or you can easily ignore it completely.

Thanks,
Qu

>=20
>> Can you use some newer btrfs-progs and run check on it again? (not yet
>> repair)
>>
>=20
>> This time in both original and lowmem mode.
>>
>=20
>> As the involved btrfs-progs is pretty old, thus newer btrfs-progs (the
>> newer the better) may cause some difference.
>> (Sorry, I should mention it earlier)
>=20
> No worries.
>=20
> Just built the latest tag from btrfs-progs repository with
> ./configure --prefix=3D"${PWD}/_install" --disable-documentation --disabl=
e-shared --disable-convert --disable-python --disable-zoned
>=20
>=20
> $ ./btrfs --version
> btrfs-progs v5.13.1
>=20
>=20
> $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 257 EXTENT_DATA[31924 5689344] csum missing, have: 36864, exp=
ected: 40960
> ERROR: errors found in fs roots
> found 71181221888 bytes used, error(s) found
> total csum bytes: 69299516
> total tree bytes: 212942848
> total fs tree bytes: 113672192
> total extent tree bytes: 14925824
> btree space waste bytes: 42179056
> file data blocks allocated: 86059712512
>   referenced 70790922240
>=20
>=20
> $ sudo ./btrfs check /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> extent item 3109511168 has multiple extent items
> ref mismatch on [3109511168 2105344] extent item 1, found 5
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111489536
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111260160
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111411712
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D12288
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111436288
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D16384
> backpointer mismatch on [3109511168 2105344]
> extent item 3121950720 has multiple extent items
> ref mismatch on [3121950720 2220032] extent item 1, found 4
> backref disk bytenr does not match extent record, bytenr=3D3121950720, re=
f bytenr=3D3124080640
> backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=
=3D2220032, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3121950720, re=
f bytenr=3D3123773440
> backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=
=3D2220032, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3121950720, re=
f bytenr=3D3124051968
> backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=
=3D2220032, backref bytes=3D12288
> backpointer mismatch on [3121950720 2220032]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 257 inode 31924 errors 1000, some csum missing
> ERROR: errors found in fs roots
> found 71181148160 bytes used, error(s) found
> total csum bytes: 69299516
> total tree bytes: 212942848
> total fs tree bytes: 113672192
> total extent tree bytes: 14925824
> btree space waste bytes: 42179056
> file data blocks allocated: 86059712512
>   referenced 70790922240
>=20
>=20
>> Thanks,
>>
>=20
>> Qu

