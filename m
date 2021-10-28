Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1940143DA69
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 06:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhJ1EfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 00:35:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21890 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhJ1EfE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 00:35:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S1Ww9H027369;
        Thu, 28 Oct 2021 04:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qDRF81HCMDgTlzXOUyBwpqMHb1XdmJ2Ri5+YEU8JMXE=;
 b=q7e1Uok8/3++UZDnTO0FHoBaPECuFYHXiZQUSg1BRn+Swv/DIW/ckHSHUSMuYS1m/X5y
 rZSgbMU4kuzU5xzWUREyTvf5QNVA2WA4zYdiswFggMnkC7Iu4W1/En1q/WuzQJji4+RS
 FEp8pgsmbyzS36wgnuUk9SPSm3Vicj2Q47pfKrIRsgd/6WlmxZCLU4dEJRRrFpBiN6KY
 D63KSQSDY3DKd0BLwjSat2R+8yxkjIORW0qIBGKLSbzsfAFPFr8/Xxd4S5LMJYIbVyjk
 Qw37LmMZ6GAKl12OGAM23wr9WUL756LJSu7603iJ/7E0v9txqUk2Mwfk4V1OzB1cpc02 dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byja28cdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 04:32:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19S4W1Xf021656;
        Thu, 28 Oct 2021 04:32:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3bx4h3f5bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 04:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmycwB+gQqc1uhmlS8P1TpVTzVV8WwpCXZiK3Q++HcrYMWEDx30EJ7YZBiXY4CxnPBNuPZQYcDXGuiP+PhHPiKvTDcbb1AWiPDUBrvLfpOFdthnPpq5eOcN84X+SqUPtoxZDko+UkcFRUgAWBxf1+CwRKkS6hEaNW2dPVOtn3AxH2TLPFWkwll8vVBBxnNmnGpZVOiNJ8kSd/OidNZvAkNJS3sUFTa7AygiyoefhTc1rQS++4DqfwV5HJViLxXDXim7Bz/Pf8wTw1Lbr6ZFZ+GoSbjiFM7k/jTFEj0EJLaVtmnW9kOXzpShUsEwQIBff+cpI5+RR8gcpJwSwXwJCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDRF81HCMDgTlzXOUyBwpqMHb1XdmJ2Ri5+YEU8JMXE=;
 b=N1mHfBNVMHtc7LFjLWld51XQliSRaTRtkQ0lsDP8U7DrHJCXQLtKzn8vqtB7w3nJgNjnfQ/ib42I7UHlOtBnoT/pr5jTThtFS5hC+nArflWJrIK7QNThDojEe0CxUphYT8K/pOe7aYJz2xqVhPQL5MmjqeDyZGMEMwKbZ66BABR7JpkwGez965kaU9t3zYSHSa6iDE6spVBCNDdpzVLgdvyVg7jKZZN9SAwfrMlL5YEgojGkXigT7K9L/SMptQHRolAwYWlJnvVfvb/sq8kybuX22vBhHTIXopciHpj5Pf1e4Gq90j6T6t0rzArODCl5p/aJd8YVpZtdBl8jxYOveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDRF81HCMDgTlzXOUyBwpqMHb1XdmJ2Ri5+YEU8JMXE=;
 b=eSnKpxKWZ9lfyCn7UtHltM5PQvNQQUyDQZYtCfljTQNq8odkep6z+K+nLsgoVLV9teZHZ5NKn8OJTOLEyzD1ZfKqQEVZzFmsWagU35LmDeUrks3BM7gBH8SZBJZCW9lbPoFoLSxK3BGKTBztEUsbIKE/CkT8PVbMJHfSXNlD9ig=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2852.namprd10.prod.outlook.com (2603:10b6:208:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 04:32:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 04:32:29 +0000
Message-ID: <cf881d0c-4c73-600d-42a5-ed0f876a8d6b@oracle.com>
Date:   Thu, 28 Oct 2021 12:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v9] btrfs: consolidate device_list_mutex in prepare_sprout
 to its parent
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
 <30861144-9327-8d61-49fc-505174d45caf@oracle.com>
In-Reply-To: <30861144-9327-8d61-49fc-505174d45caf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR04CA0017.apcprd04.prod.outlook.com (2603:1096:4:197::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 04:32:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6075b31-e9ab-4b60-c454-08d999cbf365
X-MS-TrafficTypeDiagnostic: BL0PR10MB2852:
X-Microsoft-Antispam-PRVS: <BL0PR10MB285200898B3DECD8E6E907B5E5869@BL0PR10MB2852.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlnIF45PKx2ywUbNhjTrIMFb/lArXKLSaaQX9/7JuAATuDm5zj13IwLW26KH9iM1qMadgpkuhFu3o1NwHXmLH0oD8nFMflt2fErijJX+bnG7x+D1yaI+J180eNnW+YTV00h2C17w08QROQoDYveYsKcMFfz4+ljEBR5SsFOsv7+4N5wtMz8bdLvFSrMhS78zyAiTZwIl49kjFk/78xckQsVy0bZUcvyOgyS9fU35KAUh0EGNA0Pqb/aZiLIV3WuXBn2q3+BVqWPVtDta0wHmqemp4LKCUwGyZ6Iz0tTYlErfGGdn/wUdGd37ii7N/ZGViEcIRDYJ51aKJVdbriJO04eEd/pe0NCeqQEKS70ftM3Ul6sT1i26lqfz7SKQQRcFMd7G8VloPZjuY9Lh0q7cEQi4+L8Jdl6jH79qD45rbJQluMKYWpWhJ916lGuiMg/RqsL3r9cjIPmoK8amRCoISsk37Y7AuGAbe8XAIxqqMH9d1D44zuArwwbXjb6A4Ce82xf+2FfU3OONsavutuYbDuKehJl2KBES0Vfv/4il9o4Ileffs/fyIckuTQShK4r569V+XQ407ZAC3AYNzRJHHcE96hfhKX8ynA3PkP+6z2qIy0cUIPJeOKCeObMz7kKihwdyONU0sUC2OWElMg68RAY3SaI5iBDOoVVPhbsk8Srx2krxrkg7IBOhvMbSNwMZZ0M6rY1lsleTZ/uos5hoau0J+qmxmbJfxtAzU4okLYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(83380400001)(66556008)(2616005)(5660300002)(86362001)(66476007)(16576012)(4326008)(31686004)(508600001)(8936002)(66946007)(956004)(8676002)(2906002)(31696002)(36756003)(186003)(26005)(53546011)(6916009)(6666004)(38100700002)(44832011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtQa3NVRWVaMCtIRTBwYmViY2ROeEdEQ2hJeFpWZlVLUjNaeXZUNTlUK1B6?=
 =?utf-8?B?U1ZxMXh2L2hNeWIya2hCNHU1UWIxYitmYVlaUlBCSC94SlYrV3dxRWZzZTVV?=
 =?utf-8?B?NmYxM1FaMDA2OGZKeXdTQTNDdWFncitMZlBNNDMxdDJrOVNXeWVFSVJKcWVl?=
 =?utf-8?B?SGdXaTllWkIvNDNCQnJUV0kxKzlWOVFXUE1Eb3FBYlJ0ODNQSXBBMlZXYmRV?=
 =?utf-8?B?cnp3bHVRdHB1UENqNE40RFZlcnFFRHN5RGxjMnJwMzd2eC9hOGM4Q05lQlNk?=
 =?utf-8?B?Smh3eEJmUERCa2xNMEhrYlVYVlF6b3ZoWUVqdDRBYzl3akU5bDFZYjlSUjVt?=
 =?utf-8?B?WlFTMWxlSzdueDV5blV4NHdMbk5URmZ2RTUwK2lmREQ1NFdNOFh4RXBPcW9p?=
 =?utf-8?B?M2V6TVZPZVhpcmY3dEFhZUdmMVQwTGE2MFF4ODJzeXBaQ0Rva21oUlNKRVMw?=
 =?utf-8?B?MmtlSTJwTVVJZFQrR1RUWkRtYW9wTXZQSWNlTXR2NTk5YlR6VzdjTW4zU0N1?=
 =?utf-8?B?WmQ1WkJtVUovWWJ4MFZZN3V0ZEtTcHBVdUM3MHY5R2JUMjVrQk16TmF5aXNU?=
 =?utf-8?B?OURrRXlGdUxPRFZLWkVLdVFWSTU4MEJEZVR3UkY2a2k3OGZCUC95Z0ZMU2hw?=
 =?utf-8?B?bm1mRVZLZVNUTkd3WWFQY2VRUXJSaDRqS0NNYm5kMGZOQVBMbGl6cFBxcWJk?=
 =?utf-8?B?VUt2L3V5QmxZWXlUVForR05Ub0h5dCsvazViZTF6YkZacFUvQnNEczh1RDQ4?=
 =?utf-8?B?TmhDRGYxNGYza0g3WVAxbkIya2VLZEw5TkJNNkZrTGo2K2tZaDhhU3Flbnh3?=
 =?utf-8?B?Rk10SDNjUnRaQ21iM1cwNkI3SkQwQTVhK2xXTm1SSThUaEJpK1MwbVlLUFFZ?=
 =?utf-8?B?Nm5wSG5WWit1YXZwblB2VkNHQXZTK1JSTDJSOTFOWlZ6NENvcG8wVGk2eXVM?=
 =?utf-8?B?SFZMNG5adWJ3TmJqM3FEMEZrRGs4NFVGMjlGb09aVy9SUitwa0dVdEEwbXdi?=
 =?utf-8?B?RmJGa2xHbS9PMFowZWRla3hpSFM3Rm9WL1BFdmcraisxMkx6djNZQUx3bitz?=
 =?utf-8?B?bmhJeW9WNnlES0RoS0lRUTllZHpzbzJYNlRPN2NLZ3U5eGMweU41ZTF5dW1r?=
 =?utf-8?B?TjIydjRjWnR0SDRuSkhYTnJrcm9CMjluaXA4OGtYekZJZmNabmE2cUxBZDdq?=
 =?utf-8?B?R05oOUI5T1dpeWdMWVYrWXcyTlFwRXBTNEUxWERQWktZb2tRbEJtcVNIcm5a?=
 =?utf-8?B?bEg4eFpDQktWcUtkZlVYcW5lN3NvZVU3SitvbWl2ZzRTNDlxTU1WN25Jd0RO?=
 =?utf-8?B?MFREVVQ0ODdIcmdjUlhlaEg1TVVudGpJM0J3akw4WjVWbFJVZlhzdERIRC9n?=
 =?utf-8?B?Zlk0eDVMcUZHdFRRMWI4TTVDOUtjejhoTWxlVGJVYmVtYWMrVVBnNUE3M2tO?=
 =?utf-8?B?Y1NnV29PejIyaDJJbVRaVTJsRDhzOXk2Wm8wRjgySlpFTUlPZ3k2WExVTzFP?=
 =?utf-8?B?bE5UT0dCbVF5K0x3UGdmYng0K3dBMnpzdTFTYisvU016NUVrZlZqb05sNXoz?=
 =?utf-8?B?VFk4U1U5ekhScm5EK1VvMG0vN2o0VEd3ZTZnMk5DM2xOM2N6aDZhMEQ2dWp1?=
 =?utf-8?B?Y2JEWlNJQnNBS3NJMTRVVnNtNlBBVlBWUStFSmNZdkovWkFmSllFbk1WS2JB?=
 =?utf-8?B?WEhqM0ZwNHd5dHhzMnpQNTl5RlQ2ektlUHN6K2Z3TWdnc1FyZWZuQk1acTRt?=
 =?utf-8?B?d0dyQjNhL3pMVXlLcE9JVU5jODVuSlBQc3I3NWFleVM0dmRSaDJvQzQ0eGJ3?=
 =?utf-8?B?bXZmUGdYckNLQzlacThicHdEMXhrUzlXdmtGbTQ2RDBybytHcXdpaE8yUGRG?=
 =?utf-8?B?U3IxcmdpNzNYVnNuS0Zkb0dmNUZQdG50M2ZOOGE5MUJQWXR1WGdOSnV6Tnpa?=
 =?utf-8?B?cmZsY01mNXJuU2xCdlVOai83SzhMbHliYk4wWWZzcE5MUWZ3ZWkya01YM3Qr?=
 =?utf-8?B?V1dBYThnYzRnY3B4MnhhcHM4WVdNRFV5MHNxWmxBdmxyM2c2UXFYSWFwanJY?=
 =?utf-8?B?eHZvZjg3UlJZQWpWN3JjZ2d1SFh4YjUxbXF0L2p3d3cvWDF4MVVsL1E5aWlT?=
 =?utf-8?B?cE5tZ1NwNnphV2Y4aW5jNjM1a2puQkczbWRqajRUbDV5aVFvdkpWQVc4dG4x?=
 =?utf-8?Q?uAuSsuYSxeazoaYpwWeMDOw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6075b31-e9ab-4b60-c454-08d999cbf365
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 04:32:29.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrzIRwhrRbuFIGGKelKQY7B5p2iEvkLmH7JC6K1IWc511Dmjc+Kabr5Zb6nQ/jkkRTyfNu9yTmuQA7F3Sq3t3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2852
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280021
X-Proofpoint-GUID: CePtHGhSxzCGpyP3p_u2zg8MTzpwSqI0
X-Proofpoint-ORIG-GUID: CePtHGhSxzCGpyP3p_u2zg8MTzpwSqI0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

   Ping?

Thanks, Anand


On 21/10/2021 18:56, Anand Jain wrote:
> 
> 
> On 21/10/2021 18:49, Anand Jain wrote:
>> btrfs_prepare_sprout() splices seed devices into its own struct 
>> fs_devices,
>> so that its parent function btrfs_init_new_device() can add the new 
>> sprout
>> device to fs_info->fs_devices.
>>
>> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
>> device_list_mutex. But they are holding it sequentially, thus creates a
>> small window to an opportunity to race. Close this opportunity and hold
>> device_list_mutex common to both btrfs_init_new_device() and
>> btrfs_prepare_sprout().
>>
>> This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
>> btrfs_setup_sprout(). This split is essential because device_list_mutex
>> shouldn't be held for allocs in btrfs_init_sprout() but must be held for
>> btrfs_setup_sprout(). So now a common device_list_mutex can be used
>> between btrfs_init_new_device() and btrfs_setup_sprout().
> 
> 
>> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
>> starting of the function to just above the line where we need this lock.
> Err.
> 
> David, Could you pls remove the above two lines in the changelog at the 
> time of merge? If you prefer, I can resend/reroll to v10. Whichever is 
> better.
> 
> Thanks, Anand
> 
> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v9:
>>   Moved back the lockdep_assert_held(&uuid_mutex) to the top of the func
>>     per Josef comment.
>>   Add Josef RB.
>>
>> v8:
>>   Change log update:
>>   s/btrfs_alloc_sprout/btrfs_init_sprout/g
>>   s/btrfs_splice_sprout/btrfs_setup_sprout/g
>>   No code change.
>>
>> v7:
>>   . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
>>   1/3 is merged and 2/3 is dropped.
>>   . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
>>   than just alloc and change return to btrfs_device *.
>>   . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
>>   than just the splice.
>>   . Add lockdep_assert_held(&uuid_mutex) and
>>   lockdep_assert_held(&fs_devices->device_list_mutex) in 
>> btrfs_setup_sprout().
>>
>> v6:
>>   Remove RFC.
>>   Split btrfs_prepare_sprout so that the allocation part can be outside
>>   of the device_list_mutex in the parent function 
>> btrfs_init_new_device().
>>
>>   fs/btrfs/volumes.c | 71 +++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 52 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 9eab8a741166..6aad62c9a0fb 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2422,21 +2422,15 @@ struct btrfs_device 
>> *btrfs_find_device_by_devspec(
>>       return device;
>>   }
>> -/*
>> - * does all the dirty work required for changing file system's UUID.
>> - */
>> -static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>> +static struct btrfs_fs_devices *btrfs_init_sprout(struct 
>> btrfs_fs_info *fs_info)
>>   {
>>       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>       struct btrfs_fs_devices *old_devices;
>>       struct btrfs_fs_devices *seed_devices;
>> -    struct btrfs_super_block *disk_super = fs_info->super_copy;
>> -    struct btrfs_device *device;
>> -    u64 super_flags;
>>       lockdep_assert_held(&uuid_mutex);
>>       if (!fs_devices->seeding)
>> -        return -EINVAL;
>> +        return ERR_PTR(-EINVAL);
>>       /*
>>        * Private copy of the seed devices, anchored at
>> @@ -2444,7 +2438,7 @@ static int btrfs_prepare_sprout(struct 
>> btrfs_fs_info *fs_info)
>>        */
>>       seed_devices = alloc_fs_devices(NULL, NULL);
>>       if (IS_ERR(seed_devices))
>> -        return PTR_ERR(seed_devices);
>> +        return seed_devices;
>>       /*
>>        * It's necessary to retain a copy of the original seed 
>> fs_devices in
>> @@ -2455,7 +2449,7 @@ static int btrfs_prepare_sprout(struct 
>> btrfs_fs_info *fs_info)
>>       old_devices = clone_fs_devices(fs_devices);
>>       if (IS_ERR(old_devices)) {
>>           kfree(seed_devices);
>> -        return PTR_ERR(old_devices);
>> +        return old_devices;
>>       }
>>       list_add(&old_devices->fs_list, &fs_uuids);
>> @@ -2466,7 +2460,41 @@ static int btrfs_prepare_sprout(struct 
>> btrfs_fs_info *fs_info)
>>       INIT_LIST_HEAD(&seed_devices->alloc_list);
>>       mutex_init(&seed_devices->device_list_mutex);
>> -    mutex_lock(&fs_devices->device_list_mutex);
>> +    return seed_devices;
>> +}
>> +
>> +/*
>> + * Splice seed devices into the sprout fs_devices.
>> + * Generate a new fsid for the sprouted readwrite btrfs.
>> + */
>> +static void btrfs_setup_sprout(struct btrfs_fs_info *fs_info,
>> +                   struct btrfs_fs_devices *seed_devices)
>> +{
>> +    struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>> +    struct btrfs_super_block *disk_super = fs_info->super_copy;
>> +    struct btrfs_device *device;
>> +    u64 super_flags;
>> +
>> +    /*
>> +     * We are updating the fsid, the thread leading to device_list_add()
>> +     * could race, so uuid_mutex is needed.
>> +     */
>> +    lockdep_assert_held(&uuid_mutex);
>> +
>> +    /*
>> +     * Below threads though they parse dev_list they are fine without
>> +     * device_list_mutex:
>> +     *   All device ops and balance - as we are in btrfs_exclop_start.
>> +     *   Various dev_list read parser - are using rcu.
>> +     *   btrfs_ioctl_fitrim() - is using rcu.
>> +     *
>> +     * For-read threads as below are using device_list_mutex:
>> +     *   Readonly scrub btrfs_scrub_dev()
>> +     *   Readonly scrub btrfs_scrub_progress()
>> +     *   btrfs_get_dev_stats()
>> +     */
>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
>> +
>>       list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>>                     synchronize_rcu);
>>       list_for_each_entry(device, &seed_devices->devices, dev_list)
>> @@ -2482,13 +2510,10 @@ static int btrfs_prepare_sprout(struct 
>> btrfs_fs_info *fs_info)
>>       generate_random_uuid(fs_devices->fsid);
>>       memcpy(fs_devices->metadata_uuid, fs_devices->fsid, 
>> BTRFS_FSID_SIZE);
>>       memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
>> -    mutex_unlock(&fs_devices->device_list_mutex);
>>       super_flags = btrfs_super_flags(disk_super) &
>>                 ~BTRFS_SUPER_FLAG_SEEDING;
>>       btrfs_set_super_flags(disk_super, super_flags);
>> -
>> -    return 0;
>>   }
>>   /*
>> @@ -2579,6 +2604,7 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>       struct super_block *sb = fs_info->sb;
>>       struct rcu_string *name;
>>       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>> +    struct btrfs_fs_devices *seed_devices;
>>       u64 orig_super_total_bytes;
>>       u64 orig_super_num_devices;
>>       int seeding_dev = 0;
>> @@ -2662,18 +2688,25 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>       if (seeding_dev) {
>>           btrfs_clear_sb_rdonly(sb);
>> -        ret = btrfs_prepare_sprout(fs_info);
>> -        if (ret) {
>> -            btrfs_abort_transaction(trans, ret);
>> +
>> +        /* GFP_KERNEL alloc should not be under device_list_mutex */
>> +        seed_devices = btrfs_init_sprout(fs_info);
>> +        if (IS_ERR(seed_devices)) {
>> +            btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));
>>               goto error_trans;
>>           }
>> +    }
>> +
>> +    mutex_lock(&fs_devices->device_list_mutex);
>> +    if (seeding_dev) {
>> +        btrfs_setup_sprout(fs_info, seed_devices);
>> +
>>           
>> btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
>>                           device);
>>       }
>>       device->fs_devices = fs_devices;
>> -    mutex_lock(&fs_devices->device_list_mutex);
>>       mutex_lock(&fs_info->chunk_mutex);
>>       list_add_rcu(&device->dev_list, &fs_devices->devices);
>>       list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
>> @@ -2735,7 +2768,7 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>           /*
>>            * fs_devices now represents the newly sprouted filesystem and
>> -         * its fsid has been changed by btrfs_prepare_sprout
>> +         * its fsid has been changed by btrfs_sprout_splice().
>>            */
>>           btrfs_sysfs_update_sprout_fsid(fs_devices);
>>       }
>>
