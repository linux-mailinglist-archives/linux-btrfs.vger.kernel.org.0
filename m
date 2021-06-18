Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7F3AC2D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 07:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhFRFUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 01:20:25 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:32956 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232387AbhFRFUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 01:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623993495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4RlMc16y2KFv6JKIx8LiC7F1EWRpGyM4V61M1qApXFg=;
        b=Zpp+82YyFaxNGk54fme2+yHdsp2Bg0ce3J+29Z13qOUlK7+jBmLgBUVsqn1OzwAqTB0yjL
        JA723FrSTtD3n70KPJ80Z+BtWJHdLlyurhczFty44mLSWisxweGeF5SsSCf04nx07A8/F1
        uLfwxkB1rALUwBvHPKSMTt1rn+vRq64=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-JPAjcaXNPY2OuA5RXA8tDQ-1; Fri, 18 Jun 2021 07:18:13 +0200
X-MC-Unique: JPAjcaXNPY2OuA5RXA8tDQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1IFFbdaDOUZnD/nhJvL35L5H2IR5TRRICIWY03L+Cs9rRJiPk9uKT0asE6km/an85CAelZn/fX2ZsNtzZ1EY6hSfjHPJpeN+q3r522uXWHkvfzb3VnVvSVCoobhAAz2nPSk4dB3aGE0mfIy4iL+6brmBkGH6i2mLZfLvcr7m9s3LoMFTY5N38ZEY2Zy1Z+jJ9T6iLhIiIEzattTtKOwN+zengQX6lIc/VplEdnz6GhhA/NYL7pVMoIsgnFSgjBaI+dnK7Lm3I+DH3PQ1aW+odAkHT1ezTdYl8ETeGpdVb7RzGtxoTUIWlhQZCnf/aafZXPPQZ6V9amCuqBOWOZEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+VB/I/De/viUSqjGoV8ejGa94J/PeKJnjLkmTPzzac=;
 b=dqUZgwUtcrY/kE085XCGOpm2fCYpkQD6Hbu9km/LbOL3XLXbsLwZ1HcJL/nUowtMO4+vdnNnt34sPhIqdlYt9ETrVE5GYC8eKhjkkpOsbbqACRtdVGsaOPBHlUyLhsZhhDtduCsjdBuwW2d+29unOY1p28jmOxJyzzIvXtMgEV2CrfOwy9e+ZSrsoQRZdaL8s9ZG5NPqY+KQlHl/LDcZx7VCzy+qOIGX4sXQWibbXRypPkH3sxHBIJ+W/Ogm1BBjwRA5O/atPBX1TRaqVxB+8gh2wU6Qr4rCH4FB8+jmC6rKXN7S5w/7UvcYv0Gi0ZsRk0wC8JqkfsThzeccHs/1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4744.eurprd04.prod.outlook.com (2603:10a6:20b:5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 18 Jun
 2021 05:18:12 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%8]) with mapi id 15.20.4219.025; Fri, 18 Jun 2021
 05:18:12 +0000
Subject: Re: [PATCH v4 2/9] btrfs: introduce compressed_bio::pending_sectors
 to trace compressed bio more elegantly
To:     Anand Jain <anand.jain@oracle.com>
CC:     linux-btrfs@vger.kernel.org
References: <20210617051450.206704-1-wqu@suse.com>
 <20210617051450.206704-3-wqu@suse.com>
 <ed1c6ef3-e7ac-e1f7-d617-5bae3c85257a@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <9ddc2e85-57ed-a097-96bd-e4a63a27ec1c@suse.com>
Date:   Fri, 18 Jun 2021 13:18:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <ed1c6ef3-e7ac-e1f7-d617-5bae3c85257a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:40::23) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:40::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Fri, 18 Jun 2021 05:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211e544f-8503-474b-4732-08d9321877b9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4744:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4744AE8CAAAFFB02C80998A6D60D9@AM6PR04MB4744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Q5J2sOYytLYAK5b0I550ZezeS4Rg0XgKnnrChNzDT2aCAwyKZO6dXgwd/CSgHAgxwm7X5USjBMIY2JRk5y8DVW7RmLZr26dIwZRa4oK85hcvLqJfXlfIlquAI/7k7pqbxpc03eGnSWi1zCBeYNm2gGD2uIGhvvMC6n9WgSQ6mMALdI6cYUoKtLvKFID88hFSl03W1nmdkyrLSrgnQrD8DlaT6JLPH6PczStLItZsVxu3glzVjEZw22h6kQp/WRZ3UZ1nYk5qmrUuSKCPdB96G0mcVjTkiWId2IUSSQCi0/0wPdQnhMoYaHcpzdz81fj1wn6N2zBA6sryRjz3SydmLyYZQPyUhZ47e9UvgxuI3ol1JdjnHq8dt6Pgs7uqF5U3MEcuZb8y1AEcNmZaEhaSv6OFWIt+v1R/Hcmm71h6rA3ftHpozA6EuX1Wtnoj3CxEi8VjscArzsjgPfae9xl2v7D2p3/4+0bG3bZDHWDFcVbD/ab3Uv1A4YuGIBfuA240Fo+o9NvLPL7kayxBHXUXRQK8ahG3vhHeOF67LunZhQIrrBGexlfUx/jbPn44K7XOwuUOOqnexC0qaN2VoOb+XDljvybU4e/hLfXxo29yZtCaTxd0Jp7Bisc3Ft4Ufb2RZ95hGXvGUPg5u1gnm0eV3eMR9Mi9E1DMb0lAhVczQOj/p/Y0+MCtQa0Tlcq2ebI9OusuUOQK7dIM0sI7XHRXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39850400004)(136003)(396003)(36756003)(478600001)(86362001)(6916009)(4326008)(8936002)(66476007)(66556008)(31686004)(26005)(186003)(6706004)(66946007)(31696002)(5660300002)(53546011)(2906002)(16576012)(316002)(16526019)(38100700002)(2616005)(6666004)(956004)(6486002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R00s39qfal4T3yBkRtIQoq9qDt3/7p7jMYTobOu+bj1M817eH3U0JUPGAf/n?=
 =?us-ascii?Q?7rixSmBisJ6NmVYjzmQ+kCzX3hmsCLSPKuN9EGgvc01NtylUb79JrxdBEoXL?=
 =?us-ascii?Q?mlLmeJTkBfjU60Aw22yWHhXVIuRM5c0scz9Y+OBPdzA6jHMdoLOqtNIMKd4c?=
 =?us-ascii?Q?0LKGeDmq/Qjr+bvq9x5BJjZLCXHpObwBCOS6siJAOK+MZuOHVg20LS4BMN0T?=
 =?us-ascii?Q?rqWKtlhIftvWwy6cYt/JMxZJ5H1xo70dCpU9j8JblvBwobuPFeLoMXdsnt51?=
 =?us-ascii?Q?iLOp4j4xnsp/tSYoBmsNU/lj0EBODL2jxUNTlo5Gd5y9FFzSURtDTQOt1cmv?=
 =?us-ascii?Q?b3uvBgxTGrIAlTfChW6QrPBtnnltGqvXmSulerzFjO5nCaRE8Ik/vjblNNcn?=
 =?us-ascii?Q?dr3QIbU3n+X81Q7/4MxyQxLVnW9Cq2aonEhjGyEfubMTX/RtFfGSzOhdurlP?=
 =?us-ascii?Q?K4uVTAK2LuVsGK4EfYhspQ4IdN+t5GISUrGYDGIDcWs2rnJ5kwHS7BtSJHt8?=
 =?us-ascii?Q?YBPcGqFE3MpBIl9L6em0wBBXbzp4fHA4yDyib96CMbyEXAh5zCfTVoug/FII?=
 =?us-ascii?Q?22+IJJTBPfnRLI0RHRj/wI+oqRgktSFflOL4cRERoR/hLTNLKz/urp7p7wrq?=
 =?us-ascii?Q?uxiit0Jcjmahp6QkUOQuzBTCrBFLUPPDIuHlOxGQn0CWdbDR8gA09DzFDIeD?=
 =?us-ascii?Q?av1zLY8WD6Ir5AHfvgBZw/64iV5nbtxkYJ40hMkElC1IBuYwGrG5CI7ujId5?=
 =?us-ascii?Q?6Ss2V45nhq1Ho3a3yVYT7LbqHGOVi+Y+Ivnv166Q55gpnagHE4elk6g5A9PZ?=
 =?us-ascii?Q?evBoghY6DyFVNW7+OcNfisWk3e6PxqAS1Qd0GubylWQWVJKv/1RhFQeJatqx?=
 =?us-ascii?Q?3sO2dCcqrGxInFOXUWJVyYgrnR3ut+oxD9/o8BP4wBaJCQ9wTuN4lOl1UCek?=
 =?us-ascii?Q?cwIDlxYLgu8x4AisvgYSHNbyLnP5uEC9emSj6fz9RsMePWmiFp35ZbBldg1D?=
 =?us-ascii?Q?gB2SE4R/3eVJiBF+/0G16ufoGogN/ZdozfF7v5JJS7EQZdtjZtgQlCugjIBI?=
 =?us-ascii?Q?S69OaC78UzBpLqaCmhQFN7S8RCF+qyVgmNVvB2TcHo/kDlJbTbAzGDUELE5W?=
 =?us-ascii?Q?S13RYmLYU4RY1+klDgUP0rwqPjxLzRyxPvP1QUzXCq6djk4R7fHPOseXG7iB?=
 =?us-ascii?Q?8wnwneeCWcdkF5RUaJVeruj3Ztrde0y1iNofl+YHT1iSwJmKfuencaj6r5oM?=
 =?us-ascii?Q?ITNaJ/YvlAao27zax9H1cW1Zp2nwcde5MjQJfuaoapvBTuPV1gQulOyfrB5T?=
 =?us-ascii?Q?AponMp15gixyYfjhTVnOceAw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211e544f-8503-474b-4732-08d9321877b9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 05:18:12.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz/g9E6UX5bK1A6CNgpf4wv/K3X0ME//I38Ltgm82y40guG0V5fVSkODH0Ou/LEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4744
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/18 =E4=B8=8B=E5=8D=8812:16, Anand Jain wrote:
> On 17/06/2021 13:14, Qu Wenruo wrote:
[...]
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atom=
ic_inc(&cb->pending_bios);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D btrfs_bio_wq_end_io(fs_info, comp_bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BTRFS_WQ_ENDIO_DATA);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BUG_ON(ret); /* -ENOMEM */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * inc the count before we submit the bio so
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * we know the end IO handler won't happen before
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * we inc the count.=C2=A0 Otherwise, the cb might get
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * freed before we're done setting it up
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refc=
ount_inc(&cb->pending_bios);
>> -
>=20
> Looks good so far.
> I understand pending_bios will go away in favour of pending_sectors.
> But here, is there any purpose=C2=A0 atomic_inc(&cb->pending_bios) is cal=
led=20
> before btrfs_bio_wq_end_io() that might fail.

The pending_bios is increased before we may want to submit the bio.

There is no special reason, but we will later merge refcount_inc();
btrfs_bio_wq_end_io(), btrfs_map_bio() into one call, thus I just choose
btrfs_bio_wq_end_io() as a marker.

Thanks,
Qu
>=20
> -Anand
>=20
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D btrfs_lookup_bio_sums(inode, comp_bio, sums);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BUG_ON(ret); /* -ENOMEM */
>> @@ -805,6 +816,7 @@ blk_status_t btrfs_submit_compressed_read(struct=20
>> inode *inode, struct bio *bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_disk_byte +=
=3D pg_len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 atomic_inc(&cb->pending_bios);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_bio_wq_end_io(fs_info, comp=
_bio, BTRFS_WQ_ENDIO_DATA);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(ret); /* -ENOMEM */
>> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
>> index c359f20920d0..8940e9e9fed3 100644
>> --- a/fs/btrfs/compression.h
>> +++ b/fs/btrfs/compression.h
>> @@ -29,7 +29,10 @@ struct btrfs_inode;
>> =C2=A0 struct compressed_bio {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* number of bios pending for this compre=
ssed extent */
>> -=C2=A0=C2=A0=C2=A0 refcount_t pending_bios;
>> +=C2=A0=C2=A0=C2=A0 atomic_t pending_bios;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Number of sectors with unfinished IO (unsubmitted=
 or=20
>> unfinished) */
>> +=C2=A0=C2=A0=C2=A0 refcount_t pending_sectors;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Number of compressed pages in the arra=
y */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int nr_pages;
>>
>=20

