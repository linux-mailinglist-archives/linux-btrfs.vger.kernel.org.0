Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CF44A845A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiBCM5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 07:57:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55292 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238149AbiBCM5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 07:57:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2139kN3f009901;
        Thu, 3 Feb 2022 12:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nwYYlRz8vdz4+ouvgdYeR+G7h3909/O2784/O5svry0=;
 b=p4gXXkfZTIKatz6ySTpNclLnqddlvS1kx/8MbnvSbjsHMFpNoZ7sAJOP3ZIBVUpk2sR1
 T6aMbuE43VOhg9sTpylJsPQ969kUGntu+/2DMutgZljLxTzvJ20fyoNQhqJ0ZSuQn7SU
 njZPMCSm1T+6XuHsocowGQXBG4vDwpqbpqLgUhyjZvLSUhLDlumDuvDm09q3i28Zp4j0
 X+RcPUngFI18NZWtg2vzg1EM4F6FzFr8FGhPORvkd3wmBuuBQ6w5SJwpJaCwPDMYFpuO
 oIlR4K+Lw9azaViMfY90Dw9N58gImnBT6urO+oe/L8/5LfptHjSxzttyqNXyColvmHuR iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac92t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 12:57:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213CpUQ6105461;
        Thu, 3 Feb 2022 12:57:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3dvtq52eh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 12:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXpT9x+GVpSHM93/VYGzQzgFzRm74Wmr3MxSiYmGR5U92QZenEpXKhS/Dqr75olZpNoM6MhGlSW6yxAdphDQehK8QuVZDJ3q6GlLt/NuoPefjJcf0Tuvxe8lr4nl8XQ4i6VX1T2K9zkU8Y9Ige/yFuVBM/Xw5+1yxu+rjFRXdDOOafr554/4jsOT3lkjteI8GR+Exu5wPnDHKhMyGRna2mcdfSOKkBoDSApvBjFxfNDk05zp9PuLFz6qAWpWSFvV8qY0XRPI9KXo755d0TH4LqbnHybMvqf4m2SwOn1Q6j/BgvLdlZ+XF4SpdH2Z2ued8+uLKj57Wq70NQtpQyahWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwYYlRz8vdz4+ouvgdYeR+G7h3909/O2784/O5svry0=;
 b=klXAKE+PS23sWm4DaTpBHPBcH15BmvYqa5FWWtCnWDuAumuIhNAh9pFurHJ1uRZDTolMcpjH26hNCTyTj+e2EoRJdOv/RIKBp4z0CZg8Nqa2+++TZydmWACUsbmz3e5ZUT0pxAQmfwAnm5TCKpXP5Mwyle0+kgleY4Aa7GdYtBSSdqzBV4CcrRhF6y4xVn8xmAdwJXaYX/BEwwTybW139kiZD4Ll+LOY5iXDYNpBHKn7MdP4aPiEkFCamzXOZpo4EyAhalccGIOXbM/20QhHgGSHZUD7LHb/LCV7tfyKcK2zVYmUDqdSzeGTuH4QJDk9rMVYwJCk6N+tww3cSxdkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwYYlRz8vdz4+ouvgdYeR+G7h3909/O2784/O5svry0=;
 b=L8xOeSnPryapzAOOEIEPH3rQUYZ0LpEtNoMz6yvLhXu9I5jzJ1Kb3SV96j3pddLZ2J7ZaalUbn9969MvnBS+zKhva2PoXrVKVrRQ529SDC+tdZYHCt4oAQ56quNDB+RU4ovcpKwRKTRVITCJl826BfLq7WM4PWLlZM5CwFLqX5E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 12:57:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::7ca5:168a:d3cf:f562]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::7ca5:168a:d3cf:f562%5]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 12:57:00 +0000
Message-ID: <094ffa0f-d596-8744-5ca1-39b0566cb520@oracle.com>
Date:   Thu, 3 Feb 2022 20:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] btrfs: keep device type in the struct btrfs_device
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <c815946b0b05990230e9342cc50da3d146268b65.1642518245.git.anand.jain@oracle.com>
 <20220126165302.GC14046@twin.jikos.cz>
 <e412efb6-7ea2-cfd2-5c5e-cbe4fdde5c53@oracle.com>
 <20220201170658.GV14046@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220201170658.GV14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c236de3a-b75b-44a6-04bb-08d9e714ab06
X-MS-TrafficTypeDiagnostic: CO1PR10MB4625:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4625CA01A470F2451C41AEC8E5289@CO1PR10MB4625.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhd5XijhfndeT+pZf0FnWOkYT+VCRdUibakMH0ymwpRojQUqpmUdbDO5ISbUNj0m+OuiW1Hm86roJAbnTDU0hzeEHmieLev1x9pwqw1tdbW6Xh/4ySNHHQRgxt5Kzv/cOiu8o/j4ufd63/jxIAnzxz+6p8xbfuaICrKpnMJyXAClCSfvnLGTqS4DSUpVuoMbcYaXvIVa6iQNncFjU419icXM3YFkcUNhunByV+81maWG5lt+04TNoKTw6bb2slzOybpFnP9pJ12b87grIkFMFpN6YRRBgmRHTFVgiToKH6Hzujl82vI3M2Ut0ohXaruNNz6zRxB2KfH/nAZKtOmzn6ncBIz34DZMe6eNESp4D9D4WHV0/z0ozUwmdthheK0vi1QMt5a2nLJuxbOrKBaLdSFfjge9hI5t2/atKfDfJbiLihssVHDCaZrk51MXfaRnTUG/dP3SKcQ56P4aO7tf5TOh1TEF9cRJaqdTzIyTj1kKUL3r3mzdZ5XOTCX6ESMRWpW0X2GzHkYlUMNezsNRV3fmu1IaXQFe4p4FdJrFD3x9SI94L6UWyH8QtSE65dR+VueF4C816eusXIQ1oBlEXATs+qVJiD8TYcpWZc7hW3OsHDzb0y7ptBjV7Fc++AIrlWY4xRiSCuZdXnFPl7fBUrC+a23w5L8U+nFfuCm/8zmmZH6GuliR97pVftEtYQlFYj5xQ42tqj22HmNsCo5FEfZ8COj85n81qJJ6C3pJ7W8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(31686004)(26005)(186003)(36756003)(31696002)(86362001)(83380400001)(316002)(2906002)(44832011)(8676002)(38100700002)(6506007)(5660300002)(53546011)(66476007)(66556008)(8936002)(6666004)(2616005)(6512007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TENHNEV1R0syTUpUZVIycTZzVzFHSUcrd2ZDekRtWFdlQzlzZWViMWl2S2FK?=
 =?utf-8?B?ODhQWlMwckpzZnk0QkdkOG8wYmVTMHdDQXZqWWlYYTM5UVlnL1JoSkpDTDE3?=
 =?utf-8?B?bHliVENRS3ZPUjBveVZZcHUxYjVKUDdZZjByaW53YlNSZ3hhbGg5L3c1WHlx?=
 =?utf-8?B?Yy95SEM3V0dLN2FCWVFMVm1kQ3hXNHdlS2VzN1FZMkRWVVdhSVpZWmtWdVFy?=
 =?utf-8?B?MytRNGZGVlhuekVGL1hsZXZNYWdlZVExd0ZGUm5OcEtWd3lZWGFkVkxna1ky?=
 =?utf-8?B?YkxNejV6OXdCeCtwR0F2Z0xEQy9BTGFiZDdVOGFJQnZGZ2grQnBBZnhOQkQw?=
 =?utf-8?B?UjdLbXdkYno5eXZpK0RhUWpEUTRndnlNbUlXcXQ0VkxsMkkxNDdxQzJyS295?=
 =?utf-8?B?Z3pKUUhIeDA4Zk9ic0toZnNnNU95dHVRcUFmV3ZlV3dJTWY4WFkxdUpDcWJP?=
 =?utf-8?B?K3dLemJMTW1aWjhLQ0pQR0NMVTNWNzdIc2VlYTVDbjczU0sxZVR1eFhHUzJ0?=
 =?utf-8?B?azBWYnlTbUsxeXhMK3M1Z1NmQ3lzaDVvWG5vOHdsY3ZQKyswZWFXZW1jQTRi?=
 =?utf-8?B?T1RDWjg3UjN3SDA5TXd5Uit2bXM2UVpYRHhCS0ZpQmNLNkNCZitBakFBQkxT?=
 =?utf-8?B?Z3RjTU9zbkltL0xyS21UVEt0S0YwSDlra2FRVzRuY3JjZWVEOVg5UmpONkZD?=
 =?utf-8?B?UG52Zm8yZmc3Skt3QzVIbk1VMzJROVk3dklUQWdLWHp0cU5CSE9MSld3UjNI?=
 =?utf-8?B?THFFY3BONjlXZzQzdE5GdnpwT2d1cC80Q2QwZCtKUWFQbnR4STVaTWxyWW9z?=
 =?utf-8?B?TmdzUHJzR3FzNDB0NFhaSlVmeUJ0cWpCekRwOWFDMm52ZlllYUI4bUtra0tL?=
 =?utf-8?B?OXNqNXNqMzBwK1JNai9hMFMrMXV0Mm1YZmxtYmtlbTA0dE1lQXZkcVN4Vk83?=
 =?utf-8?B?clg0T1JyYm1xb2t3VEgxemNta1dHeVord1BwcWtzZk4wd1NKeFcxUS82eFhn?=
 =?utf-8?B?R0xuNGlpOGt6eHhlR09YR1dDQUhkeVBtVlMwRUxIUmY2bmg3K3FmelBMTkFF?=
 =?utf-8?B?NHA1M00xMlZFdkpNQUN0MlNFeFE0RldnTjhjdTFiWmRXdk9zbjhkN28rSUR6?=
 =?utf-8?B?MDQ0QS9DNDdDYTN2QVMvUEk1WkwzOWNKWnlvZ08vMmdtWFVhY2dpSEZScTZK?=
 =?utf-8?B?bGFsU2loaGEwNEszRklDaXdCK0l2blk4c2VLemY0R2cxZDZleUJ3RHNwNmJU?=
 =?utf-8?B?LzJSbHd0V0R2V3AybGNqcm9pMDBNaW4rekY0NHAvK3I3eUd2dGMrUWZPdkdC?=
 =?utf-8?B?MVMyWVNWcmd0UzUwa3VCbGxpNG5UOURnQmhMMGZGb1VlNlVZU3JsYVVadVp6?=
 =?utf-8?B?allHSWpsUkp4K0owak9reXBFeGptN1FubUhNUW5weEdXbEJqS1dZYzZKRWVj?=
 =?utf-8?B?eDJWTFJRTUtpTnJVR3Vrd2MxWmw5R0xQVkJjeGozdHFNdzVwL0dIcVZtbFlr?=
 =?utf-8?B?dE1TMmJyUy9XbnpoTXdRdmRmbCt0bkxDZEh1aGt6YWRpRHVFOHRPSjBYSy9Z?=
 =?utf-8?B?Yy9xcDJlRStjcnhZcUkxaHJOUit6UDIzUGNtejlkdGFmdHNuZ3ZYb1F4Mjd4?=
 =?utf-8?B?c3ZUVVI0NzZ1OFVQR1dDdTdoQldpcFV0Vk1FdFZzUjVTVVJQaWhJVWJ3TUJC?=
 =?utf-8?B?bDNxN0Q1QTBsOTR1ajFsRnJZT1NtcWhyMGFvbmNLQ3g5dm5Bcm9zdlZEWE9L?=
 =?utf-8?B?TEd6QU0vOWVaZ3J1OCtPdnRIR2kxaStPRXcrQ0M2bWtoa2Roc2VEVUpZVDMx?=
 =?utf-8?B?OElEbEJDa2dGTDJPbUxEcnNWMCtIMVlHK0x6V0dsQ082YnIrcnJzRUJWK3NT?=
 =?utf-8?B?OTBScUZlMkR5SzE2ZlBOdHkvUEUwcUVmaSt6ajBERVMxZEJySXU4Q2N6UjMw?=
 =?utf-8?B?U3dNeEt1WWg4MmFkSStZcy9zRkI4NnNpMVNSbkVtMTFrUXIwQ1kzM2gvaDl2?=
 =?utf-8?B?b2lGYitZNG04Y09TcURCb2x6SnRkL2pjTE5ZR01QNk0rdmdsRDkvY2sxU2h4?=
 =?utf-8?B?ZkV5dTlvSU1aL0F5aGFOaXh0bXJKRDhhMnVwZDFkK2xpNGx3WjhzbFBGbEhT?=
 =?utf-8?B?ajBMYmRxa2Z1RkltSnRMSGg1YWF0bjBDaml5cmdkd2FPdzkrcDIyajRvQ1ha?=
 =?utf-8?Q?ygZV5hQqD06Q40JPLRVl4PU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c236de3a-b75b-44a6-04bb-08d9e714ab06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 12:57:00.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRA07W65Qo+BNY5yVc8ZB0WB4S/dJprHCj7SRNVfDNDsgcKmOHrxxOFeJg8mmsqEzwjdNmLHJ6hezGKWSdARkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030080
X-Proofpoint-GUID: E1aq6FUXtVVntlohSSyQMXacH7_iF7IS
X-Proofpoint-ORIG-GUID: E1aq6FUXtVVntlohSSyQMXacH7_iF7IS
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 02/02/2022 01:06, David Sterba wrote:
> On Sun, Jan 30, 2022 at 12:24:15AM +0800, Anand Jain wrote:
>> On 27/01/2022 00:53, David Sterba wrote:
>>> On Tue, Jan 18, 2022 at 11:18:01PM +0800, Anand Jain wrote:
>>>> +/*
>>>> + * Device class types arranged by their IO latency from low to high.
>>>> + */
>>>> +enum btrfs_dev_types {
>>>> +	BTRFS_DEV_TYPE_MEM = 1,
>>>> +	BTRFS_DEV_TYPE_NONROT,
>>>> +	BTRFS_DEV_TYPE_ROT,
>>>> +	BTRFS_DEV_TYPE_ZONED,
>>>
>>> I think this should be separate, in one list define all sensible device
>>> types and then add arrays sorted by latency, or other factors.
>>>
>>> The zoned devices are mostly HDD but ther are also SSD-like using ZNS,
>>> so that can't be both under BTRFS_DEV_TYPE_ZONED and behind
>>> BTRFS_DEV_TYPE_ROT as if it had worse latency.
>>
>> I still do not have a complete idea of its implantation using an array.
>> Do you mean something like as below,
>>
>> enum btrfs_dev_types {
>> 	::
>> };
>>
>> struct btrfs_dev_type {
>> 	enum btrfs_dev_types dev_type;
>> 	int priority_latency;
>> };
> 
> 	enum btrfs_dev_types {
> 		BTRFS_DEV_TYPE_HDD,
> 		BTRFS_DEV_TYPE_SSD,
> 		BTRFS_DEV_TYPE_NVME,
> 		BTRFS_DEV_TYPE_ZONED_HDD,
> 		BTRFS_DEV_TYPE_ZONED_ZNS,
> 	};
> 
> 	enum btrfs_dev_types btrfs_devices_by_latency[] = {
> 		BTRFS_DEV_TYPE_NVME,
> 		BTRFS_DEV_TYPE_SSD,
> 		BTRFS_DEV_TYPE_ZONED_ZNS,
> 		BTRFS_DEV_TYPE_HDD,
> 		BTRFS_DEV_TYPE_ZONED_HDD,
> 	};
> 

  Ah. It is a cleaner way. Thanks.

> 	enum btrfs_dev_types btrfs_devices_by_capacity[] = {
> 		BTRFS_DEV_TYPE_ZONED_HDD,
> 		BTRFS_DEV_TYPE_HDD,
> 		BTRFS_DEV_TYPE_SSD,
> 		BTRFS_DEV_TYPE_ZONED_ZNS,
> 		BTRFS_DEV_TYPE_NVME,
> 	};
> 
 >
> Then if the chunk allocator has a selected policy (here by latency and
> by capacity), it would use the list as additional sorting criteria.

> Optimizing for latency: device 1 (SSD) vs device 2 (NVME), pick NVME
> even if device 1 would be otherwise picked due to the capacity criteria
> (as we have it now).

  Hmm. Above, btrfs_devices_by_capacity[] contains device types
  (not device itself).
  Do you mean the btrfs_devices_by_capacity[]  used as the device-type
  priority list. And, then to sort the devices by the capacity in that
  type?

>> I think we can identify a ZNS and set its relative latency to a value
>> lower (better) than rotational.
> 
> The device classes are general I don't mean to measure the latecy
> exactly, it's usually typical for the whole class and eg. NVME is
> considered better than SSD and SSD better than HDD.
> 

  Got it.

>>> I'm not sure how much we should try to guess the device types, the ones
>>> you have so far are almost all we can get without peeking too much into
>>> the devices/queues internals.
>>
>> Agree.
>>
>>> Also here's the terminology question if we should still consider
>>> rotational device status as the main criteria, because then SSD, NVMe,
>>> RAM-backed are all non-rotational but with different latency
>>> characteristics.
>>
>> Right. The expected performance also depends on the interconnect type
>> which is undetectable.
>>
>> IMO we shouldn't worry about the non-rational's interconnect types
>> (M2/PCIe/NVMe/SATA/SAS) even though they have different performances.
> 
> Yeah, that's why I'd stay just with the general storage type, not the
> type of connection.
> 

  Hmm. We might have challenges to distinguish between SSD and NVME.
  Both are non-rotational. They differ by interface type. Unless we read
  the class name from the
     struct block_device::struct device bd_device::class
  that may be considered as a dirty hack.

>> Because some of these interconnects are compatible with each-other
>> medium might change its interconnect during the lifecycle of the data.
>>
>> Then left with are the types of mediums- rotational, non-rotational and
>> zoned which, we can identify safely.
>>
>> Use-cases plan to mix these types of mediums to achieve the
>> cost-per-byte advantage. As of now, I think our target can be to help these
>> kind of planned mixing.
>>
>>>> +};
>>>> +
>>>>    struct btrfs_zoned_device_info;
>>>>    
>>>>    struct btrfs_device {
>>>> @@ -101,9 +111,16 @@ struct btrfs_device {
>>>>    
>>>>    	/* optimal io width for this device */
>>>>    	u32 io_width;
>>>> -	/* type and info about this device */
>>>> +
>>>> +	/* Type and info about this device, on-disk (currently unused) */
>>>>    	u64 type;
>>>>    
>>>> +	/*
>>>> +	 * Device type (in memory only) at some point, merge to the on-disk
>>>> +	 * member 'type' above.
>>>> +	 */
>>>> +	enum btrfs_dev_types dev_type;
>>>
>>> So at some point this is planned to be user configurable? We should be
>>> always able to detect the device type at mount type so I wonder if this
>>> needs to be stored on disk.
>>
>> I didn't find any planned configs (white papers) discussing the
>> advantages of mixing non-rotational drives with different interconnect
>> types. If any then, we may have to provide the manual configuration.
>> (If the mixing is across the medium types like non-rotational with
>> either zoned or HDD, then the users don't have to configure as we can
>> optimize the allocation automatically for performance.)
>>
>> Also, hot cache device or device grouping (when implemented) need the
>> user to configure.
>>
>> And so maybe part of in-memory 'dev_type' would be in-sync with on-disk
>> 'type' at some point. IMO.
> 
> Yeah, the tentative plan for such features is to first make it in-memory
> only so we can test it without also defining the permanent on-disk
> format. From user perspective if there's a reasonable auto-tuning
> behaviour without a need for configuration then it should be
> implemented. Once we start adding knobs for various storage types and
> what should be stored where, it's a beginning of chaos.

Yep. Thanks.

Anand
