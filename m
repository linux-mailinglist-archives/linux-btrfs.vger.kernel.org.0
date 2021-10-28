Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9604743D860
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhJ1BHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 21:07:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19892 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1BHT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 21:07:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S0GGHs023707;
        Thu, 28 Oct 2021 01:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5XJBgj7cxmcO05PJ+q1yOueCwvJGck/+fjfKbpaxU2A=;
 b=EdVG3HAtFfdfoYmHf0CdZrPs3ZwVHMq5dtnW/xNxn2nG3S8U5hC5fWFS0QiPCTBmfEsE
 l6XLN3LZkn3IYQFJZ+L9nnKxqZvmOqv1+z4ZNXxZJe8PFTmm/totVU2xgX3WqSLqP11/
 SQ2qf8CaME228hCFw5t+CKGtaI+gLjchUlJ3i+yu2uTA+/nmpBpimg1fvOHOht+h7GSg
 bVCqCHGz0rdCBn81ZEUTbeOzX279b0eV6UQGKXshgLhNRteEdrvBgKAgspDGjN1Ts3z+
 HHQPiR04hA+Ko9ucI9pVqtOpW4N47TRfNveIJeYa9853CZtXO4RG8LJgXFwKrjSC+ZmS +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fj6ya6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 01:04:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19S11JRt192311;
        Thu, 28 Oct 2021 01:04:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3bx4gas8sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 01:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrlLCd/DEc6ULvYBZoHYuZBlc4LI/YBcuL3PdHKrzYkoY+5IKJmr6OZkeJReeTHbY443lLZ2IPL4qYkOsZNAlP2eCNWw/7jrUWmxeMU/5ZvUTUrSX2MqHMR9QhkQ2VwzIKn0dCwVIPlX0KGDhrgVOi8WgHMsXzzS+uW+uOtp+/oGmLZOys5iqXQom0xE4BjxSuTTYVJ4j7rmoZ3B3nirtHJhxhj6I3MgAMhbWN66zVnhIsw2cKBFcP7AhWA14+Y+4zR5cEksjmenRj7C+kt/9+5fEdKa5Zyg7TN0cd/9He6y7krq8gojtoQEbCLNKVuh0dD2DP6280fceR5VnFSeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XJBgj7cxmcO05PJ+q1yOueCwvJGck/+fjfKbpaxU2A=;
 b=eJWydvdYsAZPLzIE3FrC9lfY9rYiYj+CaT9fzmfZzuAmL0uA4XgpQb0rZDaB8BEx/wyE6afSGL1ZOXUspUtw2fJMuR9GflHv7NPuOWfnLAsCzRdcp0X48+sUAL2QJSia8d77Vl9zNjNTnASdpxnv/CQiaN1HI/BMDQjWSRlbWcgkr6xbMk4etAz2Jj6IRoKhCXAuFuoNzgh6cAi37v/z8WiwAm3zTRzmJQlLE5oglitG3kFZ0b0HXbdt/IxHDaGEnro/YZKAlmYrJUcFPxg+UL3nxuUQBldf0BEV4GJ42yLSqrWJCe+WVylBE193booHkgizMQWGVyyMQPe+Wp4xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XJBgj7cxmcO05PJ+q1yOueCwvJGck/+fjfKbpaxU2A=;
 b=MVYTcn7+J4VcYO8tGIrreul1+h+Hv+ccpFWJ3Z76wOGtTdhIq+QEYZnuTxEdYtsfacIDxiBQSVr3gLv4jX4TKpUZHHdSh9mgOIxcyBsdHPqQozKcylMUl30g7V/inSnPzXFSE4nq3vemt6Dj/Q+5oRzT3UJfYcmDDWW6Uzjd01Y=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3774.namprd10.prod.outlook.com (2603:10b6:208:1bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 01:04:43 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 01:04:43 +0000
Message-ID: <91627cd8-279b-30a1-7e10-adb43f5a2027@oracle.com>
Date:   Thu, 28 Oct 2021 09:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
 <514d1330-6af8-4d48-fef6-f2732d7f186d@oracle.com>
 <f229e88f-5483-9f2d-00eb-9da45f9bca4e@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f229e88f-5483-9f2d-00eb-9da45f9bca4e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR01CA0013.apcprd01.prod.exchangelabs.com (2603:1096:4:191::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 01:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60e89d3-9685-4ba6-122e-08d999aeed20
X-MS-TrafficTypeDiagnostic: MN2PR10MB3774:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3774816E5AE972D4F5656A73E5869@MN2PR10MB3774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reWY/0zX2gZoRUyVR+hGRsQOC38EXonYu/wVyQZ3iwsgIvZqSIkPOQnBB6GI1p3rUz9goR4ljEgaP+yfJ8J+w8HOY41qA1TSuuC4v6hT3i67DGXSun8su7fbvXo5zCN4NU21APEnrS08ocrVTzoTQ07YPHL1Ti3GNphh/ixnjsPkYoNi1eIc7/Ccy+Rqb/wBJa45e4tTeuxyUwFVZcdEXTznKnFGjB8xfi7QReYUP1eYwHZMAS0budPL4VCFlKGKNpFAS1WMq2i4jBjR2pXmbqKkYr547EFX1wraa5tKr7v2jqJvLBjE2BrCEGNH0an1Zr6N/okGsE0xNsgAdQ9Nfo/jPn9bKCo1VWlOONUauWv1hBQGgKYA6l+T8dnuBn63/jfCSXFnYIhW6peEc8ce+y+bAp8obbbGxwEwIxljPg2P9B7yEyWfQ4kOq1ud5Bf1VYA/1/EkAtKOae5RE6xog47hlYYsmMRw0Zgp+KSManeL0fzf0WQXxX4CcnyVeqAGKRZGRGfGgE9gUJXI6dbTygq4qfTtVKrTcZjCZx1EGhEwaWhnWuza6cLKENEkCCNm0CJr6K9GAzccCbNeU0aQuQtbdpR2i9oaPqdxuKwtpDZOgXPbzeDHKVFHLQXajERqkKYyXJeN29cvnEA6w4EjuBVK+imu9Y70h7fv/yuUnu2eEVvHnuME8eR1m0P3gYRFv5qKR0Y1XRIF+PbJEv2FSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(31696002)(66476007)(316002)(66946007)(83380400001)(16576012)(53546011)(6486002)(44832011)(2906002)(186003)(5660300002)(26005)(2616005)(31686004)(6666004)(8676002)(956004)(110136005)(8936002)(86362001)(38100700002)(508600001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW83R0dOYlFKV0xmWjhybkZLa2xTdDFpUUxRd1pwOHkrYitQbVMxZmFJN25p?=
 =?utf-8?B?cExKeU5zYmlMMmZ0THZxazlHMlJGOUQ0cFRIcStWSmpyQy9TMTYyZ29GVVEv?=
 =?utf-8?B?SjZZRjZCV1V6TEZ2alJKTXQ4NmgvWkxlUC82TE1iNi9SbU45bDB2M3NFMGg1?=
 =?utf-8?B?TEw4ZGVpY05haFJGcjV1UHJxOUhiUm8wY1o2Z2lreFJ4UXYxY1lHM0lGeTJX?=
 =?utf-8?B?b1FhdjNBbUJYeVJHbXBBQmF6RXVtczg0ZFNKU0crSXdRTm02ajV0Uk5PbmY2?=
 =?utf-8?B?UlcxRG1iUnRHK2lWaXJucU1PT3JpUzVtVElVZVA3eUtsVWRjamk0SlBqSXR5?=
 =?utf-8?B?U3hSRnZIc1A2TTZXSW1vVHBkWDErTDY3clI4V0VjUGYveXhMdmM1V2xzSmFO?=
 =?utf-8?B?c1NxWVRpQkVka2ZYVkRJaUIzMWtra2hyVFM5UUZobmVNY0VnOEk4dU41SWlI?=
 =?utf-8?B?dUxHQVgzTEJXOTE3cWFTMHUxTmhyMzVIYXQ4N1Y0VkhjcGRWRTdHYXdYTFBW?=
 =?utf-8?B?ajRsajgzdGxZLytrUHN4dkEwZ3RyRGlnMFdTeTZzb1NnVm9uWklpVVR2cVN6?=
 =?utf-8?B?dUk3Y0c4U216WTd3eTF2VE8vTUlTdjFzNWRjQnVVOXpvdlI2Q1hlRjNFTGVo?=
 =?utf-8?B?MS9lUGszUDdOK3NyZlRyZ0cxTzU2SGNYNlBSUTU4QjJYZ0JrNDh4c0hlN0x6?=
 =?utf-8?B?VlZLSm1TNWZCZGhDTk95ZS9EL2d3MGJjOHRIY0pKNTZtcTlTVGd4N0RDdFo2?=
 =?utf-8?B?N1B6Mi8yNUZLQUtoS2N1RkhNUng1VDlENlVxM2UydG84bnp4aEhyMFNrVEQy?=
 =?utf-8?B?OVoxRWdPbUZONU5FVm50VHVtTE5xdEdwemowWEg4K2JaejZ5MVQxb1EzNEVJ?=
 =?utf-8?B?cURCUWRJeFdaR2FPVmxCeFRrRldvVUJzQ1dyWDhyMGgrSUlzaDB5UWlwRWky?=
 =?utf-8?B?eUI5L3NZNWViZnY4dmNsbno4TlUyRHk4K0I3S0Y0ZTVKeFUydWFQeVpkQXl4?=
 =?utf-8?B?Ni90OStrdHEwdnY3UHhQYkQxUkI3VFl4anltaFc1bzhtWExPYktTTHVqdzNY?=
 =?utf-8?B?KzZTcDRMV1pwaWFrdXMrR0dxR2RBNDhDUGVuWFQ0em1xNXNobHgwQW02OE02?=
 =?utf-8?B?Rm16blFoTkxNNTJjUjBCTnlqeTZtN3NFV3M1a1FVUUwyVkhBNkZjcklSM3Rz?=
 =?utf-8?B?aXVKdGgvOHY3bnZpZkExcHVVVnlJcms1QzlDdzRyVm9IYVZncHBKWGEwNUpP?=
 =?utf-8?B?S0R4amlaRnJoVmV1U09PUzd3YjdhUlUzdVlyYk9wODVpVlk5YU00N3ZiL05l?=
 =?utf-8?B?ZE9PeVpYYU5KdGxwNlB5cVdOMEtLWlZ4c3o3MWx4VmF2dUc1NjVIN1NScWxH?=
 =?utf-8?B?RHJYaEIyQ3RXblZyQTl5MlVjWU9iY2h3OEJXQnQwNEl5dDNIUHpUdzhZQ3FW?=
 =?utf-8?B?VEtRTmU5SENPZ0gzNURIUUJWaWh4THUyOWhPaFdEczZSVXgvcWZDZFIzSWQ1?=
 =?utf-8?B?VjhWcEZ2bW5vVFFNU3ZHWE84M0t4RFd0eERHWU85U2NSTXQ5dEFHa0E4cGhS?=
 =?utf-8?B?bmVSWFpsY1RHcmdzSDZSSjZhN0JoMUlNODEyZ0lVemMxeldsei9UaG1RWGsy?=
 =?utf-8?B?WmhGSUFXMVBoZ1huMmE3MUhMTmJUZ2Y4Q2d0Z1huTitaTDhrQXJoK2xiM3NO?=
 =?utf-8?B?ZXlDUHJ0ZnRZUEF5SDd0OE1zN2RSYnNlY2xaY1Fuc2JYMVZ6aENmdjBwaEJv?=
 =?utf-8?B?aW9OMWdmYWhQTVpLQTlwWkdKTW1IcXZLcGZlaTV0S2pVN2ZWUzdRLzBxQlhR?=
 =?utf-8?B?Z2FqcVF6cC9xbkVtbWtLQk1TUUtzRTNpUEhvNmZyaG45czFyTWJ0NlRQWHp6?=
 =?utf-8?B?SDVudEdYSU1vS1RlckdlQnFVcGZVRVJMV1RwMDBScit0U2p5OUlnWUtBR3dz?=
 =?utf-8?B?YUlpcFM1VHlxTEJZcUpTSmRFazJwV2ZFN1cyUjNreUt5Y2dEODlLVmxUTDQ4?=
 =?utf-8?B?WmtjSEZxaWVmSXZOY2wvTlpOTzJzN0p6MEs5TDRTNzl6aWVxZ1JHTnduSDhZ?=
 =?utf-8?B?MGU2cjF1OXpkanJwMjdUS09sZm9yaC8rWGZQOVZRTHhZazlLZklEOWFteHQ5?=
 =?utf-8?B?ek1MM2xxa2NVMnh3OXo0UHVYZ0VQWXFNTS92eFNPLy9jOUpVUUsyMXV1NUFM?=
 =?utf-8?Q?VDI5fOBf5CAcvVpgH2vYgKc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60e89d3-9685-4ba6-122e-08d999aeed20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 01:04:43.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDJfR5AYUO5ZgbBPdE8Fo5ppowq6uBwa3nS2IgXTdLfgKpqVf+bOfMVHkcRwTS/IpbkVn72sjt89wmcumotUfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280004
X-Proofpoint-ORIG-GUID: Dk6Btb5wPjIZAVW0hnF03-Gi-YGiut3Q
X-Proofpoint-GUID: Dk6Btb5wPjIZAVW0hnF03-Gi-YGiut3Q
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27/10/2021 18:41, Qu Wenruo wrote:
> 
> 
> On 2021/10/27 17:23, Anand Jain wrote:
>> On 27/10/2021 13:28, Qu Wenruo wrote:
>>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
>>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>>
>>> But the truth is, there is really no such need for so many branches at
>>> all.
>>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
>>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
>>> their values.
>>>
>>> Only one fixed offset is needed to make the index sequential (the
>>> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved for
>>> SINGLE).
>>>
>>> Even with that calculation involved (one if(), one ilog2(), one minus),
>>> it should still be way faster than the if () branches, and now it is
>>> definitely small enough to be inlined.
>>>
>>
>>   Why not just use reverse static index similar to
>>
>> const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>> <snip>
>> }
> 
> Sorry, I didn't get the point.
> 
> Mind to share more details?
> 

Something like

/* Must match with the order of BTRFS_BLOCK_GROUP_XYZ */
+enum btrfs_raid_types {
+       BTRFS_RAID_RAID0,
+       BTRFS_RAID_RAID1,
+       BTRFS_RAID_DUP,
+       BTRFS_RAID_RAID10,
+       BTRFS_RAID_RAID5,
+       BTRFS_RAID_RAID6,
+       BTRFS_RAID_RAID1C3,
+       BTRFS_RAID_RAID1C4,
+       BTRFS_RAID_SINGLE,
+       BTRFS_NR_RAID_TYPES
+};

btrfs_bg_flags_to_raid_index(u64 flags)
{
        int ret;
	flags = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;

        ret = ilog2(flags);
        if (ret == 0)
                return  BTRFS_RAID_SINGLE;

        return ret - 3;
}

Should work. No?

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/space-info.h |  2 ++
>>>   fs/btrfs/volumes.c    | 26 --------------------------
>>>   fs/btrfs/volumes.h    | 42 ++++++++++++++++++++++++++++++++----------
>>>   3 files changed, 34 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>>> index cb5056472e79..5a0686ab9679 100644
>>> --- a/fs/btrfs/space-info.h
>>> +++ b/fs/btrfs/space-info.h
>>> @@ -3,6 +3,8 @@
>>>   #ifndef BTRFS_SPACE_INFO_H
>>>   #define BTRFS_SPACE_INFO_H
>>> +#include "volumes.h"
>>> +
>>>   struct btrfs_space_info {
>>>       spinlock_t lock;
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index a8ea3f88c4db..94a3dfe709e8 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -154,32 +154,6 @@ const struct btrfs_raid_attr
>>> btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>>>       },
>>>   };
>>> -/*
>>> - * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>>> btrfs_raid_types, which
>>> - * can be used as index to access btrfs_raid_array[].
>>> - */
>>> -enum btrfs_raid_types __attribute_const__
>>> btrfs_bg_flags_to_raid_index(u64 flags)
>>> -{
>>> -    if (flags & BTRFS_BLOCK_GROUP_RAID10)
>>> -        return BTRFS_RAID_RAID10;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID1)
>>> -        return BTRFS_RAID_RAID1;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
>>> -        return BTRFS_RAID_RAID1C3;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
>>> -        return BTRFS_RAID_RAID1C4;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_DUP)
>>> -        return BTRFS_RAID_DUP;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID0)
>>> -        return BTRFS_RAID_RAID0;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID5)
>>> -        return BTRFS_RAID_RAID5;
>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID6)
>>> -        return BTRFS_RAID_RAID6;
>>> -
>>> -    return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
>>> -}
>>> -
>>>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>>>   {
>>>       const int index = btrfs_bg_flags_to_raid_index(flags);
>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>> index e0c374a7c30b..7038c6cee39a 100644
>>> --- a/fs/btrfs/volumes.h
>>> +++ b/fs/btrfs/volumes.h
>>> @@ -17,19 +17,42 @@ extern struct mutex uuid_mutex;
>>>   #define BTRFS_STRIPE_LEN    SZ_64K
>>> +/*
>>> + * Here we use ilog2(BTRFS_BLOCK_GROUP_*) to convert the profile 
>>> bits to
>>> + * an index.
>>> + * We reserve 0 for BTRFS_RAID_SINGLE, while the lowest profile,
>>> ilog2(RAID0),
>>> + * is 3, thus we need this shift to make all index numbers sequential.
>>> + */
>>> +#define BTRFS_RAID_SHIFT    (ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
>>> +
>>>   enum btrfs_raid_types {
>>> -    BTRFS_RAID_RAID10,
>>> -    BTRFS_RAID_RAID1,
>>> -    BTRFS_RAID_DUP,
>>> -    BTRFS_RAID_RAID0,
>>> -    BTRFS_RAID_SINGLE,
>>> -    BTRFS_RAID_RAID5,
>>> -    BTRFS_RAID_RAID6,
>>> -    BTRFS_RAID_RAID1C3,
>>> -    BTRFS_RAID_RAID1C4,
>>> +    BTRFS_RAID_SINGLE  = 0,
>>> +    BTRFS_RAID_RAID0   = ilog2(BTRFS_BLOCK_GROUP_RAID0 >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_RAID1   = ilog2(BTRFS_BLOCK_GROUP_RAID1 >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_DUP     = ilog2(BTRFS_BLOCK_GROUP_DUP >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_RAID10  = ilog2(BTRFS_BLOCK_GROUP_RAID10 >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_RAID5   = ilog2(BTRFS_BLOCK_GROUP_RAID5 >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_RAID6   = ilog2(BTRFS_BLOCK_GROUP_RAID6 >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_RAID1C3 = ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >>
>>> BTRFS_RAID_SHIFT),
>>> +    BTRFS_RAID_RAID1C4 = ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >>
>>> BTRFS_RAID_SHIFT),
>>>       BTRFS_NR_RAID_TYPES
>>>   };
>>
>>
>>> +/*
>>> + * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>>> btrfs_raid_types, which
>>> + * can be used as index to access btrfs_raid_array[].
>>> + */
>>> +static inline enum btrfs_raid_types __attribute_const__
>>> +btrfs_bg_flags_to_raid_index(u64 flags)
>>> +{
>>> +    u64 profile = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>> +
>>> +    if (!profile)
>>> +        return BTRFS_RAID_SINGLE;
>>> +
>>> +    return ilog2(profile >> BTRFS_RAID_SHIFT);
>>> +}
>>> +
>>>   struct btrfs_io_geometry {
>>>       /* remaining bytes before crossing a stripe */
>>>       u64 len;
>>> @@ -646,7 +669,6 @@ void btrfs_scratch_superblocks(struct
>>> btrfs_fs_info *fs_info,
>>>                      struct block_device *bdev,
>>>                      const char *device_path);
>>> -enum btrfs_raid_types __attribute_const__
>>> btrfs_bg_flags_to_raid_index(u64 flags);
>>>   int btrfs_bg_type_to_factor(u64 flags);
>>>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>>>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>>>
>>
