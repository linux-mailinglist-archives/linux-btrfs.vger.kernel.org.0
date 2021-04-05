Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512603540E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 12:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhDEJax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 05:30:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhDEJaw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 05:30:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1359FMUh072580;
        Mon, 5 Apr 2021 09:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=G1XkRK6iectehMjbQ9AY8bduBxD6LclNHNmu1AYWRRQ=;
 b=eBcy/kEpyqk0AWOs38kk0TBeh8hsxyiiYFR/Q6KXOv4Ocskt2giX+QOOKpuSf1eoM/FD
 TPBoVrOQKbt2NTCla5dCLy8IGioJ25XKNGHLT06RfWuswJvWjnnWgnopMdMTciEJrddz
 7YqPZuWTWHO2VO9Iidb90JLu9gverfoVwT4UOVRX4XvhqT2X4PyFWnkrS3U1uycmgmNc
 3vrQ3F1K/NMpXd/PG1D4QNuewAfmRMlZHlbmI6qor45iZkVpyT8ENncBxsot5rAMdhBd
 LC4a+o+kvXBDvTYg75ZTP0ViDDjNqV+5jvTP05lwuG4b0thMJLITHNFjhkYkA+3ujxbd DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37qfux8xy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 09:30:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1359Eu9G031899;
        Mon, 5 Apr 2021 09:30:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 37q2psp33b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 09:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajyTdXSlg/xmoGaY75jKizFB0oIebyt71p2UiXpOctSiJU37ou3TXJMMLLIYk4rl0MeULWthF9QSev4V5fAoYkEjixhDYu79AXIpF3nd9I4ElO+xZ3UswD2KhsLV3cySX/skcRHZyGNHPN449NA5/y1nf64Eo/0s1apWUbnqPhpj2efuqEdznKDv9j6uxMTKfpBwGis04ieq+kor48CiCp+DacA5OMihicZAwA6Awd5OHRAK1W0boa+7pvptR1quHGdO8TUAkulc15X1bk/k1pt7YIrW5FWwqhMxIBMVvZk6MRuZxEUVBXaT8BbhJxl1jt9Ta6osjIAkdxUTnv8wfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1XkRK6iectehMjbQ9AY8bduBxD6LclNHNmu1AYWRRQ=;
 b=NsR4ZTZoRTusGRGsuE+eHrslesJCy2xo/5CfT48QInA4BGOKmtWNvTFe8ryDnU5M8oIgniRVyb8ujvZfFUNO9S1r37o1fl9nJTmxCYQgIZOLZ+65Oz6QyfYgK6YLbUhBPcGYetaA0Xu0K6hR+Vz9avW6WpzUu1FzXIEFVqgwz23kxYtNIoIW6dCB8PYUfzX+76m+/7D8eNOto5Rr5Ik8q6HUnkyWtfBDGUGoVJkQFpsfjmfaXi6FcD6q1CND8ZV/lrQFyx4Q8sivM1yyVobNzmBJaxDSKc7M1M5kKmU/67hZfuonCoWgyR8o6V7hRKSkvqzRy0IkNr81mVjVtWt3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1XkRK6iectehMjbQ9AY8bduBxD6LclNHNmu1AYWRRQ=;
 b=cAEVE8z0N1DB5WMEttY9Yev7AgoIglCXWfsHVHhGSTdv6DSKqHhCvUtQoLMkwdbahsy2TPPqKvHlblg83dwyyMLweUwn30uBx1BiA/oLHShSrklqFZVm+QCqqIxMp4+jjMSc3p7s4nV3cGjUT2X2riHkig31t0UPL/UCPOO9/D4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3057.namprd10.prod.outlook.com (2603:10b6:208:76::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 09:30:28 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Mon, 5 Apr 2021
 09:30:28 +0000
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
To:     Su Yue <l@damenly.su>
Cc:     "dsterba@suse.com" <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
 <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com> <a6qdw0jr.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <89152693-03c8-bfec-458f-8622c24345b5@oracle.com>
Date:   Mon, 5 Apr 2021 17:30:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <a6qdw0jr.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:68b4:7588:cf71:2e25]
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:68b4:7588:cf71:2e25] (2406:3003:2006:2288:68b4:7588:cf71:2e25) by SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.3 via Frontend Transport; Mon, 5 Apr 2021 09:30:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b68b431a-8910-48e0-ab08-08d8f81572b9
X-MS-TrafficTypeDiagnostic: BL0PR10MB3057:
X-Microsoft-Antispam-PRVS: <BL0PR10MB305767042CD7C0215EF6D77EE5779@BL0PR10MB3057.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwyyWsWm/uL38EUPuJvLI/iOQntDD3mcbJ+C9gR87mm2oRxhd7Nh2LO3LSwGpvwJlDDZdZ+tjwI4TL3b5yGhD9lYw3dAIwCSJ8OGDsYQZw83jC9EK10G2heH7w7n0ewxMF1y5VVk926zBCemprppQBVGatWgpk8K2taFoUgfH+BZYAJ69NTEwp8AysGAMBjl8IQ5EkIWtokDAc4gZgak4DhvtUMiSEDaXQ2GHzxF4Blruw+XcEMMylE20PYMdnaPv+oak7SR0DcPty8QrT9OUCUKbongGYb23Mg+WtsMJxW8o5GIpPZhHWBPqU4e0xlcdh5MmPGfD6wlYAKek5LMpTqaEqhWGV4wejJKciNhlSDs8/toG/i3jBjTVVO85yxBCpu48hC/ClNPRfdW0jjM0eK03vI3nDF6KAeJ+0XfE7n/6J7Zg3PCNMkVVfJgV2SzwB2WGPilJ3XMSv1PyNoSuHroM/+UN/MbS7qdO69hFkEap4JM7sQ0ujhcQg60vKPSe+nlZsK3IwfJa17R8ZdNM3x6NIIQsYchu78UyKJOPTk+G8olSVPTGXWATJCtxQGBGcqne5wCS60LwIWSq/o1FiPhZ5LHtAPq3n25DyaoKvgsRCcu6JxgSYqFAiuOeeo6XNeaDyUIU5QOuNhGiyGhPBU2gGOLlWPfy7OwdwVzrAICGDWfMdgT2mhjhC39KPFWrUOLtpYvU6n7x7Aq3cPjGfqQJfXvaqbgLOwIj0aiSIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(316002)(31686004)(44832011)(8936002)(2906002)(4326008)(53546011)(31696002)(36756003)(6486002)(66556008)(66946007)(86362001)(66476007)(83380400001)(6916009)(8676002)(6666004)(5660300002)(186003)(478600001)(38100700001)(2616005)(16526019)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bXpDeGIwQ0dycjJzS3Z4QWEvOHNGdjU5cUhoQ3VJVU5YankzcTRvMWlORWRB?=
 =?utf-8?B?a2EvVEdNV2RVQkoveFh6ZEJFdXhKZWdVUTJJdGRlVjFMbUUrallPa0o0Ymdt?=
 =?utf-8?B?Z2tNSG9zc2YrWUJZczNaTTMrZXI5QklMVW9FRndIelA0SFJoT2hlWE4vdngw?=
 =?utf-8?B?MSsxZlVrdTZlYldWakNRL2R2YjBETSswUDNHMUpvVm0xNlJSaUVMT2V4Zm5V?=
 =?utf-8?B?UnplUWEyaXNqMWtVZ3Y3OE96My8rZURYaGpEQnhVd3gzQ1lmYVQ3T2R5NzJu?=
 =?utf-8?B?MVRFTzNYTktWVWk4blpLUUtmcDVlaUpWZDJrUlFaemdmdHozTUdDTElXVDFt?=
 =?utf-8?B?VCtYMlJwdC9ZaXR2Nld3NmFIY2k2YndiREVzeFNiNkkyU3ZmS3YzSHRPTFRF?=
 =?utf-8?B?UnhRVHFPOW5TeU9udVowK2xHTDZKWC8wOU5XRmRqYlVmdnB0OXJReFg3R1hP?=
 =?utf-8?B?bStMbGozYTdqS0x2SHlod1MyejM3MkRrQ0VVK0xnK0VESU1QdUVjdncyanI0?=
 =?utf-8?B?VlA3RU01bjdCUlFPNWFpQTQxSE9vZk92VkovWFJCZjRhbUhMZFJ4UmZFNi9P?=
 =?utf-8?B?UDY4V1NuZk84WHE3T0lkaTYybzVVYmR5alpRZnFZNCtQazd4YlVCaFQ3YXJV?=
 =?utf-8?B?SEd2cjZYcUUwTXNNeEVnWjRUNHRqaEdhUFQzTlFySk40bHAxbUJrc1B2SkFt?=
 =?utf-8?B?N2hkRjJLNEJWNUd5dEtOajBRODdEbWN0Tld1Y2w4NGRLUzFvNnM5aXJKOWZK?=
 =?utf-8?B?TFpBYXJhaEtWUDc3cmxvNFRkOHBvQ0FEdFlRbVBobkVFaTJmRGFMR1A2NjVn?=
 =?utf-8?B?aytkZHlUaFNzVWpDaXRiRFptMGFackpvcXRYcFJOQXpiLzdPVWlVL1doSjlU?=
 =?utf-8?B?S3NqSndaMmM2elpPdE1acmR4b3JBVlB6Y0FyNzAvQ0tKVmx5WUxCbUJudkFu?=
 =?utf-8?B?a3JPUXBNcTVXMDJpU2JYLzdoWm1Ed0Z4ZDhXd2ZlcG1QS3B6SmdQekJtazVP?=
 =?utf-8?B?bEp1RnZnRnl0QWp2S1o0NS9CeGVkMzdIK2pzcjZxUW13WlFjNitnRVAxOHAy?=
 =?utf-8?B?dUROQ2tVN3VEUnR5d3hqdzN5WjU0NGR3WVhWMjQreEFaZWM3UHkxNy85MGtU?=
 =?utf-8?B?RFRsL2U5NkZQZTdkeEIvaVBFYUxtZmh3TUdNMmMrOTUxSStGOVhCRFNPakRm?=
 =?utf-8?B?Y0dpWmRXNjhxa0REZnZnd1JBUkpwNlJ2cTlGaHBRK2FldWtLT1NpNEd0SFJI?=
 =?utf-8?B?NHpHdFB6ZjJhZURzc3F1T1drdTM4Q25IUjJ2NW9kYm80emRzR2VwcnV0bFp3?=
 =?utf-8?B?YitJZ2FuSXdieERWRngvcjNGcTIrQm9Wenl4d2x4RklwSW1ZNjlEMk8xdXBW?=
 =?utf-8?B?a05xK2pBLzVqcDBjNll1aFNnOHdTTzBlbmlNMHB2b1pCemU5U2xvYWJZUjAw?=
 =?utf-8?B?SXh1c1gxVUZoQUt3VSt0bVJaYUNqbjlSZEplOUhBNWIyL0VIYjBScFlZOHJX?=
 =?utf-8?B?UnB2dGlEakNhOTEvd1NVMHR5SDVJQXc2REZoQitJSkZKblRiejRaU1laeDRo?=
 =?utf-8?B?ZmhpYUluUnBxQUxjbVJ0OUdSSUhyMjkrSlZIOXcrM0x3WnhoaG9XeFV0Kyty?=
 =?utf-8?B?eEFpZzRBbTRPd1l3Nk1rcCtzcVBaYUZMODVaaFhySVhwK2lad1hGS3ZEUjZk?=
 =?utf-8?B?R1p6a29GMEVCNDF0aXVBL3l2ZVJzeUtiYU5EbHBDWjVJVnQrWEpMMkRGYkNo?=
 =?utf-8?B?ZmlhRzR2TXE5QlFseDNwYllKM010S2lKZEtCbzFBaTB3akVNN0RsV2V2RzhY?=
 =?utf-8?B?R1dUblk4NFlxYXdzbU05ZFJ0YTNwaGMya1pENVc4Z2Z2NU0vRE1tVE9oYXYy?=
 =?utf-8?Q?Zj9dSIczSXeqM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68b431a-8910-48e0-ab08-08d8f81572b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 09:30:27.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HP7qYCo/Q0Tqk2bpNHQ9EFO1ktOiHUba5tT5+Hg5fq0+t4d5CmKVnn4/619kYkhhZgrxBa3Sj4hy4UMs76uqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3057
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9944 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050062
X-Proofpoint-GUID: _rcbMolsi4qOAhm2TKUeHp2qEgLlWXxt
X-Proofpoint-ORIG-GUID: _rcbMolsi4qOAhm2TKUeHp2qEgLlWXxt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9944 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050062
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 05/04/2021 17:18, Su Yue wrote:
> 
> On Mon 05 Apr 2021 at 16:38, Anand Jain <anand.jain@oracle.com> wrote:
> 
>> Ping again.
>>
> It's already queued in misc-next.
> 

Oh thanks.

Thanks David.

-Anand


> commit 441737bb30f83914bb8517f52088c0130138d74b (misc-next)
> Author: Anand Jain <anand.jain@oracle.com>
> Date:   Fri Jul 17 18:05:25 2020 +0800
> 
>    btrfs: fix lockdep warning while mounting sprout fs
> 
>    Martin reported the following test case which reproduces   lockdep
> 
> -- 
> Su
>> Thanks, Anand
>>
>> On 06/03/2021 16:37, Anand Jain wrote:
>>>
>>> David,
>>>
>>> Ping?
>>>
>>> Thanks, Anand
>>>
>>>
>>> On 04/03/2021 02:10, Anand Jain wrote:
>>>> Following test case reproduces lockdep warning.
>>>>
>>>> Test case:
>>>> DEV1=/dev/vdb
>>>> DEV2=/dev/vdc
>>>> umount /btrfs
>>>> run mkfs.btrfs -f $DEV1
>>>> run btrfstune -S 1 $DEV1
>>>> run mount $DEV1 /btrfs
>>>> run btrfs device add $DEV2 /btrfs -f
>>>> run umount /btrfs
>>>> run mount $DEV2 /btrfs
>>>> run umount /btrfs
>>>>
>>>> The warning claims a possible ABBA deadlock between the threads
>>>> initiated by
>>>> [#1] btrfs device add and [#0] the mount.
>>>>
>>>> ======================================================
>>>> [ 540.743122] WARNING: possible circular locking dependency detected
>>>> [ 540.743129] 5.11.0-rc7+ #5 Not tainted
>>>> [ 540.743135] ------------------------------------------------------
>>>> [ 540.743142] mount/2515 is trying to acquire lock:
>>>> [ 540.743149] ffffa0c5544c2ce0
>>>> (&fs_devs->device_list_mutex){+.+.}-{4:4}, at:
>>>> clone_fs_devices+0x6d/0x210 [btrfs]
>>>> [ 540.743458] but task is already holding lock:
>>>> [ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at:
>>>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>>>> [ 540.743541] which lock already depends on the new lock.
>>>> [ 540.743543] the existing dependency chain (in reverse order) is:
>>>>
>>>> [ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
>>>> [ 540.743566] down_read_nested+0x48/0x2b0
>>>> [ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>>>> [ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
>>>> [ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
>>>> [ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
>>>> [ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] <---
>>>> device_list_mutex
>>>> [ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 [btrfs]
>>>> [ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
>>>> [ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
>>>> [ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
>>>> [ 540.744166] __x64_sys_ioctl+0xe4/0x140
>>>> [ 540.744170] do_syscall_64+0x4b/0x80
>>>> [ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> [ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
>>>> [ 540.744184] __lock_acquire+0x155f/0x2360
>>>> [ 540.744188] lock_acquire+0x10b/0x5c0
>>>> [ 540.744190] __mutex_lock+0xb1/0xf80
>>>> [ 540.744193] mutex_lock_nested+0x27/0x30
>>>> [ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
>>>> [ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
>>>> [ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
>>>> [ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
>>>> [ 540.744472] legacy_get_tree+0x38/0x90
>>>> [ 540.744475] vfs_get_tree+0x30/0x140
>>>> [ 540.744478] fc_mount+0x16/0x60
>>>> [ 540.744482] vfs_kern_mount+0x91/0x100
>>>> [ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
>>>> [ 540.744536] legacy_get_tree+0x38/0x90
>>>> [ 540.744537] vfs_get_tree+0x30/0x140
>>>> [ 540.744539] path_mount+0x8d8/0x1070
>>>> [ 540.744541] do_mount+0x8d/0xc0
>>>> [ 540.744543] __x64_sys_mount+0x125/0x160
>>>> [ 540.744545] do_syscall_64+0x4b/0x80
>>>> [ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> [ 540.744551] other info that might help us debug this:
>>>> [ 540.744552] Possible unsafe locking scenario:
>>>>
>>>> [ 540.744553] CPU0                 CPU1
>>>> [ 540.744554] ----                 ----
>>>> [ 540.744555] lock(btrfs-chunk-00);
>>>> [ 540.744557] lock(&fs_devs->device_list_mutex);
>>>> [ 540.744560]                     lock(btrfs-chunk-00);
>>>> [ 540.744562] lock(&fs_devs->device_list_mutex);
>>>> [ 540.744564]
>>>>   *** DEADLOCK ***
>>>>
>>>> [ 540.744565] 3 locks held by mount/2515:
>>>> [ 540.744567] #0: ffffa0c56bf7a0e0
>>>> (&type->s_umount_key#42/1){+.+.}-{4:4}, at:
>>>> alloc_super.isra.16+0xdf/0x450
>>>> [ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, at:
>>>> btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
>>>> [ 540.744640] #2: ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at:
>>>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>>>> [ 540.744708]
>>>>   stack backtrace:
>>>> [ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 5.11.0-rc7+ #5
>>>>
>>>>
>>>> But the device_list_mutex in clone_fs_devices() is redundant, as
>>>> explained
>>>> below.
>>>> Two threads [1]  and [2] (below) could lead to clone_fs_device().
>>>>
>>>> [1]
>>>> open_ctree <== mount sprout fs
>>>>   btrfs_read_chunk_tree()
>>>>    mutex_lock(&uuid_mutex) <== global lock
>>>>    read_one_dev()
>>>>     open_seed_devices()
>>>>      clone_fs_devices() <== seed fs_devices
>>>>       mutex_lock(&orig->device_list_mutex) <== seed fs_devices
>>>>
>>>> [2]
>>>> btrfs_init_new_device() <== sprouting
>>>>   mutex_lock(&uuid_mutex); <== global lock
>>>>   btrfs_prepare_sprout()
>>>>     lockdep_assert_held(&uuid_mutex)
>>>>     clone_fs_devices(seed_fs_device) <== seed fs_devices
>>>>
>>>> Both of these threads hold uuid_mutex which is sufficient to protect
>>>> getting the seed device(s) freed while we are trying to clone it for
>>>> sprouting [2] or mounting a sprout [1] (as above). A mounted seed
>>>> device can not free/write/replace because it is read-only. An unmounted
>>>> seed device can free by btrfs_free_stale_devices(), but it needs
>>>> uuid_mutex.
>>>> So this patch removes the unnecessary device_list_mutex in
>>>> clone_fs_devices().
>>>> And adds a lockdep_assert_held(&uuid_mutex) in clone_fs_devices().
>>>>
>>>> Reported-by: Su Yue <l@damenly.su>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>> v2: Remove Martin's Reported-by and Tested-by.
>>>>      Add Su's Reported-by.
>>>>      Add lockdep_assert_held check.
>>>>      Update the changelog, make it relevant to the current      
>>>> misc-next
>>>>
>>>>   fs/btrfs/volumes.c | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index bc3b33efddc5..4188edbad2ef 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -570,6 +570,8 @@ static int btrfs_free_stale_devices(const char 
>>>> *path,
>>>>       struct btrfs_device *device, *tmp_device;
>>>>       int ret = 0;
>>>> +    lockdep_assert_held(&uuid_mutex);
>>>> +
>>>>       if (path)
>>>>           ret = -ENOENT;
>>>> @@ -1000,11 +1002,12 @@ static struct btrfs_fs_devices
>>>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>>>       struct btrfs_device *orig_dev;
>>>>       int ret = 0;
>>>> +    lockdep_assert_held(&uuid_mutex);
>>>> +
>>>>       fs_devices = alloc_fs_devices(orig->fsid, NULL);
>>>>       if (IS_ERR(fs_devices))
>>>>           return fs_devices;
>>>> -    mutex_lock(&orig->device_list_mutex);
>>>>       fs_devices->total_devices = orig->total_devices;
>>>>       list_for_each_entry(orig_dev, &orig->devices, dev_list)       {
>>>> @@ -1036,10 +1039,8 @@ static struct btrfs_fs_devices
>>>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>>>           device->fs_devices = fs_devices;
>>>>           fs_devices->num_devices++;
>>>>       }
>>>> -    mutex_unlock(&orig->device_list_mutex);
>>>>       return fs_devices;
>>>>   error:
>>>> -    mutex_unlock(&orig->device_list_mutex);
>>>>       free_fs_devices(fs_devices);
>>>>       return ERR_PTR(ret);
>>>>   }
>>>>
>>>
> 
