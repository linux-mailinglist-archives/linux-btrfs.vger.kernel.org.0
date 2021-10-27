Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9A43C3AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhJ0HUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:20:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhJ0HUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:20:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R6YRZx014961;
        Wed, 27 Oct 2021 07:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EGNLvZSwWwD3VIPwzLtOF0sgqnvRJtO52+WLcExjZZA=;
 b=ex836mHjpQiKh0VQ+S9FJzc+INtZ4JDGBMf11JUKTZ7FLGUnwt2kfNVMJ8THJs8kIKs3
 8SQ2LQpp2eOnmODPQXPROC7UT+gJwk5KdBGtoXgL38X1PKeu2s99Aul1mW+ffAicsEW3
 wPJ1UIASngR1lxOD5BCnJbrihEP/fqOQzev6cvt4z0MEU6+bB84b7cZPHFn1LgqxDlZt
 N+dswZVa6+mP2xyFqAjwY+f28Krx/9mgwaWQcQrtsFjS8Y9c9shweKDasFe4AGTYxyS9
 V/ekgdpdB7k+uX4AwVisvzuAar7eNYOeDGXQbg0sxAwlzG8kAxdmO8X3iKU1QrPg5QfG FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fj16tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 07:18:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19R7G0du131196;
        Wed, 27 Oct 2021 07:17:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3bx4h1xdww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 07:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQq88B4Wrl4h7dLpzNaZyaoRO3TaAUhXucsCJeci/lB/xviIEe/Ahg6XnVEWklxCU3NHoenWJEf/+ZMQxfOFXVBkVZYZ7Gr04Zj7OIl6vTRXxgqNsoxkw2IrFX2rpmvzWwJOvfJJ16HZ5QqlPDToup0CQF85EgIrjgUFMwYiYHYBJOnlw0izB4CFy1CZ2OmWEZsUVTICLz2YU1oCcTBdJ1hTFF7XrYmQDcqD+qt6JBj19FXhROk9ppDxXLUibODBIOAWfBel8hALEBhaVP5mf/JnTtbgjaJ2GAhQ/nPb1uzKyTliWWmBWfPzG4UttzLLnQsHNM0DpycIks8kV0QvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGNLvZSwWwD3VIPwzLtOF0sgqnvRJtO52+WLcExjZZA=;
 b=a1rTwU9QiFCe6rNWtm6oQDhPEacmCPuHuyT1mBrBWKiH+kPENduthL3PlgWtUukhFMwoENgFJFLg9mRLjWUTHulHqtCJnOnjAtJSfpRgCG6I4YgDAPSqbiLDhpGZYRyMvHQremjb8TEkC0mWp5CX7HT7gptD/Unw217Ok0d/o0ypqwOTl5RMs4Wasr4+Tw4NpHt/k861BGl9ci7bHRfeTXsEvNJiWTEXIH5Jx9/mvwAlGHleyQ2snersq+HHJ6AtTqOEh0yYEn2DuCIa2NkhuCwIBImbk0L6l+NKkcZ1H+svPv6MJAh1+vOmsR6rp/IVdhmdMMvfq9reqrm8HCSmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGNLvZSwWwD3VIPwzLtOF0sgqnvRJtO52+WLcExjZZA=;
 b=CfFKhwq2AZce2Ve2lxQogElcGCygCPuzBSbM9x1346H4wvxKSttig3s7/1E6twslNRBxMBmrajy3oJpHosJtNtjjy1Z1QwXzZlSY44/LyRMypwqJiItz7qWHXFANRwd8G+QgDYNnYobqcH0NI2Y/cpgSbNekb/i4LKFPjeYGDM8=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4963.namprd10.prod.outlook.com (2603:10b6:208:326::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 07:17:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 07:17:55 +0000
Message-ID: <72708fe4-5886-8814-f5e2-3c1dbf523965@oracle.com>
Date:   Wed, 27 Oct 2021 15:17:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com, nborisov@suse.com
References: <20211022145336.29711-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211022145336.29711-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 27 Oct 2021 07:17:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd80dec5-4ea0-44da-cd4a-08d99919e57b
X-MS-TrafficTypeDiagnostic: BLAPR10MB4963:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49631530784F83731E6E50B3E5859@BLAPR10MB4963.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFqr7BfYwcvI0u6dN/2dD0pdNZbe9zmwrdvPPdKLGXPITFGm3ch7VJjY3CRAMoEg8d5bVUZIDl6Y7MqSkSc12VY1HYkQz5zYNg/DWcJqFon/lzxytUiBVjNKJLsdFt1HyHlgfpRaURDtVxyYXJds/gLiY1uabzGzq/Ysozrk8UZaIlIrpETe2berZAW+cScvCDXOtFOhNeT00oOYJuvF7sothPiLq/z/BZ6+UwqLUSBRH/LLXtXKwecbBx4SKo+kk99BKux9JGD4SLy22XeR5diNbIGkAdIOX4XR4oO82i0H0wJfMMTqQ1Dk9fQ3dSbcGk4LStA2caeHFDOzpj69n4+PRmUue1LBMbnK5g/ozNl5fVTgc4wHRv5N6D4YwIhqAcwY5lAHy20y/iFHnar1cT4kNjWiCiPQsUYaaaGbpzDynjSZBvbxn5oY1/2Oxw782IbLTfNYoCjdig+m+JAEoXbKv2KREzq2gfmAuT3X9sJF5mNwodEgxmGuyN3+/SLK8JUYxmYGYpK3z/wEHh28hdYj5DWGaQYFhkyKYVfvCBCjJz733BZQdL0TJ8Pd3eSOs+mmWDP7CAM9hT0K/EsbwjRsXaYU2QlDJWrLyJKYLsDjroMZ+0liK2uZW+/kTzV1B9jk0KJyuw4fDhDG9KTrZZelXKxS0oiFXqeE6SHfkOWCjRHIlasCxMITMEi6PAiyra65jG6jycRRebg/74Pw3/1ElLGT1qjyOvJ3DXGMZVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(186003)(66556008)(66476007)(66946007)(86362001)(53546011)(508600001)(36756003)(2906002)(16576012)(31696002)(8676002)(5660300002)(956004)(316002)(38100700002)(4326008)(2616005)(31686004)(6666004)(44832011)(26005)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZ0MWV2bFRwV2EzS1dBMmt4TkI3L09XNDhwZ3gzb0F0MXpDM1dsU29EQ3pU?=
 =?utf-8?B?Qi9uOW5nZk9TOGFVZ0NsL01GSnlnUXcvRkxWZi8vTll0eDBwelRnVThyc0VI?=
 =?utf-8?B?dmRwQ1BvdGJRMEFWOGY2NTZRR2dicjhFbk1YTVZYQWVTSFhhdXovTStHZGZE?=
 =?utf-8?B?ZURUbGg1SVZpbzJxZk9EUlIxN2Q5c3lFM2ZORU5RTkpLTHlxVXN6Vm04cFVV?=
 =?utf-8?B?WmV2WlVFQ3F4Vlh5T21ZWHNCcVpaVjZHeDcvdFZJaTZBdGJFTC9ubVo4TnEw?=
 =?utf-8?B?VHBqRE9JRW0wR3o0NkQyVExuRFNuRGtZQzh1WXRhVXRVZDRYYXc4SUErT2w4?=
 =?utf-8?B?ejlwbVhEaXZLZ0ZhaUdVWTlneVd0a3RuTmRPVUY2aWFVd3AxQkZ5ZFJraXNa?=
 =?utf-8?B?UmUzNG1Fbk94MDZvdlc2eTZ2dEJRWWEzSjQ3dGtrVDJOYkpDMUM5WEVYT1ZV?=
 =?utf-8?B?RlF2RjF2THNrVlBKa3ZiSitmUmdqa3RNQnZOekQ1QWVNQ2dyRHZRaFpVSnRC?=
 =?utf-8?B?bHNFN0ZCQmEzNzcrbE9VRXZvb3krYkE2YkxnSGNQemFsbFJBYUNtOVFQdjY3?=
 =?utf-8?B?M0dzeEtnUW9IT2Nsb1FQMUlOTlZxanl5eFJCaUVGME5DT2hxbnpLQU9abFlD?=
 =?utf-8?B?WWoyL1JYeVFjT29NRWpXRVdTQUxVUGJzWGY3KzdhaG9PWUFxMm4zTHI4USsr?=
 =?utf-8?B?a1dSdkJlRG5YRjFva2prRHBrSjVQdFhmOWcrb0dWejFKamp0elhDOVpQa0Jw?=
 =?utf-8?B?c0pjbE1KK3VnNEtpTHAyeGxneXBNTHlYM3JidDhYanpTQ29iMHdEdDBaeXY5?=
 =?utf-8?B?N2lxMXZLbHFmVXNsQWgyZDZ2eWJlZWIvV0NseHZ0bXc5VnJvWklmR3JEYTVP?=
 =?utf-8?B?L055d01GZnNOWXlmb1VHRDlhUmZTaEtRWWVzMTZiZDBhQmU4R0NKenNzeTNP?=
 =?utf-8?B?VmpQaWFBYXNSdDVjY3NaaTk4MlBoU0hvOGwrbmV2SEtEZ0J5cys0cDE0d09W?=
 =?utf-8?B?UXY1MFpWYXAvYytJUjNOWE93YkovRWl0dVNmbXZRaWZSS0VXc1h4djBZQnRi?=
 =?utf-8?B?TXJiNUN0UFhJZ0pNQ2tOTFJiWEF2M1RkdlVXM00zMUliWm13eUQwbVRxbEtk?=
 =?utf-8?B?U2RpUnFLc2ZSME1Vd0JZVkRGaXJzTGhjcnRaZkFMZ0VGRjNaaE1MUktVdElw?=
 =?utf-8?B?TUhaamJPNUp0TThRQS8wU3E5M09FRkJ4cVRDVlFvQ0xCOUdIR05rcFNYSno4?=
 =?utf-8?B?MW1MSGxrSjJFNEcxcEZXcStpcjhhM3Q0QVJsdDRZb0FXL2ZpMEQvVmxoMWZS?=
 =?utf-8?B?RVhzUVQzZTJCNThGamZESzh1SCtTQmNWdDVCcHE5S0k1djhuanJhSzd6NWdT?=
 =?utf-8?B?aGxPQXZPVk9jb3hNMUNRTGZpUEhTejR0UmdnWjdVMTdBNkcwb3E3MUtNWlRq?=
 =?utf-8?B?RStNWEFIbVVmTmRuNm14VW0yVXRhcGNsSXE3aHVtam9kVy9ITW1EOHcwK3hy?=
 =?utf-8?B?TWl0Y2tRMWhqL2FyNVhlalh2QXBRRlNDZTErRnhLZExUNlErYUtkNjY1Lytk?=
 =?utf-8?B?aVFUSjJwalU4bUNHVDZBekd3VmRnRnUzaGxhU0EwSEZ1ZlJjNXVUb0o2YjVC?=
 =?utf-8?B?SWNQUW03QlVHajBvenpCc2NNc1BCak5FRGNQSmlEMWd6MlVKcFYwZkh0Tkd4?=
 =?utf-8?B?TkdEYWM4TWNpL2JFMEQ0ODZvaTRnaGhJbjc1QWVQaVgzT3BsNHozUk5iRnRV?=
 =?utf-8?B?Z2Vrck14cTh5VVNVcUJyNXJ1RGtTZlZBcWxkQi9ZTVBsQ090V3VaSzVhRUhX?=
 =?utf-8?B?SDRsZWgzaWxNYVNlQ0tPTDNoamF1YzlYZnlCTzZacnU2aFJMWXEwanFEM0F1?=
 =?utf-8?B?b1U0Y1VnM1NYdzFwZ0VjSmFwZXQrdWg0R3gyaEZOU0pteTBxdEFBQXptSWlX?=
 =?utf-8?B?MTl0TDlrL1c5a3k5RU9VeGR1a0VHZy84L09WV2xSLzdzWXV6WXljNEpjTjB1?=
 =?utf-8?B?U0p2T2t6MHVwcGNDNFhDRms0N2lkKzN3d1V3a1hkR0FPOGYxaS9paWJMSkR4?=
 =?utf-8?B?NVFvam1HVzZOd25vUEdkSGx3d1kyenhBbnE3bmNwVEtZS2xtRzl1THBJWjN1?=
 =?utf-8?B?WlhkYlZ5WWg3UlFRdjJ5ZEp0b2g5VkFick1jRTRjMVZ1QXk1SzBnNExSQ09O?=
 =?utf-8?Q?DTQ1lPsO+1NafsweSWDs5eY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd80dec5-4ea0-44da-cd4a-08d99919e57b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 07:17:55.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uIOKngX3IXbatOjA5m4b8AfsQyixxDM6YkATy23yt3c7qieTcmGDcG6F49HWmOtY/xZgPiuy5yZ+cFtNeR0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4963
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10149 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270043
X-Proofpoint-GUID: -ag5ZY8n5cAVUUbJa_da-5guZbiSrlli
X-Proofpoint-ORIG-GUID: -ag5ZY8n5cAVUUbJa_da-5guZbiSrlli
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/10/2021 22:53, David Sterba wrote:
> This is the infrastructure part only, without any new updates, thus safe
> to be applied now and all other changes built on top of it, unless there
> are further comments.
> 
> ---
> 
> This is preparatory work for send protocol update to version 2 and
> higher.
> 
> We have many pending protocol update requests but still don't have the
> basic protocol rev in place, the first thing that must happen is to do
> the actual versioning support.
> 
> The protocol version is u32 and is a new member in the send ioctl
> struct. Validity of the version field is backed by a new flag bit. Old
> kernels would fail when a higher version is requested. Version protocol
> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
> that's also exported in sysfs.
> 
> The version is still unchanged and will be increased once we have new
> incompatible commands or stream updates.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/send.c            | 22 ++++++++++++++++++++++
>   fs/btrfs/send.h            |  7 +++++++
>   include/uapi/linux/btrfs.h | 12 ++++++++++--
>   3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index afdcbe7844e0..28a26980245d 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -84,6 +84,8 @@ struct send_ctx {
>   	u64 total_send_size;
>   	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
>   	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
> +	/* Protocol version compatibility requested */
> +	u32 proto;
>   
>   	struct btrfs_root *send_root;
>   	struct btrfs_root *parent_root;
> @@ -312,6 +314,15 @@ static void inconsistent_snapshot_error(struct send_ctx *sctx,
>   		   sctx->parent_root->root_key.objectid : 0));
>   }
>   
> +static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
> +{
> +	switch (sctx->proto) {
> +	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> +	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> +	default: return false;
> +	}
> +}
> +
>   static int is_waiting_for_move(struct send_ctx *sctx, u64 ino);
>   
>   static struct waiting_dir_move *
> @@ -7269,6 +7280,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>   
>   	sctx->flags = arg->flags;
>   
> +	if (arg->flags & BTRFS_SEND_FLAG_VERSION) {
> +		if (arg->version > BTRFS_SEND_STREAM_VERSION) {
> +			ret = -EPROTO;
> +			goto out;
> +		}
> +		/* Zero means "use the highest version" */
> +		sctx->proto = arg->version ?: BTRFS_SEND_STREAM_VERSION;
> +	} else {
> +		sctx->proto = 1;
> +	}
> +
>   	sctx->send_filp = fget(arg->send_fd);
>   	if (!sctx->send_filp) {
>   		ret = -EBADF;
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index de91488b7cd0..23bcefc84e49 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -48,6 +48,7 @@ struct btrfs_tlv_header {
>   enum btrfs_send_cmd {
>   	BTRFS_SEND_C_UNSPEC,
>   
> +	/* Version 1 */
>   	BTRFS_SEND_C_SUBVOL,
>   	BTRFS_SEND_C_SNAPSHOT,
>   
> @@ -76,6 +77,12 @@ enum btrfs_send_cmd {
>   
>   	BTRFS_SEND_C_END,
>   	BTRFS_SEND_C_UPDATE_EXTENT,
> +	__BTRFS_SEND_C_MAX_V1,
> +
> +	/* Version 2 */
> +	__BTRFS_SEND_C_MAX_V2,
> +

  Isn't this has to be in tandem with BTRFS_SEND_STREAM_VERSION == 2?

  The changelog doesn't explain the plan of __BTRFS_SEND_C_MAX_Vx use case.

Thanks, Anand


> +	/* End */
>   	__BTRFS_SEND_C_MAX,
>   };
>   #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d7d3cfead056..c1a665d87f61 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -771,10 +771,16 @@ struct btrfs_ioctl_received_subvol_args {
>    */
>   #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
>   
> +/*
> + * Read the protocol version in the structure
> + */
> +#define BTRFS_SEND_FLAG_VERSION			0x8
> +
>   #define BTRFS_SEND_FLAG_MASK \
>   	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
>   	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
> -	 BTRFS_SEND_FLAG_OMIT_END_CMD)
> +	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
> +	 BTRFS_SEND_FLAG_VERSION)
>   
>   struct btrfs_ioctl_send_args {
>   	__s64 send_fd;			/* in */
> @@ -782,7 +788,9 @@ struct btrfs_ioctl_send_args {
>   	__u64 __user *clone_sources;	/* in */
>   	__u64 parent_root;		/* in */
>   	__u64 flags;			/* in */
> -	__u64 reserved[4];		/* in */
> +	__u32 version;			/* in */
> +	__u32 reserved32;
> +	__u64 reserved[3];		/* in */
>   };
>   
>   /*
> 

