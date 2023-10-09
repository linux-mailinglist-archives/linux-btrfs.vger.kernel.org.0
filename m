Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F277BDB77
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbjJIMU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbjJIMUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 08:20:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B39D45;
        Mon,  9 Oct 2023 05:19:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399C8oDC011316;
        Mon, 9 Oct 2023 12:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ohnhzGF1bWfhhe55Ktcti5h75oQgffkhVnZI7StSN8Y=;
 b=1ZRx+5vDziGRJeToQbLE1Lnk+VJx3LDQybRnCWyWZ8fqocuOZLMFgFfP+OrdxtSgMQYL
 u9mkOKvPzh1xX4VKq/iSLnBbjzJXzE5oj6olrhltBd6Rt41xgUsc9rZ2C+jHlqngJHxL
 /fGJEUSiwTZ4X/7+P4pCW1+GwApP9P6/vPFizIJ4vUQqtdB/W8Kodh9yI2y8+Pf//Czx
 Vwg61Fe7K0yXTptHRiauEAa0WW8P4iVbTkRlSCqwRcT2AUCoHusA9vSvZiB44HPjHPWx
 feFRVelKfEGvrzO7i4ZOe2bTIE65cBtN+7KJ2ENEGSVQcUMaSgzQ1IiBOsEALD1tis62 jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh90r0ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 12:19:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399BdFtq014439;
        Mon, 9 Oct 2023 12:19:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsadk1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 12:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8hR9SYOEa7R8o+BLmO/eK0ucryg7CYO+01+5fOl5ANStCeCiOirk3iEDxgKRP51s5HO14dvFY2a+y1DA38eq9KWxTxl2RhLli9Zu80BPk2hJeCk5A/tW3EgUEoksFaDnQ/RHYyN1M3nWk0sdIS5ua6V+av3wPI6BGTEJu4a2zdeKCA+cbd19gBcBrtcwKz2Lq8UvBDCDMr8No8jc/4LQzmt/1KPhgm1OqR0StspNR69kOHPbsswrU+Yq/LnNtlNCwkEwIz2Q4uSrmLZj0mVXgpVV4LX+CZ9yiiOPN2sWT5OSGiQy/FbPIhbennoXcq+innpGVOZd5mRp1a8pS3xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohnhzGF1bWfhhe55Ktcti5h75oQgffkhVnZI7StSN8Y=;
 b=JzuHysIGvPGOTNm29lqoCgH9OP6gFP1rmcyz5lAs/SYBij/6ZE7gZJ1tiFsgvHQYmnL+c6KBKTNEwFjSwM2y5JOoHAmZt1d0ebANMRa7zh6vtAKLk0m4KgpDOwprap3hNcSVZDbgDOgRB1/35gMWYIAzGW/D33CsP78Ie0+udkMoc3Q8cInXEbj2IMvzw6KPUnSqf3wXrQYTTiVckqNkIWQ0i6PLj8/0oW+SKUlODGoeOF4G0dpXdsF6I4wc4cZmowk3/rvw2nAp4p9s0U/OB02B0DVzOv8OnN/d+6fhsZv4ZNfJIcogaKjZQmym+R6Co/iEhePJ1KdMe2Y06uNI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohnhzGF1bWfhhe55Ktcti5h75oQgffkhVnZI7StSN8Y=;
 b=zora07y0QgOtGEaCrNwSa6asAY1XahG/H/XDvanC/nGmgrrV6l8CJCQBYr0qhoJv2nqQyXGwxiJLtJOW/+7Tqik7bODFaWIFlTMIJ9BIF65tqGIFyk8C8qVbxlXjASsRq2OsuyHNRvvqq8ICtB1Qur2OnJxG2NBZGOLXx6nZwTE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7563.namprd10.prod.outlook.com (2603:10b6:610:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 12:19:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 12:19:00 +0000
Message-ID: <d4e7ba14-dc94-4611-8f7d-e3c5aafe80e1@oracle.com>
Date:   Mon, 9 Oct 2023 17:48:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
 <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
 <ZR+YX6whnmZlnFv4@dread.disaster.area>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZR+YX6whnmZlnFv4@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: d27b556d-4753-452c-9584-08dbc8c1eb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgd3wB79MFn3QHTCDpW8a6S3ViEMfZjmCupI91qADkacRpt8YSL/2OzLshjvFEWmfWFvQqVR7n88B2GbljuyIBCBg63LxQny0lqgaA6Wu2rwGLWVP+/8Zf7brbzFSlrxa4Na511XPvTq7lZMVxsApOFQ8roh+7rKXzdMu3o/Rs0Ao3Zqwxv7XL4JOUsjNnnGVqXjZpMv4OJhtCz1dsesKpagU8YACO3BRBuXLztD6m1tlUJUV88lVO4sRVcoi1jbzH72MKP2hYb1waAthDB/IoWA4QJSB7Ci5IjaAPrQvD1sypMfyv9RiILvPa6NOfgROrRzJJqTBrSiRTG0fyrQ+8krxoVaHEBjzERujXpj/kTTITbLTqGWhnMTt1GUvnY8ZQCoGWfRZBqUZb+e4jFRsNNdsWcljU4c2QlX1QBheztqLfZwGxkSaXStlJR0g9qPv9P/H/pAADWONkKY30G2TWFUnEBRkTHVPxS1zbPs6uxC3Nk5q54FHEcI0ryTp7kGkzRRSXUs9rQLNyqxh04POj4ayGnhynXMyEiUItltRakZxH1HSlLDLUnpVzVNPEc70sGRQiyz7hTRAMB0yJQ0HsKLSCNzZTA/AzDQmJLhQecwtiEFTprAXabEuwuy1jD90v+/Vsh7DiU0zFoEkmWXhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(66899024)(26005)(2616005)(38100700002)(36756003)(31696002)(86362001)(8936002)(4326008)(2906002)(8676002)(6506007)(478600001)(6512007)(6666004)(41300700001)(44832011)(5660300002)(6486002)(316002)(66476007)(66946007)(110136005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkk3aTJsYSs0VnhseVNIRzRxZnhxMHU4bXZyRzJObmxHdnJEZkxvdXNKK2Fy?=
 =?utf-8?B?OTZVSkpxbzA4NktneUNpa0pZZXB3ZHEvUTAxUXV6WXRiRzFaelRxdWVwcnhD?=
 =?utf-8?B?Q01tdUpnQzRjalorV0pZYVNNNDFvRFkzWDc4MXZBYzhDYlBtcVBvdE1CRXQ0?=
 =?utf-8?B?aUdKK1F2b3pzTVpWaDgzbVBScEk4dGhKVHkvU3RTNzEzc3VSZllOVHp2M1hy?=
 =?utf-8?B?RXZGZHFhS2pEM01hMk5tU0x4Y1BNTGNmTXZTL2owbHlDckFvRGUweGhySU5h?=
 =?utf-8?B?WHJJTk1yeFc5UlowMmU1Unh1c3NseXNJcm9aajRndTdaZ01yUkhWVjRtbHVs?=
 =?utf-8?B?ZVdoV1VKWlBIczhsdHZySlcxVDlERkxaV0NwY2hIaFdIZUYvSGdCek1yeUhD?=
 =?utf-8?B?MWpWeTVmOHk4SWR0QlhMeTdvbmxRaXBlaXBKeEhsdk9ZQUdXa1ptNkZQdmZi?=
 =?utf-8?B?dnQ3NW9IeGZLUXhxOWtMbVRybjNoM1RyMnNhbk56QWVFeGd0U1ZZajhoUE5L?=
 =?utf-8?B?eGxUampOUEVaY3c5RnpYN0R4R3JGbUU2RFNWTXE5NDVGeTJJWmhiQVdLZU05?=
 =?utf-8?B?Y05EQVRSZlQvS2hSbkZvQ3g4bG5UTFp2NFlXbURGOVNDamluSjV6eHBodzVT?=
 =?utf-8?B?TGxFYmdMSitrUmhnelhlLzBxODVCcEE5Z05udVEzbjhMVkRDc2tjMXNLbVVr?=
 =?utf-8?B?WkNuR1pyWXdLb3daWEg3eUg2ZGFGWGZJaDlFUE9DZUw5blFZd2l4Mm9jZkE0?=
 =?utf-8?B?QkFiYWJ2NFNiRjdETlNIMHhHSUMwTUVCejhWVm42OTRWNXZ6V3J2WUdJWTBo?=
 =?utf-8?B?NGFZelBNRXR1aXBVaXg4NXUvVGs3ai9iczlVVGpUK3F4NlAwYjVzY3BlT3R4?=
 =?utf-8?B?UDRwNmQ1RjVONUtqUWdjN1ljTGFsY1R2SjMrNFZqOG1JT3E3VzM0S3h4WHFY?=
 =?utf-8?B?YUd1TXRnQ0xFclY1d2R2Y1R3bjJWOFFpUHBmU0IxSXNqSTdJNDZORllmT2Mv?=
 =?utf-8?B?UlVlRmdhdzlwZVEvTkRVN2M3VUtNR01RMFQ5d2gvOEVwMVFsZmNFdFI2Z0tC?=
 =?utf-8?B?LzBvY09iOGk4T1ZZTVM2d3AxUjd5NVVaSkg0NjUxZUhzK3gwbVh2MjJ1SWlZ?=
 =?utf-8?B?dFZ5dFpnN04vTzBnTXV3aVpoOE52V1dVMVRGbTVNc1hTbU16OE1TNDRqQzZz?=
 =?utf-8?B?ZUhIN3k3YjM5K0NWQU1ONzRDRTQzY1Q4aENyRzJJaXNsblE1SytHbUc2SnZs?=
 =?utf-8?B?eCtvTkp0bXVWZkZSQ1dpdE92TWNsWmRCaEptb1hKRzhkc3J3TG5EOU1UUXVY?=
 =?utf-8?B?djFyV1ZLMGhPcGZlN3Jrb0lBaFl0eGluZ0RsZUlXRHhxYlh6ZGNFb1ZDZFM5?=
 =?utf-8?B?WThwV2ZabEp5UTBHMUJ6S1IwNU02YitqZktBNVJSTVJXWGxISUFyYkFqQjgw?=
 =?utf-8?B?ay9CcVZKQnB2VHFlQ0hwR01panhQZ3NWS21xMlF4eElJUVVOS1Z2bWRaMnVq?=
 =?utf-8?B?bDl2RWk0eFdwcysyYjF0dnhMbUlGQ0ZYN1o2QXNab1FTVXA3SjZFdTMwSkw4?=
 =?utf-8?B?eVNHQkRPOTRCT2pMVzB6dklDNDYwSmZJK1ZEcTZOVkpFNnVaVytxOHpTbXJU?=
 =?utf-8?B?RmJZZSsxVjJXZEM2ZXNMMG5qeStEMS9iVnlRQng2SkltMlFOSFphMGFWWGFN?=
 =?utf-8?B?anVyQ3BiaTE3VDVlVmxWakY0THZxb0MzUCthM3UxYURPaTgyUjdCT3cwNTZM?=
 =?utf-8?B?TnJxZDZUZmdIZHNoeWlVRzZNL09NWGc4UXdqaW10aHJFQ2Fpb2ZzVzZXSnFu?=
 =?utf-8?B?RTRSekIrRUVxemlZTUYwM280a0N1eHZKZE5ZOWcyKzhVdFo0bWJqb1ZCVW5G?=
 =?utf-8?B?YWFITzhOTlRqYTZaTUNUTTNHU0JXTTVONFpoc25rVWpKY0NrMmxNMi9kemFq?=
 =?utf-8?B?azY4RUdiZnlwbDdSZ0xHbG95Nm1LZ1F2VFNTTE1IWUhYNkJnUDI5UTNjTVN0?=
 =?utf-8?B?aU1HcTZpdGhmNzBYL2VvNnEycUxIa04zcHB3VG0zdTQzQlBmOW9nNFFXTmQw?=
 =?utf-8?B?MXMyRlNwUWhPNVFJUWFQZFhwaEFzb1ZESkxqNm5GSEVnUlJqaUpaRVMvUVk1?=
 =?utf-8?Q?9xyxr4ujwtnscY8SKBcVkOOee?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MH62ggrGvszlH7+87tds5A1mCVfFFnMrCjx3MdayNT4qh7N1rNfGDIu5UzHmB51FiEATeSwmt5kKKE/xpa1fgU0Lp5XDiFEcIrN5FOBIIjuN5apBcJr0padUrPeVVvoE7CK87/FdKge7ejS7qEGSpYZH3sxYQTfIlfhOZMBSsyL8iTRv3u2wZszRW69bXC5+FUEOjbl3yZ7jfMumDJ3ckWiuoS+LIA/naCTSRNfOqMrGrC8bJaBTrOt6a3SjzQ6GyWpjD0f9JuhPqsHb4AH64gb40hEEsgwDaKEEXhI7spRUVbVoyODO6oRddR1Hl4dydDpWovh0pGY4aeIjqZMSbSDeUWbjgixN++TBtohzBuPIx5tmZt+30c7a8WtshEDJ2G7K8TC4p9TKLdG3xCswPZrh2z/eVHB/PITenW/R4i3bKMQib7cWIwS9ilPHelNof3rAPYV/jUYcYmn7IrGZ/I9wawfOT8hhDXdqRL5hvUeiV7NuLiBhplpDoyAruclEd8akLCcuOAwX+eOwAw+uUP4c/Chxt1yY/3N72kXRld+6nFuT/eAPpcdyZThQAWsRgxjl3jkc2kFV1/SeNVdTHI0gX/w6htWu+xsjkz0gsOfNFH9Vu8j0wiK8jpjRBGSOcTTlaw6JEdG4cn6LbsIT6Zkckgw/BrS8TtAMTicmJRL05JsmjGmIAlCkmHqreS5HicTwfvUAvsZ/SumH0dbTpUEwPV9UFVTdBzHAgYX9feIFw4wnWEaYak4B1RRJEE/kkAu2AA2xOK5xcIy+OJFPPBafc027++w4Z0ZDfMhi3um2sUnNAgJuXtRn2E9d5slH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27b556d-4753-452c-9584-08dbc8c1eb04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 12:19:00.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maPkDBiJHLYRD1+0rUACH7KJKRqqf02/VzG6xMkOg39SQpgqPcmjD8LHYp4xBdHpxDEP6PuyhQ3wqy+VoDcGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090101
X-Proofpoint-GUID: tzQyGeLm02qV2SjIcP1OufE7nWuJtvzC
X-Proofpoint-ORIG-GUID: tzQyGeLm02qV2SjIcP1OufE7nWuJtvzC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>>>> @@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
>>>>>        _scratch_unmount
>>>>>    }
>>>>>
>>>>> +post_scratch_mkfs_cmd()
>>>>> +{
>>>>> +    if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
>>>>> +        echo "$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV"
>>>>> +        $POST_SCRATCH_MKFS_CMD $SCRATCH_DEV
>>>>> +        return $?
>>>>> +    fi
> 
> Ideally this should be something like:
> 
> export SCRATCH_BTRFS_UUID='<uuid spec>'
> 
> btrfs_tune_dev() {
> 	local dev="$1"
> 
> 	if [ -n "$SCRATCH_BTRFS_UUID" ]; then
> 		btrfstune -m $SCRATCH_BTRFS_UUID $dev
> 		return $?
> 	fi
> 	return 0;
> }
> 
> _scratch_pool_mkfs_btrfs()
> {
> 	.....
> 	btrfs_tune_dev $SCRATCH_DEV_POOL
> 	.....
> }	
> 
> _scratch_mkfs_btrfs()
> {
> 	.....
> 	btrfs_tune_dev $SCRATCH_DEV
> 	.....
> }	
> 
> See how different it becomes when you stop thinking about filesystem
> configuration as a generic post-mkfs command and instead think of it
> as just another configuration option?


There's a possibility that mkfs.btrfs might include an option similar
to btrfstune -m, but its main purpose would likely be for running
fstests as there isn't any other use-case for it. If this addition
happens, I can withdraw this patch.

However, to clarify your approach mentioned above, if we want to set
SCRATCH_BTRFS_UUID to the UUID of TEST_DEV, then the config file
should contain something like this:

    SCRATCH_BTRFS_UUID=$(blkid /dev/sda1 | awk '{print $2}' | cut -d"=" 
-f2 | sed s/\"//g)


This should go in the config file. Right?

Thanks, Anand
