Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5E7DB511
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 09:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjJ3I0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3I0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 04:26:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B821AF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 01:26:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U3eIVw010854;
        Mon, 30 Oct 2023 08:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bkE5r9ekw2NkrZlgV0jdUgbMCBPfRQ2O3ncOgjUIXTI=;
 b=Kjjq+FF0SG0tKTYVkw+BP6o23dWwrJZQEhBW9PpLDySw0vo0UviKPj/iOfgUHwAxC2kp
 Af45HpGBS2OZcrH1QK+HgeMtC5ERPdz9O16sWZGfIcV7TP6WOBJoXFzDjUYbhMqTpuUP
 zhyHLJDHUxffUxt1gEvsUbw/ejyA2QPwyK5W6D30qtjLFZ09+wZf6MwRDYA8mSNGRlO7
 7RVoZfFv9XwJ6hFFxdPsUnZUL1F7jpAVDd1Z2jN7QY1HADrh+KYAyjBcF2ZvsHqFf8JC
 /5W8HaCNf6HC/wNVB5iCKweMZMhJQXPIal0U4V/d+/Ogeb4PERMVuvfMvRlVyV1vCUUK Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7bt6u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 08:26:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39U6hb3w030752;
        Mon, 30 Oct 2023 08:26:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rra6yck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 08:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USuUAY/viVCx5HHs/p0fFsddteAnM/nA+dM/mWmAw3d6ve79kLsi6MmhczrT7npWpUE4eQwbWKZMFzJTmwy6AWe2leHzirB0mOg6uCYZI0neLKnB8hip9cnp614PJGLaPomgb2sh+HFm+eNy0ccBSYVi9WF1oj5EbS/188mhzEW5beSMbWaUMRtagj/Nt4Uh4SHpNRD+8e2MBojY/yL6f4194RAXGbsnXHTpjkMMqHjMFKmFSDFTwPgcCQ/kQ4H08ri6Q9fWXlX1QSbJVJYJ5afd8yNpWc4kwiWIMUKstc2/SBE6OazIe63yspo1SJPHubP72hWWLluItwqdaHCUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkE5r9ekw2NkrZlgV0jdUgbMCBPfRQ2O3ncOgjUIXTI=;
 b=f+jkFqwvthD8VIO6UljDCeyXyzw3s63Cup4/6XAip+49IEcTiQFYuPlt9R14zJeMCwQc0KfWS3P5/6akibtBUL2NztkJXXMeptY7RmY99Qkyu4oijhC5u24Ncqyjd1iDotF29Np9Bc5vQKU6S4Jr4udqauZdOC78fR1+2i4tNPKeUtrmE0GB4adm3pbvVkHHE9yggoQul+RrOxlCwdVTg6mXDxt/Bg2cZKWA2EaVEoI0Zfv5chCycZ/xgJr4gcs9nb1LEVXN46ppEieTboPvvXZCD5475R/NRRtsCrhK9NhqPgNgBCyvt5sVeXSTGSOESRINTsBEYlmu92wRkNRAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkE5r9ekw2NkrZlgV0jdUgbMCBPfRQ2O3ncOgjUIXTI=;
 b=OHLSi2BedcSiI4rnAhDMedVPj8a2EzN0tJz8tN9oHwK+4vqEQJEMM1n4Sj14W27FgSTSdgozft6JlJpaH2P5f1nIuaOe/wjHcK6CSr3A4fZB/u8WDR8Z+ZOtge/W/45nT1bXRBNyUGopIzVOIBizwUtDGsn4pcVhFVCmiAbrU/I=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 08:26:23 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 08:26:23 +0000
Message-ID: <8be3fd96-4c9f-487c-9397-3ab36f4edc5b@oracle.com>
Date:   Mon, 30 Oct 2023 16:26:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs-progs: cmds: add "btrfs tune set" subcommand
 group
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <1c294f739f028da499cf7f57deb334f419979097.1693900169.git.wqu@suse.com>
 <2adb8c79-d1d2-dffa-dd6b-5254d75c9c86@oracle.com>
 <20231013174752.GT2211@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231013174752.GT2211@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f10d71d-57ef-4509-d3b2-08dbd921e6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOq5Ztpehhx9qb7D29HMK267IfVHEfUjBf2e7OtODsWKPs6ur4+cVsB5BrhoKVEWsV5LGqHCQSWvmi6Q2UdG346A0z2pJvccXuR9nHIVvB4q4v/V5wCtscbr4Fe9tNtGhMx9D9iJo5CFOORdgFBioezrxv1T64WI8bEgHhcE8+0ByRcJDyQBNGT+OnlsvcvZtzdDjGA056ebHbArXSH2RPRLDaE4rWfOYWBJXX8aCWxTJJaE+iBvn+31sFZCwHVzhRwjbqpdU9+qvh+oNTcfESa+ogQzvvTo4L4j5BiVI/MF61N3HI2i4AS1yDqEdFqMnF1aRLO8aPipmEjvTv4CwDG/z6SBXVGinLmwEAKLDVntNzZGxr6jvxQHXLRdsm5gU0HC8qNlKoY85MYY/Mldp0/RLsG+EPhAzJsEhHalTW03Dl+ZAaY8e4gOSggxaG2MNiXExMx41/1k2zvK6UgA0Vl4mdn6fBExHRvuoMq8s5eKg8LTXx9EhuUE8SCwIUbImlmKuRIP7HhXJVSs35HlEhuQVHTaqEZhUNyR7/9AERCo8TTx9fOaSOuc1IwVNu9E1StXmMhbNI37xJvrEg/1MAVQohTpz412DCd+V30KGAoCw3Ju47Tbx60nTqayzTr0F0dgVr3lmsuB06P3/2sNtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66476007)(66556008)(66946007)(6916009)(316002)(6512007)(6666004)(53546011)(6506007)(36756003)(2616005)(26005)(38100700002)(83380400001)(31696002)(86362001)(478600001)(6486002)(5660300002)(4326008)(44832011)(8676002)(8936002)(2906002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEs3QzVPWU85ZWQ0dDhiZXpiSmN1Nll3OVdybE41NDlQdFhJMHQveUpaendQ?=
 =?utf-8?B?YXQxRnlaaGFzbGVMTkVwOXM2YndodUZMVkl3aTY4SW5YQ0JIWjB1dVJJV2xH?=
 =?utf-8?B?OE0ycVRXaGdPV1B2cU9RQlF1WE1OTmFSTDkxQStob0ZiNG11REkvcmFodU4v?=
 =?utf-8?B?VUNBaGVVQU9jZmdTVFloK2pMT3pRblNkWktvWEQwK2FGMStiTzJ1UHBRSHpu?=
 =?utf-8?B?cWt2UnFyWTdLWGJpNlhFYVFhRlRQcHdBSnJtR2hHY2RuS0hFTzdqMkIxRWNV?=
 =?utf-8?B?RlJneWcvL1hiM2hRWnlwcktOL0wyelZCKzh0bzZNNlNNREZHRGwrVzY4QzFL?=
 =?utf-8?B?V2FGT1NqaGZmUUdBai9Lb2I5K1dnZnBnWXJwSFdidjZOay9GUzMvTXFoUHlv?=
 =?utf-8?B?M3pvUC9rZ3dqSHJ5cVdHVHk4VWU0T0dqZUhEd2FNcjI1S3VtQmhMY0xWcGF3?=
 =?utf-8?B?eGJTUkFWNERFQTRlWVZTVWZBdnJvNzNxdUdEaStkTk0yY0lBQm9qWGFyd0Jp?=
 =?utf-8?B?MFljeUJDQjMrK0huQzdRM1dOZzVSYVRqV1g3WDlkZmd2K0ZkSDBjSWRDTFFq?=
 =?utf-8?B?ekFMdkd3L1VtQjVFRVVITDZqcHFtQWtDK2JnQXl4bGVrcFRYdm01ck9EdmxL?=
 =?utf-8?B?cjFtQUNwSlVXd2JnTmdXS1Z3V3QwSHVwcUlMTnNyNktEb0F2SktIYy9UL3Qy?=
 =?utf-8?B?NUxrMklaWW5FMzRmaEVzVjJTSzFwNDJRQ2pLdHF4SFE0NFhxT2tmYjRqYmtX?=
 =?utf-8?B?TDhiaWJsS0dxVUl1RExOZ0VacDVqVDhJelNMa0JDZ2FRV2lRNzlmRTFPczBr?=
 =?utf-8?B?b0tBL1VQaWFLY1p3dEdzRERFb0toTTlZc3MydE43QVRHSzliYUcxbW5ua0kw?=
 =?utf-8?B?RTVER3RrK2lnUGphYTRUWlU2S2VlZC9aZVh0YzNKTDBoY0gvM3FlSTM1VkYx?=
 =?utf-8?B?QXN2dmJ3ZkI1anVjbmVrQXVoQlBQZTJybjIzL0Zya2J6Ri9tOWxoRlBXa0o2?=
 =?utf-8?B?a0FTeDFJY1FyeU55RndrZlA4d2pPUGJ5S2pDeVE4OW4rZmFPSEZ4dHBQMjVJ?=
 =?utf-8?B?ODdSdi96cFVtMVdWdVpaUkpRT3JmOXlLTEhTdFJPYnltNTgvOHZOcHBldXN2?=
 =?utf-8?B?bmQ5TDdyZDVUNlZGVUhtWmVoZmRYYWlNWU95enU4MW9ySzlnYlNBaW92Mlh2?=
 =?utf-8?B?MFFIRXR5QTMyMlNMTVlsZ1owQ2o3dm9LcjNxRGxYVUVkTzM5V1Zkay9CNWc1?=
 =?utf-8?B?S0ZFZ3E5aGJ2S0p6eTVqN2g3SU1nZWE3SE5UMG9uZG9KZklxeW1udnJMMStk?=
 =?utf-8?B?TDJyWk1XYm5DaW1oRGU2aG4zcE1rbGdrZmUvaHBBS2x0VXRFQ080ak9tWjAr?=
 =?utf-8?B?NjlRU2thZm9odWRUSWtKazI2aGFzeTlDbEhqZ1ZwemNoUTlzc2g5U3Q4Z3Vr?=
 =?utf-8?B?K0VpcmVQM1RmQ0NZRXQ1VmFtWTVNME1FcG5hdEtTYnM5WXY2dG9FOW1kaldV?=
 =?utf-8?B?ekdFbkdSL2dCSHgvck9DdTAwZzFwRU1DZ2VKRGNKZGRhdkUrUEgreW5vMHgx?=
 =?utf-8?B?dkE1YzFDdEFlblpESk1VRVIrVzEzU1VnR3UxeDFNRUttSnRJWWtjN1BQYWt2?=
 =?utf-8?B?RzA0WkRUV1Nia29hRGxWdTdnVUdnaUZPTllWY0wwMVE5STVXQVJ6bUovRUxh?=
 =?utf-8?B?VU5UM05lcXpuWDNtQjd6dXVEaTRqQzlZa1d4YW1xaDB1Ym9LRHBucmNTNTJX?=
 =?utf-8?B?c3R1UWZ6Q1plYWZDclFIaHYvY2pMS1ZPSW5iVVI2aDRnb0xWRnAzUFN1OEZL?=
 =?utf-8?B?RTlzcVpHeWx5RG1XdldnRXlRTkx0OUZkZFV3UVFQZ0ZOU0loTU1uTkxhcEVN?=
 =?utf-8?B?REpiQkJheUtXK0Q5bW9VWWxOakJqQ1l2U2Rzb2pNUk5ETFI0N2Z3N0grbWto?=
 =?utf-8?B?dDFyY1habUZYbjVuc1kwVUJlSWx4ckM2d1FkcXdmS3JxVThsKzRaSW5XMGpP?=
 =?utf-8?B?U3gwVHdmbm91YzRpUVpwTld2MEN6L0ZITUdHYzJxOCtMNXdJOFZBMzVCTHR6?=
 =?utf-8?B?eWQ0blIyWFJEV05rYlV2ZEVzcXkvaGtFR3dBc09lN2p1WWUxdHByM3FkaTlw?=
 =?utf-8?Q?mcYN388OOUfz1/aW4Pg4dK7ep?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kM6BZfAcD/rJzmNFBpJUHpGOZM5HRNBH0Pg08miKEzMNeLihhCooMTNXsla7YnVpHM1pUMiFMQ0Aqrnv0Fsjz5zRFBvJrTQWOy429+QcONS7SKqdNv1dyMArlT+yp0ofxz6UyR3eLCAlLrMJoWAH9yq/YGKfG+HpDfKiQyktAY6PQG3tVfaBdK3WSrrsIqf04n36wClWSQY+bXoBBZdNz1Ni1H0oD1zcsQxvW4SO6MMEvzkKiplSGYW8TUjHVBVUJ1BPANKCxWZtHAoejVWrnHIVm37sZSWc9QZAeqOzT+fUcCFgg76JhE/EubfxSsuDPS52N4JHUwHmtDTkDmMtP5dadR1hqgvSdRsEgSpvuxZUIkTYa0kUmWCFQiLWSCMI2vfTbtBigUGBA8d69AUfL0+b4W4Rh64e6z/2Ty7uEv0fySLWabOKHycCXD8WCJUuroVqPGyKLACO1kaV5z9KFSpS1tXMsEkdax0HrDi0Add1tIyf3mXBG8ZtunlbF/+1KSudwmbXb7OWzpgo/ZCxFL4NLRR+UH8kkoHRR8XhyJFkuD1a0oZTwvRXKfy7CQgN3xji3DAS4/Sb9KIv5b8JsGE1uRd52Q7mg7eVtn0ixJQUjniLBYmpTlSEbvQxX21qjsGtSchrO9rqqmgRHFM1+9QV/n141cZgu0OngcZuAn7Fd1QBL7fUT7WC1fXmpRbMEbTXNtMYTehfhwrRV/rM61lnhppujmVRZ+wOUQjrHeX22vP8+5D7hlnOtwgqIs7s8fDdoFycgHkO7OFpnrA7z4vEN3BnrR6F2lyhw7STzl4CAuf3Jm9dSLY9nFenE36m
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f10d71d-57ef-4509-d3b2-08dbd921e6a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:26:23.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3UJhzhE1luh1rz94wWiauWg366XHgi3y1z9vdqu652QEYfeKuYHqZIPBlCBzImz6PxDe7GW54vPwS3LODFjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=527 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300063
X-Proofpoint-GUID: TA1-FEAnNOOPOPpGXhT1VdMCU2izfFaX
X-Proofpoint-ORIG-GUID: TA1-FEAnNOOPOPpGXhT1VdMCU2izfFaX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/14/23 01:47, David Sterba wrote:
> On Thu, Sep 21, 2023 at 08:53:11AM +0800, Anand Jain wrote:
>> On 05/09/2023 15:51, Qu Wenruo wrote:
>>> As the first step to convert btrfstune into "btrfs tune" subcommand
>>> group, this patch would add the following subcommand group:
>>>
>>>    btrfs tune set <feature> [<device>]
>>>
>>> For now the following features are supported:
>>>
>>> - extref
>>> - skinny-metadata
>>> - no-holes
>>>     All those are simple super block flags toggle.
>>>
>>> - list-all
>>>     This acts the same way as "mkfs.btrfs -O list-all", the difference is
>>>     it would only list the supported features.
>>>     (In the future, there will be "btrfs tune clear" subcommand, which
>>>      would support a different set of features).
>>>
>>
>> With this patchset, the syntax is structured as follows:
>>
>>
>>      $ btrfs tune --help
>>      usage: btrfs tune <command> <args>
>>
>>         btrfs tune set <feature> [<device>]
>>             Set/enable specified feature for the unmounted filesystem
>>         btrfs tune clear <feature> [<device>]
>>             Clear/disable specified feature for the unmounted filesystem
>>
>>      change various btrfs features
>>
>>
>>
>> However, for consistency, I suggest the following syntax:
> 
> Consistency with what? If it's with btrfstune then no, the reason why
> the command is split into subcommands is because the command line
> parameters became unwieldy and what you suggest below copies that.
> 
>>
>>     set:
>>      $ btrfs tune <feature> /dev/sda
>>
>>     clear:
>>      $ btrfs tune <feature> --clear /dev/sda
>>
>>     list:
>>      $ btrfs tune --list-all
>>
>> This syntax aligns with the:
>>
>>      $ btrfs device scan --forget
> 
> The difference is that scan won't be extended much if ever. The 'tune'
> interface grows over time so we need properly structure that so we don't
> end in command line option mess.


My apologies for not responding earlier. When designing the 'btrfs tune' 
command, pls consider we may need '--noscan' and '--device' options at 
some point. For example:

$ btrfs tune metadata --device=/dev/sda --noscan /dev/sdb

This idea is inspired by the following command:

$ btrfs inspect-internal dump-tree --noscan /dev/sda1

OR

Since some of the commands perform a user-space system-wide scan for
btrfs-block-devices, so global options like is also not a bad idea.

    '--devices' (specify btrfs image files and continue scanning for 
block devices across the system)

and

    '--noscan' (to avoid a system-wide block device scan when needed).


Thx, Anand


> 
> As an anti-pattern I can mention the 'mdadm' utility, that comes from
> times when the commands were not without the initial "--" like we know
> from git etc, so the main commands like assemble are specified by -A or
> --assemble. What I find confusing is that it's just another option but
> means a main action. The command groups logically and visually
> encapsulate one action and can be possibly fine tuned by parameters
> without affecting other commands.



