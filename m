Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8013F46536C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350966AbhLARAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 12:00:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232427AbhLARAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Dec 2021 12:00:45 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1GabjD017206;
        Wed, 1 Dec 2021 16:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GHC/NjOsexk06w9/dgNwS4yzZNLABVuk4ZgjLHAxSdM=;
 b=pr/0V2wSWElbaKacz4xEpJLmpNhCZqqrVK7/kFGMxMCc1++jNLWcnYyGCYJedvOW+0rz
 HBy6Z3liPhUNoPR4LEAIsNvyTPnz1CKeLK/L/MYhuekjpI1UkIUXFD/jp4Lkcaj1VeM+
 oZt/KZ9p88jr/DchdcVCBKyk8c6pqUKVK9filaucDiToBSGak+BOkvPKTUMPNp0uN8+i
 se5K/s7fHZQkPaElMH5qEUePFA99EWPzvC5nngkaawIB1QdUfmPMcg8eXlTtI4HiABn1
 IUcNdTFy2W2pkNbfSC4SPI2iLqzko0ixlVoDdrDcwAsr5OgPleP+ffzdOa2xw1DG5vZg SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7wej2tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:56:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Gpltu068349;
        Wed, 1 Dec 2021 16:56:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3cnhvexbv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec4ofKS7GtAKM1qsAsGBe+OtbE6dauQkSxKZdY18x90avcZAou5MNWKfTkLK8oO/JGS2IQoHnTaNLDE+uO2+oNEt1kp8EzdMngO9RAp4uJb0WzCu6P/TO6pwvl5GScqQZAsTSA8BETJ3fiN4qetDCM++9ewqhJ68CQ8Vc6zaFs10hjvdjvQFOQVj6uMkVAxzVxtkXs3Pkm4MMyrAZI8g9eCj4CneUW3EytYwxTqM0QvLQyOI/F+jFrQ5PT1HkjPJUEjA5Xa9cH/Mcyb846dsgKVYpH09OMegwOSejYu++FQJCTc7yvLb+QI7B4cgGG2XS1nfVEJXokCb7trcqIefLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHC/NjOsexk06w9/dgNwS4yzZNLABVuk4ZgjLHAxSdM=;
 b=LuHBAO5AkLjP+khaQmLEAKo7lzRrQWbjeBm++4DI5m+iY2hiK53ii2XX3JSvQqeIcxN+BxIJ3/omG152GR0MmHpdzsGVrrINr/a0jkzr98WkyYJfWR3WGfJF3jRiNG1oaUlpaUrGpda0aSWUugbAdFnM1d0G0bzL/bRhkoaI2XqkLfAeNKbzwkugSsdA9aQAlFd8htYIH0VZ6LmSLVZvTpOrAnpDkIncbokFZtfK8uL6yVJpTst9yA9HtUDAqQ+/WrPt6qYI1Ss6lgsdebwxJcxB4ONmOjPlZ6ukaQxammptVluJOF5XTN/sjvMzyvS9TZmf+YTBuyF6+J/ejoOfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHC/NjOsexk06w9/dgNwS4yzZNLABVuk4ZgjLHAxSdM=;
 b=Fgvx3yEP55P29gvSpKBrRTGNQ/wNzGiHl5wAsC7O0QJYrf+XIX/9YyYinsN6Z5krab+mS2TqjcAS9xcvsYltFONDmUdPIxcRzdbfTMtBauADHA5VHSmyDp3lXDZ/1yS/KmJCjh63eN9MG0oNIZuTjARPi+86R/bMl1tW+hAEv3I=
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DM6PR10MB2729.namprd10.prod.outlook.com (2603:10b6:5:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 16:56:44 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::9ca1:3e07:1503:e999]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::9ca1:3e07:1503:e999%3]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 16:56:44 +0000
Message-ID: <eff38ce9-8f93-34f6-2cc5-40c06d2a8894@oracle.com>
Date:   Thu, 2 Dec 2021 00:56:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid
 from the device
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
References: <cover.1634829757.git.anand.jain@oracle.com>
 <33e179f8b9341c88754df639b77dafaa1ffec0d1.1634829757.git.anand.jain@oracle.com>
 <20211116171621.GU28560@twin.jikos.cz>
 <5f269a90-7145-0991-5da4-5f03fc0937fa@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <5f269a90-7145-0991-5da4-5f03fc0937fa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 16:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63676a1-df46-415d-f747-08d9b4eb8e03
X-MS-TrafficTypeDiagnostic: DM6PR10MB2729:
X-Microsoft-Antispam-PRVS: <DM6PR10MB2729D95C61B619979F528062E5689@DM6PR10MB2729.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sapaBMc9WXJYwzPm6cTJuM9H+giZcfdQza2Fc/SYUYH1o5R+2xuu/tNvmCejzSuFh0dj+KyGqtFcbogOHobjrm+F3nzIsML7Z84dvH26L3jbjdWo4OyaGb/YHay5ZUH+iwhhEozk8PxYo/Tl+KcPI2ssVAOUgSUH7Z/b0W8SjSgs/MYU5wWuxCtpLF2Wiv9BkvP811HHSfBICxJqvXTBgHhfYJ4LGS10O1WwqJAmkPD6MOdRgwG6HY6RJawo/kkLNYo9cgmtiUMjZ6UjAFJeQ9EqdEh3ky0ERBqBEIZ7gWyzfrq1kswH0xy/fddAEHY4ZkKmgOtdmRBoOzO37dd6Mtp3A3xUmiaB9ve0cIwPO3vmNvoqg4MFV9BwPRV3sOUjm6HXCf+/ovQY8BD7hEiLCmrjzkA6UaT+SEcz3naK79It34mKJdsHJJWczaD6zuYOPZTL7xZQxr3MgrvS4HH+KgmxLAEcDxlrTBzxpnMg76rgGc9FT3o8Yl2fTVdj1g+Ut5q5qnliiVeZ9JvvRFc9Hk9vPdZRULhhj2s30SJQEpEqI26bpVf0ZybIU7j/jZI1CPCD410lmj+WDfC1dUiqIpcdvgqNKlBvSG+4MVtgcRRX8a97LIlHyO798gQszLKqhdUwfWgGRlgJUIGudWIy9n4QCRpgZrKOh4/uC8g1immTwk0JQ6NO+LWfHeZMJ9GQzZpOe/H4HboFFmfAp+t3YT0nvfont6gmHNwXBX5Z6R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(16576012)(44832011)(66556008)(6916009)(508600001)(38100700002)(26005)(86362001)(53546011)(8936002)(6486002)(66946007)(956004)(83380400001)(66476007)(186003)(8676002)(4326008)(31686004)(6666004)(36756003)(31696002)(5660300002)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZiNnplcXlzV1Z0dzIvUzgyYkFINFd3Rmt4Z1lTT1pMa2JNNVd3VzNnVDN4?=
 =?utf-8?B?bzlVUG1zMHFvVFFhMi8wbUsxVDRINEJwZXhTZU5Jb293ZGdwMVRteUM1djRs?=
 =?utf-8?B?NmIvWE1UbUF3RUtibjNTdTdFZEJQNVd0TEpqQU04VmgvVHZkdGlzVnNyWW50?=
 =?utf-8?B?cVRTV2FYUXJwU0pZZTFXWkNhL2wxd0toK3R5V3djMVNHVUN6dzB5UmFMVzVu?=
 =?utf-8?B?dnNBMG1uaU5RQkcwb2lMNDF5S29QSUhHQjA4RENrYUVWcDQ2UXF5Qk9veXlO?=
 =?utf-8?B?MUpTclhzUVZKYk9SN1dkSUt3aDhZS0RJZk9xL3VBc1UvRjdpRDdXdklqcGpM?=
 =?utf-8?B?TjFyUFB4UjVHaW9pYmlCZE01eUcwU0dQZHMvUHRvRWp1TkorcWhQOWtsakZy?=
 =?utf-8?B?eUFOcTgwZEU3RnAwcmlGMWhEZ09zdGw0R2xaQlJaSVVITHZqRHFIOWRpN3Bv?=
 =?utf-8?B?Q0xhZXcwbzRIZXpQOHBHMGxVTmwrUkRGOFBYbjJhSkQ4UmdGT3dSeCtBdjZX?=
 =?utf-8?B?ell6ZUgvVUVZQkpMcnVFcGRNK1NRTTM5NVhza1JQbGZSNzlrSDc2VFB2TWNr?=
 =?utf-8?B?dm1ZSTBOcEU2M1doZTZUellLczkvTWtseDRqVjBPS2tCRHdOQ092bzgzU3NE?=
 =?utf-8?B?ZWlDSFNvaTJ1Rit6YlVtSmxvZlEwbzlKWWhDOSs4YjBGV3hUbzZnTm8xYWxX?=
 =?utf-8?B?d3c1Z05qcWtzczJYSDhPRnd0bk14UjVVRTMrRTRKc0pZdHdFYWZsbEE0QXEz?=
 =?utf-8?B?WjRyUHFZbUZaTEd5dVBkMFlCZ083cWZNdmVWenB2blJZcjNLTTFoY1lSOGJl?=
 =?utf-8?B?aHFWcVE3dE1CVGFqNjdaeUpwWXZBQURrNURJZ3FpT3ZLcHFmNjlEU2lhQjh5?=
 =?utf-8?B?a0FQOEtDYUxxVUUvUnoyRE9QeldocXV4TXRtZW50QmlyNlBEYk41WGY2bDht?=
 =?utf-8?B?K1lLZjZzcFpFRDFSMUZiYWE4OVZPUWZ2UXpIRlNseER3M3c2dERvbXd1RTdu?=
 =?utf-8?B?QmhPbDRoU3RDd1E0eEJGSnNjRXVPaHgvNnhQMnFnKytHaUlTMk9RaUx4YWwz?=
 =?utf-8?B?TldaSmZXcGZOYWc3MGw4MGJhc052c3RwUFV0ZWY2K1RUaCs5R3R1ZlpmSUFu?=
 =?utf-8?B?b2ZDdkw4Sm0vdWx2TGVFRmh5TjF2anNCdzArc2tESmpoQ0NFNnV2dXFUdE9D?=
 =?utf-8?B?Q0NLVVdESlJlY3RVSkZxVmR4d2VVbVNjeTF0aDhSNEplT1ZiaExqVjFYQXdy?=
 =?utf-8?B?RS9XTE9MKzdIWm05R2p2ejJzK1FVbEVucFlXVk1TOXczdlpnSmR4SVNGVHNL?=
 =?utf-8?B?TVd3bFMvVThVSDZOeWN5Y0VGbHMvOFBHZExzMlFCZ1Q4alU3cFVLTXNjakN5?=
 =?utf-8?B?Q3crdEVDamV0djhWR2JZWkl2VGU5VjAxc0pxS2dvYnlseE84cFcrNHVTVDFD?=
 =?utf-8?B?TkxpTFhUK2Q0V3pHRTNXckR1QjVud2Vnb1VTODcxOGxNc0c2aEF5aTc1MGxq?=
 =?utf-8?B?TjM2RUZvTjV3RFpubGp0SzZUV01pdDIwVXNwZ3ZiZHFRWkhYMTN1dHVDbzFV?=
 =?utf-8?B?QS9mbnF3N2pTU0lad1RvSG5iVXRNbHRxMWhqalh1b3pkbDJxaDJEb2o2WGZ4?=
 =?utf-8?B?Tk1DWkUzdVR3ZVMrV3RJeWRMV2c5OUlpNDNadnRkM0lRSytrQXQ5ZXNYd3Mw?=
 =?utf-8?B?VGtYTDNRelhENVo5NGFKTGFHYjdCRm81NlRmakdNa2NLZmRJT0VOTmtaYldp?=
 =?utf-8?B?T21wbnEzZDVmYWxYbndvZ1VXLzMyai9rRHp4Q1JTcjM0RTU4dU1tczA4dVdR?=
 =?utf-8?B?Z2JPTkdFNU5XN2xZUURvTVJDek5qbGtINjcvend4Y0RhM21UYm85TEJZYzJl?=
 =?utf-8?B?MzJtUjJPQUQ2M0VLOTROYW1HbVhDRFJvVTNWNURuN29DMUxDeVNZYmFUVWlR?=
 =?utf-8?B?UVN4SWRLTUNMRlkwQXlwRFVMUkZzUS9kTFlNOE9ZM1BJY3hhSi9nOXlJZ1dK?=
 =?utf-8?B?WmVYQVlOeUhWSlBuYnFNVEkvQmM2OG91V0NwbzNZTEJLTjl3OXYwd1NLSU03?=
 =?utf-8?B?R1k5RUZNNm9oRC94Ylk4TmZPaWdNQ1pIakQyZXhodDBzS0hiYldmYjZ3ZDNG?=
 =?utf-8?B?QjU1K0diVDRpYjlNbzJyaElOREZFcDNtSk9aZXpDSGppOXBSQ0tQOCswczdk?=
 =?utf-8?Q?+Dm3Hed7rg5GkrQZ2xQPoGg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63676a1-df46-415d-f747-08d9b4eb8e03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 16:56:44.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw7mSHkRME4G9BDfHqo6Q47wtTR98Vg683xlEc9UWNcXur8tSbzLJTqQqhRY3fVvk+ngYRn4N7UOR6/ixwmpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2729
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010091
X-Proofpoint-ORIG-GUID: yteUxgQL5mQ_WRTnJz2gHNJsxIWnN4UJ
X-Proofpoint-GUID: yteUxgQL5mQ_WRTnJz2gHNJsxIWnN4UJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  Gentle ping on this patch?

Thanks, Anand


On 17/11/2021 11:29, Anand Jain wrote:
> 
> 
> On 17/11/2021 01:16, David Sterba wrote:
>> On Thu, Oct 21, 2021 at 11:31:17PM +0800, Anand Jain wrote:
>>> In the case of the seed device, the fsid can be different from the 
>>> mounted
>>> sprout fsid.  The userland has to read the device superblock to know the
>>> fsid but, that idea fails if the device is missing. So add a sysfs
>>> interface devinfo/<devid>/fsid to show the fsid of the device.
>>>
>>> For example:
>>>   $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8
>>>
>>>   $ cat devinfo/1/fsid
>>>   c44d771f-639d-4df3-99ec-5bc7ad2af93b
>>>   $ cat  devinfo/3/fsid
>>>   b10b02a5-f9de-4276-b9e8-2bfd09a578a8
>>
>>  From user perspective, it's another fsid, one is in the path, so I'm
>> wondering if it should be named like read_fsid or sprout_fsid or if the
>> seed/sprout information should be put into another directory completely.
> 
> I am viewing it as fsid as per the device's sb. This fsid matches with
> the blkid(8) output. A path to the device's fsid will help to script.
> So I am not voting for sprout_fsid because it does not exist in the
> most common non-sprouted fsid.
> 
> Now to show whether a device is seed or sprout, the user friendly
> approach will be like for example:
>       /sys/fs/btrfs/<fsid>/devinfo/<devid>/device_state
> to show all that apply, for example:
>       SEED|SPROUT|READ_ONLY|WRITABLE|ZONED|METADATA_ONLY|\
>       DATA_ONLY|READ_PREFERRED|REPLACE_TGT|REPLACE_SRC|\
>       SCRUB_RUNNING
> 
> However, per kernel general rule of thumb one value per sys-fs file,
> so it should be for example:
>       /sys/fs/btrfs/<fsid>/devinfo/<devid>/seed
> 0
>       /sys/fs/btrfs/<fsid>/devinfo/<devid>/sprout
> 1
> 
> So based on this my patch "btrfs: introduce new device-state
> read_preferred" in the mailing list already proposed
>       /sys/fs/btrfs/<fsid>/devinfo/<devid>/read_preferred
> 
> So to summarize,  I can rename fsid to read_fsid. And, progressively
> in a separate patch, we can add <>/seed <>/sprout sysfs files as above.
> What do you think?
