Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62B315F47
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 07:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBJGQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 01:16:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhBJGQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 01:16:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A6EnSV158689;
        Wed, 10 Feb 2021 06:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=i7z1R1s8xa94mc3J+D4bZn43Nh+BF4kD4ur8OrLTR8g=;
 b=DfByR24oKRa//cNW9DPwa//Uhu4mGcwbubH12sITjxbPA2X/w38bN/B8/I5fPOSwK4mV
 lWBsHeGSA3gzTa1RwdUGGqpOBxsoMiTP+cTg9WbVx2/aiuhVmk0hMQaElSdoLyBOLbmY
 1t6DXraZwBSLrR57EizRk4ii1i4qWQnTN55Ra2infhaMlcQzUMXSk3LsWf/icpmsxD/I
 r/brtzARj4tF6Hs12QqAzppa7LfmllE1rwjAW1GMEAHMmR2AUDr1LYolY4ER3Y/maEk8
 clqP+lvHtL2breqPcjnpgBlVbiKViulPIxZP53jOgzWzAHbp1NGwr02/CtvPgCAxNe7s vA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn2117-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 06:14:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A69v9Y176652;
        Wed, 10 Feb 2021 06:14:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 36j4ppr4kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 06:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILuAmaT3hQvGahEioq4KYHfZo8L0rSuJa9Sxikh/GfdJEPgi3U4BpF0xM+iWHeIiiVHP9WBY2Dw2M6clH4qeyIh2NY+jBAVnP6g+ea4VC6H+d5wOqjDOu13Ps5khptx6G0NkNn20irhVJ8ZkfprDjXDvddN/2bUgwjw6VsvkHzn1koJZo4x58CWjz9AGNANpr5FZPpbIzWfaKZ5Ji2H7EkvEoLhrwdZqbgtftRDf4govhdZ2LafBIrfpckSG4sQRe5SS3omrwwJKBejCrE2gOxZ7tZQd96FBC2Uf52VyE5Yv6wFTuWDkLN/YP39NIBmEDF6y2qDFN/K+kLCCXR1hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7z1R1s8xa94mc3J+D4bZn43Nh+BF4kD4ur8OrLTR8g=;
 b=RaW6Q5LjOlSgHtouOtQz6BXQIwNqcRYlnLW8J8UbRIsETr9cccK4qXHrTEH53DfXYO201rNSpT9YJSBwX9bPgwBmDNPf1alKaBON/5hZbPnHs4nHHMG9kZRg7aqOCebW0Y/UNVU17CaJEo9iKHF+ltlBjdES79h5AFr6y/PcWQ+62iViN8sgW2FdNc8p+cXDFMJhsXoXk/7GpyZFOvqWdpK+g+7lilAH4ozMQsf2GQ5lfPSnLHupz9aTcSuweCP0uG+VYXTrHTvkNz4PyJGczLR+Y0hBZ5rq7pSn+sUwq38eZdoFv8unKdE8NamHA+iZgpJxwsZ9P1KghL5PkkpWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7z1R1s8xa94mc3J+D4bZn43Nh+BF4kD4ur8OrLTR8g=;
 b=K4KNj5+srC8ZEltf/Pn7ATTFZpFL453+2CyGAELPXZkUkZS+CApiK/x+TKyNVOAZVmqFK4dVK21+WtLgkmOc1w3zp1c8NWbj4vkLGvz3EUkTKceF0JJSp63SpgicOSq+2QDOl3xNXoJgCDnjCk/XZjk4NGTW2Gyo0Sw3u/0TDUA=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3137.namprd10.prod.outlook.com (2603:10b6:408:c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 06:14:45 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802%3]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 06:14:45 +0000
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
 <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
 <20210121175243.GF6430@twin.jikos.cz>
 <28b7ef3d-b5b9-f4a6-8d6f-1e6fc1103815@oracle.com>
 <9f406301-c16a-72a5-4ff3-d3bda127895e@oracle.com>
 <34cecc3d-235e-2f47-0992-675dc576b5be@oracle.com>
 <20210209211200.GA1662@wotan.suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e28769c5-37aa-4ec5-4b09-07ab8a1ba2a8@oracle.com>
Date:   Wed, 10 Feb 2021 14:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210209211200.GA1662@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a91e:934b:cf95:4132]
X-ClientProxiedBy: SG2PR06CA0120.apcprd06.prod.outlook.com
 (2603:1096:1:1d::22) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a91e:934b:cf95:4132] (2406:3003:2006:2288:a91e:934b:cf95:4132) by SG2PR06CA0120.apcprd06.prod.outlook.com (2603:1096:1:1d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend Transport; Wed, 10 Feb 2021 06:14:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ffa78f8-d7e8-4187-b941-08d8cd8b2972
X-MS-TrafficTypeDiagnostic: BN8PR10MB3137:
X-Microsoft-Antispam-PRVS: <BN8PR10MB313786710AB0087489993FA5E58D9@BN8PR10MB3137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kohzF4WJJNH8JVW5vMXKPydS0XyXV8jzHpPslkDSNaCESWzpQJQayxJa9nALzwwOlPB4WlOhr4NCKVSYJXh9ri5r2tOjMHDLgdqVh2vKVDWNtrj42cyJBIde+MlNCqrgLgl8Fbf8V/V4X0mz0p7BgrU7SOfj8RliQGdgKhedKBeff+Dc92ZCdeg4xeljY3SBSeIiWCJPLnSj7D2kLfAAZuMdgJAOyMALpQMm8hURhs/ChvCxiHpYFMxhrn99rpHHCTsHIZlDIjj+FywtmOxyWnsAUSjoRKzo7tfjxGGDVwk2Q5s1reM17IiF+P8DFnnSbfR2w4ggwkQAJPapQA7mU2kDR0E+aZ2iB8AKrqm79LpOGSZjp2CYLsdzMqJCFvICk9+s2RNw6z7xkP93OW46yihanZ1CiXbe+2jBhFqOPsHUqWfd40UdglbRxhBpEy1V0eV/EdMsEF4hpBjW0KwhPZdvLbOd5qmHuP88v73OYmQ+mm+WnYt1tZXXjXKZSrS6rYX7MjgUYnNgQlWubJQ77ClU2T+hNT39/45i13DErNxvD7zKGQZubrNXFsM5uMDQw2NHttY8LJmIOgwd6JG47mb8Y6TqOgpOordrIyR5h4D2c6g5Px6+tMNByMK7CiOkVNSLRu2ZU1VCMAdbJhnn6/dzME5iJt0LPpFr3L/LzZK71/BEKypZmpCANJs8Mzb8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(6666004)(8676002)(66946007)(5660300002)(86362001)(31696002)(316002)(4326008)(6916009)(66476007)(966005)(36756003)(8936002)(66556008)(186003)(31686004)(2616005)(44832011)(2906002)(6486002)(16526019)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bXN3WHZJY1MvRExPVnN2ZW4yeFMzOEFEVmp5ZHdzaTBHRHNoT2FjOWNXNEVO?=
 =?utf-8?B?UHFXQVpHa3B4c2M1cDFGeFppQSsrQUdaOEZ4cmlpbmEzcE1CWW5SUUdVNFBD?=
 =?utf-8?B?bnhWOHg1Z0d5QUZiQnFVM1VMOHJiRUI0T093S3BTZjFLQy9RYzRmakM1VG9C?=
 =?utf-8?B?U1B4c2RJSHB3TnJBYUJ0bjZLejgrMGdtV3BzNEgrS2RWOXFEUnpGWEYvZWdK?=
 =?utf-8?B?SThROGNpSHpVeE5hVkdkbnAzQWh0akMrdlAvY1VLTjB2a003RzE3RW1RVkhJ?=
 =?utf-8?B?eHQ5cDdkS0dvZHJvZ3NDVzVwYjltNXk5MWpZQ1NhQ3RuYTVGa0NQS0JLSXlk?=
 =?utf-8?B?bEdsV0FsOUx6cGg2L2xOaXJqSmFSOTBFcWJKdGltU1JwaGx3ZWdvQTEwRmhq?=
 =?utf-8?B?cFliMXY0VjdHa2lkMTB2WHVkODlRbjA2UUV3cFFzdng5ZXBvN0FaMGUxRWhH?=
 =?utf-8?B?cGxKVmFneFNhSmhvenRWSXp5R0VoNzZ2SHE1NHJ3ckxIZVRod1RwNldvUUhQ?=
 =?utf-8?B?bDRuNjc3TjB3UXNaNTl0aGxWRVJHQXYvUTlEcTV3TkRPVkVvTjRnR2MvU0py?=
 =?utf-8?B?NHVhZEptSEpWNy9Nc2haZklwL0NGOXJMMGxHSUR5VWxQTUxZNStPWW14VEl0?=
 =?utf-8?B?VkxoaTBUVDZxdzlYK0pqTktSbnRPeTBRekVGdHRuaWFGaW9UWW93U01vaWhN?=
 =?utf-8?B?SFFZbXlIQXpKTnk1dTNRaC9mZmdmK1JibmNZeGZIWE5mbk9ZVzNETVdtbEdO?=
 =?utf-8?B?ZWtyV2pRYnV2VGtEWWwwKy9ac0svcDhlcjJpcUNSWTZTZU8vRjhkSUZvZXNP?=
 =?utf-8?B?VEVrbGhyRDN3d2xJRkg5N3I3bGhsYXd0dVhnMHpDL2loUzAzTE9VUTNPbHFJ?=
 =?utf-8?B?QlU2SVdLNTBJRnZDOThBWDh0Vk5pNW1ENUpiL3Q4UXVEK3ZvUWUvdW03OTFl?=
 =?utf-8?B?dDRIWHl4clRIMVpONXpoV2FVUWU2OTQyL1R2cnNSNmd2MHVZN0g5cjZUL0dx?=
 =?utf-8?B?RUs3dGZHTWNqUXBJbE1YcFlsUXZwTTAwejV1bzdsRmh5MTc5V01PTGYrOHV4?=
 =?utf-8?B?NGpqdGxxclVlNXZBZCt6SS82TmNyRGQrbGxYRE5OYXlxK3UvL29LaDdBZkJW?=
 =?utf-8?B?aEIyUS81TzJqbFg4Q3EzWjR1M2xDZTFmVENqdUNBOUlxWmVFMmJka3U2aG9p?=
 =?utf-8?B?MDRoeTlhemVTbFU4eUN6V2xYS0RLaWZxcGJha1J4cXVpZXlsVVN0bDVJL0Rm?=
 =?utf-8?B?cDdHZEZXU0ZPbnJkTmRUWGE2akNXVnR4NkNRN1Z0dlVWUTdyL0w1WWZ1RExC?=
 =?utf-8?B?Y1c0eDdvYUFIL0FtcUt0azZZUWVwUDZmMitqUjhEaE5qSVZINVZYR3VKcUt3?=
 =?utf-8?B?QS82K2pZY01aQUcrUGpTTG9WanBsSTRaa1NVSjRjSHVEbElkV1VWUDZvTXBL?=
 =?utf-8?B?TmFzaVFGRFgyNmRmQ3RvRXN6RlRSb1hhNFJneE5qc1dWY3IzU1dzc3VFQWVF?=
 =?utf-8?B?SDBxbEZwQi9JZ0xPMzJBcDR1V2VEZnVVTEF6bWQyRWpzTEJpR3hJR2QxUUM4?=
 =?utf-8?B?dkJtWW9oY2JYSmlJSXJDQzRLY21lQTVnUUc2QWxlcmtqQmdRa285NUg5a0hK?=
 =?utf-8?B?SkdmQTZNYTNtZ1hMRmc5Ni83allPRjY0RmY4NEh3aW9Fd3hpb0kzSGlwc3BP?=
 =?utf-8?B?Q2JocjBFVjJHL21NWUR4MDJ5UU14VThaWUY5STczdjNzUWpPcDJnREpSZU5q?=
 =?utf-8?B?dmx4TU10TjJabkJ1S0VwTnU0bm5oOE9meVlmOHZtSmpuSWRWZlc0Rkc5L3RK?=
 =?utf-8?B?cnNobzVUN3I0OW1JZDA0RjZMbWZialNHSHdhWS8zckh5dkFKRUJaVmorVCto?=
 =?utf-8?Q?z5+/51crSLQit?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffa78f8-d7e8-4187-b941-08d8cd8b2972
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 06:14:45.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbp1xahTS6eaX6mzcxsSinL4p5npMSmX6nTh4WpR7VZu1WsSc10xajBTOYbS6LfFS04WJlUl74JIWOgK/Npaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100062
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100063
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/02/2021 05:12, Michal Rostecki wrote:
> On Thu, Feb 04, 2021 at 08:30:01PM +0800, Anand Jain wrote:
>>
>> Hi Michal,
>>
>>   Did you get any chance to run the evaluation with this patchset?
>>
>> Thanks, Anand
>>
> 
> Hi Anand,
> 
> Yes, I tested your policies now. Sorry for late response.
> 
> For the singlethreaded test:
> 
>    [global]
>    name=btrfs-raid1-seqread
>    filename=btrfs-raid1-seqread
>    rw=read
>    bs=64k
>    direct=0
>    numjobs=1
>    time_based=0
> 
>    [file1]
>    size=10G
>    ioengine=libaio
> 
> results are:
> 
> - raid1c3 with 3 HDDs:
>    3 x Segate Barracuda ST2000DM008 (2TB)
>    * pid policy
>      READ: bw=215MiB/s (226MB/s), 215MiB/s-215MiB/s (226MB/s-226MB/s),
>      io=10.0GiB (10.7GB), run=47537-47537msec
>    * latency policy
>      READ: bw=219MiB/s (229MB/s), 219MiB/s-219MiB/s (229MB/s-229MB/s),
>      io=10.0GiB (10.7GB), run=46852-46852msec


>    * device policy - didn't test it here, I guess it doesn't make sense
>      to check it on non-mixed arrays ;)


Hum. device policy provided best performance in non-mixed arrays with 
fio sequential workload.

raid1c3 Read 500m (time = 60sec)
-----------------------------------------------------
             | nvme+ssd  nvme+ssd  all-nvme  all-nvme
             | random    seq       random    seq
------------+-----------------------------------------
pid         |  973MiB/s  955MiB/s 2144MiB/s 1962MiB/s
latency     | 2005MiB/s 1924MiB/s 2083MiB/s 1980MiB/s
device(nvme)| 2021MiB/s 2034MiB/s 1920MiB/s 2132MiB/s
roundrobin  |  707MiB/s  701MiB/s 1760MiB/s 1990MiB/s



> - raid1c3 with 2 HDDs and 1 SSD:
>    2 x Segate Barracuda ST2000DM008 (2TB)
>    1 x Crucial CT256M550SSD1 (256GB)
>    * pid policy
>      READ: bw=219MiB/s (230MB/s), 219MiB/s-219MiB/s (230MB/s-230MB/s),
>      io=10.0GiB (10.7GB), run=46749-46749msec
>    * latency policy
>      READ: bw=517MiB/s (542MB/s), 517MiB/s-517MiB/s (542MB/s-542MB/s),
>      io=10.0GiB (10.7GB), run=19823-19823msec
>    * device policy
>      READ: bw=517MiB/s (542MB/s), 517MiB/s-517MiB/s (542MB/s-542MB/s),
>      io=10.0GiB (10.7GB), run=19810-19810msec
> 
> For the multithreaded test:
> 
>    [global]
>    name=btrfs-raid1-seqread
>    filename=btrfs-raid1-seqread
>    rw=read
>    bs=64k
>    direct=0
>    numjobs=1
>    time_based=0
> 
>    [file1]
>    size=10G
>    ioengine=libaio
> 
> results are:
> 
> - raid1c3 with 3 HDDs:
>    3 x Segate Barracuda ST2000DM008 (2TB)
>    * pid policy
>      READ: bw=1608MiB/s (1686MB/s), 201MiB/s-201MiB/s (211MB/s-211MB/s),
>      io=80.0GiB (85.9GB), run=50948-50949msec
>    * latency policy
>      READ: bw=1515MiB/s (1588MB/s), 189MiB/s-189MiB/s (199MB/s-199MB/s),
>      io=80.0GiB (85.9GB), run=54081-54084msec
> - raid1c3 with 2 HDDs and 1 SSD:
>    2 x Segate Barracuda ST2000DM008 (2TB)
>    1 x Crucial CT256M550SSD1 (256GB)
>    * pid policy
>      READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
>      io=80.0GiB (85.9GB), run=44449-44450msec
>    * latency policy
>      READ: bw=4213MiB/s (4417MB/s), 527MiB/s-527MiB/s (552MB/s-552MB/s),
>      io=80.0GiB (85.9GB), run=19444-19446msec
>    * device policy
>      READ: bw=4196MiB/s (4400MB/s), 525MiB/s-525MiB/s (550MB/s-550MB/s),
>      io=80.0GiB (85.9GB), run=19522-19522msec
> 
> To sum it up - I think that your policies are indeed a very good match
> for mixed (nonrot and rot) arrays.
> 
> They perform either slightly better or worse (depending on the test)
> than pid policy on all-HDD arrays.

Theoretically, latency would perform better, as the latency parameter
works as a feedback loop. Dynamically adjusting itself to the delivered
performance. But there is overhead to calculate the latency.

Thanks, Anand

> I've just sent out my proposal of roundrobin policy, which seems to give
> better performance for all-HDD than your policies (and better than pid
> policy in all cases):
> 
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210209203041.21493-7-mrostecki@suse.de/
> 
> Cheers,
> Michal
> 
