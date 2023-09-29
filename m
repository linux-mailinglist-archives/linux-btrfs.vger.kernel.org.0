Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE927B2F64
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjI2Jka (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2Jk2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 05:40:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3E19F;
        Fri, 29 Sep 2023 02:40:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Tjt022482;
        Fri, 29 Sep 2023 09:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oXcjqoH1j+G2a4L4SYzIgIhmu0CrNM9BgjgD0qEnado=;
 b=fhhDFq4zmEuMDE0+6pttptk8Jy8xDPN2CuJUpdY7FqMSk/JxQTVfuin9AFPe2i2nsEAQ
 QR/r/za3d3EDfXTGVK6AHpyOos6yJyaWOVKE80KOnfELNPWSxQoUJ2ZhfK14BZSkJk8q
 T8QW8FYcdg+8J/DCqObzYoR1SNDo95IxLDssm3Q9vwwRWIAHLj7q5ePTsV4NP+YA6Oko
 LE3PeUzuiWsha37BKvIWTe0rDICFTzD+qkqFAtiTa6YTEQwDr0PNn2Yz1uE/VHG0qPn3
 oPiNDM+UBrRF8IIQ2GOtHIpToXh/efM+yatOtgtblGsFQR48DfMkM3zd1q8m0hjzS0DF Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbp9mj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:40:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7uC6q040712;
        Fri, 29 Sep 2023 09:28:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhb0p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM1pNekbh8pWVizIyKeTONUWNga3RpXyakmyzhQF7ZGfENHL8a/Vv/StOpa9UISoC/LjNSvOVCsC9tO0eC2OBFUv6fsmVn+CZnTAzQ4dfr+wLu9x57uQxHiLKAtWLZxyJLhOdS3NizgWA+SzGkqNDy4xhv/umRyKqNP76SqCqT80FPZN1Eyx9mhscrby6/EY3tULq7sihNIQdjDoJ9knbBRnO1A5tbEe8FXKCLbFRdmrJr4MuYXKX7+1b++P0w/zR5Q/5b0wY8XbIOGo6D45YMioiwutu+UHs2aMmdJhMcWXclEwod4CqOPnsAwJga1aAU747sSV3/nKHU4uo9qBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXcjqoH1j+G2a4L4SYzIgIhmu0CrNM9BgjgD0qEnado=;
 b=jmYE7EYot1lC/95rh47mMfNBlkIOoaZanKHKAd3HlfoybO91ryFIdfpdOfUrLtu/m8CwpT4B0ICrvvWaf0ZwZdsPXm8x97npQ2hQ2QXx6o8i/DvtkR6B5YldMu0S0UWp4YRGO6O2xzBccGwJTZEYVz3fkVG5M0I/DJZODFMg5QtfMi1GuJcBALHXVjwisbiniRryJoUppe/ZInpUS6+nBupucJDf1i3wAkJknmXwbZO7lbLDKTrLQU348tWQkTgN/aUE7j5zDYbYvLlQpBfYf+8UKnVAZDxaHL193THc2x4Vm010CdJ1/N+Ldx9rAFmvo7QJgKPMDLigEuMcmTFu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXcjqoH1j+G2a4L4SYzIgIhmu0CrNM9BgjgD0qEnado=;
 b=Rv6Y9/RIYIaAfb2BlZCzqtdBGoy8a9lry7YEDv0ouecPce2y9txjZjXQ+IiKIAB/TyEzOIERgoppy86qJGSk8Z8q2yQun7t2HDrQb/Z1EU7LBwhdqbu0UQNYQxTgPb02JdYp1xYoH/DGmeswpBBpt9S8+JB1zRikgJTVyQtdOkk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 29 Sep
 2023 09:28:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:28:30 +0000
Message-ID: <a1ca9981-8ade-1157-56af-e77ee07e195a@oracle.com>
Date:   Fri, 29 Sep 2023 17:28:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 5/6] btrfs: use new rescan wrapper
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <7264ca978836109af1be53f93153837ede2705da.1695942727.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7264ca978836109af1be53f93153837ede2705da.1695942727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bd4b3c-683e-4ee1-393f-08dbc0ce7168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jp/pfFrTr5LXcBSf0NpzBD7zPqsXtzu8MxzvDPuHB4Rwdpi+FXS8RY+xwWNKEBngl4RD/oHrNLEykR64q9uq6pRxLJtTkjhR3gSbFFT/tFmbhFPy+W7j+E16qBtktaw0bQAr/BEZaF09xm2uVQAxoTAYaYRtMhcHByrqXAe1B+y38PfT2HCTYATvowvdC/gLqSjyO8ahAYupI4LA9Gc3ZagO7wLz3r6/+J4oe84AYyAZ2phyGXdj1iW77hSjc/zwvuyVjWH07v9+2+KNzaTrCIPPvOr4uvVruQdQtd2UczKYpoYpJ3ae0Gq5VfwZIemBZCmpR0KnNRlQaZw/Y0rjjjaT/y4f5rJQNvrLGM9SImKjONnpLY5r8/Po8tFqkAxV43kdFS970q3GMA6RQYjrqoLsKvzfMUPPilF87I+iDLeljRKsnZ7a6m5mrRIYCd9ShP9kP7/86p7pB4GC6lXQ1dn75JykpTskFY7xvvUO9lKOr/vZEmF0AlwKMiRLsf7wlE7CDXQrUP3IJ23KuPhFLHPBqDpKf03qNvxBSROWPlke9uoG/AVdXH8Q+WwDuRMwh6bH4M9KMsjb7C/AP2F3HdAOuRmTQpoTikGxyiyN++VAr3hQbs0R9gdNdomuLH8MC+pX3EYgQ3oLDg1FvOQyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66946007)(83380400001)(31686004)(6666004)(6486002)(66476007)(478600001)(53546011)(8936002)(6506007)(38100700002)(36756003)(31696002)(2906002)(86362001)(4744005)(26005)(66556008)(41300700001)(6512007)(316002)(2616005)(44832011)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHkrN3Z6bkxCZlMyUGNlcW11dklueGxKNExaMTNKYVdVZ2MzbmxTNTFCUUE1?=
 =?utf-8?B?VkxtSjRSNWVlWXhESmZyQ3VISWNoWVRZc0NsYUp0MmVXL09oSlJuYVorOTVM?=
 =?utf-8?B?VlVvcnhSb3FERVhEME5Wd3BkSkpTZjJzMzBaVWRybGhXTE9sdDhGbGtYdkxx?=
 =?utf-8?B?b2pnb0lUbGNyR2tEOExiWXkyb3BuV0hzNk53Sko3V3lQekZuYld6NDNiYk1W?=
 =?utf-8?B?dXdBdkZyRDlxUjRZVmJrc0MvUkxLSTVRV1VtTTZic2JORTBVdTlwNE5yUklm?=
 =?utf-8?B?ait2K3Q3NlM4S1ZKSnN2c296RFNoT1E1dG9CM2ZtTTVFUWY2SWtZUmRZYU92?=
 =?utf-8?B?bjUxRGtrK3ZFTExaM3U4VGRIdHhYS25mdTgzWnZBczF1VE5sS1RNbDVUVHBB?=
 =?utf-8?B?aGZOME42RWxsa25DbHpGc2xMd1RjYm9XWjNHLzhJVUdhMHQwMTlucndLZGRM?=
 =?utf-8?B?ZHN5U0VNOUdMS2RsU3dzeDJ0elFldkpMcUE0aDNHNG9wK0UrZEdaOHU0SDRj?=
 =?utf-8?B?d2lDWmIzMit2MHRDZE1TcHEvTnczU0J5bHc0UDcvZEhxZ2F2WExOOUpyM2Qy?=
 =?utf-8?B?ZEdsU2F6WlQweDArZVVyMURkMVFlU2R3ZXdUaXM1Y05SYkZrTGN1L1RKRUlF?=
 =?utf-8?B?eGdtOStvYlIxbU5yVlh6eXdNTmt5NEdWUlNsUU5lTkxLOWtSUi9XRDR0Q004?=
 =?utf-8?B?R0NOMVpwOFZqLzdjRG5RSXVIZllTaXRKNDdPUWpIZEo1RGd2NGxobTduYkt4?=
 =?utf-8?B?d25ONENxOUhLUWE5dDg0ZzVEU09ZbjN3SGhrR3JJT3JPa0V4MGRHN3NuV0ts?=
 =?utf-8?B?eGpwZDh6OXk0TkhrMlBaUmxCdkNJU2xpRXFtcjg4OTdXWDFpZ1AxNklZdGJF?=
 =?utf-8?B?TzB1S0JwOXg1TjBDdHlRL3duNkU2WHZQUGFqcVpObWNkdHlQeHoxeHA2dmxW?=
 =?utf-8?B?SEpQUHFoVVdRNXA3YTJFSEQ0bWJNZXRycGkzcUhkM2tGYlRtRW8xaHlPNElM?=
 =?utf-8?B?a2ZhY25FTDRkODEzY3ZMUFkzTVJDVWtSQXQvYTFDS2VCU005SWlNczVRR1Iv?=
 =?utf-8?B?emJxUWdJSHpLaTFGTjd2dGtQQm95VUYyQy81ZlhtUnRkZWhtaktZblFTQURF?=
 =?utf-8?B?VkdtaElRcU1nTE9mcFhFQW5CbXI0OWtBd1NVVndNcGtMMzdFUkYyVG40dHNo?=
 =?utf-8?B?WUpxMWtIZ0kyN3lFNlFjaDdJS24xaXFxU1BDUVlTbG9HSVd2eTlIbzhMaU5E?=
 =?utf-8?B?SHdPdkh1Q3E1eWJQOEtlUXJpekRtTDVtOEZ2TnNhbVhNeDVKeGRtMkwrdGpm?=
 =?utf-8?B?WjBvWU1mK096THYrUk1rZ0RuV3N2Tk8vZHYyK1ZUYm1Kd0lKT1Q1cTU5Smdn?=
 =?utf-8?B?WERic05LOEYyRWxRbUoyeTFVWVZSd3ZzUDd1UHBVelY3UHIvUE5aWkpNeWNs?=
 =?utf-8?B?cjNpVm1oenJUM2djeG1BYng3SCtDNlpwR3hZMVRGZERDZWZxM0wrWHUzcjZB?=
 =?utf-8?B?MTR0QnZWL1hZTkFLdXRsWFVJWllaZ0prWWlTUnREMlQ4RmR5MjFOa253bzdt?=
 =?utf-8?B?REo1NENFRmVrdHJuUjZ3ck1aV0FLRThaODVhZ0pHdjdBTmY1c3RESDJDUDZO?=
 =?utf-8?B?QmRtWlE5ME9UVzBtVVVINHRmSW5UcXAvL0J2alJKemZaN3dTUnZUcGU4ZUVT?=
 =?utf-8?B?RHR6STQ1YndCRHNIVldwczVIdVFpVnFvT2l3T2xzUi9TVmE0NU8za1JLMEMx?=
 =?utf-8?B?K0tYVkhOU1NKcDcvKzFxSDA3VDZPNzFMd2hrUlVCTklZbHgrTitmbTFzdG5I?=
 =?utf-8?B?L0RvV1FoS0Q4dTlhM2hLSVd4eE1IY1NPNHNac2NkTXdLYnd5Nk1GeWtQNnhJ?=
 =?utf-8?B?SFpwb0M3UHNVREVxTU13RGpkK0NLdkZDaXZVR3Z6TjdmNTBrREJ6cllTTkVP?=
 =?utf-8?B?WGMrUWJPVjY1c3hZamQ1a2p2bWsxbGp5TC9ZVUxMaHorVG1JRTFuWTFEWTg2?=
 =?utf-8?B?L0ZuVXVSemg1SlBaTXhGbFRiSnpTbjRvTG9KNERDcWkzSHlndTdHdmgrUjNB?=
 =?utf-8?B?citaSlJsb09aelJvbGd0R1VZRG93WDlFNjUzTnpMUnBGYlltQXVKNXZmbmhl?=
 =?utf-8?B?QXJmTDN0NmloRkExaERwNVF2OHcrcGNGWWR2MnF2M3d0Vkx4TVRyTUZ3UWlY?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gq3MOauS2aWW/LGsbIaXr789Wa4F5Id9awWbUXR81kqnm2EyVKxTZmrNNTzXijbi6AR0Y+ZEUjXFzj8gYp/EvcxpQ790OjtG/qvP5WCW0Y7eCYIOCTz39P8iVDSmpEA/pc0kUE8fkAd3sfF8g0h4z0eOOJGeNyS4boMfkkQy8ZfpROd4aQtuK+V/7Bs3GvHrpDixEnqc3F4hHLRLxk07KLmCYvLjxyXF63dp2egoxYy0iUPpbYnYM0l5Ku/7gWNPcQCiVWG6dq0YHEp/Mz9Lcw0v1EYjYpLw+HalgPyqlYIgTS1b3f93DnsC8IK4oLG0ZZH/GC19sV5G/3HUoEnAuV1dyZkuiMwzHL0a9Jyf0mqxKC+SK52wUjtvn5kD5nuquTK525szBaiYmL3PeFDVr3C5ZCtBf5Yh1hWQ9n/CMaRlZa1x85WnKOrXE2vma52VE9s5v9fu/pQPNAt7V+bgxaXPSEFoM0NXHRcS9KCnelQSUT30fYmA59Sdmf0WoXB/YzVX6pT891rrnAOWVIGKgOx26/5Sw1DXzDtErAL0GYI2gp0+NtrLLWhReDrkkqz8iYeJ0Wv8CFjS29UtbOf9s0xB/rioDDOVUqXbA0ccy2Nm0Lv+HSE+Fqr8la0GtCc8u+v6kKQ0ulW9IvtXQZUD+77qY1fVebBcT77oVExcSAbDE6pJzymFKNiHKXFQQhM3aYBu7v5e8ZhgZe4MtNhxlbzEgTlqWt+gRn0GQ9zplhjRLbdMRD845WdoqbU6Cs60wVZ9ZEhHVePtt+44hx9WldYvuywANRtJ7B8c0bUbBNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bd4b3c-683e-4ee1-393f-08dbc0ce7168
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:28:30.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYx7mGeeg3WeYCNgnIqTQoKvBkFPzQnkUtzRwy40jWqSXpLxtRhiTFgxOPe2txUP91JqGHS9B+qUepZFzEJ6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290081
X-Proofpoint-GUID: f1PfviabkxZu9oyP4qqZCJh-uBDm40MB
X-Proofpoint-ORIG-GUID: f1PfviabkxZu9oyP4qqZCJh-uBDm40MB
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 07:16, Boris Burkov wrote:
> These tests can pass in simple quota mode if we skip the rescans via the
> wrapper.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand


> ---
>   tests/btrfs/022 | 1 +
Nit:
  Probably 022 should I have been in 6/6.

