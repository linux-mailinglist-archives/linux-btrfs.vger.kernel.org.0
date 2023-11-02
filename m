Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C907DF140
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjKBLiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKBLiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:38:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28312D;
        Thu,  2 Nov 2023 04:38:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A283NgM024470;
        Thu, 2 Nov 2023 11:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aSf6b9Rqfg61IB9NXV9T6sn/Jt9JsIcEwCn34jLh9Ps=;
 b=VkxS4SZcZQ+5YRhydkwMjJpahTOB7uBwOotXlS9vjTtI6j4WBPa8/dMTlsuU3nMObTqc
 +7CgpN2jxDR67yHgQM1bgzsoMtLhJxdUnTwbf0GqnxYlPyGaETTjg3O3hqS7HFN6fc6l
 +DV38HxBpZfaLKt4tzaxThk0MJ33J5CK90sTWEe8yLEuFly2BYX0fcDbZxYP1f1iQhlq
 TkiTPuPwKMiLN1DeRax8pNbCkiO86vTy3StPFolTwlWqF0PCfJfhNh/8n/CgJFQ/VigY
 zsaSuo5I7RzQ3tUCDnUEvJO4cXrtnzFdKSNbDWiWh8N5cO+KdU4TgY35wy1TG39JAw5F nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw29f65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:38:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2BTVYF009077;
        Thu, 2 Nov 2023 11:38:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x89ppk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:38:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke7M2n16SikZkLecChUkFaG2AIHyUN2zBTFfGjnHbaVcjJwfy1rrrYxh3MbuhZsl5BnfK48wihyPCajX9McSuiE1BwMLkLxFqfM+KE0tDNYFYMaP6B9ElwCkDy2rhxDthZ6pmDMqFt7/1iAnqnlRH4LOlXSUNTKOD6t846uaiwK5C/PMEmBJOnEYiUwhghbLZXBxHy2zm84H5PNfwl//QreNHUqkI/4WIVsTZk9Vxa/r7OOqS7c/UCXTwnteXhjc/0ATl/5sFnjFb2/UKOJLIKlI6oHvLv2fO9cuahQYdzfg4sbTHaKszN/xZDdrm7oMUKw0Pj+vhfwxT82PzQw/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSf6b9Rqfg61IB9NXV9T6sn/Jt9JsIcEwCn34jLh9Ps=;
 b=VeIQHAl/yxJINWj5N7zf5JbOKqi4N2/s0iY5COuZ+gwonML6DNNRe6Zkp4jWnH0LeLAnaLiBZiYszvlBV1qVrsvK4MITz98mEPxcHi5Sfdm09MdkPvgon4LSomSH/eSWh1th3/pgllkWm7eC2mFWbLMVmDtald7o13gz18SOtqazDQbSQ0EOauoi5ZaijqmrrcpbNZvZNQ48znT+b+VNYSXDa8QejpsPHW6xmvJSBH6CoAuLyAu3MCUeQPvZwgcg3cTNYou/Jab58/XM/yUTT/Ubvn1s52ToIm0gM2SvWO3rBPzYWq+bCUH+0L0us0k+IY1loyFvXVnKIq0bziA5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSf6b9Rqfg61IB9NXV9T6sn/Jt9JsIcEwCn34jLh9Ps=;
 b=UK0FLwVvjhMsR/x0NT96iVLpozQu8MSYiDVkLtzwxTBWb6ueiWo8EtaA15PXMdr9sf/ypLqWz+t1zZU49fYe9XjJs/ey7v34o3Ba2reetJaoAFAIjUO/CBFvOvp3j3/OmdLgavV9GRdAlVJyYDt3iVOWd4hdzONs53moQHwB5iI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6631.namprd10.prod.outlook.com (2603:10b6:303:22c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 11:38:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:38:02 +0000
Message-ID: <6d2e85eb-8bac-48cf-9aab-9d71bd287d9b@oracle.com>
Date:   Thu, 2 Nov 2023 19:37:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] btrfs/219: fix _cleanup() to successful release
 the loop-device
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698712764.git.anand.jain@oracle.com>
 <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
 <20231101112019.j3iojkkcwjz6bzrb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231101112019.j3iojkkcwjz6bzrb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: a96a8fbd-4610-410d-98eb-08dbdb982c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHeUxpJpjueb55iikyBCg/FmhyfsUrnEIQnHaZ6Adh7cQ/bG8q5EvxtDTjNGiUayS9MQCRlzVPdTTa2EXWPMeVjbGDs4K4GDhIKgp9uQW0Uh4+gZX6MFwRfmn9cay7X/bYtc4W8CS3ZxzqYNA+UEi3Q2RrER7rvrA4jca8kAIIMRUj6zB9jWAUP/78qW86BbpDKUlJj//aX207YiJzEQTWeqQixlmIBSgbl6w3AOKXqqrl+/JNN3FrOLS00l9feC44FCFmcN5saMnH0WrmV/tuC1APsc6R33CGFMxKAxZp9m4Z78F4+EywRmkPyEtEJ5HB/kNRSa5h/q4ezW5j6LCMvt5JgxrmInNqMkYRLvKA1Hxbpu4KtURH+uXwK0qGFO/6XlEKJJ8N1tZ1oX8G+wQnaKvFwJlb3rN545si16NwJViWdEBxC7zsdR+HVkekQzoSEL33xQ46tIiks54jT15f6kwAQD74b2mjPjYbLI9+efA1wBLo4yAhmY/yMbny1KpTV27cIB1JkmG0yNZqsXHciUVBHbe0Pt163AUkr8FOTbwx2+uMm9ZcEoSbSDRdHoB6MVrpQW3fVIYg6+eDOdP95sLtA5z+5HFVcevs92ERADkVf88yp5uadLpJTUQ2Qxe1kx3TfcbMNBCCdlpGI7Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31696002)(66946007)(6512007)(478600001)(31686004)(26005)(66556008)(6666004)(66476007)(6916009)(316002)(2616005)(53546011)(83380400001)(8936002)(4326008)(8676002)(6486002)(6506007)(44832011)(5660300002)(2906002)(38100700002)(41300700001)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRVUHM1aGZxUzNtYXNCZDFUNlFqTFhwcjJVbDRxWExLclR3VWN6enQ3UEpL?=
 =?utf-8?B?NnBNVTJQRlJxRklEUTVIc0E2QzZVamxoVmxyMGV2azF2U0hobThuN3ZaNW9k?=
 =?utf-8?B?aUZBeGx4blNXZ0pPZEgvOHM5UlVBcmtabmJiTTlPa2VzejVVblArZHZ5Q2ZW?=
 =?utf-8?B?QU5kS1FxN3lLNTNFVmNUZ1BzRkRZVVBXaFB3QTBBYm9YMDhCVDBNTUpIS3N5?=
 =?utf-8?B?QTFpWVYxQlBMRVlEVUcxcEczYkl6RzBPTk9COFFNZ3F1dFkzQnlVK2o0V2g1?=
 =?utf-8?B?NzVzNURyV1lJb3ZVaTdqWWlUQW5veFdrNkdmdkczZkRHK25wVnNnSy9OT3BU?=
 =?utf-8?B?S25FTHVZdmtrWXFIVGFPZlRrQy9jbW5mclZSLzdlYXV4ZlJaZkR6MGRqZnMy?=
 =?utf-8?B?NE1YZEVuZkpQYkxINnY5NnFWUWs3RHFoUGxLaXpPdk9JSGt5bWJjWHZHc3pY?=
 =?utf-8?B?bHpRYjhEMDFXdWtXb3lQVzdEcDFmZlNLOFdEWitWUVJQemhrNVIxaXRxZW1O?=
 =?utf-8?B?VnN3RU5RcUlYNWpUY0RRWGhyM2JHVHNzbU9hVlVkWGRzZE1zejJjTWVyZmRJ?=
 =?utf-8?B?UHVheC9uMXhiOU5kS1B3UnBCeWNOK2RtOU5ncnJjdTZjeVpoYlM2WnZFV1gv?=
 =?utf-8?B?Y0huNXB0Sk14TjcrZFBvZzJrcUt5blROSW5NUWZhWi9pbExZUkR1Lzc4dG5m?=
 =?utf-8?B?aEp5WWhHQ1htSzN3OVJHWlhuMU5OT3JveVJERkJ4bld0c1RFNnZ6QnNxNmU2?=
 =?utf-8?B?M1NKV3BhZEEweHlNclJ5bXFzZDVtOEREd1l5ZzhBa3FPTTFPTStEbERPbmFJ?=
 =?utf-8?B?cHFLcWthL0djSTlEZDEyMVF3a2hlWC84M3RaT3M3VENsOUVaYmhobTRDQ3FJ?=
 =?utf-8?B?WCtYZlk5dXN2cVRvKzgxZ0NnV0hKbTZWTGFuY0FMMjhTRjViNFN6cWh0bUlv?=
 =?utf-8?B?VVpkMnJJTUFhdUF1S0xFay93YjBaK2djN3pFaXRjR1ovalBlUms0a2puWnVh?=
 =?utf-8?B?R2V5S0lsMGZXN0o4SjJQZ0N0a3RIdy9tQnlkQ3FOZkdzem9WdFdua0phTy9a?=
 =?utf-8?B?RVJwdm1jQUF0T3N2L0UzdUlkV3JBWEcxWmR1K1BDaCtzUHFFUWdxZzlsZGYr?=
 =?utf-8?B?WG9Yb1lLR3plVm5BNldISmJodjJURUptbnVvdTU3ZkQ1N0tCYTZGRk5KNGRX?=
 =?utf-8?B?Q1VpWDdSVVZWRndrR05EWEg2TmxTM2tLVTFHTzlHSmxYWVF2RUNablk2QkZB?=
 =?utf-8?B?Z3QrY1JYemRYSlJ2ZDc1WEkwSmFNbks2NGZWMHlIdGJ4R3N5b2t6alU0d1A5?=
 =?utf-8?B?V3g2UURVSWZOc28xeEliQUV2MHdhODJCQnFzOFdqNjlsZldVOFpPQ2lKdlhp?=
 =?utf-8?B?NmEzWTF1T3BRY2tDa3ltYzZGcVNhZkQraStLTUpzTzM4WHIrTzBrSkcxN3hJ?=
 =?utf-8?B?SkYzMVFXWURUY3NMRFhxUjNSTzRocFhMQ3V2dlFLblhKTmk5ODlnMCtyb2tQ?=
 =?utf-8?B?bnRkYms0TTZrNDhRQUxwbUNpUnFBUGNHVFJzdzV2QUZLeUlsRzFMUndwNlNm?=
 =?utf-8?B?ejZEMjZpY2VLU2dDUjlJdWI2UjVoNzg2QzUrU1hVNFQvTzduRjNyRXltaHJE?=
 =?utf-8?B?cXUweXhqQkR0RkwrSS9jUnJiNzRMWGtzcXYyZ1IyRWV4U0N2eVkwUGJORzZv?=
 =?utf-8?B?QUw2RjJBYXRSVGpCMWVPRHlrWDBzYTFQUmM0M2x4T25wTWRvVWduemVEci9y?=
 =?utf-8?B?SjFiOUNkM1FUMzVTY3Z3OUZaeklic0FDMDFnSG1JVUViWk0wNHRBakhLcWs5?=
 =?utf-8?B?dW81NUZHZVFPK1E2R28zdUlGblA1R25hWmROV2FiSjYvOHliTnpjVXcvSkx0?=
 =?utf-8?B?NGNxZGhvSDlLdFByUTZTQ3pCYmg4M1E2aUM4YzFaS1JSN1dKcnBseExna1F2?=
 =?utf-8?B?YUxzdElONXpWSkUvU1hyS3RoS3BBOEQwNUxQeWM0WGhlVUtEZk9OWVdFUk5i?=
 =?utf-8?B?OStPTmhRYmJ2ZGJwK0M4UndCZkt5Wmk5Y2xFSTFKdXFnZnhIdzlwbUJ3Mmth?=
 =?utf-8?B?MFIwUzJESmdYWndNU0l3ZlRBNy8vQytYUk82K0k3NHhqajlpYlhHcTI0YzF6?=
 =?utf-8?Q?MkKyCzTNsS3rbDMFlsg48Km1C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mz0n0m8v4+r8Y4G7MnwHq9BuRJasWh2+sGbDreaq89TqLox6CLUfyLfa1es37fv9B9ExvQFe83wRl7Wx8Tjg5AeQYBzQhww3hzrrtnyPJW/MxLcGg3xTriSKV9wxFZ3G4Dm/kzSvihyWRm4sTe7ACGldAxgsQFBKZGycD62mHop7D1DjAIAmrYFXycigyVu7jK2V/c24wQ6EEoKFGea1GFO0aNA1g5FglcyVCPpPPn33JAOjDvVDmrIkKquHh2yIVjl3284Qq8nxVkQ+MXJifNy2tIE+0NJONPnE+Xitxzl+hV/I6auOZhOYPHVs2YXpCzQcqqTxLQ/Hgc2ApFhAElCAe8aYVve+EFtIkGUnxE5x0cTFEQejT0fhW8dSlLWGO9t4es6JwJZKAoBwvlyBHKTkZC8vfCm2XMq+HbXEs6y6sje5kf2g3U6eC+TScbBzfi7WlqVnHoUSosIwI9sHoFC0X9xSe4s5znHi5jJji1n2++xm6wMSM19CaOZlgNEaDbY4312R5wAAnUuvon+R0HBVS2C6XZ/GuT6KVkxrz2v44eWEpJROght2fn1U/F56WLB6NTyrSpHVv4uP/PObzv6I7Hd8PG1j/hamr6lYiLgsFlLIdzP64xw3R2+t1gSZyL4pAJwrcfxk0yq6QIt7PZMcMC9YdNkr9fqqevPs5QfbC0cOPCVesyCHyGPJx49khA/BlYPSR+K2Izc75A5ddglii0OyCv5tGUvTjFFRILvamYkkLfj0tLHTSfA3JKuY+d1/UhJubSqU82IWxMdXgUkhWZF0Vd/1MRwghnbrRZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96a8fbd-4610-410d-98eb-08dbdb982c30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:38:02.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XOv5CCwsvwa3P5dKheyEbI6ZvNdC0vDxoDgeBO+x9KGDgj3Tt7Ix/eIHzKBeWz/gdTj0SYe80TEE9N16TiYCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020093
X-Proofpoint-GUID: O7k3VkjW1aQahA6lq2Gn6xqIuIIOzwW3
X-Proofpoint-ORIG-GUID: O7k3VkjW1aQahA6lq2Gn6xqIuIIOzwW3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/1/23 19:20, Zorro Lang wrote:
> On Tue, Oct 31, 2023 at 08:53:41AM +0800, Anand Jain wrote:
>> When we fail with the message 'We were allowed to mount when we should
>> have failed,' it will fail to clean up the loop devices, making it
>> difficult to run further test cases or the same test case again.
>>
>> So we need a 2nd loop device local variable to release it. Let's
>> reorganize the local variables to clean them up in the _cleanup() function.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> v4: rm -f, removed error/output redirection
>>      rm, -r removed for file image
>>      Check for the initialization of the local variable loop_dev[1-2]
>>       before calling  _destroy_loop_device().
> 
> This looks like a single change of the whole patchset below:
>    [PATCH 0/6 v3] btrfs/219 cloned-device mount capability update
> 
> The v3 patchset has some review points, better to be changed too.
> And the V3 has 6 patches in the patchset, now this patch names 3/5.
> I'm a little confused. Could you send the whole v4 patchset? Of
> course you can send them with the RVBs you've gotten.

One patch, 2/6 of v3, was dropped, and one patch, 4/6 of v3, was
changed; it was sent as a reply to that patch. Somehow, it didn't
work. Now, I have sent all the patches as a bundle in v4. HTH.


Thanks, Anand
