Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91070F153
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbjEXIqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjEXIqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 04:46:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2C12B
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 01:46:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O8OtCn011649;
        Wed, 24 May 2023 08:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qZYSkKULEujxHaKigq9XEwj2NoJpw6I7bbCzLsD9qUw=;
 b=knrH1DZrgG5oFijo+zIJv1QQy+6x6FVfyl1kz7SKM+JHautRYr7Y1Li816ZdVvihJIxq
 IbbM1rRSYKVE+kIAm85OehEDTi0jzE0DbZifSmFyC8XmZc2hO9gQBzod8OGcqJLjMDBb
 X/MPQTEkJs2bOoGbT14KbpA0vTW0DY9pUWVSZdvmOCaht3hEGXUUqyKdi74m79BPZeTL
 pDq9qgvWvcf4WlY4MyTTDFFJsMencnGYtoJQIM69r7cmgBXCWzmrAaHXenL6R5MEEGSm
 Ybqierdu0bApnJK8grve7wbsBs4P4y86WH1QJgMO5yz6MQ+T/7yFFSHl53dxRz2CD2Db oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsf1sr24k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 08:46:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34O8bAdV023878;
        Wed, 24 May 2023 08:46:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8vfgew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 08:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juXKuJbAkAMuZYX9y0PyWr8VoVaLi7xonwIT2tfOPz7pv5rHn06EgNsJq0hnTKnKF28QKhlQZI0GnesNFb6HzlK87UHyOMFGCkpQHxA2lM5deLVkAe3n/tiSwjCOn16dx2wlNjos5ziQePDGRJ7+TdBql72ut+RKQxnn1Z3pT2w66/ah5C96+JZeIlVefrpAP5jpi/3TwT4fQmJXdGBkmKpQboJbxUOC+uNqQzwgnLMvBwdbVyw/ORooYjaC9TFeMpe6My/IMLvM5jweBahNR291MYkFE0v6cFkQFBi1mSgmGsXSLuH8O5a3Ke41Tu9nurXAM2QMhfUqVQ//S+M9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZYSkKULEujxHaKigq9XEwj2NoJpw6I7bbCzLsD9qUw=;
 b=aY3EzxeLDjd4ZZ7+XKUTvpY9iNqyK72xgJt0Xuiyd1wPapfhDXJYSOzqGOT+UROdhbTchoOfB8FR2jukUbEBPWq8GKq50Unr8YZw9UPOjpmxBt6j5hPqWGvy9QWvUjzxoGNeXCJTw8cMxsnQUDMGE/r6NCqorQA/ub17osEx96g0A4zKB/tKGa6brmmJjKToR04AoiLbeIkn8lfQyJUsPdAR2PGh+L7YKVDjOxDS4doBZ/wkn9819z8CtBIvhn+Wvvo/Pf3x34BGqgzfiqqgXqZy2/7TEtZcmTY4RxYo9cMDO21H21pM5w32EtCHX+3NsLIq5iXzEvXzBDk7GR6knA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZYSkKULEujxHaKigq9XEwj2NoJpw6I7bbCzLsD9qUw=;
 b=L8izEPHcHimgOMV37P6FPx0UEAjxL7bmUbQ9s4W/dZDrWQvtxZFDKpxoyQoC6IvDH1c1AGgFyywfviiqOSHgakalYirezRwBQ+AU2ZciH2ilS/G4Nub3/iEbMdqSkk3ZbopnibrYCc7RG5i3iF64BFIx6zsijXTz2iueiuwQ8jo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 08:45:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:45:59 +0000
Message-ID: <f6622e99-74e7-fb62-b9fc-359adba0f932@oracle.com>
Date:   Wed, 24 May 2023 16:45:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/9] btrfs: streamline fsid checks in alloc_fs_devices
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684826246.git.anand.jain@oracle.com>
 <5113dde5d6f756818885c39bc8ec6f5b8e45ae54.1684826247.git.anand.jain@oracle.com>
 <ZGzqDIVyRiDT7PSX@infradead.org>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZGzqDIVyRiDT7PSX@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: b01c1412-9cc6-45cb-f633-08db5c334c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +y9DX11IvurWbOIkzMdHycXpGF2zbJZm10x6h0tJBjMDxS5A3h6jlPVT3OaOTMGqtTuPpPt7QKb8iH8QT268pBU3Xf1tnoBYksU07/Ct786TCy6y1h7XXxe/pkXjqKoUqawoP6mw1vNHH9CP+p6tjepwB421gFXOxgqEC4IBlZADmtQqTO1zLDnJBgBsW7mZSEQN//3vALy6VJcDAVXK9DGf6d967hgCUgRe/xK/XAYOk56DEnHDzSXXSrmrG891mzULnJ+JPHmSkFaf9Vf1hWYN0yKW9V76wmx1H0Dn6pRQ4LvoV9tTRlzC2Pqhd6bmN9pgnkeT4U1L4JfkHtV90C3GRx8va97JJh/RjY2BmGg68wiLDTsOGbt1pf9wBOTIWejdobvNo/zb+MmMPKyzFH2uELAhM02kx/k8vxoM1M1/G/chtjyClmjSV05vyfcjDLLVLduZW4/C7/syJEpkHnT/TuOpkuYMqhRToCb+oeOyna26cPMtTUEBwiV8zLm0Q0RlCTx7/Mw5e3au16keExJM5XALhsaafhihZ6HHQaBmiBXpyAM/p5MiSnyyYHHBsLziFKEym8VHdorR/Wi6auu/O0QaUpUKIxf1u6atM6Tj1e1DQoJXJoe2kekzi8rhJwirHDnsuCKvhfZYdarvdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(41300700001)(6486002)(31686004)(31696002)(478600001)(316002)(66556008)(66476007)(6916009)(4326008)(6666004)(66946007)(5660300002)(86362001)(8936002)(8676002)(38100700002)(44832011)(6512007)(6506007)(26005)(186003)(53546011)(2906002)(4744005)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkwyb2xWVFFEODEraE5RSS9UNGxEb1E1S3VyK1BGc3JUVGJJRmNVQis5UHRI?=
 =?utf-8?B?UTJka0tqaW1yRy9RdWIwRGZ3aU42T1JiT2hwcXNCWEZzRFFsOFhlYW5oM3Rt?=
 =?utf-8?B?VDFzZ0RaTVBTMTZ0bFl4RWtYemJoSWt2bnBtaG1BZWdOQVNLWGthZ1FWT1ZW?=
 =?utf-8?B?cVVTZk5BM0Z5NWpHdjJyTEZ3TW1TdFk0RSt0cTNpR2R4c0QyRURLeTY2NTIy?=
 =?utf-8?B?VkNtV1Nkb0JYb0NFelpKMWllUDlld2RIM2NUQ1duRVFLL3hGanh6S3ViNUlF?=
 =?utf-8?B?Q3VZRXUxNHUwSjdMd05qbEFPZVBRUFJKbjgyS1hScmgvZkl0ZnlGOUJScnVz?=
 =?utf-8?B?YVMvc1ZIOW9JT3VKN2JaQmJ0NXBWMXA5dU1OOXFETHRVNU42OTRydlYraVI3?=
 =?utf-8?B?aDAwekNaTlRXeXJYeSs1aW13U2tBS0kxaHZiMFI0czlKMEwzWmZQdXlWNmp5?=
 =?utf-8?B?RlZ2WHdNckg3bzZNNGZhRFA2WUV6Ujh3ejdOdE1PSTdsWGIzdGJJNlc1WjdE?=
 =?utf-8?B?UGVHRTdIY3NUaUs3bHY4ZFg1M2NXZlUwTXN5bEVOeWFWQUs3VHlvanl4bjlS?=
 =?utf-8?B?QStSTmNGN0dKajFzUDJ5RDRndW04bHIwUWFmdENyYWRKNnF0Wmw4SnFTa1ZY?=
 =?utf-8?B?WDBhVEQyeGlWcExuZFhvYlB1ZmF5TjV6ZUl0WjFvckJMQ0ZLeDRIRDFCUXRC?=
 =?utf-8?B?ekVuNVhBYndSeW9JUDRDVTdPMlFnQzllTkdsTWQyTC90Vk90U2JiWUZNcTE0?=
 =?utf-8?B?NXRnQ0pkdXJYWW9seTVFb1RyUnk4bVh6V1J1Vkp6dndNL1BQQ0dJcFBINWcz?=
 =?utf-8?B?cElvUXdSVHVjNEp5a3dQaE1taGJ5N09PQXpORzQxT2RhZnFuVTd4YitXVnZi?=
 =?utf-8?B?cDV5SFZlY1l0Y25UTElZcXZMdDRnQy9iSU9yYUxVVXlncmhrMmtad0pVRlVP?=
 =?utf-8?B?QzdTc1ZiZWtrWGdSM3N4SGV1Slg2NEgwVDA1MkVraGhkWnJ0NXh2NVU2VEtu?=
 =?utf-8?B?OUJ4K28rcTlid3lSWmhpNXkyb0RWY1hsT0dDWEw0N0llZzhZRVIzVWVRbXU4?=
 =?utf-8?B?Q09tNyt2dEJpUW5tU1NTRXNnSEFJV2tRQ0g4YWF2bjRCdFBOVklHcjZIR3lZ?=
 =?utf-8?B?SjEvTVBkN3NTcjArbzVFQlYrZGd5UmxvNmlqUERuKzIzWGxNdG9ibjZtM3Zr?=
 =?utf-8?B?QStZaDVxY1hsbER4NnZMYUJLbk5PTndaTVlDMVJ4dXFKQ2hqSnl4UWt4QTdx?=
 =?utf-8?B?aXIzUzBCSHRJR1VIeUYyd2hQUHZSMkdUZ29kUElPeHoxQnREbEowY1lqY3pk?=
 =?utf-8?B?WGs2YXRPRlgwL096NG5QUHVxOTNoVWNpVlQ5dytPSkM2U0RkaVhGdDkyYXJr?=
 =?utf-8?B?OXpYZ283eFlkcGp4dUpEbm9BUzU3SWJWbTEyd2VrcEJqWXBUaDJ1aHMvdVNw?=
 =?utf-8?B?KzRYSTg3YVdWdGNHMDYvdElncnhnWEF6b0c5NjdPQ0JGWXJJKzA0K2d3aHY2?=
 =?utf-8?B?QWFqRVBYd2I2cW9JNUphdkZtMEVBSnZkQkpEeHZtb1BidUxnbnl6Wnd1ODgy?=
 =?utf-8?B?Yk9OL21uTUU2TVVIcTc0OWtKYTZRa0FCQm1pVkhzbHlOMHRhdHFsTFRaU3Z2?=
 =?utf-8?B?VWRmYlV6RXMzUlg2a3hleTF4MEROYTE5RWFjM0Jkb0wyM2ZZN2FXRTJ4K3FU?=
 =?utf-8?B?N05QOEFrYkJGdTBuQkhMakFFZjBwdEd5VXFXL2xJN2poNzNhdnpRNDJlTTlM?=
 =?utf-8?B?NUc3WEx3YUgwWTdnMzNTQjBmNWVMaGkzclNiSEFpRlcvZlkvZlg5RE5NSW1t?=
 =?utf-8?B?NmgwRjI4bHpEOTkzUDB1elJmMCtvYnpWNmdmT2NBbnNhT1c1ZWhlQ0d4bmRK?=
 =?utf-8?B?ekpiaXdlQVhXQkgzTFNXc1Z3d3BIeHR1ejVCcm9SejhLSUd6K2N3SUloaGhE?=
 =?utf-8?B?YjJvUTBSQUI1cXJnTEQ4UkI5Ym82K3ozOXQ3Nlowc29xRWhBa0hWSHBsdk8z?=
 =?utf-8?B?UUQxQTNXZ2t2S3VKZ1MzUWdxOThlSDc2a2xYOVNDY3V5Qi90WWx5YzRTZ3RY?=
 =?utf-8?B?YndadTRtT3BjRTVUYmFaYkMwbXVJWENib2EwaUZsZXEzU2ZROWY2amU4VWlq?=
 =?utf-8?B?MzVzdFkySWpaSUhPREdkY2o1VklHUFV0cHJqU0prZzZ1RmV3RXhTdjU3RnJ5?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AXYtuRrdtEbIaOq/6DjTKGNhY7agr6c9P7JHJvWNQWIXiINUv0+p9lTSj2K79ZuPpIU4hvc5EqCPU4Se4hCdJCf8kwc6M2ExWGLU12YrJlGUowtgHN7tzG/3DufbONBctfbAtpciawFQQ9lGdj8nirNG3uX0HNzeoEOlg1UP1VcUWShB7Haktfk3ZjCcJblz6yk/Zm+rdxVOdAN9/F+/rzF62Ljy5G9RASGaaTbHXtPc+0opELHjhHSyXuHLzKlvc99LkKZ2ICCnw0wm0GS8e0JSlN6IGu61MypF0kx6L7GuvXcacp7XpE2a2UGquN8GYWGFSW1oOs5qBx5xxUEtDIQbfwMpzKa9/tZHHvpEmszBSq6pPtcbJzYeVSlAZOasqZzRrYYZQI1tPUySl57vrPkAUBYDTOO5mNPEOxZvKr03RyIq06Dy+mn1St56ZutZl2q4igS3L/QxPagPQ6jJOtxgMIoG+iBEHWNfDe8SGNYbVFOSIMOpwKWqvUA0KJmx84hyhKZu6yuDE7Cczb10NeCXEd6g7uFAYUtsnHGEyxYnD6fJNLn5cunOANZGfj6NyAMfgg7GfndpKa/e5Ee/0oLT48QkVfMMPVU2gdnugqzT+0Bzq+iTTkWlfyv05VpUwroEEwfiqv+ZlMu9ZXAnjGCKe78aPf3JheCSJmwwXZDzvtzmy7gVEKcq9d8I+fHkYU5skMNt1ZSIRsQCBx66w0nfYAzk76sGClV0yKYjl8I9HTbrC6W20UarvHHNCxddW6nb0crazebBcj5Q9jCRtFVviWZjiFn0TGdnGl2PLjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01c1412-9cc6-45cb-f633-08db5c334c11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:45:59.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssDZYtlV+e0fLMVUy/whF2cKpflelHnpGefg4seYSldP8dX3vW5/o4GShpb1Z5gdbdnKKddxtPmSk9zBjq5q7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=957 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240074
X-Proofpoint-ORIG-GUID: v6NiGQlFdKSiPFyx4XkZ0ixoYMZ01zg2
X-Proofpoint-GUID: v6NiGQlFdKSiPFyx4XkZ0ixoYMZ01zg2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/05/2023 00:30, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 06:03:16PM +0800, Anand Jain wrote:
>> +	ASSERT(!(fsid == NULL && metadata_fsid != NULL));
> 
> The more readable way to write this would be;
> 
> 	ASSERT(fsid || !metadata_fsid);
> 

  Yeah. This is better.

> or just throw a
> 
> 	ASSERT(!metadata_fsid);
> 
> into the else branch of the if (fsid) check.
> 
>> +	if (fsid){
> 
> missing whitespace before the opening brace.
> 

  Both fixed locally.

Thanks, Anand
