Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AE785A72
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjHWO1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:27:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46363E63
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDuQH4016114;
        Wed, 23 Aug 2023 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=My5Bwt98N8uAUYsVIHUSiTNIoM8KfgcrBdRZ0HK2YoOEiI0ZU2ndDd8kVTgHSJg44cmm
 YkmbZQs0buOSpIoq/7dIMQFnp2NVW+B7+GiBk6y5MOYRrHVUGbBDYTpn8o1C/1f6RN4k
 Fyl1saMMvB6NS9+IbKPeQoFppMx/IaSVp2dDEFNY/BB+MJ0y0IBZReno8uvH0Y/BUSJM
 k5un3DFsTicYJUISTeG4r+sMYgwFM4VmgIAyyB6k9fwf6WZOFdcwVGLgZd4KCoLvrtF5
 WlVs9HZt42l1zd5hNHN3g1W2sN5CT9JeNdDz4mgVSDPpkU3JyAWNohA//oBezxpObWfT sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20chvtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:27:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDvLK0002155;
        Wed, 23 Aug 2023 14:27:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yvd5b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ2flYdkKwlWeaJ6Vidnc+e92wQr4oxvOzKetLt58PGgz16JCc2bbJah78tNhIp6N3FcztP1uVUVZkxaPa8QsdtOEy6ezwnGgAr7DVcrjLMFV20w55290WD0cVsrXYwstrSl7kWgJrxMLQYFvOOevbUjTYZGwCqc2WwdYIR/4q/iP9tVNMu0ov7OmHo5Whp5Ok2ANx72MVO2BCkXAEP0sjEt5Z5nFYwvdnyTUdSjJO6SNKI7qoxB0d+J2u9pTzDrQXCdw0oZ9HHQrwcXUBASzXvTVQ9fCHcycfTgSzY7G39wVphS9a3PcsTL/rbzNEiQMupWAhuj6zdSCCMimQux2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=lRcdwoNXMv/xyeZP2L6lR3QpulOlYCDp9WNy2n3XjEOOw+uOyAk5ehQQFYXIsn3pGfc3BoeyR0z5ScvDwnb9pI/3wTf91DyuY5qoIgP9tHvcY5bgGehYqVRMIxO8ZqVdoiNp+q0acBFI2ZjLdL85Ppv2aUDICrQLhgi9LQaGvJQDJe+10gDxnsC2zc0siH4g5kzEQybuT0hE6uITvyLCep8J5W0+nluKDRdksFoURr5dm6qnGBHMYU0IailsG02UPwosqWMYlUa1ya93lbTVAP9ZqIQpCWp9U6vqf1UyjbBJtOH4GLVeP/ZEThQlBUzsgxNYlWjkYfVV4BcGGlLyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=FobVaHAdQbTG4xlqopw4CZjvuL1JESDD/5AY3ZdzWKnSIA7i5zAjdWNm8R7/IHU+ACkrE6OoxjjkgP4mMlgPyqhGPv8hntFazNrvoKFty2Zvjrioav0f7U49BFcQQ1Kk+h0rb6r3algYz3z7Y8yzsUTSMYXzxbF0WLoVrmbK7KY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7380.namprd10.prod.outlook.com (2603:10b6:930:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:27:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:27:03 +0000
Message-ID: <0420520f-d599-f855-894c-81b410c2ffa5@oracle.com>
Date:   Wed, 23 Aug 2023 22:26:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 02/11] btrfs: remove btrfs_crc32c wrapper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692798556.git.josef@toxicpanda.com>
 <8a7ac9267cb726add7fb8bec90eb1d50ddbd0b4f.1692798556.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8a7ac9267cb726add7fb8bec90eb1d50ddbd0b4f.1692798556.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: e20e68cf-f483-4518-0a4c-08dba3e504c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJkxxEZYVzm0PBpETmwu09GmnMxKefWp5EgD4DFbjaj0WBWHBBakBiShPRgRK8mNpGcQikPmx0LVkAMbO+0WmLUH9JsKyfOpCWI2lmLPz4wW80pOb8NDhtaJ3amW9JCoX8CdQwnIoSC8M7gULo5Lwz3JD1086qEVQjGq7dDwHBs8ZraZaEl2UZFIsUrehK6QJPOG6GFa/YCkXZNTfemjAlgbCikN8ewOCMihZFAQoU4pIVwe36qZB/sFNr1fzmxabwIZk4PTms0enxGRQ+49nVfYYjJz4Q5D5DyR98MjNw7f7efo1ogGJ/xe3BuohGdEvpu2qkcCNfykGg8++L8WCjOZh0wCZVkIVASWJ9vcr3N8qUmGyDpN2xQrwtzL8wNYwsZ2AAhCM1g7rfpA/A/18XNNjdAt54ME+a7mOhqQlQjGTVKrebK8vOVRi0hq9dN19VvgRHzOBCLZNOv9q0YXhl4kyvvT1lMdKmErogEAQKdnCwpAvueHrx3dKlGNh+Smib2f8LkrAVyoIt/mdyHV+h1mrpRmrrV9D8JDJ0Q3neE4YMdO1MwfeeCKuHZjTZ7jVzbWX76GK9X4dgHbNyaNJEKiYyp2R95+L/+TUXVgFwVlgZLC77+OfrEvXcFIALgSUfMawwWJK48KHoDlnQnMMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(6506007)(38100700002)(6486002)(558084003)(5660300002)(44832011)(26005)(4270600006)(31686004)(31696002)(86362001)(19618925003)(8676002)(2616005)(8936002)(316002)(66556008)(66946007)(6512007)(66476007)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlZcExCUHlBbGUva2MvN1R6dFlONDVNY01keVh6TTJZNVI3YXdKWlJDV0FT?=
 =?utf-8?B?ai9BSUVlekVjRVF1QVM5d3p3YkZLbU9OQU5NRVFadVB6c2k1ejVRTnNubEJQ?=
 =?utf-8?B?VnBxMThsRC8rd0lUd2xVM2hKb0xZeWNRUmIrMmlDUnNUcE0zdkJMTWlQeTh3?=
 =?utf-8?B?NUdkUVR4Z2xwYzJtZHNsMDJ3TTNTa0ZZNWlQYnErOHFNM0cxdTY1SFBLTVVW?=
 =?utf-8?B?cmlwNEVndVFwa0xVQkJBeVlPamtHeVFrYXZ6ZndjWW1iRE01YUpyRUJHYlk0?=
 =?utf-8?B?bmk2VCtqVzRiTWk4NVUyay82UE0zQnlvRDRmTDRQdkt0MUJ5eFRYNXVTaHNS?=
 =?utf-8?B?LzZvUFh3a3dLVHhSWE5yWHNFOFU5d2I0MHpyNUVKcjlhNmVpMHdYS1NjWVlT?=
 =?utf-8?B?OUxoMTgxL1hrVUNlTTBZclJFUjNGWUd5ZU5vNTNXcDdmZWlRVGNaVndZbWQw?=
 =?utf-8?B?bmZVSVQzS2dJdUdjYmpQMTFiNTJNcU1CNnI1Q3FrNFBEV2hYMWhjb2JPMHJS?=
 =?utf-8?B?K3BrRjRpTTY3RElsMXJreUE3a3djeHR0UHh5SCtyTng5MWJHNnVtZHpsMlJZ?=
 =?utf-8?B?NCtBblBIUTB3ZU12NUZBZnZDSGdXY3VFUzZmMUdob2V1WkRxQW5NZVp4SnRa?=
 =?utf-8?B?a280ZWM0eVFLUlZEMXdjaWNFQzBrcGc0ZW9qRGovRG5nV2JRUk5iYjR3L2hh?=
 =?utf-8?B?dlVZWFBXUU1oNzJlWDF1WFJ3Y1VjWTdwZjNIZTg3ajRiYm4wK3YxUWpPREVW?=
 =?utf-8?B?eFNtQ0pFSjZtMjNDYW1iT2p5NXZqdkkwT0RhQ3oxSjBNRkFwUTIyYm1hRGNy?=
 =?utf-8?B?VE9zYXBjSUFFa1BSYlcwbTNqMmtwTEFUU2VDbW42UG5lelNIUk9ldHNjdWxi?=
 =?utf-8?B?VjZHc1NjNmZ5MjcwWmd0aXJCTk1PQlk0MytLZjZTVGp4b0JQZ0pZTHdGL1dZ?=
 =?utf-8?B?cnNxdG5ESEpNeUluSW5NY1FJOXZ3cFRsMmRwek5HRXo2WWJWSEt5aWNzamNs?=
 =?utf-8?B?Ylp1NTNhMDg0RmZjZVVRUU1WdS9IVS9RR01mMjRoQUMwRFZob0VVaEc3WkpW?=
 =?utf-8?B?cWlPdElyUXpwOG5HTUNHMzgvdjB3azB2ZW4rN0g0NDNDVytxY29jSGJobnRD?=
 =?utf-8?B?K3ByWW1XeUlKNCsreUdaTHBFR2NmdUUyRnRWalVKUWRNZzRLQXlFR1BTSEg1?=
 =?utf-8?B?SHVyaUVieGNLd2srMkZtYXVodEljYStOQlhHZCtPM1c2OWRTcHZiSGRLTnU4?=
 =?utf-8?B?QVZOZVk5SFFCbTU0STAzOThtSnFkTVBMSFFCM3hiS0pJb0dTSUM1MTA5TGlI?=
 =?utf-8?B?cE5wemQrQjVLV1U5MGQ5WUdZNDNHMDhKMnp6bWtMRGxGT1NpbWYvMjNobnlo?=
 =?utf-8?B?Zk93SkpaZDNqUlRWdGY1NUl1T1NNUUNvbkkvdnBDWExISGZWb1hPYUpwQkVt?=
 =?utf-8?B?QlE5Q1VDTkhhZmlYWHR3YUxnZHNqQjhMUEZVck9PYmhNczNTNEJ4TlFEdGRV?=
 =?utf-8?B?VUhpb2praUhpN2tkY0tmQ3JMTTdPKzlKbjgyNVQwTFJRc2wzWVJXSFFNTFk4?=
 =?utf-8?B?dEx5a2FDNE0xcUhpRDJ0VHZqbUVuc3I1cnpZUlhRRU5Rc1ByUjRuK0R2c3dN?=
 =?utf-8?B?ZElOWG5mRTFKMUFYZFNraGlSaS9ldTVoSVM4OUVCdzdudk93Njg4WG5tZzdF?=
 =?utf-8?B?cjZ0Y0FEY2FpaGtJV2hVSzNHalRJR2FYQ3BNaWE5TzhqZ0gwRGM0cURqSWN3?=
 =?utf-8?B?eVlES2ZnUEx5RUFyYnhHN3BEVVNKVSthc05OOG4yZXBxaVpLTHlYOUVVZkRu?=
 =?utf-8?B?QmFOcTg5b1E2WXdHMmdkWnUzZ2w3KzBndGE1Ullmazc5Z2xXakNORnR5R1ND?=
 =?utf-8?B?VWNkZmlBeExFK1JsVXBmd3d1WXFGcVpQVStIQjNUbDhtMER5WFBOQ1c3aUpI?=
 =?utf-8?B?NTRaamJCWHdwODBXTDl4M0RiY0dyNmZKRFRCdmFIclNHZUU1NzhheDNEN255?=
 =?utf-8?B?d1hNTi9EYndhaStsbWo5cTVFcGlyV2xSTnJIbldHNFJlcloyditmMVhmYldj?=
 =?utf-8?B?dmw1dUpHOEhTZjRaUEVvZzJuVHlVeGswQVRRYkNoSWZ4WmNxNEU5QU1YUkwy?=
 =?utf-8?B?VUkrZUpnbnFFT1dqN1picFAvMkF5UUtLTDhlL1c1Q29FU09mZzdBd1c2NlIz?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sKIOovd6VwrujqlnubN1Y4U8/KWqT+IRJvrPn1yS8w1esl5D4Y3gYTxdZxzaQZcX77hCblXXqtGPc3AfcGrjHNCfdWfOfth/mhX+pJ+HCPKQ4HDe1SDCNtB2XYxA4Pqe2hBBWcwZmT8HVhZMI+r1sSPvY3bzZMmX2aKt9ysW6t4g5QI70xxmrrXrDb4Q0GByGAiVpzDNnlXomIJc9ld639bXi9J3aiXZPhqKa1/bVfMqE0UyKgMBZq5PUfDkPX1CuQnLmkSk6aZL+huA0xUy8l26eNzXBsE8YWo1yaCRCqrQzWNFTIV3MIyN9/j5z17KCYXCiW+BK2rY67g2UQmRc/jWkWAQsqV4RjWS4LCsB7Qego3f2tCdVwwIqO9VkgaUo4akNGxl7CbYFy/Eb7d+w/QSdJaGeHhDeTyVhCjGDTxBcqwOscYx05i5dkZmeVjCD+G7IgmEeXsg8euFulzz1ki0nYJTb3lr6B5RNc16cPFx3bgH/VElVGl7aay337PdXqbAlYIsl7htKfeFzmz5dFbhL5Vm1kVqnmdhmn/aXrtjctaxJ5xVCpFg87DGOoR/bVKIjKNGnRJYvyaiyGoJTwjdUocVcNxuko3Zd329eOQlZI3mYrc4H6lSAaJrNkxfowWLpLEJrwlcje5a9DizNzahOvD/pzqmjR5hu46Ax+mULQSHtupdmGM/EtWDtvLUURRx/fQY3nyI7DQQDRBgzAL3AYd/UAsnP0Kwbf6M2qaTh+UGDEcvBNWftTA2GNuvZ0mwEzEZKd4ughETn9ukTnlkCDP0F7xXgZaijyyCLVtcyfQc2twF1I4aCA3A2Fxz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20e68cf-f483-4518-0a4c-08dba3e504c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:27:02.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10uCmFEx+H7tFdDtRZVvIFti+ubL+WCijJDHnZZgkjxAGCMWZDcXOI2FR2g2vhD8hIigdonnR1jARGZTRGGEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230131
X-Proofpoint-ORIG-GUID: Jpl3WQHx7iOjDEQJ8vW7pp5-07zVDQ0Y
X-Proofpoint-GUID: Jpl3WQHx7iOjDEQJ8vW7pp5-07zVDQ0Y
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
