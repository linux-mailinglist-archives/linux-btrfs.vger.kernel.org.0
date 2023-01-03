Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77565BC52
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 09:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjACIg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 03:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjACIg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 03:36:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8268B1EC
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 00:36:55 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302ILmnA025379;
        Tue, 3 Jan 2023 08:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BTpLMh9CR+KDqMccuyWfFcQvJu2yAYdVPmxk1BVArWw=;
 b=FRyf16mDtwa8aFWoSF5JLT9W427laX0m2wm3FcQnox9O3zTP4iEiV0TgU4ViQg0WNbOA
 WEVSv2TxpTqtDJHq+VcxTxJE01UYGRGqI5ki2VPT9ABmpCmel9y00VOTQWqsZn7EO+Hu
 BZQbGu8a+ncJzG3W1dPc3RCaK5ROrxO2cO7u+xW4W0oPcLK7YEhsRQwa9CRohZxTdlqg
 I4EoicEghuNj/ziZYWlCRpMPEO5PDQf+YBnv0YDLPuoS3PApmiSsxybECzaxR7Ds70NU
 ForBo+Kd0kbhyZ9VjHMS69Lpe4P7CtisjpjILs+rXIh0Ko2+VMM+ab3vE7ROGsTCd/N4 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp0udcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:36:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3038HDMU002323;
        Tue, 3 Jan 2023 08:36:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbhat8c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVJ2qpGm/81F9YDJgXJ8C83/vpZTlxB3sHDt14wKm85WkBKBTrDdhVDZeeNOcwjp/JH2DDPTjLjdAa2pnUI5j/17PP/n2aYtXz54EfIowjj3cpNg0mFlTebEaRmj0PfjG9baxXrKfA/bBLOsvtvzpQDIKI2nhEXOOje0cr8oiImwSbwjFEpSombxl1apMEm+62d6wF3bZ+67MgtjOrOHlmjzHDkzSVxcIXgjMVXHEkxNLwjv/nzU3NGXtOGpTqEH7EUhZqSXwn15jqGCXfPBXMtd+qhfgi85pHUA0fipV9RvWLnBPUXpSt1y77jWjQlzBmfu/M7a0P1Rjg2qYkYHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTpLMh9CR+KDqMccuyWfFcQvJu2yAYdVPmxk1BVArWw=;
 b=Qz4uzK2yBg4zlQYFMK646esRzQlUNXkZopMe2Iq1gOtJ+Khfs/GMMjkLYwR6CM+V8Wn1qV7TL18mRLPz0i2dE+QS7t5WCBISivqBV655Ai4ZwRjYFFmLew37ULj1SYFp0d2ibLzNT7B0rh1yRK4CgmyKbqlsM0mNFRLOyjUUV2MZ7uwqLj+NmovgKymBh59yKp5wHV3RrQvLrtlsYz7hnq3ImjRv55DF2LMjEc0rtt3+JHbsvT8PWwVDA/r9RPO0yAP+dVhQ/UeToqFEsdMwtjD1icrWaBtnRvQcb78mXWRGHnlauRwi/QBcWqL1KgOffh4Y3gosSlmBEYBw0/RVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTpLMh9CR+KDqMccuyWfFcQvJu2yAYdVPmxk1BVArWw=;
 b=RWs0QXt1tjldrClk8CEmKB6aDdZgEhDmBnkAnM19S30jDbhoU7Ldeoo2QMM+QSx/rnN41HRZNm9RvwdAGTAi4maXc3LpijdLOQbcsZiGh+0TlXAG7ZHgu/r0p2DQEtsESMJ6qRtxUj7gNUca4jdxKqW3ZOEyhvnaBJuzAeOv7BY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 08:36:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 08:36:49 +0000
Message-ID: <86021af0-051d-d631-1cf6-8758e7f3f6f7@oracle.com>
Date:   Tue, 3 Jan 2023 16:36:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/2] btrfs: add extra error message for tree block level
 mismatch
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1672016104.git.wqu@suse.com>
 <59e14f15599dbe48acd0487dbc640ae4e7559e21.1672016104.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <59e14f15599dbe48acd0487dbc640ae4e7559e21.1672016104.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ab83f4-6988-4586-d4a0-08daed65a7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBDieAsHWwBgR7MCLcSB7qi9ABB+NdGiuJr8BCLRFE7C/vaQaGWYP7dKHRc/yE6fh2GnTcAbZqO2arFjWeh540H/9sMmNRo/8KiGlnqlNjeq1NaWDfvv+UuToOjJEviJMBJblBz7ZYTgKYL3u4yxfjAzWhqqtRa40mNzNHVqveUjwFLk5SndprNopZGAbSDmdXhLV/kRxu1icKAONeEIYR66fbd/q/6w0LtXuLO9tBY4ZuOh3ZIUuhmBrIqI6rbvaTGSY0+aYidqK5FGtXOabwCZHKCxOdF67b5/AHQ8OlVN1U8IxFAnlx4IjSSEbIy5JrUcL25XjD51aI+VH7H+o9bfkSWjP3QHnQcKqnD47oSnVAiEHbu844PEl0Sl3iL61RYNewlfSbCpWwlBEOzouErhgc4+DnAVrKcToP4H2NUrGKPJm93dy+0i/4a2ZlAJuCgDK3RCKgvyEL554vrJl4Lhy+tkTXW/uaAciaj5r2mB7xR9dv9yHSbAmO+221jParWM/EZoNRcdyoMCYk3ApRyvQxVKZw4mraYoahf5xS/IrkBUN6E8VaZapD5YEn9bdMmnfivUIwNQo1tbiWWOwOcRr6kInGLT/ogFURZ8cwIpf6mkmu46B215C+BFuOKIkvNMNBQjf4vXQ+JLENgnxu2zsFACgINYD/a9m1IfmKSJ68OimgRJCr6F7/xgoM1QW32U0OdQA9f8K62vKXyobo2X+NNt/FM73BKhYTJ+PSJgcfUmMyzvmtz5M7ApQWEY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(36756003)(8676002)(66476007)(41300700001)(66556008)(66946007)(83380400001)(6666004)(44832011)(6512007)(6486002)(8936002)(26005)(478600001)(186003)(53546011)(6506007)(316002)(2616005)(31696002)(86362001)(5660300002)(2906002)(15650500001)(38100700002)(31686004)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkhiV0kvSkcyQ2NjNUdxeU5obnVubHd5Uko4MVllWVRFbk9YK0xrTzRYSkQ2?=
 =?utf-8?B?a2J1Sk5wZDBtbEhhT25xT21DZDRybFp0bjVlNWR0cGliNEd1UTJMWDFYTS9K?=
 =?utf-8?B?aHhaVzBoMFBLQ3ZlOCt3dnNmRnZwcWE1SWJrRVMraUhYdGhmZjFUellIcStE?=
 =?utf-8?B?R3hwaGxpQmMrNnlmSGdEc2JWMStEeC9XZnVlUGI2NFMrNEN0d2NPVnA3QnVR?=
 =?utf-8?B?L3NNNlo0V1o4ZEUrY3dXYXg2OWRveUgramJNQW1obVFiMlhxOWNTaWlQWEFa?=
 =?utf-8?B?a1Y0YWJiYjF3ZEZhWW5TRnZqdDdZbVhmcmdqNThmcjBXUEpKTXVCaHJsQm1x?=
 =?utf-8?B?MktZaTBXd2kycHZ2TXJJaGJDY0c2eDQwSWNRMkk4eXk5NENCVlJSamZkQ0w5?=
 =?utf-8?B?VzUycmZiWFd6UEVFbC9OWlFHcy9lRTVWN1FDWHp2VHJRT3BVcmNFVWg4eWJj?=
 =?utf-8?B?RHlIUU5ibXZzS1VqVWF6Ri9RdXhQYVcyOWdGT2UwYzhtSVVqbUdxbVM1M2RX?=
 =?utf-8?B?MFYxa054MHp2SmhrL0RqMG1vUVorM05DK0hkU2Z0VUpYcUE5Y0dmYlVFYkFF?=
 =?utf-8?B?cGFrTG5FcjI5dU1FU3djZVpHQkhUQjRra2s2ZHFmM0JZNmJzb0l6c3l0a2p0?=
 =?utf-8?B?bFdnMzBGdmVPRU8wZHFxb3R3YUovZEJmdjZlSWg4ZGowRFZET2lpY2tJVk5W?=
 =?utf-8?B?a1krQkxFYjRlRTBLMUNJanByNHAvWHE2bSthNmZ1V0tQbUNCY01MTGIwSGM1?=
 =?utf-8?B?WEhOdVE5dVhwQU1TancyL1hoOU1kTzdoZEVEZXlBRjd6anBGUWFLOVEzd2w3?=
 =?utf-8?B?OWNiNkppM2dvMXkwRzlNRk95dFBxR3p1VWdyMkQ5bkZ5emVGajZvVHFrYk44?=
 =?utf-8?B?QjQ1YTJmR1h1cGc1T05YMjA4cmN3RE9rL1FwRUZJOUFyQVozYzl3T0s3QVp5?=
 =?utf-8?B?bWNGVGdnSTB5R3RERXFEWnVETU8wbkpJWDBrSGZGemtJWEVOcWkzWEtpejgx?=
 =?utf-8?B?UXlndFZoUFN0aEg4OWVjczhlZUQvWExLbGRKV2hidWhvbzN1UG00TmQwV3Yr?=
 =?utf-8?B?ZDJtK1VUWEsrSjI5QUxMSlFwOTlxbEg1VVExOFFJSlVIbVplSU9FT3hhYXZp?=
 =?utf-8?B?eldhdnQxMVlMWWd2b0ZYNUxRRDFrQmtqdTFSWXlCU1ZWY25aUlV5eklVaDB5?=
 =?utf-8?B?ZE9jYllTWWxXSUlycDFhWDlmMmtueS8wN2ZGRENrLzZCRWE1VmRGOEE1K3Rv?=
 =?utf-8?B?bGpSVHBHTFZlK3hKekVicFZJSi9JOTFhOWw5NUdWVjZ2SXhMa1VBTzJrV3A5?=
 =?utf-8?B?ZmFGZmMwU056aEpYczFsTFp5V0kyVzVYZ3pJQ0gybmJNNGFoL1VaeXcyOGJv?=
 =?utf-8?B?cXBFVFhQWi9PY2o5aTk3elNGNGZMRVN2TlI5ZVdtK0h5bkZDUUJNaDRZcFlS?=
 =?utf-8?B?cW1leXBKQThTeUptcXhKNndCU09FUmMybUZXRUM0ZXNWZFQwUXJwZ0RQaGhw?=
 =?utf-8?B?cldTQjQ5WVJ5ekN4Z0NPQksrQitoRG1KdDN1ekhRc0QvVlVYaGhDcm5nNjJl?=
 =?utf-8?B?aVdPdFNUQ2I1eGhVUGxnbEhheS9GOEFuaWVDTGVsdDdGU1BybWE2RGxTejRR?=
 =?utf-8?B?dHpqREFaUlRyMkR4c0hudzhMMjZFanAwNjNVN09sOVJsdTgzelVGZm5nNVpn?=
 =?utf-8?B?K0RzTC9WVHA5Mno2UGtVdE1UMjJFaUIwQkdGKzNNdVRNeGszelZFbG15L2t0?=
 =?utf-8?B?ZC9IY0RvazcrOEJqVlR5NnAwZ09wcGl5bWdkQ1lGcEtiSkVvTG5IVGxad1A1?=
 =?utf-8?B?YXVBMGNwbmVKZXBRNkI4MHhKaU5RdWZ4dGdUSmdFekg5amJxZ2dkdFR4SFNE?=
 =?utf-8?B?K0pIN3hWK3lSQlp6NjJPTXRJNVcyUGl1WG1QbXBSNlpNdGo3UmdWcnNCOHY2?=
 =?utf-8?B?aWViYUpDMUJ2dTdqK3VCamVydTFLSnJGcitCaWo4NnYvaDBDcDVJeXR2QzdH?=
 =?utf-8?B?YWRzSEJGNXRVNXowTEFKUTdJTVVYRmtoei9KcEJCbjhQZFRCV0k2Z0U1UTAz?=
 =?utf-8?B?VG5pcFRMUDJXR2hrb3JZcnNBZndNeC9laXZzS1pkeFZ1aDhTWFg2Q0hvNmxM?=
 =?utf-8?B?bVZzdGRuMTJnVXlnSGwxR3F1cXA4UmdVb2JMZTVpNFZ6enZNZ3JSOXIwNC8y?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qqdfvaTVEz0tloh/NewjT5J6GnPqQHcUe9+WUS++9lcOsR9CqMZ5SbUa9wK5li9Mt0CZYOpSk+iY9vaM+FtsNgBSmlERzc/G0cniT9OUcT9yiz/72tvxV5MTDrK7xfKSdvtwfU+jucZ+IMvZELZRnzQg2nHIodt9ZrpFgiNJKz+CMIqwAKSSMbbF6WM4gDIG9d7QGOFZXVp0iQtaZ6qMYbcjg2T8KXaCZMT1ZSLpRxHH6RcSEmTr2qqt10JSW7B4ZvI+EwdZS8ENJ9/mzoTFZnlADS7YZwjnB7Q8O5QsPtWLDFR8b9pL9AsRT3Ofn4ix5Uq+KLjR8jbRBBAT8NWp7Wstw9rAka27t5YvREs9k/ZXUIoEb3chpVbeFr9tczuWyBD5OM6jNy6FhRByWgVOaV0iyfACdz+pYCbIEDD2ynpBGP3rQezVN4iLG0LZUv5nlb3SJxZoKRr+X1myO1vs2T5V6mijGQBAghmrv1cdZVsCqxjAR/QmPEFb1lTTQKmsFstLfPr2D0TeaQiwtQP9U7SMMvYABPhKpclRM0irKdhh3lBmdA5QTDpp6WRqiP8FQewKkb+S2tjckX8lYMgJELe4xL3pum7qh8riTwjA+ixWMx3naJOlWPC0uXT4E4LyKD9T+lzrYUYQx/FmvA486g/dmkVO9SqJvpg2SWp+No99uHBiqM7N9es9Q4tmcOXtjCZ8EUWDtQz1SaMRp0AQr2XmRCMNVoauzwcTsDoIWz53b3tUeXyrS4B5Mu7M0dESeT/RMNSkgZlUMkxeQzNFN/ACWK1FXMZHTBcwoN8uwD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ab83f4-6988-4586-d4a0-08daed65a7d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 08:36:49.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeZWagfqBca/kWKGxa0y0qIrQCFnwzdo6I98To6+QXGOmPrk4Yk/eZd0IUoGP9ZBExOt7LDkQy6+3M2fQCJgJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030075
X-Proofpoint-GUID: HOpUFfuQPMcZopmPpXtPd6MIdDLuKVhw
X-Proofpoint-ORIG-GUID: HOpUFfuQPMcZopmPpXtPd6MIdDLuKVhw
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/26/22 09:00, Qu Wenruo wrote:
> There is a bug report that commit 947a629988f1 ("btrfs: move tree block
> parentness check into validate_extent_buffer()") caused some fs to go RO
> under heavy write workload.
> 
> The full dmesg provided very little useful info, but surprisingly if
> there is something wrong with the tree block, we should got some error
> message in validate_extent_buffer().
> 
> However this is not always true, as there is one missing error message
> for validate_extent_buffer(), tree level check.
> 
> So this patch will add the missing error message for
> validate_extent_buffer() to make later debug much easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   fs/btrfs/disk-io.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f8b5955f003f..3421f06eade3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -530,6 +530,10 @@ static int validate_extent_buffer(struct extent_buffer *eb,
>   	}
>   
>   	if (found_level != check->level) {
> +		btrfs_err_rl(eb->fs_info,
> +	"level verify failed on logical %llu mirror %u wanted %u found %u",
> +			     eb->start, eb->read_mirror, check->level,
> +			     found_level);
>   		ret = -EIO;
>   		goto out;
>   	}

