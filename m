Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828E0161E1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgBRAB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 17 Feb 2020 19:01:56 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:46280 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgBRAB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 19:01:56 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Tue, 18 Feb 2020 00:00:54 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 18 Feb 2020 00:00:06 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 18 Feb 2020 00:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI6VX0RYCyLwk9GHOgArdnYgu+JgEhVATMfk0X3Z3hOQsl5KsIAZEgP6AzM6gEaH64I0QMUwncrZbFBRP6/HD891G1coeueUpg/wn+hhgI8r1e2HeQUQw1pnMPvEx9JOB5c48DWnTsnF8TZV9QugF5ZSTZWqRVWMYqsBooHy+3rLXSm9hGbi8P6lxgSR8G62lprkNt71sVlVjQviNkI9HQbY800B1nft6VIlqmrTyCsOmuEFlODajBWOMQ3fLpnRt1ILLat3lHyyr2iE4nGRB4WJTUcB+sY1WTw/fY6SdrwQSm2dZXA5EV3P+IotX6mDmvI6ri7zmoZgGBbV+XjMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv8LHyXraLAGLrXI091ateF9d74mI7taVik5Q3HLN1g=;
 b=BOZCW449qdLImtp8Zlyn5NrfZnNJoMOrgzTnzak+IBJFVJ2aV/V2CW+2UWmDCjS1sO4jYD8VXv93A52l0H4cTalG1mmuEZLWFrQK+3Mbi6DXhijM4jYazJCKWt1cmSQLu/dBDI93aUljeQiaBtS0+71TM/hjgPtxoFTpb53x+Dgvzsmuqv1AYCJhyo6ic/Q+agGh0CXz1SXI3uBzLVPhKHbOuQyWoABMrFHQWux1qxrc+7vaLn76Avl/88J3b1jz0yzgK1la8klfWCqtNIR/YUM9LDGzle3ucedXO//4LLHvupA9SxP3b+fz5Ke0zvynsDHRPPRPMAN5AObAwFhQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3364.namprd18.prod.outlook.com (10.255.136.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 00:00:03 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 00:00:03 +0000
Subject: Re: [PATCH v3 2/3] btrfs: backref: Implement
 btrfs_backref_iterator_next()
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <20200217063111.65941-1-wqu@suse.com>
 <20200217063111.65941-3-wqu@suse.com>
 <e5e5ba05-2f9f-d8be-63bb-9bcd3e0c090e@suse.com>
 <2cee1b97-b6a3-bffd-8cb0-cb7d903497ca@gmx.com>
 <696547c7-84ea-d346-cecb-6270c2430031@suse.com>
 <3aadef5b-7bd2-b830-869f-67de417a4600@gmx.com>
 <c75fb84e-fa6b-a666-a30a-811d95c6735a@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <0664de30-80df-7654-ba64-5325837cf249@suse.com>
Date:   Tue, 18 Feb 2020 07:59:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <c75fb84e-fa6b-a666-a30a-811d95c6735a@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:74::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.9 via Frontend Transport; Tue, 18 Feb 2020 00:00:01 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8640feb-4653-4ead-ef9c-08d7b4058079
X-MS-TrafficTypeDiagnostic: BY5PR18MB3364:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR18MB3364C0D9516E48A9EDDDA130D6110@BY5PR18MB3364.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(189003)(199004)(110136005)(31686004)(26005)(5660300002)(36756003)(478600001)(31696002)(2906002)(16576012)(16526019)(186003)(8936002)(52116002)(81156014)(81166006)(2616005)(8676002)(316002)(6666004)(6486002)(86362001)(66946007)(956004)(66476007)(6706004)(66556008)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3364;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWWlB0/jbzxu0QkELCgM0duWw1vncJZiff2HADl5vdzcOnVH70OHvgMRdc6bOT1+ysOkdiFMyyzhrZ0N+19Lk8fp646IXrFriX/+2uDrNP5DLmZDl1eke8Ydz8o0VIgXY1h71iksyLtlRl6uFI4M0Gaojw3un2tmq6oEz+lCXNzbU1yhdfHLN8PDNC3EJoaHCbxN8ZLTMLUUUTiZLB0A8z/ItrA6F5aK4yaE+qRtFszX6jlgfsRcRZMAQeCIqG7lknkUbjCPs/ihGl7bVaIACRvd3ywpABXCcoOouACQdu/i48aPwEuQcs4qmPzAZQm5gvKUmo7OMRBUtGwtL8+hXDV7XwGW0SLcrJ3+0oHcjRG4GC+4Jj3HKLdgSTuyMucHCjNWGLxsjTOR02FsuVtdFros6olVGpxBMm/ZvD+r+qnK+WUqzzKhBTWMMeDg3j8NQuUFKaX9LbM1gBsk6sdnwAy7bfHLDY4tDFt0tNruR8gwVgMy7QtsG2m4V0st+NWzNNRBYkr10cQhrKV0oA03Dw==
X-MS-Exchange-AntiSpam-MessageData: IUvUtvZLOPnSMiFSeXQrSQgolKfaxUdblXfvFGnmSPtM3ssyxwdGKy4zo8LhmAEu96gc+vbfDu/MnrlHRDA3jE7quhMGSiKvL0ka2zRryGySvGj92OZTbI9kTTazblgDLPjFBe9NDl5qgSgS3HgbHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8640feb-4653-4ead-ef9c-08d7b4058079
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 00:00:03.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxfmUtZwqIoLOtkfBTSFuXufHURWB/MG83bkVpjTRSrgdVUU4KBFXgSXFsltO+Hy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3364
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/17 下午10:13, Nikolay Borisov wrote:
> 
> 
> On 17.02.20 г. 13:45 ч., Qu Wenruo wrote:
>>
>>
>> On 2020/2/17 下午7:42, Nikolay Borisov wrote:
>>>
>>>
>>> On 17.02.20 г. 13:29 ч., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/2/17 下午6:47, Nikolay Borisov wrote:
>>>>>
>>>>>
>>>>> On 17.02.20 г. 8:31 ч., Qu Wenruo wrote:
>>>>>> This function will go next inline/keyed backref for
>>>>>> btrfs_backref_iterator infrastructure.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>  fs/btrfs/backref.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  fs/btrfs/backref.h | 34 +++++++++++++++++++++++++++++++++
>>>>>>  2 files changed, 81 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>>>>>> index 8bd5e067831c..fb0abe344851 100644
>>>>>> --- a/fs/btrfs/backref.c
>>>>>> +++ b/fs/btrfs/backref.c
>>>>>> @@ -2310,3 +2310,50 @@ int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
>>>>>>  	btrfs_backref_iterator_release(iterator);
>>>>>>  	return ret;
>>>>>>  }
>>>>>> +
>>>>>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator)
>>>>>
>>>>> Document the return values: 0 in case there are more backerfs for the
>>>>> given bytenr or 1 in case there are'nt. And a negative value in case of
>>>>> error.
>>>>>
>>>>>> +{
>>>>>> +	struct extent_buffer *eb = btrfs_backref_get_eb(iterator);
>>>>>> +	struct btrfs_path *path = iterator->path;
>>>>>> +	struct btrfs_extent_inline_ref *iref;
>>>>>> +	int ret;
>>>>>> +	u32 size;
>>>>>> +
>>>>>> +	if (btrfs_backref_iterator_is_inline_ref(iterator)) {
>>>>>> +		/* We're still inside the inline refs */
>>>>>> +		if (btrfs_backref_has_tree_block_info(iterator)) {
>>>>>> +			/* First tree block info */
>>>>>> +			size = sizeof(struct btrfs_tree_block_info);
>>>>>> +		} else {
>>>>>> +			/* Use inline ref type to determine the size */
>>>>>> +			int type;
>>>>>> +
>>>>>> +			iref = (struct btrfs_extent_inline_ref *)
>>>>>> +				(iterator->cur_ptr);
>>>>>> +			type = btrfs_extent_inline_ref_type(eb, iref);
>>>>>> +
>>>>>> +			size = btrfs_extent_inline_ref_size(type);
>>>>>> +		}
>>>>>> +		iterator->cur_ptr += size;
>>>>>> +		if (iterator->cur_ptr < iterator->end_ptr)
>>>>>> +			return 0;
>>>>>> +
>>>>>> +		/* All inline items iterated, fall through */
>>>>>> +	}
>>>>>
>>>>> This if could be rewritten as:
>>>>> if (btrfs_backref_iterator_is_inline_ref(iterator) && iterator->cur_ptr
>>>>> < iterator->end_ptr)
>>>>>
>>>>> what this achieves is:
>>>>>
>>>>> 1. Clarity that this whole branch is executed only if we are within the
>>>>> inline refs limits
>>>>> 2. It also optimises that function since in the current version, after
>>>>> the last inline backref has been processed iterator->cur_ptr ==
>>>>> iterator->end_ptr. On the next call to btrfs_backref_iterator_next you
>>>>> will execute (needlessly)
>>>>>
>>>>> (struct btrfs_extent_inline_ref *) (iterator->cur_ptr);
>>>>> type = btrfs_extent_inline_ref_type(eb, iref);
>>>>> size = btrfs_extent_inline_ref_size(type);
>>>>> iterator->cur_ptr += size;
>>>>> only to fail "if (iterator->cur_ptr < iterator->end_ptr)" check and
>>>>> continue processing keyed items.
>>>>>
>>>>> As a matter of fact you will be reading past the metadata_item  since
>>>>> cur_ptr will be at the end of them and any deferences will read from the
>>>>> next item this might not cause a crash but it's still wrong.
>>>>
>>>> This shouldn't happen, as we must ensure the cur_ptr < item_end for callers.
>>>
>>>
>>> How are you ensuring this? Before processing the last inline ref
>>> cur_ptr  would be end_ptr - btrfs_extent_inline_ref_size(type);
>>
>> Firstly, in _start() call, we can easily check if we have any inline refs.
>>
>> If no, search next item.
>> If yes, return cur_ptr which points to the current inline extent ref.
>>
>> Secondly, in _next() call, we keep current check. Increase cur_ptr, then
>> check against ptr_end.
>>
>> So that, all backref_iter callers will get a cur_ptr that is always
>> smaller than ptr_end.
> 
> Apparently not, btrfs/003 with the following assert:
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index fb0abe344851..403a75f0c99c 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2328,6 +2328,7 @@ int btrfs_backref_iterator_next(struct
> btrfs_backref_iterator *iterator)
>                         /* Use inline ref type to determine the size */
>                         int type;
> 
> +                       ASSERT(iterator->cur_ptr < iterator->end_ptr);
>                         iref = (struct btrfs_extent_inline_ref *)
>                                 (iterator->cur_ptr);
>                         type = btrfs_extent_inline_ref_type(eb, iref);

Exactly what I said, in _start() there is not enough check to ensure
cur_ptr is always smaller than end_ptr.

Thus it triggers the ASSERT().
Will fix in next version.

Thanks,
Qu
> 
> 
> Trigger:
> 
> [   58.884441] assertion failed: iterator->cur_ptr < iterator->end_ptr,
> in fs/btrfs/backref.c:2331
> 
> 
>>
>> Thanks,
>> Qu
>>>
>>> After it's processed cur_ptr == end_ptr. THen you will do another call
>>> to btrfs_backref_iterator_next which will do the same calculation? What
>>> am I missing?
>>>
>>>>
>>>> For the _next() call, the check after increased cur_ptr check it's OK.
>>>>
>>>> But it's a problem for _start() call, as we may have a case where an
>>>> EXTENT_ITEM/METADATA_ITEM has no inlined ref.
>>>>
>>>> I'll fix this in next version.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>
>>>>>> +	/* We're at keyed items, there is no inline item, just go next item */
>>>>>> +	ret = btrfs_next_item(iterator->fs_info->extent_root, iterator->path);
>>>>>> +	if (ret > 0 || ret < 0)
>>>>>> +		return ret;
>>>>>
>>>>> nit: if (ret != 0) return ret;
>>>>>
>>>>> <snip>
>>>>>
