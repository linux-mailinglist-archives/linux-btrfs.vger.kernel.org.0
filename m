Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352EF44AB39
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhKIKMW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 05:12:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36434 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239091AbhKIKMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 05:12:21 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A99t6qo015326;
        Tue, 9 Nov 2021 10:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gX/7RBUHafTa998MBxMKys+Qf785fMJHsM8jWTmh2lc=;
 b=alRQZGEE6tzVLjk9+3/Qhoq1jzj28J6IZHBn2GeA3YoaivseF060xo1r3JLqVkXDIV5C
 DjmB9AKHWA1sIZMV6GDbWXoMJtUid7EG/CwdfHi81lHVrRcWSZHfuL9eYCguT4Ysmm3H
 vm7LO6YSvwz4xEWSVhk7T2N+CKerdL3VzeIMTuCHyTEQM9H3Gyx2JZKxrC/qbQYhNVcq
 FJegKHDcrr8KmIrtbjbOOUhLpTxlHuwjIlUdHYsM2P16wLEH9O1ghKPgPdEox4qoLEM3
 v5F3LaEDjMCrsnqhF/CM4xcw4hVnDrOia3dtrQ77XnQC4CBq4r8lDObvKN2QCSIFO8Cl Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6usnht0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 10:09:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9A5NK9035160;
        Tue, 9 Nov 2021 10:09:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by userp3030.oracle.com with ESMTP id 3c5etvde75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 10:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfL2Bn/pr9ae6H7eM3Uxr2o9hODCUiXcQbe0HnurqcDEHWWccvNTOqCU3A1slYYqzTa1L9g8uqSuZm75MCDGbxmIispbkMBgASNbP3zW40bRfFdqf2IU0cxFUcbVOvCCYZDbZQH4A1DCtf7eQlwRKv2blzQ5T/HKIrCwYaZhao2/XYSLTV3dSt6F92rz1yyYYQFI3OaH1a6Vx+QSDC00szUgmHNYTXpWIvoDSQ+PHtDfuNUoo2JaXuoj2xpWXAm8uRelwlBjjFgK22nd4tz4y+M2IQ4/dxSYommSESthpm893/n5u/Hqx8nfT4OTp/qg9a6dvhgR3yLiHaUaWcFE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX/7RBUHafTa998MBxMKys+Qf785fMJHsM8jWTmh2lc=;
 b=OGJJLvcMSyljewEFzI7lpRM7dg9URt9iVYPps86l05kSCuEikB6FLOchNxtrwbcWWGy9LEbjLG90JAZHKz8mQiBiUIwZeXUiqm5eRKaQykTfn7NHYeko2xgIb5/uRF2gi/XDCCp5BCau3Dw12bMTAhiegMnUHEI/R9OZwwfrKIPrXMWRdR62Xzscm5ujMX0hY+JNP/fJ5bz3vnEey8BP0A8H+NjfycBZQ2T3mr1kFRvPu45hzFSdM/mkLhNgJktb4HY0CaC6hveeFganpLp+K3qNYvpIsxMyLdB//9hMBbKoaZRVqP1rUpPRGgtnbAjfi2ofEm9pMgj/bTr15JownA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX/7RBUHafTa998MBxMKys+Qf785fMJHsM8jWTmh2lc=;
 b=GCetU7tNWoevRSESU92a80mG6xxfzFj3GbGLRF4alfV4VrdN6OcTpbKBrT+abHu/tQjUOhRJ14Vxe4cqEk2evsyvb0S/4KorJ0VblbaJTSZa627AdzAIF+vGV/eq2Dody41FWmoMk/j0UOe9KH4iuL47m3d2AKyHz8KFI2k1f74=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3918.namprd10.prod.outlook.com (2603:10b6:208:1bd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 10:09:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 10:09:25 +0000
Subject: Re: [PATCH v2 0/2] provide fsid in sysfs devinfo
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <be907432-4279-7226-b79e-192d633cf3ac@oracle.com>
Date:   Tue, 9 Nov 2021 18:09:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <cover.1634829757.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 10:09:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e22a393a-fd02-4aff-d1b9-08d9a36901c2
X-MS-TrafficTypeDiagnostic: MN2PR10MB3918:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3918A6848BF5B1779318A4C0E5929@MN2PR10MB3918.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7DWZ/mEwL4/BYAqNSEC5KKbp9+NYw5a10W547vN/4e847fUZzegmx9kCgHLC+vSRv5cx6GjttLI1G3MRXZO4AQSVfIRSaaX4mA0a5xvXXD/eFHjNL3ul1pHY7nz5h722JbN7RXLWIZooc1XEkPs/dRvpskiLBh/SP4GZC4BaYO5eMgjjd72tSINAw+8JYpSMlFChc36ByeH1Q2rNHoSPfNh1K2XuVzx1GhKP1NBv15nMLP/sAUID8eNAUEkpxCc3SjLt3kn/OF3yd/g809kZLZQNEHqUJzxVtNEUj0o+DZ5gOtzrq6oEeoHJgulolY50aNisaoeIJBkJG4UIHAJlbWrdAZlOGNlYEKIg4ODu2t1CvcaPYnP4Xn5U6B44nJSfETQ/tHBdfwyQprYzURBFWJe8KBRvSeRCwumQNrNHL0kLZViYvPPufyvR1OhJK1/OT/vV3O2cROcK7UhbwkU58254KMuk0sN6coUXYUx7Le8bn014+AgBqYTQW3OmIeuFNpq+FS0LSnSTV/7kLHwttWjfihR1NALE+gEYfveDgCwU91MAz5UxJu1IyZjwQRv8hGm1HuopKuiE+0WgEiPteMG0qkpEKHb9/7EE1U/Vr79qw8ZyRDHLvWz1XPHC63Kz7a8Q3iHIsgtIT0Dj8XdqzOCzfuA2PzQPENIjMsbAwrux/a1+eR+dgpmr5ljkLjvF6odbbC4dRvDQNTGymk9Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(53546011)(5660300002)(36756003)(83380400001)(31686004)(2616005)(316002)(6666004)(44832011)(38100700002)(8676002)(16576012)(4326008)(8936002)(6486002)(2906002)(66556008)(508600001)(66476007)(66946007)(6916009)(186003)(31696002)(956004)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTdzSFhzM1cxMi9vSFZMSS9EWSt5VHUzUkZFYlBZSVlvbmpwRDM2RFdPRHpR?=
 =?utf-8?B?UE9iSGFkdjhzK1pEa3dyaE5iU3l3bGVjQzFac1BxWnJKZkJwYitNS1ZUWUZq?=
 =?utf-8?B?L3gvZGVZUWNUWDRFdTVkeG9kVysrQlNSZ2tjS0RDa0pVMFlSSUQ1bVhPOFlm?=
 =?utf-8?B?dS9SOUJXZWZrQTRKREliRFpFU1lEck1pbHBvb0tOcVo0em5zalk5NyttWjZZ?=
 =?utf-8?B?VUVvWGpTZi9RZ3AwQ2xieTNLZm9hTnU2MFZnZmpRamdvalBkMy94c1JBc3Q4?=
 =?utf-8?B?VTRobDVBRGtmUS93a0IwaTBncHlhaDAvMTVYaVU4MlRRSVJQT2Zwb3hPYmp5?=
 =?utf-8?B?TndPenJjZmlkVE9WbmdMUm8xamlyNzBDaCtxM255Sjg1WmVaejNxVlZRMjJj?=
 =?utf-8?B?VEwvanZvZjJudnVWNE03RmFsUGFQNDNMOWRCNmxmSGpUZWhlaXcycG8zWW1o?=
 =?utf-8?B?OFR0ek95WlF0cUJoRVJNQy8wYXg3TXdNeTBoWHl6cEpGcXltc3ZhSFNmSURG?=
 =?utf-8?B?bFF5M2tIcUxqTnZMa3k4c21uZFFjY0FRRUNpV1VMR00zaVFNVmpYVlF2VHJ0?=
 =?utf-8?B?WjQ3TVQ4RFYxNC9lSXRHak84NmtBaVY2ckIzaEFnTFIxdTFVUjM0WjV4YzBa?=
 =?utf-8?B?am0vZVZVSmJzdFpUY2JtRGdHVnJsWnVqTmp2VFJua1YwNGZORFg2MmZYd2k3?=
 =?utf-8?B?RDJvL08xZVlJZGxMWVRQTytjNzh2cGdtWUlhRVRRMjEyZlhackZOTFdmb1VC?=
 =?utf-8?B?am5YY0ZsTGdLdzN0eXpWdkhPUEpuMGpVR25oUGx2Wm9FVWRLY3AxbkxJR3ZU?=
 =?utf-8?B?TDM5c2JZZkZGRHFhYzhnS2hsVDliVWp1SUQ5UFpnd2FlOW1ucTRYbmhPM3p3?=
 =?utf-8?B?SW1Yd1d5RWpjOXI2QVFNdGpDU2tmbEw5eEZRcG9JRy9vVFZJMVVROHdzSnJI?=
 =?utf-8?B?aTBlYlM2UXptRG9wTDVhM2dnc0lhcXNOYVZpaVAvOEFjNlQwVWk0RTNRbmhl?=
 =?utf-8?B?WFRNOGhsb0RCbHFqT3J3b2c0dU5HQXNSdE9Calo5U2VvMHQxdC9keXZQcTF3?=
 =?utf-8?B?K1FLQkNjLzhPZHBzdnpMWUVPWGs4dDBJb0IwOUJRSUFXZEgySXBXZlhmZElM?=
 =?utf-8?B?bWR0aUJNTU9NNXlSUUhEVlQySVVabkRoTU54YmtuR1FnQVRqOEQ5ckREWTgr?=
 =?utf-8?B?ZU1lYlNVK1dORFdWUTJPallsTFlvMkVrVWwrNFMxQ3hEZEd3WU5ubnd5SUlx?=
 =?utf-8?B?MnNFTHdjZGg3U1huTEoxd0JMOG5SekxnOE9RWERkK1lqR1JUVFJ2YTJNL0s2?=
 =?utf-8?B?TEcyakJqa2FEWFNRREJCZUkyR1M1S2MyRTRlMlhFVU0rclBUYzNGQ3gvVFFL?=
 =?utf-8?B?WjQzTzQ2dXJzMlZrYUF1WXlpY2ZsOEs5UW11enkyR2FML1NrU2pxUHZVU2ox?=
 =?utf-8?B?TTZHQzQ2bXBCLzVQMVJGeDJlR3ppTFpEMzUzaUE1bUdCQ3hteXVCVE5mQVFQ?=
 =?utf-8?B?SFZTUE5PdUUxeFRHR1prSDhIUDVsRzN2ZFRoTTVVTWFtT3VRejJjdWszaGRx?=
 =?utf-8?B?Vjg4a3RvNE55SjdqcGhtbWl1RFVKd3JaZ05BMUNGOUp2KzNjOGk0bTc1WTk3?=
 =?utf-8?B?R2xZbktuYWwrVVFOTTBkMFhPL0VEWklHcUVjM0JhNVVXVllVaXlWaEIrL1Bx?=
 =?utf-8?B?cGx3cTJBUDk3L0tBOEtmVEtuRStVMGt6WVplVWpoaGU2WERQZEsxazBSM05H?=
 =?utf-8?B?N3lBdkZ1VWo3OFJtSUE4cHplRVdGK0o2c2c3b2JIeUlEWmFaVVp6Z0dnVEFV?=
 =?utf-8?B?bjNRK2pDOUFhZk9vWURrd1c5bWVzaDJPR3U4c0pHeFhrbzZpUE5WdXZLSTNI?=
 =?utf-8?B?aTNzb3Fkb01veVZpL2k1bUlGWGIvYmhzMUdKZmJGb3c4cjc3Z1hvcnBRSDdv?=
 =?utf-8?B?dEZTSHVvNGt1RFcyd09TMURraXJrWjBRd2xieE5YRTNOeG1vamZseHpNN2RB?=
 =?utf-8?B?TlRWVEluSDdCSzFxZmkxT3FoNktWUnNHUnpGeC8rNXdrb21YNVpOYmVNaUt5?=
 =?utf-8?B?ZXU2VmsrUzFnVksrR3dBTHVGQ2lHMDcyWERQMjhxYlEzOE5XODMxdVpsLzJ2?=
 =?utf-8?B?VlROUS96Njk4aHNhdEVwdVNub3ZXVFNFZUdKSUJNQmVXWkczZC8ybEEyLzJM?=
 =?utf-8?Q?WjDkwyCjmBbV+Q5TnDL+wog=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a393a-fd02-4aff-d1b9-08d9a36901c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 10:09:24.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Z9YlphWSltWhmjBvTUfFyOqddBH7iSmh/rAD+f4lplzqi55jhf7Ox0horB9TMgmSwml3sAoR+XMmkU947pvXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3918
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090061
X-Proofpoint-ORIG-GUID: WB_zkrN25DR9jzTRVmsAUnOn01NCkQYp
X-Proofpoint-GUID: WB_zkrN25DR9jzTRVmsAUnOn01NCkQYp
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  And this one could also merge?

Thanks, Anand


On 21/10/21 11:31 pm, Anand Jain wrote:
> v2:
> Fix sysfs_emit conversion at the two non-sysfs show functions in patch1.
> 
> btrfs-progs tries to read the fsid from the super-block for a missing
> device and, it fails. It needs to find out if the device is a seed
> device. It does it by comparing the device's fsid with the fsid of the
> mounted filesystem. To help this scenario introduce a new sysfs file to
> read the fsid from the kernel.
>       /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid
> 
> Patch 1 is a cleanup converts scnprtin()f and snprintf() to sysfs_emit()
> Patch 2 introduces the new sysfs interface as above
> 
> The other implementation choice is to add another parameter to the
> struct btrfs_ioctl_dev_info_args and use BTRFS_IOC_DEV_INFO ioctl. But
> then backward kernel compatibility with the newer btrfs-progs is more
> complicated. If needed, we can add that too.
> 
> Related btrfs-progs patches:
>    btrfs-progs: prepare helper device_is_seed
>    btrfs-progs: read fsid from the sysfs in device_is_seed
> 
> Anand Jain (2):
>    btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
>    btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> 
>   fs/btrfs/sysfs.c | 106 +++++++++++++++++++++++++----------------------
>   1 file changed, 57 insertions(+), 49 deletions(-)
> 
