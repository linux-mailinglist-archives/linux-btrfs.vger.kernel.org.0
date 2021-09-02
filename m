Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8A3FF80F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 01:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbhIBXwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 19:52:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233282AbhIBXwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 19:52:32 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsGDt023065;
        Thu, 2 Sep 2021 23:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vSwX0vLQ1w5t3W9Kf2ak+69vOyUHOgNB/z+GikLXk/Q=;
 b=NuE2ntqqAKLSA/tHy71Uqn7t+5x12ZURsrlTewr0mOpk9++db3GpuokJ5cQiPjm3gadl
 jE5rHzuV4s9XvcWvk7naA+EXytZ8vwngIZcVfUWN6Ql/sPFCTle8FJD/DQz7bmkzEQPo
 POaWxJEGd2zxE2PtGwNDbPH29I45YBZ1znQK4Q5/hJLM9WL0i1bWAXREtcC5fjWbjP5r
 agDywrG87UlNyK9CyGHxbFpuJzCI9+Ciz17uL6RoDaY36yl2KciBK4LvGK+8kR4LLdse
 f4CrPAdTelfdYi0kYuj+LhH3HAxc98+Jhn1AL5uxv1B3VNHuNrt9Ki5HCv9EzCbwiRdf gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vSwX0vLQ1w5t3W9Kf2ak+69vOyUHOgNB/z+GikLXk/Q=;
 b=WBKMT7SD93vu1DGaqWT6UGPzT7EPhXpZiCtQejGpGwKURjpDhL2CvHgOeWudqdE8DaZ5
 FW5ZQdmbtlZkkmezZZfkZqhPqN00XWSeyQokr/VNezSbS3QW0cTIU6yt6/Qq79TaKWUM
 UMtxq/3dScMsBE305JO9r89yXVDySNRom6i+1Q2gfkxmSR7hmoninRWbVvuaS/o8/Ozi
 YIBn+x5KI1mSQ0RbtuzLOZruuZqjlQ/hY4cnai/YpNwgDwigfUAp/zn6rcKrDB4graS9
 QF1cdIlp7xkYxHR6nhzImM4PmYDJn7y09LepDHnOrJKyMiUY9Lu3zn2EVx2c8L1iBEV6 Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdvymmgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 23:51:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182Njxms115984;
        Thu, 2 Sep 2021 23:51:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3ate00pefm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 23:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLCRM2tNSafEQwGr8P4OWxUF2/bpqOD9XdDWzeRBTQ2iULxuAZ9TeNuDP55JQLsM5/iKOazW0JYQxKF1feFKvNNWqYmMpVAT8mvgozwpzDux+HLxWK5Qx24D8emAiNlLO13Dn+9WEGyHJXPuIesI953TWuhn59GhqGs4FLfXvuzi+cnEbRjn13Eaee/K38XYsXk2sMW0GCIv6fbxndMVy8sjoLeS34d3TbzjZwV/FIkctJmphRn8jVO5HHbCxGX05YNKoFkskZFdmEK5yC3egzP8StUWM1GQK3M2JR1CWOZCO+d2A+UbL3oJQyfBmIo8pxSDxEni9ybDstwwhxkTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vSwX0vLQ1w5t3W9Kf2ak+69vOyUHOgNB/z+GikLXk/Q=;
 b=N1lsUJEnu9fGBjubJaZEx4xVWPuMUcPcbSXDwOBMv0wHJKdmdTqbMdkUDhd87QjnTo8oWhqnaVPEbSwAVD/cwv9hRwBUuyEf2Eouv1rE+yacRVZo9BmR4WgyI2zuUzUyvgphqNZhLtxBQBF7yXHAT9nIymHBv3CtaX+swa5cwl+vXtmC2HYkPyeD236fbESQDtsn7y+8Nvx3MaYuAZslmjpzr0gucJu2uiwL6gBvhEaWrbnliYAGL0hBs7O4z6GD4PDh0Sm88Ro2IqikyQqtHCi7uumUV/pZ6xbU8WUZqV8UEKJFLPoYbJT1fWPCTiKkI/foi5bmz7uw8yqUGXJICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSwX0vLQ1w5t3W9Kf2ak+69vOyUHOgNB/z+GikLXk/Q=;
 b=dCU6LU6536gyCkocJQHF6yc050Vggh3z4Vjyk0zUZ0XLnTl8p60o8ZhTCKNWCT9Kz8LH998p+06/SeugTdud5ieB6dFVYeRMXq8jJzdCMrU2VS8aLqTUpvnMsmQGtdFWH434IHvekg0JQms2bcpvplAlYVZsXcYEK8hAulwgdeI=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2932.namprd10.prod.outlook.com (2603:10b6:208:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 23:51:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 23:51:19 +0000
Subject: Re: [PATCH V5 1/2] btrfs: fix lockdep warning while mounting sprout
 fs
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     l@damenly.su, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1630370459.git.anand.jain@oracle.com>
 <215cb0c88d2b84557f8ec27e3f03c1c188df2935.1630370459.git.anand.jain@oracle.com>
 <5c9c7e1e-7909-f9a7-6e4d-9265e1bd0d5b@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c71323a0-edb2-3994-babf-4ff8c3fac1e8@oracle.com>
Date:   Fri, 3 Sep 2021 07:51:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5c9c7e1e-7909-f9a7-6e4d-9265e1bd0d5b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0143.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 23:51:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c596d140-e8fc-4a19-b8a5-08d96e6c8f5b
X-MS-TrafficTypeDiagnostic: BL0PR10MB2932:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29329806F0EB7CBE1CDEDCC4E5CE9@BL0PR10MB2932.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pgunOauLtqPwPk6KjRgD9GyXh2l1WQeuZzd8+YgZJFGY+TZi39JSBgEPE+HEvcVfhUX/TvYXkkIQk/b3nZn7CW8DEGus1LNCAHhFqmpyqpuJ5qXF1TItweb7Riz4EZFWiyvOoQUhvF9hQjO9zdY/wve0f+826q2vEkdi7tPOE1XYcsWVQklajULeooy0mgW51pJ9YR97D8ulf1NcLRHZdJsqXg4YVWNsek2hW+aqHimfB3OKI5ClORIqyl6Qul3xHw6JSgY/r6/2SRUbfd3AKDWG1/bjWzEsdjiD4RB56GesC7sWOAypER+leUuZngQVnoNoy16upH1zi5iLDpTOZ61kF5F5j03UmVUfeRDmmKz+XqdH2yzKpdXy/iQFyy0ManJcnDdrKAP6MHkw6l3Hkq0BCPe9TtgkZSZAS/ehnAps8a1WriRt33S/vC2XDeqKDaF56lkGkL5mXIGHvrBRymb84tNgUFcEMn7YFLLhmu+ETZn+f+nrPqO5Uyag+5mDV8UrI61poF7Oocf9zJykZGVeVQS8fVNN59r4sy5W+aQJ39/5vpqjUMavR1/YLJar5TvSuchothpS5km/3fiTVeTZQe2cq7SBMm6GpzZ9uABaV9xb7EiE4TRGR584mx08jJ8ynfQOynGDx9/Fz3ZXC+X/PXAgr+HgFc7d+5IKzrDWE0wNd9NGooIPKEvyDZT3seuiZAxDVXjz0boTnKiJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(39860400002)(366004)(376002)(6666004)(36756003)(31686004)(26005)(6486002)(31696002)(83380400001)(86362001)(5660300002)(44832011)(66946007)(66556008)(4744005)(956004)(2616005)(66476007)(4326008)(316002)(16576012)(186003)(38100700002)(2906002)(8936002)(53546011)(6916009)(8676002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STMxWWNMU3VMYzZGQlpMcndGUlBaUlQ1dkIyczlFMWdRRkZ6NWRQSkNqbnVV?=
 =?utf-8?B?RnlFVFpTUFF3djBrb1lwVlZDS1JuRlVPMjI2ekIxUnhUT2RmVkZXYXRua0Y2?=
 =?utf-8?B?ekEvTlcxcWo0c0NzL0pzNmZCMGpQRWdVNzRuZEJzbm1BNDJxZ29zNFJtZzJt?=
 =?utf-8?B?NlNuaExzSitGK3pRR1RNalg1VEVhekFHekxBT0lGZHhydmU4NFA1Y2orZWo2?=
 =?utf-8?B?Yy9lVkF0ZVB0SGxUQTIrMEkxYkZSZGcyYUNYY3pUM2VhWlk5WkFsbTJOK05O?=
 =?utf-8?B?anF5eUJlejVLYmliV1l1TG83LzMxY094ay9TSUxSYWd4d1h0VUtWMHg4YjJp?=
 =?utf-8?B?V001Mk9SMzZhcnRidjRoa2RtQnJZUUhQTm1xUGU5UnJ6bE1IeGF5b0dORFBr?=
 =?utf-8?B?T2xOUENQSWZaYjZwOWpBWjZHTktaSmFoc1ZUS1RoaXpyOFczZ2pESEQxNVhy?=
 =?utf-8?B?N0pQSE84T0pMSTlXeVFPTWNlRFpBam9kckg3K2t0L3p4ZEM2QkFCa0tNLzhv?=
 =?utf-8?B?YW1KT2tCMWdsdEVBUWpXRC80SDN4eFdDdEhmWmZZaThvd2ZtWG9iNkpSUzJS?=
 =?utf-8?B?QnhXTUhjZXdBSVVaeXlkS0I3U2ZpSFlUcFltOXJmQm5XN3ZVQnJSd0hsNGg3?=
 =?utf-8?B?Q1hzY2JEdkVnL0gybHVDRmUzL2VTV1hXRktrY3NJdi9FR1J1YnBUR3ovZnJx?=
 =?utf-8?B?b3B6THJQRWlkaVJtSHl6a2tiMW9zaGNUemVMODR5dDJXWk1haWtMVkdtNzNR?=
 =?utf-8?B?YzdqeXEybXFRVzJpQlNaWWdvMUNuN1hkQW51VmZLazErRmhiTjM5RVVXMFVY?=
 =?utf-8?B?NTVqWkVSVzZEdFowN2x3MnNPaGFFWlJzbllvWm5VOUY3Nko2WnZpcld6bjRz?=
 =?utf-8?B?amR2WDN3ZUlmRXY2NzBqRnJqK0xxSytneDdOYm9XSGZxTGFocHM1M2ZkTzhz?=
 =?utf-8?B?OFplSWJ0dTlsMUlja3BKYkJTdEZXUmNMVmQ1VGZIQTkwN2l4T2VGeXUrMVRp?=
 =?utf-8?B?M2lKV0J5dlV1L0NVUDRHOGltelZ5TXBYc1RMazFsNHB2R1NFbVYvN2oxZFEx?=
 =?utf-8?B?NWwzS1BINkk0SUxNWWxoYTErVGtERmFPSENlOS92NWJsSndhZExWZVlJbEZr?=
 =?utf-8?B?Z2NkR3Z0TW5vVFZmSUFDQnJ2QndzejMzdCsrYWVjZVk1b0pwbnM3N1hvY1g5?=
 =?utf-8?B?Y2J0MFd6andoZTU5TG1PcjIzL3MycVdiMUtEYzdlcGNXZ0ViMnQ5L1VZMm50?=
 =?utf-8?B?SktKTDlVUExHM1Q0ZHF0MnhNbGtRcnladjhUS0hSRkhwMXFhWkVNenFqV3Nn?=
 =?utf-8?B?aEZJcmhueFBNcEdvN2ZVd0JhTEJNOVZHQ2ZRaFBPNDZyQ2lWUFVWWVZ2YVZq?=
 =?utf-8?B?bWlibkJOMlBVSEdMWTZBNlFscitWL0lTOWdYN1l0ZURiOVQ3NVJkNEh4SDBV?=
 =?utf-8?B?cFlTN1plN0hQZlFRRDhGRFhrVHVLbGo5Yy9QcE84Vzk3QVV2b3c4RERtN0JI?=
 =?utf-8?B?WEtjSmJBTitoaVY4SSs3a2YwdHhFM3JmbkI0d01LazVlZTF5RXNPZysrSTNU?=
 =?utf-8?B?L0xIcmV6T0ZVUWZWVittYlVwZVJBU3hzR2hXd0RwQzdtaUk1dFpMaGFsWWlB?=
 =?utf-8?B?a2lvcUpub2x0cTNsOE5lVm9LeXFZalZJRnhDUXJQMktJb090VlI0Y05LYXJv?=
 =?utf-8?B?S2lBU1VJWDMzUnZmc044ek04UXkvVkRzbURyZ3RDdzVFN3RzVitaMnQ3YkY1?=
 =?utf-8?Q?2/8fcolZ/pKYA0YniT6r+ucBMMT3LrtWnAGc6Xn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c596d140-e8fc-4a19-b8a5-08d96e6c8f5b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 23:51:19.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC0eW6pvr+0y4CgPHnAoV0ESJD6gWnZkmhQabQKOD/FAYQkqNkTJbJp5CkG3paNLcmOX4vavfAsT7AzrldHl0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2932
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020137
X-Proofpoint-GUID: __1QOC7DXM8fH6iKuXWoJJovPOEazMMC
X-Proofpoint-ORIG-GUID: __1QOC7DXM8fH6iKuXWoJJovPOEazMMC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/08/2021 16:18, Nikolay Borisov wrote:
> 
> 
> On 31.08.21 г. 4:21, Anand Jain wrote:
>> Following test case reproduces lockdep warning.
>>
>>   Test case:
>>
>>   $ mkfs.btrfs -f <dev1>
>>   $ btrfstune -S 1 <dev1>
>>   $ mount <dev1> <mnt>
>>   $ btrfs device add <dev2> <mnt> -f
>>   $ umount <mnt>
>>   $ mount <dev2> <mnt>
>>   $ umount <mnt>
>>
>> The warning claims a possible ABBA deadlock between the threads initiated by
>> [#1] btrfs device add and [#0] the mount.
>>
> 
> Send this as an xfstest

The above steps are the most common in the seed group of test cases.
The first test case (btrfs/161) in the -g seed group already reproduces
the lock dep warning.

Any idea how do I reset the lockdep warning (without reboot) so that it
will again report the same lockdep warning stack if it discovers again?


Thanks, Anand


> 
> <snip>
> 


