Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6883FF901
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 05:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhICDJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 23:09:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46508 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhICDJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 23:09:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsYPM002854;
        Fri, 3 Sep 2021 03:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y3hC2qpcAMo9McIKXUMMt6/v40YPqfzoVPgUg/3L8Ck=;
 b=KcVnOv0GsgDc+589N5sQpOvNMbuzQBvdxzJQ8PdH/Bij6ETyhshZDiM7qboYyibgmt1k
 0D6t6PzlW5QWGFQ0ujSB1P0yC4trmxiRkaYdCNR0XWursZ1jWwiRleV7OLk5C4FkX8KB
 OUemsRpd6Jn5wKgTP09KdXzB4VVDoR9k1iNBmiVHZKKNCqSa9IjPO0JGvdZPmh4eh9ja
 DS8RaXLjxGDMWi9flDtKFgQlKYlPVhR2PTFaFa3Y9unsx/3kjnvMTZlJYwNQHBC16UuO
 3x8LS2HkDWrsD8hu6g4q+DnYa9eZ+9rRkF34u9565B14bXmjD45d0zebFLVn9J5jdw1Q Uw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=y3hC2qpcAMo9McIKXUMMt6/v40YPqfzoVPgUg/3L8Ck=;
 b=cNHBBkXEnvI8YzkiDn6UzwHXuqitM7pxE2w9WQE2SaRmXosC4B6nC6hRE36b6UrY1WYq
 KP9AQgcobSOi90ZQxheJoBuTyk/S7YQ1FAAQYs0F4+o1ehB6vs60TKX8h+1FbMbDiXr7
 sZarUcTExvKpIDqlGKWD/xLi5V91HZDlUxNa0xLcpwoK2mfkIfee27CZ2c+sCtyVmPRm
 EZ/tmWnvyhSOeMr5EdzS5ozrCthfoTwCHEg+0JGEkFMglXZ/GrQY7T/j6+OJ9/gUNa0a
 OijRIFkYhTa5fwyiGylLGYlBpPP+bmlX8U1A+xKNnvZW6J5XTXWs61EazaophUACK2ob +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw1cqsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 03:07:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18335sGT020449;
        Fri, 3 Sep 2021 03:07:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3atdyxwuum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 03:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygfx3UAOi1W2niQ9F4HlnT98FJ/mrof0OVNcY7ncJORwvXPDi3v+Li0NGHlnQF5sLe6uHjuHsYkBDcJdhVpiMUqNRLY+4HBAWaJh4ROFhTH/5aul2JUmJSHfOQmPSTX1IRJ7OQ9R5IiVBAHagLfSlRjlQSQhjdIFQuxX+TwKsUFQBOy8YZIahh113R/yDVKWVNLfQYFqwMicg7Bs8K9DnxVXAY611eLl9ene3fhBaoEJycv+Qi4116l98e6pe3jjGuneJIZl/tgb/fobSYw7Y1cyyHCMXMuzOq20ShaC6f2dFGPk8QNsW3TAHijA/fJStmdQ4v2Bt51/4kETfLOZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y3hC2qpcAMo9McIKXUMMt6/v40YPqfzoVPgUg/3L8Ck=;
 b=eIBQFt7JKxGgZgfTjF98OokLu6ipJpW3GRtAXzMp2Pp4flVqZ3tjX4VioCAwH2yNYe9cmN/JqmYs6Hn0f3JhehJEybJekPwpT2nU4qzi4kYVDT9DH/EK2DkPHk+dS8bEmIH758SQOey1cWjq/TmnBsgQFOQIH6mfmAw025zOu6RDu9qUQjcX2i6FZVAdM3FjkpNjTP2JBzo76+k08NC6rPEjAHxA5rVZhHv434SQCz2n05A9JrnvyNUhM1IInAk1nMbuRATDUbjWO5dCd3Pr+l9PdVHsfd0qT1H57yqcnVsEDkDpa30RxTMA5FY7kZZgww8pbtb/34kSA7l8qdN17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hC2qpcAMo9McIKXUMMt6/v40YPqfzoVPgUg/3L8Ck=;
 b=oolSri2VdMnCV+1mGgGnDYTYKqnCYw1VnlOpgeyaceRHdLZq93O5cDYZXU9qlS5RFzayVlfvQcgkjKFz3oW14sPH31Rp45qPtbfYzOXbp2pcKbK1nwoeUB0cD4JUHMELuGI45HDPQMSkJfaAMpKPrwSbaecue/rzkJnT7Dzdi3k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 03:07:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 03:07:56 +0000
Subject: Re: [PATCH 1/2] btrfs: use num_device to check for the last surviving
 seed device
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>
References: <cover.1630478246.git.anand.jain@oracle.com>
 <d9c89b1740a876b3851fcf358f22809aa7f1ad2a.1630478246.git.anand.jain@oracle.com>
 <ea5d6985-7c7d-3147-e0b6-fac17a2e298f@suse.com>
 <20210902153128.GY3379@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <e741e14d-3ea0-5f55-5438-73379be181dd@oracle.com>
Date:   Fri, 3 Sep 2021 11:07:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902153128.GY3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::27) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0101.apcprd01.prod.exchangelabs.com (2603:1096:3:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 03:07:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c693bf-258b-4366-637c-08d96e8806e8
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3425E6A98175F293BC7ED18CE5CF9@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzikFlu6igRX79PC5+LuNEgiNThgxufmCTgMFExuhvAePLi9HIQS2T3E3Qe25BMWFuBeiFuBczjKy4IFVcbB819JqaROHAopozJzt34SpVm9aoDvUi36QwSDEy4D1xeedPTDCA2CWfymu4MpNG2PngJ6/Vd1HmZ4kBK0wdtB8yJPGhY7DubL113Oa+CSaqXY/RwQZgagwSZwVJ1oFP9ag9PMolHuLHcFwu1cl1bK8t1UWLT8BQlBgpa0vyYuV9OUOj3QIJW5KSGmRliApE0SZW4riXxFzzJ1RR+goMXtZru9BvLo36CmmlgR2ZE7A5dbCw82ie0ORCUrJXMX6ijkwmVnzIm0UZoia8A2KLugCAHoyPWgZhLiEG9T5Ru4j92wslysAQjYJZEZTzK82bAlEaifAFs508FVid18udueeITZ8kAcoZkseHjL+TnIOu8ZLD+jOmLErpcoHuhBHY0NWn0gj+yMXrWfMaS/4iaZNtkkVFvhL4Wn4x8gZKFhZx/N9s9sbB3ZkFhisQuq3pwvI6HC6unpT+PVQKRIqOlCrpb5uNpl2UAg1bHlDAymiSW5YtZv65bcfB+mvBVIIi6LFFKHVepFJydduaUJNyC41XjQikG2YVqfAPhhjaODAsTOMmRry3OI6UGPOm/d1KWsiTHF21+XhsehXrYO5fg3sSuXngdRYmrom/wi3i73ShZMfGL13r3Df/90nv/T2/jcF23dS1zMriYCY0NpcmqyC8Vw+WA9JLFLgsehjUG7jhy0lvHiy5MeTs26haX8SGpuIPTVJJXCnjtODJZJFlE/4yw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(2616005)(6916009)(186003)(38100700002)(86362001)(31696002)(31686004)(8936002)(53546011)(956004)(966005)(36756003)(6666004)(4326008)(66556008)(66476007)(6486002)(44832011)(16576012)(26005)(478600001)(316002)(8676002)(66946007)(5660300002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0lpei82ajQ3QUdVQUdnYUlMZVNhbmhnTmtLcTRaUERyMFZwQmk1RkhpcjZz?=
 =?utf-8?B?Vk9WNklMdDN3NlBqNzBiaTZLVTBOa1U3aThVL0c4NTdEbzlPbE8rRTdOcmpI?=
 =?utf-8?B?Yzh0NWdIVVFRTFVBZUd4ODlzcUk1NDE5ZmpxZGJxUmhzWHpjRXhRcDRIL3N3?=
 =?utf-8?B?MHNZUk5qTVh1RXpzQUNZWHhyUklDYkw4bmJnMEl0RlhHTkNvRG9IVWQzZ2Vv?=
 =?utf-8?B?NnBKeUVOZ0lRNTErTTV4cHcyMUhMc0lCcUVaU3BlcXRlWHNML1hFZ0lWSDhS?=
 =?utf-8?B?YWViZWVhcUwzaUZXenEwM3dZU1VYRFJFRWV3ak00SmJVL01taTZLdTBJeGJQ?=
 =?utf-8?B?WGVpOC90OHBlNTV3Y04rbkNSUG1zdmVrV0cyclV0cHBVMnZqY2FSaDZldWtG?=
 =?utf-8?B?Q3BtQTREYktRbDhkQkc4TWdORkM4M3I0dk1JOHZJampZbjFUWlZzVmxtRHRi?=
 =?utf-8?B?RHYzaWE3NEtid3RGcTE2bFpzZWJoUmg5Q0FTUUNoMG9hQ1ROOHdSdUhoU3FH?=
 =?utf-8?B?YUxvS1lkL3k0ZWVuWm5LWjlLc3RVOVRhVlhreWNOTTJDS0xrdUg2OXRscGJs?=
 =?utf-8?B?WXd1T2xQR0t1SCtUdGtUMjYzTEdZaDczOUpOa2JZaDlaRmZpZFJWVEJjZDFE?=
 =?utf-8?B?VWVaaHRmWkphWmVLRWV6alpDWjlCTC8wSk45dFF2VzhRSHJUWStFdW45ZjZD?=
 =?utf-8?B?dWFLb1oveTNaMjFsZjlpK3ZpUWtuamJHZzZIWHFmN3NMbHJ5WlVReGpOSExz?=
 =?utf-8?B?WEVXZklYWjRUVEhtaklyUnRGUGpGTkpiUTBTM3RvWUFQcUZReTZYOXhydmw4?=
 =?utf-8?B?aGc0NStvZFpHZW1LUUM5ZXZIdEl5Mmtub2lUbCtqZUs1Q3RUY0dxUW1aclRm?=
 =?utf-8?B?ZXhBY2cyWlo0UlA1UjZ0N3hSYUJ3RVNsdVBIZkxPQzJjSFJmYXVjRC9oSXhJ?=
 =?utf-8?B?VTVNOUw1RGRDVVkyd05LeWxWd0E2Z1ZidDlqQkxOdi9maDdHbk9qZHJVa2o1?=
 =?utf-8?B?bUY1QXpNM2ZxdFo5bzRWQjU3WFV2TGxhT0FSaGNBMmJhVWM1ZTlUMUpzQVJY?=
 =?utf-8?B?NVY3cG9KRmpjUEwyQzRXKzdrbjJGNitPbW5UZjBvWmhPWnJZV1F1SXlleUo5?=
 =?utf-8?B?UnM4RmlXdXF4ME50M0xuODhHZno3R1JUUTBDaGFoN3Z4NHcvdlZmZ0hCcWdZ?=
 =?utf-8?B?NmZQN2ptaGg4dTlPMHBWL1FQOUpGRGpieCtCNFFPTTBqSXh5ZXYrYWVBV0dF?=
 =?utf-8?B?aTV1OFJ6di9JeEV2ci9vK2dTQTZrS0lMbytjVStwRUpKM1czS0FOcDM4VmtU?=
 =?utf-8?B?a09SMm9lN1VWZVduTERFRGNyc3lCZFp5ckYxbEhReXZ1ZDJYSlRVSnBFVFdU?=
 =?utf-8?B?eVdzeWc4T1dzMzZpY2RPZXp5ZU1DR1hPMlBVY082akpkbFFnaHRHenVKaEdB?=
 =?utf-8?B?cHQyRmZVa1AzZEJkUjdKNVVUZDV4Y3NjeURZNlFod2xnY3p0NzAvTCtvZ1Bq?=
 =?utf-8?B?azdoZzNXUjZkd0FwV1JmZEdhUGhuR2NPUEM4OEZVSjhCMkhoT2hhTmNqYnFx?=
 =?utf-8?B?blFrcGR3WER3TW5aRVFCeTZBL05vOVI1b3Ywb3R5UHFvdTI2RTBUU0swRi9j?=
 =?utf-8?B?YkZvYVYxbmNSTWJEMnRHZVVWa29OVjREcnBOcWd4cWZpeTBSdFQxSnV4SGdS?=
 =?utf-8?B?NEU4RFBNR2trUjBSdC96VWl1WWhvN01XY0ZwKzNTUEduRjE0dzRDb01FYUlT?=
 =?utf-8?Q?FsliCncAFesG+WHb27WSYu+xxtQ9anYFtqQrtTd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c693bf-258b-4366-637c-08d96e8806e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 03:07:56.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtEE0m/9vhUk+s23er9RSBkeM8MHRkQp/0aDZmVi9TiChdars9ml047A3xgzkEzBxhHUH+G49Vp4iDMDsS2Kzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030017
X-Proofpoint-GUID: K_H9UvuxQj_4EomOGkawBqXHAQAqfqcl
X-Proofpoint-ORIG-GUID: K_H9UvuxQj_4EomOGkawBqXHAQAqfqcl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2021 23:31, David Sterba wrote:
> On Wed, Sep 01, 2021 at 12:22:30PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 1.09.21 г. 9:43, Anand Jain wrote:
>>> For both sprout and seed fsids,
>>>   btrfs_fs_devices::num_devices provides device count including missing
>>>   btrfs_fs_devices::open_devices provides device count excluding missing
>>>
>>> We create a dummy struct btrfs_device for the missing device, so
>>> num_devices != open_devices when there is a missing device.
>>>
>>> In btrfs_rm_devices() we wrongly check for %cur_devices->open_devices
>>> before freeing the seed fs_devices. Instead we should check for
>>> %cur_devices->num_devices.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Is there a sequence of step that reproduce the problem?


Fundamentally per our design, we should have a struct btrfs_device even
for a missing device.

Here is an example where we break that rule after deleting a device in
a degraded seed device.


The below example needs boilerplate code here [1], to dump the struct
btrfs_fs_devices from the kernel.

[1] 
https://github.com/asj/bbp/blob/master/misc-next/0001-btrfs-boilerplate-procfs-devlist-and-fsinfo.patch


---------- cut ------
# Steps

# Create raid1 seed device and degrade it.
# Mount it with -o degraded.
# Add a RW device (sprout).
# Remount it so that it is writable now.
# Still we can't remove the seed device because it is degraded.
# So convert the raid1 chunks to single.
# Now remove the seed device (note: missing device is still there).
# At this stage the total devices should be 2 (one sprout and another
#  missing).


DEV1=/dev/vg/scratch0
DEV2=/dev/vg/scratch1
DEV3=/dev/vg/scratch2

local 
dfilter='fsid:|devid:|missing|total_devices|num_devices|open_devices|device:|MISSING|UUID'

         mkfs.btrfs -fq -draid1 -mraid1 $DEV1 $DEV2
         mount $DEV1 /btrfs
         xfs_io -f -c "pwrite 0 1M" /btrfs/foo
         umount /btrfs
         btrfstune -S1 $DEV1
         wipefs -a $DEV2
         btrfs dev scan --forget
         mount -o degraded $DEV1 /btrfs
         btrfs dev add -f $DEV3 /btrfs
         mount -o remount,rw $DEV3 /btrfs
         btrfs bal start --force -dconvert=single -mconvert=single /btrfs
         btrfs dev del $DEV1 /btrfs
	# dump btrfs_fs_devices.
         cat /proc/fs/btrfs/devlist  | egrep '$dfilter'
----------------


Before the patch:

total_devices = 2 but, we see only one device with devid 3.

[fsid: f3bd00d8-7be3-491c-a785-0d207a43b248]
	num_devices:		1
	open_devices:		1
	missing_devices:	0
	total_devices:		2
	[[UUID: 8c2d2dc6-7c0c-4a02-b63e-109131edd563]]
		device:		/dev/mapper/vg-scratch2  <-- DEV3
		devid:		3


After the patch:

total_devices = 2 and, we see both devid 3 and devid 2 (with the missing 
flag).

[fsid: 8542998a-64e8-4180-bb29-978403beb81c]
	num_devices:		1
	open_devices:		1
	missing_devices:	0
	total_devices:		2
	[[UUID: b0960a13-f956-4a0b-9ec2-b0da05060ec6]]
		device:		/dev/mapper/vg-scratch2  <-- DEV3
		devid:		3
	[[seed_fsid: 8dbae94f-f4c2-4875-9a88-b7db7847e740]]
		sprout_fsid:		8542998a-64e8-4180-bb29-978403beb81c
		num_devices:		1
		open_devices:		0
		missing_devices:	1
		total_devices:		1
		[[UUID: 9ade13a3-8264-4e41-908d-048dae3af370]]
			device:		(null)    <-- DEV1
			devid:		2
			dev_state:	|IN_FS_METADATA|MISSING|dev_stats_valid



Thanks, Anand
