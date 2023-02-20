Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6123B69C62C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 08:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBTH4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 02:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjBTH4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 02:56:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584AABDFD
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Feb 2023 23:55:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31JNH5OP018229;
        Mon, 20 Feb 2023 07:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IVHlEUEITnssuv96A4x2cpuCmQ7sjd7s25MVV6UlI4E=;
 b=Qy0yfoMgJrZ8KHDxw8/lNhMJPzu0wltfA2j1xCSJcpg9G4e9Oy6VWfJeOGdpScNW8sGp
 0TYPreXx8zq4gMU589RIpHjmVHdnIkNcTdLpY3gaapd+fH7vFmxJC6Y5/4+kEq6glZN5
 SILdoQe0t1HfdZ9PhI//m/pupf+uFf35jdR2Jxq1mHChOsiwkhrtPM7+J64kpacKFW31
 qMAtS7/RXlP0Du0cu4kBr8b+wxOf/K0Eady5VOtu1IX/oLwlYsox+Nu6yQg7IzTfCfC8
 RInrk2jYR6hfEbypIN6DD2//4k6btNu8cHyHadnPYPIQURmG+2pMarVeN/5IwwrZuFCQ uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3djgas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 07:55:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31K7Rcpa023947;
        Mon, 20 Feb 2023 07:55:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn43mecf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 07:55:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Hs9HHedOLs6aMwdMIKqFng/wbbd6/+CYDHB5pjYOq9D4FnNZfyy+TZvrJlJtt6bWt4hEtPKJaGZUAI8q4TaeTXQJFgdjB7WeeAyD8neACF8Gqq/rK4E5udla+QKbO3+5XqxIke2LaMDnqrQiMLSWAwC2FZUTi/4tai9vn/EicHU5P+MNA2WKg8IRt6qpDfJU2OOlzAed40ykAQ9ojX0iFXoaEB9eOIrBBGzRjjJLRaQwpvdN1DVrQgXLieKtj7BPeV0/XRuVgNU7JJco9jkd82Nh+NQR6DM1eI4/RUAPjGkENJWPx/3kl2D1+giw79txSEBTyrio8evrVOkvqPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVHlEUEITnssuv96A4x2cpuCmQ7sjd7s25MVV6UlI4E=;
 b=lKIMOg/A7NdtW0SftJxmzXOx7kyYfPuUec0tUBpt1Bckg6SO+In+FG81qoK74EPPd5CV/UzuGojwdP0n3sVODqdvUbrLNssHc6GiW4GjBc+yvAGQyytaubZP1MMMSjofK0tvjiWlXqO87soFpRa0M09HNcxIAnXI0wVXxyp6C/elzbJGXTudrwByNJG1Cbev+CX+0H9iancvTJqFksslGcHK49PclDNkmz/Gf2Hnk9gN+DXjYtewygDwQgy5JmmAGxvP36GVCGpwdyRH7+TW1cfgy9ZR2XXdL2VhB9oSKgn5nngQ/ANz8bBXOle67DLxfjAsfKDFcV2ndS6hqiAjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVHlEUEITnssuv96A4x2cpuCmQ7sjd7s25MVV6UlI4E=;
 b=V53ob1S8/yI4YNsGZXN2hdUPbY3LLDO5hIC7mEl/hphwgd1MxH2C5mqADSrX0r/b2v0HiOFCKGDtQ4VsBVro3L3NWtv2al/gTPlfsaO+f9Hd6g1xRzzbQY2aJ17GoCpg/6psCrR1dHMNbz8FQQs8XNMX2s/jbY2ux+BTTp2AOBw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Mon, 20 Feb
 2023 07:55:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Mon, 20 Feb 2023
 07:55:45 +0000
Message-ID: <b0521a4e-15f9-e6d8-0239-97ad83c3124a@oracle.com>
Date:   Mon, 20 Feb 2023 15:55:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: make dev-replace properly follow its read mode
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
References: <da81abd638ca83237b8b50671e72793c498dddd9.1676802781.git.wqu@suse.com>
 <8b465081-65f7-4b97-a1bc-3c6b93d3b9c5@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8b465081-65f7-4b97-a1bc-3c6b93d3b9c5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b0b015-6c05-4276-685f-08db1317df1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syu7R3N6wEdisn6Oaze9hv34FVN+qemzRdQJUYhWzP6piLuV0Z0y1kHJeCzcOcPjSRxv5SZeW8uvNhcd7OV8lHRLNtpgVYRHsAguv3gVrw/QAYmLdQc+eFvK/VPdT+TrN47VB0OEJmAwFXy+HrdDdu5PSpiF9pwL4Kc8gfahmdFwBJZF95fuugIq3gyQtXeF8Zq5NTLtKmMGF1EOUv74knpUSCRTb47nMYgepBmg9Vx3eBbFznVCHWLWLgJE96eYYBwOYEWSKPu88+HRBWuOcuLd0+vYPSBT/ya/aO/HS1wORtWcWoVJaatyPiDzx7fVWuVE+csHjK14zVTvyS99qdapTy6zJyZkFkO3HX2EgZruA46ervE3+YIv1IhwfKLduaYC9ns4DZUv0GVIuGmwve3PS+PK/SZYlEsTCMUXjUrCV3fPSy6I7PomJXNh2z54H3H+t4F8GAtLkMzIrnTh1mmB8z6LJX+zkf5LnT3cP2fqjdVZzYEWwcCOw678uIVpyq/5v75xghmMSgSv+y8V3sq1mSHG29Vs9QmDHW3eotd2dWDEPJ5+7/tniPC8iQv/UclLo/Rv1jm8y5C5mxCvkeeaI6gnf+05wf5apzufiWytAsDxpVykaMlUFRUswM8TdxaiuGIAXdZrudnzm++LzfX+7fZFUHRMQ83h0OpjQo3ZU42/1UInklQD1C3rXkXBNeKyRKlLmK6c9EwXdFZPDDtMuM1Csoh/gXf0TQ5QpoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(2906002)(31686004)(316002)(86362001)(36756003)(30864003)(5660300002)(44832011)(8936002)(31696002)(66476007)(8676002)(4326008)(41300700001)(66556008)(66946007)(38100700002)(83380400001)(53546011)(26005)(6506007)(2616005)(6512007)(107886003)(478600001)(6486002)(6666004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1AwOGU2OXZOYnhaRDEzU1dKcktnaGNTaTRPVGtNZ01sY2tIWTFrd2R6WjU2?=
 =?utf-8?B?Sm43UTQ2Q0RRZUVzTTFjTHNYR2wxTklyaWFlTU1zdnd0bVdCa0Erc2NpUXBa?=
 =?utf-8?B?cHBWc3dtT0dRMHNIT054YmUvYlhqbmFyTFd3UmFvdWxORWNwOU5OYUNJSDFu?=
 =?utf-8?B?Q0lNVnFEbWhDdXNCNjQvS1JGNnZwekVOaitPREw5aGordzloQWV5SVFiNHFq?=
 =?utf-8?B?N1hFQ3dCeHd0dktRZnM0WHJBR01CNDhIeWd0Y0RZdUI4ZjFxdzA0RGJVVmE3?=
 =?utf-8?B?OXUxS1QwUGdrYUpkQmNGMmhSYTBkNTVKTnMyWkIrT0FEU0pYcElweUZDUThT?=
 =?utf-8?B?TktIMStUZUhqSUEyY2VpTEI3bFZ2aGlvMll6WU5UUG1TY3ZpZDN2WjZReTEv?=
 =?utf-8?B?enFoYW5lRlF2WExFYlJNOE5GR1FDWWMwM3B2emV6VnF5eG9rYlJaOWcvWC85?=
 =?utf-8?B?eDVTS2xUcC80aWNETGZ3NlFGK2dTTHYyRWpXSlFEc3lpSkJ6cUYzUGtuNXNh?=
 =?utf-8?B?eW1DQUpabEdmYWttRDc4UkVHN0pwYUR3SktVRUFBZ0RYcndja1loY0FqNzE5?=
 =?utf-8?B?anEyMHFlNXRCTlRBb1laYU5kRW9odzRFbEUvMlJpa1A3cVRXUkNBZ0FJL3hs?=
 =?utf-8?B?aGI2a1l2aUl0RUtTcjVDeUd4WXRCYUpaUkUvNnFrMTJhK3ZQUzVjbnpMd1hI?=
 =?utf-8?B?L3dyaU02OE9VWklpVXdpaDEzLzVLbVFLdEJLZUhDRStsdndWZFFyMHpZN0Nz?=
 =?utf-8?B?cHk5eXRmZEtNdGNrN0ZWV0c4ei9KeGh6eUNqRDdmSVFodGpRWTNjYXVTSzVK?=
 =?utf-8?B?Ym1URTVQK2h5N3BqZys1Q0ZPeC9peVIzL2ZLQkRsTVU5ZUt4QWZ6MmFWSjgv?=
 =?utf-8?B?YTc4R01XQ3RSV0tNSkV5V1EzUDhtKy9sc1JTVWNiR0VRck45UTFKQnNFSytU?=
 =?utf-8?B?Vi9wbTYwMFBTK056dUlTMmJtRThtVjN4SnhHczQzKzN3WFM1dzdCYXhFaUYw?=
 =?utf-8?B?ekd4ZjNDSWhXTlZzNUpCNFRQdUh0bDFGdEJSUmNTRmczTVhPUzRXV3h3M0ov?=
 =?utf-8?B?ZlBVcW52RTQ3cTJUUERIekZWUFF6WjVFTWgxb0lpV0ErUlQ5YTJuRVJGQm5p?=
 =?utf-8?B?THJCTzV6S245Z0pUOFVjeDRBbFNvT1NvNmdjV3h3bkhoK2JCeGVRMiticCtq?=
 =?utf-8?B?VzVqVHJ6TjFwOU1nL3A2SmlOYmJwNjlyZHY5dGZxQml3NkVFNGVCc3FkYnF3?=
 =?utf-8?B?ZmhmbGxtYi9SMzlVVnhRaXgwMk51ZkM4ejQ1cXBCbHRyRHExaytNZFpXc2h4?=
 =?utf-8?B?Q0xkaUFXelpqWENQOWJycHZieUZ6Y3dPaXhibFB1SjhzTFFlbVZtOTVxdUl5?=
 =?utf-8?B?bERPdzF2WFl6WlNFWTYxZzNFa3dkUTNHTmN5aUFwNWhDc09zWGNUbE96TEJ2?=
 =?utf-8?B?enFraUluUnNzTVByVUl1cXNWZ0ZxdzRxakU0MGVtRi9aNURPMDVqMVozR2ZN?=
 =?utf-8?B?V0FhaG1SV25QdW1NUC82MGRRTjBxejF1Z1YwNXdZREhUYmVUbldFTHFIV3lE?=
 =?utf-8?B?T2k3a0Q0UlA1Wk5rREpMOHhwZXAvRFlwRUpoMVV0bjFreTRjUHBOS3pRSG52?=
 =?utf-8?B?L2MyV3JIVTliWU85OG8yZ3lYR2lOMThEZnczQ1NrcWZSc0RTUGdjQkZhOHA2?=
 =?utf-8?B?RUhsbXRHMWtMQ0FUSElVSE5sNVFlQnZ4NmNKMHJPOGZud0hxUnNWQVpVNXVk?=
 =?utf-8?B?NlpOTlVYWjRhR0o3b3FBNU40SWZkaU1hUURUU3J3VWM1UW1FQkF1M0t3dk9Q?=
 =?utf-8?B?YjBPR2JqMldneFBIZGNaQ1lCL1FEMzdITjBoRDAzMlRnQ0ZsTGx5em9NRm8r?=
 =?utf-8?B?RVcya3k3bXExOHRmMmx1SkpoMFlkV2NtNU9QMTBGdGE5MjNEV0I5MkhZby9M?=
 =?utf-8?B?T2x4VEdHdUNGcTR1Q054RUtYTzZMVTVZWVE0L0xCTlV2ZE4yZ0hYa0wvWDlh?=
 =?utf-8?B?ZExOVlBoMnFzemJMZ0h4UGpJL0lyRDhsM2U4bml2SFdlTGxXdjYwQWg2S0pz?=
 =?utf-8?B?VjVvaGMxNlAxeW5pOTF5b0dSVU9Vc3VORUNETHpNRUwxZmVJcGNzVjFnR0ZQ?=
 =?utf-8?Q?H37U+WiiEdMjv0R/+Fa1EbqYL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5oYqP1DYJ6S2weAGfnYKZSUoMzvJX4lSAkzEjHPnkCQp0d0IioieNld1TLzRj3fEfBJRJ7hjZZQAJdiJPrV+/V958lTki4hrI4zPGGL1ICuLHKoaiiFJ3QsI8cTL3GhlgqHA/uTZOJ1Bp0uxhvUgpZLwr/aouBU+mmk0o17ttEK7yZpCmZk3muq14fhTvXEj6PjEFQ+004rH0TyTeGeCZktgjvfRzneFixg22KaUE2yGWi193fsRycWCTyi53P7FRMFbI1mvs2feWgPYL0lQO8NE6pwDY8fBdEY4AiKYMluxiRC30lgT9HsavZmD9uU2KVaqiOZulTYkCVjPt4QZtcNf211h4QG2WQEaFsjGIhB5eAEZvuFTxwwXLT+ySwz9vRsbNbWQj2UfEBLlwriUchAZtWYztPlHBeRGaklfH9W2CZBW3z4YWqNZkxcayeFT18ranJlC75RUeo90qN19pSEYnVKyBAEOHh0J23baMXH/k0gRWmkylLpD/LIhmDO+uLGPoAZdhd6LaB+lTB4z7FAzV9zZCh5CTNa+WpeQAdMCaBoVqBqISTkxswiay3YO8GPe+59m7itTFe9HhDlQTBhNh/pzJOpK0CwL3DIs6C1Cbb0KdfpGl2mkK9FWNxSTDLaa/jNoulF74WNQoyc+xuox45CioAE8aA9+y3YtfZTIyKimRuJLl/JrKoWzGuu88gcU0wMGeUKV+008Ege09UO1QjEti55odMQhMfepJeSBTQ8rDMJ2Jsl93IpcjnMF6PA98YyCyNRpyy99KyHckPBOTqGTbCs78Z+iXcF2QyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b0b015-6c05-4276-685f-08db1317df1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 07:55:45.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIwxINl85AU8kvOzM92g9WwR48ceV2Otq6P1FvHbMPqwEuTYMxpId15Fi8a4YJnnxD+BwR1laVslccKLlKpz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_05,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200070
X-Proofpoint-GUID: VdtA8BTECFdK6y6QpQut5iuZYf9YKHu8
X-Proofpoint-ORIG-GUID: VdtA8BTECFdK6y6QpQut5iuZYf9YKHu8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/20/23 10:56, Qu Wenruo wrote:
> 
> 
> On 2023/2/19 18:33, Qu Wenruo wrote:
>> [BUG]
>> Although dev replace ioctl has a way to specify the mode on whether we
>> should read from the source device, it's not properly followed.
>>
>>   # mkfs.btrfs -f -d raid1 -m raid1 $dev1 $dev2
>>   # mount $dev1 $mnt
>>   # xfs_io -f -c "pwrite 0 32M" $mnt/file
>>   # sync
>>   # btrfs replace start -r -f 1 $dev3 $mnt
>>
>> And one extra trace is added to scrub_submit(), showing the detail about
>> the bio:
>>
>>             btrfs-1115669 [005] .....  5437.027093: 
>> scrub_submit.part.0: devid=1 logical=22036480 phy=22036480 len=16384
>>             btrfs-1115669 [005] .....  5437.027372: 
>> scrub_submit.part.0: devid=1 logical=30457856 phy=30457856 len=32768
>>             btrfs-1115669 [005] .....  5437.027440: 
>> scrub_submit.part.0: devid=1 logical=30507008 phy=30507008 len=49152
>>             btrfs-1115669 [005] .....  5437.027487: 
>> scrub_submit.part.0: devid=1 logical=30605312 phy=30605312 len=32768
>>             btrfs-1115669 [005] .....  5437.027556: 
>> scrub_submit.part.0: devid=1 logical=30703616 phy=30703616 len=65536
>>             btrfs-1115669 [005] .....  5437.028186: 
>> scrub_submit.part.0: devid=1 logical=298844160 phy=298844160 len=131072
>>             ...
>>             btrfs-1115669 [005] .....  5437.076243: 
>> scrub_submit.part.0: devid=1 logical=322961408 phy=322961408 len=131072
>>             btrfs-1115669 [005] .....  5437.076248: 
>> scrub_submit.part.0: devid=1 logical=323092480 phy=323092480 len=131072
>>
>> One can see that all the read are submitted to devid 1, even we have
>> specified "-r" option to avoid read from the source device.
>>
>> [CAUSE]
>> The dev-replace read mode is only set but not followed by scrub code
>> at all.
>>
>> In fact, only common read path is properly following the read mode,
>> but scrub itself has its own read path, thus not following the mode.
>>
>> [FIX]
>> Here we enhance scrub_find_good_copy() to also follow the read mode.
>>
>> The idea is pretty simple, in the first loop, we avoid the following
>> devices:
>>
>> - Missing devices
>>    This is the existing condition
>>
>> - The source device if the replace wants to avoid it.
>>
>> And if above loop found no candidate (e.g. replace a single device),
>> then we discard the 2nd condition, and try again.
>>
>> Since we're here, also enhance the function scrub_find_good_copy() by:
>>
>> - Remove the forward declaration
>>
>> - Makes it return int
>>    To indicates errors, e.g. no good mirror found.
>>
>> - Add extra error messages
>>
>> Now with the same trace, "btrfs replace start -r" works as expected:
>>
>>             btrfs-1121013 [000] .....  5991.905971: 
>> scrub_submit.part.0: devid=2 logical=22036480 phy=1064960 len=16384
>>             btrfs-1121013 [000] .....  5991.906276: 
>> scrub_submit.part.0: devid=2 logical=30457856 phy=9486336 len=32768
>>             btrfs-1121013 [000] .....  5991.906365: 
>> scrub_submit.part.0: devid=2 logical=30507008 phy=9535488 len=49152
>>             btrfs-1121013 [000] .....  5991.906423: 
>> scrub_submit.part.0: devid=2 logical=30605312 phy=9633792 len=32768
>>             btrfs-1121013 [000] .....  5991.906504: 
>> scrub_submit.part.0: devid=2 logical=30703616 phy=9732096 len=65536
>>             btrfs-1121013 [000] .....  5991.907314: 
>> scrub_submit.part.0: devid=2 logical=298844160 phy=277872640 len=131072
>>             btrfs-1121013 [000] .....  5991.907575: 
>> scrub_submit.part.0: devid=2 logical=298975232 phy=278003712 len=131072
>>             btrfs-1121013 [000] .....  5991.907822: 
>> scrub_submit.part.0: devid=2 logical=299106304 phy=278134784 len=131072
>>             ...
>>             btrfs-1121013 [000] .....  5991.947417: 
>> scrub_submit.part.0: devid=2 logical=318504960 phy=297533440 len=131072
>>             btrfs-1121013 [000] .....  5991.947664: 
>> scrub_submit.part.0: devid=2 logical=318636032 phy=297664512 len=131072
>>             btrfs-1121013 [000] .....  5991.947920: 
>> scrub_submit.part.0: devid=2 logical=318767104 phy=297795584 len=131072
>>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Rename "replace read policy" to "replace read mode" in comments
>>    This is avoid the confusion with the existing read policy.
>>    No behavior change.
>> ---
>>   fs/btrfs/scrub.c | 131 +++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 97 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index ee3fe6c291fe..4c399a720bf1 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -423,11 +423,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, 
>> u64 logical, u32 len,
>>   static void scrub_bio_end_io(struct bio *bio);
>>   static void scrub_bio_end_io_worker(struct work_struct *work);
>>   static void scrub_block_complete(struct scrub_block *sblock);
>> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
>> -                 u64 extent_logical, u32 extent_len,
>> -                 u64 *extent_physical,
>> -                 struct btrfs_device **extent_dev,
>> -                 int *extent_mirror_num);
>>   static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>>                         struct scrub_sector *sector);
>>   static void scrub_wr_submit(struct scrub_ctx *sctx);
>> @@ -2709,6 +2704,93 @@ static int scrub_find_csum(struct scrub_ctx 
>> *sctx, u64 logical, u8 *csum)
>>       return 1;
>>   }
>> +static bool should_use_device(struct btrfs_fs_info *fs_info,
>> +                  struct btrfs_device *dev,
>> +                  bool follow_replace_read_mode)
>> +{
>> +    struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
>> +    struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
>> +
>> +    if (!dev->bdev)
>> +        return false;
>> +
>> +    /*
>> +     * We're doing scrub/replace, if it's pure scrub, no tgtdev 
>> should be
>> +     * here.
>> +     * If it's replace, we're going to write data to tgtdev, thus the 
>> current
>> +     * data of the tgtdev is all garbage, thus we can not use it at all.
>> +     */
>> +    if (dev == replace_tgtdev)
>> +        return false;
>> +
>> +    /* No need to follow replace read policy, any existing device is 
>> fine. */
>> +    if (!follow_replace_read_mode)
>> +        return true;
>> +
>> +    /* Need to follow the policy. */
>> +    if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
>> +        BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
>> +        return dev != replace_srcdev;
>> +    return true;
>> +}
>> +static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
>> +                u64 extent_logical, u32 extent_len,
>> +                u64 *extent_physical,
>> +                struct btrfs_device **extent_dev,
>> +                int *extent_mirror_num)
>> +{
>> +    u64 mapped_length;
>> +    struct btrfs_io_context *bioc = NULL;
>> +    int ret;
>> +    int i;
>> +
>> +    mapped_length = extent_len;
>> +    ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
>> +                  extent_logical, &mapped_length, &bioc, 0);
>> +    if (ret || !bioc || mapped_length < extent_len) {
>> +        btrfs_put_bioc(bioc);
>> +        btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical 
>> %llu: %d",
>> +                extent_logical, ret);
>> +        return -EIO;
>> +    }
>> +
>> +    /*
>> +     * First loop to exclude all missing devices and the source
>> +     * device if needed.
>> +     * And we don't want to use target device as mirror either,
>> +     * as we're doing the replace, the target device range
>> +     * contains nothing.
>> +     */
>> +    for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
>> +        struct btrfs_io_stripe *stripe = &bioc->stripes[i];
>> +
>> +        if (!should_use_device(fs_info, stripe->dev, true))
>> +            continue;
>> +        goto found;
>> +    }
>> +    /*
>> +     * We didn't find any alternative mirrors, we have to break our
>> +     * replace read mode, or we can not read at all.
>> +     */
>> +    for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
>> +        struct btrfs_io_stripe *stripe = &bioc->stripes[i];
>> +
>> +        if (!should_use_device(fs_info, stripe->dev, false))
>> +            continue;
>> +        goto found;
>> +    }
>> +
>> +    btrfs_err_rl(fs_info, "failed to find any live mirror for logical 
>> %llu",
>> +            extent_logical);
>> +    return -EIO;
>> +
>> +found:
>> +    *extent_physical = bioc->stripes[i].physical;
>> +    *extent_mirror_num = i + 1;
>> +    *extent_dev = bioc->stripes[i].dev;
>> +    btrfs_put_bioc(bioc);
>> +    return 0;
>> +}
>>   /* scrub extent tries to collect up to 64 kB for each bio */
>>   static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>>               u64 logical, u32 len,
>> @@ -2746,7 +2828,8 @@ static int scrub_extent(struct scrub_ctx *sctx, 
>> struct map_lookup *map,
>>       }
>>       /*
>> -     * For dev-replace case, we can have @dev being a missing device.
>> +     * For dev-replace case, we can have @dev being a missing device, or
>> +     * we want to avoid read from the source device if possible.
>>        * Regular scrub will avoid its execution on missing device at all,
>>        * as that would trigger tons of read error.
>>        *
>> @@ -2754,9 +2837,14 @@ static int scrub_extent(struct scrub_ctx *sctx, 
>> struct map_lookup *map,
>>        * increase unnecessarily.
>>        * So here we change the read source to a good mirror.
>>        */
>> -    if (sctx->is_dev_replace && !dev->bdev)
>> -        scrub_find_good_copy(sctx->fs_info, logical, len, &src_physical,
>> -                     &src_dev, &src_mirror);
>> +    if (sctx->is_dev_replace &&
>> +        (!dev->bdev || 
>> sctx->fs_info->dev_replace.cont_reading_from_srcdev_mode ==
>> +         BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)) {
> 
> The check condition is not safe for RAID56.
> 
> For RAID56, the scrub_find_good_copy() won't return a good candidate at 
> all.
> 
> Thus unfortunately for RAID56, we won't follow the avoid mode for now.
> The proper way for RAID56 avoid mode is to go rebuild path instead, 
> which is pretty different from the current code base.
> 
> I'll update the patch to exclude the RAID56 mode for now.
> 


Based on the comments found in the only parent function of
scrub_extent()-  scrub_simple_mirror(), this function
stack is not intended for RAID56. I don't understand what you mean here.

Thanks, Anand

> Thanks,
> Qu
> 
>> +        ret = scrub_find_good_copy(sctx->fs_info, logical, len,
>> +                       &src_physical, &src_dev, &src_mirror);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>>       while (len) {
>>           u32 l = min(len, blocksize);
>>           int have_csum = 0;
>> @@ -4544,28 +4632,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info 
>> *fs_info, u64 devid,
>>       return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
>>   }
>> -
>> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
>> -                 u64 extent_logical, u32 extent_len,
>> -                 u64 *extent_physical,
>> -                 struct btrfs_device **extent_dev,
>> -                 int *extent_mirror_num)
>> -{
>> -    u64 mapped_length;
>> -    struct btrfs_io_context *bioc = NULL;
>> -    int ret;
>> -
>> -    mapped_length = extent_len;
>> -    ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
>> -                  &mapped_length, &bioc, 0);
>> -    if (ret || !bioc || mapped_length < extent_len ||
>> -        !bioc->stripes[0].dev->bdev) {
>> -        btrfs_put_bioc(bioc);
>> -        return;
>> -    }
>> -
>> -    *extent_physical = bioc->stripes[0].physical;
>> -    *extent_mirror_num = bioc->mirror_num;
>> -    *extent_dev = bioc->stripes[0].dev;
>> -    btrfs_put_bioc(bioc);
>> -}

