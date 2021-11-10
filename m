Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551D44BE16
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhKJJyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 04:54:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64406 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhKJJyc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 04:54:32 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA9Sv9e014510;
        Wed, 10 Nov 2021 09:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sPBPEaGTg9ucUvQUvCcPfpd8xXwGy+F3w1Eop5wKwn8=;
 b=eXD8m5vep73SR1FYpzyyrGHwAPUVS339/5fKkmj6I4fXzSx8mnuKpdHbo69nn1oGhn81
 EuuHgpNEfRsmxyQJXr2BGyTAL87Tx55KvCVDp4QhuL0u2A5+l/miUxqlYNOstWs53/MM
 Q5U4t5QD/gvJRB+PxKs87WLaqoxVyl1TiUgWv9n5YN1cNl3GkP37EbBrKhNWXeHnNTq6
 Y6Y/HqfQ95ckHarCpVfb5Sp+uT9l8IGTQTydmcrTswPvCPHvYZhppwyJHVqNiJOPc2y9
 +G0PlmlxsYPik8UIZFYsFQ7wSyW1XevoSqnU59N0nGWBAXJxKfUxMcA3lOIO3AyrB2DF zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c87vxha6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 09:51:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA9pPuP101809;
        Wed, 10 Nov 2021 09:51:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3c842c0gn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 09:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHWfBO0dXt7rYWLuHptgr9paVa3xBZsB+0ZQUJtzLFs0J+bIa31UdFEos8ZV+3+k1qbcZ+85kr3fqXkrd0m4oEXuaYid41NP6Dkk19jTS+kCtifi18TlJtG2CV40e0KUzz8DkOC4NNyqwm6JVRDLtxjCRc6KAdIH8aAHJjxSB6I2Jo2KTl1vBQF+uCw6icWOjGiTwfg/zRMQm+CfAEAmX++sn9vyAlSC27fXfXGWmeg7r/OqQU8NtTOADLvxaPicCEwBBpvCLI/i+1ql0s4tgXXfOEBa4/dDqCfJpeN43OQrNUTNeVrtWSFxQ2ipyiph7JbC5uQDXTGCMyQUPBLO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPBPEaGTg9ucUvQUvCcPfpd8xXwGy+F3w1Eop5wKwn8=;
 b=MeOL9l5rTazYADxkVxk+Uni8cWJ5eTQVzrofGD6uUkR/3H6telPc75lwY0SCu+9gImqUPtY5wMDdxlI6AKboXIHskFFGC9F2X4pQWylx0hggkySX7Il6q2N9wIZ62vyrUl3inqvKGpfVAW5rVO+fm6FiSLzsHhC8AkPjclFSub+asatr1tfQX/gA+Gm9ay3HjrkNh515TWL0otGPmRw6ugamqssWePwqjFGe4G9a1/WFPjtmeesbxMUJzOlrS0JQrkVJM555T5lm6Z6itQGvMt5aKDUvsDEtGK5sRdBhqoDFanHmfbag8B9lzSE0yyA0f2GqxmDsJVoNYyizRf7ITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPBPEaGTg9ucUvQUvCcPfpd8xXwGy+F3w1Eop5wKwn8=;
 b=q5n8eXsDAfffrmRRkoM37m/p9bBegpRRMRwHDeOsoiuhVFFxah2oplc5HrW2EehPY6CpMiIGMdIX8/v/4aGBBEmMR6IOPmVunAsZ8jjC4BKk/zoMpMIWwsKK8X/RHznIEbiB3Yq2xGVxjMH/p3LxnrMxvj+Tdwjq9NCkgBni/K0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 09:51:37 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:51:37 +0000
Subject: Re: [PATCH v3] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20211110093417.47185-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e28598a3-3756-6917-c52b-db0542da4fe1@oracle.com>
Date:   Wed, 10 Nov 2021 17:51:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211110093417.47185-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SI2PR01CA0047.apcprd01.prod.exchangelabs.com (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 09:51:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5adb9412-058c-41ee-cf03-08d9a42fafa0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39819375D24D4D7CC9D712C9E5939@MN2PR10MB3981.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpBrL/XVO8icYbD9BXGDQD4pe1pAKKCjUGbGwZCOk6IgHXKXAo44EPpvAUo32xZBU+zbrHrbQBsO/4RSLGVmM+9iL3IHCe1AM1EeohOknvMeS5fBhmRnzND+OO7OvbGd7O/GiJdd/5iWTFMgyZ57e3WtYzjWFnj++//gdAfNBtLT/QHQFeWniR8f1AXczO4axQECKB//O0AzilrWp8USdXjcwc+vkwnGS7gO0oWddR/BSDoBtmMl+2cRThrJJy18RgZJCO3VC+/gc7X2LkgszkI3O49mL54rJqpPzNgCp7GH3Hp3sGpKVqF3ZoarL07VhDgzLwB7TUDYPKOFNXKnIN3WW3egxxkgTgddmTa8xtx2TRis/jJCVxxvu4PIWdiqyr/79whiTioE961LLfdyamh2konpWUKsbsWXNbQ0Vv+Ppn/iZcgri3Qnf4F3unRnDFYHWlHkilRaV2et7nwpGXnRvSjnAdK7us1CSqfeHflMmr+4lsjUPeO7esWRYXV+RDjEcVQ1ssCnnZmW2XL+2Xh8FveOjOcALLqy3yjV4gNstWcFAiDggPN23+pRMKnAGuwfqui2NF0PJtGo1MV442bS8Sw45w6P5NbUKjNrCRrnI7S9vcQCPtcsXBSc/IACQDvx7A3Th6bhooW1mwipaF7SzUT1cT1WsWEQXRiA7zb1Z7HpD5sZ8f33NFZ1HtzuEnb3WaHuDvhnX3m8mgHkOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(86362001)(186003)(508600001)(53546011)(31696002)(8676002)(2616005)(83380400001)(38100700002)(2906002)(44832011)(6666004)(316002)(6486002)(8936002)(956004)(66946007)(4326008)(66476007)(31686004)(36756003)(16576012)(66556008)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHU5UkVhNXhHVGE1VHJVTmtXYlVIRjZaeHRNRXZYZ0hYNmMyM1RseTA4ZkRR?=
 =?utf-8?B?YmxBMlhvSEFyWmJFaWpaMnhOUVBDU0F6MVhUc0wvamZvWVQ4TGt3LzJVNy9X?=
 =?utf-8?B?ZmpoR3F5VVA1N1lHQTZTODZuN3BEUURxazhxWjV0clNUUHlOYjc4SGd4S1Ru?=
 =?utf-8?B?OUlJL3hUWWNhaStOSFRGODFwMWJuVUM3SGR3WkFTQUM5a1lqUElXeitmYmVt?=
 =?utf-8?B?bHkvdWIwSHAvanl4RzVOS3R4MEd1bCtIY1k0N0h0cHN2ZzFHQkVZU0kraEM5?=
 =?utf-8?B?SXNCRWZDNjNWVkxZSWFwZVRkaFFqVElGV1RmTXNHL0NDRWVyMnBETjVGKzg4?=
 =?utf-8?B?ZHJFbVoxeERtb3JMdHpGU2NoRDBXc1BRUTQrdGZwd2NSbDhPSDdPNVNSMzBI?=
 =?utf-8?B?UUlHT2tacEYxcmx4MjhCZGd4SElBcU5ZUnExdDIvUUJsY3VFVk1hYlVBejlk?=
 =?utf-8?B?Qm9yOS84MTdmdlNicGNxUy9OTEk1UmpmWTNPaXMwOGRqZW5WZGVDNjdRMGRF?=
 =?utf-8?B?YmZnWjM0MUM0SzVkV2hidFc5OW1PcG9icTJtak8rNDNSUFc3N0VTV2VwUmVt?=
 =?utf-8?B?OTdtZzdBZHA0VjBuUUE5T3lVTy8rci82NEhmbW96UGJTMWJqU1hoU241OUVm?=
 =?utf-8?B?R0hIKzR3ajZGcEswT3BVM0pVYkdXNEd1SllRS01PVEV3elovZmNuOXdrUWRX?=
 =?utf-8?B?T3Rpc2pKTHhkSDNkMmZLZEw5MXhuRmRKc2xxZG83c0k4djlzYmU3K0Q5MFMv?=
 =?utf-8?B?aEwxdWgzMkpKa0VKY3hwRWxKM3V1a2NkNnE0VnlXTWhtcmlpc2xnVTFWa0ww?=
 =?utf-8?B?U2lwQXRpVWpjd25oTnF3Vlg1ZzJyWkJNNGp0T2Y1Vklvbm80TGxKeStlbHhD?=
 =?utf-8?B?enNNd1dLL0xNTTVDak44M1NPM2JpRU5OOGgyMnNNMTJTeUd1ajV6bUwxck5v?=
 =?utf-8?B?VkVRVWpTWUVOWEJOOTU3Y0dvZitqclJQSjN2SUpVNGZRRUVPQjdpcnB2aUVx?=
 =?utf-8?B?c0o4YldiOUJQazhsbElxUGloNmkvTW1zMXdFVDJIc2RnS0sxWWhLOU4zMDI4?=
 =?utf-8?B?MmlYQ2JMUDhUM3hyakU5MjU1c1hPV2N2bTNzZVNLbHBidFV6U0g1aFNoS2RV?=
 =?utf-8?B?emtLQ0Z3Ti8yVmxsbVY2d1U0U05KNzJyM1N5cDYwYm9YZ2xNMGhoeVo4TEdh?=
 =?utf-8?B?QjlIZS81S2dCTDZ4RG5rYUM0RFpkTXgwOHc3WitVVlQzOU5FRmZlaDlkY3BR?=
 =?utf-8?B?aUU4TnAzYzBaZkVuN3pGMzFDc1FuQUtVOE9yQk9KTHdxQmlaWExIUnhLd2Nn?=
 =?utf-8?B?VEhCeXlaeklua2loWFBNZzJiYmVLOHBEUjNCWkFmem53QU9qMEY5NmdCY2tG?=
 =?utf-8?B?Zm9NZTZmbXBGaXhveWxLWkRZMEFxQ242MGk3Nk5qaSt4S2hkTUxkK05GRzZh?=
 =?utf-8?B?WlZtWmVyLy9ma2lKOHBZUlBXSDd2NG4wNHF1TngvSGptWjE5T2JLTFFScnRW?=
 =?utf-8?B?RDRVM0EvdFlPVFkrOU9vQ2hIaEJXZ0JHendlNUZaTEZRRlI3WjAvL0dOMkNv?=
 =?utf-8?B?M0tRcWxYbnk0OERiZC9WNGZFdlFCazJaZjdPUTZNZDMxandjMmdNc1gxc09Z?=
 =?utf-8?B?bXg2S2JOeDNCOVZnTUdkZ3MwZytBT1RJMW1jQU1zbGF4YlpQTm9NRmZUK0dp?=
 =?utf-8?B?WUZXaVB0M2R2MHYxQllpbkhSajA2STF3dTd2Ny9PL29UMGZ0b3NpOGI4MzhH?=
 =?utf-8?B?VlZmOU52Z1Y1ZzNMRldzZXFDYXQ1ZGRsalZPbFhPcmZCUmduY2plR1Bma2la?=
 =?utf-8?B?K0k4Y1pJSDlmclRsVmRhaXFCbVNjU21FUzdoMlZFTFVIY3kraUV6azNnK0Zr?=
 =?utf-8?B?c1F6SDJTZmVPTHA2Kzl3bjIrZEVkUzNJZmsvT0c0NW1GR1c4a0hlSU1pOVcw?=
 =?utf-8?B?VlRMdzhCN3dMTDk3UDNKcm5FVTNuZFZQVFRiZXlBbUduemhhQlN1NVl5eUtS?=
 =?utf-8?B?SU1nVVhBZzdEUkV2bmxJd1M2OCtIbU1LeHpPNDZiQXBZM2pVYUh6RFdjZXJI?=
 =?utf-8?B?MG44YUsyUnJHU2VWTURaZGRqNzB6ZXd6OUdNTWVCWHZqcTZUMXJjZXpVMEow?=
 =?utf-8?B?dDB1clROWEJuZ05LMi8vNWZneUZIbytFWUUzVmxTcW96cHdLbDZ6TEdwVFQ1?=
 =?utf-8?Q?jINN6m0K6qCxS+nAuOfvXOM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adb9412-058c-41ee-cf03-08d9a42fafa0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 09:51:37.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5HAQZH0ESSs4AVPWXpYUjWIDsPjcRg9i/nqGtwhXwcy6YN+V5Kpa5fTPRs8rjP9wLyCgkcJKKvJfBRHboY6Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100053
X-Proofpoint-ORIG-GUID: io1AU0niKLKK7TPFDUXtWsgGivJ7F7oI
X-Proofpoint-GUID: io1AU0niKLKK7TPFDUXtWsgGivJ7F7oI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/11/21 5:34 pm, Qu Wenruo wrote:
> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> v2 cache by default.
> 
> However nospace_cache mount option will not work with v2 cache, as it
> would make v2 cache out of sync with on-disk used space.
> 
> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> to reject the mount.
> 
> There are quite some test cases relying on nospace_cache to prevent v1
> cache to take up data space.
> 
> For those test cases, we no longer need the "nospace_cache" mount option
> if the filesystem is already using v2 cache.
> Since v2 cache is using metadata space, it will no longer take up data
> space, thus no extra mount options for those test cases.
> 
> By this, we can keep those existing tests to run without problem for
> both v1 and v2 cache.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com> > ---
> Changelog:
> v2:
> - Add _scratch_no_v1_cache_opt() function
> v3:
> - Add _require_btrfs_command for _scratch_no_v1_cache_opt()

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   common/btrfs    | 11 +++++++++++
>   tests/btrfs/102 |  2 +-
>   tests/btrfs/140 |  5 ++---
>   tests/btrfs/141 |  5 ++---
>   tests/btrfs/142 |  5 ++---
>   tests/btrfs/143 |  5 ++---
>   tests/btrfs/151 |  4 ++--
>   tests/btrfs/157 |  7 +++----
>   tests/btrfs/158 |  7 +++----
>   tests/btrfs/170 |  4 ++--
>   tests/btrfs/199 |  4 ++--
>   tests/btrfs/215 |  2 +-
>   12 files changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac880bdd..e21c452c 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -445,3 +445,14 @@ _scratch_btrfs_is_zoned()
>   	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
>   	return 1
>   }
> +
> +_scratch_no_v1_cache_opt()
> +{
> +	_require_btrfs_command inspect-internal dump-tree
> +
> +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
> +	   grep -q "FREE_SPACE_TREE"; then
> +		return
> +	fi
> +	echo -n "-onospace_cache"
> +}
> diff --git a/tests/btrfs/102 b/tests/btrfs/102
> index e5a1b068..c1678b5d 100755
> --- a/tests/btrfs/102
> +++ b/tests/btrfs/102
> @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
>   # Mount our filesystem without space caches enabled so that we do not get any
>   # space used from the initial data block group that mkfs creates (space caches
>   # used space from data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # Need an fs with at least 2Gb to make sure mkfs.btrfs does not create an fs
>   # using mixed block groups (used both for data and metadata). We really need
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 5a5f828c..77d1cab9 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -60,9 +60,8 @@ echo "step 1......mkfs.btrfs" >>$seqres.full
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# makes sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index cf0979e9..9bde0977 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -59,9 +59,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index 1318be0f..ffe298d6 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -37,9 +37,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 6736dcad..1f55cded 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -44,9 +44,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/151 b/tests/btrfs/151
> index 099e85cc..b343271f 100755
> --- a/tests/btrfs/151
> +++ b/tests/btrfs/151
> @@ -31,8 +31,8 @@ _scratch_dev_pool_get 3
>   # create raid1 for data
>   _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
>   
> -# we need an empty data chunk, so nospace_cache is required.
> -_scratch_mount -onospace_cache
> +# we need an empty data chunk, so need to disable v1 cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # if data chunk is empty, 'btrfs device remove' can change raid1 to
>   # single.
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 0cfe3ce5..e779e33a 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -64,9 +64,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid6 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> @@ -94,7 +93,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>   
>   # step 3: read foobar to repair the bitrot
>   echo "step 3......repair the bitrot" >> $seqres.full
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # read the 2nd stripe, i.e. [64K, 128K), to trigger repair
>   od -x -j 64K $SCRATCH_MNT/foobar
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index ad374eba..52d67001 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -56,9 +56,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid6 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> @@ -85,7 +84,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>   
>   # step 3: scrub filesystem to repair the bitrot
>   echo "step 3......repair the bitrot" >> $seqres.full
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
>   
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index 15382eb3..3efe085d 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -27,9 +27,9 @@ _require_xfs_io_command "falloc" "-k"
>   fs_size=$((2 * 1024 * 1024 * 1024)) # 2Gb
>   _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
>   
> -# Mount without space cache so that we can precisely fill all data space and
> +# Mount without v1 cache so that we can precisely fill all data space and
>   # unallocated space later (space cache v1 uses data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # Create our test file and allocate 1826.25Mb of space for it.
>   # This will exhaust the existing data block group and all unallocated space on
> diff --git a/tests/btrfs/199 b/tests/btrfs/199
> index 6aca62f4..7fa678e7 100755
> --- a/tests/btrfs/199
> +++ b/tests/btrfs/199
> @@ -67,7 +67,7 @@ loop_dev=$(_create_loop_device "$loop_file")
>   loop_mnt=$tmp/loop_mnt
>   
>   mkdir -p $loop_mnt
> -# - nospace_cache
> +# - _scratch_no_v1_cache_opt
>   #   Since v1 cache using DATA space, it can break data extent bytenr
>   #   continuousness.
>   # - nodatasum
> @@ -75,7 +75,7 @@ mkdir -p $loop_mnt
>   #   Disabling datasum could reduce the margin caused by metadata to minimal
>   # - discard
>   #   What we're testing
> -_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
> +_mount -o nodatasum,discard $(_scratch_no_v1_cache_opt) $loop_dev $loop_mnt
>   
>   # Craft the following extent layout:
>   #         |  BG1 |      BG2        |       BG3            |
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index fa622568..d62b2ff6 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
>   _scratch_mkfs > /dev/null
>   # disable freespace inode to ensure file is the first thing in the data
>   # blobk group
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   pagesize=$(get_page_size)
>   blocksize=$(_get_block_size $SCRATCH_MNT)
> 

