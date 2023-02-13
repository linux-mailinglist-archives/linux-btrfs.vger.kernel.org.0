Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0B69449E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 12:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBMLew (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 06:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMLeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 06:34:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48F2118
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 03:34:50 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DAUHDQ017729;
        Mon, 13 Feb 2023 11:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=A2ukK7fnHaqsDkdNqy5FzHPGBCQYRL42Ig+72V4tx0Y=;
 b=h0HKp6gFF5+BeKta3n4lKvoXZADR1YDh7OXhfd1el4X+hvnntUJUWhuQ65ECp6xgUKrq
 uy667KXFHY+zTuVl3X4pgezrcLiFA8gdHdIQYcaSZxW7BnzaDLIPtmaGtegx7BOtGXst
 730ItiScRBy4M7lbdfBUPP2GBSRLOIzaAFdwKZy9MnIBRKMXS75MOYCbyWrvN/B7KExm
 8c3xMEsa3blYU3EoPlQwG1crbruwC3bwVizJ1BNs/k49xN5RcWjfsCgk+UnlJ3PBX4gt
 rUdkAnoIiGwRvnk88+hr0CtlkZwUh/pQJz1WuklDw0sZG0UmL7oNoiMtMm9hsljAn8Ga LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jtth35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 11:34:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DBXTw2028824;
        Mon, 13 Feb 2023 11:34:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3pwum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 11:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLDfZPddgQeRFFrl7n+p9TbCg7PmJoLElvdSLpTNyifG3vMvI+XyJIakCRttwHlMPSH0G/K8o3ln3/QblLWfurgwSminoRi35he1utDkoe1ZxbuVTsd0z1EnzlfJsX0yzvMKHIV8NvBc7WD4OfV/wd1mDGAwgztgmkEo8uWuD83bHwmlBWMoGrdlov1EEH12pqq38Upz9MgFjFvXRyvD3I04u35P11gNHtNPXcjDeCzFtuVXuawFpITUobE5mhWlFocSaU54XnGvWPY2J6kA2mnLGI1V0pvwey5mt4H1/skou9ABTwb6gNZMmxpnCJQm4/RQSxE/vZP76szKfmr/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2ukK7fnHaqsDkdNqy5FzHPGBCQYRL42Ig+72V4tx0Y=;
 b=BZd6TJrVfWRdmGAHhWa9LHrTU5EaQ/ky3OTw+A3Wsm2ZEq/XkAiqtmk/44VnJdWx00LdMMxUH7TcAIXcljgW4XRvqAOcKr/YTABpX3jtFrNlPat8U82WiMyIHPRZ5OasVWc3uQrn8u7iMdHDjQXfesccd57uWzuQZDxg+Ko8wmQVAhvVNr7zZU3Q6b7nqcNU9TUsWN/XGoFVYBdDBzNLfgE4jmRZozkTdej8rdyBlvckOeufEy5Hob1Q+BUW10aSmEJ/tB0zTjVG1HyOYRQ3dCTn4h2Z6RG9iPdBuZh7ku3DiXWKn5luAQUpP2Git0vI281ddG8pw2PfrXL9U7MeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2ukK7fnHaqsDkdNqy5FzHPGBCQYRL42Ig+72V4tx0Y=;
 b=hjgYAJ0MkyXe7nyUjjlnamvtB+4aSAUNJKp/FNGazYKu+PBMLyVuqO/Jt4HhgeCv93xnBV3rG7IKGf61GA9Qsni8j7sVmYi/aBt6uBZ31quIEpiO7Fm8K5Nj8xfdA7f4M0xo3a2A3VPQq5sjPNeiudCGumxQXU3Ru+Rt7qd49bE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.16; Mon, 13 Feb
 2023 11:34:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 11:34:45 +0000
Message-ID: <8e970a84-b7b9-a8e6-a5bd-d586966337cd@oracle.com>
Date:   Mon, 13 Feb 2023 19:34:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 02/13] btrfs: add raid stripe tree definitions
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e83b0f-677d-4445-70ae-08db0db64e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FgZdt6NB9pJ38C9dwd9uhljIP9Jt6qvpt71voojBfoG8uQNOgrAUbDOzV2nDpEzrOgtr8hZ3uYI6vPAs0L5kemOnoPKJzaH9xW6P+tiatC5+T2IP3aGDPEXH9F7Q6yACIPbbYJ9cjQTmEb/4Z7RUfXN0D4lOcvuw45+VdeMvIM9YD6o8pYb5lLSEbQwhWPkolWnEnEwGzDMrSvEHkOMdnNwuow3tMt19ySgyuV1Lj0eO7Khz7KHpsybTkc42OEuDJLKgtfc/2g3N+pbiN1Qn0sw1gAEq4zEYDeVF5yAFt9kbXRbyqYmuyMoBKAZnQlEgQ/T1vAEtKpRxkEXPDgPjN/2IjeMvvYL1HuvP68/iIXFX3IN7IlpImZvHoYx65uxfCNDhRsRX76Z3GBAqQyKtenRsw+2BUf97uOFay4j2uRYPRfbSNtx/zlWwIn/ViqAVJxuGf89Pbxc652swXtTVMPrVtv0ZEHyJcR229CS6/lk5CXT0VdV7tMU5IHeY+tAFFPpHUkq3a+WxN+IePJa8+Wh75gYsmG0teCN2hSXBlcnTy3i1/H85846MUoenQ3qU81pQHBSEs2nUNyH9iiVvsDxlhuRWvwCfdGgo8OL4XPyim9n6nxROdFMphB2UndvXCbXdRQLiHNPVY+GK+EXQuld2IJrUYeLKFckWEfhgrn62fax0YKFGDyguqJePfsmIde7pUOxeDJDEj335jXHFa1NnwRyqqSJ3xdbgdXp9X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(44832011)(4744005)(41300700001)(2906002)(8936002)(5660300002)(66476007)(186003)(6512007)(66556008)(31686004)(66946007)(6666004)(53546011)(6506007)(6486002)(26005)(8676002)(478600001)(31696002)(316002)(38100700002)(2616005)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0pOdkF0dTlXbkdjRnRFK1JLcWUrRFNvaUVsM2ZJd2dwMXNpelR3TEl5NDIz?=
 =?utf-8?B?c1ludXg1WXkzbkdxcWFaWmVFa3RuRENaRENMcnRRc3V5TmsrK0Z6WTRqcDJN?=
 =?utf-8?B?aERvWm5aVi9OTXdJRnFaYXd4VlJ2MlJKYW1wVzFPWFVPN3hVTHkrdTQ4eVBn?=
 =?utf-8?B?ZnVCN1BQVDBQSlc1bUh3R1IrNjNBUTNQQko5VFpLRkxEZ1VjMWdTWkgwRnlI?=
 =?utf-8?B?aDUzbm4rU3d4QkE2ZklpR0hHMUV1cHFTbE1IaFpNbHJNMitWVHoyd0dJeS8r?=
 =?utf-8?B?VjFiZVpROXZhV3JzVTM4NzZjZ2J2Ui9vMmtmMEQrejFrTmV3M25oSWV3ZEl3?=
 =?utf-8?B?Qyt3a09JU3FZcFczeU1DeDE5ZEhsSG1vSzk2UmhUYVBPdnNQN3JQR3dCakJT?=
 =?utf-8?B?RFlCekdyRjR5NjM1STd6NlJiZEEwQXZGRXY1QkJGbnJ1L3BCaTlRcUFzVVFi?=
 =?utf-8?B?OGlKSjJOdnZxZW1JemF5WndKRnoxTmtvNFkxdnJ0ei9HSTJvaHMxUGNaT1Z2?=
 =?utf-8?B?UUpYZlJzRTRveE9JQSs2U3hyWVFxNzltNitHTDZXVWJQWVc3TEVZd0owUStH?=
 =?utf-8?B?ZzZqa251ZXJjbmJBR0FYcUM2a1BieUdkVzV4bjF5cDFtWjIwczYxam9tY0lj?=
 =?utf-8?B?UWZqajU3V3JGajhqOUpoNEMwMUFDMlRMdG9KZGUzSVlwL0hJVzk5ZGZsK1d6?=
 =?utf-8?B?ZnBzblB6TU93SU9yYzMxQmJQTThydk9ZODBMTlVTQ1VIUVZzdWNMT0wybzVU?=
 =?utf-8?B?eDJQTWFibEkxektKRytkY29TalNlc3JKaHY4cURIMGVTVitVVC92N3VVNjEr?=
 =?utf-8?B?QVhMWCt0aVpkQm9pd05teE55Lzk0NmRLZFZ3ejF5WTdLcm5yU01nRnVnN2Zv?=
 =?utf-8?B?bGVuNlFRNWlTY3AvZUtKYmJjbWVsaHB4MDk4NVc0T0Vmc1JBMVJNL2JtVnFW?=
 =?utf-8?B?azVzQzAvK3hPM2xzK0RwWDg4VXlmbllNcE5mbFFHOEY3eSsvaHpKd29sMzZU?=
 =?utf-8?B?OUM3M2o0YTBsNldlanQyVEZGWE56MzFzZE1lRUVRM29najVwaWFEWjR3WHNz?=
 =?utf-8?B?VEpVWms1MTE4U1ArMngrQVMwN3AyS2xzZzlJakIyVDZLdHRnTjUzOWkvTFBm?=
 =?utf-8?B?N0M3YkQwV00yQUhEQmRINjl6dlZweDN6VHBwbkltMnFYa0phUW9XblVnYllD?=
 =?utf-8?B?VXVVS1c4Y1ZnNjB2dHNGajFkeCtKOEFuTWJOcUlFd09JWHdibkpKcnc4dUNw?=
 =?utf-8?B?bnlDbnlIbmtDMlAxWDZRNytzSEhQV3hpVkZqMXBmbUEyTTUrOXhPK0d6Z0tt?=
 =?utf-8?B?bE94blNzOWJ2aFM2OUpBZlFQZ0JvdzExS3V5dEdBa2UzMytRQ1RESStsWlI3?=
 =?utf-8?B?TXV5UjhKYjUrYWJOaGlReUhSdUZZOFY5SiswVDU3bWFtZ1E3eG04eFJIQUZP?=
 =?utf-8?B?eHJxNkM4Q0hNcEc5em5MNXlqYVNYTlBKZWsxVURxbjAzaUFqNVZCS1UwZkhP?=
 =?utf-8?B?Z2FzK3NJVXZIQlp1UTMzeGN0K05xUGF4U1FJZGZOM29SeDh3aUFsanRmQ0dp?=
 =?utf-8?B?Y1VLaHh2cUFLK1RzZUd3WEh3ckE4Skdjcm4rNDVJU21lT3hKMHhia0hWUUJt?=
 =?utf-8?B?MExwNmFIMDZUT25udTFaVzB3RmVTa283ckJmQXk5MHBIaVI2bm9Sb2FWZFNF?=
 =?utf-8?B?WmlNVmUrblJ1a245TjF5VG01WFZoRmFSbnM4RWZqT0VUS2F5WXZJMmpxMS84?=
 =?utf-8?B?amFZNnQ2TGRwcURwQm5Ka2tUZUlqUlZMa2VVK3BjVkFISVR4KzQ1TjJOUVMw?=
 =?utf-8?B?MTAyMUw1dEZuS3p6S1VFTlhWKzZselhUdlpDZU91ZFA0N3cvQm0yaEVRUmNW?=
 =?utf-8?B?TFB3UThIRG81S25pbmQ1N3ZYMERjcUtETnJJTkdVN3Jrb29vVVY4bGNrKzd6?=
 =?utf-8?B?SVBLaXdqY2RTRjU4ZkNhQitmMVB2bUw5RW9XNWlDalhNQnhKdTB1Nng1bjlP?=
 =?utf-8?B?RW5aYTRRV0JZaldlZUJlT2tLOEFCdXlQUmswUkFSbzVBcTFOdDIzMTJSVEkx?=
 =?utf-8?B?SWpzamFCVEpUalVyN29tV2dvUkhHY1hlaTRjekxGT2VsZEoyYTJNZU9wMW9z?=
 =?utf-8?B?NTIxczRXOTYyN1NDNGZhSERpVTcxZDBYVngrYVIyT3FGTHIxWmFtakhvbVcv?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0VdGuMF8Bbbw1qtKYRMTq18y5NjXjaaDOO7FEOasDboq5hZHv92+cBQ+P6MEVhgSTsoR7xUw2UbW/U4ewThCZU7UeFLStdFoSP9g/h3XKMAfKqeynm4EbHPzE4jqnaGDETsPHp1Trqrhb1/jJMpnS51D2xCFVBX7qxeeyX7tB3cG5oawY0FSa8/wqw0O9To3IkeaC2BYp7o8L9QM9gCLANoB0i9oILXwSJwUatv8mtWfdFUehTbP9M9y78nlMsryOz+v/j+MJymt1w4rRWYTpZcVYVu7CDijvvTbeWQeQJO3iC35+Q8dl6BFMzU+R2pco7CfZxl+qbap4ZBGh77DtSWM4KjbyMHbm79TsivKSFlxiEJXi4m7VEqT+05Td81z7DW0eQNIHOTNXmX7tzhxFUlJL4/4quygKhMtkURZBry5glL7JERDH6NcCHaHPA07kDzX8f35rJsYY1mxY5UiJqBHj1rrEcxJPwrHh8aSw+vzcENRqo3GJ+Sbu7Nr2Hja7tIv2ceKQM7wRW5AiUf0AlJPcf5/OU/JgslXqnLRV7ez8z1RKkXZWuLCQ5XsgmvM16QFdsnJNsaae2c1rbDd5d27g6Sutj5qcGSGstneUeP3xAssqYHCSJ5oHeJWEytjTl2kW1RpsYsRoJe0z+jYI7PWY8fp8P6jKY7EmHFOAbR4IuzpLJ8c132s432OYUQwbFqwEwjk58Cj60XZub8Eg4FLCEPIOsuhE8rbAs2+axNL5tpMMEaIKezrwE/GAh9lyC1rUIUFN7m+4kkr3RK13aafzzraP+DMCXfJdfx54R8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e83b0f-677d-4445-70ae-08db0db64e55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 11:34:45.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NU3TbLDlYLuEwxxWg8KjrZsGrXVy0vto4m6Q6yPFxRILpVqXidq/ETMU9xw/QOB9wtwMEHX8cr2GPtHeNk5gWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130104
X-Proofpoint-ORIG-GUID: CeBQVfPKsQSjKEPyzLAGyzmvx9ocR8uX
X-Proofpoint-GUID: CeBQVfPKsQSjKEPyzLAGyzmvx9ocR8uX
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/02/2023 18:57, Johannes Thumshirn wrote:
> Add definitions for the raid stripe tree. This tree will hold information
> about the on-disk layout of the stripes in a RAID set.
> 
> Each stripe extent has a 1:1 relationship with an on-disk extent item and
> is doing the logical to per-drive physical address translation for the
> extent item in question.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

