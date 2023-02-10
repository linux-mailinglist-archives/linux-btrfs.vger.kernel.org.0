Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD06922F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 17:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjBJQIe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 11:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBJQId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 11:08:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C674302
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 08:08:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMejb011918;
        Fri, 10 Feb 2023 16:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HVG1dVPlCbQvNAoEdpINQcjIkx5CtjmFgyifs+sGkX4=;
 b=ZcPfU8rOS5Sl4N1ibBT12mx5T4CfeZVUnLSFFL3WvN59s7XgsrtAGsz4ObPwhfvghnnY
 tBY9dudFoITAz7lKcEWMwpZczs1UrOg2NFvNbYEVEW0aNhDwC23+yqPc8mc4cPRj8B0c
 bt1+JZMkt8OCpdTUUE1sHTB/gFSWcGBZ1Z9PBzJnnNbBXBFvRBOjMYUrZt+H8iYITFf1
 M1cS60Jef7B2SIVN2tqnO2fJ2xnzqDkaJcdz0DWx7XG1pN1h29Dq2IQQPoQrUWPb6hi3
 STdiz3qovDe/zzUuVn5uJvta8HxP0zJ9jLnwLsJKQahiRdBHRLdx2ox/xz9G3qL/ih0D Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8adm1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:08:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AFTns9013624;
        Fri, 10 Feb 2023 16:08:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtae8w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyKtqyO1Y47UplEt2slzMwJp9off9CpzRY+sdemfGcwlCQOVQ1HqN2SB+XUUqFN195ASyb9SiQodiIDj1tZ5GhO1vHmQM7m74GFdTZ9du0l0RLOyL0kT9UU4LNGZyZdEUnzgbwmZ6KfXtScJuoKvBVXrWZWshmaJsguEJtUuFTgl7EMO00GoAGratSekjtE/dSBpY/zbRgtzSByTClQM5F1ThGErZKR+nVM4lIVk3eCjtGVVyxNZ2z4d6ULzKqu20IQrQxiAyh8SMrgu+xzg3l7c/apfEBnvtHhi2GgrL9OJX4Jhf5C3tX1gZXnumcISw7Gah7br0gRr/H8OkQH0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVG1dVPlCbQvNAoEdpINQcjIkx5CtjmFgyifs+sGkX4=;
 b=a7MpjD4EQbjHWxE3sGhdQEWDVGlIeGej/gRQA5eiFzm5sh1BB+VWuPRuVde6o0NqX3oWoJTLZlabZAVit3lMHYcfArPi1ftTd2ZvVvPpJljH2KfaatjDXjQZI5yufezweAbCPFHiwKdSwy+eCSim143fP6GLl7aE5ECiCfMyTHo+Wt+U/6pqf6U/YI4M50abzjbi8+RZtPw47tbBDxkqImJV//kivBurZcwTkNJydGwglSAhYahXYUn2kQa6ljg5M1USL3O42aV94pElJXnDspCJ8X+4uWz8qdkgQrm5DotTj4nDihrNbMT9tV4J0LiuqP/Lc5EsdLnezKENnojeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVG1dVPlCbQvNAoEdpINQcjIkx5CtjmFgyifs+sGkX4=;
 b=iVyGW+kI32zKnFNTxyzp+4X2O8zD5Z1ZEVh6kgpRk5GcXI59U4elvr6MQ70VWA85FTJv0jod8+Pej+qHEvoJc87addR/MJ0EPQvENKnyweVL2dFa7dS9iA2KXXtHUVEVDoYb5hCF5+kkePUAfTnQdcAq2163gaSIEGFRd5emohA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 16:08:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 16:08:23 +0000
Message-ID: <9cb47d00-b17f-bd3b-be60-29f3f95b3065@oracle.com>
Date:   Sat, 11 Feb 2023 00:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] btrfs-progs: filesystem-usage: handle missing seed device
 properly
From:   Anand Jain <anand.jain@oracle.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <29a0e54c8461e3c25e63d5b7b3e48fa6f4254d3f.1676007519.git.wqu@suse.com>
 <770d3b15-d521-794e-b78d-ba8ad67b4e0c@oracle.com>
In-Reply-To: <770d3b15-d521-794e-b78d-ba8ad67b4e0c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb12c3a-c329-42c1-b5cd-08db0b8108ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1XOFKLBJkvbWR0NwK50NxcKIoXHkDSo2w9IuN2BUy+A+1vs4iuiyGwCBoZ5xvQA3FAIHOpK3Gi9LR5kgAk8b2IG+3snMFhoNBZQxMcj87lEjBoI/gn5GgEKB4qs+Um033mxoIRm0GttraXxkofO9z2BOETNJ0ucOveDyzQ0RjtjBOXuxft9KQis+tx4VQlpWwKsL3T9AKryb1pTCwLrVd2E7mpysiVeUwdGfH3HyBsebvQq03Hc67/+3qKHuD/1LN/B5DvcHYAUYI4GlxVg+aPp+3AfQc3Pz9n+5GpuOwviGH2Czsnv2ti3TlS/gZ3191DQ3iVb9ePehrCu0c0qbbR6buzpx/st3xsNGEI4LHpyWuo7fVe9a5IdMfSqG++wRaEw0C7Gig8SNVxhtz9iPTbvY21AhrtI9jaJ044uQxmX38efVP0BGf66PdZ0QhH5+z4pJkKFMBXf3VBagZKigjMKhLgoqxXpIUU7vuAnsjZ2FSsxUVNIcyBbihU575SoDMibywzTNoGzjXQs72CWjrbJU9ce5MHLIHvlcteCZTNjYYG+B13+8jy1zq8UOW+MF8kqFhXPcHiWzVByfF6SabOLmny8Yq4/A4bC10fP0xC7oVuRxJIxQF64zs8kvzbnJnYk+gTMzwy34X2M/8bWA8oh0BsUXa8vFzUFwIRdub6Dq6omKHkigvhdvpBWSP91c2e6AoFqhyBRlLyTDPeez5kEsOfWe+gzltAOEVSWyxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199018)(53546011)(6666004)(41300700001)(8676002)(66946007)(66476007)(66556008)(31696002)(83380400001)(86362001)(38100700002)(6506007)(44832011)(36756003)(2616005)(186003)(8936002)(5660300002)(26005)(31686004)(6486002)(478600001)(316002)(2906002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxxN3ZxSnI1bTVHRkREbVVwT1hVRlVkN0tmM3QrYTJXd09ldmR5NG9aR096?=
 =?utf-8?B?emp5OXowVTBTREt2RmJWK0lYdzV0aklKaVJFTkRBQ1ZPMFY1L09WNVlwaFlB?=
 =?utf-8?B?ckJyQjBGNU1HWXY4SnlMcTk3UURGYytpMnBRc1NxSnZKMHhMNThNdTVqZUJE?=
 =?utf-8?B?ZXBjL3VSaUkyS1lZd05ZeGlqMHBXQTlvSXN1OU1GQ3F1K3BTcEJ3b1Q2K0FK?=
 =?utf-8?B?RTFwMGFVbTZrYklXNG0rYVpvSXVxczRya3RqaGNiNmR0bGltSFArODd4WE03?=
 =?utf-8?B?MEFBNHpuV284MVQ5UWI3LytQTENtYXRRSW1GMzY5MDUyMHVmMU5BU0tiT3Vq?=
 =?utf-8?B?aFNPdU10MjU4djIvanA1UUlpMjRKdWg4TmJvRm9XZjJOVmYrUUJFQlVqWHlr?=
 =?utf-8?B?S1E4Z0d0L011djJnTzNReUxzbGs4UEpFNCtOcWRzQmhscGo4cU9hM3RwQ0lx?=
 =?utf-8?B?dkU1S3pYdktyVjdkMHVFdlpQbGlFbi9jaEE0amd3TUFGRVB2RDNRTCtxWkxw?=
 =?utf-8?B?UHVuSTdhSjl6UjkwT2pjVXVsNDIwbldKYXlmS2wyTFJScG9JVEFDMTViYldF?=
 =?utf-8?B?ZXlya2ZNaW1TdFd1RW94clFNVk5WWnV1N1BoV045TktJZ2pEYXYyK3AzRlNY?=
 =?utf-8?B?K1IyWGloWWFvWFZpbStvQ1VrZ0ptN1plU3BGUTB1by9KKzIwT25qMkVDekVj?=
 =?utf-8?B?d2lJODRackNpV0xCU2NLcmsyZWs3SHZRdStsNmFBRVZrRmRCK1JDVHFVL0J6?=
 =?utf-8?B?bHB5blVVYXM4b0tkOTE0cUMxaUlYMDhSRlNockVYenFJMjNLaFVrL1dyZElQ?=
 =?utf-8?B?VHAyeDNublRNcTdDWEUxZDMrZmpTSlNqUTRZZW1QSStuNTYwdE5ZNE1nNnpp?=
 =?utf-8?B?QlhDd0FWQlczTkh1NG1DNHVIYm9uc1pYclRVbzRYeU9vSXVoZVk2VUE5R1hP?=
 =?utf-8?B?U1BJSUxKRHpXRzUrSmpQZDd3clc3aWJrdkZQazJoMTlGMTM1WEZML0IyTzF0?=
 =?utf-8?B?RDViUGF4eHpBSytTMDZ2SEQ1b0FIMkVJZWpWMVdSZWdUSGwwamptcTlDQ29G?=
 =?utf-8?B?WWs5MXpXWmlJSTllRUIyeGhVZmZEUEVMZ00xU3lTd3JwMCs2N1htQ21OVCtM?=
 =?utf-8?B?RzdEb0prb0VMVXpEZGFHc0taK0g5M3NZK0l6UXFWOWIyWGpqeVY0d2hJT2Vz?=
 =?utf-8?B?Z3QwS1lDZ0xHd2g3VUxGcWx0V3VKdFZpNVdqSEM1cStjck01ZG1oVUlaMGFO?=
 =?utf-8?B?NjJjU25vUXpNN0h3bWFHYU9NQzNsamhwcWFtcndTSUV1WmFIZE9KbSs1Rjlk?=
 =?utf-8?B?WDlsZ2paMTl5WFN0TXRvcnpsTERxZ2o1bjNKdmVBQThpOUE0czV0cFhLKzN1?=
 =?utf-8?B?YitmRllXTmE3Kytuc1diRzhRNlhwUmU5czM1SEphNE5iakNtb0p1eG4zR2ZX?=
 =?utf-8?B?dy95MnlVSGYxQzJaNXJjOGFQVitob1lqcS9RK2hTRkxXK3FIKzhqODV4SlUv?=
 =?utf-8?B?N2pvWVdMeWJycjMrQlo0Rks2YTVNUTduRzY4dFpwTWkzWWJSdFZ4Y1ZwYnZQ?=
 =?utf-8?B?eDlSajZYaVdWWVF0dnZESktBbXM2WE9KV3ZDbWd5aUJrY2duTHM3Tll1NnUv?=
 =?utf-8?B?STF5LzJuendmYXJNYlUvZ1RzZ1FDV0JsYTQwMUhkN3AvQ1MxbjRpMW9IY0xM?=
 =?utf-8?B?YXh0U2s1VTVxWktiWXhjMFBoOHRuYkMzQ1ltNHphMjlDMm1oVEZLWmtNR2o2?=
 =?utf-8?B?aG9SWXVqbkNNWFFHMW9WY213WFl1cTVWcERSL0wrSHRDeTJmR3Nrb255L0di?=
 =?utf-8?B?eGRHa25DcElrcVk0U0VsTXI4YnZmTzRRZ3BQNEVNTmwyYWhLU21PWDVtUEU0?=
 =?utf-8?B?RFJjVzFNbTdTRzUrcVF4Mk5NbXFlWEo5Ri9iWUR2cnd2ZHowZ1hRQ2Uva1Ex?=
 =?utf-8?B?L1pmSm5qb1N6OXQwRzVvMWtlTkd2SS9mSEtvRG5jU1JFU2orNlcwUlBTWEJh?=
 =?utf-8?B?b2tBaUZsTkpiaVA2QXBONWluMTFIc3A4NjRuSTQvTzZWZFNaMFA3NUp4ZW5w?=
 =?utf-8?B?a2EwVUg2NFUxSzRSQ2JEa0pKcXFXTkxmK05aemhOM1A5ekV4WU05QjhkTGJG?=
 =?utf-8?B?RGlrQ0w1aTFTWkZIZ0MwR21vRlk0OU1KRUY1UXlWVFJzVGplN2JOaXdRb1RG?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lDA9wEslF4ATkhU4SxqttU8U98SWy4/iTmHCBAXGacB97MsHpOEgpXwcTdCIcTx5MhsXnQ7ACn9AxV8s5RNWrDoCwIywKKFrh5aOS0oJaG/TjIlktvV7vGwqNCCdpE3GjBOuOQlTpTjiU3uhSPZxOxUxqfAhThyoFoRIUpv2CSrVGqmOCGlezdBJqKMOF6uu8Vtc5uNt6nAQ2WPX7LpeNLYhmkVuTfgUiaIqxhqXuSYe36zNkr48a0JecnqkwtA99nEsK7ug4koystE8Yd+6Yr6X7lOTDDODIwv9k/8SsKxHuvPCNRGVXTsOHpA92U59XESAFA5W0+HU88LfCqpZS4o69ZmB7+paQ3uIvSBupVVu7cqjrN31YxT87tOanatesqRHW28oihNNvbPO6UMmu5RpYdaxl1+U/QbNufa6r1sh02WThjC0INSACb50L3HMuDEKR6+wMottKpmWTLDdaoyt0VWbQqmcn4/jkvS3FIdMwVqQ6FejP0UN3P60Jd0yyu8q2DP8ZmAd8uk8IcVWScnMweAAy9bJOdsPxt1CxhGZQmnabU9pacTK7ZGrAIjwArD3EPyU46ANqK/4Afx5ZimIOxOBAyYUliF8XILBWtkr8PLUqOkeq8rRQBHnGrz+Y4D6vmsBRvnJYh059NTgHPccrMiMscjQvf2bQDOfzrsnkWOVwDKOsY6YgJJfseTHjrb+krfxw0J4iXBcnBXA6TSCg6kZ54dXN68PqRwausvNyLzFA+8UNjfl2qIhsQucikTwPbJleYv6KTr50FxhDsTSYH7Vy2y57l2mXHfpgxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb12c3a-c329-42c1-b5cd-08db0b8108ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:08:23.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIHAi9uORUdamCnwv8OcMQT8XkVl0ybbV2bRhXieouBSnhHstdPXPc+9h0B9/C6h/h0lWXXLptfD/jq+sWCCSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100135
X-Proofpoint-ORIG-GUID: qdqyToS1hNyzPw62EPKBQK_0qo7up2hk
X-Proofpoint-GUID: qdqyToS1hNyzPw62EPKBQK_0qo7up2hk
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


OR

We could use both methods to accommodate older kernels; switch to disk 
reading if newer sysfs interface is unavailable.

Thanks, Anand

On 11/02/2023 00:01, Anand Jain wrote:
> 
> 
> 
> 
> An alternative solution is to utilize a kernel interface to obtain the 
> fsid [1]. Previous experiences have shown that attempting to directly 
> read a mounted device's disk is not a reliable method and can result in 
> various problems. As a result, it is advisable to use a kernel interface 
> to read the fsid.
> 
> [PATCH 2/2] btrfs-progs: read fsid from the sysfs in device_is_seed
> On 10/02/2023 13:39, Qu Wenruo wrote:
>> [BUG]
>> Test case btrfs/249 always fails since its introduction, the failure
>> comes from "btrfs filesystem usage" subcommand, and the error output
>> looks like this:
>>
>>    QA output created by 249
>>    ERROR: unexpected number of devices: 1 >= 1
>>    ERROR: if seed device is used, try running this command as root
>>    FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and 
>> btrfs-progs version.
>>    (see /home/adam/xfstests/results//btrfs/249.full for details)
>>
>> [CAUSE]
>> In function load_device_info(), we only allocate enough space for all
>> *RW* devices, expecting we can rule out all seed devices.
>>
>> And in that function, we check if a device is a seed by checking its
>> super block fsid.
>>
>> So if a seed device is missing (it can be an seed device without any
>> chunks on it, or a degraded RAID1 as seed), then we can not read the
>> super block.
>>
>> In that case, we just assume it's not a seed device, and causing too
>> many devices than our expectation and cause the above failure.
>>
>> [FIX]
>> Instead of unconditionally assume a missing device is not a seed, we add
>> a new safe net, is_seed_device_tree_search(), to search chunk tree and
>> determine if that device is a seed or not.
>>
>> And if we found the device is still a seed, then just skip it as usual.
>>
>> Now the test case btrfs/249 passes as expected:
>>
>>    btrfs/249        2s
>>    Ran: btrfs/249
>>    Passed all 1 tests
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This version is different from the original fix from Anand by:
>>
>> - No need for kernel patching
>>    Thus no compatible problems
>>
>> And also different from the fix from Flint:
>>
>> - No need to search chunk tree unconditionally
>>    Tree search itself is a privileged operation while "filesystem usage"
>>    subcommand is not.
>>
>>    Now we only needs root privilege if we hit a missing seed device,
>>    which is super rare.
>>
>>    And we can still fallback to assume the device is not seed.
>>
>> - Better commit message
>> ---
>>   cmds/filesystem-usage.c | 72 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 70 insertions(+), 2 deletions(-)
>>
>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>> index 5810324f245e..214cad2fa75b 100644
>> --- a/cmds/filesystem-usage.c
>> +++ b/cmds/filesystem-usage.c
>> @@ -700,6 +700,56 @@ out:
>>       return ret;
>>   }
>> +/*
>> + * Return 0 if this devid is not a seed device.
>> + * Return 1 if this devid is a seed device.
>> + * Return <0 if error (IO error or EPERM).
>> + *
>> + * Since this is done by tree search, it needs root privilege, and
>> + * should not be triggered unless we hit a missing device and can not
>> + * determine if it's a seed one.
>> + */
>> +static int is_seed_device_tree_search(int fd, u64 devid, u8 *fsid)
>> +{
>> +    struct btrfs_ioctl_search_args args = {0};
>> +    struct btrfs_ioctl_search_key *sk = &args.key;
>> +    struct btrfs_ioctl_search_header *sh;
>> +    struct btrfs_dev_item *dev;
>> +    unsigned long off = 0;
>> +    int ret;
>> +    int err;
>> +
>> +    sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
>> +    sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>> +    sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>> +    sk->min_type = BTRFS_DEV_ITEM_KEY;
>> +    sk->max_type = BTRFS_DEV_ITEM_KEY;
>> +    sk->min_offset = devid;
>> +    sk->max_offset = devid;
>> +    sk->max_transid = (u64)-1;
>> +    sk->nr_items = 1;
>> +
>> +    ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
>> +    err = errno;
>> +    if (err == EPERM)
>> +        return -err;
>> +    if (ret < 0) {
>> +        error("cannot lookup chunk tree info: %m");
>> +        return ret;
>> +    }
>> +    /* No dev item found. */
>> +    if (sk->nr_items == 0)
>> +        return -ENOENT;
>> +
>> +    sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
>> +    off += sizeof(*sh);
>> +
>> +    dev = (struct btrfs_dev_item *)(args.buf + off);
>> +    if (memcmp(dev->fsid, fsid, BTRFS_UUID_SIZE) == 0)
>> +        return 0;
>> +    return 1;
>> +}
>> +
>>   /*
>>    *  This function loads the device_info structure and put them in an 
>> array
>>    */
>> @@ -708,7 +758,6 @@ static int load_device_info(int fd, struct 
>> device_info **devinfo_ret,
>>   {
>>       int ret, i, ndevs;
>>       struct btrfs_ioctl_fs_info_args fi_args;
>> -    struct btrfs_ioctl_dev_info_args dev_info;
>>       struct device_info *info;
>>       u8 fsid[BTRFS_UUID_SIZE];
>> @@ -730,6 +779,8 @@ static int load_device_info(int fd, struct 
>> device_info **devinfo_ret,
>>       }
>>       for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
>> +        struct btrfs_ioctl_dev_info_args dev_info = {0};
>> +
>>           if (ndevs >= fi_args.num_devices) {
>>               error("unexpected number of devices: %d >= %llu", ndevs,
>>                   fi_args.num_devices);
>> @@ -737,7 +788,6 @@ static int load_device_info(int fd, struct 
>> device_info **devinfo_ret,
>>           "if seed device is used, try running this command as root");
>>               goto out;
>>           }
>> -        memset(&dev_info, 0, sizeof(dev_info));
>>           ret = get_device_info(fd, i, &dev_info);
>>           if (ret == -ENODEV)
>> @@ -747,6 +797,24 @@ static int load_device_info(int fd, struct 
>> device_info **devinfo_ret,
>>               goto out;
>>           }
>> +        /*
>> +         * A missing device, we can not determing if it's a seed
>> +         * device by reading its super block.
>> +         * Thus we have to go tree-search to make sure if it's a seed
>> +         * device.
>> +         */
>> +        if (!dev_info.path[0]) {
>> +            ret = is_seed_device_tree_search(fd, i, fi_args.fsid);
>> +            if (ret < 0) {
>> +                errno = -ret;
>> +                warning(
>> +        "unable to determine if devid %u is seed: %m, assuming not", i);
>> +            }
>> +            /* Skip the missing seed device. */
>> +            if (ret > 0)
>> +                continue;
>> +        }
>> +
>>           /*
>>            * Skip seed device by checking device's fsid (requires root).
>>            * And we will skip only if dev_to_fsid is successful and dev
> 
