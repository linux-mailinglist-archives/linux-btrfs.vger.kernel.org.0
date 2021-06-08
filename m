Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511C039F2B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFHJrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 05:47:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHJrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 05:47:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1589jAbI165047;
        Tue, 8 Jun 2021 09:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z5wlZgW7yNW2ABjUpo4at6qGYwWXH61TOhhb/Dm1Ytw=;
 b=poIatnKBdNVAhT1cglrya4iPrXXO1FE/wYwuOlfcpBSWQI1QzdYdYSjZXAMHoUgJPQqk
 EFS93pyWEUph+fjOM/UM44UsK8gvtXjkT9DuhQCba/99Miq1w19Q1LXeIDGf6O288ss1
 gCuAagw0WPD+zwsx2ScYC0pMeQQY6/2s/Jm14ce02g4AIEvIAOHAiQP699CMqFf5s/Lw
 HBvcB3ktgpydVJl4EICYp/RubygeO8oK0f+7Ji+e/UnKEyaEbaFwjnlrYCs89J7eHhOP
 AQa2apd4tdIXwHfmgY1cbYBvLzur/Ktx4gOug7yh+fsdHkaXzRLwBV2fw3pNQxyGl4EK dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3900ps5ghc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 09:45:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1589eae2123524;
        Tue, 8 Jun 2021 09:45:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3922wrg6kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 09:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBaMdMXgnt9z33CYDuDnhwikDfO6XGEN/Q+0OoSqEIJoxu3gH5V3ytN/Flz/VrT0ui9EbhG0ksBlYtMK9LCbRkBzhMvBr5kQx/z3ZbwTq8c8Z8XvTZLF1eHyOLFpAn8wjNoWvYOK2Z/EwUDQ/PnzMWyy2Ormgw1uMBlO8MTNaI60u5GQbGURgH7CKWKVNzQFIydtHmfeGQFVp/m7uFLtR7dwbYR7LXXBA+PV58a26Nebur33uc64+k0l4Pc67LIhWnK9KZ5ZZPRMD2tIZYhV6wkaMBaNlnAqpqVevrd459cV6oB35FT+ogtnmnjlGCWPUG17mXy+0jC5JV31ftAfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5wlZgW7yNW2ABjUpo4at6qGYwWXH61TOhhb/Dm1Ytw=;
 b=GpPxkH5jv8YTFggjXP7ic/NpmUIsYWAGoipKvAHjuWMZIx5bjfdfSvfc0uJ8S3D8CLrZBL2DIpjmhMNERWoCj0leWxO+9NDCiuO8EMEBITV4HxSjF7WifQr/A76MNT29a7f4w8mY/X37p3GZm8lxuKpMyWUI9Ua6jOscnUqOybpdjWvIyZ/OebgGv5IIxTCgd/XGUrWtNWnim5W8W19qnyQ8iJVcCiM93i4q88K52f6ia765ZbfkBSDdRekVdxEGfTWCGr5T8v5Dir2kwtdZouzT9K78h31xgTvNae6Yh+RqA1Bdgsmp24oay1w36wFxVNig51I9+F/S5gnjX5nndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5wlZgW7yNW2ABjUpo4at6qGYwWXH61TOhhb/Dm1Ytw=;
 b=R5njj/gEQXRe4IpELLQVXAZSCFom1XWJ/hOx/IDvasN11Z0drKIKfrXE5/bcA/s9fA0q6ExUKsh1nQT7uFiCPMgDeA+luWTrBvuaXJPBEKY9OVZaxCpTfcQF+8DqT1vacEJ2rPyk4LfK8vSntzElC2miO+ajDNzP8d+NftlEUWM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 09:45:14 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 09:45:14 +0000
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
 <a1a2aebb-759d-35a2-ade0-3a0119346166@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b1eed283-af02-8052-40f4-b671ee17ac6f@oracle.com>
Date:   Tue, 8 Jun 2021 17:45:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <a1a2aebb-759d-35a2-ade0-3a0119346166@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0099.apcprd06.prod.outlook.com
 (2603:1096:3:14::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0099.apcprd06.prod.outlook.com (2603:1096:3:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 09:45:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986beecf-3d0b-4152-c1fd-08d92a621d49
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4929BB79A6D05A94A178AB2FE5379@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uot4J4N7AzE1/axflM7B9lahWNXXNWp8SJq5rZqjqAJ4WINQD7ARUsUwB9J899vo79oyJYDPB0bhGpTXmHXDz3juRma4iK2qhQfE1/Tgsu5j7MOmUe+P6xS0v+4Rb34ZfhyuqJg4RXczqIxMEzDlzsdhiRQ0USlPUFo67goQHBNcnlLTw+m9Ix5AP2+70jKlhbCk3HiX+97X49heaiS5f0tx2ai72taPKJxg8YbMzXWcpttmdYKMTDbSlOkr3SQOfjyofbkyxOqVKHyLvzMbNtWuW3aDdrHmFRyacdB80RvT7nQgbYiPAaYTzaJNdpYjIgMtQq8ZfPo4nqWA6eZocHG3f/6+xnMLZNhUrSqNKOpTQUGV+WW+oiHmGD2dYyr+Ax0gZU2x2JaGXhLy09+e51D9fpUDIUn2BhqnYm9h/QYelKdMBWyCJt66ONARgQACo7QXfHdDnjzhoCx4M5M9ivQTkYUhbfXedMWt7brYwsyu5qPhaznHmrUWvh9lVIse2FA3S4qDmNF7ASFM9kek+vyxYZeFO+qUc6XsWVd42ncmd4iQqFmIda7yXppEmoO6WeK/PfRMciAa2uqU4hTnaPP69qSBFjyFj4iqCPFXMNdcnKdcF88pVoCfAm463nj6Rp9Z5F32XhdHnVUDs+HhHzTYUXa3iyfcqcCfCEq/kMHHn6Z+ri0fN11A6g/DnEn6T29s4Q0T+slcgFgKbY1mPhHwI0iw/8Sf2DLBqRaqN7LDoIWIxRH9u7NRIjkQDbdFgNDHo3YK/L40J4Fwsq3e5oAQWpXUfbaxjqGZYFkYgxgrtm2pHadAzbwcb3ecT+loIbtfZ6AaQPNmlQS97GLgJPF0qG/PpzA3Vq/G+9uUW0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(31696002)(2616005)(956004)(44832011)(86362001)(186003)(38100700002)(16526019)(6666004)(16576012)(316002)(8936002)(8676002)(31686004)(478600001)(966005)(36756003)(2906002)(53546011)(5660300002)(66946007)(26005)(83380400001)(6486002)(66476007)(110136005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEp3T2Jmd1p5aEc5bWhUUXdGVTdCRXBjL1h2SDBZM2JLQ1dmZEJrd3FzSERE?=
 =?utf-8?B?c0hOREp6ODNSWTdtZy80NENFeEM4RGJwcFkrR3F0c1BNYzhpOVgycEdQZWY3?=
 =?utf-8?B?cWJ5QU52M214a2JnUmJQTUNjRGQ3M1VvbzZjQUhZWG1qK2I4WEc4TXp5V0pW?=
 =?utf-8?B?M2pRRnJDWkdZSTI3WDdyNkdwOUQycnZoeTNZK0l6ZG81TGRPREkzNXlHTGVi?=
 =?utf-8?B?SWx1Y0pyUFEzYjRCMDdJVjQzc1pJbEQwWVY4MmFyKzJxcUdiTU1TODJhZC9X?=
 =?utf-8?B?enFWeDJ6anFLaWpIWXJrUkx1VEQwQi9NY2FLSHUwQTJoUXB3RXZqbFNSZGpD?=
 =?utf-8?B?OW9XWDBmakZQMGRnSGYyMG5zenJlNkNRcmVnT1ptV1RQQkUxMk1WcWJCVmdz?=
 =?utf-8?B?M25RcStPZXU1TTRYRUx6N1RSVU92bDcwYTEwWkQvQXNuYmt2MGdUclpCYmp1?=
 =?utf-8?B?dWhSV2tYcWdYZGM2SU1jaGNKbFh2Mkl0YXZFUUZLbFFSVTdwOGNpMVRSTVI3?=
 =?utf-8?B?YWRlTG9abEI4cjVXV1VKZDRHejVzcmFXSkJwcGN0MFJqOEJJdUIwRVU5VENI?=
 =?utf-8?B?WFUrdEtvcTVKa0dyMUprWVdxckFMb2VWalhGcjZtOFhKNm9SQmtGbndPc3p6?=
 =?utf-8?B?MlhNU1ZqSGE3SU82MFVYOGsrMlQwRWZZbmRwZjRySzVvQW5lc3Y2R2p3RDlt?=
 =?utf-8?B?QTM3R2JZaVNwb3kvMzJkNjV0WVZlSmE4MjVoenpmclJtOU9RTnBlSHFNdVpZ?=
 =?utf-8?B?cWlGa1UvWmhoejh2dk9TVS9lczV4WE81STVtRGdFVXB0SjRSQ1REZ2hmZEta?=
 =?utf-8?B?T3lSRjZPcmU1NFdtSXFoK0VHbnBGRk13WmJNb2ZwUEdqZk01OVg3NWxsRmpC?=
 =?utf-8?B?RWN0TmZialRlS3lSMTAzWlArWTFsandFZ0UxZ3VSb1FRa3BFZEdEaHZLbmdN?=
 =?utf-8?B?cUk2aUU0Ri9JMGRqeFNnSzVTNjg0ZFRRelJaN2hxOVppNFN5eDRtUTM4b0pF?=
 =?utf-8?B?MDFoVEQxOVNwWDQwcFJoVWJDKzBOeU1hRHI4T2tialhCaEIvZG1HTEFtUE9m?=
 =?utf-8?B?ajNONVFHVllFYXFqOHhsYjB3TUdnWEozbTBMVW1jOXlCUUY0RklGOExSSlJi?=
 =?utf-8?B?a3Y5d0tzMGZKQmJGQU8rb1IxT1lOMkJEQWUraFRQTmVIOGJweXBsS2UyZ0Z2?=
 =?utf-8?B?OEhaYXVrblNzdTVoUFBhUnRqZkJrNVNjTmI4Rm55R0xNakgzaW96U3R6eHpx?=
 =?utf-8?B?SGxOdnpWdW1HN3piTGI3MXdaV3ljQ2pmRWpITlAwanlUVGlDMkpqSDRpT0lN?=
 =?utf-8?B?anI3eWsxOEEzbW4weXVjQ0dnbFRPKzdxMmVWa1l4RjVyMUM2Q3ZZQ2xBYmNt?=
 =?utf-8?B?ZDFMcTdJOG1OTHdZamxXVzJrWmZ3MVBCaU13WUppMkZoY1hqVlNKYWdDWmo1?=
 =?utf-8?B?aDMrZTRZcm1aNk83WjZoTHcyU0xrM3dQc3FMR1F0dXVabndoYmRKd0FseGNh?=
 =?utf-8?B?eGFuQzk2eGVSamw0blJMa25Rb040ZHFOZHBuQzZXREJvRzBnV1pIeFpyRWdN?=
 =?utf-8?B?cml2U3haK0VqamFsMFhOaWtaSDJPeEtQak80NW9sbjJzam90RkVORFRzUGw1?=
 =?utf-8?B?Q3Vkd1ZPZnluYlk1WjVTTyt5YmxKMHFQMStqZW50QTI5OTMvY0NyN3dPdVNt?=
 =?utf-8?B?Z0w4ZjZUVmxHREc3M1JKdE5pRzZIK2g4SldTWTdEZ2doMlZUMzcwc2sxU1ZG?=
 =?utf-8?Q?IYHbCLaiMqTI1kqDANtBRI9jALIBq6nUFF0FLEs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986beecf-3d0b-4152-c1fd-08d92a621d49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 09:45:13.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jhvp8MQMlDZN47BbVR2OPVkTJdVeAdqzV3YcO8VAEKa4mNt7CdafUbTqS98yTbkn26KYVFF1uA3WLz9TCzRCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080064
X-Proofpoint-GUID: 9nhWLnDHGKn6wN7wcraoL8wpmfrhIYBb
X-Proofpoint-ORIG-GUID: 9nhWLnDHGKn6wN7wcraoL8wpmfrhIYBb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080064
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/6/21 5:02 pm, Qu Wenruo wrote:
> 
> 
> On 2021/6/8 下午4:23, Anand Jain wrote:
>> On 31/5/21 4:50 pm, Qu Wenruo wrote:
>>> This huge patchset can be fetched from github:
>>> https://github.com/adam900710/linux/tree/subpage
>>>
>>> === Current stage ===
>>> The tests on x86 pass without new failure, and generic test group on
>>> arm64 with 64K page size passes except known failure and defrag group.
>>>
>>> For btrfs test group, all pass except compression/raid56/defrag.
>>>
>>> For anyone who is interested in testing, please apply this patch for
>>> btrfs-progs before testing.
>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/ 
>>>
>>>
>>> Or there will be too many false alerts.
>>>
>>> === Limitation ===
>>> There are several limitations introduced just for subpage:
>>> - No compressed write support
>>>    Read is no problem, but compression write path has more things 
>>> left to
>>>    be modified.
>>>    Thus for current patchset, no matter what inode attribute or mount
>>>    option is, no new compressed extent can be created for subpage case.
>>>
>>> - No inline extent will be created
>>>    This is mostly due to the fact that filemap_fdatawrite_range() will
>>>    trigger more write than the range specified.
>>>    In fallocate calls, this behavior can make us to writeback which can
>>>    be inlined, before we enlarge the isize, causing inline extent being
>>>    created along with regular extents.
>>>
>>> - No support for RAID56
>>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>>    Considering it's already considered unsafe due to its write-hole
>>>    problem, disabling RAID56 for subpage looks sane to me.
>>>
>>> - No defrag support for subpage
>>>    The support for subpage defrag has already an initial version
>>>    submitted to the mail list.
>>>    Thus the correct support won't be included in this patchset.
>>>
>>
>> I am confused about what supports as of now?
> 
>  From my latest subpage branch, everything work as expected.
> 
> Defrag support is in another patchset, which can be applied independently.
> 
>>   /sys/fs/btrfs/features/supported_sectorsizes
> 
> [adam@arm-btrfs linux]$ uname -a
> Linux arm-btrfs 5.13.0-rc2-custom+ #5 SMP Tue Jun 1 16:11:41 CST 2021
> aarch64 GNU/Linux
> [adam@arm-btrfs linux]$ getconf PAGESIZE
> 65536
> [adam@arm-btrfs linux]$ cat /sys/fs/btrfs/features/supported_sectorsizes
> 4096 65536
> 
> It still shows 4k as support sectorsize.
> 
> What's your branch/HEAD? And are you using 64K page size?
> 

  I am on misc-next (which contains all these 30 patches). I don't see 
subpages supported. Is there any patch I missed?

  $ cat /sys/fs/btrfs/features/supported_sectorsizes
65536

Thanks, Anand

> Thanks,
> Qu
> 
>> list just the pagesize.
>>
>> Thanks, Anand
>>
>>
>>> === Patchset structure ===
>>>
>>> Patch 01~19:    Make data write path to be subpage compatible
>>> Patch 20~21:    Make data relocation path to be subpage compatible
>>> Patch 22~29:    Various fixes for subpage corner cases
>>> Patch 30:    Enable subpage data write
>>>
>>> === Changelog ===
>>> v2:
>>> - Rebased to latest misc-next
>>>    Now metadata write patches are removed from the series, as they are
>>>    already merged into misc-next.
>>>
>>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>>
>>> - Use separate endio functions to subpage metadata write path
>>>
>>> - Re-order the patches, to make refactors at the top of the series
>>>    One refactor, the submit_extent_page() one, should benefit 4K page
>>>    size more than 64K page size, thus it's worthy to be merged early
>>>
>>> - New bug fixes exposed by Ritesh Harjani on Power
>>>
>>> - Reject RAID56 completely
>>>    Exposed by btrfs test group, which caused BUG_ON() for various sites.
>>>    Considering RAID56 is already not considered safe, it's better to
>>>    reject them completely for now.
>>>
>>> - Fix subpage scrub repair failure
>>>    Caused by hardcoded PAGE_SIZE
>>>
>>> - Fix free space cache inode size
>>>    Same cause as scrub repair failure
>>>
>>> v3:
>>> - Rebased to remove write path prepration patches
>>>
>>> - Properly enable btrfs defrag
>>>    Previsouly, btrfs defrag is in fact just disabled.
>>>    This makes tons of tests in btrfs/defrag to fail.
>>>
>>> - More bug fixes for rare race/crashes
>>>    * Fix relocation false alert on csum mismatch
>>>    * Fix relocation data corruption
>>>    * Fix a rare case of false ASSERT()
>>>      The fix already get merged into the prepration patches, thus no
>>>      longer in this patchset though.
>>>    Mostly reported by Ritesh from IBM.
>>>
>>> v4:
>>> - Disable subpage defrag completely
>>>    As full page defrag can race with fsstress in btrfs/062, causing
>>>    strange ordered extent bugs.
>>>    The full subpage defrag will be submitted as an indepdent patchset.
>>>
>>> Qu Wenruo (30):
>>>    btrfs: pass bytenr directly to __process_pages_contig()
>>>    btrfs: refactor the page status update into process_one_page()
>>>    btrfs: provide btrfs_page_clamp_*() helpers
>>>    btrfs: only require sector size alignment for
>>>      end_bio_extent_writepage()
>>>    btrfs: make btrfs_dirty_pages() to be subpage compatible
>>>    btrfs: make __process_pages_contig() to handle subpage
>>>      dirty/error/writeback status
>>>    btrfs: make end_bio_extent_writepage() to be subpage compatible
>>>    btrfs: make process_one_page() to handle subpage locking
>>>    btrfs: introduce helpers for subpage ordered status
>>>    btrfs: make page Ordered bit to be subpage compatible
>>>    btrfs: update locked page dirty/writeback/error bits in
>>>      __process_pages_contig
>>>    btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
>>>      locked by __process_pages_contig()
>>>    btrfs: make btrfs_set_range_writeback() subpage compatible
>>>    btrfs: make __extent_writepage_io() only submit dirty range for
>>>      subpage
>>>    btrfs: make btrfs_truncate_block() to be subpage compatible
>>>    btrfs: make btrfs_page_mkwrite() to be subpage compatible
>>>    btrfs: reflink: make copy_inline_to_page() to be subpage compatible
>>>    btrfs: fix the filemap_range_has_page() call in
>>>      btrfs_punch_hole_lock_range()
>>>    btrfs: don't clear page extent mapped if we're not invalidating the
>>>      full page
>>>    btrfs: extract relocation page read and dirty part into its own
>>>      function
>>>    btrfs: make relocate_one_page() to handle subpage case
>>>    btrfs: fix wild subpage writeback which does not have ordered extent.
>>>    btrfs: disable inline extent creation for subpage
>>>    btrfs: allow submit_extent_page() to do bio split for subpage
>>>    btrfs: reject raid5/6 fs for subpage
>>>    btrfs: fix a crash caused by race between prepare_pages() and
>>>      btrfs_releasepage()
>>>    btrfs: fix a use-after-free bug in writeback subpage helper
>>>    btrfs: fix a subpage false alert for relocating partial preallocated
>>>      data extents
>>>    btrfs: fix a subpage relocation data corruption
>>>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
>>>
>>>   fs/btrfs/ctree.h        |   2 +-
>>>   fs/btrfs/disk-io.c      |  13 +-
>>>   fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++------------
>>>   fs/btrfs/file.c         |  32 ++-
>>>   fs/btrfs/inode.c        | 147 +++++++++--
>>>   fs/btrfs/ioctl.c        |   6 +
>>>   fs/btrfs/ordered-data.c |   5 +-
>>>   fs/btrfs/reflink.c      |  14 +-
>>>   fs/btrfs/relocation.c   | 287 ++++++++++++--------
>>>   fs/btrfs/subpage.c      | 156 ++++++++++-
>>>   fs/btrfs/subpage.h      |  31 +++
>>>   fs/btrfs/super.c        |   7 -
>>>   fs/btrfs/sysfs.c        |   5 +
>>>   fs/btrfs/volumes.c      |   8 +
>>>   14 files changed, 949 insertions(+), 327 deletions(-)
>>>
>>
