Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9435D434397
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 04:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJTCoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 22:44:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23570 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTCoD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 22:44:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K246xd007933;
        Wed, 20 Oct 2021 02:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rVhizpp1ZqsgUcc174ifhITa5W6aVuYhsnNS1+02C0U=;
 b=WYZVtsrEG+n/rodssu5TMFkcew4RcFDpm8gcvtcjDoLl68Vx110J/h3L+dXZuaKolJN2
 s8Za4/H0RAomlfgbhN5I6qPEKz1ZdkSFB5GeBa8KdCRPaHUk0XiTRwpxeX/lPySXGuBP
 ZhW00/iTJ3NAHU9/cJfImsyh/bDzWg1z4ZYtGuBwpu5HdWVgQA1rjBcMRm/SspZLEjfv
 plPSmd+Lqc/UEMel+2RkMqFPkbEJACCrgZzolPilsY0Kmw6r7pJT9xTg7/r/gS0uuwj9
 EToO76rj8lqjF+963dqIRM71yEmnKEBZImve/R2hihUfSRJNShpddOLQ8B8ZYC/erHEX BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsqgmpc62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 02:41:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K2aoOo019301;
        Wed, 20 Oct 2021 02:41:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3bqmsfqrwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 02:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqzjuPhTIO6eBDYtPcQxB6tYTo1nVd1h/OVV5Oilb8TsukvFt/Uy59XSy3ZWX9lIAVTcNIa5/u60yG0alMNleLBXBI61wmgA/Mv0VVVU2acaID1RejeR/bm5bk1vJFdaqB46ofpV25edUa9LxA8ygrXRsJJO4lq75jls2qj+RRRZBdSEhxFQWU2zbCHSdapd5plOx0BapZKmEcDMUH+pbi5N/dexHXoPtdxNcLP/L9y2AioxHO+SGyWD3H3iZDw5XC98XyJijG+2jWDlExpC8l6biZC3r05/g+yDOdYfm74TSChgb9GEB/8dHihWo9HmxZ1H69rxhQ093xxyWJQI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVhizpp1ZqsgUcc174ifhITa5W6aVuYhsnNS1+02C0U=;
 b=d1wpko/8XGt/86jzaQhfbP+pVtPBXld450Fz7kZ983GaZfGqEkJZaEuYLR5w8FPAVGjVTvdHTFVtOTCZoEa2NiPFXevzPPUMtK6+erxdZY0kD2jIv5zlwjUaNcU6W3z8xoPEoYma5Nt4TPoIvZPAD7KoGPbCdJXH8B2YOJAnPNEPAxyi/I1rrCLkH+JVztx5HWzO5qALNY0ZgFtP/cUQcEncIyhSC75mb6ia5WJD8wB3TnpeIIgRoMfO0Jfi0tC0T/41aykGHZzrQ+GM6Z7wvbHcB7rGzYd2Wcu3FPOozslKwmDY3dU6//pgn9iiXiPj8y8y6GZl4ZcF60T2fmOaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVhizpp1ZqsgUcc174ifhITa5W6aVuYhsnNS1+02C0U=;
 b=HkhkHIjHdWL4bKb7rR0PSlq8QwzmZ6OsRZ9frj9ZaiNSitehI3uWfLY62hKBchxfI4Al4Vitr5jasYZk+l1pUq6GUjTo3+O8/DXUg4MAwCMvI73FVoDmRB7gaKgpmJY6S8+g1CnmLL8HhIZPj44NTndG676HRZYs/+eWfP1uuQc=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 02:41:45 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 02:41:45 +0000
Message-ID: <021de9a7-e401-3c07-9e50-851829a216db@oracle.com>
Date:   Wed, 20 Oct 2021 10:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
 <YW7QW/RBMWMCnYIo@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YW7QW/RBMWMCnYIo@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0001.apcprd02.prod.outlook.com (2603:1096:4:194::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 02:41:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d502b122-bc47-4ba7-2859-08d9937327d7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4350:
X-Microsoft-Antispam-PRVS: <MN2PR10MB43506865FFF3974C2A7EDDD2E5BE9@MN2PR10MB4350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AfIBN3LLoRd4flJyUyz3fdAMs+kP40yCO2fJvr0ZSPRD0IUokAb5GaQ19kMq1YoUIebeD+RYhUJtikOTabaX9SAZLJMtOyzXAYuVCnFZxsdY1GIv5r8mTxqQdeVpjhUSSq0xLNtSLIfJ/8qAUsAn3Jr3ptT0NyKGAK60RmIVilUy67f0szhBRmA+ALGHPYGt9Zk8lR5trdllaVxzPhI5yZM8cPC6/Wvmbe+laepNVH35DMZgJR9Ypjym8SC3QXUMzvxt933OzO6iLraZUFjwOPvtWG1MXtR9HeFUNDwLp1y27FnP6L8I2TJMda7CjYunOEc/effdHb8PPs/pSbaW9oScj4wU0JT4HVpG7I5f7cLIyTPoOtOVnW4TK+iVMW7DxL7jY9wV0GCEkAqd4p5i4sd+NoKqXtksosFPmHj8kY9cbnF4cMtUlrK8kC62kHsV6oNpUWail/PoyWwJfB9Gr/jEDWHZz2xRLMjtTnTARQsnb0dOmDLg7Uk9LyVoReLzFtlx3KZHpMm0LlbMBHqwGYnBsw+gxNd625TKlBF0gQnbkrQcwZk5k8Ump8/yPLyO06CZcaDIcsLqgTfUtXYC3KtAQom/sx/Yc85KVMV38s472Bhgl9fgAYwAhwZDzevndyOBijpp9WPKmIhMWtSZi2t9Hvao7UiqrWHGXrwfUa8i4qZevpHCD/LF6hMizQ8tYU7sXB+Xhs4618LLE5c59ZCmkV3ZVGaL74acLFUMSaXKRS1CrTTHLDGR4/rephG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(16576012)(26005)(186003)(2906002)(956004)(38100700002)(83380400001)(66556008)(53546011)(31686004)(8676002)(66476007)(86362001)(31696002)(6486002)(4326008)(6916009)(316002)(5660300002)(508600001)(44832011)(8936002)(6666004)(2616005)(36756003)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3BmVmtPNkx5MkplZHVzVUNFZ1dvNVJUd1c4QzkvcldBNkFmUXc0L3hLalZm?=
 =?utf-8?B?a2Y5RmRsYmVnNEUrZUJHU0pOcGpGKzNiSXNibkhaeTdURHNmd2hERjZYdVNI?=
 =?utf-8?B?b2htMFFyOHRNWEhWalU2dHVwemJCUWRjUHpRM1lrN29MZC9YcFYrOGxvOHFo?=
 =?utf-8?B?RFE2NVZicnFreGE4NTdSYVRLemJpc29RaDV6TnBvaHNsMFhwTUZ5WU10QW92?=
 =?utf-8?B?S3BpcWU2RWNab0hMMGw1L0R3NEw5Y2x6RjhxbHhnQ3RlWFhDZUJKa1lXdUlw?=
 =?utf-8?B?UnlwRlJCbEE5SHFvU1dWTUs0aXZmcjNrakI3MExuVE8rREM1aW1iNFZiYXJF?=
 =?utf-8?B?WFZRSGlHOHpPaFpsZW5JaEZNRHdiUGUwNEoxbFlwZ3ZQRVU4SDd5NzV0NytY?=
 =?utf-8?B?bEdxUGF5bUdGVzc2QU9tSHIrQlJWUUFBM3lib2cwRUlLVTZVM2Y4K1B5WW83?=
 =?utf-8?B?VjY3OVNFQ0JlVWt4OVNCYm1BdnpHVlc1UVdTaCtjNlgyUzNiQVAwb2V3a2Zh?=
 =?utf-8?B?UzdjcUhnd0Mra0pUTWFQbDkrMGUyQXg1WmVKbjlYZWRRejBnK2UrZnBJRWNa?=
 =?utf-8?B?OTFFYkpEc1p2ZXBNTnZXcE1uMHR1bm9EQmUvWnlOeUw0Tk1lRXlMbHVYTi9U?=
 =?utf-8?B?cTdhWDdpYUZqWklLamJQN2ExZVBCZzZkQWY3Yy94elNCZ0FjQlEyRkRabG5t?=
 =?utf-8?B?SWxCbVZtNDZPTWNZaUxhUXhJSnhZKzZiTlhuc2VWdDVwRnRtdHdzR2phSnFB?=
 =?utf-8?B?NzFwU3d1MkloeEdNUWtVdmhhb09nTi9DK2JhTlJ2V3pFWDA4MHp6ZEpwRzZL?=
 =?utf-8?B?VmU2MUNZdXlKeTc4YWRGQ2pWZWF2NUtkejFpYmI4aU82VGQxNFR0b3ZjcVky?=
 =?utf-8?B?dEp5VTBBRzJ6eTZzS3NxaGk0cWViMVNDZUEzYkNXc2JUVlB1ZzNOL0RIbXBw?=
 =?utf-8?B?cGRYNWtEcGtxWHo3QTZKRCtuTGlTTFQ4cE01a0M2amtvZzgwbUU3S08wMGFC?=
 =?utf-8?B?UzNhUmVSSTVyNDB5bU4wclF2QUlmOHRRME5ZVVV2VzFBQUJaUmRxcXJGd3ZP?=
 =?utf-8?B?TDE0a3NUZXptaXNXak84WkQyN2JLZmR1RkZRb0VwN2FUdHpUdmVqazdzNEJ0?=
 =?utf-8?B?SWV0ZDdQMWxkMlN1bjhWVXh2NWdnT0dibm0xN05qYk9SbnVqY3BYUEtIM05U?=
 =?utf-8?B?QXl3cEZUeXBReVhlakNLamFHSUV2aUU0SFFuWFFVOC8zVHNBSEFJY1RDT0R5?=
 =?utf-8?B?SnRhZW9nRXlZd1hmV1E0eFUrbFVKZ2J1Y1JQcmJpRzdublJIVkpKWlgrdzNt?=
 =?utf-8?B?dDloZXlOTXMyM0pNaUs4R2pIM1ZXR3A1K2h1Rzl0ZHduQVRYd3A2QXhyU0Fn?=
 =?utf-8?B?OG5LNFg5ckNjZVVoRWMvUlR3SkNnYjdLdWZwaVpvVzNqWWhnUTFiZkhaR0NF?=
 =?utf-8?B?RDBqZFVNUVJIa0czeEx2cFBjUWRPdThLbWhJLytveDhZanZJM080UVlkcXBV?=
 =?utf-8?B?eG81YmZ4MkNPL3FRYmxyc2k3VDJnODdjb0tYeTczYnJiM1dTSjVURXdXVFVp?=
 =?utf-8?B?ZUZmeFpWaFFkcmlReCtYamxWZERZcEVyVGh6aTZaQ01PcXdheWhyNEk0a1pP?=
 =?utf-8?B?OHZYbkdjOXE4UktZR3gzNi9LYUR3QlZXUytCU0FVUE56TVp4eHFhYVB5NHJY?=
 =?utf-8?B?OHMvYnJmWXppZU9vNmtGbEd3anp0TGFLaEVlVHN6eSt0eEQwbk0rRUZyVGVv?=
 =?utf-8?Q?jgpA11BzsIFxu2t5m8hEA8oF0NWtApMR6JGXPat?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d502b122-bc47-4ba7-2859-08d9937327d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 02:41:45.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200009
X-Proofpoint-GUID: mlpvEVSLut6COHEbVLEmCCAhjH62KOF1
X-Proofpoint-ORIG-GUID: mlpvEVSLut6COHEbVLEmCCAhjH62KOF1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19/10/2021 22:04, Josef Bacik wrote:
> On Tue, Oct 19, 2021 at 08:23:43AM +0800, Anand Jain wrote:
>> The following test case fails as it trying to read the fsid from the sb
>> for a missing device.
>>
>>     $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>>     $ btrfstune -S 1 $DEV1
>>     $ wipefs -a $DEV2
>>     $ btrfs dev scan --forget
>>     $ mount -o degraded $DEV1 /btrfs
>>     $ btrfs device add $DEV3 /btrfs -f
>>
>>     $ btrfs fi us /btrfs
>>       ERROR: unexpected number of devices: 1 >= 1
>>       ERROR: if seed device is used, try running this command as root
>>   
> 
> I'd like to see this as either a btrfs-progs test or an fstest.  I think I
> prefer the fstest because you're adding a sysfs file, so maybe a couple of
> tests, one to validate the sysfs file behaves properly, and then one to do this
> test as well.  Thanks,
> 

  Right. I will do that.

Thanks, Anand

> Josef
> 
