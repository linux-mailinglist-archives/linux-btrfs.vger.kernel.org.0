Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFBD41AE23
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbhI1LwQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 07:52:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53508 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240438AbhI1LwO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 07:52:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SAxXEs017999;
        Tue, 28 Sep 2021 11:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/rQUswYrLlAVM8en0WI5FD3RDW+oWfqyt1jzYSPlRQs=;
 b=cmvSngobLC3sSuSAEk6GxguHIg+n5ht4/EkpwxbPusIZf+U4FbBJqlNLf5knYD9Ooqmt
 Bh5nBqiTeKCP3GiWMqbjWsWoYT2itCbaOJjtKRJl9Lwwt9Jts5/HBhh9qktA/7zLVOKL
 kCB2NvApuYdcxjOeWnJNPuE1OeHCBcNmqTrcKhqfmfscx4siULUB0FqIWRWij6kyre/b
 4k7WsqtQQLpIittIe6VBMaen8jQ16BiJUhE6N9kwDaNl6wFgPrn4r3Jpa38gBCn+qIMK
 c88DOTyKMFfI1TK2GLb8rC/3c3fp3iCiU7B0ynnPYZOfuwAanuKWJNqa1jRK0ZjKhi76 zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbeu17ety-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 11:50:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18SBjL7W078482;
        Tue, 28 Sep 2021 11:50:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by aserp3030.oracle.com with ESMTP id 3b9ste3qg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 11:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBiWSek567L0sHXL54NDRBazfXBl0hhIhx6vvQ64yaI+mpMKA9yGKVTxFhww6KDB8jRDLoyx43Fup+2DyEaS9EzsnauKUW3SBXyZl/svpiUWbFP9C/oAQLX8qFBK4rPzdom0pdvcNCRgyTt95Jwpfl1txkWxtbfI0Z9jD+Ofgc4WsdYsgW1614OuREvuyNhsyZ3Lx1LjsrfXrW0lGZOOFJUfBEPZMxey/0GQ9Lv0moT1kjZ6Y2PemutZcb2JAA13bnajVyAJ6UlHyod9ejhycyfosO3fQkXpJjUGMmXUDkrER1tFL4MgoN1z/RrJlB1UO+S1x7Pb4U7+z7AVNzLNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/rQUswYrLlAVM8en0WI5FD3RDW+oWfqyt1jzYSPlRQs=;
 b=A1OSE/OyD7IT45VxfGdEtN5cAgyP3bps8deX5xRjDa+xYPKJlwH3us6zsJPlhWfdn0jsqMzrOVR3MjhwQcaK8RKxXoczyk0wx7uJ0jaKdK+jQtRFIKye63HEQarFkvh7eBSb4YMHHwBb26lKE79bSE+KDHz1aWffA4Gb2Kf0fSHtLAGT81LGuGrwMXuTTbo6oxV7ns4ZOCcecFPrK6mbBC0q88s2WQBfL6jsmzH2GzpFrHZLr5fVZvj4gLt4q+bbUwG6VyYDtcBSWv4h4xWFgE32WcLG0nlx9fpTXp6r1/+bRRH22cy+REaTsRMeOgtexby6kG3fEnkuUY6K4+VaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rQUswYrLlAVM8en0WI5FD3RDW+oWfqyt1jzYSPlRQs=;
 b=ebQOYKzDPNUNuuP3lubJZRaaUTMsYZ23Z7GTRLtwj1BlPOoaS+brVpVN6NrVLZmW4Q7eUT4HIp1xOcDb+zY6R9a1LHNXaZd+BC/w2aximieYUdTX1K6Lf/67d2EkLJFaf6rGkVoCuI0RNbDyjiqmLr+oYqypfQLz84cg+j0bDDI=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 11:50:23 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 11:50:23 +0000
Subject: Re: [PATCH v2 3/7] btrfs: do not read super look for a device path
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        David Sterba <dsterba@suse.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
 <26639cd9f337a84b432b6627cd7c17b3d6d51e34.1627419595.git.josef@toxicpanda.com>
 <41d2c028-6af5-ab2b-91fa-1090d4258ba9@oracle.com>
 <ffe45a8d-7ff9-ddda-2c5a-b0e1aae1441a@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <afcc1d56-8c94-f55c-4359-494ae3ca17e5@oracle.com>
Date:   Tue, 28 Sep 2021 19:50:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <ffe45a8d-7ff9-ddda-2c5a-b0e1aae1441a@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:4:188::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 11:50:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9007164d-5038-4e67-1398-08d98276271c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40943E3FA2919491A71BFCF4E5A89@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyDQd0A1RNfsm2mYKq5L5NvgJV7HY522Nyi2OLkJDxLxA3/97hpAFvPVPDB5jJmYVJpChoKkLK44pQSxnztjVBCwUlIByZmBF4ySEyDODH6uvJ2gv3eOTf85Ta+5lTaVXaavrWBSBXpBDG1sTGpXwnwDD+kV3ROMnNNBY4vrV9xEI1n0LB4a2lxjiIK3KEReMUhQ53vbiN0HCQcneZlzQSFw3OsPI3P4DeGtO5SugCUzCR9dZppTeBsz3F4fkB4FZKpCgo0o8VEz9EPJqgOw25eRM/dxJzb/PwwBBWM3KfDh1pNrY8blsozeBMMqhYHSLSz1P3eyvrvN15DwUzzhvEMcI02kUYY/uhQdiWP+gMtPR0armG+c9J2r3G3PHBVRXEkmTlpLPp1/2TkL9N2kMHWTr3U6dh7wjMCqWhzK8H+Rzh59OOqmgPs0E0EPuJsNKfa407i6pESZziBr4CMB93S9CGyl1b1nR08OTWsJSpi6of+qVJZMLvJeEbUoPVdivtGod75lKY06iMTDFfT8A9TW6IoVKt4OGenj25+pXlWicXb16Vmm+zs4IP9vjFHTC7o9OYT2uPKz06CZFPvFQkCmZ33aDpy/RdTbkRK7IC8uZFpv8RdDPI+qQY+Ao80U+6iukZ5E0vLKGc6n39cCJDDUprgVhXmyJlrgTa+pen38C5fxOQbkmCmwkfSKYkNlopx1vroziQnxKob4SDfW1GCfLf4uN4epss+DbYs/MHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(956004)(4326008)(53546011)(26005)(6916009)(508600001)(36756003)(66556008)(66476007)(44832011)(2616005)(8936002)(8676002)(66946007)(186003)(6666004)(83380400001)(16576012)(2906002)(31696002)(31686004)(38100700002)(86362001)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJsSEdISGtZUjdadWM0NGQ1WUM0S2ViNGtHdnNwVURnM2Y4UlRqaUFLUGpi?=
 =?utf-8?B?dDYzalZCUHRKSGlQdkROTkEvZllTRWNqcVM0YWxFZHBxTGdIckYrbkVvSGF6?=
 =?utf-8?B?VE82WElsb3l1cENINmZPbk1jdUt3Nmt2MTlFZUI3MWZIK1p3Zkw5d1FsMVhu?=
 =?utf-8?B?algxQ3lYRlBoeml5bUZIUU9RT01ZamJDeWtpZzlDU3ZGNnA1dVJJdzlnOG9Z?=
 =?utf-8?B?S0Q3WDJ5RnczZDB0MEdtT2pMUGRqVFh2aXg4TDlzZ2lmcU5RVTBXcTlLUERC?=
 =?utf-8?B?Y2h3YXNJaVh3VHVFZkNvS0Z2U0J0TEdhYU5kQWFkNnJhWWZLQTZnWGFXcTBV?=
 =?utf-8?B?UHFrSmxkRm9jbkZXVjl0bWVQK05CZDNOOFZBbnUzK25uLzFnVGlqOUh6ellx?=
 =?utf-8?B?dndCSkNnWjV5T0QwM0NhdzRpRmpQTHkzcG1IMjBLTHpEL0RjWTk3UVE5U2Rs?=
 =?utf-8?B?VWt5T0EzQ1JvSVlhMFVEaFgvVzgzSzNBR0RuQytvQmJ1b3RNYjlCRTZHSmty?=
 =?utf-8?B?VncwcG11SS9nN2luOGlkZ2ZXRkFZbVRZR1FiU0Vic2NGeDlGRlpFUnF4MlZw?=
 =?utf-8?B?bU82bGJra2RFak9LSXpiYm9JYlQ5c0p5TEc2cmdzSlRONlRCdndHV1RqQ3Rp?=
 =?utf-8?B?MkVmSmtFbCtQay8ra1BCd2pKUkpmcUQveldtOXRNL3NzSjE3bEFtTnBkZ0ZN?=
 =?utf-8?B?SHFxMHZGbzlCWlJibjA3cU8raXh2T1kyQTRzVU9tRTlzb1FUc01Rc2dvaXBF?=
 =?utf-8?B?ZFdqeDBWakNYQUJSZHYyUjFLZWpseTBFRWc5Q3J0WUhidTYzQUdDbDRoVHJD?=
 =?utf-8?B?eU9WSkJoc3hsM3pmeXhrUWN4SGZ3Q2NIVklNekhTTXVST2dzQ3RJa3MzeGtG?=
 =?utf-8?B?b1lmWDI0NmRmeEljV0UrejdzZVptOHoxSVdxK0F3OU03dGJGRkQyeFJEKzJR?=
 =?utf-8?B?VnBYeklydFVYS1dUc2tjUk14Tk1EN0N3bXh0eXNyV0VMbjliV0p3NENvSUJk?=
 =?utf-8?B?ZUQwaUJaZktnOTNhNXdkaGphQ0M1UnB4RmpPUldIUkpaVDJ5NlEzTXd4V1Nv?=
 =?utf-8?B?SU9ubDBCWmJCSFVvNXFGaURBRXlZQlBvdFp4ZE1mbnBsamc4cUlPajIvZDF5?=
 =?utf-8?B?Rzk4cXU3THJqUnhDaGx1akZFRlA1NXhZdVErdldRTTd2czhrQlE3ejBFMjJY?=
 =?utf-8?B?QzhDMHBxUExtR3FPWGpTek1OWlc4MjhCWnYzS0xsZ2tRWjBXMmVEakhaSGhm?=
 =?utf-8?B?YVBVSXRORERCdEJpckJzQXdzWHJKTDI2cEZlS3cxenJyTVNhNG9URjRnanlj?=
 =?utf-8?B?eWZucjQ3eS9jck45OXVPeVp2ejdkV0QyaE5BQUM5dDFoeVJ3VUtLQU1hRGhS?=
 =?utf-8?B?Q2NSdkh0bjVhRm9Hbjg2Ymg4d0pVc05CWUFUTXhPVFI4emR3NG14K3pvUVJw?=
 =?utf-8?B?NG9VQldlWlNyQjlTT1hxN3dXV2haVDg0VHRnMFBuNHBPdDZCbjZXdGlVRUxE?=
 =?utf-8?B?dElMMnM3Mm1XcUQrSFZNZFM0QzZvNFc3STRrc2tTdTdtQ25XZEx6bVU1RCtS?=
 =?utf-8?B?aDl4aXJ5dHowd2NMMldZR1F1T1Y2M0VTbC9SVytOUmQvNHdETm1PckJ5dXpM?=
 =?utf-8?B?bFIrWnVuNTNJY1pvb3Y1dWNIeVJ6Z2M1amtPZzVsTUpKWkxIbGRMR25jVm5Y?=
 =?utf-8?B?V2YrNUtneHpzYVlqdkI1OHVpN3BLWEFnOCs1UnFraWdTOUszNFpvS0xtUmpW?=
 =?utf-8?Q?KdL0vSUz9tsMQTiN98lC9QbP22pG+G5EhmCfwff?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9007164d-5038-4e67-1398-08d98276271c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 11:50:23.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxHX8dZu60PMRQNzoyMT6ueSr80mVpGxT1EEcQxrSpUUNM6VtydOEmdIDjFi255YmGoDi88XRD8gnQS2q9On9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280067
X-Proofpoint-GUID: xsMvHeezP8_jcGZF8fHKurKivipxX9iJ
X-Proofpoint-ORIG-GUID: xsMvHeezP8_jcGZF8fHKurKivipxX9iJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/09/2021 23:32, Josef Bacik wrote:
> On 8/24/21 10:00 PM, Anand Jain wrote:
>> On 28/07/2021 05:01, Josef Bacik wrote:
>>> For device removal and replace we call btrfs_find_device_by_devspec,
>>> which if we give it a device path and nothing else will call
>>> btrfs_find_device_by_path, which opens the block device and reads the
>>> super block and then looks up our device based on that.
>>>
>>> However this is completely unnecessary because we have the path stored
>>> in our device on our fsdevices.  All we need to do if we're given a path
>>> is look through the fs_devices on our file system and use that device if
>>> we find it, reading the super block is just silly.
>>
>> The device path as stored in our fs_devices can differ from the path
>> provided by the user for the same device (for example, dm, lvm).
>>
>> btrfs-progs sanitize the device path but, others (for example, an ioctl
>> test case) might not. And the path lookup would fail.
>>
>> Also, btrfs dev scan <path> can update the device path anytime, even
>> after it is mounted. Fixing that failed the subsequent subvolume mounts
>> (if I remember correctly).
>>
> 
> This is a good point, that's kind of a big deal from a UX perspective.
> 
>>> This fixes the case where we end up with our sb write "lock" getting the
>>> dependency of the block device ->open_mutex, which resulted in the
>>> following lockdep splat
>>
>> Can we do..
>>
>> btrfs_exclop_start()
>>   ::
>> find device part (read sb)
>>   ::
>> mnt_want_write_file()?
>>
>>
> 


> I looked into this, but we'd have to re-order the exclop_start to above 
> the mnt_want_write_file() part everywhere to be consistent, and this is 
> mostly OK except for balance.  Balance the exclop is tied to the 
> lifetime of the balance ctl, which can exist past the task running 
> balance because we could pause the balance.
> 
> Could we get around this?  Sure, but in my head exclop == lock.  This 
> means we have something akin to
> 
> exclop_start
> mnt_want_write_file()
> 
> pause balance
> mnt_drop_write()
> 
> resume balance
> 
> exclop_start magic stuff in balance to resume without doing the exclop
> mnt_want_write_file()
> <do balance>
> exclop_finish
> mnt_drop_write()
> 
> If we're OK with this then we can definitely do that.

This is getting complex. IMO.

> The other option is simply to make userspace do the superblock read and 
> use the devid thing for us.  Then we just eat the UX problem for older 
> tools where you want to do btrfs rm device /dev/mapper/whatever and we 
> have the pathname as /dev/dm-#.


> Both options are unattractive in their own way. 

I agree.

> I think the first 
> option is only annoying to us, and maintains the UX expectations.  But I 
> want more than me to make this decision, so if you and Dave are OK with 
> that I'll go with re-ordering exclop+mnt_want_write_file(), and then put 
> the device lookup between the two of them for device removal.  Thanks,


There is a 3rd option.

Here, the root of the problem is about reading superblock after 
mnt_drop_write().

So to avoid this, can we read the sb -> devid before mnt_drop_write()? 
and use the devid later on?

But when we read the sb we have neither mnt_drop_write() nor 
exclop_start..().

If the devid we read is stale, at a later stage the btrfs_rm_device() 
will still verify it.

I experimented this option, the diff is here [1]. This change needs a 
lot of clean up and did not copy the same logic to btrfs_ioctl_rm_dev() 
or tried to merge it. This diff passed the -g volume test cases with no 
new regressions. But I wasn't able to reproduce the original issue for 
which we wrote this patch.



[1]

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9eb0c1eb568e..e9c6bd05abf9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3164,15 +3164,13 @@ static long btrfs_ioctl_rm_dev_v2(struct file 
*file, void __user *arg)
         struct block_device *bdev = NULL;
         fmode_t mode;
         int ret;
+       bool cancel_or_missing = false;
         bool cancel = false;
+       u64 devid;

         if (!capable(CAP_SYS_ADMIN))
                 return -EPERM;

-       ret = mnt_want_write_file(file);
-       if (ret)
-               return ret;
-
         vol_args = memdup_user(arg, sizeof(*vol_args));
         if (IS_ERR(vol_args)) {
                 ret = PTR_ERR(vol_args);
@@ -3184,9 +3182,32 @@ static long btrfs_ioctl_rm_dev_v2(struct file 
*file, void __user *arg)
                 goto out;
         }
         vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
-       if (!(vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) &&
-           strcmp("cancel", vol_args->name) == 0)
-               cancel = true;
+       if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
+               devid = vol_args->devid;
+       else {
+               if (strcmp("cancel", vol_args->name) == 0) {
+                       cancel_or_missing = true;
+                       cancel = true;
+               } else if (!strcmp("missing", vol_args->name))
+                       cancel_or_missing = true;
+               else {
+                       struct block_device *bdev;
+                       struct btrfs_super_block *disk_super;
+
+                       ret = btrfs_get_bdev_and_sb(vol_args->name, 
FMODE_READ,
+                                                   fs_info->bdev_holder, 0,
+                                                   &bdev, &disk_super);
+                       if (ret)
+                               goto out;
+                       devid = 
btrfs_stack_device_id(&disk_super->dev_item);
+                       btrfs_release_disk_super(disk_super);
+                       blkdev_put(bdev, FMODE_READ);
+               }
+       }
+
+       ret = mnt_want_write_file(file);
+       if (ret)
+               goto out;

         ret = exclop_start_or_cancel_reloc(fs_info, 
BTRFS_EXCLOP_DEV_REMOVE,
                                            cancel);
@@ -3194,10 +3215,10 @@ static long btrfs_ioctl_rm_dev_v2(struct file 
*file, void __user *arg)
                 goto out;
         /* Exclusive operation is now claimed */

-       if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
-               ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, 
&bdev, &mode);
-       else
+       if (cancel_or_missing)
                 ret = btrfs_rm_device(fs_info, vol_args->name, 0, 
&bdev, &mode);
+       else
+               ret = btrfs_rm_device(fs_info, NULL, devid, &bdev, &mode);

         btrfs_exclop_finish(fs_info);

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6ade80bae3a5..85ae7294cea2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -493,7 +493,7 @@ static struct btrfs_fs_devices 
*find_fsid_with_metadata_uuid(
  }


-static int
+int
  btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void 
*holder,
                       int flush, struct block_device **bdev,
                       struct btrfs_super_block **disk_super)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c7ac43d8a7e8..fa1d1faa70d4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -502,6 +502,9 @@ void btrfs_close_devices(struct btrfs_fs_devices 
*fs_devices);
  void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
  void btrfs_assign_next_active_device(struct btrfs_device *device,
                                      struct btrfs_device *this_dev);
+int btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void 
*holder,
+                         int flush, struct block_device **bdev,
+                         struct btrfs_super_block **disk_super);
  struct btrfs_device *btrfs_find_device_by_devspec(struct btrfs_fs_info 
*fs_info,
                                                   u64 devid,
                                                   const char *devpath);



Thanks, Anand


