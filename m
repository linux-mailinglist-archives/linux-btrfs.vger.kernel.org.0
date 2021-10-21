Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D471D4367B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhJUQ3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:29:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32034 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231889AbhJUQ3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:29:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFHw9H019370;
        Thu, 21 Oct 2021 16:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=74dda+9ztNIvwbyFok556UAiyeBuPJjOR7lrxUVjo8g=;
 b=tQlcDmLMKVr3n2zSmkG8ZnEGiju7IONfPjTqWIg4Ixeio9LocMz/82R4WTfYQBfNVLVz
 jHl1nvAcURogaH7gMpALEblXC6K11NdT0J7qgyJfWo1iUmcN3B1R8uHwqSLR+clz1J55
 H921lMCqyoOJfEJ/a5a7riHDCFS7YaTQoCNz2TbVackNIvN/MKNJ6NdyXgMey8Is2hxg
 OXzBwFx2SyR8R6rKdrWJClcKz11mU/6y3V45fLVlPC20dtPLQAfz5OPA57gHjUxzWJYo
 bXg/E6VuckhQhdWwiGzzlgBukB5A4IOvHxyHVVIGLkmEc5wzo6Bh9AnVYvy5Idk8fRSP Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btrfm5x7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:27:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LGLeqF080932;
        Thu, 21 Oct 2021 16:27:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3bqkv26ja8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzBjyXcJD4Prv94RdUjCZa0TArh6ayL1z+ZKhh4k7RY0CXolmimbMtMrBqVs4dYm0aKMTl1rPsmL/yQcD9OQRILJ2Le+zXN2I0ivGFBhWw5j+Y8LKiNOKFM7oOzpGg0WqWBv9SDsiLTlb7KQZqxX8Uy5VoHqda9HcTIrNSzUzhUL1ljDeefxRBoPg2z2VkOQBpVXG051e6i+h/RMvInGs3KCl0htTw+dbXViY7cuA9Olxv9qtNVrsT2nuXKruE1g7O9FJ/PDxSe2yePukXHNo/9kIO5x2JialbX25hRO1nQpIWXZSzmPaxbnzAvdp/Zp3jPHyqXXVFRg1Vbtpfsrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74dda+9ztNIvwbyFok556UAiyeBuPJjOR7lrxUVjo8g=;
 b=e31SYs8b/AeXH3werrAiSvYKJo6INgMImS2JjVA2DJ5ULjvSNrkGpQJYPngTtxep7v+kK8HNTjUhxp6EVMUVyf2tP25R0JNhxndfATI4X+9hnnSuRI3I/CHf9nyaH9zhqZjBEynT2sVFO8+AkM3zZQZh4vsEnClI2QrBVz8ptShqsmOScqLOR3tHzEKgiH8MRK574Cx15UYG2Kq4IYDqUT1UCSc1PuEsddsesPMGdKB8Do0eBrv5VX9evirsX+7b/4PTRkehkwALLrzfmsExTV/Ssg/UgFRHLZkFo6fhFQyc2XLoD9DTWB/lxxgPlhEfmyk00DHK50DV5jF00D3jYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74dda+9ztNIvwbyFok556UAiyeBuPJjOR7lrxUVjo8g=;
 b=BejBJ/8agoTb3ysn7Mb3ZhHGj5uskkV2C+lQ71jgVfHKdkNU+VzbW9n50mRIy9nAu3rXFmoEb0QZ97fb2ZjlqS8FE4JpDmhFvhDeEpRCnDhy7rr5AwNG26VhYHkOCkPHNuQKkr2+/obygKMDAO4g7IPiTWSuSKHZyuluqNj1BjY=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 16:27:21 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:27:21 +0000
Message-ID: <3898e0fb-8539-c165-ae7a-90bf2be44435@oracle.com>
Date:   Fri, 22 Oct 2021 00:27:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] btrfs: sysfs convert scnprintf and snprintf to use
 sysfs_emit
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <8ff89162573399dec6ce5431243e4b45ec2fc4f0.1634829757.git.anand.jain@oracle.com>
 <20211021161939.GE20319@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211021161939.GE20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:27:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba557c5-2007-4110-9e98-08d994afa83c
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:
X-Microsoft-Antispam-PRVS: <BL0PR10MB34258A42496D687707FDFD66E5BF9@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKXES21eKuthtt397si1FW0cXUmaS7iX9zWaFLlLPLGeMCPFzV3ovFns8Uy9xTSlkceTjCR5V4roSaQZ20wnj9Nt/nECr6B60mPN7tmTBL0sBQ0vQ5weK0rKf9tBnP1dA9qkKhQRht0kbHkLISHaCGz8itedG8QiuFoCDtRtc9NXInT0mf0j9DA770szO1kjm3i6eZF77kwKmM2wSoXMbwxX8Ooq+KlvxRqL/6mXu9p7Rsb6z6dXLXFWaD5ub9q3Ifh5/nedl1YWtAdZeDEVM8KLRcNR4cXRtAYOEEMyus/YOdEiWRmfh8l1/H9aiS8UQEDqZg4DAd9NUfpRODrEUMM7DqymZm4oIxdp1SuSepuew72hIeJyit4IU7/T1G5hi5hhACc117flO8eg6fRRIzv5BPDTyEhKpTXkwb9rFzAreABsbGsCyM8t4TEdl5fntPdfHZ6vUPKX3f44sIGD3MuYMJpZqG4fsbnoHEeVE9wcl+hB/8kavpE7074lc09IfkTm+iRWOhI5PTyZ5zyBp0TsNLTxo9EDTUf8ukYiNytk0I9DBMeYnkV/R5Hjl0cFEKgIIHABSBXNDpcLjjmCoyJjqRVU50T1tuR3570yk5qf+ksWP25o6ewOcqGc9UH1gFA1KG6VkKm0YT7cdzxMToJw9GZCB+IXm33L1h1dBRuv4nqDqVAVqvSyiOA9uTX22k5t9dVqQNDDc7AkDCpJhmY8XChztoQvaDxVJ5FhrRaDVPED9pLVbhE7RlBJHnWK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(16576012)(53546011)(956004)(316002)(36756003)(26005)(5660300002)(6916009)(31696002)(8676002)(6486002)(44832011)(31686004)(508600001)(6666004)(83380400001)(8936002)(38100700002)(2906002)(86362001)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05vOHBueVFESW5JeXh5bVBPZGlTMm9QNVZuWGhNV0M2VWV4bEh3cnJIS3JL?=
 =?utf-8?B?UCtNTEl3WGk4MSs1VW1iVWFRQkg0dVBJTHd3bmkxbGg2clVkRUFHVmtHVGdp?=
 =?utf-8?B?aUpDWnlTMXBobzZURTdnQ1N3Zis0RGhZeGs2eWNmcGNVTXBHd09HTEJueU1Z?=
 =?utf-8?B?Qkd6T044Q09NRkRlTDdYeUI1cndQMFoxZVRSZEp1dEJ3NFNyakxmbFlXMVM0?=
 =?utf-8?B?RTc0WU5reGd3TmlFZWJTMWo0YnRibGd1eERQZ2t6QlEvMXZSTU1XWnF1clJM?=
 =?utf-8?B?dWtFeVF3QlQ5c3hnVGxNcU5VOFFOTCtSOVMrcHp5SXBGaDAvTzN3dkV3SnZk?=
 =?utf-8?B?T0tNSjNPdlFRT2FuNk00OGRybUtwWHkyVEdNbUJCYkJFQmRZSTNwQ0wxN1BL?=
 =?utf-8?B?RW5iZyt6Z2lVa0J3dHZBdW83aGhQbGRHQlF4dDlrS1FhZkxodHUwaU9rOEJl?=
 =?utf-8?B?eVVDeWdaRnpmWVhpRnUxNDBjMDN6bC9XT09jdTc4NitvYkR6ZStia09BblNx?=
 =?utf-8?B?bUNyQU5VSzlaT1NWVjJBMVE1NjFLNmdMTFVkUDFNajdubW82b1ZqZWhGb3g5?=
 =?utf-8?B?bnp2bnZ0WHh2RVkzSjVJc0FlcVdCU0FnbVhudHhPZmphMHNNd1lWTWNkSnM3?=
 =?utf-8?B?SmFxQUhDNE1Fb0ozbGdIYSszajVhdGpIRm9jQ25YekhqLzBhNEFCTDBqNG4r?=
 =?utf-8?B?MWV1SmVSWU5KRWw2YW5FcndBalVOSzh1d2JiU0RhcGZ0K2dSTjdyanloSUVz?=
 =?utf-8?B?blcyK0Z3djJEKzA1S0xMemhwRG0vc1hXaWk5dU8wQnFhKzkxOWo4M0lmdDBG?=
 =?utf-8?B?S0s2RDArSmRROURsT3E1OFExMkZrejNDVTd4OHNVbjZ5cjUrT01oMVN1TzF5?=
 =?utf-8?B?QVVsY0ZHdXJjeVdwbS9BbGZQL0ttNkRLbVZyZFJlaEhtOThoZ2RKaklVTkti?=
 =?utf-8?B?ekZOMDg5R210OGdWOG5BQ0FxQ1FrdFBXRDh0NnV3d25GRmpFbVI1R1BhK0Rs?=
 =?utf-8?B?M3NmaW1YRmJzVFd0T2tRMXVHV09MMy85ZXVTeEsveFpER0RrbU92bUdRc0pt?=
 =?utf-8?B?TWpxbFVXU1ZXRzRndVYrM1I2UHE2OUxGNnIzTStnYlhzaFkzcHhXK1M2d3BF?=
 =?utf-8?B?ejZCMVRVUm83RFRQODJXcnRGdHFOS1gvYzE2ZzNsVGZBdHhCdU5KeXdoTC9z?=
 =?utf-8?B?WHdVTVZUdGJubmUraUhCU2R2Z2FNOUJNNkVLT2tNWDVQVFdGTUsxOVlGb3Fz?=
 =?utf-8?B?T1lIQkhJaEQwYWh3anBsU1lqOEd0RVR4RFB5dFRSZDdFNkpvVXc4eCttMTVq?=
 =?utf-8?B?bVVsT3JyNmFBUkptT1QwOWpDR2w4QkZhWGVGeGh2UmFlUFBmcks2b3JLdkkr?=
 =?utf-8?B?aDRjRk9mMS8wYThZQnZDMXRpckk2MHBjeUdOb3FESmdIRGY5aTd5R2ozdmkw?=
 =?utf-8?B?Z3ZFM2hxdHBLbWtyNHpKN0Y5NWcxLzhTOStEWVZMaEtuUFdIZEZVS0NrVzlI?=
 =?utf-8?B?aDg0Qjd5L245TTczLzU1dUxDM0Q3bVdQRVdhOWVyaERFRHpmYVhwcTBYK0s1?=
 =?utf-8?B?N3NMMCsxNGRNckpXaCtJWThZeVZ4eG44Q3lrV2wycGNNWmkxZEcxWnltb1p5?=
 =?utf-8?B?RHhiR1BiTkN4SG1mb1FoQ3prZW5ZS08xMjlzaDg0RTBOVjJJQzBWK3J5RmZn?=
 =?utf-8?B?dzZncHhRb3BQNnpvNHFnaVpZZVpkdEpYc1E1TVpoakVscHlFaVRHVVBWdFRC?=
 =?utf-8?B?OXdxS1k4TXhpc2JxZmtOSklVeC9GTDVqSGtmbGtpN0s0QVBYWHUxZmc2R1Mz?=
 =?utf-8?B?TlE4ZlpuRGt0Rkw1T2Y3bVNITjhCV252b1dvdHNnVnJQTEkyZnhVMGFsREhk?=
 =?utf-8?B?OGJTUUJJSXlyM3JBUDBxVkR3d0FpdE9CYkNPZlREZ2Rka1pKTjFCTS92bUMz?=
 =?utf-8?Q?q78TmFn9LBRTJj4LOmuE17yh0VN9gKC4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba557c5-2007-4110-9e98-08d994afa83c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:27:21.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210083
X-Proofpoint-GUID: p2CsNG5hABIS1dLH8xkpdXAdbZc1fnhf
X-Proofpoint-ORIG-GUID: p2CsNG5hABIS1dLH8xkpdXAdbZc1fnhf
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/10/2021 00:19, David Sterba wrote:
> On Thu, Oct 21, 2021 at 11:31:16PM +0800, Anand Jain wrote:
>> commit 2efc459d06f1 (sysfs: Add sysfs_emit and sysfs_emit_at to format
>> sysfs out)
> 
> Please use the common formatting which is 2efc459d06f1 ("sysfs: Add
> sysfs_emit and sysfs_emit_at to format sysfs output") in this case.
> 

  Err. My bad. You told me that before. But, for some reason the related
  config isn't working. So I am doing it manually. I am going to try
  the config again.


>> merged in 5.10 introduced two new functions sysfs_emit() and
>> sysfs_emit_at() which are aware of the PAGE_SIZE max_limit of the buf.
>>
>> Use the above two new functions instead of scnprintf() and snprintf()
>> in various sysfs show().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> Reported-by should be used only for when the patch is fixing something
> based on that report.

  Right. Ok.

> 
> I've applied the patch over the local version 1 but I don't see any
> fix related to the the crash report, is that correct?

  Right. There is no crash report for the v1.

Thanks, Anand


> 
