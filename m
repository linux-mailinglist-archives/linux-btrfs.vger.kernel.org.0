Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956636E2F71
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 09:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDOHUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 03:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDOHUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 03:20:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28859E6;
        Sat, 15 Apr 2023 00:20:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F77qlj027774;
        Sat, 15 Apr 2023 07:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1CM5ta2nzzk7aaNCZ2Bg6/FFyznfsCJgbDOG5xK+bLM=;
 b=LPhKCghpuD4cEbAHy295YoDpOE+gfkMJWKKHJ1Tpzu//TnM/2BsXRjLQRZIvwoWQwMmn
 nDdWnRDZ5Bks094PbrkLmJYEEOxNKbaOOLwmVQnLeUvIdoM6c4mPrYYxUl3wPUqzGCfK
 r//TG3yYaTVjtHuYwohawlzEi3wwjkLqaxzoCibJmbhBCWyMbp5Nm6zSRuN7CL5jqVC3
 VjGUQLT0zIBpCUlXojyF8/6mVINwai23pEtZ2ME1yjB097ZNPExn1T6PCU1kTDLfjeAH
 /+OanQi4XCzmjQSk8X2fJ85NuYokMzDGF9/bzACdMXSKOiVsxTNmuLflaPTGBkGIm6+a 3w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfu84yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 07:19:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33F3DJgJ023096;
        Sat, 15 Apr 2023 07:19:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc25dfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 07:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAaYEbFB/SkhamAxgr0UBt8pnh/XIYv6zpQaXG3RFDNliFH4MOhb5+huBqo7ocHHTqjN3MlY5Fmzpq9GGwqr1uXJ7nnsXg7VVrEys+EZuTfKyYR+Lsk7Vw+shK0p8pMYdLX+8YPwplOowVJisQv2VHHyfuMpI2oBQmGpX/0D1wX62vZk2jcbsx6CaA/NtxURnh2MfxJGras+BTey52B5SKLhAxpUrgQ4D9vyrovcShwQcTlNF3xXQd2NXMXt8IKbA8w4XsRa3/H67XtnS5ofZtACflmdpCsqW/Td3M6IOr8Wty2pCzBLhq5J7WRhg/MRvek6G1h6K3pWgs9mIet8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CM5ta2nzzk7aaNCZ2Bg6/FFyznfsCJgbDOG5xK+bLM=;
 b=TKdYWqpRd4gWLfaMSWR1j7YUUsanG+ilrR/OCXGTOZuWRC6/y0c9Qdvu630pmIzxSTcAsT5DuBDZid007TcViwzEjeSc9YZ18wDjEAXtzgz/tbS4DfK2kSl2yr8VTXTtW5/bbAV0IA7hxti+9q7QNcFVRfRWK5kYn1uS2W/9UEnvKk3TC5y0K2bAl8V6GTgSFApY9sbetRXQhW8C/I4mIck9misqOz4A2mHeTNkg5AhXKpSLBEKOL1sJVbb5JUH/cqQoUhIkiOm14NmQ6+BJqL0zsq1pa5cjwBG1vdEBJ3BptHtyW60EWVm74I9ktl4X4Oyx0IuTC8o/2OUF8PvUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CM5ta2nzzk7aaNCZ2Bg6/FFyznfsCJgbDOG5xK+bLM=;
 b=d9ck5ZFA3bb03dPPv5T2VgZijYTox8DQkNYPGJeFCv2cRurh+Fk8bCgLMO6OGBvShuXoGEX29QNy71m+UoTy6YjKSx2d3DMDgGGVs2gjq2Qkyt2J9EOzY9xkH4U1Td895AKslex/D3zyTbKP8vaUmOdr0GPe6obIxvdPNUfHaHI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sat, 15 Apr
 2023 07:19:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Sat, 15 Apr 2023
 07:19:41 +0000
Message-ID: <da776860-e8dc-3013-b74f-5af7ab18a51a@oracle.com>
Date:   Sat, 15 Apr 2023 15:19:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/11] btrfs: Mark btrfs_assertfail() __noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <cover.1681342859.git.jpoimboe@kernel.org>
 <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a1d27b-9826-45e6-cea0-08db3d81c738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYp7Z1jo7KTIwwahZ0MdY1ekermnX0r4mXfzb/RIUEZaXuW88bZHDV+v9rtWnMxseqSFRNkwLWkNgFVtRjB1bVEsBHn/Jcsl94IyGV2IieyqeGIAHYTfZ6S4enJGgDqOSYgzEjKa32Xjzv3jqhhk/kKlf7fr+GfCN5UJbaI/6Dm31uHZtsrr5WMm2jHmZ8snpfP/oPiE/Ld1iNhANDorT7vvI9B9N73snAkMUdxGQDvNwrcIMWbode4nmCZ4KOgZkgho2AzKKmHEnE1ZpUcClp/hKdiuUNODRAuQKfNQb/sSKZuerSIoiCBdakEYgHOHU8QN5+s/n2WLrOO9tOcUlF4kGkXkpMCb54+86hm1prCj53fl2lEGQ+HCaKFQDTz/xO3JF/XcYvJtDWd6Joz4+mwWCC7qPjJdBuVtBrRDf6L2U9L5Tp0aZYSOXP6ovqxZQpcXanAMqEulThkysQ5FDiD38QsEzyr1gF10dyjvacMqyVTCOsPDQ30n6iOpApGb0XVvpE5GExU5Q7lXGmBb01/jVNFUZP8RFHigEy56GnKELIMqR6JhY+3RUc0v7A+uLwi2OVIFQbTv+xc4zUuOg8GBj3GoWQ3BorpJ6YO20u0Oo/UjwHmo157v17FsJ4XDCHpBueXnsF587Ykamj2zJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(31686004)(478600001)(36756003)(31696002)(83380400001)(38100700002)(86362001)(2616005)(66476007)(2906002)(5660300002)(6666004)(66556008)(6506007)(6512007)(44832011)(6486002)(966005)(53546011)(186003)(316002)(4744005)(7416002)(41300700001)(8676002)(8936002)(4326008)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjA4cm1QUmlHZlJKL2dTQXowVlNXV2FrS21YRzNxWllmT01tVHFlWWxxSTFC?=
 =?utf-8?B?bVFYek5Ia1owOHFoMnJyaTFzeFRFSUJYOWxOSFZqRWlSelBwaXYxL2Zaaml3?=
 =?utf-8?B?dzIvd204bUVodDNFc1VtQ2VxWXZzTWtLNHlibWJBNzE5MzI3UG1KK0s2OEdV?=
 =?utf-8?B?MnZsU0U3TXBlb3JhbkgxeUZ5Wmw0ZGFTR0ZxeXRELzJIWEdhdHRuZTE5dmkz?=
 =?utf-8?B?MXFiVXlBRittNllYN1RFYjhSRWk3Zzk3WGhDcE5MQ3NnTkx5azh0MmwrZW9T?=
 =?utf-8?B?bEZzQjNhQWxzQkpKQWhZRVNSQmczdXVxRmdEUVVPMVhZa0lKV3pFNHVLaFhK?=
 =?utf-8?B?dUJ5bm8zdEsrT0pKc2J5RXFoOGFWNnBIcVRqQXN4SEpyVTNCNy8xWnJwTXo5?=
 =?utf-8?B?bHFYR2JxbHJ2YndTVlp2bkt5eDNmRHdKSTR6U3QrWUNWY0ZsM3crRnIrWjBt?=
 =?utf-8?B?bVRFbEtoS0VEQndaOXpsQ2I3Q203SE54WHdHVDdiVnRLcXZEWXVwRjAxaDZV?=
 =?utf-8?B?Y2FWbGw2ODNmTDJUR0NJVVhIMzJtRDlRVXFZL0gwVHJBZGUyc3lBTGE4cDlp?=
 =?utf-8?B?SkhhZEwzTi9LUERhb3ppSWh4WFg5MEJORUFMNjNtSG9NbjFOTktJNHlwTjRX?=
 =?utf-8?B?WW11eFJObUFZMFMvcjA3cWk0WkdaNW94cjlFUDVYRXRCcUVGVy83ZG56RlVv?=
 =?utf-8?B?VDRVWVBwaDhhNGtyNk1ZdFpxdWhCbERwa3AzQ2hRVHNqbG5YeXozOUZteDdP?=
 =?utf-8?B?M1BUaVdvVjZSOHhqNU82TFpYQ3lRRFJQbStXZU9kMUpvcjJtVVIvREVGRU03?=
 =?utf-8?B?QUlBdlNucU85TW1sVWdDbHRIRHVNZzAyMEtQSTlMU3FIbEhqTThGdHVQc3Av?=
 =?utf-8?B?Y2VHQVZDK1QyTHpRUGRrajJCVDhNdnBuaUZtdWM0K1dxY050Qlp5aHFtNHFI?=
 =?utf-8?B?bWF2d2h1QmRRSEp3bVRCRlBYSFZFc2pDME54dDlBMDR4M1Q0czdnR3FiNGtF?=
 =?utf-8?B?TXlMdEROQXhEQzIyNlNDOFVtQ1lKblNFRTVvYWR4N04zMmd6ZXBTMXRrTGc1?=
 =?utf-8?B?U3d1NnJxdGdER1RVTStMOUx0Sm4yeElIZW9DVkE3UnJoM1BuUGpQZW04QzdM?=
 =?utf-8?B?UlNvaXZtbytiWnFYY1VLbUZWUVlON3NsR2h3MzdnekVXSG9DenRzak55NzZJ?=
 =?utf-8?B?dTgzZ1VFbENGbWkxMzZBU1ZzN0Y5TERoMjhGMUVFb0t2YU5NOU0reitGMmJF?=
 =?utf-8?B?UTNybGFSa2xKbmF1clpJcUxZWFhKRFM0OUVxekRLazlmcnhmTDBJZXl6akkw?=
 =?utf-8?B?Y3pyODVGS0ZGMHBqQzl0OGVKUy95a0tJM2ZrTUNIa2Y3RUp0QnlZUXkxQ21C?=
 =?utf-8?B?T3dyT0tCOFpBT1VKNHBUa2duQWZSdENKdmFkbSt0KzdtOXFvNzFlcTluUEw5?=
 =?utf-8?B?bFVQTmhtOGM2cTlacE9JNWlWUlJsK3NidzBzalVLZzBWRGtSRWpTSllyZmdu?=
 =?utf-8?B?T2tFY3c4WWQwcExqZGt1RHhtZUsxRmY5RlpTUFR4aXROam9oblFIQWpYcER5?=
 =?utf-8?B?Mk1tdFZNQ1BxZ29RWmtCdDNFanJBdVMrSC8xZUIvRHNubDZ0UFR2MStDbHZr?=
 =?utf-8?B?Q2hZNkhqYzEwcy9xN0FQcHNxU3RkVWVvQnFPQk1SY08xeDVQV1VOSzJrMnh1?=
 =?utf-8?B?Umd6MWEwTENMdDkwdkdUc3FaZzZDb2JLVEp1K2xjWjh6SW5DUDF4YXlXa2Ri?=
 =?utf-8?B?VTg4UTM2NHJQUVdrK2ZGT2Z5emxnbVUzN0hpK0wrZTBoZ2sxNit4RXZZL2Jj?=
 =?utf-8?B?M1ZDYzFtYTNKUi9ZWVhuN2dmTTRzZzZiZE9VZjZtWmVwTmNTcWExMXJETE01?=
 =?utf-8?B?UGhTOFZzRDVVNmlTcEJoNkx3elcxNXlycG1CUGdrdm5FWUVVWno0OFBpa1JY?=
 =?utf-8?B?U1dHNzRiNHBaTkcvWDZmZVNEVmF0U21mdVpHSUVPT2lKZTBPK2krS0VNYllS?=
 =?utf-8?B?K2c2bmkrRUxWcGdvRmJGcXBaTnNNK0Z4YjRoSTF6d2lEKy9pdmdGZjBVaS8x?=
 =?utf-8?B?ZnJCS0pwdHdVc0tITDFyUDVqd3psczUrOCs2eFd5WmNvT0tCRk1HaE5abWlH?=
 =?utf-8?B?bHh4OFhXd1c4UmFRZzM5QU41eTV1QnNqNDVnREcxMHhwV2NTRVl6dlJIQjVW?=
 =?utf-8?Q?PVMk3bul7QchR7oy64IzcgYQ3mWoEB4BhvfqJPSiUqB1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WmNseGNKSVh0ZTVJbUNJR2dqbVNiUUI3c0xuUkltTm5QcVFUQUVNamxGS1lZ?=
 =?utf-8?B?RlZ6bVVYYVVJZXRxOUtVUDMxR3p1Rm9HWmVNcndJLzlzZmlkWnNFUGtXTjM5?=
 =?utf-8?B?OEEvNE1Vb25vWFRDTVU0MisxN3RpWk9VUzVFeDJIMXNuRU1jYmZOUUcvUi83?=
 =?utf-8?B?dU5lUDByUzkrRXJDZVFXdm5uMU1POEhrU3RLcS9aL3prNlpsSkt4aTZJak5S?=
 =?utf-8?B?OFpZOTRrUUgwT2J6SDZ0d0JlRklGajBlcVhkWVE2Nm5KaVlnY0Fwbzg3UzB2?=
 =?utf-8?B?akYvbmhTNUpnT0EvcW9vL1I1ZERveUhuUEIxSGRqTW04eGZ5SjJLR3J6MVlG?=
 =?utf-8?B?b3VXc0hwenk0NWRDSGNsSnpQZkd4WHM5dkRVa1IveWplWHJ6MmZXQzZWQVBs?=
 =?utf-8?B?UU1VY3Q0V01TTklWQ1MzL0VUd0JJZEJhUzk5TEFlV2g1cE5mZTBrWm5NMUhD?=
 =?utf-8?B?eHNySUdmT0N1WFovSXVkaStRU2VSczdyVFE1U3pYWVN4SE8zMlVxdmhXeWFC?=
 =?utf-8?B?R3hxSm5pc0UzTlB3SitnaHVLNWQ2N0t5WHJJc1JZQnplZ3BsbHVXY1ZEakow?=
 =?utf-8?B?d0o4aGsvMVVKQjI5M05yRlkyTmxWNjZSRjFoRUlWZFpDTXlRL0JGT2kvQWNj?=
 =?utf-8?B?bzc0ODlMM2FLNWhPTW1HcFJTZHoyRzNzaDNpbkJjTWc0ZXl6dkcrTlhFRTZU?=
 =?utf-8?B?YWZCRDlQR2JablRyK1pNQVBnNHJCKytYbDgwclA5QmZlMjBWYWhvSXg1RzRq?=
 =?utf-8?B?QnFCNW83VSt1ZmdVSXRkQk4vTncrTDk3VWFKNE9PcG15WlpsNC9yUmxHUm11?=
 =?utf-8?B?M1lYVVBGcStZa1ZsTWQwdEFBVmZJVmcwRzA2dnB3a0cvZldmejVjTEZnNXU1?=
 =?utf-8?B?dzhjTXFGN1RKT0tOUG8yK2Y2VUUxak90QVZPLzdUUjZ2ODg5NmV3dDBhbEts?=
 =?utf-8?B?SjRDOWl3L0NhWUJXdDhqOWFsVmVENndCSk1VWjUxcEM0RjV4cHpiVWlTZ1Nx?=
 =?utf-8?B?TUFUTFBOUGp5elZQbTN4N0I1Q1BJTVlrQ0U4YVR6cGtJN1RORnVaQjdLMTZY?=
 =?utf-8?B?aDkzaVluZnVsSERZZkxhUDJXMGxpRkVHc0tUV3g2dXUwcEI0UTBTRjREbFoz?=
 =?utf-8?B?d0FCdDR3eFRBZW0vUW1RdFVsZnBWaW9uWWxXNXp0S09nbmQvSG9zcllYdFhV?=
 =?utf-8?B?VWR4WUNqa0FDT1d0YzAvK0Rqd2JyTFQ1QnBsTlVnbUtxMTZvdjFyUmJONEdB?=
 =?utf-8?B?MElRc2o3NlZiRC9QcDc1L1lQK0JjTUJ2MkVMbmRBT3BRYmx0ejFPVENFd2N2?=
 =?utf-8?B?V01YUFJIbnFaVzQ1b2I4dUE3SElDdUdlemJqenVJQ2FDRmorb1BKdlB2VnJJ?=
 =?utf-8?B?SXo5Z0pzajlUUUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a1d27b-9826-45e6-cea0-08db3d81c738
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 07:19:40.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSowR2/srvDCe01S06Z/AlnzX55Va5OEc2cl/GzbXETS43XyVcPhNQsr8sjuyPpJW3ciK8efwV9gx9CeYmf20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=979 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150064
X-Proofpoint-GUID: Thghra3E_aIIcpb5tqccD7mVjFPWFAGC
X-Proofpoint-ORIG-GUID: Thghra3E_aIIcpb5tqccD7mVjFPWFAGC
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/4/23 07:49, Josh Poimboeuf wrote:
> Fixes a bunch of warnings including:
> 
>    vmlinux.o: warning: objtool: select_reloc_root+0x314: unreachable instruction
>    vmlinux.o: warning: objtool: finish_inode_if_needed+0x15b1: unreachable instruction
>    vmlinux.o: warning: objtool: get_bio_sector_nr+0x259: unreachable instruction
>    vmlinux.o: warning: objtool: raid_wait_read_end_io+0xc26: unreachable instruction
>    vmlinux.o: warning: objtool: raid56_parity_alloc_scrub_rbio+0x37b: unreachable instruction
>    ...
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302210709.IlXfgMpX-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


