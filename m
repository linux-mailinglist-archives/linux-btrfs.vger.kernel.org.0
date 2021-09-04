Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274CA4009D5
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 07:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhIDFHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Sep 2021 01:07:32 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:21506 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhIDFHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Sep 2021 01:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630731988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNP4CAAmM9VBBJfPdqXdmwgonHMiKxMRtuhKq+orLxY=;
        b=Yrp4ny5Pt98GPGHj2Cm43E7Hr04xf/uZLTrP3jAVeg4fmX6PggWyWT7Kpdygn5fSDBt1vj
        O/GJHoMEYK+CRxdtHkk0cNk68B97f+r/ODzkaOf7/YRBB04ykKxRVFycoBD71yVNTZCHkU
        4pM+1SdMfzcBhfSWaVyJ9+ukwuetVM4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-WYyxSZAuPkW0PZMOjE1tFw-1; Sat, 04 Sep 2021 07:06:27 +0200
X-MC-Unique: WYyxSZAuPkW0PZMOjE1tFw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPnItKEP4c8P2U4zOO88EhTlMWNAV+tj3MKOzQTTQaSooHiBwNeDdYxvLQmB+zmTZ/yWBfD5o46+C8r9qm1bc/XVXxbJkOLjb3F7NZQkPEsM88/Mt5IOVxbKdwzerQHAS+qifZQb7ASy+/FRbsSTi/A8ohoKNn7tOrg6YCMz3qnuq3PQmjMVN3dzxid5qSpyFQbsqvTbAWapRMUpB8Pp5Nkg8QW+M6zrSfJ/7jF5Pa2OiOZQ6fVzEdQb/EEXTs49NqCEu/UacLI4M9Xh+AZ5q0UnZrgQM3yG6sVtWddOKIYOyUxSc6+6+v+wv8EgrKfntQp2aznG07hMsg988kUXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ScqzRe5FJhb261uZaGmCwpUjPxLENrkWaEQzPNXpTO8=;
 b=KyNV5/x0XkXqwT7oGzwcs4rx4zLBskTc00UJ+elY5I8sEeHgugzSPAYNxKOLHprNnd80vrNiK5NgkLeHWEnK4H7e9t8dG6gKa298VSu+pUT1ExSeQIu/HU7TAIfYBjICo0d7q2Pjq5fBEV2EZaZPeamdZ/M2Z0+/viMDzcNdrs8hZ66mNX+MdPBn/WK1qk4I0XBXwAhlwOC2rRNIzCWyXrDIDBWYDgfP3Fvm4I85FyvEbi+QF0BB+ZEdE1BPJve+iSgReEVz8cvZWTJNRaNJ1dX7n4s5XcO9hYUtTiqOqzkhpJzxcWW/uZqqgXhg9vAD85wOFRGRce/kMtK+XVKo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Sat, 4 Sep
 2021 05:06:26 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4478.024; Sat, 4 Sep 2021
 05:06:26 +0000
Subject: Re: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node() and
 btrfs_check_leaf()
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210902130843.120176-1-wqu@suse.com>
 <20210902130843.120176-2-wqu@suse.com>
 <4cebfa71-59cb-fa71-d9aa-a3707778cc0c@suse.com>
Message-ID: <6bc4fb68-8e79-9c1f-af63-d4d2858dc0c2@suse.com>
Date:   Sat, 4 Sep 2021 13:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4cebfa71-59cb-fa71-d9aa-a3707778cc0c@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:5::13) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:5::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Sat, 4 Sep 2021 05:06:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 548357c3-0395-440f-2b12-08d96f61bf4d
X-MS-TrafficTypeDiagnostic: AM7PR04MB7015:
X-Microsoft-Antispam-PRVS: <AM7PR04MB7015D264BBED818B9886CB1ED6D09@AM7PR04MB7015.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f09+DYsJJ2j7CLGSpxoIWHXPhuZEBttN77Nfhm1D1XSklKrt0fI7zjYEujbIcLOgk7lpGva9hzOyVUCVAdwPgVvOLXqHbV5QuqLN7a/sG5krLhCun5ye1ZSnpIPTRxmGClKcwVUMQ1kaaQjzjUtDTTLnn3XdABvv/tUlSstpAo1HLmz8h62nUuKk3oeUMSB4nxh8yqbp7UF7eMvhSjL4mDcR2KTBWlzZb65rRgatIOEtLzI5m4yol3kBMry8kuwFM7FRpaDrJf9LIzOEA3oF78ydtE5fzskHtpcXOTwmcQ+6iAtUxa1Wf2ExdgX+4oiulbRCeafZFDjmn2Lo33h87Mu2qElbN70wrN+ZeKLKcTexqEpT/2t3V/ey+/SheLjrBdOhMwdvFi5OyrN59e1VPcbl24XT4RcF9elKstNcdcIAhNjuZZc0cBGw19oLXxzseRUCxgCa/iCSIoZOADa5TFCKOZUo7VrQLcg9q3g5ya4xS+xFlaaaksW554dlKboW3oX2wiOOWjPdIYnAn8sIVqItYKWZKX3z3nHz51rRBHAKMW3EgeMJFGfN7VkIyk0SpX7eb7yVBFkNDQ++/I3EosNbIfyg2mfeDlgMYojfE5CR20x89cl9ThSlbAwKK22R1aMKKXCGL731Jup2a4/D/eCxJL/8h5O8YlUgvUHyh5QS5sVH33eWl0lBbLbI+rkWughYf2+sBDbvmWj20ztOUYQ1vev1I8fXPve8Sk7wV3b9CvAn7vtjLlHRhcErtp/S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(6486002)(316002)(83380400001)(66476007)(66946007)(66556008)(16576012)(2906002)(31686004)(6666004)(36756003)(31696002)(6916009)(26005)(2616005)(38100700002)(956004)(5660300002)(8676002)(86362001)(8936002)(186003)(6706004)(478600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4h8BqdPHpRNko5hpTZiYxfwV042Avh+3ALfpCcKp0ghzkCJn00pb6bEXNsc?=
 =?us-ascii?Q?KYsWCmUP/0P3pcfuSpBpXTPQnnRtHT0kuAXC1ystiAvbGIhrxSMuQwDibssd?=
 =?us-ascii?Q?Ni04agXXCCZum8z39GWGXU7qYdoGfFD5jL5TDsVIHSdX15q5YcKmsFyYAP/Z?=
 =?us-ascii?Q?4a5/OjBYvpOKA7G5RTdC5+T6DhrS6vvf53XIIFBL9d5iXozv1xm9Dn2iOeSz?=
 =?us-ascii?Q?5hTaIMKFYV+BrzJQIrivX4todIbLsR653hBy3QEve0hlmGfo34//h19MsVU3?=
 =?us-ascii?Q?tFjNHmLq4MHI5ceRIEg4VBxT/udpB8q20tXROR4Mi+CMtj6MIDkY7yS1kYo/?=
 =?us-ascii?Q?GpWHy7k8vsxxnkmsl2D8DEej59LrYSChcpssrvE+gbE03c4kHnKnPArQCaoJ?=
 =?us-ascii?Q?t8YyydZOp9Pn48VR5DL8aMKEGGLk7TwQL9dO28VwMR6bVD5XxGP8MegWqUXi?=
 =?us-ascii?Q?vanHyEBeceYn9QVD2NtcHaKTHJFpWL0xD+wHRjmFxJzkjzFpDJU86WmtaRrB?=
 =?us-ascii?Q?BilCkLcamdVklyyHhw0q23AzkbAh83vEp5FizNvCwR9wskzTwLCdImHlq+SP?=
 =?us-ascii?Q?chUDKu/PrELUrsKa8RejNrdtfalr//6ROF47123t88HIoEEM+0Vko8w+gxmR?=
 =?us-ascii?Q?3A7zUy0B15XmilRAPcu68i4g/NUW4VBHAQupkAcielDfQkSwYqTnjb7yHh6P?=
 =?us-ascii?Q?9UMV/nLapi6JBPCRxVMF7Qw7q0qE2AJmu3lFZmDGF6wtolOxjDEd/imuPsbh?=
 =?us-ascii?Q?RihtCuHCVj61FZRRwtF4W/FUydjNtg5CO85UeIALc1V1sk8pNuk8QQez0D1U?=
 =?us-ascii?Q?sPJHFfnM3dcmX5oXpHDt+PNqJZiQKybyZalLOinBgwcHxWsXmbeBww/ZYNET?=
 =?us-ascii?Q?+d9QNezMyhxtiF8tEwRumK4le1A2j9z2Lct+PhXLoZ06W+JqCfNQV0ftfdXL?=
 =?us-ascii?Q?SoGq1a+8xgPwOLm1y/jyZ7NOagcKUczGhtGhKciD3XP/Wora2Vdzr2jCvlSP?=
 =?us-ascii?Q?jB9eTpYw1ggreGbV4kUQctHxzJ/NDgE7NCOQ+K0aLEDp8+4zCPVcGyfoqLPs?=
 =?us-ascii?Q?VfEn4v/rdMSiF0YvadT1dRX2kzaROZJlNFpbplqtWWKVxsycDi/56nwe+OqY?=
 =?us-ascii?Q?lxOsFzD++4V1X71mlxwfcJZZ71y1a4aVYuKzMAsCbyb88sybCQRrFfyflXcp?=
 =?us-ascii?Q?UOPasbC6Et0FMblvfAM8EHsXXfNMUnQFmrNHFUZr6d9AiIW/ZHZljflZ60Lf?=
 =?us-ascii?Q?j6qTyz+V1Sr1t6CDuCe1l68wrv0fUBFRAO20rws7+eMeo7pGAsj0KY9SI3As?=
 =?us-ascii?Q?zprziiXiaRu7HInAdtJ8RuFr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548357c3-0395-440f-2b12-08d96f61bf4d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2021 05:06:26.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZk1emBVaLF6EMBGlgNRLaPGfgf331/644IQJGrj1iqXFInZ+qKXXgOpqcoIU99+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/4 =E4=B8=8A=E5=8D=888:56, Qu Wenruo wrote:
>=20
>=20
> On 2021/9/2 =E4=B8=8B=E5=8D=889:08, Qu Wenruo wrote:
>> In kernel space we hardly use btrfs_disk_key, unless for very lowlevel
>> code.
>>
>> There is no need to intentionally use btrfs_disk_key in btrfs-progs
>> either.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++---
>> =C2=A0 check/mode-original.h |=C2=A0 2 +-
>> =C2=A0 kernel-shared/ctree.c | 64 +++++++++++++++++++++++---------------=
-----
>> =C2=A0 kernel-shared/ctree.h |=C2=A0 4 +--
>> =C2=A0 4 files changed, 42 insertions(+), 37 deletions(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index a27efe56eec6..ff1ccade3967 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -4162,7 +4162,6 @@ static int record_bad_block_io(struct cache_tree=20
>> *extent_cache,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_record *rec;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cache_extent *cache;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache =3D lookup_cache_extent(extent_cach=
e, start, len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cache)
>> @@ -4172,8 +4171,8 @@ static int record_bad_block_io(struct cache_tree=20
>> *extent_cache,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_extent_tree_record(rec))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> -=C2=A0=C2=A0=C2=A0 btrfs_disk_key_to_cpu(&key, &rec->parent_key);
>> -=C2=A0=C2=A0=C2=A0 return btrfs_add_corrupt_extent_record(gfs_info, &ke=
y, start,=20
>> len, 0);
>> +=C2=A0=C2=A0=C2=A0 return btrfs_add_corrupt_extent_record(gfs_info, &re=
c->parent_key,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 start, len, 0);
>> =C2=A0 }
>> =C2=A0 static int swap_values(struct btrfs_root *root, struct btrfs_path=
=20
>> *path,
>> @@ -6567,7 +6566,9 @@ static int run_next_block(struct btrfs_root *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 memset(&tmpl, 0, sizeof(tmpl));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_cpu_key_to_disk(&tmpl.parent_key, &key);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpl=
.parent_key.objectid =3D key.objectid;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpl=
.parent_key.type =3D key.type;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpl=
.parent_key.offset =3D key.offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tmpl.parent_generation =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_ptr_generation(buf, i);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tmpl.start =3D ptr;
>> diff --git a/check/mode-original.h b/check/mode-original.h
>> index eed16d92d0db..cf06917c47dc 100644
>> --- a/check/mode-original.h
>> +++ b/check/mode-original.h
>> @@ -79,7 +79,7 @@ struct extent_record {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_root backref_tree;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head list;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cache_extent cache;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key parent_key;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key parent_key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 max_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 nr;
>> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
>> index 0845cc6091d4..c015c4f879c1 100644
>> --- a/kernel-shared/ctree.c
>> +++ b/kernel-shared/ctree.c
>> @@ -568,11 +568,10 @@ static inline unsigned int leaf_data_end(const=20
>> struct btrfs_fs_info *fs_info,
>> =C2=A0 enum btrfs_tree_block_status
>> =C2=A0 btrfs_check_node(struct btrfs_fs_info *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key =
*parent_key, struct extent_buffer *buf)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key *pare=
nt_key, struct extent_buffer *buf)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key cpukey;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key key;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 nritems =3D btrfs_header_nritems(buf)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum btrfs_tree_block_status ret =3D=20
>> BTRFS_TREE_BLOCK_INVALID_NRITEMS;
>> @@ -581,25 +580,27 @@ btrfs_check_node(struct btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D BTRFS_TREE_BLOCK_INVALID_PARENT_K=
EY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parent_key && parent_key->type) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key(buf, &key, 0)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key_to_cpu(buf, &=
key, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (memcmp(parent=
_key, &key, sizeof(key)))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; nritems > 1 && i < nritems =
- 2; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key(buf, &key, i)=
;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key_to_cpu(buf, &=
cpukey, i + 1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_comp_keys(&key, &c=
pukey) >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key next_key;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key_to_cpu(buf, &=
key, i);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key_to_cpu(buf, &=
next_key, i + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_comp_cpu_keys(&key=
, &next_key) >=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_TREE_BLOCK_CLEAN;
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_owner(buf) =3D=3D BTRFS_=
EXTENT_TREE_OBJECTID) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parent_key)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_disk_key_to_cpu(&cpukey, parent_key);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memc=
py(&key, parent_key, sizeof(struct btrfs_key));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_node_key_to_cpu(buf, &cpukey, 0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_add_corrupt_extent_rec=
ord(fs_info, &cpukey,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_node_key_to_cpu(buf, &key, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_add_corrupt_extent_rec=
ord(fs_info, &key,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 buf->start, buf->len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 btrfs_header_level(buf));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -608,11 +609,10 @@ fail:
>> =C2=A0 enum btrfs_tree_block_status
>> =C2=A0 btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key =
*parent_key, struct extent_buffer *buf)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key *pare=
nt_key, struct extent_buffer *buf)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key cpukey;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key key;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 nritems =3D btrfs_header_nritems(buf)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum btrfs_tree_block_status ret =3D=20
>> BTRFS_TREE_BLOCK_INVALID_NRITEMS;
>> @@ -639,7 +639,7 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nritems =3D=3D 0)29368320
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_TREE=
_BLOCK_CLEAN;
>> -=C2=A0=C2=A0=C2=A0 btrfs_item_key(buf, &key, 0);
>> +=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(buf, &key, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parent_key && parent_key->type &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcmp(parent_key=
, &key, sizeof(key))) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D BTRFS_TRE=
E_BLOCK_INVALID_PARENT_KEY;
>> @@ -648,9 +648,12 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;2936832=
0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; nritems > 1 && i < nritems =
- 1; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key(buf, &key, i)=
;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(buf, &=
cpukey, i + 1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_comp_keys(&key, &c=
pukey) >=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key next_key;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(buf, &=
key, i);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(buf, &=
next_key, i + 1);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_comp_cpu_keys(&key=
, &next_key) >=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fprintf(stderr, "bad key ordering %d %d\n", i, i+1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto fail;
>> @@ -676,8 +679,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nritems; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_item_en=
d_nr(buf, i) >
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_LEAF_DATA_SIZE(fs_info)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_item_key(buf, &key, 0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_print_key(&key);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct btrfs_disk_key disk_key;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_item_key(buf, &disk_key, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_print_key(&disk_key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fflush(stdout);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D BTRFS_TREE_BLOCK_INVALID_OFFSETS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fprintf(stderr, "slot end outside of leaf %llu > %llu\n",
>> @@ -692,11 +697,11 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_owner(buf) =3D=3D BTRFS_=
EXTENT_TREE_OBJECTID) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parent_key)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_disk_key_to_cpu(&cpukey, parent_key);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memc=
py(&key, parent_key, sizeof(struct btrfs_key));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_item_key_to_cpu(buf, &cpukey, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_item_key_to_cpu(buf, &key, 0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_add_corrupt_extent_rec=
ord(fs_info, &cpukey,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_add_corrupt_extent_rec=
ord(fs_info, &key,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 buf->start, buf->len, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> @@ -705,22 +710,21 @@ fail:
>> =C2=A0 static int noinline check_block(struct btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path *path, int level)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key key;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key *key_ptr =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 struct extent_buffer *parent;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key *parent_key_ptr;
>=20
> This is the cause of fsck tests failure.
>=20
> @parent_key_ptr is not initialized, but I'm also wondering why compiler=20
> is not slapping a big warning onto my face.

Not sure why but neither clang 12.0.1 nor 11.1.0 gives me any warning on=20
the uninitialized pointer, even if -Wuninitialized is specified.

Any idea/suggestion to detect such uninitialized pointer?

Thanks,
Qu
>=20
> Will update the patchset and even try to figure out why compiler is not=20
> helping me in this case.
>=20
> Thanks,
> Qu
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum btrfs_tree_block_status ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->skip_check_block)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->nodes[level + 1]) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D path->nodes[level=
 + 1];
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key(parent, &key,=
 path->slots[level + 1]);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key_ptr =3D &key;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_node_key_to_cpu(path->=
nodes[level + 1], &key,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path->slots[level + 1])=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent_key_ptr =3D &key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (level =3D=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_check_leaf(fs_=
info, key_ptr, path->nodes[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_check_leaf(fs_=
info, parent_key_ptr, path->nodes[0]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_check_node(fs_=
info, key_ptr, path->nodes[level]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_check_node(fs_=
info, parent_key_ptr,=20
>> path->nodes[level]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D BTRFS_TREE_BLOCK_CLEAN)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
>> index 3cca60323e3d..5ed8e3e373fa 100644
>> --- a/kernel-shared/ctree.h
>> +++ b/kernel-shared/ctree.h
>> @@ -2637,10 +2637,10 @@ int btrfs_del_ptr(struct btrfs_root *root,=20
>> struct btrfs_path *path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int level, int sl=
ot);
>> =C2=A0 enum btrfs_tree_block_status
>> =C2=A0 btrfs_check_node(struct btrfs_fs_info *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key =
*parent_key, struct extent_buffer *buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key *pare=
nt_key, struct extent_buffer *buf);
>> =C2=A0 enum btrfs_tree_block_status
>> =C2=A0 btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_disk_key =
*parent_key, struct extent_buffer *buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key *pare=
nt_key, struct extent_buffer *buf);
>> =C2=A0 void reada_for_search(struct btrfs_fs_info *fs_info, struct=20
>> btrfs_path *path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int level, int slot, u64 objectid);
>> =C2=A0 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_inf=
o,
>>
>=20

