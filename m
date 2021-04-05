Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E19353C6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhDEIj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 04:39:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36108 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhDEIj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 04:39:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1358U1aI106048;
        Mon, 5 Apr 2021 08:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UO+lWxlFw+IHN4AXl7j0WZbrq8O7OsNfa2bBCkcNdZ4=;
 b=ZJ1ounf91NC8BA996uu2qGiqlDDWlwW5fbTnIis3B9SkzoIl76/rZUcXyGlq7e/PDq7J
 dftmt0u8anLEcANekQwI0+3G7+B0V2LqDwRxl5XrnsqDyPPRUcWQ5Hom0ZiVvwIiQaff
 2eY19orx8wy08ls0Rjx5lUSqFS5S3rFBEp5sLvLlEjm9Hitj+wmNPGKh+sqS7E5iGyC4
 meuzgMI458PzE2S0ueXDRvONEwTdyx+UYdB5CsVTdnW67yGif2vIwbHd4B/BKJEIdarL
 hasGtVZhoXcdxAfRICE/JOBrnaxpVnTXXmoHy/xGu3Nk2sLhRJvcDf9mL3CmExtvaK0+ zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37q3bwhg8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 08:38:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1358avUQ120542;
        Mon, 5 Apr 2021 08:38:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 37q2psmn5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 08:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kim9zrStvmOrFlj6nkc+itvC27aOTpAWY/oiQ5stMp12ZxNXn2+jbrc2FEJ+gMfpDfsEMP0lCqqxDrZrHY5FlWqKFKVK075v435YUDoTcQ9bgH0fgZexsaKgE57JyOAmT82p1BN4IXCmWTAPCTEXfmOg7i4okriHwJEv1L+7+CTKooGnGaZ0pgmvh41ii3FvvtNxuqRhpHEbQHxRO+uF4rG36JdWaTxvjGaME6xJN3elHlbJHCnEy0Fr0ppqQWpYAL2iczMcbl6Jrx/s5FqINTannep5lXIA8eieJsMi83guN5E4sfBd12G3GBp/PMX72rpfFxP+t2/3nLs6WkjV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO+lWxlFw+IHN4AXl7j0WZbrq8O7OsNfa2bBCkcNdZ4=;
 b=j+x8tYUefR2CPFvq1bESXVMY6x3Ry6Smwszrh5/vN3QM5NGfNvoXMrCrVPTpcMnApo54f4cDw1vR7l2/BQaUpuJNkXcdAMT16NegptOryYShuoEnCwWBH044k9m0hRvvuMKpHDbCk6RY1dwBxu+eDOyzZn9dU3I0Vh4MJY9yMgfmO9pllCJaLTEe1+Ali2ZjNxIHueG1CbdSE9pFyL7APiJAHlZRNnlvSxlDg8Ji5IL5hzj17hWo5MAV7EurDc+8Ft9hODMUjfKp1giHTlgiA1O9PhHW3zpUgfrbDD1PDS2rwQkPRuhjGlviqq7If9AdEd8HyyRVt/2cmeNC/6iQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO+lWxlFw+IHN4AXl7j0WZbrq8O7OsNfa2bBCkcNdZ4=;
 b=kTrI3hEZHtm5q/HthqrY7ZiV3T9K6923d5VwWdPLIWB/DEq8QwJug/vcrH0bRhnXh4tnkmXHfEywVs2wC9ICZh8dQYTsQO6oyO1yYNafd56tmeXo0/bf17feQkZE8S/GJQbTmudXGi6AewdGIW2KcnTsNf0jvZ57QJ26O3S1L5c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2930.namprd10.prod.outlook.com (2603:10b6:208:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 08:38:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Mon, 5 Apr 2021
 08:38:30 +0000
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
From:   Anand Jain <anand.jain@oracle.com>
To:     "dsterba@suse.com" <dsterba@suse.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
Message-ID: <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com>
Date:   Mon, 5 Apr 2021 16:38:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:68b4:7588:cf71:2e25]
X-ClientProxiedBy: SG2PR06CA0162.apcprd06.prod.outlook.com
 (2603:1096:1:1e::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:68b4:7588:cf71:2e25] (2406:3003:2006:2288:68b4:7588:cf71:2e25) by SG2PR06CA0162.apcprd06.prod.outlook.com (2603:1096:1:1e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Mon, 5 Apr 2021 08:38:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e880d08-7eaa-4a39-bf06-08d8f80e3072
X-MS-TrafficTypeDiagnostic: BL0PR10MB2930:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2930F092CAB869B5595853DBE5779@BL0PR10MB2930.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgcCEeLAQ4iDgniIqOfSLfo/IPouPX/y/fcsJC2iqic1D8T95khGd9nADXoldReaByT4dOUHv4yfzfcRLqf07fMK4nBQVekY9aXh+CRZF2F0u4em+SK3a7dZLoRvx/MPAPIYRw9/kjD1IqiHz4lGxaXTfG3vcdb9rcMki9Z1cuiFTn9WSMi2qud27eIlkO4HEqLPvouKc4Y0hAgS7EhY/zAdv64o+siuMYtffS3ohGsh9cEwvfCb9hau/Q4wwmLwbZpqchB98AjkcWmFQGTpYSVoW4o5oOuiZ8YtdtI98sJ7sMinyZ+GLV/RsnO3cBxbW8V8x9VPHNOUZhCttOr+147FOJ8+96Gyl7qhzuEHUwPu5Tc4Gh8W8RaLNaJajyZSUncMzCJhBGIJ/WeTzktm8oRi0hloR0UkT3Cphwhd7iEKtyQgyowuQ4wtS6B5SSZTOgKZnKZlDTTwqhL1nSJwocFVGY40MKURYp+kxvV8e0ZEB3NZugoazZajMSY9RTEE901ee9ba/Ljrl+/+Rorq4BnPGI2slfqI9mkWWFVUbXKRDiJQDW/z5BXVLE3NooEIjCNo7w1SdOKQXHKxf/c/x/LH0tAIW7DuEr749IEA+0yhdKbY2TQEY8x/1k81y99/AEUhrjhcOkqn8mrWckWzgBxmJ9umTG6ba+n0QwoxJmpjbV6jAXQnl3NidBXtCJ9tJ2IOFmyMGqbCCxl2Gr92lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(2616005)(186003)(44832011)(66476007)(16526019)(5660300002)(31686004)(66556008)(2906002)(83380400001)(8676002)(86362001)(4326008)(6666004)(31696002)(6486002)(66946007)(478600001)(316002)(8936002)(38100700001)(53546011)(36756003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlhzRzg1eE1pT3F0a0JuWDh2U001bko3WVQ2QUgreHVVb04wWXFjdGFVNDAv?=
 =?utf-8?B?VSs3WDM5YTJjOW9JRFZiRGRiSTVqM2h5WlNWSytyQ0hydlc4UWZWQ3JneE9Z?=
 =?utf-8?B?b3J1SUcvWWVtMzcvcnYwQjZFdkd4UGpRTXVNb2ZUQnZQYUEvWC9LT1FyLzcr?=
 =?utf-8?B?RGpOUVJDSmJpT1k2TlNEMEtlTUZSNk9iZng4V2tWcDQyUVN3M0RWMzFwUzNK?=
 =?utf-8?B?QXA2aUU2NU1SWjFCR3g2N08veE8xVFQ4MWc2TzdkV0NBajNuRSt1dS9xRkFt?=
 =?utf-8?B?ekIrclhycnpsTkR6SDFMV3FrT0xQeFFXRjFpdzNSbGpCVGZkd3Z5ZDhqT1Bq?=
 =?utf-8?B?cDh2LzNPQXZUWnM5ZVAvYzFSazFFSXBtdCtnTldReVVnUVZhTXZJY3lURkV1?=
 =?utf-8?B?NGpJZWF3cjh6Kzk1TmE1SEdJdW9yZ0w3Tzk3QTk4QUs3Mm4rVmZUdVdmeDk3?=
 =?utf-8?B?anZDR3h1b3pBZlFyOGt1YUpQcThDVTE3MFJYaDZId2FjTTNiU3kvRHZvdUhR?=
 =?utf-8?B?TWJWdkE4YTRlRmFTU2xQanRUTE1mMVg4WjMxQ0ZveGtid3hYWkdQS05rT21F?=
 =?utf-8?B?dk9VYnB0bHV6U2g5U1Foa3ZHZjhrNE9pNmo1NjZNWnRKY1hLYzlhWG9mSEE3?=
 =?utf-8?B?NkprMnpZTFJWYzNrL2xHU0syTU5sam9IMHpPR0sxU1ZPSnZhaVRtZTZSQnJ3?=
 =?utf-8?B?K1haWXE4MitpNEEzVUxtdGhVay9kcUhoM1dpdGlLdG9iWndhVUV6RHJ0bHdZ?=
 =?utf-8?B?M0E5NVZDaEY2MkNSNmVEQUhZNTRPK29GNGpSUkRpTjFadE9BdzZ0aGdxdTNl?=
 =?utf-8?B?cVhNMGFrMzU1cHJVZXgrcTdPcExickk0cHVBaWY4YmxEZ1VvbXJTK3NiS1F1?=
 =?utf-8?B?UmRKcUxjWHdIQ3J4a29jZUdmcHVUZEZGa0RKOWEwbjJIbS9tSC9NODI4OXEr?=
 =?utf-8?B?MkZDYjIxeG9QNzVyNGxwUHJRVFJQR1o5VDNLMC9aUk1aOGZMcjBvdzdRbFBz?=
 =?utf-8?B?bEFhQ3ZTdW9jQVpPY1psRjVXU2loK21BbUdxekxuc2pyNiswY2JiMWpBYTJF?=
 =?utf-8?B?UklRbGlJNk9PWGF2WFRHM2JVRjNOcVdVaFhoSzR0eVdYcUI5RUxGQWl2UnNh?=
 =?utf-8?B?NWNRdHN1bU1FVUxXai9oenVKTTVtSHVqVXRIQ1Y4TzZ3OGxYdjZTWEtkeDEr?=
 =?utf-8?B?ZkRKaENUdXhpUDZtQmRVb1picjJJNUZTT0h4UkpiTGtadzl1dWxmL1FYekUr?=
 =?utf-8?B?VWRRV2c5bzJad2JYeUhZZzlEL092VC9PbFRtcnlMN0h6UVVWeEhwVFhLR1Vm?=
 =?utf-8?B?Q2lTdXFjTlZ5djdHbUtOQVc0Qk01SG5sOUVPVHg2YWZ3Y3Q2amEyTURRVE1Y?=
 =?utf-8?B?Q2RkUFpPeTlHcldtU2lJc0pFSSt0R3ltU3kyd2Q4NUhzSVMxOXhXOTNwdEtm?=
 =?utf-8?B?TUhTdDJhL0VLTmpUL3RQVDZqV1BGWlQyTkdqVGVObUhtQm9xdDUvMWVCWFBV?=
 =?utf-8?B?b2ZIQmN4YVd0STd0K3E0RGZMdjg2cnhwSXU3MlMrektCeDVqOW9EcVVyZWtF?=
 =?utf-8?B?ZnNXeEtqVENySnk2aVZsYitDNGhISGFKZmhDVWF2WTNSNklobXg3YTJ3Y0pE?=
 =?utf-8?B?bVBMU2V1OXUxTVZ2aXE0YkFyTzFlVEVETW83L1l1LzVRVHZNUmM2Y0wwZjgx?=
 =?utf-8?B?U3J0ZFdzSXpTemFDWjAvZWE2dk1QSk9tWnFCM082djNVaC9sY3VzSmFDcDBk?=
 =?utf-8?B?eHNrNklBemYrUkhKS2cycHNEanIxa2Z1UC9ZZmN0Y3p4UHhkNko0Qmw3Wm1X?=
 =?utf-8?B?bmRoa3lxa21PbVJXeWN6VU1ObnFEcTZ5SHF5MnBlYzlzU0E2eDlndk90U09K?=
 =?utf-8?Q?lIOjSDaGzkKXw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e880d08-7eaa-4a39-bf06-08d8f80e3072
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 08:38:30.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lw5ucb4RwKLn2lHfmLifQ9n7CvAdBayld3zxKa+DMsncAP3AYJcqm45AGoQdK1bIGfbfRbNjVxQJM8RWwRceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2930
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9944 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050058
X-Proofpoint-GUID: FjMvbv0iEb4fTlEIH-IQn1-1N8C85dzl
X-Proofpoint-ORIG-GUID: FjMvbv0iEb4fTlEIH-IQn1-1N8C85dzl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9944 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping again.

Thanks, Anand

On 06/03/2021 16:37, Anand Jain wrote:
> 
> David,
> 
> Ping?
> 
> Thanks, Anand
> 
> 
> On 04/03/2021 02:10, Anand Jain wrote:
>> Following test case reproduces lockdep warning.
>>
>> Test case:
>> DEV1=/dev/vdb
>> DEV2=/dev/vdc
>> umount /btrfs
>> run mkfs.btrfs -f $DEV1
>> run btrfstune -S 1 $DEV1
>> run mount $DEV1 /btrfs
>> run btrfs device add $DEV2 /btrfs -f
>> run umount /btrfs
>> run mount $DEV2 /btrfs
>> run umount /btrfs
>>
>> The warning claims a possible ABBA deadlock between the threads 
>> initiated by
>> [#1] btrfs device add and [#0] the mount.
>>
>> ======================================================
>> [ 540.743122] WARNING: possible circular locking dependency detected
>> [ 540.743129] 5.11.0-rc7+ #5 Not tainted
>> [ 540.743135] ------------------------------------------------------
>> [ 540.743142] mount/2515 is trying to acquire lock:
>> [ 540.743149] ffffa0c5544c2ce0 
>> (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: 
>> clone_fs_devices+0x6d/0x210 [btrfs]
>> [ 540.743458] but task is already holding lock:
>> [ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: 
>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>> [ 540.743541] which lock already depends on the new lock.
>> [ 540.743543] the existing dependency chain (in reverse order) is:
>>
>> [ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
>> [ 540.743566] down_read_nested+0x48/0x2b0
>> [ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>> [ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
>> [ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
>> [ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
>> [ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] <--- 
>> device_list_mutex
>> [ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 [btrfs]
>> [ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
>> [ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
>> [ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
>> [ 540.744166] __x64_sys_ioctl+0xe4/0x140
>> [ 540.744170] do_syscall_64+0x4b/0x80
>> [ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> [ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
>> [ 540.744184] __lock_acquire+0x155f/0x2360
>> [ 540.744188] lock_acquire+0x10b/0x5c0
>> [ 540.744190] __mutex_lock+0xb1/0xf80
>> [ 540.744193] mutex_lock_nested+0x27/0x30
>> [ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
>> [ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
>> [ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
>> [ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
>> [ 540.744472] legacy_get_tree+0x38/0x90
>> [ 540.744475] vfs_get_tree+0x30/0x140
>> [ 540.744478] fc_mount+0x16/0x60
>> [ 540.744482] vfs_kern_mount+0x91/0x100
>> [ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
>> [ 540.744536] legacy_get_tree+0x38/0x90
>> [ 540.744537] vfs_get_tree+0x30/0x140
>> [ 540.744539] path_mount+0x8d8/0x1070
>> [ 540.744541] do_mount+0x8d/0xc0
>> [ 540.744543] __x64_sys_mount+0x125/0x160
>> [ 540.744545] do_syscall_64+0x4b/0x80
>> [ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> [ 540.744551] other info that might help us debug this:
>> [ 540.744552] Possible unsafe locking scenario:
>>
>> [ 540.744553] CPU0                 CPU1
>> [ 540.744554] ----                 ----
>> [ 540.744555] lock(btrfs-chunk-00);
>> [ 540.744557]                     lock(&fs_devs->device_list_mutex);
>> [ 540.744560]                     lock(btrfs-chunk-00);
>> [ 540.744562] lock(&fs_devs->device_list_mutex);
>> [ 540.744564]
>>   *** DEADLOCK ***
>>
>> [ 540.744565] 3 locks held by mount/2515:
>> [ 540.744567] #0: ffffa0c56bf7a0e0 
>> (&type->s_umount_key#42/1){+.+.}-{4:4}, at: 
>> alloc_super.isra.16+0xdf/0x450
>> [ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, at: 
>> btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
>> [ 540.744640] #2: ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: 
>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>> [ 540.744708]
>>   stack backtrace:
>> [ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 5.11.0-rc7+ #5
>>
>>
>> But the device_list_mutex in clone_fs_devices() is redundant, as 
>> explained
>> below.
>> Two threads [1]  and [2] (below) could lead to clone_fs_device().
>>
>> [1]
>> open_ctree <== mount sprout fs
>>   btrfs_read_chunk_tree()
>>    mutex_lock(&uuid_mutex) <== global lock
>>    read_one_dev()
>>     open_seed_devices()
>>      clone_fs_devices() <== seed fs_devices
>>       mutex_lock(&orig->device_list_mutex) <== seed fs_devices
>>
>> [2]
>> btrfs_init_new_device() <== sprouting
>>   mutex_lock(&uuid_mutex); <== global lock
>>   btrfs_prepare_sprout()
>>     lockdep_assert_held(&uuid_mutex)
>>     clone_fs_devices(seed_fs_device) <== seed fs_devices
>>
>> Both of these threads hold uuid_mutex which is sufficient to protect
>> getting the seed device(s) freed while we are trying to clone it for
>> sprouting [2] or mounting a sprout [1] (as above). A mounted seed
>> device can not free/write/replace because it is read-only. An unmounted
>> seed device can free by btrfs_free_stale_devices(), but it needs 
>> uuid_mutex.
>> So this patch removes the unnecessary device_list_mutex in 
>> clone_fs_devices().
>> And adds a lockdep_assert_held(&uuid_mutex) in clone_fs_devices().
>>
>> Reported-by: Su Yue <l@damenly.su>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Remove Martin's Reported-by and Tested-by.
>>      Add Su's Reported-by.
>>      Add lockdep_assert_held check.
>>      Update the changelog, make it relevant to the current misc-next
>>
>>   fs/btrfs/volumes.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index bc3b33efddc5..4188edbad2ef 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -570,6 +570,8 @@ static int btrfs_free_stale_devices(const char *path,
>>       struct btrfs_device *device, *tmp_device;
>>       int ret = 0;
>> +    lockdep_assert_held(&uuid_mutex);
>> +
>>       if (path)
>>           ret = -ENOENT;
>> @@ -1000,11 +1002,12 @@ static struct btrfs_fs_devices 
>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>       struct btrfs_device *orig_dev;
>>       int ret = 0;
>> +    lockdep_assert_held(&uuid_mutex);
>> +
>>       fs_devices = alloc_fs_devices(orig->fsid, NULL);
>>       if (IS_ERR(fs_devices))
>>           return fs_devices;
>> -    mutex_lock(&orig->device_list_mutex);
>>       fs_devices->total_devices = orig->total_devices;
>>       list_for_each_entry(orig_dev, &orig->devices, dev_list) {
>> @@ -1036,10 +1039,8 @@ static struct btrfs_fs_devices 
>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>           device->fs_devices = fs_devices;
>>           fs_devices->num_devices++;
>>       }
>> -    mutex_unlock(&orig->device_list_mutex);
>>       return fs_devices;
>>   error:
>> -    mutex_unlock(&orig->device_list_mutex);
>>       free_fs_devices(fs_devices);
>>       return ERR_PTR(ret);
>>   }
>>
> 

