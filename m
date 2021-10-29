Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C593143F545
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 05:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJ2DOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 23:14:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58964 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231558AbhJ2DOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 23:14:21 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SIWtan019713;
        Thu, 28 Oct 2021 20:11:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Vh8wWi60KYGe0dUhi2UEb9s1wzbvZt7kj+mgIcCfLNY=;
 b=E8oprQOUJPSvUsyMFUkLNjJnoYXtNvAqFFb4dPF9UxoLwU0VJ/AROqVlcCozZlann1RG
 MhMl8cndPMYxPEQ5n1Ra7HiiZB42AThH+TIAJK32rnnOkUjUN/TM0NdxNzX4CSXO6xhp
 zGMC0NDhkmVsM9jhiN1hp6M7RR2HlarYBIc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3byr41q33s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 20:11:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 20:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYuCuLSXC+9uHOZ1gOlRNds3P1NmNWwJL1FGJxi0YfDt00L9u25h40tJBhyaCHstkIG8Sp8LpOenEcg1wjCyQwE9FvEud2xyiBbpfZb8xSRdw/cMDY7y/HeN+SIOL146VFoBKE9qhBuTzLw/1jROM6k4NAkze6d6QNNQCrfs/sk7NBeA1g9ROpEbRwBa09oOtP4aG7BQh3HP75RpFEpso2oOAG5CwjXhLGi4CZeXj5e/VjWyr1ZhdTsEAUemkV0r8189GELAQWbi5mFddMEYyccTyrvtYKdkUcm6djxLUG2pXL9gcPTqePzIqPBdHbN71LS+qac95omMMfsK79l24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh8wWi60KYGe0dUhi2UEb9s1wzbvZt7kj+mgIcCfLNY=;
 b=dR0O1GAeF7J05UEseW60RbfbEHfqlwSyL+3LBYgByVFMoxWJbkn0knOI0KxCPC/4GwncQDKUmjaHOdQWYe3k0OslMRrBH2gQi9uu6NzLLTBlwu4yNRYFocRWZ3VBY9lQdXTovkLs5QYYYkEOPKdTqe4/pnU6npMwcpB5Txbp0vb56MCEbZhmYE4aeu1iSqt5yYjsjxabQOVzj8FVBcsyQ27owVfXpXqn8KDikpfXFH3JShOouasacv5M+zfTYqlEYQAbqCIzapaermt/0/9Lx8ZaMkkDSsYWLPUPGIo/tVviVBIwFcKOTVOBi9qWOBEuSryyCJjt9QMH7y4LJoqfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MW3PR15MB4012.namprd15.prod.outlook.com (2603:10b6:303:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 03:11:45 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::d182:98ae:c999:2a51]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::d182:98ae:c999:2a51%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 03:11:45 +0000
Message-ID: <29f1017d-99f5-dfa0-8365-ed7552f4c76b@fb.com>
Date:   Thu, 28 Oct 2021 20:11:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20211027201441.3813178-1-shr@fb.com>
 <YXqpFxiAVrC92io6@localhost.localdomain>
 <YXqzWv7t77ZpKIig@localhost.localdomain>
 <PH0PR04MB7416FDDC06510EFD61785BC19B869@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <PH0PR04MB7416FDDC06510EFD61785BC19B869@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::149c] (2620:10d:c091:480::1:c115) by BL0PR0102CA0015.prod.exchangelabs.com (2603:10b6:207:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 03:11:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 276d196b-72ba-42b0-9a5c-08d99a89d6b6
X-MS-TrafficTypeDiagnostic: MW3PR15MB4012:
X-Microsoft-Antispam-PRVS: <MW3PR15MB40129CB69FB3B36CB0AC497AD8879@MW3PR15MB4012.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glNKwy883tD34uDupG+A8pI1avZ8NttKT6cg/ZHgmMstzszzGPPsj7C4WsWItu++wFN9zfT+Havwo2VOZg9pkLYbQ1MH07CIWJD5oreTitqi+Mt02HMr9S8Bsnrcd/QB7hbmAT/+LXtt+BIyS7xbGSEgYmpb1pI353dHKOLXVAszlx5PTQavOhSPJHm1GE7DJcukrTO43MlariT7iUCRwH/OldonfNs6kB3FyFOe57nHk6tlWw5x+25LeyAB6HmCHX8zgi3fvu+xRUYiNillZ3aCeVpiXi/jjTxUFsFOMSyhj0cz1LMjPOP1VyLu9oB8DodDLPYbbDIKCZAey4vInU+SPOZd+OsS19VFR5FBVnUzwee4yNUYCeY/kXK4RFWTbmDS+A+h/CAH/6qnqI/Jz3bVBg04WqDCcjcN/BrtAkUx9TjQrIvODoTS9ytuOg2e8CkQ6zW3qGKUUFioSmFp6vN3ZY60WQvj7Apr3XGdj6I08a2IwG09pUyVgwny11c8933SnShErazHQV7cdjgJQTu0T4RhvAJb7Jf+yQ8A2PHaogHlebWJkhCcQfZXolBENb/HdnjplS3p1jim4VMjC3yvmqsA7DUOuOqaNcirYnxm1n2HKO/5zsiKtjiRfAoBKkkJXLsHs+sm2kNuETAPXRm8cIhH/phEYhzaV+sQiXKXC+wBVoWS9Zo6WeCencc2lRIDjtGHjPtGpZc5y2moFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(5660300002)(6486002)(508600001)(66476007)(31696002)(53546011)(66946007)(86362001)(316002)(6666004)(8676002)(38100700002)(2616005)(186003)(110136005)(4326008)(2906002)(31686004)(54906003)(83380400001)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1BN0RaR0lzUG0vSE4yZVZaYXJuZzF3c0lLQTlSbmRNODNkWlhRUXF4ZWZv?=
 =?utf-8?B?WGczbFFLK3lTTDcyU3ZsNm9Gejl2UHc3cUErVndGdHFaOTAvbktrV0ptT2c4?=
 =?utf-8?B?Z1VKbFR4M3diUjNia3RKNHEwS2lzckF1VzFzYXZhazYyRnFZWEk3R0lSZWhJ?=
 =?utf-8?B?MThwazdsYzBZY0hQMFhzMjZNQ3gxYzVRbjVuZTY3ZW42L3hzN2xJNnZiOHEv?=
 =?utf-8?B?NGJRUWNEUUhsb0FoeC9SUVEvcThyM2h2Y3JxeVVrYks0VTdKeUlYNUM5Q2NC?=
 =?utf-8?B?SFoxMEszdFNXTndQODhZWGZPYlI0K2VzYXRwMHQwa05iYkVGNkNUTDJtb2g1?=
 =?utf-8?B?ZlhOTFplN1RTaTR2QTgyT2czTTZaaGhYT1hyNDR1NDhVQXhIVzBxNlZZTW5p?=
 =?utf-8?B?aU5pMEt6VDZGQnJnMHh3Q0NuTXlZQ3FVMjBWbkZ4UjQrcnBWVHUxN0xyUzZo?=
 =?utf-8?B?OUUrb3dZRi91d002MEliamhyNnE3K0JBblI4YmQ2SE5MckFXUW1wRDVNbVdW?=
 =?utf-8?B?VUhRRU1RUXdmaWY3ZnYxaGFVUFVZdld2a0Z2VGpUMFZDd3dPc0VPM2hPRytn?=
 =?utf-8?B?MEhqM3Y2OGx4Ukl3Tm9EeENDdUFFejZOdDR5eTNZeTR6REEvYlNWQVFUT211?=
 =?utf-8?B?UitPOENNUHdzdlJIcUMxUFJSVTI3VjV5WSs5R3E1dE5TVWUwWlpWMlNkbGJ5?=
 =?utf-8?B?OVJZaE5IMkVKSUFRV2NHb0l3Yjk1bTdMd1FKd1BOVDRLR2JPTWlReE9NZlM5?=
 =?utf-8?B?YUx0Sm1VMFlaTm9Ya0NuT2tCSjFhdUJmWVV4VFRDaGZvL3ZqNkxHMlp5VDFN?=
 =?utf-8?B?eGpJb0xvNXZHY0RjS3l5Mk9nMXF3enNXcE5DdCtMUFUyTmJxZWVmbysxckUz?=
 =?utf-8?B?R1Z3QzA3bVVvSlFucGNleUdiNHIzVWxxM0I5YTgvcFN6VWZBaWdvY1RIVEk1?=
 =?utf-8?B?Z3dsdU1aV01FZTVxMEpYZDFncXQ2R2ZhdWxrN05PUENiMDVCTXVYVUI4ODdn?=
 =?utf-8?B?UVNpTE84OFRGSCs2ZTF6dXl2SXA3UnRjZFZQeUx6NnF2Z3hsZEVhaU1OZ1J5?=
 =?utf-8?B?dkdZNWcrZ2o5bks0cTdxeUtQUTlMSWtOeTROTnlHQS9YUmw0WHZwQ0w4VytZ?=
 =?utf-8?B?bHJFbWRrcVNSSENzdStyRE1YN1RjRjNvY1RuMEdGcFVhZlNUUDZaak5VZGN6?=
 =?utf-8?B?QVVxOG50ak1xSlljcHJHa2ZrU01wcEh5dFdCSFZEWGw1NVdoTWVuR3ZWc3dN?=
 =?utf-8?B?OVYwMVJ0aVVPTW4vQ2IrR0dQL0JybUd4eWxmNEFlVk0zOXRXSnNWVU9GR3NH?=
 =?utf-8?B?aVVCVGdTMU4wTDZQYjBsTlErZjZNaGZYbnoydGVKU3c4VFBJN0kzRHpXWkxS?=
 =?utf-8?B?RUdCS2VpT1RXM3gra2h6TDFXeGM1a3IyN1N2Ymd3ekJJZkRqMndpNngxRUtQ?=
 =?utf-8?B?S3dCSCsvaEc4WUFkUHF0dEg3d1ZtNFppeWY4dXlKTmF3R0pSTFQyMzVJYndP?=
 =?utf-8?B?T29kSDJHZGoxNTBSUUhESmJ4YkF2c1UrSjdHSklEY2EwT1FzOTlIeVhuQk5h?=
 =?utf-8?B?Q1hBRjROU1Q1ZlQ3cHI0WUZ5YTFCRzZvYk4wMmw2UkkycHZTT2hwVEY1ZWNV?=
 =?utf-8?B?REZmZVJkaldhZXpLWHMxWTM0MlRYSXltOERDQVhxTVRnQVA0N0FJUVdNcVZN?=
 =?utf-8?B?eTZaYUJDbmNhdDFxWWhpK3pBSkhqK1BRUkpzTGdzdUI5anJhVEc1Rk5vNXpW?=
 =?utf-8?B?WGZsZGJ5VS91RkREMDRUN0sweHFPRkxGcXZoTXFxM2plSXRGRzdjWXkrWVBU?=
 =?utf-8?B?M1ZJNldDYU1zRWViNGVPUTA5VDBWRXdLNzExVit3SWVvUXhmVXhiUnd6TGUw?=
 =?utf-8?B?Ri80MU1ZU1RwQUoyMkdwMUk5NThHMGVJR21ZNjdSTnNHRnpHV2xkSU9Menl2?=
 =?utf-8?B?RWZ5MTYzRGRjb2FZUWFkSjBOWjNYb2w0MkZrNHdxK3BxalpBZDZjTXJYeHlq?=
 =?utf-8?B?U0FtM0M0VmhVdHoyb0plb1ViMFFsYlRRMzFkUWV2TUMvaE55ejJGUS9JTysx?=
 =?utf-8?B?SmRqVmlYVGVsWmVZbE5kVjdMZFNud1BKM09XUFREc3N6ZlJpejI1djRkYytw?=
 =?utf-8?Q?WYGtDIY09koPczeaUhaVOuwgO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 276d196b-72ba-42b0-9a5c-08d99a89d6b6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 03:11:45.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jC/zaoZB3uIHOZV+9Ba3P29ajLwKm/N+bLBO4imfrHYS06zOjCFymxiPJwmgRkj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4012
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: y18QRgVATMfpq2xGRHBfFeteKMrJ71b-
X-Proofpoint-GUID: y18QRgVATMfpq2xGRHBfFeteKMrJ71b-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/28/21 8:00 AM, Johannes Thumshirn wrote:
> On 28/10/2021 16:27, Josef Bacik wrote:
>> On Thu, Oct 28, 2021 at 09:43:51AM -0400, Josef Bacik wrote:
>>> On Wed, Oct 27, 2021 at 01:14:37PM -0700, Stefan Roesch wrote:
>>>> Motivation:
>>>> The btrfs allocator is currently not ideal for all workloads. It tends
>>>> to suffer from overallocating data block groups and underallocating
>>>> metadata block groups. This results in filesystems becoming read-only
>>>> even though there is plenty of "free" space.
>>>>
>>>> This is naturally confusing and distressing to users.
>>>>
>>>> Patches:
>>>> 1) Store the stripe and chunk size in the btrfs_space_info structure
>>>> 2) Add a sysfs entry to expose the above information
>>>> 3) Add a sysfs entry to force a space allocation
>>>> 4) Increase the default size of the metadata chunk allocation to 5GB
>>>>    for volumes greater than 50GB.
>>>>
>>>> Testing:
>>>>   A new test is being added to the xfstest suite. For reference the
>>>>   corresponding patch has the title:
>>>>     [PATCH] btrfs: Test chunk allocation with different sizes
>>>>
>>>>   In addition also manual testing has been performed.
>>>>     - Run xfstests with the changes and the new test. It does not
>>>>       show new diffs.
>>>>     - Test with storage devices 10G, 20G, 30G, 50G, 60G
>>>>       - Default allocation
>>>>       - Increase of chunk size
>>>>       - If the stripe size is > the free space, it allocates
>>>>         free space - 1MB. The 1MB is left as free space.
>>>>       - If the device has a storage size > 50G, it uses a 5GB
>>>>         chunk size for new allocations.
>>>>
>>>> Stefan Roesch (4):
>>>>   btrfs: store stripe size and chunk size in space-info struct.
>>>>   btrfs: expose stripe and chunk size in sysfs.
>>>>   btrfs: add force_chunk_alloc sysfs entry to force allocation
>>>>   btrfs: increase metadata alloc size to 5GB for volumes > 50GB
>>>>
>>>
>>> Sorry, I had this thought previously but it got lost when I started doing the
>>> actual code review.
>>>
>>> We have conflated stripe size and chunk size here, and unfortunately "stripe
>>> size" means different things to different people.  What you are actually trying
>>> to do here is to allow us to allocate a larger logical chunk size.
>>>
>>> In terms of how this works out in the code you are changing the correct thing,
>>> generally the stripe_size is what dictates the actual block group chunk size we
>>> end up with at the end.
>>>
>>> But this is sort of confusing when it comes to the interface, because people are
>>> going to think it means something different.
>>>
>>> Instead we should name the sysfs file chunk_size, and then keep the code you
>>> have the way it is, just with the new name.  That way it's clear to the user
>>> that they're changing how large of a chunk we're allocating at any given time.
>>>
>>> Make that change, and I have a few other code comments, and then that should be
>>> good.  Thanks,
>>>
>>
>> In fact I talked about this with Johannes just now.  We sort of conflate the two
>> things, max_chunk_size and max_stripe_size, to get the answer we want.  But
>> these aren't well named and don't really behave in a way you'd expect.
>>
>> Currently, we set max_stripe_size to make sure we clamp down on any dev extents
>> we find.  So if the whole disk is free we clearly don't want to allocate the
>> whole thing, so we clamp it down to max_stripe_size.  This, in effect, ends up
>> being our actual chunk_size.  We have this max_chunk_size thing but it doesn't
>> really do anything in practice because our stripe_size is already clamped down
>> so it'll be <= max_chunk_size.
> 
> We should also add an ASSERT() to verify we're really never ever going
> beyond max_chunk_size.
>  

Do you want an ASSERT() against BTRFS_MAX_DATA_CHUNK_SIZE?

>> All this is to say we should simply set max_stripe_size = max_chunk_size, but
>> call max_chunk_size default_chunk_size, because that's really what it is.  So
>> you should
>>
>> 1) Change the sysfs file to be chunk_size or something similar.
>> 2) Don't expose stripe_size via sysfs, it's just a function of chunk_size.
>> 3) Set stripe_size == chunk_size.
>> 4) Get rid of the max_chunk_size logic, it's unneeded.
>>
>> I think that's the proper way to deal with everything, if there are any corners
>> I'm missing then feel free to point them out, but I'm pretty sure 1-3 are
>> correct.  Thanks,
>>
>> Josef
>>
> 
