Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02493467348
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 09:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379206AbhLCIfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 03:35:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22584 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379202AbhLCIf2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 03:35:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B38T1gH010929;
        Fri, 3 Dec 2021 08:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3d1GyEMboc8mFvS+JYrDYsXsaIKZne9OgHPhxG+hN2U=;
 b=xOOTzEZO1En+azdtqBDodnvUZmoKbx6pbycdveWP5vzp+fPieoH/kI65bFi39WnTnDHp
 H0GsFxQsF6CYJo2XPrNX+oCv/Xbq1ewZNO4wLSDesWib37+ORmyGoJQe9ENJisfNx5eJ
 9b/ukQ4mCXqJFsUp2LHUZxQ9HyKofxqAbKua0pKON2iLAXAoSI7BsSFeg7/bjKBfl0h4
 S1gM093omwtyzq+rkRhLAYjmOaEwz0dqZBDf1NtSYJIZ8mQVvV3hWqTwcoMlwPPWYizX
 9N0TNFsMs/3ZCykTgquxT1p85sm9BhjiJKuYzB67GS8L2krIfg6HbDAz8LH7zHv6IL2l Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r5e41s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 08:32:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B38UWRF055038;
        Fri, 3 Dec 2021 08:32:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3020.oracle.com with ESMTP id 3cke4vv88g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 08:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmWgRqkUgiKLBMgWkPYbVHShKr84Rrk+k3VJwPqTGQ2ty7ABValp2czr3bJYA3HAdrDeOIcaUZPJ67Y8iEozF3giNrOLcBHmJ1VDCRGgMhkQJApRUECHGqv6vGKeauylLRTctkZ2ySehPcuPxjQpuzSDSlR44Kmfk59CXqjAQseT3Vr1HxiYOXgYjwuhEUk/Mr3s7E3G76EjrVQN20w1zcrQIIAt32M8RFulscl5kxrimLUERNMUzZ8TSJlwzVnc9Yp7Z1zfKo1mli/5PPted3WOTrL4ni5BFNzxcdgJfrUbuGg+EDvFN438y+uS7idWmGjJ/92RordN08X/M4UYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d1GyEMboc8mFvS+JYrDYsXsaIKZne9OgHPhxG+hN2U=;
 b=EromUuWRXHLsxUbCNrWAY28RLhiwlqUYgvN0oetL2FAET01AXwe82J8OoVVLW+s4w6pCUr14UG495dUjidV50VfnZhkE6qe68vomUBBrxW8V4xLusZtbTFKOSoiYljbgqvvT8aEGk9B2vxFDKziX5L5oZUp839C2/SLVYzTNqeSV/O7f8KYjPBQio76FatzNlBZpZKb48Dntpskmyd/uqHFLyrql6bhBK+vMDu+I6L6JzburZNKbDKDSXAejsr6WPW3zIo7bT0iD2VGSXDVagVLD1eN+CmDQESLcQyi9Eq2J5EKQfuByqBjO6PWyTuuhBsOG0DY6QTt6xV7eWqD3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d1GyEMboc8mFvS+JYrDYsXsaIKZne9OgHPhxG+hN2U=;
 b=tXt6M1MFV7g7OtK0oNvOO35G8cVB/jSUml4CoBQlkN8//MV7CoeO59m9KcktPDXRfrUNJbkoJ/DddaAUA9mIfXnX6qkBl2I3uzAf2WYJR/J+qPF67V6zfzo1w4x8ilF9U4BUtrpl5AHAhQyDEMeGydG+E/uVFhVTOjVDwQUzMVo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5284.namprd10.prod.outlook.com (2603:10b6:208:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 08:31:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 08:31:57 +0000
Message-ID: <b25ba451-18f3-073f-0691-c99b10fd8c9a@oracle.com>
Date:   Fri, 3 Dec 2021 16:31:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
 <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
 <YajuCbMN4H0Ap76V@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YajuCbMN4H0Ap76V@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 3 Dec 2021 08:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6212c36-4575-4bf7-a943-08d9b6375e82
X-MS-TrafficTypeDiagnostic: BLAPR10MB5284:
X-Microsoft-Antispam-PRVS: <BLAPR10MB52846DD1D683172F1DB3395DE56A9@BLAPR10MB5284.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e8Ae1UMTUT44HJZHiFrioesSmLMIOTV3kzXNd0eJgVwKqQnBQ/FPydpPmNJ7GANgVphPtwtk3hv13E2ByrnE2wHCHJI7bdBGSKzeWNWtTBGobSZJncLfHAnDZ37XOld6D0NQxSICe61HHJVvfeEq9ZSQ7ktnkuethTNxPKnko6h5j9VRwgbgaunkKRRUhmpzktEGG/Swrprn4eZq9LDSVJBeVn5e/te9GpjjWpEg7cH7AOA8l6Xd51uac7KROXXzsd7GNmGOxz9G7fLAK2qWnIDvNNbIzI+kej8kgw2J7J2l8YSzP5P45Uj5qzdROR65UUTa+mdFJRKAUFIn7neRlNbmJn/uCUpw+g5KhDF5IgyafXzBo2bKTMn3cWgkiwK752i+qjbVSsItQezC7hxNtdRtn8q7tNdqk0s0wOv6Ee10af+Hpqljp8O6EN4ERZojK/ueO9sfgwBaUZrEQPfqaM4o3KUIlMNaX+xJy3ybVrwJYxcGKng3G6kJXYoDAt+1ahlxvgBd+CH5lUj2JwrehiRKr5r3NChKjruHPhbBeMJ4jUDmX66NydWA+NotojYxOcToffkTdbqQ2cyILMHKm2bMhJBWppWoY++96+BlA5plDs+1TWIZZAqlNpBmn3mkyHP7g9U1wGdNMu6mpZU1QkjxxOUwS1Cy9rY1ukJztPvZegVTLU6PlW1OuZayC+8a9QeBzhS7In085oObC53xticZloYWO/dpUVkdzh5O4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(66556008)(2906002)(6486002)(86362001)(31696002)(6916009)(66946007)(316002)(38100700002)(16576012)(83380400001)(31686004)(956004)(186003)(26005)(4326008)(36756003)(2616005)(508600001)(30864003)(53546011)(6666004)(66476007)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5UY0t5ZEdUSXZ0NGU1RUc2aGZoRXVjbG5uMVl6YXlRdWd3WmxPRi9XZGpo?=
 =?utf-8?B?S2JHMS9pZFJWRWNneGRoSC82c3JjSXgxNmRJVVdFdzNuOFhSdWdYSW9iSE1Q?=
 =?utf-8?B?TnlmS1VCeUZuM3l3cUUxWmtPR2xDcVBqRVpOS2M1ZS9aUFBHOHhFemxtUUZp?=
 =?utf-8?B?ZjhRdFBRcFJjQWNsdEVZUmVISTNvazNUUmVqU0RHSG5VQU1sSHFjNDViVUtk?=
 =?utf-8?B?NEZpYkRYa0ZBa2Z0WDJGZ05keUhiZURoYkJ1NnlWcTJjenZROFNqQjN1MjBZ?=
 =?utf-8?B?aHhIeTNwMWdWL2hFS2pSL1ZIQmRvYlBFUHhWTy9vNTFTOGtIczB3ejZMbTVy?=
 =?utf-8?B?MTQrWFJEQlZhMUM4ZWdTOWUxaU5yQWdUQVJqL1hkUXQ3R1pTQXBFdG9LN0hP?=
 =?utf-8?B?a0RHcEUrb0F3aHp3eVpOb1JPR0Z1ZUlEVDR1Z1BuM3B0T1JzTExQVXFFenFv?=
 =?utf-8?B?V0FYSlJRQ3ZJZmVOaG1NRGgzajkwTjBycHJZaFpPbkJ1dzdRVzlZUkJQMHF2?=
 =?utf-8?B?SENWdXdaYmhUSGJLdGx3WmZuNTJiNzlWYVFKQXl0em5JZnhBV0ZGOVFMQWFi?=
 =?utf-8?B?VGxLeXFNa3hkb3BsVC8xcDVqcHhYK3ZwdytIM0RDTk81bzhNR2wvbjU2UnFs?=
 =?utf-8?B?WHVBMk1lRG9WTlVpSHF1OUlGUTMrQ1hMMmM4dHlnUWFvOGptSU5XR0dyd3hG?=
 =?utf-8?B?aGROY3JXWWZVNXN1U3Z0dU80aDdnWUVwUm1aS0lIR2xkbnpPOUpvRExleFR4?=
 =?utf-8?B?NlhwMVE2M1E2dHljS1hPQ1BBSE8wUDlnNlI0Rkh0eGxjRjRibks1NFlITW5O?=
 =?utf-8?B?NDA1cWFXdmYzWDlHaG45MDZaWU84dURtaUtoa1E1NDNOaWxVS1lVdDZvbndN?=
 =?utf-8?B?SVEyY3JwMENXQk5xcG5maEpzZERxMWxINnk0TG5jSmhvZzN6S1VsdzR2OERV?=
 =?utf-8?B?c1R0S09pZW0vZ3ZncVg5YUs2V0hsUVRBeUFnNDV2Z29UZWlaK0NLSy9HWnlM?=
 =?utf-8?B?VURDSHBYNUVXWEF1dk5oY2hBVWpBWXROWVFMMUJITlFUODRLejdmWDdnSXIr?=
 =?utf-8?B?aHBUN0pBVEJDbzBwNG43Z1JYUEZ5anZkN3l4T3VOc3QvZXZtYVdNR3RmSWtp?=
 =?utf-8?B?VUxDdTRYTFZPNDdqMExLM3ZxRlhHVVlvb25SNXUvSHBteFA0M0RreU1xMlJQ?=
 =?utf-8?B?ZjRYSE83SHQwSHRZUDdjaDcyRmx0ZGxES1JCdDlSeU9IemI3Vk93ZTBVbUdq?=
 =?utf-8?B?ODZiNVdLbkg0cHBHS2IwTEhHUWd0cVZaU2tJWUM3Zy8zS3BZamRMVlBSbW1S?=
 =?utf-8?B?UXBqczlxcktZeTVGOVJLUU5pV1NYZi83MktBT0k1Z3BjSkpJTlZ6UXJBdSt6?=
 =?utf-8?B?Zk1jNEJNYkN6b3d0SEdrMG45UUIxZjIyc3p0RVprRjlQdzNVN0JZUVpCVEVR?=
 =?utf-8?B?elB6aGZ2U1N6RHZyODNIaUc0Q0l5L012UHJ1dzM1T2dmNzVJb2NWQWxrVW1I?=
 =?utf-8?B?TnhEdEtBYUhjeFRSblkrYnI5TE9XbGozdDZxamIzeWdYQjFhNTFuWDQ1M1di?=
 =?utf-8?B?TUx1V1hjOHlxWmdJZjZYbnN2S2tXc0o5RmtCRGw3THJhRzZvOW1wUlFhb3Zy?=
 =?utf-8?B?WjRQZForcVQ0T0IyRlF1NTBPS214V1hUdVhWQzBTZW4vTi9mYURxd1FIczZL?=
 =?utf-8?B?VHdPUDg4UEwwV1VGaGw0VVlJd3I1eE90N296ODMvWHkxRnRmenNLeDY0bHF3?=
 =?utf-8?B?U2xqSnA5eVpuUXQzREhlQURlK1VZRHIrZVphUHI2U1BxaDI1ZnhYMTB2Vlk0?=
 =?utf-8?B?STdTb0NqUWVsSkFIZ3JOWmkvN3FyZFJhNmQ0ZERzN3FXdFU0eHBjbDNKOVhU?=
 =?utf-8?B?a2Y1ZmpQb2MrMWNjcXZsSW93NEtRWkxjSTRRWXRrVlVsL0I3VWxtYXJUZ09x?=
 =?utf-8?B?clAzditSWEJLNzdEYkRlNnZ4SXIwUFB5QXBIZitwSzZjVWYvSlBMVnBaL3A3?=
 =?utf-8?B?aSt3a3FWMmhEOVlKd0JZN2tRcnBPaitqWkJWa01QK09OWXVWNHowOVRWNUpV?=
 =?utf-8?B?WFdmZVpQWU5JTUd3UTIvVVdsNjFvcU9SZHROQ1BXRFJidno3UzhEUnNNTzBE?=
 =?utf-8?B?aVhPWEEyQmJ6UEU0NTFHQWlZQWQ1cm9jWnU5cEZRUXpkZmc2UWFLdHU0UmZw?=
 =?utf-8?Q?FI039x8WZVNjHff4INUw24Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6212c36-4575-4bf7-a943-08d9b6375e82
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 08:31:57.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53RjNDaTRlzXejg+SoEnST+sUY7gCNXRHIhbp+5Rf9Qaz1mPPWAk5UTezJUA6ukvZTSeWQ7wNaP3T6W+tH9UdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5284
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030053
X-Proofpoint-ORIG-GUID: 3IwpCX_d6ttUfB0dsbg19rQ_yZ_KpQ4T
X-Proofpoint-GUID: 3IwpCX_d6ttUfB0dsbg19rQ_yZ_KpQ4T
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 03/12/2021 00:02, Josef Bacik wrote:
> On Thu, Dec 02, 2021 at 03:09:38PM +0800, Anand Jain wrote:
>> On 02/12/2021 05:18, Josef Bacik wrote:
>>> We've been having transient failures of btrfs/197 because sometimes we
>>> don't show a missing device.
>>
>>> This turned out to be because I use LVM for my devices, and sometimes we
>>> race with udev and get the "/dev/dm-#" device registered as a device in
>>> the fs_devices list instead of "/dev/mapper/vg0-lv#" device.
>>>   Thus when
>>> the test adds a device to the existing mount it doesn't find the old
>>> device in the original fs_devices list and remove it properly.
>>
> 
> I think most of your confusion is because you don't know what btrfs/197 does, so
> I'll explain that and then answer your questions below.
> 
> DEV=/dev/vg0/lv0
> RAID_DEVS=/dev/vg0/lv1 /dev/vg0/lv2 /dev/vg0/vl3 /dev/vg0/lv4
> 
> # First we create a single fs and mount it
> mkfs.btrfs -f $DEV
> mount $DEV /mnt/test
> 
> # Now we create the RAID fs
> mkfs.btrfs -f -d raid10 -m raid10 $RAID_DEVS
> 
> # Now we add one of the raid devs to the single mount above
> btrfs device add /dev/vg0/lv2 /mnt/test
> 
> # /dev/vg0/lv2 is no longer part of the fs it was made on, it's part of the fs
> # that's mounted at /mnt/test
> 
> # Mount degraded with the raid setup
> mount -o degraded /dev/vg0/lv1 /mnt/scratch
> 
> # Now we shouldn't have found /dev/vg0/lv2, because it was wiped and is no
> # longer part of the fs_devices for this thing, except it is because it wasn't
> # removed, so when we do the following it doesn't show as missing
> btrfs filesystem show /mnt/scratch
> 

  I thought I understood the test case. Now it is better. Thanks for 
taking the time to explain.


>>   The above para is confusing. It can go. IMHO. The device path shouldn't
>>   matter as we depend on the bdev to compare in the device add thread.
>>
>> 2637         bdev = blkdev_get_by_path(device_path, FMODE_WRITE |
>> FMODE_EXCL,
>> 2638                                   fs_info->bdev_holder);
>> ::
>> 2657         list_for_each_entry_rcu(device, &fs_devices->devices, dev_list)
>> {
>> 2658                 if (device->bdev == bdev) {
>> 2659                         ret = -EEXIST;
>> 2660                         rcu_read_unlock();
>> 2661                         goto error;
>> 2662                 }
>> 2663         }
>>
> 
> This is on the init thread, this is just checking the fs_devices of /mnt/test,
> not the fs_devices of the RAID setup that we created, so this doesn't error out
> (nor should it) because we're adding it to our mounted fs.
> 
>>
>>> This is fine in general, because when we open the devices we check the
>>> UUID, and properly skip using the device that we added to the other file
>>> system.  However we do not remove it from our fs_devices,
>>
>> Hmm, context/thread is missing. Like, is it during device add or during
>> mkfs/dev-scan?
>>
>> AFAIK btrfs_free_stale_devices() checks and handles the removing of stale
>> devices in the fs_devices in both the contexts/threads device-add, mkfs
>> (device-scan).
>>
>>   For example:
>>
>> $ alias cnt_free_stale_devices="bpftrace -e 'kprobe:btrfs_free_stale_devices
>> { @ = count(); }'"
>>
>> New FSID on 2 devices, we call free_stale_devices():
>>
>> $ cnt_free_stale_devices -c 'mkfs.btrfs -fq -draid1 -mraid1 /dev/vg/scratch0
>> /dev/vg/scratch1'
>> Attaching 1 probe...
>>
>> @: 2
>>
>>   We do it only when there is a new fsid/device added to the fs_devices.
>>
>> For example:
>>
>> Clean up the fs_devices:
>> $ cnt_free_stale_devices -c 'btrfs dev scan --forget'
>> Attaching 1 probe...
>>
>> @: 1
>>
>> Now mounting devices are new to the fs_devices list, so call
>> free_stale_devices().
>>
>> $ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0
>> /dev/vg/scratch1 /btrfs'
>> Attaching 1 probe...
>>
>> @: 2
>>
>> $ umount /btrfs
>>
>> Below we didn't call free_stale_devices() because these two devices are
>> already in the appropriate fs_devices.
>>
>> $ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0
>> /dev/vg/scratch1 /btrfs'
>> Attaching 1 probe...
>>
>> @: 0
>>
>> $
>>
>> To me, it looks to be working correctly.
>>
> 
> Yes it does work correctly, most of the time.  If you run it in a loop 500 times
> it'll fail, because _sometimes_ udev goes in and does teh btrfs device scan and
> changes the name of the device in the fs_devices for the RAID group.  So the
> btrfs_free_stale_devices() thing doesn't find the exising device, because it's
> just looking at the device->name, which is different from the device we're
> adding.
> 
> We have the fs_devices for the RAID fs, and instead of /dev/vg0/lv2, we have
> /dev/dm-4 or whatever.  So we do the addition of /dev/vg0/lv2, go to find it in
> any other fs_devices, and don't find it because strcmp("/dev/vg0/lv2",
> "/dev/dm0-4") != 0, and thus leave the device on the fs_devices for the RAID
> file system.
> 

  I got it. It shouldn't be difficult to reproduce and, I could 
reproduce. Without this patch.


  Below is a device with two different paths. dm and its mapper.

----------
  $ ls -bli /dev/mapper/vg-scratch1  /dev/dm-1
  561 brw-rw---- 1 root disk 252, 1 Dec  3 12:13 /dev/dm-1
  565 lrwxrwxrwx 1 root root      7 Dec  3 12:13 /dev/mapper/vg-scratch1 
-> ../dm-1
----------

  Clean the fs_devices.

----------
  $ btrfs dev scan --forget
----------

  Use the mapper to do mkfs.btrfs.

----------
  $ mkfs.btrfs -fq /dev/mapper/vg-scratch0
  $ mount /dev/mapper/vg-scratch0 /btrfs
----------

  Crete raid1 again using mapper path.

----------
  $ mkfs.btrfs -U $uuid -fq -draid1 -mraid1 /dev/mapper/vg-scratch1 
/dev/mapper/vg-scratch2
----------

  Use dm path to add the device which belongs to another btrfs filesystem.

----------
  $ btrfs dev add -f /dev/dm-1 /btrfs
----------

  Now mount the above raid1 in degraded mode.

----------
  $ mount -o degraded /dev/mapper/vg-scratch2 /btrfs1
----------


Before patch:

  The /dev/mapper/vg-scratch1 is not shown as missing in the /btrfs1.

----------
  $ btrfs fi show -m /btrfs1
  Label: none  uuid: 12345678-1234-1234-1234-123456789abc
	Total devices 2 FS bytes used 704.00KiB
	devid    1 size 10.00GiB used 1.26GiB path /dev/mapper/vg-scratch1
	devid    2 size 10.00GiB used 2.54GiB path /dev/mapper/vg-scratch2

$ btrfs fi show -m /btrfs
Label: none  uuid: e89a49c3-66a2-473c-aadf-3bf23d37a3a3
	Total devices 2 FS bytes used 192.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/mapper/vg-scratch0
	devid    2 size 10.00GiB used 0.00B path /dev/mapper/vg-scratch1
----------

  The kernel does set the devid-1 as missing.
  (Checked using boilerplate code, which dumps fs_devices).

----------
  $ cat /proc/fs/btrfs/devlist
::
[fsid: 12345678-1234-1234-1234-123456789abc]
::
		device:		/dev/dm-1  <---
		devid:		1
::
		dev_state:	|IN_FS_METADATA|MISSING|dev_stats_valid
----------


After patch:

------------
$ btrfs fi show /btrfs1
Label: none  uuid: 12345678-1234-1234-1234-123456789abc
	Total devices 2 FS bytes used 128.00KiB
	devid    2 size 10.00GiB used 1.26GiB path /dev/mapper/vg-scratch2
	*** Some devices missing

$ btrfs fi show /btrfs
Label: none  uuid: 761115c2-7fc2-4dc8-afab-baf2509ea6fe
	Total devices 2 FS bytes used 192.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/mapper/vg-scratch0
	devid    2 size 10.00GiB used 0.00B path /dev/mapper/vg-scratch1
------------

------------
$ cat /proc/fs/btrfs/devlist
::
[fsid: 12345678-1234-1234-1234-123456789abc]
::
		device:		(null)  <---
		devid:		1
::
		dev_state:	|IN_FS_METADATA|MISSING|dev_stats_valid
-------------



>>> so when we get
>>> the device info we still see this old device and think that everything
>>> is ok.
>>
>>
>>> We have a check for -ENODATA coming back from reading the super off of
>>> the device to catch the wipefs case, but we don't catch literally any
>>> other error where the device is no longer valid and thus do not remove
>>> the device.
>>>
>>
>>> Fix this to not special case an empty device when reading the super
>>> block, and simply remove any device we are unable to open.
>>>
>>> With this fix we properly print out missing devices in the test case,
>>> and after 500 iterations I'm no longer able to reproduce the problem,
>>> whereas I could usually reproduce within 200 iterations.
>>>
>>
>> commit 7f551d969037 ("btrfs: free alien device after device add")
>> fixed the case we weren't freeing the stale device in the device-add
>> context.
>>
>> However, here I don't understand the thread/context we are missing to free
>> the stale device here.
>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>    fs/btrfs/disk-io.c | 2 +-
>>>    fs/btrfs/volumes.c | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 5c598e124c25..fa34b8807f8d 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -3924,7 +3924,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>>>    	super = page_address(page);
>>>    	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
>>>    		btrfs_release_disk_super(super);
>>> -		return ERR_PTR(-ENODATA);
>>> +		return ERR_PTR(-EINVAL);
>>>    	}
>>
>>   I think you are removing ENODATA because it is going away in the parent
>> function. And, we don't reach this condition in the test case btrfs/197.
>>   Instead, we fail here at line 645 below and, we return -EINVAL;
> 
> I'm changing it to be consistent, instead of special casing this one specific
> failure, just treat all failures like we need to remove the device, and thus we
> can just make this be EINVAL as well.

  Hmm, as this change is not related to the bug fix here. Can it be a 
separate patch? The actual bug fix has to go to stable kernels as well.

> 
>>
>>   645         if (memcmp(device->uuid, disk_super->dev_item.uuid,
>> BTRFS_UUID_SIZE))
>>   646                 goto error_free_page;
>>   647
>>
>>   687 error_free_page:
>>   688         btrfs_release_disk_super(disk_super);
>>   689         blkdev_put(bdev, flags);
>>   690
>>   691         return -EINVAL;
>>
>> function stack carries the return code to the parent open_fs_devices().
>>
>> open_fs_devices()
>>   btrfs_open_one_device()
>>    btrfs_get_bdev_and_sb()
>>     btrfs_read_dev_super()
>>      btrfs_read_dev_one_super()
>>
>>
>>
>>>    	if (btrfs_super_bytenr(super) != bytenr_orig) {
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index f38c230111be..890153dd2a2b 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1223,7 +1223,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>>    		if (ret == 0 &&
>>>    		    (!latest_dev || device->generation > latest_dev->generation)) {
>>>    			latest_dev = device;
>>> -		} else if (ret == -ENODATA) {
>>> +		} else if (ret) {
>>>    			fs_devices->num_devices--;
>>>    			list_del(&device->dev_list);
>>>    			btrfs_free_device(device);
>>>
>>
>> There are many other cases, for example including -EACCES (from
>> blkdev_get_by_path()) (I haven't checked other error codes). For which,
>> calling btrfs_free_device() is inappropriate.
> 
> Yeah I was a little fuzzy on this.  I think *any* failure should mean that we
> remove the device from the fs_devices tho right?  So that we show we're missing
> a device, since we can't actually access it?  I'm actually asking, because I
> think we can go either way, but to me I think any failure sure result in the
> removal of the device so we can re-scan the correct one.  Thanks,
> 

It is difficult to generalize, I guess. For example, consider the 
transient errors during the boot-up and the errors due to slow to-ready 
devices or the system-related errors such as ENOMEM/EACCES, all these 
does not call for device-free. If we free the device for transient 
errors, any further attempt to mount will fail unless it is device-scan 
again.

Here the bug is about btrfs_free_stale_devices() which failed to 
identify the same device when tricked by mixing the dm and mapper paths.
Can I check with you if there is another way to fix this by checking the 
device major and min number or the serial number from the device inquiry 
page?

Thanks, Anand

> Josef
> 
