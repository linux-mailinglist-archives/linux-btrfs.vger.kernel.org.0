Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821F75FAB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGXPWg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGXPWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 11:22:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC910F4
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 08:22:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OF2gpJ006872;
        Mon, 24 Jul 2023 15:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OYpcrY5Jr/F+qHgqVbh64AKeYeLjsBJ8kh4+XMoE524=;
 b=r1sEdP1L6EU3giPCOz4Qds8LjdNHd2Z0C/jXdG+u+1wPqV5tbg0L3pmPHWmqJA8FjIpW
 hx9qAXblHSI6mWgarGLKc7EvLkYvO+n9ChgCb8Ix5ItMNmYPSxkr0R990FWHFzVfomIO
 VJyvV5Nmti8pZ8JvVXcSWT0LfNtTTt+lT+1HzUlyh59gbjyjBE9/H7PO0bp/o8Qii8pE
 UrOzkAz/O0kW6YeWmrXPv+aEVcqWTNtE92X1Foe6BRlbkTimp6hv55w/Yn2YcwbSTuO6
 z6l5DOe7WNBVZ8t5IXPrfK1bFud16y8u4+JMUoTpCyIselxY/33Qhzog9k6+3XHRuQi2 OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtu0nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 15:22:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFGTvC028692;
        Mon, 24 Jul 2023 15:22:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3trc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 15:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUEk0R8P/Hf5nK5k4vuC3Mj5FFJT/p5SP+8vS60/GWEyWILt56eR1ziq5l0qZnldR62qIIN+YtcgzIQxkQiqT08196cVFqxdid2DZCoq/u4/GoTYutpo9S+TsQoNrXc87PDDCv338e3mQEwMCyeai6wbCsp0vnlaCSgPm2hRiLeUfyVq/ON7bboMug7LlrhThyBZl9Xdy2pf9EAxUmG0lBIubuARNMyLhtFftGHSu8VM+DvS1DJaEV8Xhc8PX5Wcnrv02bQzx22K6/TyYhwiZ2F1YDlsu2P9rWERjO18k0u9z1LB/w7R21dBdqRGAYWGEBsdq8oRjBHnVOjXLHwT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYpcrY5Jr/F+qHgqVbh64AKeYeLjsBJ8kh4+XMoE524=;
 b=JofQQDD8syRB8EV5X0rTUyo1Wce4UXdYaxksOhoD9hgbBReDrIzKeMHCAve+OVAvyeKy/VwjIws+QnfoVGOmE2b/ahwXDhstQKzutmmPb4E2fyakF8NcFFgvJVlsa6A9/W9rI790HQgXaM27HLdIhZDA1HFV7cttOFsQ9iD1Kt5QXCEpJJKkd845ZQ2FIFdhD8Ow3KmoGoZH+Y/l0n+1yCcD6ZUyuo5dP4jvNsZ6mpUNjkmLPKp1BHSj0brSqNdp8ftxjpHqCFQBi/hMGrCCz0zyhp6Ua23bZJaScd0Sve19smgDbX4znp8MGszszwvPfDflM2pPV/wI29gERCEShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYpcrY5Jr/F+qHgqVbh64AKeYeLjsBJ8kh4+XMoE524=;
 b=aLYlydLgq8/NtG0vO/KGPBtb/OiVyC3InJRp72y7X88K2SkL36D//640lm6fdnA5INx/Pm9vBrqeHQp6FREV1faHDGS0LGEOvkOwDXnSp/5a2w2PU31cG/u76bMtuM/B0rJ345qd6U9rfJf5Fzy6p98brV88GZGF6NN9b0ZqMpo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 15:22:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:22:06 +0000
Message-ID: <e62052b0-1008-43c1-7abe-41e5b55347e1@oracle.com>
Date:   Mon, 24 Jul 2023 23:21:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: warn on tree blocks which are not nodesize aligned
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
 <ec3b4494-2a76-9519-39b8-edb36477e677@oracle.com>
 <c2411057-179c-4041-9a0b-92f487adc7df@gmx.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c2411057-179c-4041-9a0b-92f487adc7df@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 644fa226-1b20-4865-6a95-08db8c59bd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2V1eVbtujq25xbEqi9bp/t1kwqOTt+xT8rkp/T1bDEABcw/kaaaQcgQfpV8SFSgDW8kyOglcZbrByoGRJfX7mxinWNwBHYAz53Am8FTChTuG4abFitfUOQgXYIWvYJmv2u8KGygBTK6wHkZkuU+O60HjhYXIZMBjb04m8NpGGNLwbvCVus5uhshU7zWTkBZVprR2JO8pgprtE7L26mkjrThwdlS2GitQdzFYFITk9ByHZuvUWmGspTrqtcPR8Rt+YW1+fnTQ2wDHJuFuzj/2C4iusxsBEFjdV4NeFGYnc8ZOMRBhnfLQwuvijqJOZOdj37XyMz+JlzmAHNmOy/HGOrG5edS4ZVBaP1fqEkOkOWzDEGgl1uw6eVrEf27KrsuK6kPb+TUGEdrHrwRZe2CHcI6T9/tSjR/lOM+8DWgukcN4HS2/c3bCbwRw5/IwQ5iXzpKsxizXGlwqECvGI8ykSiNdW9cHc2f96wQZ+9qzGhM/XQA3awppUxxs3k1qQ/pm55jbzoVCpUA8wZkq0frThnEb7B0D/tjALom4W09piaWCHPDFhsXICUV6ao3SzPxX0lu0WnO2gKUK0pbF6PNHM5064D7zJ0FV3B9PoDCmePnQyzO1TgsXrkuLlYQBntIXomPLIrr2gaCk9I9ROAByg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(5660300002)(38100700002)(26005)(8936002)(8676002)(44832011)(86362001)(41300700001)(186003)(2906002)(2616005)(36756003)(83380400001)(53546011)(6506007)(66946007)(66556008)(66476007)(110136005)(478600001)(31686004)(31696002)(6512007)(6666004)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpzSTFweVVPYXZJVmRhM0ljNWFEUTNDVUtad21FV3JKWTNwaVBoeU14QjFq?=
 =?utf-8?B?RmZFNHlVWjhWRkUzVDB2OUErNmNMRHo4SUF5czZSOE5Bdm1pZFgrMzd3RjRP?=
 =?utf-8?B?TTZNbHZpSXR1YlhFVGpXejBOL3ZjVGNRZk5KN3hvWmpBTmlORXZFdUJHNXFI?=
 =?utf-8?B?V1JtQ05wdVI1ZVNHeVdZaUVLd2Z4TVg1b2VEREgzZXVYTmxjbFRFN3RTam9j?=
 =?utf-8?B?Mlh0RHVvSFlaSWZFUnNkcHlsWFp2RzNBMWNJazdHS2xzNDV1ZnFRcTlEeTR6?=
 =?utf-8?B?NjJpQVAxYks2S09qN1Jyd3VxQzNBajJOdnUyTHF1djhaS3lYcUlDUU1oUWJQ?=
 =?utf-8?B?dDBMUmRabXB0Nkdka0VrT0RSQ085Z0ZiTTMxQkFzd25Makd3QUc5YlJudW5l?=
 =?utf-8?B?bUF2T0I2L3NmeVI1ZHhLMG1vWGMyUDNRYU1ZejlpcEpFa0JQaThJZGg4eG1H?=
 =?utf-8?B?aUpmdlpRTnMrWXhFemJSS0tOSnNnNm45bnNTVTg5T3g5T05GNk5Xelk0cmFI?=
 =?utf-8?B?T0VPRWxrVVZodTROSFNXVG8zVE1zcnZYRE05aUx1UlhUV1lIRTJYQU5TQW5Y?=
 =?utf-8?B?Z1hreEhKZnBoVGhNZXErTmxrWkw0bjl2a1hZbnd5OW04aEVqQ04wdC9ORWxp?=
 =?utf-8?B?U2plU0NHWWVGV0FyNC81QUtuaEkrelBXcFVwV3dJQk9McUpmekQwaUlwT3Jn?=
 =?utf-8?B?S1N1bzVGWEFyTXc2NXE0TWZVRHNNZ1JsZmVCdFpsSkNJYUJwYTdUT1FyMkVu?=
 =?utf-8?B?Vm1CNUV4aC9hVDBsQkMyZzZ3QzZUejVtbjUxM21xNnFvNFJxL3BYbjJidU5G?=
 =?utf-8?B?dFlTMFBLaitOeldiTzlYUUtYc2xJbXlRa1ZXZmNJbDB3bk51bWVRR1g2MEFp?=
 =?utf-8?B?NWpUQ2xqaTFZdCs5TlJ3cjJDL3p2T0krYTNIRWlXd3JmTDdGYW0yRlY5SlRq?=
 =?utf-8?B?ZVZuZm1sb0V2QU9MOHNtbjFKNW1LSk5FUXYrM1dWd2dYNW9VSXhkUDk4Y29q?=
 =?utf-8?B?RVoySkt0QTdERXVTNHp1QVIvMTdqMVdCa0FtSVZqTnFad3o4QzJDbFZrMnNU?=
 =?utf-8?B?WmdjOTNyOEd3cStVT3hWZWsrYWtHeEpBRktGR3c1a0xVUFdaVXVOd1hIQ1dI?=
 =?utf-8?B?dFdtbCt0MzFkV1RiV200ZlZhM240TXFQRm1CU3FKdE54aWszMVhkSGlZNlZZ?=
 =?utf-8?B?eE5BbXNjbDJnek9uenA0U0RwQzZCanIzZW5XQmdlNWpZbHA4YStaaTFZQjlN?=
 =?utf-8?B?UGtYbWJJeUIvSXBoNlpqaTkxeC81RkhiYVg5ZG1UU2Z5cDhhSzl4d2xTTy84?=
 =?utf-8?B?bnF6d1FwZUhNUzRVSllsRFVOMy9xS2RkY0VEL1ZtbHFkcXpDRytxL0xhNHhH?=
 =?utf-8?B?bXlwaTFnM1JZZUN4YTB2YitQRFNUQW1qS0g3NURCbTY1dkFLTXVSYjM5SUFt?=
 =?utf-8?B?cDB0UU9xcHJLRzZBL1BFeFh1WmdKdjJWcmE2VTRqeFpJc2Z4bzhYcWw4eG9J?=
 =?utf-8?B?QXF5MVZFeGYvbXhwcCtKKzljMkhKSHozMFdQRTQ2MTFwYklDc1V0T0tIbVZj?=
 =?utf-8?B?aXNYR09oZDVGL2w2OTQ3YzJIWldjVjhUU3JNQjhjY2dVVWovNUM2TGZnc3BE?=
 =?utf-8?B?aUlrRENmaC9qdGxSQXcyOHVjUDAyVnpBMTYyZVFiVmRuSkJqZy9SS3F6TlIz?=
 =?utf-8?B?WlN0UFNyZkx2V0lydDB0NEFURUYyNWI5OHBGalJSRDNuWlhFMG5xN0dodGFL?=
 =?utf-8?B?Q0RqTFB3TUtzcGtwSFF6MFBucmh0OEV3Vng5c01vTVhONFJvcEsxWWJ4UUYw?=
 =?utf-8?B?Q0N4VUJub2kzYVNQenhEbmRNZ3NBaTQ5UWhOZTZwQ0xGWkFRZlk0ck55VUVY?=
 =?utf-8?B?Rnd5aGdkRmxRdkczZVRJZWxSUUJFeGZDd1hhM1RIa2grQ2FLVjNNdVc4bUNH?=
 =?utf-8?B?R1luVVB3WUgzTGp3b1pVUmZxMHFicEwyUVhtRkxmTTI5SGI4Kyt6YWNnSnBI?=
 =?utf-8?B?ZTIvY29yMXRyaWp4ODJrcHlOWmhudTBvTFdEbEpDSndtNHhkZzZMMldiRklJ?=
 =?utf-8?B?eWhraktIQkp2SFl5ZGZVaTVlZ3ozUi82UGJhN0dNaFJNZm1rVGVmWlRCSmlJ?=
 =?utf-8?Q?0DeDHdZEQQXKmDDnfmhRE3qWo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h3cvcIxP7ylb1q2xnhaGKlbwR0vACxLUkw2q5Yw/PrsvZe40PHMGaxrLTDaAozENn+AihLpsUZmPmeJc6DyVdmpmXtOxQMqzw8GdvyJryc8qMeCVObhzmazKqH0F1j9JMdcAEE7hyOStB0st4oWsFw3tJyXYOKVw3rjPxHuM/BLIDXo7MdVdNTCnLrtbhbXQJ5MBee1dErnO/didqrvFctOfTZRi72S9VbvTgar4iTTZ2kAk9UlyqmSyW6807gu1mPnW+2iItkGJH1yif+0e8UGm+3x1JwcpmW/6DyYiKqvxIFTg/O+brsSJ6i7afK5JQPJzBFXZgsuvykP40wlClW+fdMhjf+olIFAqHyEjVkYmzoJGLMTZQ3MiiZTTAaXZQOEoT9B/lGSBpdJI6/fJKGy7DmL2GYDDgcB42dejptOv+5IAgMV/oZtOPrEkt+4MVlm0g2ejr+p5WG510qHAEeUsXW0vdoJjBph7H0yXi5bpTdE9a95jm2bjkjgavsAnOM9BQxdf/f11yjbxTUXKTWPVCM81I/r3sGHIimNnT28t0oH6JRA+CQuGvhgYECpSFKFMBoL01Jm5Ychiw1pe0GFvgH5/gkRQs+1ha93ZWmFjEkQsiw5dsZgtr00z6wTQztRDAu3por1Q7GcPkxKLqkG5UHawjcTrUcGzu1tdPNnSn7F0T+1OwtcIb7BUuSfLY6wWcjsH1lMfQ+ea4XJrjUOscxzG5LLEZBwBk6N3ubJ22/8Yl0Nx1zoeanE5ecEmri7KvYMPv0vUJmYtPw7jhH1mU59t9geyxxAVCcF092YccDuferdyRxdwLd4f2z4W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644fa226-1b20-4865-6a95-08db8c59bd62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:22:06.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SWbsWoInZ3n9lOz3JRd0FsmSAtBtZcrgoYCWxOVN0OEWUak8IBp5KoDCZMjPkH0W2i81WTYucemAgGbvVKp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240136
X-Proofpoint-ORIG-GUID: 17ugcEzQZU9IopfPtjVO0QD2WWFWQSsD
X-Proofpoint-GUID: 17ugcEzQZU9IopfPtjVO0QD2WWFWQSsD
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/7/23 16:55, Qu Wenruo wrote:
> 
> 
> On 2023/7/24 15:43, Anand Jain wrote:
>> On 24/7/23 14:09, Qu Wenruo wrote:
>>> A long time ago, we have some metadata chunks which starts at sector
>>> boundary but not aligned at nodesize boundary.
>>>
>>> This led to some older fs which can have tree blocks only aligned to
>>> sectorsize, but not nodesize.
>>>
>>> Later btrfs check gained the ability to detect and warn about such tree
>>> blocks, and kernel fixed the chunk allocation behavior, nowadays those
>>> tree blocks should be pretty rare.
>>>
>>> But in the future, if we want to migrate metadata to folio, we can not
>>> have such tree blocks, as filemap_add_folio() requires the page index to
>>> be aligned with the folio number of pages.
>>> (AKA, such unaligned tree blocks can lead to VM_BUG_ON().)
>>>
>>> So this patch adds extra warning for those unaligned tree blocks, as a
>>> preparation for the future folio migration.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 8 ++++++++
>>>   fs/btrfs/fs.h        | 7 +++++++
>>>   2 files changed, 15 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 65b01ec5bab1..0aa27a212d1e 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -3518,6 +3518,14 @@ static int check_eb_alignment(struct
>>> btrfs_fs_info *fs_info, u64 start)
>>>                 start, fs_info->nodesize);
>>>           return -EINVAL;
>>>       }
>>> +    if (!IS_ALIGNED(start, fs_info->nodesize) &&
>>> +        !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK,
>>> +                  &fs_info->flags)) {
>>> +        btrfs_warn(fs_info,
>>> +        "tree block not nodesize aligned, start %llu nodesize %u",
>>> +                  start, fs_info->nodesize);
>>> +        btrfs_warn(fs_info, "this can be solved by a full metadata
>>> balance");
>>> +    }
>>
>> A btrfs_warn_rl() will be a safer option IMO.
> 
> Not really, as this warning will only be output once, as we are doing
> test_and_set_bit().

Oh. Right.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
