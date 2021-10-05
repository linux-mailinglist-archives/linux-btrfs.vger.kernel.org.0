Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9847421DEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 07:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhJEF1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 01:27:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10518 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbhJEF1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Oct 2021 01:27:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1954mSHI029448;
        Tue, 5 Oct 2021 05:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5z4490B6RIWY5U6B7d16B2rpmoE5t0VqZ/zCj2RHxVA=;
 b=RBRatD8d4dyUIYADw2gbQp08sxB5MI+Z+X7CDid6vxurqFlU6OylMnmp2MZG2R+3VHOS
 Sdo7jMxZBtYLgsfXNG5cdRz9zSzjlVXY8VMfUuVVAzQ0WJEPrEXUEf3JYyQTlW1En3z7
 Ck2VRIQgQ/wRXKikELpSW2EsW3mRL5P4E0YaikT++kfMHbEy56gfPAI4D7LMruN/zlzG
 CvAJgjbOfCL8qY4S6Yq0WxYGc1Jqz9wK1joJYlj4UDMD12ziFivoenwKAps+ZuoYpQjn
 Ggo1WU4jKHU+qyeh2OsK48562yvj2jEB5mRRgqTVrIGFiPIsga37BQc/Ob/NLbp5MoaK dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kmt6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 05:25:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1955GHnX034692;
        Tue, 5 Oct 2021 05:25:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3020.oracle.com with ESMTP id 3bev8w5w0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 05:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3B+C1wmeiqA/uwP2ywBjHIkD9IRJy8EdxGubQ4rfrOd5418P1bPI+FUi8ocBeXiSBwC4OiONpKy1vMzBngIecHZXkuQ3x0ZcwNQqTog3kcJsheKFLFL2PFmQS9SZTqMsx8YyfOgJyfqFYylclCTIfJxoBfO7Typ+mFUY+qRKut061BWYzaTnSP2VuIq2hyQMutQnDKvRlnwd75+YE/dr5T7zkwmtvdJQCaRnme5NBBuI7rYnVP2Ll5kDArLxK44hPrV6JWd1M4w8DZR8Dt2Jk0ASWj7IZxAOyj1/ZfA6saYUqkYdPFN6lIJxWPpq6i4H+YkMdO9oVBeDcL3gvGiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z4490B6RIWY5U6B7d16B2rpmoE5t0VqZ/zCj2RHxVA=;
 b=IxjmBxls0bVZ3gVMb4lY/AaZBJX3kaXxUErSGMS4QEePzIa7U8b8l0AG0n+jqBf85vFNsDT8TsOChCFTn4BSrRIzxCcVNTnpTq+n7/63ScfjXsafvRMWROeB90T+zkR/7dvLdJslu6/YUQu2ZKn0n31TevEjyabtUMrDITbuLS9woR9Wg5ceWsF+JT+WHzLnHCgx9o0LGMgyuPjWJzKAUw8z4eA9wMFrZzLnLdQcy4yv5q6t77HPJVay5CYbk9X/47I0YmjpN0K7C6VFfRpH4tAJbGGHskAnB2ZjAqQl9I2HTi+LsfcU0/D9kcLIXcxpF6ix+PYkKbnRIc4rjtw6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z4490B6RIWY5U6B7d16B2rpmoE5t0VqZ/zCj2RHxVA=;
 b=A5kNFBhY9ggw0A8tC4MHFSBFhj8RBsFkEJnYtpt+fevaRwsldOI7XvrJ/cxpB0tSG33HQIEsPthoHo6NksedfsBanaKtEB5ykos7bQsFGAZTbwPSgXM55D8DFRup3UYa950ehMoHBPSP8s0FC2pYgqpDSwTy2KU015Anw1gMbN4=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 05:25:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 05:25:50 +0000
Subject: Re: [PATCH v3 4/6] btrfs: handle device lookup with
 btrfs_dev_lookup_args
From:   Anand Jain <anand.jain@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633367810.git.josef@toxicpanda.com>
 <5fb28919a4034e6ebd0c677e5bb1b52bf8fb4fdd.1633367810.git.josef@toxicpanda.com>
 <15a261ef-df68-41ee-7cf4-494b11c38b01@oracle.com>
Message-ID: <cee8e985-260e-9d89-fb44-c552cca7c3bd@oracle.com>
Date:   Tue, 5 Oct 2021 13:25:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <15a261ef-df68-41ee-7cf4-494b11c38b01@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0143.apcprd03.prod.outlook.com
 (2603:1096:4:c8::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0143.apcprd03.prod.outlook.com (2603:1096:4:c8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.11 via Frontend Transport; Tue, 5 Oct 2021 05:25:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bfe5090-7ed7-414b-b53b-08d987c09821
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4093A3B2E0EA739463D4E04EE5AF9@MN2PR10MB4093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rX60BOPT1YU2aytQTliKY9ATz9AEH8yA4hongCU5sFDKP0a7fXQuld6UKXrIW7J6fOOiXqXELYu+wv69MfUmDmxFL1Xvuq1tmp5asNKxmX1jxpdJ/1Fpsn7JRmSXfOaN87wmRfMfEPrdY0He+VV/u40TcTgN1++fbE7AfH4+BjTbFycnZevzS1ESLpsrh0lrfadNwDx6i+wGoY1RLdvKD+MFAvv9G7/X8qypKTsoZfe2jnilX7o7klTjPGnmS5M1st1+prG3ZCNQQbTpjAvkpoJfW0vCQ1U2hstpGEzyhui26QNyoF7zpEJprgQpjf0cuzMiaUZad/e3a7RLqWfQpBNTO+3PpK3AXVAsOOCpv/TGuxPQsq07yJrDBBHmlOnir/C7SguOfhYWMDjfNAcuhKi5PQqGglA9CEEOLTVLDqr9aFgM2TH2Km4MLcl1WieBSWr9ADYwSGhNRpiNP2hEehIMxUjg86Zylk4nnC4GSVCYrfw2FR4fPs7umtaxrNqFdM+GXcM0KogYneFe2Vo/0NVGNbHzuKZxL3bY/mjFUein5VMDlH+4lwjhHCIAU9RsCNCWjyHmwXO4gZZ2BDALffcdnCk6/nsef2S/nUeOrZ8juf1yQJ2VeRQz9VI9Z/XXKIUZrh1Zg97iT/nlf9P4s/UyQrm9cmvPufCwX+T+hcSdMBwmyAhMd4aoYAn2OMeW6AP8+jIbEA2uBHOFAqIj23JbgL6YzJ91DLLH1gtYCMK3RJ1LYLh+mWFT3ea+Y2yb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(30864003)(316002)(38100700002)(6666004)(31686004)(16576012)(36756003)(83380400001)(2906002)(6486002)(186003)(2616005)(956004)(8936002)(8676002)(86362001)(44832011)(53546011)(31696002)(66476007)(26005)(66556008)(66946007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dER5VXJEMEw2Q1pwb0N5bGRjZjNBZzdEMjZPQlhHNUR5cldGMG9WVVJMeUlT?=
 =?utf-8?B?UGR6S1RhZWQ5bE5xQ0ZSaTM1Y2ZrRUpKeUo4eHBQYkNxaUN1OUhabFlrcVNF?=
 =?utf-8?B?b3VPRVR6VlYyRDFKS1AwWGU1Yk15OXg0VFY3VDI2ck5pOGpxRlJOanpuN0lF?=
 =?utf-8?B?MTRJeXRIVjY2NEgyVVpKVEE3d3Zmd0x6dFlEY2NLY1BVVVBtcmEvMGhkUjcr?=
 =?utf-8?B?YzluVStNbGtOaXllMHFrWUV1WHNxVXZJcVN1aHh0WUFneEZZeCszczNlcDZR?=
 =?utf-8?B?U1hOd01PbVdHdUx3a0xXMGZ3cmN6bzVuN1Q5MHR1NG5iQUp3Y0YyRkR5WGdw?=
 =?utf-8?B?ZnIwNCtnRFFRUUhsRTBIRmNtTXBXOGI0d0FoaWQxU2lobWNhMVExd3ExVC9a?=
 =?utf-8?B?RGJYQkZqMndZOHByK0xQUGtCRUFHa2JRU1pjbnB4VGhaVUc0NmNxYTJDKzNv?=
 =?utf-8?B?Zll6aTFaWVdFRmZTU0VtQ1A2ZzZ5dEp1TnVhdWEzYUM5S29OeDM2aEh6U3lv?=
 =?utf-8?B?VGJ4RVR0OWtqbnZ2VXF1Zzl4c01zcFcxU2pYT3JROGlyM0dZVDMvVUdVa2sw?=
 =?utf-8?B?MW40M1BOQkl4UUUrMmF0UVlIMHI2M1BkaHVveTVGazdXM1RwZXlRN3g0dEFt?=
 =?utf-8?B?YzR5eE95dzNuNVhBdXZmVmpra0MrYTBaK1hOeHNVcTdqUHYwVHdLVFdVRmNt?=
 =?utf-8?B?dnRnL1MzNVRSWXZhRmtLSG1yaDJqRElOdnQvMU9aS2xzZnNacXk1YWw5aWFs?=
 =?utf-8?B?Y2FDREJ6M0xTMis3S0lLdGtlZldmRHFrdTFQcGJ5Vkg1WWlEWEV3Znltc0tz?=
 =?utf-8?B?a1UwMmFpMXBLSlR2M1J0NzF2S1dOQi9TNkNsSWtZb0E2MDBYYS9zS28vMUNH?=
 =?utf-8?B?UlBzNDBzRlZYS3FRa3c5Z3RMNkdPanpOZmhRZ2JCUHA3SFBKbm04N29POWsx?=
 =?utf-8?B?akNyMlRBY25MMFMwNFNOcnVGMVJKcGVkMGlnWUhEQk5XK0E3MDdIdUh0RVZZ?=
 =?utf-8?B?alpSTG5uaGVGSXJ2ckhhUHJmdmR6RkhvWHdNZGlmRXFLbkUyZ0hwcjdIZHJw?=
 =?utf-8?B?YU45K0ZqdjlWR1pLalRFN05HaFluenFoenVpMEM3WUdCQTRMa05wWnJ5SVBR?=
 =?utf-8?B?aUE2QmhVTlhPWU90UEl1UzJTV0dFTzhzbTRuQWZPSlUyUm0yMDd1MmNxZlc2?=
 =?utf-8?B?OFBqZ0NmbUtKS3FmM0pTSDRzcDRlTzUwM1c1QXJsdmYvblkwb2xNZGVhVXdZ?=
 =?utf-8?B?ZW1VNUFHZjk0QU5jVnNpTlFycy85c1dEMDNQNTlQeVQrRHp3WU44Umk3MWVv?=
 =?utf-8?B?QVRBaE9RLzdPSWJic3Q5OFJ2a254UE5kNG1XcG1oRzNtRUtZZHN5bUFULy9B?=
 =?utf-8?B?ZUxBOUJMWlZVeUJLNlA3Y0hob09vM2wxU1cxbTVhbG54d21tYXRnNWRFLzRi?=
 =?utf-8?B?Y2xHeDdYem1ENU9LcDhVc0J0NTdvNm9FQUZUMTkvZ1UxTUd6a2RrR2ZMNHZR?=
 =?utf-8?B?dGNWak1DbVJQSGNUUnlReHQweFNIUlVRZGkyUEdLUkg4Q1BBZC9zd3pITVNW?=
 =?utf-8?B?MU8yakVrS0V3RFNvVk1XdERmcTRqMCt1eDVRaXYybzFSa2hqRVB6R0I0bnlu?=
 =?utf-8?B?eE9QNEV0ODdUYit4T0dWQ3pHZ3VBR3FXNjR6dWZFclVmam1mUk5ZWngvOVpw?=
 =?utf-8?B?T0pCOUJNOXZpUXpOY2dFMkZGZ295NlhmVnh3U2JxWmRPQUU0QUZSYjU5dzNt?=
 =?utf-8?Q?GjAcR9a4YHokU8Z8h3ZDjt1WcYpSVrVOs5DmtYJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfe5090-7ed7-414b-b53b-08d987c09821
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 05:25:50.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntf3EcKbweViA2kunKKieJZswE+dt1ZmJSd4r03ng/g+Y/uYDXityi0RUfcE9E3H5emwG4KOXUrCmjbBUdtDIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050029
X-Proofpoint-GUID: w-TRJ645GDjRefcdhhcurSgNTZOp6K05
X-Proofpoint-ORIG-GUID: w-TRJ645GDjRefcdhhcurSgNTZOp6K05
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 05/10/2021 12:48, Anand Jain wrote:
> On 05/10/2021 01:19, Josef Bacik wrote:
>> We have a lot of device lookup functions that all do something slightly
>> different.
> 
>>  Clean this up by adding a struct to hold the different
>> lookup criteria, and then pass this around to btrfs_find_device() so it
>> can do the proper matching based on the lookup criteria.
> 
>   It is better now.
> 
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
>   Looks good.
> 
>   Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Thanks, Anand
> 
> 
>> ---
>>   fs/btrfs/dev-replace.c |  18 +++----
>>   fs/btrfs/ioctl.c       |  13 ++---
>>   fs/btrfs/scrub.c       |   6 ++-
>>   fs/btrfs/volumes.c     | 120 +++++++++++++++++++++++++----------------
>>   fs/btrfs/volumes.h     |  15 +++++-
>>   5 files changed, 108 insertions(+), 64 deletions(-)
>>
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>> index d029be40ea6f..ff25da2dbd59 100644
>> --- a/fs/btrfs/dev-replace.c
>> +++ b/fs/btrfs/dev-replace.c
>> @@ -70,6 +70,7 @@ static int btrfs_dev_replace_kthread(void *data);
>>   int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_key key;
>>       struct btrfs_root *dev_root = fs_info->dev_root;
>>       struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
>> @@ -84,6 +85,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info 
>> *fs_info)
>>       if (!dev_root)
>>           return 0;
>> +    args.devid = BTRFS_DEV_REPLACE_DEVID;
>> +
>>       path = btrfs_alloc_path();
>>       if (!path) {
>>           ret = -ENOMEM;
>> @@ -100,8 +103,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info 
>> *fs_info)
>>            * We don't have a replace item or it's corrupted.  If there is
>>            * a replace target, fail the mount.
>>            */
>> -        if (btrfs_find_device(fs_info->fs_devices,
>> -                      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
>> +        if (btrfs_find_device(fs_info->fs_devices, &args)) {
>>               btrfs_err(fs_info,
>>               "found replace target device without a valid replace 
>> item");
>>               ret = -EUCLEAN;
>> @@ -163,8 +165,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info 
>> *fs_info)
>>            * We don't have an active replace item but if there is a
>>            * replace target, fail the mount.
>>            */
>> -        if (btrfs_find_device(fs_info->fs_devices,
>> -                      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
>> +        if (btrfs_find_device(fs_info->fs_devices, &args)) {
>>               btrfs_err(fs_info,
>>               "replace devid present without an active replace item");
>>               ret = -EUCLEAN;
>> @@ -175,11 +176,10 @@ int btrfs_init_dev_replace(struct btrfs_fs_info 
>> *fs_info)
>>           break;
>>       case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
>>       case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
>> -        dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices,
>> -                        src_devid, NULL, NULL);
>> -        dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices,
>> -                            BTRFS_DEV_REPLACE_DEVID,
>> -                            NULL, NULL);
>> +        dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, 
>> &args);
>> +        args.devid = src_devid;
>> +        dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, 
>> &args);
>> +
>>           /*
>>            * allow 'btrfs dev replace_cancel' if src/tgt device is
>>            * missing
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 9eb0c1eb568e..b8508af4e539 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1602,6 +1602,7 @@ static int exclop_start_or_cancel_reloc(struct 
>> btrfs_fs_info *fs_info,
>>   static noinline int btrfs_ioctl_resize(struct file *file,
>>                       void __user *arg)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct inode *inode = file_inode(file);
>>       struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>       u64 new_size;
>> @@ -1657,7 +1658,8 @@ static noinline int btrfs_ioctl_resize(struct 
>> file *file,
>>           btrfs_info(fs_info, "resizing devid %llu", devid);
>>       }
>> -    device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
>> +    args.devid = devid;
>> +    device = btrfs_find_device(fs_info->fs_devices, &args);
>>       if (!device) {
>>           btrfs_info(fs_info, "resizer unable to find device %llu",
>>                  devid);
>> @@ -3317,22 +3319,21 @@ static long btrfs_ioctl_fs_info(struct 
>> btrfs_fs_info *fs_info,
>>   static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
>>                    void __user *arg)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_ioctl_dev_info_args *di_args;
>>       struct btrfs_device *dev;
>>       int ret = 0;
>> -    char *s_uuid = NULL;
>>       di_args = memdup_user(arg, sizeof(*di_args));
>>       if (IS_ERR(di_args))
>>           return PTR_ERR(di_args);
>> +    args.devid = di_args->devid;
>>       if (!btrfs_is_empty_uuid(di_args->uuid))
>> -        s_uuid = di_args->uuid;
>> +        args.uuid = di_args->uuid;
>>       rcu_read_lock();
>> -    dev = btrfs_find_device(fs_info->fs_devices, di_args->devid, s_uuid,
>> -                NULL);
>> -
>> +    dev = btrfs_find_device(fs_info->fs_devices, &args);
>>       if (!dev) {
>>           ret = -ENODEV;
>>           goto out;
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index bd3cd7427391..1e29b9aa45df 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -4067,6 +4067,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info 
>> *fs_info, u64 devid, u64 start,
>>               u64 end, struct btrfs_scrub_progress *progress,
>>               int readonly, int is_dev_replace)
>>   {
>> +    struct btrfs_dev_lookup_args args = { .devid = devid };
> 
>>       struct scrub_ctx *sctx;
>>       int ret;
>>       struct btrfs_device *dev;
>> @@ -4114,7 +4115,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info 
>> *fs_info, u64 devid, u64 start,
>>           goto out_free_ctx;
>>       mutex_lock(&fs_info->fs_devices->device_list_mutex);
>> -    dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
>> +    dev = btrfs_find_device(fs_info->fs_devices, &args);
>>       if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
>>                !is_dev_replace)) {
>>           mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>> @@ -4287,11 +4288,12 @@ int btrfs_scrub_cancel_dev(struct btrfs_device 
>> *dev)
>>   int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
>>                struct btrfs_scrub_progress *progress)
>>   {
>> +    struct btrfs_dev_lookup_args args = { .devid = devid };
> 
> 
>>       struct btrfs_device *dev;
>>       struct scrub_ctx *sctx = NULL;
>>       mutex_lock(&fs_info->fs_devices->device_list_mutex);
>> -    dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
>> +    dev = btrfs_find_device(fs_info->fs_devices, &args);
>>       if (dev)
>>           sctx = dev->scrub_ctx;
>>       if (sctx)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 5f19d0863094..191360e44a20 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -812,9 +812,13 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>           device = NULL;
>>       } else {
>> +        struct btrfs_dev_lookup_args args = {
>> +            .devid = devid,
>> +            .uuid = disk_super->dev_item.uuid,
>> +        };
>> +
>>           mutex_lock(&fs_devices->device_list_mutex);
>> -        device = btrfs_find_device(fs_devices, devid,
>> -                disk_super->dev_item.uuid, NULL);
>> +        device = btrfs_find_device(fs_devices, &args);
>>           /*
>>            * If this disk has been pulled into an fs devices created by
>> @@ -2323,10 +2327,9 @@ void btrfs_destroy_dev_replace_tgtdev(struct 
>> btrfs_device *tgtdev)
>>   static struct btrfs_device *btrfs_find_device_by_path(
>>           struct btrfs_fs_info *fs_info, const char *device_path)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       int ret = 0;
>>       struct btrfs_super_block *disk_super;
>> -    u64 devid;
>> -    u8 *dev_uuid;
>>       struct block_device *bdev;
>>       struct btrfs_device *device;
>> @@ -2335,14 +2338,14 @@ static struct btrfs_device 
>> *btrfs_find_device_by_path(
>>       if (ret)
>>           return ERR_PTR(ret);
>> -    devid = btrfs_stack_device_id(&disk_super->dev_item);
>> -    dev_uuid = disk_super->dev_item.uuid;
>> +    args.devid = btrfs_stack_device_id(&disk_super->dev_item);
>> +    args.uuid = disk_super->dev_item.uuid;
>>       if (btrfs_fs_incompat(fs_info, METADATA_UUID))
>> -        device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>> -                       disk_super->metadata_uuid);
>> +        args.fsid = disk_super->metadata_uuid;
>>       else
>> -        device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>> -                       disk_super->fsid);
>> +        args.fsid = disk_super->fsid;
>> +
>> +    device = btrfs_find_device(fs_info->fs_devices, &args);
>>       btrfs_release_disk_super(disk_super);
>>       if (!device)
>> @@ -2358,11 +2361,12 @@ struct btrfs_device 
>> *btrfs_find_device_by_devspec(
>>           struct btrfs_fs_info *fs_info, u64 devid,
>>           const char *device_path)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_device *device;
>>       if (devid) {
>> -        device = btrfs_find_device(fs_info->fs_devices, devid, NULL,
>> -                       NULL);
>> +        args.devid = devid;
>> +        device = btrfs_find_device(fs_info->fs_devices, &args);
>>           if (!device)
>>               return ERR_PTR(-ENOENT);
>>           return device;
>> @@ -2372,14 +2376,11 @@ struct btrfs_device 
>> *btrfs_find_device_by_devspec(
>>           return ERR_PTR(-EINVAL);
>>       if (strcmp(device_path, "missing") == 0) {
>> -        /* Find first missing device */
>> -        list_for_each_entry(device, &fs_info->fs_devices->devices,
>> -                    dev_list) {
>> -            if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
>> -                     &device->dev_state) && !device->bdev)
>> -                return device;
>> -        }
>> -        return ERR_PTR(-ENOENT);
>> +        args.missing = true;
>> +        device = btrfs_find_device(fs_info->fs_devices, &args);
>> +        if (!device)
>> +            return ERR_PTR(-ENOENT);
>> +        return device;
>>       }
>>       return btrfs_find_device_by_path(fs_info, device_path);
>> @@ -2459,6 +2460,7 @@ static int btrfs_prepare_sprout(struct 
>> btrfs_fs_info *fs_info)
>>    */
>>   static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_fs_info *fs_info = trans->fs_info;
>>       struct btrfs_root *root = fs_info->chunk_root;
>>       struct btrfs_path *path;
>> @@ -2468,7 +2470,6 @@ static int btrfs_finish_sprout(struct 
>> btrfs_trans_handle *trans)
>>       struct btrfs_key key;
>>       u8 fs_uuid[BTRFS_FSID_SIZE];
>>       u8 dev_uuid[BTRFS_UUID_SIZE];
>> -    u64 devid;
>>       int ret;
>>       path = btrfs_alloc_path();
>> @@ -2505,13 +2506,14 @@ static int btrfs_finish_sprout(struct 
>> btrfs_trans_handle *trans)
>>           dev_item = btrfs_item_ptr(leaf, path->slots[0],
>>                         struct btrfs_dev_item);
> 
>> -        devid = btrfs_device_id(leaf, dev_item);
>> +        args.devid = btrfs_device_id(leaf, dev_item);
> 
>>           read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
>>                      BTRFS_UUID_SIZE);
>>           read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
>>                      BTRFS_FSID_SIZE);
>> -        device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>> -                       fs_uuid);
>> +        args.uuid = dev_uuid;
>> +        args.fsid = fs_uuid;
> 
> 
> 
>> +        device = btrfs_find_device(fs_info->fs_devices, &args);
>>           BUG_ON(!device); /* Logic error */
>>           if (device->fs_devices->seeding) {
>> @@ -6753,6 +6755,32 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info 
>> *fs_info, struct bio *bio,
>>       return BLK_STS_OK;
>>   }
>> +static inline bool dev_args_match_fs_devices(struct 
>> btrfs_dev_lookup_args *args,
>> +                         struct btrfs_fs_devices *fs_devices)
>> +{
>> +    if (args->fsid == NULL)
>> +        return true;
>> +    if (!memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE))
>> +        return true;
>> +    return false;
>> +}
>> +
> 
>> +static inline bool dev_args_match_device(struct btrfs_dev_lookup_args 
>> *args,
>> +                     struct btrfs_device *device)
>> +{
>> +    ASSERT((args->devid != (u64)-1) || args->missing);
>> +    if ((args->devid != (u64)-1) && device->devid != args->devid)
>> +        return false;
>> +    if (args->uuid && memcmp(device->uuid, args->uuid, BTRFS_UUID_SIZE))
>> +        return false;
>> +    if (!args->missing)
>> +        return true;
>> +    if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
>> +        !device->bdev)
>> +        return true;
>> +    return false;
>> +}
> 
> 
>> +
>>   /*
>>    * Find a device specified by @devid or @uuid in the list of 
>> @fs_devices, or
>>    * return NULL.
>> @@ -6761,30 +6789,24 @@ blk_status_t btrfs_map_bio(struct 
>> btrfs_fs_info *fs_info, struct bio *bio,
>>    * only devid is used.
>>    */
>>   struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices 
>> *fs_devices,
>> -                       u64 devid, u8 *uuid, u8 *fsid)
>> +                       struct btrfs_dev_lookup_args *args)
>>   {
>>       struct btrfs_device *device;
>>       struct btrfs_fs_devices *seed_devs;
>> -    if (!fsid || !memcmp(fs_devices->metadata_uuid, fsid, 
>> BTRFS_FSID_SIZE)) {
>> +    if (dev_args_match_fs_devices(args, fs_devices)) {
>>           list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> -            if (device->devid == devid &&
>> -                (!uuid || memcmp(device->uuid, uuid,
>> -                         BTRFS_UUID_SIZE) == 0))
>> +            if (dev_args_match_device(args, device))
>>                   return device;
>>           }
>>       }
>>       list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
>> -        if (!fsid ||
>> -            !memcmp(seed_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
>> -            list_for_each_entry(device, &seed_devs->devices,
>> -                        dev_list) {
>> -                if (device->devid == devid &&
>> -                    (!uuid || memcmp(device->uuid, uuid,
>> -                             BTRFS_UUID_SIZE) == 0))
>> -                    return device;
>> -            }
>> +        if (!dev_args_match_fs_devices(args, seed_devs))
>> +            continue;
>> +        list_for_each_entry(device, &seed_devs->devices, dev_list) {
>> +            if (dev_args_match_device(args, device))
>> +                return device;
>>           }
>>       }
>> @@ -6950,6 +6972,7 @@ static void warn_32bit_meta_chunk(struct 
>> btrfs_fs_info *fs_info,
>>   static int read_one_chunk(struct btrfs_key *key, struct 
>> extent_buffer *leaf,
>>                 struct btrfs_chunk *chunk)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_fs_info *fs_info = leaf->fs_info;
>>       struct extent_map_tree *map_tree = &fs_info->mapping_tree;
>>       struct map_lookup *map;
>> @@ -7026,12 +7049,12 @@ static int read_one_chunk(struct btrfs_key 
>> *key, struct extent_buffer *leaf,
>>       for (i = 0; i < num_stripes; i++) {
>>           map->stripes[i].physical =
>>               btrfs_stripe_offset_nr(leaf, chunk, i);
>> -        devid = btrfs_stripe_devid_nr(leaf, chunk, i);

  We need devid to initialize here for local use.
  This fix is in the path 5/6. However, it should move here.


>> +        args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
>>           read_extent_buffer(leaf, uuid, (unsigned long)
>>                      btrfs_stripe_dev_uuid_nr(chunk, i),
>>                      BTRFS_UUID_SIZE);
>> -        map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices,
>> -                            devid, uuid, NULL);
>> +        args.uuid = uuid;
>> +        map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, 
>> &args);
>>           if (!map->stripes[i].dev &&
>>               !btrfs_test_opt(fs_info, DEGRADED)) {
>>               free_extent_map(em);
>> @@ -7149,6 +7172,7 @@ static struct btrfs_fs_devices 
>> *open_seed_devices(struct btrfs_fs_info *fs_info,
>>   static int read_one_dev(struct extent_buffer *leaf,
>>               struct btrfs_dev_item *dev_item)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_fs_info *fs_info = leaf->fs_info;
>>       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>       struct btrfs_device *device;
>> @@ -7157,11 +7181,13 @@ static int read_one_dev(struct extent_buffer 
>> *leaf,
>>       u8 fs_uuid[BTRFS_FSID_SIZE];
>>       u8 dev_uuid[BTRFS_UUID_SIZE];
>> -    devid = btrfs_device_id(leaf, dev_item);

  We need devid to initialize here for local use.
  This fix is in the path 5/6. However, it should move here.

Thanks, Anand


>> +    args.devid = btrfs_device_id(leaf, dev_item);
>>       read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
>>                  BTRFS_UUID_SIZE);
>>       read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
>>                  BTRFS_FSID_SIZE);
>> +    args.uuid = dev_uuid;
>> +    args.fsid = fs_uuid;
>>       if (memcmp(fs_uuid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE)) {
>>           fs_devices = open_seed_devices(fs_info, fs_uuid);
>> @@ -7169,8 +7195,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>>               return PTR_ERR(fs_devices);
>>       }
>> -    device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>> -                   fs_uuid);
>> +    device = btrfs_find_device(fs_info->fs_devices, &args);
>>       if (!device) {
>>           if (!btrfs_test_opt(fs_info, DEGRADED)) {
>>               btrfs_report_missing_device(fs_info, devid,
>> @@ -7839,12 +7864,14 @@ static void 
>> btrfs_dev_stat_print_on_load(struct btrfs_device *dev)
>>   int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
>>               struct btrfs_ioctl_get_dev_stats *stats)
>>   {
>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>       struct btrfs_device *dev;
>>       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>       int i;
>>       mutex_lock(&fs_devices->device_list_mutex);
>> -    dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, 
>> NULL);
>> +    args.devid = stats->devid;
>> +    dev = btrfs_find_device(fs_info->fs_devices, &args);
>>       mutex_unlock(&fs_devices->device_list_mutex);
>>       if (!dev) {
>> @@ -7920,6 +7947,7 @@ static int verify_one_dev_extent(struct 
>> btrfs_fs_info *fs_info,
>>                    u64 chunk_offset, u64 devid,
>>                    u64 physical_offset, u64 physical_len)
>>   {
>> +    struct btrfs_dev_lookup_args args = { .devid = devid };
>>       struct extent_map_tree *em_tree = &fs_info->mapping_tree;
>>       struct extent_map *em;
>>       struct map_lookup *map;
>> @@ -7975,7 +8003,7 @@ static int verify_one_dev_extent(struct 
>> btrfs_fs_info *fs_info,
>>       }
>>       /* Make sure no dev extent is beyond device boundary */
>> -    dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
>> +    dev = btrfs_find_device(fs_info->fs_devices, &args);
>>       if (!dev) {
>>           btrfs_err(fs_info, "failed to find devid %llu", devid);
>>           ret = -EUCLEAN;
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index c7ac43d8a7e8..fa9a56c37d45 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -452,6 +452,19 @@ struct btrfs_balance_control {
>>       struct btrfs_balance_progress stat;
>>   };
>> +struct btrfs_dev_lookup_args {
>> +    u64 devid;
>> +    u8 *uuid;
>> +    u8 *fsid;
>> +    bool missing;
>> +};
>> +
>> +/* We have to init to -1 because BTRFS_DEV_REPLACE_DEVID is 0 */
>> +#define BTRFS_DEV_LOOKUP_ARGS_INIT { .devid = (u64)-1 }
>> +
>> +#define BTRFS_DEV_LOOKUP_ARGS(name) \
>> +    struct btrfs_dev_lookup_args name = BTRFS_DEV_LOOKUP_ARGS_INIT
>> +
>>   enum btrfs_map_op {
>>       BTRFS_MAP_READ,
>>       BTRFS_MAP_WRITE,
>> @@ -517,7 +530,7 @@ int btrfs_num_copies(struct btrfs_fs_info 
>> *fs_info, u64 logical, u64 len);
>>   int btrfs_grow_device(struct btrfs_trans_handle *trans,
>>                 struct btrfs_device *device, u64 new_size);
>>   struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices 
>> *fs_devices,
>> -                       u64 devid, u8 *uuid, u8 *fsid);
>> +                       struct btrfs_dev_lookup_args *args);
>>   int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
>>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char 
>> *path);
>>   int btrfs_balance(struct btrfs_fs_info *fs_info,
>>
> 
