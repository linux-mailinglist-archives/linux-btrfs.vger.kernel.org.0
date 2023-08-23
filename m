Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9572D785AFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbjHWOnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjHWOnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:43:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2B8E6A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:43:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDuRkE022604;
        Wed, 23 Aug 2023 14:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MZApyFfIpoWfj6sszuO7pou54gedMb3qRVi1QVs5DQM=;
 b=dz8Uptv5F7U4o9G2rur9p2X0DpI0Mfil4TctOmi6L4mwEJIgWa/WOOpMVSuT9Id7UZaV
 SQqPTY6cg9+EZVK+YlYrRJhKnm/2Qy2HnY4tahSwYfjqn5eRV6/gxyf0WWZOyMuksKHF
 KrFu4oUb5YzudVfQKIg8WZVP1N80lrp6dPiDTL37HTDY/s9pbgolpMTyeMJe0AxX7SXn
 oQomud4jxYjV2pb1VBJbB+QoP0AS2/SeN7P79Wy7Drcpbe0N/qQ9U7U6emR0UqeNsa/N
 tIa/6IlIjwnRnYkvkYpUr+P6GbJuytA4YBMJnssKKge9jNXsHExR+g3galxQ50V00/La tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1ytsynj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:43:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEKEGx035863;
        Wed, 23 Aug 2023 14:43:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yn5q99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM86nW5KVUYPWNz5kiLh+MGTkgiKMEWn/YDSDYOl9OQNe2U/C5H/01kXYI0xLmc5aAHj/1gftuYQ0jNIkdOq24bRSAktYJdyCvgaYW5xKIGwgdGMwARx+hPVeiPypFgzJrfVZRjrgw2kMFDFoEg+WcXXEDjlTUHn5vHuo5dvivxHow6PSE+5Ui/rG9UlkfLlGb4TjrO2P6QWEhtiLUXioBRH0TeRK4W6Lb1cl3RHjtFM8i/KOvqWgo+hniNB2jxccJQJZng1q/v3JK3ExoI8aQjNdR8+3WcXzD06+7LGQMzsv9iSmdCftUY5KpVn6lOs0zsnHYW5P425d92uMx4XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZApyFfIpoWfj6sszuO7pou54gedMb3qRVi1QVs5DQM=;
 b=lfzcg3pol80kbxT7vD9vSzUV1GCiYfl2vd0ya1ZHLYour1vBmH0O5pZ52wreJRjxMVHI+XSTtph7tQBvnhG8KJURgfr5tdIb1tKrGC93ya/8YVAVeyPkhthq5DDdTmjn6LIi0ji4Klifs6XOkUXuXmB8IMLlZ51Y7zcrXz5opQAxLzFZQnk23wku6w6b/gHIIHbRXB0MZUyYK2UGH32ApeD0sgSlO8/BVdpXtS38APJhlIxMhHWxAMRfcB77OtlsDbKiPS+ix3Z8rO379gzqlwtqTuzWfw/U2KJFqrySAR41mvTY3RIFFD6J/5xoJELRwl7YqoOXh9tMFwJCdeaFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZApyFfIpoWfj6sszuO7pou54gedMb3qRVi1QVs5DQM=;
 b=tfd7OXnm7EeYuRFJF2uaJZRQqw6igC1SbTwRZuvjqNs1Mybs4aK3sR1DijZbfcVyCRpFmRZ+F4xrFLvazQXuELLNDiGWIrpiHjF18WgVFFnm4gAYgIRYG0pb9Q7XMPI2zJNu740WGPmV5YgfSJRHCua8bQzqbLbYdShU/PBTcCA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:43:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:43:39 +0000
Message-ID: <aa3ca89a-9d02-8aea-daec-f5078a332789@oracle.com>
Date:   Wed, 23 Aug 2023 22:43:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 06/11] btrfs: include linux/crc32c in dir-item and
 inode-item
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692798556.git.josef@toxicpanda.com>
 <6dbf325458ee1c2fc45a66779fd5a277d4f39810.1692798556.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6dbf325458ee1c2fc45a66779fd5a277d4f39810.1692798556.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: c687a556-7b4d-4cf4-82ff-08dba3e756f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0lWf2UyCuq8Nf2gfsnjmTaVCobYHFMVDFAzpgSBMGMznTwpaWyrGMaMyJVT/2VWcgqNydumakuEpjuFJien8VpdORJk7C8o7T8z5+fxXFsBNGh//6aVyQv4KVVFBvnYH5yRAkpyk6dwwFdQRUDUJYEuyIPDs7s9env2JJO0Mql7k8cKWN1U2GH4Wu1BkVef4YouvS727AjvQQkeMUcAYF8Tsjg2TpdwvysniOCxQt5tWUM8X6pYSgYCaP9pGfGnbNLhZ7OLzRKZfcLMo24C5RaglNwnsBKgwiXj1d4EE1sUrFJ/+pV6DFLsRigplxBFvZyi/JHNaYJepskbyeoxNYAAgQvp7Aj2t90ssm3dEfnqh3EHwtJQWafuCDPXej1TRecIv2x3CyL5I3wVMrd6PhDd8GcqxjMbappY+SyspP1DoKixYH4aJIrlIX0BE6YDQFjNohQ0OS3lr4Xyo3I+h++RvjPOuyLWroxP7ZvC0+40qYqj/MKWIgNG3VinUTQAoZDDQFWR6uAKU9gg+Yk79pKpq1wglaILOmP8oQFvv79kVkm5zq/qMr1EHl3Tsc2ogsUHWHRvpZIl+lBIrorFRA/gPq9KKCL9MG9qGxPJW8kWP4wMGnZOXF7vc+8szCGUKNAa2tap4NRbqXizZ4Gx+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(186009)(451199024)(1800799009)(2906002)(38100700002)(86362001)(31696002)(36756003)(31686004)(8676002)(8936002)(53546011)(6486002)(6506007)(66476007)(66946007)(66556008)(6666004)(316002)(6512007)(5660300002)(44832011)(41300700001)(26005)(478600001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2FzQmJKRlkvbm5nZWF5YU1oZTlhK2paMHdMdzdpYXhaN09iRVhDSXhBSVda?=
 =?utf-8?B?WTdBYm1zTXZmOVErZWp5bWFaZnd4c2tJWEdjVVNOcENkd1pHZ01ZM2svMXBY?=
 =?utf-8?B?dWhOWUd3Z3BDb2xoTFF5K3BxU3RKNkxUWkpBRlMyT3VrdkZNWjltS25JdWdh?=
 =?utf-8?B?N2FHQWRtRTJTZDJTTE1jVllxcEJaZGxuNk00ZXZlanNneU1iQ2FNcEcwa28r?=
 =?utf-8?B?THQ4YWtzWE5UeDIya0hmOFRyN0ZwNU9WNFpNVmtjNlp4UnY4cGVQS1VHZFhC?=
 =?utf-8?B?Q216YUNVQjQ1WC9ZNkZ2cTFRaFZjeTRqUWMzZlVJaVRURlBuZ0ltYlR0Z3VU?=
 =?utf-8?B?V0djd0JPbzllRWlmL1l4c0thTzZ6ZWJRRjlUWjRib0tmUGFpQVFVNmFVelRC?=
 =?utf-8?B?N0JGY0k0SUxOR285N0ZwNjN4VU1YYVFkS3cxTHM1R1kwMk9UamM0WkMrWTRI?=
 =?utf-8?B?MXluVFBnM002Wnl5OWVVQnJhTEI1OGRxVGlkOExyM3FMTUJYaThCL1p3R2pU?=
 =?utf-8?B?Q1g2aWRnUEorVFNvRGF6b3lWMVFqaWduQzJmMHZycDBFTWxBUGZ1M2JZbjho?=
 =?utf-8?B?bGRNZ3ZiOEtCS0ZyZ00zNUhNejhEUG53VElXQU5XZmgzem0xMnR5L2NvU1R4?=
 =?utf-8?B?WW9kdkI2V3R3M3pQZEdqdUR6N2JvYmgwci8zcm80N0dpRGVyeE1qOHUxaVhW?=
 =?utf-8?B?L3dVU0U2RWRyQUtRYkZnYnBvWG1hdU44L1lEU0FIY3lqYU1MMzFpbnFzOHFt?=
 =?utf-8?B?cmpRWkVPcnVZZFRUa3ZMd2lKTS9uOS8yYTRySDVYbS9kbFNwWGVXOWhhL3R1?=
 =?utf-8?B?NWRpRms1bkdmZXJtdjVjMmc1YWhQRWcwbTNhbTRMMU1zZjhrYU9mdHdxa0tB?=
 =?utf-8?B?ZmV2TUxZYmRtbHc1VzVXSzJacFJYcWJ0M0RwMHVlMXROWVp6MXdKdmtvcjFE?=
 =?utf-8?B?UEVBWDErVG1VeStiRUhlVi9VL0tHSjdDQUkrQmlBZkJqYU41MGNBMmNJMURu?=
 =?utf-8?B?V01PWVhBUm1vVGExeXlEcmdDYWpSdUFtZUhjR042d2hmZU44Z2lLcitCS29m?=
 =?utf-8?B?a29iTW42bE9PS3BwYm9VcE1rY0M2RTBDSGh3MWJvdUVhQUdUZmRZQmVvRzl5?=
 =?utf-8?B?L1lxWW9vMzAvNzdKVW1rYTdVYVMzS3M5MG45Q1dZdXVBTTU2Q2RSOEVoZ2dF?=
 =?utf-8?B?V3AvbnhLa1JSUXI3dmRKekJzOTV3eVJ3Z3VsQTYvaCt0S0tVSXR1TGZ5cWVv?=
 =?utf-8?B?SmpvRlFJd1liQ3RYS1lTSFhtcTVMaGZ0TGFRZFVVbXljb1ZDRENDajF6OXZ3?=
 =?utf-8?B?T3pIZTE3UUMyc2RlaElVL1ZoaWUyNFB4Q21GbkFzcjZCUTZRa1lKZjBnaHJQ?=
 =?utf-8?B?VHBsSjdEeTZNUVFWSTRFd1hzOS9neFBCSExUNEVqVFBnWUJWbEhGdllCREtr?=
 =?utf-8?B?a3MyR3R6MGx6ckQxWXZSRlJaTEU5dURLZ2lJeVN2K1VrdEc1VTlwWFBIV3Mx?=
 =?utf-8?B?MFQ3OHNYcXFXeGM4VHRpQnRrdnduSnFQZlVNZUQ4M1hDZG9NTklHdmRnOWVG?=
 =?utf-8?B?dXM0OXN6VTBBZlY1TU9yTERiNkRMQ0pONU9LTUxiY1lxdFMwOG45ZDFqdmoy?=
 =?utf-8?B?bFpjMXZ0UTBLVDZOanBjK29xTkV6bHhGNVNRWWJMTVRxRllsazdWa2RUUHpz?=
 =?utf-8?B?YjBIYjJoSXpORFpKRVhCVDJDUHJFZVFtS3RIRytyRVdqN3FsWnVGcFMvRXRM?=
 =?utf-8?B?UG12MVp0YU02Nk9vM3pKcHpzRE10V2hlYUZuK0RJMjFGVnFOV1pDczZCQm9z?=
 =?utf-8?B?d29lZ3JqeFQzTi9ET2lEcDR6SHNtZlhFdnpkVTdQMzFwL1c1SEJlbHJYcUta?=
 =?utf-8?B?emxmRXdLckZ6U1NXQTZjbDhDSW81OC8xWXhpM1V4VlNyajdoRkdOdG1pbjRj?=
 =?utf-8?B?dkpLUUp5T2JWZVpqRzlQS1NUa1lleGZ6aUhKcTcraDBEak14SWRTODY3YnF4?=
 =?utf-8?B?djBncEJFOFh1RUJoeUxlTXFDTVdoMVZ5d0UxOW5veDcxOFU0YWl2NzA1SWhx?=
 =?utf-8?B?ZElra2tEbGliTUN2TjJhdDhKdEo3eVVaRUdKZ2Y3d3o2M3N1WjhKR3FzVEdB?=
 =?utf-8?B?ajBSVWd4QWtEUU9XTlRxMlVWNVFtcTZPZUlRRkh4dm1ub2dMT29hYkhOZlFj?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7ETE0DMkGAvuWlQisZ/ox3zmsN6h+Vq11ddUy1DixYgE7pKC2Ntu0UGKg8G1fCsHdbiuGsYuqZ39HQIHhsa20K0G0YpxIxrjHsbE9QpO92HQibZPrVxlNY2X3ocLwSioMNv4rr3MiKuLVFyW/0O1T0wODYMkV5ejCa1qMmfAbw8yYVdiDOgzV0iZsH5qsm9mSPCEo4U8utCGUqQK+YL5e0qAqHJkCh0oABmRKbJo2FJObv0apA9ABXzAwc+pJENs9QM4ErryolRX5/EFGwp1D6w0haqDR5ochuK5/Cw+MYx14eWvJ2KtsrLKcg7THSBqZrwoZDf6MrWHKvAhxs7yuwUSILUZxMKmYfjGTDnG0X4nAaDquefon0AYcUCCbfeUd60MUWySXjprdsJ7JNgYX0OkMIkGWdlRIS3DFCkKO5fcvns8+mZ3PVh7MVXoCtES9uEH7E8y2gjuU+PHji4/xHOjoSVY0oWXEM7tuq4HsZPJ4mGjo853rWwT+jHF5sL4cY/rPGQU0QS2SRxEF7V8MqU9AWKrC42LI43b2+dVDjjl4ywIZAITsacdSZcAgNb+SfG0By04io6sw8dPyLX/gdSkurifi8W6n3nE/MK1MQsP9Q+Gait5+afZ3t6+5+cpb14XBBArPuoyFlibAfexoq902Yrh0oY1pQKsX/YXabTBgHmocmENLxY/ZTq2s/9gWpnhg3rlTMcMT+PcbLqJaGdbcsOX1uB6xMJmbAzSPk5iY/3qyULi9WhYldLwkeUnUoTT0N27Gw2NhnOSSm0Dk6iUU5tkc6NrxWdlVCONkjDV/blvtd2zisu4tJCBsVpV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c687a556-7b4d-4cf4-82ff-08dba3e756f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:43:39.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqmEGO2SmGEBXKGbuBXbo30rKm4zepRX/hgkQ0l3/srv4nOKUoGyxky6Ei+9697182ed47UUhdi78mfCgtgxeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230134
X-Proofpoint-ORIG-GUID: e4wgLhK2UM9Q0QZ4ZMgIlatlR135X6zB
X-Proofpoint-GUID: e4wgLhK2UM9Q0QZ4ZMgIlatlR135X6zB
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/23/23 21:51, Josef Bacik wrote:
> Now these are holding the crc32c wrappers, add the required include so
> that we have our necessary dependencies.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/dir-item.h   | 2 ++
>   fs/btrfs/inode-item.h | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
> index 951b4dda46fe..5db2ea0dfd76 100644
> --- a/fs/btrfs/dir-item.h
> +++ b/fs/btrfs/dir-item.h
> @@ -3,6 +3,8 @@
>   #ifndef BTRFS_DIR_ITEM_H
>   #define BTRFS_DIR_ITEM_H
>   
> +#include <linux/crc32c.h>
> +
>   int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
>   			  const struct fscrypt_str *name);
>   int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,


This could be merged into Patch 4/11.

> diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
> index 2ee425a08e63..63dfd227e7ce 100644
> --- a/fs/btrfs/inode-item.h
> +++ b/fs/btrfs/inode-item.h
> @@ -4,6 +4,7 @@
>   #define BTRFS_INODE_ITEM_H
>   
>   #include <linux/types.h>
> +#include <linux/crc32c.h>
>   
>   struct btrfs_trans_handle;
>   struct btrfs_root;


And, this can be merged into Patch 3/11.

Otherwise, changes looks fine.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



