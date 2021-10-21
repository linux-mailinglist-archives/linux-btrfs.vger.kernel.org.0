Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779644367BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUQad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:30:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54016 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231921AbhJUQaa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:30:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFHv1L019357;
        Thu, 21 Oct 2021 16:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CQwAqlTpeRnv34alU8MKOEAQLBZUHfNATCQZfX0b/ts=;
 b=SaJBD93gtZqwGp/H27VytSzCMoYwgE8PIlGH0klja0STc9WVhGsw577GECVo7Q5u4TTu
 fKwGdNjTQ1cmDzCIQ+nsyAU1+Zv5+33CW19ZizGozrB86yVAVUo2AdIBL7w/d3brmflH
 DHO40YqWvYmQlG/C8AqJ+NkxDrr8a3RF0rGdD6iZ387yqvxCEx6IwL1K438bRxnUsU5K
 rXo7JuVDEv5+vO/v1+1KeWP034JZZfb7X9Ti0ds+iXiTQFmpgR6uQepjyLFJLeo7ya6z
 PMAM/MPcI+CoPGgA4hvWHY/rE9NM8gAqcZY58mjhvNtYhzkYMl3WX+ISqnAJcbrnWnZb fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btrfm5xdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:28:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LGLfYL081348;
        Thu, 21 Oct 2021 16:28:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 3bqkv26kfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDTaJvI/d7sOkMHgCHgIPsb6aGwWW0YhRI0x0qiaT3MI9yn8tMFhrPghVebDxdRdqr6aK6p35xKIC743ceRmG8pPCKthkvo/VE7YvCEsikMQdZL4U4WF1ZHznsPonLmIVOvwMoysO4Eqo5IOPZMhjfmhwDVKL3FjLZz1CK7NnEygHIDYVV9Xio0R26JAW+4hHkytdJN0J6C8IFkA5GsawkekWkE+EAdU4z5qMvrRd3/g8exi1UhdLjDnckjO3HkHCuVpoR0oLstE7nma+bOMjbktdO7Vo7H2MEhvFKimMDHrJOMFK9hnYShQytkBeerWGF51Am6fkdYO8INQEyc6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQwAqlTpeRnv34alU8MKOEAQLBZUHfNATCQZfX0b/ts=;
 b=i/S+j5pjORELn7vtqpSx0CZqEftwc69CwnD03J8tkM4pzzBWlTHKnh210yxogNXhqTR0uXQCB9qPy11GZzOrpLpZ5/wWeBp9x6yY62oGzIrs93EPxd57LfEK/R2K0J5Wyt9I5dQW4ywCDfrndjrLZ/CllDN1XGMKxKdTtgcfQrz2X60RgN1c9B+QYorfg960VkR/7EFJucCIAMSFZl92L3/JJbUZ+UTyu84M7Csuw6J5uE0UpiV7XR+RgM2qePZJnbaQQXRuBcoD70BT78mvtrzVpgCjVlmv9FHwRyziqQUYzCsvCHTpCrlIRihQzDNrAL5EepVtUOkhJL8TQ7H6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQwAqlTpeRnv34alU8MKOEAQLBZUHfNATCQZfX0b/ts=;
 b=VHG6iJknyPTAxtOyumjznE/9JSHBhFCiunk5KR4IMPLMzK4/FSDQHDu87cVYnw9hoZ329Q5hcDnsb1vSSGviYQTKlhan1CLrFDNBs7cL/P8xDR1sWQD33ApioSVplGxk0b+TGkQutrLYMc5JiCEfvQ7K4C5U1U0ieElDzHnu5kU=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 16:28:05 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:28:05 +0000
Message-ID: <3a73c465-a842-c376-b3ef-e6e2081ebdc6@oracle.com>
Date:   Fri, 22 Oct 2021 00:27:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] btrfs: sysfs convert scnprintf and snprintf to use
 sysfs_emit
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <8ff89162573399dec6ce5431243e4b45ec2fc4f0.1634829757.git.anand.jain@oracle.com>
 <20211021161939.GE20319@twin.jikos.cz> <20211021162553.GF20319@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211021162553.GF20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:4:193::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 16:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64114175-8c5e-4335-467e-08d994afc288
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3425BC901C24DDA7E1BFC024E5BF9@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gX+8zV5eC2nE/YuldKQn6iWi9/tutyoxByUZlu1kY+0GQDUIvFye+4ZbpCnaH1dA7bMNQOcNsNGNyBUu30f/AeGhhGfTqKq+IYbKntDrSiQsn4tdiHto5RqQnN0NXL2enC6Lob8341TDof8QRilV+TjWxpwIlL6lphgehCjp1HpD+4lJEskI4eWtYH03m3SePjD7hjyjG0oUH9KfBch8djXY1XSUidK3eiWbLd1n3xLZd7tJ9dmgLT9KY514ZrkhQ1sJ4IsycuNjWj+TduUpnQMcPM8DWgZMzChzRYa8EGK7/+nUOVp9SKcqZwA/wY4ujr02xPN6jYH3A7+FlDp5JR2IFjul3lfBaqbwjJGTm/mXqglpffnYG5qoPEkDmeQwsvvXDRiQI1vbJgL2sMHyS8l7Ee9VgFBq+fDXI+dQaeK6UjSOnVepQ155xSQF/Vlk4uPYOyXAsBJ/u2pj/Hfvcs/GDR1vlQ4yKhAfQXAxAob3K+Td1TNXSCnnhT5ZLA74ePIOMExUa6waEgfHD3ueRdcSR2djxo10Y6LQOYmRk2FbbOZVqMFB2S4Ncjdxe6FMFdmx4lBrWZOG0vShvxFhYL0gaD+XKY2MJ25oOmjhO3NVpSgdwmG8QurqkApRqvZT4cTrbyaEM4OwPG2N6JecZ1sLzvu/9TSfoIn/9inYxdjwOs3Atku8rHZx1aqUppH3vX7+rlD1dDy2Ru7krAfS5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(16576012)(53546011)(956004)(316002)(36756003)(26005)(5660300002)(6916009)(31696002)(8676002)(6486002)(44832011)(31686004)(508600001)(6666004)(83380400001)(8936002)(38100700002)(2906002)(86362001)(66556008)(66476007)(66946007)(4744005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJ5L2txZ0FZZ2Q4WEpScHFFdXZ1WDEyZ0NQK29uZmpudGlBNjh0ZGp4NVVR?=
 =?utf-8?B?TGREZnVJNS9vWFNUUk8rT2tiVDlxblpVbEtpUUFKbnhPZWxYN29EaHpOTTZS?=
 =?utf-8?B?V1dMRE5DWGRMRTgzY3Vlang0Y3dtS3FnR3FldUVsRkt6VFduWGE4ZG1wWmsr?=
 =?utf-8?B?dGF6MHpKenV4MnY3dGNmQUIxbGFoWmM4TWdjRzlEN2ZOdmtmbENIOUIyWTA4?=
 =?utf-8?B?RThRODUxMVE3b0RhWDlUTlpDUDlWcmVzUW44ZmpmclFHRkFYbGJ3cjU1bkJP?=
 =?utf-8?B?aEM2N045VGVBZGN3UElrdm43K2xRZjNLK1Frd2tNMDllbnVyNWQyblczdTdr?=
 =?utf-8?B?V3czNG9ObTRSdzFsdVhnWS9mY1lPZ05BZTA1eUhHVHYzeHB3OVJNMlJoMnZN?=
 =?utf-8?B?c3hOUGpOcmIwVlBVKzQyV2dTUXg4cmFDNDFac1J1bDRSTVpIWG5nWkVFbzRu?=
 =?utf-8?B?K1ZZTU9HVjdybGJqdGlacGNPRGMrOWpoTldXRUQvWWlXNi9sUHNvMzBWY1Fx?=
 =?utf-8?B?enpFaVd4dFBPRHEveXE4aVk0clp5M01IWVJCYjYyT1kvaDcybEwvY21UdHJG?=
 =?utf-8?B?QmFUcWpaMHcwVksrVTE3SEJ6cHpKek15SVRZSkd2SkphdXMzYkpLcWVVK2Nx?=
 =?utf-8?B?N1ZHbmRETHR5MzhXMGt0K2JRNW9UUjdOeWs3M0d2NHNnSmdHRDZBMHBLZndU?=
 =?utf-8?B?a2IrZmNSZzFrNy83SjV3aERvK00xa0Z4emJZRE5rWTdWOWlocXc4QXZ0bkc5?=
 =?utf-8?B?RzZ5K1h3QmFzNGE5V0VqZGZvU2dZMm84U0lQUTd2eCsvTmZHcmlkeGk2eFhz?=
 =?utf-8?B?c1hzRTZqTUkrL3dhaFh0SUROcTRDVE5wcmtqckFTK0pUTnFZWTdhV0JpdjBm?=
 =?utf-8?B?a0FMbHhTWXhMWURndFc3L3R2N3JpZmU5U2dML2FQSFBoc2E5RDk3T0F3VFBS?=
 =?utf-8?B?UlFNUWIxWkZWZ0RHRGxYVzZieDViZEc5RE04YTBMZjh5MEduVWxPT0RTdVls?=
 =?utf-8?B?L2RkV0xJUWZsK09DRkdSRDczdERmRFIvQWlSeUQ0bjl1SlhMZ0o0cUpOVld4?=
 =?utf-8?B?eWpLNmdGUGl6ZVhNTEVLL3U4Q1hpOWhhVzQySzgwMVFndUJzZFloUnh0YmQ5?=
 =?utf-8?B?WTVFTTdjTXYxM2RPT0loNStGSE11NGNXRHJEMFZxRDVvU0Z2QlJuSk10WVpP?=
 =?utf-8?B?a0ZxUVdEV0NzT1VqVHZMcjc3L2xieVFqTTZieUM2WUNXUVJXTFhNOVIvMkJh?=
 =?utf-8?B?ZWlickFFdis4cXN4M000d3U2QmkrOUVsT1FjNjBqbGF4OXU2RGswUmduelNo?=
 =?utf-8?B?TjJjeUVwTHJpeHhjOHNib2ExNEYxN2wyeU5FMGJPMzVQdXB1blVjL09UcTVp?=
 =?utf-8?B?VkNzNDdkNVhlYmFlcUtLRGU0TGIxb3J5K3VETlNZOE5PdU12bkJWYVdyZnFj?=
 =?utf-8?B?UkhEeG5KaVhxZnd0VnBZKzEzZzFSbFBlRFFkcysveUhXTWNJS3hzOTkxUEtR?=
 =?utf-8?B?YUxsRDNDWW5kQmVkbitCMDI2TWZHKzRvaTJad09sNHlZSnc4WlErUzRIS0sr?=
 =?utf-8?B?eHltL21DelZsTVRDSDNBMmZyTVdybzdSUCtnUDB1UVpzWm85OFRSZnExcTJt?=
 =?utf-8?B?c3ByL1VKeEI2RVZZK2FaRE92VzJOQTlaSVJPdGUyYmU3a3RtLzYrMGM2R3lX?=
 =?utf-8?B?QnFJNStCRER6RFhEWDhyTjFOK3RoV09RalhxOXB0Z0xPcGR4a3FUVmVUZmJX?=
 =?utf-8?B?MFRmVTBFQlN1S2Fkc3IzSGx4Z09EdDF1S21HSmh2ZWU3Y1pCcjhRbVB0V1pt?=
 =?utf-8?B?eGFhLzlPdGQvVEIyOG1VNFhNcXZnUTUrSnNXTFlGM1drVTlvMnpGMXBBNEZ5?=
 =?utf-8?B?NEhneU9Hc05IK3dmcDBqY1NhVStCekljb0RncUJ6UDVXc2NKRUt1OUc2Uys3?=
 =?utf-8?Q?07m0RMup4ooCCMQlkzta+jMfOy8qhMOH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64114175-8c5e-4335-467e-08d994afc288
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:28:05.6959
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
X-Proofpoint-GUID: vFlRCPZLAFw_hMgdEBDzY23rSFXityt5
X-Proofpoint-ORIG-GUID: vFlRCPZLAFw_hMgdEBDzY23rSFXityt5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/10/2021 00:25, David Sterba wrote:
> On Thu, Oct 21, 2021 at 06:19:39PM +0200, David Sterba wrote:
>> On Thu, Oct 21, 2021 at 11:31:16PM +0800, Anand Jain wrote:
>> I've applied the patch over the local version 1 but I don't see any
>> fix related to the the crash report, is that correct?
> 
> I saw the reply, the warning was caused by the removed hunks, so it's
> sorted now. Patch added to misc-next, thanks.
> 

Oh. Ok. Thanks.
