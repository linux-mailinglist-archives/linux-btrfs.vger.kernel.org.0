Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A925F6F0813
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjD0PSG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 11:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0PSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 11:18:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BFA44A0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 08:18:02 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RF3r4J029652;
        Thu, 27 Apr 2023 15:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wrmut54IsyqOjVcjqbw8nqi8xL29RFaoc0z7T7lHUv4=;
 b=joYGaNbTs88y8EmefVZWShou5su8mCUzXPuzPF6EAj/Fyj6UlWPKADxn418yiD8Dnfll
 MdKvOaFvlu5pZstTbJ7YPw190DWDnmQrjpeYKdwyfyaL21v7Q9snPN5B0t7q6ZAO7BOd
 ywg6chvN8d9mt2qAK3CCeYEWIxKiV3QTXy1Vminb3g7rWJVdLSeukwB3N6CCtShecqe7
 mgJV/ceRvz4ZET/Ys91nuiFKm4YODytAY4zE1gSiCVDeCKuPK27sTSBXc2nBenZA69Ho
 92rIv7C3Dg0egejbRlbtfPHI+mSiis8H3VjqHTPDtYInRJCMneJ3p6s58YFrqNv8/gD6 Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md4ckv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 15:17:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RDk1Sp006670;
        Thu, 27 Apr 2023 15:17:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619gud1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 15:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPjD3WtY2okZRRvh+JSxOr7+nfCWGNy0v2u7o+XBsqSQcIOJNEdv5xXzpbIXRHoU4hIS0XCktAAQQNJW1BDmRotpNjo+zDBAX4/g/id4+KOaJtiTazj51zXAzLKt9/zELAh9eWqO8kL3cYblja3cSnceqyaNjxgYP0A74ZIijjXORH6+inUWgvfnibiJTgBn8+2BBQcE4nosVITMzsF0vyXoQuPqfkk8eGJL0Khv8V8vEG/rqRjbz/M8grzQJJoOg5PDHIPW795QNTTTXDieYoYnDo9t1OI5g6eT4a0WUF2w4x81fNF4rhjkonuvRZfoYBdrhiuAuFJDiTT1ysvPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wrmut54IsyqOjVcjqbw8nqi8xL29RFaoc0z7T7lHUv4=;
 b=XUsjtEHn3A08vNk6BBfTcDwkDPvnCmiMiJw2MGgi0ZKlsTfQC3rFRsi4Rw8oVX/gXmlH2VOAT1LqogX/L+ZiAXQRFOxKsTHOqg/2oBEoQ77Qwk9CX1W35dq3PMRJyMfHCJR6ra+SHtRJ1b0O2In94mP6ugGT3Kvg2ESwDbQDPYCcGVH0AWH/wSnCVnKJxvJcacpmgTwHUTTKJ/pTgUdsgrxEvKc8tUnifxLbvxmGNY08q8H/tPlPfDZPMjyjZacnK0h2K2X/mRpN4QZorjRhen4VinZaMMJKzFttWrMARQNwAOOdq9JSzRUQZFIuMzsKF5GBoC6LkVgS9tOt6SoKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wrmut54IsyqOjVcjqbw8nqi8xL29RFaoc0z7T7lHUv4=;
 b=VEqEx0NHPRO/JJ1/BcwtndZwvxjrSaxJjoIaRGOtgBktZTDefhYV+2VKOW5szvSGyWSEgaQGC4B0l0Rzk1MD9mX+nwYL2d97t+hJNEbKzqMmmHEUivRuIWAkQyhkhN9aHY/+KXuTaksinqaMCEY2htCpGs6JIbEzAJEMOdiysw8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7172.namprd10.prod.outlook.com (2603:10b6:930:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 15:17:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 15:17:57 +0000
Message-ID: <3a7672f6-8ccd-e57a-880e-70e1b43c9868@oracle.com>
Date:   Thu, 27 Apr 2023 23:17:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] btrfs: make btrfs_free_device() static
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682528751.git.fdmanana@suse.com>
 <9182a6f15c0d7ea2395e9c9588eb8fa31d4525f9.1682528751.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9182a6f15c0d7ea2395e9c9588eb8fa31d4525f9.1682528751.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 76693efb-7a80-495a-38d2-08db4732944a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbUlZDIA/rkBCXnJznXoSEVrIx2xFhQCeuLPialZoq63gzK0NKqEqavUetT6FHkHnxpyIZ9QSLSWSEsvGbyt7ToBErLGBffT0VrioXTn0EV+q60MoFrSrw8Uh4JOczFP+aJhUAbsKTOX4dRDOWO/hNQ041bMmaIJHIQgJ8HBMKRAFthppxrUZ2zxI9lYOYEOmvdutwMCbpcgB6GytrnQQWUp44EHxSmJ4uzudBz/An8kjgR4p8SE53ZA6JQEBclYyhfgOGfgNoxmcC2TX7uOnMgYqB3v0Jv2faNbhIal7KBUxd0i/7wr3HWYKFehfQWOBKuXitqCxzVG1WhtP2OquJUo4CdDup/zB/Q6yxEljJYjqiF1KsmOVULmfehFcnYvkOc5o3kWQ4Y9yF5ab2vOHibv8IE3Cqs5iq0ERnyVuMmOeU/+l7AEGFweYiLfTbjbOfyrByO0V+SJkx7ulOAcDUyDUvYttX42hrxB1bUuqJ/8Ryq0SS2ywEbXjVnVIL85OY2B95Y6pIYCcofS6dgAsD5M0JbRcwLen6RK708LTugGnhlB5wKR5cahI+bwqoHOw+tj0v404Yo8B1QfbN9fyBzc+dcrmN8a4Dk6imWlmYynRBXZ6DqrwuA9mYTyJvV9Z8+qyRqvNcCXPqb8vBKsBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(31686004)(38100700002)(6506007)(66476007)(31696002)(6486002)(41300700001)(6666004)(66946007)(316002)(86362001)(8676002)(478600001)(8936002)(66556008)(36756003)(26005)(186003)(4744005)(53546011)(2906002)(2616005)(6512007)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xGcUNsSWVyNktLNmJ6M085SWhNSHBZWXBRbHZGcDQ3b3cvSVN4R3g2U2Jx?=
 =?utf-8?B?MFFmQkRlNXJLVGVUdHh0bHYxTzVibTlRMmhHcnFnS1Mya0tyL1hiUWQrRU9q?=
 =?utf-8?B?TytXbGxsZFprMkM0aEw2NVZUWE81a0VKekVhMXIwcWpNKzN0WGluT3BBdTVN?=
 =?utf-8?B?Zks0RjgvNXdNTjhrMTVwMkY3dnJ6NkxQS2c1UzlidlhBdi9ROGN5RFJRck1q?=
 =?utf-8?B?cGwxQk8xeGROcTVCU3RaSUc3b2ZhbnkyVVUwQ1JzUU1SaHh0Qmxsdm9tV2pU?=
 =?utf-8?B?aVM3bU84L3NXNUo3SEc3RHBaYmc0eHRmUUFUa24vRkVzZklyZFNxV1ZEMGdz?=
 =?utf-8?B?T3puNmpYdHExNnE4TFpLOGtnMjl0dVRnK3RJWjVmMGlqa2dKL1RmUGJGU1Ex?=
 =?utf-8?B?czcwWitCWG1oU3RxZERJUG1EWGhQb3NVL3ZjbzhieEFJRXJSUkswNmRLTWJr?=
 =?utf-8?B?UUtoM3ZJbWlXUW9nTWo4STVzcFdTN1Q3SmovcjRTWFJRRWRpazBVZ3Z4RU90?=
 =?utf-8?B?MUM4ZUpDU200a2U5MHpHQVFpZjhzTGNkbjhKMXdFWXdPWkdNMUs1d2FPaTZn?=
 =?utf-8?B?bmFjNTVudENtb3NvckRwYis5clJCY3NuTi9DZHhZL1ZqR1JrZUtHRFpqcGpo?=
 =?utf-8?B?T0hNTW9kYTJDUGNPK0FMcFhaOVNZMy82OEpSM1FXRzN6K2EwQ3hPMlRNWnZ1?=
 =?utf-8?B?RXVlNnc3MndMeFZhZExJT0MyRnhPV1ZZN3RTbndXN09paGJ4b0ltL0Z5dk1h?=
 =?utf-8?B?MUM5N1ZBZTVSSUdHOUdWTG5nNHBlRE9PRUhRSFRySjNSekhRMkJMODdzYUh2?=
 =?utf-8?B?VFR5OUROV3dDRXpQUE1NRjVObWhjYU9Id1YrZ3o3bkR2ZDJlcmtaM3M3STht?=
 =?utf-8?B?K2VLTzNZOENOYkpUTmg1N3BGQ2UzWEliSWxJbEpIQmJrZXJ0TnJzZ29aWm9i?=
 =?utf-8?B?YkhJRm1vMEpld2lTRVd1Tm5vOHp4eEpIQnIxTmVxL0lDckFScjhxNjRBaVFG?=
 =?utf-8?B?bXBSUVRYNXkrZ013V2dCdkcxYjduQUF3VnZxMDdTWUZyd0UyUTdWdHY0MVY0?=
 =?utf-8?B?WHFRL3VkRGpSUEhtOUgxb2dhY2F4UU91UUl6cjdDYVYzVjdmY0ZyUkFTY0Va?=
 =?utf-8?B?Uk1FeWZQT3BlekcrblhURnMzN2NLU25scGZjM1ZjT2xtUE1KbWNJeDBLUGJa?=
 =?utf-8?B?cGJuaFFjSURVWmIyYjd4dUhDeGFOSlE1WEl1QVBEWXg5YWdhZTVwekR5RnRK?=
 =?utf-8?B?WDFybnlJc1FPTkFnb0QwQ2pQWkkwL2J4cFFyZ3B3UTZWN1RFclVjNCtKL1lB?=
 =?utf-8?B?OE5GV3FUei82dm5rSEpOVllpWkl2cnIwQk9hWlpTWlVKcVRGTjNkM0w0Z1FI?=
 =?utf-8?B?eHliaU5JVk9VdTJvb29ldFFYWHlNQ00va24xRGJOZHhlcnFLcWdLOGxtTDNE?=
 =?utf-8?B?MUUvZk9VMko0cFlHeDBnNXpGcTd5VjJqNWlrU1J0cGNVcEgzaXQxTXgzYWV1?=
 =?utf-8?B?SE1CTk01WmVaZ0Z2dzc5TFh5MWZXaitydWh1YmxFVEdpR3M5YVQxdSt2MUtV?=
 =?utf-8?B?Y3lNKzhwOWhvY2VhZmFZMlcydW5USmU2NUZMcmRqU0FibWxWR1l1OHMvcDlZ?=
 =?utf-8?B?T1E5Y2prWDFYUnVJdlNrUnIwMi9FcXB3Z2Rja1pyS1VmQWJrRnloeTFWazds?=
 =?utf-8?B?M2VDV0xGV0VHMVdQTkh6bitwbVkrT3BRQWJqRHFoTkpyTDk2TUJEdklvZFBh?=
 =?utf-8?B?UGxySWRLdGoxN05aaU1oK2I2MGtxdW9VdnE4YjFhVnJqWkFvVkt0eVhybDRX?=
 =?utf-8?B?MHhIbXFXYndWa0lLdXZGYmduakt1L2syc2k0MFVWTVhhQzVHeVdkWU0vQjda?=
 =?utf-8?B?TWs3bWtSUi9BQTBFemVCRFg0MUp3a0pCRFprV3VRbllTZytCVUFnbmdaVS9k?=
 =?utf-8?B?alh1S2g0RHIxM0FUMjFsZTdPU2xSbWlYbDh5b3dUNmZZSlFib0U5ZkEwSTVK?=
 =?utf-8?B?T0dGU3M2bFhlVDk1Q2tqVVFZajhoWHA0d3NVZGpDcFdlbHZiNTBLLzRjMXhj?=
 =?utf-8?B?a0NaMGlucGxGOURBS0w0OWlQZWhLRHVaYmpObk9KVlpPa0xxdlloMkdWMWtF?=
 =?utf-8?Q?iSJqv94I4ecIjr/+OF2IxZJd/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EyDiU8aG2Y+574YXEaZf8fVBoTjYL2bDDo2w1vo7e26zN+MBIEx51G68KsrNR2PgMI6LMiJJ/cKedUTfowtWT5i7N3cSGKekVeRiPlDkQL4Wp3aQjQM4dj0m1s+fForCgiNVRDHghninLLnxdEi/VNzYAK2E5F23C4Uf28QRSJllaUJZXq8JuxvfBTxsxj1XilgsWEYVTbQDIDYFyEU/1VVFUVYe9rKNdbdhzWTy9pzQi6ZJSfafyLF2VyWX57XFy/BLW6uh8rhf9JWMvBtAy+T9bLzo0mEQY7Zn5vt5bTbvLfEtXMyfayrdLDLygOFJv/WhfAddn0j56gWcj6cAX1LDJZtBVrwe0RQiYbgT6QteCmTzeQ3ZCEW5KYBHGMeqqiUd+4bTKX0uxXAwLzi0TNNhmynH4A9Fqi1uh2ewpFj2778xEHrlF27FYyFtJtLNiRaZnx/iaAztx7s7W3taevrswa5kaclV52KR9oJqL8Y2igrpM+xcAKwdqg7TNMP+aJ59qv0NsAt90qhA6YqdGtsY4b/gka5Hw9TYXrZYOcQNyTHbbFDEpJsAoUqsii3adRJiP911L8z1zg49ucigoTb8lqtSBDS3TvQrJuQwQhi8c5SKAtzRpby3gdFCUfT84beeDcPxw/XD0jLAvibeKbFiCdLJk8lzc8cAk0MiFqdE7uFg5qR0T4gUoAJO/Ieij+IZ8B4YAySHm92WMKYQAAHTp9VHuNCK+jraSywxSJuSt02vs3cG4nyFQ2HCE/a50Mp4Os3T7SY8JyvlzrTXcRccZAO+tVQS2QJbIxBtzys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76693efb-7a80-495a-38d2-08db4732944a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:17:56.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUXBDyQ0YZ/mFkzeELqIiUkMIBwixIYyog6TBXL4RIuCMoNq5vzgeCKT0tY9u4hwpPQTa8vjS5vXpRk5XjsDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270133
X-Proofpoint-GUID: _a7s7G6fhYGc4YwoLYS2yOPUsQeUvUtc
X-Proofpoint-ORIG-GUID: _a7s7G6fhYGc4YwoLYS2yOPUsQeUvUtc
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/04/2023 01:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function btrfs_free_device() is never used outside of volumes.c, so
> make it static and remove its prototype declaration at volumes.h.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

