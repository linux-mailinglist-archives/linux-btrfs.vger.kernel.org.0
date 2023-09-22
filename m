Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E227ABC07
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjIVWyn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjIVWyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:54:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C86AB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:54:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MLXoTL004296;
        Fri, 22 Sep 2023 22:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rSi4wlm1Q0OXqKsP5o2QneTJUJrOkfl8EfntB4V83BA=;
 b=zT120iZ7mXNEEAGgdygk42Yj9Sckfx9JXrwTGBDzomS7AUGB7hP/P4fbsgLs215QtxjT
 hLq211hMs4KxAHjdETxfZ+rDAyYfYHEc6ArQn5m6awYoMSwK6yDKQ5i6O6iiY4sBd7z5
 +EjM6DEdupeHuEoUCF/BUdBq+fOjR34g0cxSXPzP7e8LMzIp2DzZTEr49G9LUjFEUW9h
 I/ArAnERbCDvXaPiDsdh7WUwuuDNdaWtkyLpwKg57n8E3THkHYUSbQ5j318FONGRdJg+
 RbK1iMVFJRohR2FK0Rp9+HkGEqsp2avk+ZNOrVLaVRxml8u7DjzmQLx9PLgJWhMPs4Yt hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tswk1ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 22:54:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MLRZJG010272;
        Fri, 22 Sep 2023 22:54:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u1apqrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 22:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryz5hzivpOt5uJUl59t3+edt3QZz+Eei7jJEbeE9zLytPbDwy9VHrHyYLlkKLlCFXBwyatoJ2OHVmlDusqzkQgfjK1Ebys7znq3r9uHwXFxIk1WAwC9eN7Rh6SR01n/oL9nxR8hrgRDpS9K/ETf0+LtkUH+7R6XT8xFFob5HIBKC6PZIqlNuiL0qvtFg2MTK7KR+RC8fSKk0gWUzpQ1RU7ON/lVW7879fz2E23Lm7HITTDQKiYXY0rcsOeMxYawdCYR6/XhIMcRJlMdxDMwpMfZ81+2wXYhBrnNIm/AVg7MQlW1nM81jSwAdZuDFYp36G4tJN2xWGsdEvFM3jSxjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSi4wlm1Q0OXqKsP5o2QneTJUJrOkfl8EfntB4V83BA=;
 b=KNmG2+5lZfKFbn27upCtagEZ4cIjeeiloYqG43fEFE5zdgucZcFnnpg72txzyk3klPsn84A2kGAQkjj/mQSoj/Fk1XyvgqUpCooaB8R8uZP5fVqFkA4FB9fiM+yhWej3fOY/RPUxhhI1eDNWAiGySfncaoHp5u1o3CBUmVRPi0LarpX5ftfEpVQC++K7iaXz6rxVc+kjTWstu9zhRyemDm6IC0wKci+aBNe7P/3PjaLFI1Yr+6geOhnfywrdCXmrrxsnFa0xqWivSFQs3m0NUOOV+z+GPrta2BAoWCQ5JGjQcKxu33bn2utnfZIGpa4OTZihB8qqYJ+yL8f/EPeABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSi4wlm1Q0OXqKsP5o2QneTJUJrOkfl8EfntB4V83BA=;
 b=sYGW6gsTAsZI9TkwQNwLuZsU7YS8LNcW1ZNuzXmUQ36Jxx6eh+4JOnYCxYbB7ZtmwG5OZ13lZGGLWOvprl60my5TFvPRoZ83WNCLGDOf7GIK2vnkwMKrY5PVLXR4bwRI4D/QxSEPZ2Gp30uj7Hp2GB4uNbIVut2OLgF8zy7XtdY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4652.namprd10.prod.outlook.com (2603:10b6:806:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 22:54:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 22:54:16 +0000
Message-ID: <7921d2a8-1bcd-f7b0-e36a-b73f930447bb@oracle.com>
Date:   Sat, 23 Sep 2023 06:54:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/8] btrfs: collapse wait_on_state() to its caller
 wait_extent_bit()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333278.git.fdmanana@suse.com>
 <fdc55df022fde39acc39ae8bca91b960ad4f94c5.1695333278.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fdc55df022fde39acc39ae8bca91b960ad4f94c5.1695333278.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6970d622-28c6-4551-f005-08dbbbbed89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTyUjcpBidFU14MUHEhDUXRAoNzDdOM6ST2zW9jxJCzSniqzRetaQSzaL1pHqv0rAJLEQMzBtQoAyqt3kRkEaMJKm3gBIA8ZTFXe5gLd4ZzoIy27rMoz+xSmtk4q7r/kPkhOGxV136a4/2u12taXXzeIjFiaiRMcnITNWNduvxAy+EbxeuoVySmNC0dWblSqgnNr6ce3wgtwHHNNpGBymC+b9fprYPoh/j6yK5Lf8g7qxI1C47O0j9a5vwnyshZey1jKKk5kre9hjb4MLoxMtTy0znSlJL722X33N9XUP1SCw8HRnl/j52aaki6YMkY8/MMO5z7UUJpVd2wHIH/wScErr/qLAl4zd9TtQr6ItPn9m4DiS8QNXhNhHMifD7uNF+OKvP9wKBXWp3lXCYX9yoonLQoYgcWooNISwtVpdL1C7sl9Y8iemQ8AKsO5lNy/NoKKPEkbkODwGxREzft6baz9f6WH9JKdlW+++6lYWzSK1lc+cvHjKxufhY8ALuwmv0kcuaqMefuQoNV0mGBGBZsgHd79aH49QCDjVJ6L7YAUxEe6rqHtotmw1OQrBlEtZ7BY/wCBpJ1XfzLzae4frLSENzfjcumqg6TQP7/oMBlpdiFONsXtEqYpXMC1cIOcDzeMKXS5MdDeRUrsC8545A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(186009)(451199024)(1800799009)(6512007)(53546011)(6486002)(6506007)(6666004)(36756003)(38100700002)(31696002)(86362001)(2616005)(26005)(4744005)(66476007)(66946007)(316002)(41300700001)(66556008)(31686004)(2906002)(44832011)(5660300002)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1tcjR3UVhCeTFxVnlxbmNXaHp5SXROakhaWXJPZC9ha0ZRYm1md1VzMEpF?=
 =?utf-8?B?Q01HZnkyWXNNR0VmUjh5dERNTzNaNG9EK0ExaDd1MkZoMmRYeit6QlIxWEpF?=
 =?utf-8?B?T1lNQldWK2NIZlhhYU15UEpxRjRTR1prMWpxeVZpUlFCbEtucURMU2hTaDJv?=
 =?utf-8?B?MjdmTFVkQ25yUGFwV1RMbDJSSWhYeXVsam9UZzF4TFA0RzVzNmhrQnJ1M0ZF?=
 =?utf-8?B?YUpsVkRvQnlwRVhGMjVoYnBRNDIvZGRhdThxWlFNR2YzSGZZUE9FdnhzMVE2?=
 =?utf-8?B?RDk0ZFNydVNMcGF2Mk9ta3V5eUdDRFlVOExqTDhoNmNkYU1QNm9VcDhOQ0Nz?=
 =?utf-8?B?QnlTc1RhN1ZCRWFGckErNWlXb3NIR2grNmh5cFVWVGFxS1NiYVh5N0pzcWFy?=
 =?utf-8?B?RlBKWGhxdjJSRlFGUTZaMzllZ1lNdUp0MDFFTURVZDlwMU9EcEQ0T2ZmU1hv?=
 =?utf-8?B?ZHFIOTIvU3JQTHd3aDE3RmFhZ2xremdaNGxNZ0tOSDVpSVpreGwvVGFzTlNU?=
 =?utf-8?B?N1RxZlIyMjFPVmUrMUN1bVlIbWVTUmhOMis4R3d6NkpNRnhJUU5lOVdsUjZs?=
 =?utf-8?B?bVVUSjZZUTdoaXZIOVFnVnRnVk5INlc2WVBIK29hbHN0QTNKSFZjdFNVNVVK?=
 =?utf-8?B?dWtJODY2OUh4ckxXSE5rb1hJTHJLL3ZwTUdkVWpaQ01Qb1RwMFJOVmw3RzE4?=
 =?utf-8?B?NFRtUlZVcjVXUHV3aU53Q1EzS1gyamNpcXJrYkdvTUcrcG5leVA3L3Y3djho?=
 =?utf-8?B?NC9IN0NzT2xWSVY3V2F5bW1sQ094Wk5BaUR3bVRiQVNwNzVGTmdsVlFiVEJT?=
 =?utf-8?B?bnNvOVowUWpFdjZDN3VrV3FLc2RKb3lHMGJsWGowVXFsWnZNcW85dC9BUWJZ?=
 =?utf-8?B?alMvbHhOdk40eEpNbWVWUEplYmYyYno2KzRFZ0RhQU5YbG5rK3NCcjAwRFhP?=
 =?utf-8?B?azBzNGw3V0lVS2NyK2ZqR3dzd01XQ25oWjZYM2p2aHg3amtrbVArQ1NpUGFh?=
 =?utf-8?B?TmVIRkhtZ1NFZWtaTDh4WVhLM212NEVsbHY5NWdJbEpoeWU0WjdVYzNVd2hr?=
 =?utf-8?B?RDBLSTlHUmwvSG55WE9NU2kxVmpmNTRSSHdLVmN5L0Q3eWtiS0UvM2xhSFRk?=
 =?utf-8?B?Sms5V1lHQlFBVTlnODFsVEV6TkduUWlxTmhQbVdBZVRRbm96N3o3NjYxRCtI?=
 =?utf-8?B?azBxSWNGT1hvaHo5Vk8rNy83ek5kWVlYZmswQ2orT2UwbG4zcms1NWp5RGtM?=
 =?utf-8?B?c1hFNm5KNlFPRUpWNXVnc3lheFZaeTdPS2NObjBlNGlxRXd4c21MYWFpNXVU?=
 =?utf-8?B?K2JrTzhYTTdJY2RoOSt0bDNkYS9sUEkzTHFzSVlYNS9XV0NkSk1nWHN2YVRv?=
 =?utf-8?B?S1R5SkR1aUhFSXZ1aDVDcmFOc2luOGJJZlB4Y1ZwTHhXVy8zZ3BHOGhIcUlM?=
 =?utf-8?B?NnRPbEc1UTdUOG4rY055OWtFOHdJanhCWDBSYXRMaExkMnMySzVHMldHemRz?=
 =?utf-8?B?VmhGUmVoNUVNMGMvcFo3dWFzSWdBdXlqYWpBQytuald2RmMzUEU0ak1BT05D?=
 =?utf-8?B?R1ZUcDc5V2xwRU5iMGdvSWRmKzdGYWdBNmdiVGdnaHE2Z0o3NDNrMHU5cGs5?=
 =?utf-8?B?V09lQ3p5ai8vOUN5dEhZSFI1dzdoNmtsVnNNdGNvUG9YcCsweUpJUlk5LzBI?=
 =?utf-8?B?cVJPdXprWE5odFo3SWJkd29nOXNkb1I0RG1jM29KTU13Smo3YjVSa1g4c2x5?=
 =?utf-8?B?eUVYTThKUTkyODFWVFNMWWRnU2dBZXQ3aHVlSlplbmhPUlJtSkhlTXFtTjlC?=
 =?utf-8?B?cDJWY0M2WlZ1Y0k4c1VZMUE5eDZNT0hmNmZzUkFaYWpDSnZuNllvRU00bmdo?=
 =?utf-8?B?ajUvb3J2cnRQRTdITDE3TnkvS0hsWk4yOHprQkNpQ1lYM3d4ODFlMnA3UUxv?=
 =?utf-8?B?ejNGL3daUTVvOFo0ODB1aXVuNHVRWTF4VDB0QXRkU3JSMXlsbVI0TlE4UEsy?=
 =?utf-8?B?ak93eEsxTStrL3lCaFl1MjlhcXhGNWZBT0ZKNzRWOUtrTTJTRHhNY1gwZklF?=
 =?utf-8?B?dzliajNYYUZWSUFEczRIaHhUeHZwMG5LRmJjekh3SVpNRDdrNmNOK0s3Y0kx?=
 =?utf-8?Q?ewrzex2WgpXQzCx1R0R9miklG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tXa8sUkgamrdjx+eSrHMhFXZem0nYMgkI1Ckp+oaedH1PqMhqFRWxzckHMBzd11wKkDwUQUHw+re/8x9ERgIClbXerGmIMN5xX+sB7wiGO7WHSrK9AGCrZqFG6r4KzJLp+5MOMNG4V3ULL0qkS4wpVS0aF63FqBfAhNJZDi/CdzYCqvu3GbEhBWCQrUQ4GhdjuBsPaKDl3QxlpL0zIl3i9P1dOv32FmCrycLOpvr5zcM1zvsU42yRURgog2lnyA/JMZFn5MfQe3Kiz0bdG8UoD+WFDO2/GohiimRtAri/OM9hlXX/5MPMBmlAx92tTKlsOZpz1jYy2Bk82eIDIrs5tLcb2LIu0tVdhfROK9Pv6e1b8YVd3uPb7JWnrT/aVRUcOZ/m1G5ds0GcmJwVEhqzhIvdL5uyMm+KK+2K+EgJ0m/D6IQMCNizWdUcBTmxunnpc50fgLs3n210UjWt8cuiJGfyUAKDn/cTFH+EVfHJBeleZ23tTS2baQbYP543crbkhk7JYfZJPjaS/lptBu8doDIpc62ksvqW40rXgwqbKTIPYyNVxDz3rQfvdl0QRXMNZq9tnxcLFDVfFJpnGOSqRefofKfXjdtSfSEAqAZTYvWyog+i6dN3x2XsnyqVgHRenR5KvqWc9L8kx0QyFN/mO5mgBst6PI+Jst4eZSNDowFzXExX8wab6MF68fbLLBBDAaUvGKZSnum0zvXtUfx7FVtr/O1dqXwXklItV4BzP6fw9a8LuD7HcYeW9oOm7Vq94FmkSO3QCYMIrVqgtVBrPVYHHwfk4vLRn5i/2qAKYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6970d622-28c6-4551-f005-08dbbbbed89c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 22:54:16.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obWzmaZKkNxlKYciZ9o8YY2Uo7MF9QmTGJ772rqYYzDNw7ngWBN3Eq8gEVH/6xKOQFEudcQhwHsyBq8Vw+1w6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220196
X-Proofpoint-GUID: 1LUhEaXybfz70b86vyftRBJHmSGrQr55
X-Proofpoint-ORIG-GUID: 1LUhEaXybfz70b86vyftRBJHmSGrQr55
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/09/2023 18:39, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The wait_on_state() function is very short and has a single caller, which
> is wait_extent_bit(), so remove the function and put its code into the
> caller.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
