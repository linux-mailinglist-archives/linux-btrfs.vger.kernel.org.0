Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F25456D31
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKSK0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 05:26:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51174 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhKSK0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 05:26:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJA9gOR000708;
        Fri, 19 Nov 2021 10:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HVEWFyfIKe3K3d42GkpGl5twpkwuaALEeBTiwI9ZTLo=;
 b=lwZwY0nDLz93qlzC0AnOPwgMpAGysI41utS1VWRngYJYjgqhAzp62qBY3kGYabtLP3MN
 fr+9cLjfijkYtKJ94sPWmB9aEy3A404a/ldbdMqlT0DMJ/84YZHtqII6ImYiC28FZ4SY
 FhgXwqG7w+2/Nzx3ZbVFSPeLRf3Hywbr6JGC0pUh1zN2TOM8yek/ZBHT3ZHBm/Jo7Vlo
 Q00PrdOrjZUJENcttzaNYx9nO7enrpREQG9g6HNFJRTUfvgxlKFVEagv3o/Cq+R4V1Vp
 KMeOpq+8V96bGTVqXR4NGoTJ+RzWKDERo7EH8OL8u0XYU/6V474C3UPXgP5DoPx6fOAf Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205p6a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 10:23:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AJAAZHa027177;
        Fri, 19 Nov 2021 10:23:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3cccct85hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 10:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIAUmeUy0AGHCOlYpKWYFMhalfYNTCbXTJ6UVIZGgg2EjhpF1mXaMwVZtJc0ci0W+Nnzs31Z6a6vm7zlfZtB2IUgBceiPZBgZPmMlJq93XdrH+8eY0l5JidZBufDMRXLl7jEd79bpUUjYqsJjk8KKh2pb5gJQfZvGEI08T2qbUPKfRPUXTAX0LedROdZ+GJWAx7heJKbUJaUDSDRFWVdtDlIuJVGGC10gZOogTvo4ru8ZKo//eRWFJ8p7Iom5cvsbWNM+GW8ga5H+VYbT4YVOZxVEiRNPBaYizz6tgRqgtSlRqsAqhfNWYxO2LgtQMsUqs2/T52tU3w/xw+MDREnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVEWFyfIKe3K3d42GkpGl5twpkwuaALEeBTiwI9ZTLo=;
 b=nof0mjJHVkx5Q1BJHgZ4TvizWQ9lZmvElGQA0YrxphxtjKYgyZS8bPhpidHs8Qw1hv9UGxyP/s5KSRPWtFqHEqBKpiLoGW/1ve+7V9Pxch71a/8a322eJqlUlK6C5ERMQocGZNIWbRvVAeqmzb8a+HT1iz2V2c6VilhlWS2Ix1KFI2dZavQRlJZ4ybrnYUEqFEWHqkiz9LDPzUXWURRrQZ7jJnIiFgebghRM9HTS05JDAGjOtQc6wPBtRtJlctQAp8gYkpscQ3jV70B0m4BIizQmnlzdOTc0DVLPGMaGzoirZpYf4TDP21wFuU93qKwGO4AT4/5DXzz5WQ+6BNEsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVEWFyfIKe3K3d42GkpGl5twpkwuaALEeBTiwI9ZTLo=;
 b=MaOVl4FWot5EHkqAKvmBkeNNVH5mIYaNdQTJNIFeg1lWxiar1Rr3miWsE4H6qs+ExT3Hca4ene5TXhQIcUxF+8/vmNIoA0xNZepQFhIEYiyvCTrFfxZoFv8ji5NIwuCT59A+/9NGrt4NIoFS6+ZtuNfPlUJ8ydIJFtBOnpQT9Bg=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:23:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%7]) with mapi id 15.20.4690.027; Fri, 19 Nov 2021
 10:23:04 +0000
Message-ID: <4d05cdb0-6d76-f58f-51cb-2b270ccf2df7@oracle.com>
Date:   Fri, 19 Nov 2021 18:22:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] btrfs: don't bother stripe length if the profile is not
 stripe based
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211119061933.13560-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211119061933.13560-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:3:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend Transport; Fri, 19 Nov 2021 10:23:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e2c85b-6553-4fc9-dd57-08d9ab46925a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:
X-Microsoft-Antispam-PRVS: <BLAPR10MB51714ACF341E7337458AF475E59C9@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlYRb/vZsF4Zl6K8ZKn2U1onlu6wAmHKWtAbFg/Re/024xljKiJS9fJ6RtHzF9cLACbZj7GDfvh0OF8PjwGPF4gsg9NoNGzFrKkEdQtkwS6fE1SkTn2M5RF3/JMBB61ZYrbr2vv7RQq1DtypSXfKEEpwcj6grVCpqWYq6vCXANDYGdLOIv6d04QGApROUaEnoxRqqAbfN4fvoFg8ADz61z3bwcGZ0eP6L4VCrq+t/gw074w+9tSL8tLQ2IV4CHXxrzM314fLu5ROwdVmmeAk64aJjQR/KNvNi5q658wEnvd+IDU4Vh8gYsGAyiDuXvkoSiIHYqqX5SfR0kAf9wYFdlCsj0RxeBcJNC+jXVvZ7X4oboJaGXU+BjAXjOEWgk0CetOzY6USamFVThis+O6OD71HI0qJsvUEERhfqvImaexSNGrbGPLnME3CP/1z01JeN3vbfhVZuRuLcqhbbYTVmeoiCsorCPpJjmvBh2wWmm0HJirOmRMqkN5PX2OOlfByQEtcCGgs5wcIUz6JMy4l4MG5Qz/O6vxzQHjCqP4ONm/BnDcljG/vDPDinoPIF10NWvcZCrkvrMoSKFU7NHOUPaePCXVtLxxC1kKwhsAflQIlOSbxHfjyD/5Hnnu7q8Cct6BtO0FO+yewqQYDpMC3YcdFblNDS/3NQ0cMb01cnhyaXXuvUIl7fKp3ZK8rqcqVOOcR5WOl1uAFeK2+/xnbkxaHOtTMuopSuABv/F25Q9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2616005)(956004)(66556008)(2906002)(44832011)(66946007)(508600001)(316002)(8676002)(16576012)(6486002)(31686004)(26005)(86362001)(186003)(36756003)(6666004)(38100700002)(4744005)(83380400001)(31696002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZMcmczS1FqZmR0NXA3NGc5a003c2VidVpRTzNMaXR5ZlJURU1xeGxtVFVF?=
 =?utf-8?B?cndYQURpWEhOQzVkRGVZQmlWdzhBbk9NUW5vUGZoUXJzQ2hVUGhhK0MxUUNT?=
 =?utf-8?B?cVZVa1RUL0tQeDdvUjZ5WWFheml2OWNaZmxFRTJjZmsvV0dJaFVqVGozYmlR?=
 =?utf-8?B?aFB4cTNRWjducWNDeVNEdGx3V0ZrSUtkb2d6bm1Fek9qUnpTVmRTZTlLTDZ0?=
 =?utf-8?B?d1oxaFZWaEQxT1dIVnlTaFBuRFc2RmFhUzhJQXdoVkQwTDQ0emlhRlR3cnRm?=
 =?utf-8?B?YlZZL3VrK3hhTTU0MHJPaUxmOWV2OFZybTdBd1d4Ly9BZU5OMzFPRUI0Mits?=
 =?utf-8?B?aExOVFA3SEJZZHM1MjNrNHkzcmxqb3QvVldEbDVGakZSZmMraUV1cE9tUUVS?=
 =?utf-8?B?RGkzbnFaNGZtRW1BNEhGNWc0ci9OK0p4QzlrNzVpSjJqVHRKVkZoU2V2emtk?=
 =?utf-8?B?Q29reW5VSEluYVFGa1l4OVh2S1FOWVVucHZ0c2FtdTVuK1ZaVVN0eVFPTDFj?=
 =?utf-8?B?Zk42WEk0emloU09lMk1LZlhzdEVEbkVRUzdjMW0zYkVoYzZpTnQxbFZFY2pP?=
 =?utf-8?B?bmFQYyt6VkU5SDlBVWVGQzFRMnBaUHpyLzVac0dRQWJlNlhwdHYwYXpxSFZF?=
 =?utf-8?B?NVB1aldkaVdJeEdyQnpBVlY2WlJJUWFhYmVOazlnUDBvRU1yWk9SWGE2VVZF?=
 =?utf-8?B?Lytxd2ViYkVZOGJsVzk1SkVHV1pvTzVPajBGK2FsVWVtOXBtNS9mTjYwWjNS?=
 =?utf-8?B?bGs2d1k0WFpEb1dXRTlXZDVCYkQvRDhEZWt4MWlkK3ZjMUtBN05xaXV4Nmth?=
 =?utf-8?B?L2s5Q09xOW1vb0F5TE9ES201THJxUVg1VWZtRGlFVGRCVzZNaTRMZ3hHQmVM?=
 =?utf-8?B?TC9hWXF4aUdERkZZRXpKdEVBeHRLekVmREY0bmlWazQvMElRazRqUVF5RDFl?=
 =?utf-8?B?QlFCQ2hndlY3NEFFMUVvVGM2Wi9KUW52Zkd1UHVGM3QwVWkvZkJHdzd0VDJa?=
 =?utf-8?B?SU9kTXdrbENlcDRqYm90UUZCNEhiRlpadlRHb3IvL2dTazY3MTlHTHR3N2lJ?=
 =?utf-8?B?MzBuZXZ1bnE3OGs2U083N0ZhNE5LMldEVWV1USs2MUw5eW5ycmRaelB4RmtN?=
 =?utf-8?B?VHI3NDNiTmcvSElUYjdDSDRGc09FSzlXUExHYWE0YmRSQ2M2OXYvYnBMWWsw?=
 =?utf-8?B?OEp6TjVxMHAvajE5b2NLS2ZycHoyRWVlNTY1NUs0UFVRYTdmTm9DalBHMGR4?=
 =?utf-8?B?eTVOeUVETW01NnJYRFdMK0Q2WTQyTDNvak5XdmwvaVN4clNsWFRBRENibllR?=
 =?utf-8?B?eTh1S0JJTGpOZmx5ejlzamFTaXF3Q2lrZXF3RG5YNHk3N1doTHBZWklrOTZ1?=
 =?utf-8?B?OFF3QXdVZGc5N2svWEduaFpzYktrZjBwUUp6S2ZVaW1lamozMHBRYm9kVnRZ?=
 =?utf-8?B?dTUrRTlBSzZFaDBKYkxMckVWTzlHM0R1b3E0ZDdvVGt6VFRia3loeWpFT0xa?=
 =?utf-8?B?NWhoY2F4OWlOU2lHV1BuY1NWQkZYaVV4TGRINjhDVlRsb0VpbHA0MzVTMW5K?=
 =?utf-8?B?a0VrdVBKaWNyZ2lzSmR1NnpOcG5PUEJCMXhUQTRVMlVRZDBTRDR2WDBJbFAv?=
 =?utf-8?B?ejA5c3BReEtJZytoaHBLZ05NaXVLaDZFaXdHNDl4MGFCeUNaNmVpeTVtUlJa?=
 =?utf-8?B?YlRIRnFIeUxxK1JMalEyY1AyQ0xyTVdMTHZsUXh4dE1CcGlVUFRqK1N1azVk?=
 =?utf-8?B?ellSRTFlbDFSdjJaejZTWFZuNEhJKzZnZjllVE5PUW5sVVZCSWlVdldOVDFP?=
 =?utf-8?B?ck5ZUU1FaHJLWEp5SWNYZEFSVWpYSTJSOTc5elVtamRDU3RrUzBzRi90aDlU?=
 =?utf-8?B?SW5MQi9XMVgvbm5uNWp5Tmxxam1wZUplYmlPWTJUVVlQOUlMZFFEMSs3bmRu?=
 =?utf-8?B?ZlZ2dHpDT3J2N09YbGtWbnhBUWw2ditsTFZldFdTb3lwanNXaWRscGV2SEZH?=
 =?utf-8?B?alFxVjJLRXpDUFd4TUh1M25PK0JiWHR2QVlINDdNSmtaMnI1cldVWW96YldR?=
 =?utf-8?B?Vkl3bEtXbjVvM1JiUEd3ZEdUOXpYRVhwWE9adXpnUXhWRnBtOXhrOXNUeW50?=
 =?utf-8?B?eFFtN1dSeUtSNVVkQldlMUh3bDE4YWZyRjN1dUJNY2krMlBIQWFOWFFWNkdF?=
 =?utf-8?Q?Lri7nGfBE7U6qOwP5thNFTM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e2c85b-6553-4fc9-dd57-08d9ab46925a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:23:04.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpS9TAjzBS+5FIauDLR+W01lZbNRCh53Ai/d0OBAcKZ7lMOX1YC1Tkp6h/7C5FdhT2qPszjGxbfoQeR4kDsi3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190057
X-Proofpoint-ORIG-GUID: ndF7l1pVgRMk3Cc7_X_9MVBeqeYfJLPj
X-Proofpoint-GUID: ndF7l1pVgRMk3Cc7_X_9MVBeqeYfJLPj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Nit:

> +#define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |\
> +					 BTRFS_BLOCK_GROUP_RAID10 |\
> +					 BTRFS_BLOCK_GROUP_RAID56_MASK)

  How about moving this define to btrfs_tree.h at line number 911?
  We have other BG MASKs there.

Thanks, Anand
