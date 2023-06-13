Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4F72E119
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbjFMLQ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbjFMLQM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 07:16:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942249C7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 04:14:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65NoP028714;
        Tue, 13 Jun 2023 11:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4yLZDCnFLR2VUGhL/uJEGoEGcHhdW9b+hX5Czj2CQHw=;
 b=npjijSSZ7xIxQBczkqwRzQZqsImaqoWPeeTvojTeXNml+FnCE9JWsKHYLO6i4mVENPMK
 pSaEplZBUmR5qS5CDB9Vh0UGYN0gvOJcaLYOsOBe4XoBWDS/yYa9kTI3wBtyW1yESfrj
 De68z6s/hEqPwyK3vPj84j+XldBGECIk+wYS0Sk3NwE1c8loY7tuGPVxQV3yu111sxOH
 LP8v1NNHkuZLUjAp+p6/A/0fLrJ7FIaqbr5nopDu/gQ0oR9OePzqRKTy/kGizOKiz8Vz
 MHSYEWvI2+w6BiFKes66LSuR+Pjx41NckbD+zbb+VjnxTJYwnBanwQdlkS4PNdSHhcMZ TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdmwbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 11:13:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DB2UB0017765;
        Tue, 13 Jun 2023 11:13:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3rqdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 11:13:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEimiNONBDPkbQIQVzNiQ7KGoxA227HsRJsRZ1vi4rKjX68BqHL7tH2vSzmL0UePZ6GZVTtj4oOliNK1v8XldPrHKY+MVqlwra/DhjtGsOhh7LeLzeYxFcprO0t/YDBwi1w/m8lB7aLjxQGz5+AaJSBoAIhPKD8nYVnlNvT2n2FPSHx7ad186fzBJWl7HfURrU8VsbQ9iEqqxae+SrhazRL5wl+S+wbCFhvpiFmx9CSLTOMrJRmDFVkr0HSS8kznkvWx2Ac0+tIPWQq310GJjYawKrwkbrXSSunCZVCUgU/4PRmoW+N0Zj+sIg6zlCv3uup8w7SRuzRYGS/Ztrh4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yLZDCnFLR2VUGhL/uJEGoEGcHhdW9b+hX5Czj2CQHw=;
 b=Ry8ycv2SrWs4jOAdgEnIX6OJzjpbenioZ0PbyYU8ugQEWRA4RmubFUwy2wuJGkMRJ+LWW09feE02yS+8jJursRsmCsmQsEcXpLz22LhpC7EoJB/hixC/hpk4nS3ge32LNQ3A84x0qw2Pa5Cp313uwpVyZOBXvJXzvgVXwxq3JS8Pe+sdlM/DfX0NfxL9Mnx/XXqdZlGX0bT9Rccuh/Y5sPSxsNQCf0It1PwRJZLMD/Qc7G7kQZHPCCh0/O210ffYdK0xA47Sdz0xZu7ub0RGFqZDZVM7+/jW7Izey7yqhGs+ckbL/2NFjeI56MlIOHVrwescxEnWtFCpLvDUKOTLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yLZDCnFLR2VUGhL/uJEGoEGcHhdW9b+hX5Czj2CQHw=;
 b=yxhb2EPTHr+f8Ey5hYq4Tc3MVt4LHZPJLZXKELupf8SXZlSfj/14oQUu/M5z4fma6khqx3ZxmK7ChArB/thdwepb6S5twd4I5OWRJXl5+sUoVNg+0M90lrSSr/BJWRw9qzsmBOS2FbKCNJJl94WP+khcyF6g6tSGOH1f8jiHdqY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Tue, 13 Jun 2023 11:13:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 11:13:06 +0000
Message-ID: <59f73780-e6d7-5054-6b09-96a07645714c@oracle.com>
Date:   Tue, 13 Jun 2023 19:12:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/7] btrfs-progs: factor out btrfs_scan_argv_devices
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1686484067.git.anand.jain@oracle.com>
 <e635739e6aa18e70036ddcf63019cf0e4d4493b0.1686484067.git.anand.jain@oracle.com>
 <d476640a-d6e7-2add-e440-f82e4fe2a8c7@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d476640a-d6e7-2add-e440-f82e4fe2a8c7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: d35702c3-0b95-4e07-8391-08db6bff295d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPVjXHwfYfTNFkBZ4b65z2UQqkkfGxzSQhNREiYt7yt3kc3zCZRZGMrooxfGB1aJk6JG3Nfr5FJ7NQU8A5IHgacS3epT/IqJLM0n386M1Fzw5h8HMrr0zU1nVKCh2O7UAPFPTRS+n0gYV7/R8Y8PmdpK1pEZ3989K/b2yepgxMW3jcEJRHw+ALD9LO4/lfjjREd9VtxwRJEroTs+b2k+1FTyix8S+3b+3bXs1IsibLZ5FD8qlYQkVizUItcKbL/lulaXcoY+zU46Pej7d+hO8FJ+t0nZtreKuHX5C8SiaLn8/wd2CAkVMrvMwVQJbc/cqYceJ6zQ0mw2JGmFgHPEmKD4qGHBxKV21PmzHeinfIPRdppTpQ22pGgMLk4E0jkYm/dDxD3co+sShiyhRKzLq7T9ZW0hHD6MyPXgM9HVYWJ8T2sd8U3pOM/AcNL7FzlYnAkOL5B7S53JpZHMqWk+zwKggmxkL8X/VanDoVz+YXtgNPn5EkqZPA6PZpsMzK0gKdQIXwrr1zf/4+J+IyjPvjKskr582bwjIZJNl7TZgG/kyFiHnskNlKuAPIurgJjQ4itaQ4N4dwX2dajT6zbV8MqMpTS6QcWVYgC4C86ef0bm4KJS+Exr3SQz2WdjMmy79CgS2dxWGd/UD+it2bQc4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(316002)(6486002)(41300700001)(31696002)(83380400001)(86362001)(44832011)(6512007)(186003)(26005)(53546011)(6506007)(2616005)(2906002)(4744005)(38100700002)(36756003)(5660300002)(8676002)(66946007)(66556008)(31686004)(478600001)(8936002)(66476007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpHdFZ1ZFhhcmphRmo2eWV0Q0RRNTF6dzFodzJqamhwa3NFTWpRemNNc1gz?=
 =?utf-8?B?Ri9adlBZTlUxeTFxdnNib2FYM2xYL1g5T1Z0SkhDWWNoZFYxSGVzNWFQUG1F?=
 =?utf-8?B?WE5USFRtYW45NUtyallPaitQbjcycm9lKzhmbXk4WVRxbjd3Y29RMmNYekEv?=
 =?utf-8?B?ZmMzWi93R0hENkIrNlpuTElsK05hVndzZkJqcmRaMGhPTHVQTjVvTHNmajVs?=
 =?utf-8?B?U09NMjJEcEx0MEhZc1BmUmdlbERmazlrTU1vOFJrejM0a3JrUUJ2d0xZMkF1?=
 =?utf-8?B?bnROazdHeW1VSW0zeUdJTVJmUk5jME1UZkxLTUVqNjZ0OXYvaUNuY0plMWpV?=
 =?utf-8?B?TXVSWE5NNnFEN3ZPVGt1RFNlSThtcFdKZTdVWmkyVmRSSCtJZHJYaG9VQld0?=
 =?utf-8?B?NmxJMDdYZnlCbzdtcnJYR2F6Y09VbmwrVkNoMEdQbmkrVHZUYno5d0RyMDkw?=
 =?utf-8?B?ZnlMVWNaWUVrSmtjaDNscEJhVmtxTldBcVpzUzcxSTlXcytwcldDUkdxRVNN?=
 =?utf-8?B?QllPc0ZYUDB2ZU01aW4zL3pBelZVamdNNkJzSHZnMjZqNkZtVG5qUWw0ZWNn?=
 =?utf-8?B?ZGFWY0FTdTBTN2FEUFc0NDA4TlNwUG1mMU9rZmM1U2NsVFE0S2s2Y2JTVjhI?=
 =?utf-8?B?c0E4YjR1UGprWkxBa0ZMN0I0Z1IvK0FkODRLK3JoN0dCcWRQRUMyK0p0Zm1p?=
 =?utf-8?B?MlRVaW12TFFCb3Zsc3NBOUkxd01QNG11OTZ5UnI5T1dxcmg5R0xWNStkSHR6?=
 =?utf-8?B?VnF3QVY3ZHB0djcram0rSmt4blErU0ZIT0VvUlZ4blllampMaGhRNnM2NW01?=
 =?utf-8?B?aWlsdE1UVlRuUHFNdGhDUFNmU3FlZEtLZzJKVm9FNzgrVW56TTE2TWpSeWRF?=
 =?utf-8?B?aXdOYWhuSnpYMzdaRWY0bTBlQldKcFlhT0pDYkR5dTFERVUyeEE2Ujc5Sjdv?=
 =?utf-8?B?VlBSU1VwZzgyWFRFQWl4WmtNcnJ0SGpER0cyclE3VVhyZEVYRm51emJtMlB6?=
 =?utf-8?B?MVJRR2VXL3JNdThnNCtEWWlEVktXV3E0cHBIZndxajJVZXhRejJ0S3FyU29j?=
 =?utf-8?B?MEJqVlg0ZUVvdkRQWnM5eW81S0FSOEl3azNRcmtYWTEvRmxMMXVyQXA4TnZ0?=
 =?utf-8?B?OXduNFhYQURDZ3VrR1lvaUdxRTEzbzFCQmg2RkZGVTJIRU5Gem5FSFF0NnFU?=
 =?utf-8?B?NjluWkYyb0x2RDJxWk1JY0J6bmNQN3V4Uk94WVVHYXRGTFV5T3RhU2twaUNx?=
 =?utf-8?B?MDhjejZreHIwaUoyeURPRHBva2lyeFZJaUw1TTlNSDBINUc4akFwTU4wREY4?=
 =?utf-8?B?V2lwSzF0S0xjcXVGTDlEK2l1bDlTbFkrTWhPSWVMZldyWGw1OXgwV3JPa2VG?=
 =?utf-8?B?bm9ZTUdMdGhrL3lIWDF0dnBmVzlISHBjNFVHQ1JmY2gvUVp3SW5iTWtoOTBD?=
 =?utf-8?B?RFFPc0luc1lzNHBUSmFKL2VsWXc4TDNtVFlMcm5JcnJXeEh1T3ZrNk8rRWd6?=
 =?utf-8?B?ek9XQnZHQlZDUWh2Mm9iSDJGN05aNXV1Wmg3ZU12U0xiS3ZJdVRjOUJ1d3VH?=
 =?utf-8?B?bTJ4T1ZzTU1IYzZFUXQzc1hvTmcyeHBKNjlXRmpDRlBjUTFNSWp6NlFKS3Rm?=
 =?utf-8?B?N1BiQy8yVGlTN04rbDhrbE5ka014V0RsellKcHEyS1d6NTJ6M05IRmJMY3Jq?=
 =?utf-8?B?dkUyTkozcW1OTXpnZUMzbHFrN2dRTFY0RVRRemNYaThUMTJmVDNRbGwzVDZ6?=
 =?utf-8?B?Tlh3b2ZjTlFmTlRFWXZyQ2d6K2dlU1N2RDhxbE8wd3JkMEZKOEhlQUhXaUNr?=
 =?utf-8?B?MS9DR0tXbWFpNCtaMWFGOXFrU0R1RTJ6UjZRREJOUWVxWG1mdGxNaXdEelZh?=
 =?utf-8?B?d3FKczJ1SE1pOXJXWmxPYWM1U3kxdVV2emNQRkF3NVlHQjd2akVHQXF0QmFu?=
 =?utf-8?B?Q1ZBYk14ZE5XQ3EreVFpR0tFRFlOSk12TTdLTlJ3Mlp6alZiRE9IeTRXSzg4?=
 =?utf-8?B?RUMxYWVzc1Bqb2R1UEhTblMva0tUemQ0eUMzYXRLSjJsM3ExSzJkSU9iOWVj?=
 =?utf-8?B?bzhsVzhFc3BvTmVuRXcrUVBnc3BNNjVueklSM28zRzZoOEJtb0Zkdi8vbDBn?=
 =?utf-8?B?bWJZUFU4RTdtUDI5Vk5OUnlRa2RSSzNjZW4xYUV6czg4YWh6Wk83R3VLVUxj?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JYCtIbEvoGffJzpDR7QX+Z31lzySCYnwBvuf6TKmE1L/NApMSOvzMlMUoOpkHh8eqlRAi5fc/rYfHcJt0kWDCfOAv1RYockj7K8eZa7uTUrNvHZNLO6+6QoDz1ibF3R1wocTh/HJz1M3nOm3pKEzVMBbOHrzwEq+SnAJGe3t1L2XK1cZ8MNiEIVhCJp4qpqK2tNo2lpxcJA/z15QzWPRD/UsMFjcoxDXXW2DgReXy5KgP/ARJ1GvB8WoBdBVp9yrOJOU2r48jGGWjdsHyADNUObehiwJ8lt2E95vF0YwSdUtM+up/JPjLIejFCIcFrAam/cIpWezHJXB7ap0rHeqx8aXts/CZXOfsByll1xDzESfAr5S41fkhfCeJa44KEmzUKWI3wTSWBW68MKqy0kW5TM0S5B1+jr0jUljhincq+Mu4N5qhgBb5Wb9fX86h0fO9dIvD39TNmxsXQh0L+sLDZr7kpK/yKJljdwgy3yufrQB1NS1Am4rjvTmxQyuFSGR7oqv8GUqh5ym9Q2BbbUTknHgagUD7FbEKPQ67dotb2QxfqK2AYnaN2jeqAtT08jtsRwEJ0wIjPOJjG2YYE20cCaSEXrV2NYqa1gjFzQWzE0J70Pw1Atj3UtYG9WdRZwQObM/0pe6z2qekoHzsHRb1x3nQWyOCMCY5rpI8iauqt6k78C24BeJtXDdhmdJlTzigK3TGU/Ni6DnBNRAkFRqRfFERo08E2KsDRdBqBX6UyPuFNxfB0zopDZCjbTX5WSAanT2OW92gZjS1ryVSQPlkHC2qFRQgQ38dd5jgcZb08M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35702c3-0b95-4e07-8391-08db6bff295d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:13:06.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/KGVPYDxJN1aFwedKnPF4CoIIqgwavsKr4K0H3quyoyP/nt4yiVQ/TIjYZAJch3rGH40oYr+z5cDsEh5cL0ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130100
X-Proofpoint-ORIG-GUID: SXFIZ1WRavLndZW-7E130FPc0FALG9Vu
X-Proofpoint-GUID: SXFIZ1WRavLndZW-7E130FPc0FALG9Vu
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13/06/2023 18:49, Qu Wenruo wrote:
> 
> 
> On 2023/6/13 18:26, Anand Jain wrote:
>> To prepare for handling command line given devices factor out
>> btrfs_scan_argv_devices().
> 
> Is there something wrong with the thread?
> 
> This patch is showing 5/7 but the next is only 6/6.

Sorry for the confusion. Please read the patch number as 5/6.

> 
> The same problem happens to your tune patchset too, which seems worse,
> as what I got is 1/5, 1/1, 3/5, 3/5 and 5/5.

I noticed it a little late, but 1/1 should be updated to 2/5.

Thanks, Anand
