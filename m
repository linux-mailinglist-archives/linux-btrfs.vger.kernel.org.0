Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF37606F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 06:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGYECM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 00:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYECJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 00:02:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8F19A2;
        Mon, 24 Jul 2023 21:02:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1f9FV024100;
        Tue, 25 Jul 2023 04:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=z2qOp94+sKGOKqgjE67D04t4i6wxBkgzt4CfVx7IWulGBnmRbgy2lf18HKcd3Fg/R2Bn
 f704jtio8ODR+NY0ODjfAJz0ZGkIIN842mbqPgIwVHFGwNk9YYMNwDPv53z7wsCF1bdE
 OuQIaRt5M5OAVJmcVE3KXMDNgDRcAhc0mVsSZRRL5xDH9LAhwpo2j+GecADABj/3yZLD
 BCsnu83di4hmxWFZ4ZxiE5QAB04GIjztfZ4KBdySwB0nxxLjgcfiy6BqbwsRHH2tEUQn
 airYmQzs77kw9Q+uqZYIS3CcB3W3gFlSGNQibWKzQ5YYM8x1HqW/4+4eHCiqQ1YSr6kz eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdv5uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 04:02:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P33Xfq027537;
        Tue, 25 Jul 2023 04:02:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jag5n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 04:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTEnR/jRnEcGIYrchCMs7Mt9NTj2t3R+MrFdQk3A6819o1hAXkKZjEzXla3G0EIEXG5n1FM37YKy+3yTuFp0AzEqqR60dpVOeV+mws4nKPZxc/9OI6U4wSqDc87WRikniFTJQ9onNEK73RreViTlFXQ7lnxF7lReFNJQPanHKuxw/VfMfk73T2Zb8gz5FUL2uWKAmmrg+Ub7ODT+IZWy/qUoL0ZHGNSZJhnTt8e6j7JI3o0J8BlJmi5qKTwLrMl2Qu8pYXjAgMjb5B2MrfZBgVnF5cXdwct+J4OU3QnpoP2KQ83k7U6c6VprV+9OQpAXGHcW3eDFTigAmYFnpBp3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=bP12zumulCm/PIYUWUQ3DMQi6U1XWsNcIG0O02phV1VK+HjSd9moPAh9h1viakB7sD11duDJAJKIHVHCTr1a6f6mb8bduhnB6KfiDA67H3YUGLBvO/l4tOgMwDroy2Ivd3WYS6R6ir6MiA3rQ5eYyQnJZ9lt1WrXSR7TOHhDlJqNgk+m6IooGhtFdMnAhi6UGAeuaJZAfvl+BQsInsWOkoRAEMxT9LV6epD+zlpGxeG2ZZJIOWh1N86LwBKdcsRJXvbyn8FPlMWLxCdBaI4BhXf6ODQJZJQkm3FJzdwpsdKPJHbOn+f61B8YNOPCyJ5odifYO3g1S35Y+GGl8T9Qpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=q5dNqKMsKA+Nf7TzDzHFlKSujJJEa+MX0fOy3qpaRc3AB0ziGSZGqBcLeBASHT4LSekYhZs/UB1dCeAzXe3f6RFXx3+6RRrrNChPH3TU5SRGFPwADFaTrXlYw1sBuyy47LA01JIN9fSHwIEMmrfAIqvsENWMRhpWXF66KJ5KZCg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 04:02:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 04:02:02 +0000
Message-ID: <2f8228be-608c-2d6d-6ecc-b3c6f3aae9e4@oracle.com>
Date:   Tue, 25 Jul 2023 12:01:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] btrfs: add a test case to make sure scrub can repair
 parity corruption
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230724104657.184761-1-wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230724104657.184761-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fd5a6c-53c9-4468-cd1f-08db8cc3e6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZctRxVDbN8zvNbg1EQu1K5KfdTZKFEjVLUSbrF/1uFshxWbKFYCqpdlHgH4jQB5BUNjaYPiweWGZ2B08/4OcgFyBaBnVymVPIK6u03OnGsiwCMkxcBoTX0S6h8TvXNC9ljvBRMmfmyGcepRmqyUNlTQby+NXcqvKZ56I0Q9gsyvl0GX90b3kXsbfO6TNKZklxwFhhipTJFdlsQgU7KHugxEBwDo2BC9ynJnwN51/wBze+NTTkTGUYG+7CyBcEXjLZa15sKHH3GEgPBpHdU5yPcFrQ2hs7Qv3xvkyoEQOLrKZATjSJT364uk5UpUtUvx5sggzP4g6DOr9/R6Y0hWQPpZ9VW27n+s8zI3A46MKDTBswS+hQiQBPiBEBGlDLCqShWF9o8uxY4i2A0bevo370yH1xN6GUojGcghvg46jxkXslkkhB1ksi/tpzjZBjwRdurd/OiVrtGVGRU49Jqcp675l7le+s64lJxBw3n6gFbDhQEbbZKfUS3VNgXRql6y0EiXE3kMD62k34z2i8umI8UA/Iz6A4TMiCy02QZX68cJ67HSJQZ+I1a1LHvVd0KHBwnd3JbTEcyWrN5ebcPV1w97F9U1LtZ+IN1bxGGCx1jhwuUjktmiTVsY5ZvfKrBUOCCWKG8lXTrcMS3gm9mYHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(478600001)(8676002)(36756003)(31696002)(86362001)(558084003)(6666004)(66476007)(66946007)(66556008)(6512007)(316002)(41300700001)(6486002)(26005)(6506007)(8936002)(5660300002)(38100700002)(31686004)(4270600006)(186003)(44832011)(2616005)(2906002)(19618925003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9WM1ZWZ096RGpGRVB3SzMxMit2NTduSXZhbzdTRHd4MGNTd1NmOWJ3NWZG?=
 =?utf-8?B?VmNwVExUc1d1Q0RNSXhrditJd1doV0pEeXRmTEFhZ3kxajZjZW1kR1VDYjkr?=
 =?utf-8?B?aU4xQ3gyT2FrTVlCbDk4bnJuTDkxMUJhbk00WHNleWFpaFRNSUU2d1Q3QVBJ?=
 =?utf-8?B?TTA0M0RZYTFDT0JobUJTdEUwZ2ozK29ya3ludjVyZVdBSExVbnhGUTI1d0hF?=
 =?utf-8?B?RmZhTXlkb3JqWWJWaHZ6bk5ZUXhUMFFFaXIvWWlsOU5HZ0tka2VhM3YwMkRB?=
 =?utf-8?B?OUp5ZUFURjRaQTVlMGZmcjdDUzVqV0tIRmVzRzhjQ1NuOEFTL1oxcDArbmdI?=
 =?utf-8?B?d29CWEExU3FwMDhZR1lLQVBwODUzOFJuY3dXRHI3bmZoZlpTZjNjUTE2V2Vm?=
 =?utf-8?B?TGdvNm45aVBYRDlmVUlndGlUOWpLNzJxRUxUWDlXUXIxL3ZIOURMcjNGYnFs?=
 =?utf-8?B?RmpidFVRcmZGVnpSNlJyZXlaMnZSWHA1SGRYQUxmY0Qvakh5TFJZcjNDdXRD?=
 =?utf-8?B?M2gxQzRDSWloM0puWXF3cWZSNjVaZGNYbTdHc1JsTy9EOHpQSjlaZU95ekFD?=
 =?utf-8?B?cEtIcGxLT0pxODBFb0VDQzZvQ2Y5UVJkeWMzbzJ1eGM5RDI5cFBKWFhqUWVX?=
 =?utf-8?B?TnRLYWlTMGRGcTVYQnVQaVNRanpEU2xoSU5xRVRDTEtHNVF3MUJ3SmVNREU0?=
 =?utf-8?B?ZHFPRzN5N0EvVnZpTzRBczJXdDdnZnFjTlZMR2VoTTB4QmVNV1kraC92V0Qw?=
 =?utf-8?B?bFdaQ01va0JZV0hPMmlkZXN5NlNvQTlsUWR6QjVmSVhwRmVWbHRBaFNSTndD?=
 =?utf-8?B?dzZIRWV5dDFWUDY0M3dwTkI3R1lOTkZIUmtBZllTVEw3T3dEM1JwVmZXUmow?=
 =?utf-8?B?ZHNKM1pxdmZKQ0c4c0tPcXlieVZJM1FPd2ZlNENpVFpHdWxxbFlaMWpOaUhD?=
 =?utf-8?B?VXpZbVJVTjZ1RHNOeVFjbHBLZDhhY2V2Q0QzV2dyVW9xd013cWpUK1BrbFda?=
 =?utf-8?B?aG9SQ016UkpPQVNqMThSRXJlc1htMThxL05LZCtYcy92SERic3N3NGx1a20v?=
 =?utf-8?B?RnBMK3Z0cHYwalR2ZXdHWW1vQ0pvVG5XZkY1NmpXRDJjYVFxa1dIRC8vVTVH?=
 =?utf-8?B?VlJDd2lrWW54TTZFeGFGR1RNdnVVQXdRMXhOOEJ6ajByMUp1bkZLdHJCOVo1?=
 =?utf-8?B?RzRra1JFYmV0bUV4NzFuOEQwWVE3WnhKN0tsRkoxYnRtWHZvbUN4Y2ZzUjFj?=
 =?utf-8?B?cldFVTJIUTB5eFhsMUJEK0FGZG1zVlhBek05U1BpRm41THdzVUU4cDI1azZh?=
 =?utf-8?B?YWVDZytYME93QkFTVkR5ZWV3M1lCSmNXemM0U09GS1FoamhhRFdZTlErSllU?=
 =?utf-8?B?Tkc0UVNPLzlSZ2JEUXcvZnhtZGZPcG1wRWVUeHl0WW9mMWwzUFFQRVNpa3RP?=
 =?utf-8?B?cEdMcFMyTTBaSm5MTDRFSWhuRndRYU5ndVJ0QnMyWFJIMlBqYWxad0M1RTIy?=
 =?utf-8?B?L1lVd2J5OWhrY2lHN3pnUzIyZGJ5R2g3U3l2UzdrZklQOHlnR0lwY0JNazF1?=
 =?utf-8?B?enllc3lGdmw2Nkg3dGJXeFNKYy9OMDNPS1Qrd3BkT0ZWMXVDQ3EybE83b01x?=
 =?utf-8?B?TS9nQlRLckFCOGVwbjd1VDZQeVpoUWJleHdmZTBJbVhPZlJyR3BjNElCOG84?=
 =?utf-8?B?bC9ua1E2YjJyaXN2Rm9laGtSdDA5Q2I5VlIzRkd2S3VuLysxYVdkVXRRUHpC?=
 =?utf-8?B?eE45WFVOZ0lMSlZUYXBoWGdIalhKNFI0V0c5UFBDMi9jSWdQbHQ3Y3VXbjlk?=
 =?utf-8?B?SThRNm5NQUl3dS9xOGthWE9DSS9ZdnFzSi9OaGFjcDRWVUdZZXpsakQwVUZh?=
 =?utf-8?B?bzlTUFFtVWpieHZWNGFMN1BDbTZlVngrMWM3c09DNEFPRGpBaVZuakY2WVNM?=
 =?utf-8?B?SDZhWGF2eVJienhockd2dFgrN2dTYzl2Q3BpR3BzWUQwZmdVMnNTVDlxZ21W?=
 =?utf-8?B?Vko0aFlrUUNLeFp3UXRQVFpyLzRuZURJS2hOeU90VUJpVmlwQkxTVGtpa2Vr?=
 =?utf-8?B?Lzd0UVFoTjc2TlJRb2M5bm9ZRGxxL3dMSFFiaXNFSXRTdVZoUlg3MnUveDVY?=
 =?utf-8?Q?r//3jDAyN5T+/yAWk16EtYRwh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SjyhRi407MdO496OFq1jdQPORxdPEnaDi0j5QXGWnU3YQIkdSjF48s41LMDlEdUb0PgiYATpQcPAYILzaJ52OsyHKWmEvef518tA0uEGtCfJeYs0wfRy5cStL5go6cnEU8d6UwJy4hPHlQdotYHKLz2dnOnNspOKS3JQH4OBe2Q8/L9U5Bm96+GasgdLpachWsgdEShQf9jysAPITJ0B1yqNw3xOxf3QXlKh1t9qxiD3H7UO/eaQoe/f6fOF5RGE8rXDESDdnnPIIbpjxIXLin573X19CpMKWrUIRdFv1zk6c1LNhyuXlrDsihzsU9m5gvpYRYjmxzdhM9vjdo4wWYrkD+gNfcz2L5YLT2R6X3EWqMyz2kHS89oisirSt7oZnFs7fjFjHXkHdbwSydqeMudCvJwxHMuEUhgxsJs/a1ueWB5YV7EV7eLhY9BJTAIsPZVDjeMPgu+GG1zyO2MF8T2y1v2xaOsXIlHMYvU9rniKK66BnS7TVfC2oCy3KcYPeZvupeFS6YmDe99e9ro2XiI34s8hzRrQA6K+HA+pokR6L6WvXHT1DMW/B6sQcp+ck31/T0qRYQ7KlSYX2r5YF1NbYGKOiVwQxDME5mwypyclcJer2m9oIA4WVHlpYbdosvgZ4o2ucOD2L778JAEuN1LBd7AhS7xgP2GCLgITVHS0Hjrtbt7pzqo2vNaJIrPw5xpKACxq7pzU8Rgyla+D4GcWxLvdZlM0bgAbRpLt9hTBgINFclEj/eHtBW1fg69JcJ5T8Fdw1n4+fzFNcjsNAgkSy7eTOCyqvYKR7keioE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fd5a6c-53c9-4468-cd1f-08db8cc3e6d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 04:02:02.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eREJulEzRV24z6cGWM5tagWVfGkSnrD45s4G6YtdVBZ2Ec93G16OD8xRh9iGIhkgXjuF/cqYt/JalCSxmbDOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_01,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250035
X-Proofpoint-ORIG-GUID: UM68F5MLLWkM9ffvXNwLcZs4Uu--dE3q
X-Proofpoint-GUID: UM68F5MLLWkM9ffvXNwLcZs4Uu--dE3q
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
