Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B6621576
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiKHOMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 09:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiKHOMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 09:12:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A8862C4
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 06:11:46 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8E5Mh0000857;
        Tue, 8 Nov 2022 14:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VQlzZIoez96+r8lHTWlWjCuL6gBGxkkihX4PAjslYxE=;
 b=I8M4MJNQPdTsLWP03liObRcntB9g+D7pIJWsGgkusf0rQi0o4/sjMKembLkL9K9uh4Jr
 ywvpF0+3mbe0/UGdhtzzED3wk+Pjck+8sEbgAYBFBQRPnFihVEDgSL3e8U+QHl/uAYrZ
 I41wFavHZW/EW1a2ZGLwjyA04TSAcYKWtwAv2+hw/mKA97YFFKpSJU9YTsAPnQQj2Vor
 KFJD7v9oUOzMwBIiGGJgVbzV7iYpGHTlkfrgHI8YsNL/W7OoZhcins2QIqTBE94zCFNk
 S9DbaAjqjo0bVpXMT8hFdE3Aqrp086Zy2BbcAlgBozjoZ1OIkVdqCUz6dTXooeWwZzOW yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kqrjb80j7-34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 14:11:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8CCiSX010706;
        Tue, 8 Nov 2022 14:02:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyns2eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 14:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXcpt5W3JVkrbwVVbHH/aFhP4aJwJEi6MdFzOMY6b6NounhmF7ABFN3h3zDGxDcJhXUrN/NOiaSamDWN4OxBT9/z6vegts5gFqB+807XTbzFPGGbWOYUkzX0o0CZT5fZ/GEamtzAksnDX4L2FDGU5UVu6j9GpFLulRWQdLfPcE841x+BufCW2c0hy+n0gX5kMa/voWEenVqrtvwVcKBE5PffXSymI45oPXoeualECrcTjd9a8etZ9RPmo3t3tOWFi2aTncUaHFzWyLbWvURZ9Oi/wXHBPjYbta8ayhEzZ/7KmvubuhnYRnUYggOUq3T6QG6d+jonrbtd50PAL0Sy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQlzZIoez96+r8lHTWlWjCuL6gBGxkkihX4PAjslYxE=;
 b=QnsvwIFlEon+RQgvA4QDZQ2hO6661b0oBUWd21RAZlEAgtQHECPv2ZVWGmJh759OPahLnvGDPVaPoZVBaieMcb/pv9osFLWqKm2uKObc32eeKd/JsHZoubh5AwsBl+rkgk1iGdi4i9dr++XWFyAAdQRHT1BZeB6oDCzK6waufulKKE+W+heMDBxAuyxcXDNCkT220cWhPicSKugA9/2m5KLISPN2ei3bUaGlVvCJ3MqN/kZw6xb/0iqPU0FkPrxZtgf9z3g4rWLPE2kcgA+M6Y6AUMmhDr68X78QX1N5nrx9LE/XoR3+FgcxTufc/znEz7nLHKQuHoLQGc4CHkWXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQlzZIoez96+r8lHTWlWjCuL6gBGxkkihX4PAjslYxE=;
 b=TVw5geBViWSema9KWDmGP3WY3Efp9581hO5sR3yZJumKdjivfyHNiPcRHd1X6l1LDPk/NkKI6sXQAS7Jd0DS5cnSfgjPu2dUbteiT6umz8ZHVCGmd880TqBdZVW21oSQYSqYarLBdOEvcTLaIgr+DXYC1+2sewXIZsQs7q0AjV8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 14:02:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Tue, 8 Nov 2022
 14:02:53 +0000
Message-ID: <f6bfc232-8219-9593-6814-c0020d9df787@oracle.com>
Date:   Tue, 8 Nov 2022 22:02:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: constify input buffer parameter in compression
 code
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20221107163021.7361-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221107163021.7361-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dfc19a-e678-416f-4ad6-08dac191eda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3xQq9Dmt+ZJC3zt5mrviQ1kdGKhMR4XOtxg1hLAxAYG3bQBGMpX86R2BH2ptrGL5di5y3SG2Ckial9hwNLQB7VQ2BZiI/zD81pnY0Mu60T2wSKPdnqPVK3cM1veJ31v4/cRRHYtHAGC/wZz8veWfJSSEJHGuE/lMET4xkG+5tibtGO2prfhbEaBScwxGfRHNyserD9j0drbFXDOhVcVDi8pSmttaEFsLgLTq03dajKFGsysHEpZjIVmSTb5CFJqHcBHH7JFkFkRavd7Z6ZuKXJfIkYz1a2jdtk8CHsvesLtg6/7nvvIdbF3F/oUyUQfhKRaFW3OsZUfDyiFYO1A53461hgKlChpmeUUuAXLpEyaeu5FjZAHGOBje5IsvK4HtPEErvtdKe4iGeFBulISJ2Jv7pgMWS0AfN9CpqNzewbdKyw18Lqar5APMZJlDjNDi9gyRIy10AGH44TuJInr5ZKfVCF2eyFrX5oL/Nlnk5jUINnR+uD6V7eU2OdE1VK3qLe1QxkbGXORwjE10eyOhkrWAIZn4+qwGgwp0xQRpc94ocd3votD6YVYvfcz/eLH3tUwtn3zhipGaNWZdDaFWwcHFyAbZu+tOou0Ai2sGHxhMKQ5r9pMmIjRl0cfPCIlOAJaK3X6wh7wU+TVopqyleRGPZwkjRQR4qMSoJi/WDAuCPLMq9/kSdBA1O9sZ/1VjcI9drl6W26wN6vtEfDlSHsVl5FDpIBtvvUF6f8seK2dho/IE9M4X7eS/oq7QqGxXjehOzV94C5L6bLvk/tHifhtiPqlBTJUh9xcbyx+Bbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199015)(186003)(44832011)(6512007)(36756003)(26005)(316002)(53546011)(8676002)(6506007)(66946007)(66556008)(2616005)(66476007)(5660300002)(41300700001)(8936002)(38100700002)(2906002)(558084003)(86362001)(31696002)(31686004)(6486002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXVJaThGNlc0cUJ6RmhDdW1uZ01iTFBwc2J1ZkR4Q1NSaHlweXhXLzNKazdG?=
 =?utf-8?B?c09ZaU5uWmxDTTNPcGxkUDRJM0U1T0h3NFhueDFFQ2t2bXVSYVZjSEhzNmts?=
 =?utf-8?B?QWxyc2wrSi9qWU4yaGw5SW41RjFkQWpJcDRZeUZRTDgwUCtaMWtWQXFnbzl5?=
 =?utf-8?B?UllzaStLcURsZmY1eXZiMFRrS1lWY2o1NWg1TFM4bmlRM2xneDZhY0Jwc21I?=
 =?utf-8?B?ZGFUejZhelRoWnVOOUhnR3cramp3a1lFQ2h5Uks1VGoyMkx1REhCaHpjblpq?=
 =?utf-8?B?b3RmczN1UUhzam16eW9IaVE3RUc3ZDdVb2xUbUVyY0Y5OTN3em1zODJvbjlX?=
 =?utf-8?B?ZFlyWTRxS2NZQitnczVTWWFlRTJhN2NBOHY1Kzk4d25CMHRoLzF6QjIxRjlC?=
 =?utf-8?B?NFhVTHNvTVJlQUJOM0tHc1ZOSEhJTkUyMDJkdzNBSkFPV3pCc2ZmbVAvS2Q1?=
 =?utf-8?B?VXAzeU1NTktWZzU3aGpPNDdsWTFJZUk5c3dWVzJRdEpFRXRpbElBWFZLVFVM?=
 =?utf-8?B?Q0kyQUNWVnVHZ1djU1p3SngyOGZld0h2cDFTUE5QS094dVJhblNEQ3JFcllj?=
 =?utf-8?B?V3VaTzc2T2ljV09TYldyYXZTNlJtMWFIOGJrWEQ4RENubjBJQlNTdFJwZTlX?=
 =?utf-8?B?b05xTXoxeTdzWk9NanFRK01MQ2VkQ1J5MUxERjJXSDBaZEJKSHpQeTc0Tm14?=
 =?utf-8?B?bldKaklpTkFOODlXam8yRk91UkZlZzZtRnNKOUZCcU5YV2FYdDMvblVTdVV0?=
 =?utf-8?B?bXlyQ3pKR0tXb1FtSkF4a2orQUlUWldRc2oycm1qWXlMdXpMRUo3Y0QvWmRF?=
 =?utf-8?B?MnlldW5namRvZGlSenpoQkNOSjZBRjhxcDRoVVJUQnRUUG5uUkNONHV2Vkwy?=
 =?utf-8?B?WkZNNkp2SFJUZ0phMlVQL2EzTUlVbEFZMjZmK0orMGxKZ1FOajJ0UnJDem1F?=
 =?utf-8?B?M2paQUE0aHZEVHhwUnczQnM1U1d1ejZzTXA3c0ZWbHRhOTJQM01wMlZkWklE?=
 =?utf-8?B?TjhhL0hhTzBSZGxkTmdBcW9QRllkTGtFRzB6TUhKSmhJRkpZWkFJKzgrMEs4?=
 =?utf-8?B?SndzZVY1M0FMV1YrT0I0ZUtCZnp6NmlCcDBlOG5BQlJIWGh0Skt6bWVHOXdO?=
 =?utf-8?B?QVhUZGJSeHNlNjBLaUdGOEc0K0pORXJsVkgxSTlqVThleFRwWFVBclVkNW9n?=
 =?utf-8?B?RmowRDFTVjFPV01yRzRzclk2VWY0TUhpTHFDZCtaZ25uTXVsTXhqY1lGZGRB?=
 =?utf-8?B?YUdoaXZCTUxNbnlhMENMN3A1MUVtTllqaW5udWkvYmNLTm14T01SY3l5QnUy?=
 =?utf-8?B?TXg4VG1PenBRYm5LaDVCQTF6OU95Y2JIb1dEMTUweDExcXN3a3c2Y3NwNzRn?=
 =?utf-8?B?cnJnMEtQUzVoWmxQRVNFenI3aitkTWlKQlI2am1mZWlmK2Q1bnNuSmlMVnFO?=
 =?utf-8?B?WWZ2NzZKNmtTOHExRFZtRk1vNldWMm1ERlpYLzY4bU1rUlc1Y0pBbi8xaEZw?=
 =?utf-8?B?OXhaejNhV3ZpV00zY1FqM2kycnVCNXl1dDg5bXNRY2U1RFRrbFo1YUhCSFhq?=
 =?utf-8?B?eVRORVNMVWxKZ0FzaUdFTFJGVjc4cWliSkN5NHc1Rko0RjdqcWRlSFd4T2Fh?=
 =?utf-8?B?S2RqUGgybHBxRVJYdmdHRHFWVzlnRW9TeHRaQVJPemFtRUl5SlJHejJ3bXYw?=
 =?utf-8?B?VC9GRSttTi9KN1VhbndxcmZLaWtJeVlJcXVXM2ZaN3pTUUVMQkVRNVBaOGk1?=
 =?utf-8?B?bmFBUFM2dDREUHdGbUwxdFo2dGxtOU1nWnl6Y1FWMHNld1Jvc3BYRHVlQXhj?=
 =?utf-8?B?TFgwaFBkZFJvRmFndHVLTXI3RlQ0ZjRYRFFSUDZJSEEzbjBaUC91aTJENml5?=
 =?utf-8?B?Nkt0RlJPS3FhbUQwOXlwQ0g3RVdmSHp2cDhBbDNRTnZUZWRleTdTM2MxNFI3?=
 =?utf-8?B?SGVPR0xWWUk5Y3FPSEJHOC94UjdzTm9CYTVCUFVHOTVFSWNaQ1ovN05tVnpN?=
 =?utf-8?B?WU1NNmlmMlVLWUhhVWY3bXJLMTBFSGhNdTVaT3Z3L0xaRXJtS3ZFQnpnTHFh?=
 =?utf-8?B?MkVIU3Y3UXF0Y05TQXIwMHVvY3ZOYjFmOVJRQ2FZTGU1Uzd6WVpuZExzQ1do?=
 =?utf-8?Q?AXlH/+utk9sL4PP5hvno9QvpP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dfc19a-e678-416f-4ad6-08dac191eda0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:02:53.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCwzNz6PP/7ujIVY0+aV/E0Na123p3uUSNR69aJ7EMUiUxzd7iqsxdpQaHol4I0cXx34Rz5QLQVu8Nn3NTQGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080084
X-Proofpoint-ORIG-GUID: LSIdZTZd99pC8wjXGHCjGUfissYnCmxS
X-Proofpoint-GUID: LSIdZTZd99pC8wjXGHCjGUfissYnCmxS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/8/22 00:30, David Sterba wrote:
> The input buffers passed down to compression must never be changed,
> switch type to u8 as it's a raw byte buffer and use const.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


