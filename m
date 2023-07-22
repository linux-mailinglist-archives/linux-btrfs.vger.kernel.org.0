Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC28C75DCBE
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGVNY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 09:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGVNYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 09:24:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748C1BC;
        Sat, 22 Jul 2023 06:24:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MBUu3u026572;
        Sat, 22 Jul 2023 13:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=50WJel2EWduCPzoJTAotg9lXUW8nBBzrXxh+b8J93g0=;
 b=OZlmdvCgTtDDe22Qlxq+T65zBhXU1GR9/OIjTLXUVMCWd+mEPRpV05xMpvN+i/3yLdEO
 jmoIo4aSBVUVvAmaOKlnE2AtUjkS4uJ8cn0d/Ig+j0CD5gWGStL5t67DhfyfgJhe78x6
 70CtP3XVe7oFHHI7sctk8BA/Rz4mSdQQRwY8hK7tqTyyPAL7tPYVnZZbKrFLGGCs+5ZH
 BLUXMhab9jogRV/9owlImJVlIYbzBvdggwPGjYUN36KDp/pbQDQ3rOO+drHGUYRUYljX
 /l73OLLmiNsm1q9LNePil6RdDkNFGdlPJ1hP+BL8yo083RwT9o2St9/8gwn3vazG8i8i UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070ardx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 13:24:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36M9UqNw000472;
        Sat, 22 Jul 2023 13:24:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2cddb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 13:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/HW9Fbz9zjmW0oLinHmmXP+4V1MycPsfXr/FLTEojQ3w9WOsPOuHW2QMLCPAJ7fupqjjle06BguJUPZYrX3GPoIzeg50kieqPHp27nWOt0yQpyIdJbKp4J/8loiPZs01ziBW1Lkh5XYVunRfZQg/uAd3+SbeF36u3S9LxBW+OSa+jGMx1bi9iHNlegFcNfS+2BQgxHLdsFS9eVMdQXN/L9H1EDFcpmV6QNwS3xqOxFnZbrJ+qRKBofp9cZpH8qCGx3pNrbIvKsyHpIkVkZKXARSZ6H5imbXGxXlFYNZOOvvq1wk1tpewLMDwVE5u//HlEj8VDiOQfwSDYYkUe7wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50WJel2EWduCPzoJTAotg9lXUW8nBBzrXxh+b8J93g0=;
 b=hWut4/DBeHQUfRSEOPgyVpGLhzt3C0aTiOEasbIulOc0TUSWtuB98oXThCxT0XuDEP/lbwnXN5iZR3mZpQeDF4klSvRPZwbzlHGD5aovMRBJvRRIUQYxY4H6alW05KW+3FI2H505DRWupcdFNtuluQvUsXQJJLCKxNvQjgNrNHEEiaTkyov27OEGIB0HK+H88KPXT7L08x/NxD8nKI8XnRc2mjheAt0xcSIgO0H7+MqsqPpDK0nNLNbCiL3WeUHeDbv01NmHUnCQilXJN//4NvlFiR41YDAAxgW42KMiJzXHIT5uPV1fgUN7JfKum5JRErkMJ8R9hy5w1r9Awd5sjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50WJel2EWduCPzoJTAotg9lXUW8nBBzrXxh+b8J93g0=;
 b=Xhku0eq0wichw8WcmiB2scAR/L1GyLlI6/q6vE0Wu8WsJAoscQmUkkeOX5z2kMnKGcBf2kd/piO6fI58VnV9U3WWUu0gsYXve1zAywSuGGaxeMPo1iP3OE9Wev7X9WBpHHgH0jSENaPysBwl8SdyLZt0SqZqHK93wU+0H5kT57U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Sat, 22 Jul
 2023 13:24:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 13:24:16 +0000
Message-ID: <f97ff066-d94e-29fc-b915-bf2c6a85d915@oracle.com>
Date:   Sat, 22 Jul 2023 21:24:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: add a test case to make sure scrub can repair
 parity corruption
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230630013614.56667-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230630013614.56667-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: d673f17f-06f0-49bf-35d1-08db8ab6f260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+9a7+hXt0jbNOWqbbPFWkI8gV+ILlpDEdtFxaYtk36dvHyuikJ/+8bAnhMyRiV71y8fhr5xle5gWd7uvR3M0H23e1N03S1wvmbaM2YkcTQHsXOGgt7eZAcCynv1/Jj1hTd81dDqgB5pOaP5SdjTx5hiwf9TIXQAxeeGE/PZy2Nck5iDqOMYTt7TmDmgPxMntSzymlUebNXvtPSZy2fDtlf1HL0OrLWAlR6WGCfHyVHq/VuvKPe8p9Cr97yZx96bpZ209ilP+v1YNQ2UWDaKsHY+v8j0QQt7oAnTz+r0BikaUoIOzn2LB1ZsDl1c/ERkJvvcVS7lVF9cfZ2llhtLMuDOJy2BYoPw/nxbIA8UpQijQ2yWABUouJHpV5VRhVHoq5Lj+dT6VZwpAKVINTa2ZM8nqcN/iGBW/u2fgsq6k1dk7+nTCfWtXm52YVxRweb/0QDpsHZ7fdA84BMrjgqPZzBuDpk83CME0M2KkAEF6HtrshA9rQhKo2snxLed0H3e4/uZKxJHkADjhcoYfGVFkxQqkuEo5cRlqhEFPfkklhXdVQVWKLOle+dK55ku716H4PJ6qy7bJqN7HbZ8qZ7JzCmzC8eIRScZZT0qx57evbsHJAw0cPVyxpXmrUUPJ5oNcjyaTN7Bi4ICz9ruUA++qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(31686004)(478600001)(6666004)(6486002)(6512007)(36756003)(31696002)(86362001)(83380400001)(66476007)(66556008)(2906002)(66946007)(2616005)(186003)(6506007)(53546011)(316002)(38100700002)(26005)(41300700001)(8676002)(8936002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxTdnM0eGxsNmJldStYZGhNeXNrU2hPOTN1aS9zdE5oYzJBYXBSWHlvMG5H?=
 =?utf-8?B?cTZGYTNDTHVYeXYzb09ZdkFWU0l1Q1dXOVdUVi9tWm1OM2hPK2lnRk1mdm50?=
 =?utf-8?B?MlY2Umt0bU9Yc2FORFZjejNaZ1BtTXBBQTdpSlJsS1BBUGtRSm9iTkFma3hm?=
 =?utf-8?B?VTBHaExBdFJmZmVTbU5hL0dzK1pYOGoxSFhEcnhKRmtuKzR0ZE5uYWo0QVZW?=
 =?utf-8?B?VXphZHh1VEMyUndUT0JoZWluSzlieUQxTXljWWFoQkJWcTZPODJyRXg0Mldu?=
 =?utf-8?B?MlU2OVpCbzZpcGxQSFRQWk9zSXV3WnJRYnkzR00xSkVLYU9RSlZ0NHo2aDFq?=
 =?utf-8?B?Q0VDbnVFREZwV2lGb0lEQ3NBNWFMUyt1Nk5OTTUxODFvNWJVY3JhZ0RIYmFt?=
 =?utf-8?B?TXc1OXQ4MUlXNC9lYUtnbzM3YW5VUEN2cE1ReUl0dUhXck9Za0RhU2JmdFg4?=
 =?utf-8?B?QkZoTFdUQ3VoMUEzYWoxVEd0dEtqZlNYMkV0OTNxd1JwbE5FRktPZHgwYUQ0?=
 =?utf-8?B?STVnSSt1ZWZOZElkL1hhWVMxSWhZdmwyeWp3YlFmbjZzbHMvZFI2cVNKQ3hs?=
 =?utf-8?B?TTBHL2hjZkJCYTdGY0hoRXBuUnpRSzBPcll2TGovRG51MlRQblQ2TGJ0TElL?=
 =?utf-8?B?ZFN5dENVdjNOV2JpdTY4ajZhdWNSZkhpTHNZTDVieHdKSGdSMDBhS2pwQ0pa?=
 =?utf-8?B?cE9HaVFtR2dTZXJQRitwV2NlR3ltdXMxMFVpQjlueUxrR09wQWkrd2hQU0hi?=
 =?utf-8?B?ZFJralg2SUdDd0VONU5SRkFZVnRuZ2Fnd0d3RGtNTmxxRkw4SGZoYXJSU3JJ?=
 =?utf-8?B?R1RKNWxvMTB2d0l2Y0dtT3MrNmJ4aU9sdlZmclBJVmpaZ21wSS9ZWVF2UGJQ?=
 =?utf-8?B?VllLRzJvcjZIUUk1ZXI2anhPT3BON3JyK3lFQXUxTWNON2tCeEExamNJZHQ1?=
 =?utf-8?B?aUtMUXVYRXZqK0c3MnhUWGZtNXM5UVVrZWpnQytWcWhqREhnTnNXa2I5WG9x?=
 =?utf-8?B?VXVhVlJBUlJ3bi9vOGk2VjdRZEEzTkxXWDcrdFdQOTRsSFJuelBaeFlmVjhC?=
 =?utf-8?B?RnZWWjJ1Z0JjZ0ZyOXIvQk9EQzVTYVpzdmJVaVZCYUZmOGt4cWdFZGdEYlhy?=
 =?utf-8?B?aFlzenV0Q1Q5V2k2Tks2ajc3YTQ0OVhXZWJjYng5RUd6V3QrOUpPM2xmYTA4?=
 =?utf-8?B?YjIzWGZUTjRhQ25UeUc3NUZzaXEwMXZPOURQamxXSzYvSW1tWXYwaWFubE5j?=
 =?utf-8?B?VGhKRWJXUWNFK25ZTGtOQkJBVGIzY0RESWMwS2dMTTV0WVVHYWVoUE1mSXRX?=
 =?utf-8?B?N0hRb3ltVUFVcENuUDNFam1GejN0VDdoVXVyU1Z1eXJkME8xVE1NM3F3ODc2?=
 =?utf-8?B?eEVQSWo0dUh2TEhwa3EvN3IrUGhwa3FQR1pPY2hBUjZVUWVaclRNQmRtY1Zn?=
 =?utf-8?B?NTBxMG5KRGQzSXNhczA0UHhJdjZrdkhZbjlpSXJtKzVmRkNtYlZUSGRZQVBC?=
 =?utf-8?B?MWlkSkVpZElZcllZb21ZUVpydVA1NnZEZWlJMW9XVUxlYUkvb3VuRU40OFRp?=
 =?utf-8?B?NFZVcjYwRVAwU0twQktDQVRmajFuc2g5OXorbW9lOVY2YUl3bWxPNG8vWGZP?=
 =?utf-8?B?d0tXckR6SHFWL24rOE83RmttS1dwZU1KTGZUTVp4bVpVYlE0OHFjR1hUbXBw?=
 =?utf-8?B?MEdxNEZIRGsybTZwK21sMk12WjFONDlVK0ZlZHJITlFGemxKUjdLd1JoRUsz?=
 =?utf-8?B?YXQ2SXU3TFkvMEIxODVrbytBK1hzbjVmR2VpUnRkbERabzY0T0VYMmluOHJJ?=
 =?utf-8?B?MGRjSG9SQmVjVHNIWHdKQ2RzZ1FLNmhDTENYRVk0R2dUcUlsNDBXd3pNenR3?=
 =?utf-8?B?MWM4K1l1QXVaMVVXYzB4R28zVjlUc1M1NUJFUnAzQVhqS1RsczI4TGZaYVRH?=
 =?utf-8?B?TkV6TFNHZFN3bkZXZkprVDBETFlYdDhScEcxTGFXUnBSL0pLdGlGM1haQUd5?=
 =?utf-8?B?eDF1U3QrdXV5Y2xqUmdtdERRQVBDTEUzWGt5cHluWjA4UEZhUUgxYWpseXY4?=
 =?utf-8?B?cUlTZmh0RmRLLzdnSVM3QlRjVHp6OURoTUhZSVdpTG5uZE84eWp3cEZSTVZZ?=
 =?utf-8?Q?EbVjpXdmpQO5tX0ZpFe2DQ48c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fcV5+B5QWohWMrUgfm/AYiuwixHItFYj12uGxWY7pjOtv4NNu7vizEUhnXYD2dn9zmc4cSgjuhglEfUfJCfWbq7Nf+oXmKK8oubO79lOXrDz4nWO+wJY7qQj9iOv6abdPDKeixTxPuTtM1TbHne1/ojFAVJBqFQuSly98+eMFSKojXAyb4tualZlqzOuTmu7oqSfStKQMsOW/qt0N6gyHpQCpmAZ6xH+adLIDpcGo4U6im9EOEYs036IY+m+4nDTuw8uSR18ssMp5tV4Zv/xYwWJVpPnmbsE/3io5/9Q02Y0l3bdg6Fc4AzvN9tcUb3cTQLE5FZzLNI8m19iTjgVjNlZ/1ciBy/WApknlB28coDf+UeY5ROh/HvAyLGR2ByYqd/OxQ+YvRWIUQDIA4Sp9OLfmuyHUJHjhvpEFadBxqWhyhlmH40DpJTua7Lu5cHmi2qRQs50E8xkdCWMt5W7u0VHe8Rc5EWY61cFVwK8P1IzAKYQgbiuLHYQUDan8Z/a/P083xVLY5PMVUUDT/PZkNkxYEdrwBIVvEKRstQoemavQ7ijSRbi13mftK5KtlFMBwVWgha2nJ4XIBtRP81m7W5mcTFz3BRjAIN4YgY+VRlRZmItlN2jgx0BKg8GwS5xsu98L7Y3hJp0qiEzAX+BG0Aj0R6Q3yQR9Y31fVH9UDoGl0lp1n4TCAQ5+lKjIjIGX7A0WUCmjdsD5LPz5g+CN+6t9/z2e0HYLmCr5CGbc3rd/sd3jiwrL5d4XhFo4NswEefGhkrwrPqaCZk2duATpFwNiAq1bb58sGsqifZ7O2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d673f17f-06f0-49bf-35d1-08db8ab6f260
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 13:24:16.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P5T6HyUUNMzGkT1Wb7R0C+wMxHcFdFfz0HFqrEYcw2GDQI+BHwX2hQ7fdFUaeLWWi4WHvervHY5KQ06fZmSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307220120
X-Proofpoint-GUID: BOT7Oc4FQ-9Z4SczLfXSqS62-62DuHss
X-Proofpoint-ORIG-GUID: BOT7Oc4FQ-9Z4SczLfXSqS62-62DuHss
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/06/2023 09:36, Qu Wenruo wrote:
> There is a kernel regression caused by commit 75b470332965 ("btrfs:
> raid56: migrate recovery and scrub recovery path to use error_bitmap"),
> which leads to scrub not repairing corrupted parity stripes.
> 
> So here we add a test case to verify the P/Q stripe scrub behavior by:
> 
> - Create a RAID5 or RAID6 btrfs with minimal amount of devices
>    This means 2 devices for RAID5, and 3 devices for RAID6.
>    This would result the parity stripe to be a mirror of the only data
>    stripe.
> 
>    And since we have control of the content of data stripes, the content
>    of the P stripe is also fixed.
> 
> - Create an 64K file
>    The file would cover one data stripe.
> 
> - Corrupt the P stripe
> 
> - Scrub the fs
>    If scrub is working, the P stripe would be repaired.
> 
>    Unfortunately scrub can not report any P/Q corruption, limited by its
>    reporting structure.
>    So we can not use the return value of scrub to determine if we
>    repaired anything.
> 
> - Verify the content of the P stripe
> 
> - Use "btrfs check --check-data-csum" to double check
> 
> By above steps, we can verify if the P stripe is properly fixed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/294     | 86 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/294.out |  2 ++
>   2 files changed, 88 insertions(+)
>   create mode 100755 tests/btrfs/294
>   create mode 100644 tests/btrfs/294.out
> 
> diff --git a/tests/btrfs/294 b/tests/btrfs/294
> new file mode 100755
> index 00000000..97b85988
> --- /dev/null
> +++ b/tests/btrfs/294
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 294
> +#
> +# Make sure btrfs scrub can fix parity stripe corruption
> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid scrub
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_odirect
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +_require_scratch_dev_pool 3
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: raid56: always verify the P/Q contents for scrub"
> +
> +workload()
> +{
> +	local profile=$1
> +	local nr_devs=$2
> +
> +	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
> +	_scratch_dev_pool_get $nr_devs
> +
> +	_scratch_pool_mkfs -d $profile -m single >> $seqres.full 2>&1
> +	# Disable space cache to prevent v1 space cache affecting
> +	# the result.


> +	_scratch_mount -o nospace_cache

[ 1562.331370] BTRFS error (device sdb3): cannot disable free space tree


Mount is failing for the -o nospace_cache option.

> +
> +	# Create one 64K extent which would cover one data stripe.
> +	$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K" \
> +		"$SCRATCH_MNT/foobar" > /dev/null
> +	sync
> +
> +	# Corrupt the P/Q stripe
> +	local logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +	# The 2nd copy is pointed to P stripe directly.
> +	physical_p=$(_btrfs_get_physical ${logical} 2)
> +	devpath_p=$(_btrfs_get_device_path ${logical} 2)
> +
> +	_scratch_unmount
> +
> +	echo "Corrupt stripe P at devpath $devpath_p physical $physical_p" \
> +		>> $seqres.full
> +	$XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical_p 64K" $devpath_p \
> +		> /dev/null
> +
> +	# Do a scrub to try repair the P stripe.
> +	_scratch_mount -o nospace_cache
> +	$BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $seqres.full 2>&1
> +	_scratch_unmount
> +
> +	# Verify the repaired content directly
> +	local output=$($XFS_IO_PROG -c "pread -qv $physical_p 16" $devpath_p | _filter_xfs_io_offset)
> +	local expect="XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................"
> +
> +	echo "The first 16 bytes of parity stripe after scrub:" >> $seqres.full

> +	echo $output >> $seqres.full
> +	

White space error here.

Thanks.

> +	if [ "$output" != "$expect" ]; then > +		echo "Unexpected parity content"
> +		echo "has:"
> +		echo "$output"
> +		echo "expect"
> +		echo "$expect"
> +	fi
> +
> +	# Last safenet, let btrfs check --check-data-csum to do an offline scrub.
> +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "Error detected after the scrub"
> +	fi
> +	_scratch_dev_pool_put
> +}
> +
> +workload raid5 2
> +workload raid6 3
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/294.out b/tests/btrfs/294.out
> new file mode 100644
> index 00000000..c09531de
> --- /dev/null
> +++ b/tests/btrfs/294.out
> @@ -0,0 +1,2 @@
> +QA output created by 294
> +Silence is golden

