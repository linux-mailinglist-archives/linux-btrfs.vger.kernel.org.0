Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFF669528
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 12:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbjAMLNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjAMLMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FCFB90
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 03:09:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DB2Pjp031098;
        Fri, 13 Jan 2023 11:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QYOwyzoclq1Vqq150O0Z3uUDcfYlIiT9YWu+OzEdtF0=;
 b=UEkPfkMd+r8lbQUyQxQz5cl27NpjG+5TRrsctRExeVpUZjvQGNxRM2IGHwgglZEjxUV+
 agRzUoTVl02EonomFqKeP65Ad+CbuBEFxHgJD8GgPFR2plkrqQyqs55iXYcjbhWI0nfk
 m2ohhTWZok9v4WZiiAlSeKZjJStiuVBrfSbq2f/fkiOEk065M5uviW9fbn4l/roz+bCv
 NzIhpL4ndFELfErDe1UEPriQQ/ySY6sWLn164x/znFGmjJq+YjtDFhz2B/x0/h0yQZD4
 ogdcjcBXhGaJWXqtMGVPvFsaX9TuOoPRvrJrmvePlIY3skyyij+G7AyQwZ7ISd2qwtQF ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n362w80ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 11:09:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DB4ruM008274;
        Fri, 13 Jan 2023 11:09:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4s1map-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 11:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISQJhgMyS1em6TQvWFRGg/3AqIBCajC4oo8ML7IhkIgY0Rg9IbS7J8ifzkg+sPYU25svmCHDuvTajafvK9XnsMAM8fVa9hPpDFq6BxFRTB5qqb8UGs+xZHTnPsPl5QAbZqlrUt47gSXjdL5Uc7ffpH2Pym/UIBdBv9F0vOyRkNoHckFLZi9RUeEDa1cdWFpOz4eHigOqg9UCQweifOxDxMAug6mKeLbchgG/g5MeY8OXgR6mNSTRjwL2/HxUoksAARRkJ5dPaxAKQctUSO6wIlFpFYbPIT4jykcuhmhwBGyhcwZBHOr4r7GtmrrTXB9b9yRBEyOMtjxkoA9Bm/orTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYOwyzoclq1Vqq150O0Z3uUDcfYlIiT9YWu+OzEdtF0=;
 b=f6W3KQKslkWGZKWuUFHV8paIZJmpWti0pZgQIJmyYk4B8g56wB456tFmGTrPVpHnVxnabuQSCVPqTo3Coc/Hgcu0VVrVruZDfiuHg56v4zhNG/rKC6fo/SJL0TaAu8XZXBhHkKJh2w93bZkCSdpNitRedYVtR/CSWM28I+5axQ0RH7f2FOZX0e5prZtewHnp9UMLFANVNudHJcv1ZUj5/34TivreWC5fnXyiCMqS7vrZZBl92aLDtN4iYTXqmbAreQxLTcVfHCCq8js9mMOHhqbMPckQ8By+BM3+1x9a7qI67kUAFn07F/Wl2wXvbOGHfqlaP+jzvNsPp8P8RmhcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYOwyzoclq1Vqq150O0Z3uUDcfYlIiT9YWu+OzEdtF0=;
 b=vUyFF7eqEHXAUtwWfQRLdFF3ZnHJTgJ6Oi7thNDPLERJ7VgwRSC+Gg9rTftgnd8mHPQbtcRvzcsebWXuno0Jww6xFmLv5dy3UHDzH4RQzY5dP+k+NS/tR4GzzxtoXZuQ5K3h7XGKo1L4rDrcMdE+zAlItK/KGl8/Za5GqR0bU3c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 11:09:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Fri, 13 Jan 2023
 11:09:22 +0000
Message-ID: <dc5f5d7e-02a4-a476-88aa-95f31dcb4503@oracle.com>
Date:   Fri, 13 Jan 2023 19:09:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v4] btrfs: update fs features sysfs directory
 asynchronously
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <68670fad66f9e112a19c6f0252cb3bf68979aa2f.1673606471.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <68670fad66f9e112a19c6f0252cb3bf68979aa2f.1673606471.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbd6787-0ae8-49fa-f982-08daf5569fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7Ucg7mFLG9QoEsxKscNSukz+QGj0nH757TK845ClGNENNVZLf3Gk3RopotHhtV8YEuXzqOQT9s9eGmayDQIhuwMcVLSsECe79WUQtiwb6vCXUju2l2pGE7amzsqC3uzqAlbS5oFV/fe27RfVgftEeiLayJPDLAqFZnGxsuQN7fs2OcGC1a/ZTHnmvMHiHAqtjvK/SibBlttY7kzHXw8S8uPPsX/aiughxIBsBamjLiNgMHlBNHnx3G4KFvT8tmypOZ2m9v399LWi9fCQvPvORYl8r+/ksKfgwN+2PKRJJSwb3+ToAG7VuLzXQtosWzPj+t2+O+3b5GTqEFnsXWOR10EezZRuVxeJfXslyX3CRv8GDHuPlSNeTNKEed327lWdxJWM72kmVvtsXbv7iEnpNnlCq/QimA+TgPiQI6bwwygAYFgn0AdM8wUOvjNh2JPLmjVkjcTM9cjyTx7yjvlJ0heZPRbxWfzbc/J0cHTwajczpejkfDx+/Js5C+8tlHINUUyffvAzhOuDjFunot+DBdEOPN2pky1Q2zNO6yPBYSMFfTch8UYJhFXXTOaTtXjtPDv+FjNHpI/KhNsQBwSp7gUNhYwqIc9wtj7nH9Pt2Wxls8jwnU/Q7L1B33dNHLoHtnwP8zgx2RrxsiVlwykP7mP8YUjX3HIxhOsuErcrdnl72b9q5gCDLTd27ZXDwr33uIUFZmMK+9jOcAF4cPtD+ZSVgDaVXbhCV06sOV0f1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(66899015)(31686004)(316002)(31696002)(6666004)(6486002)(36756003)(86362001)(186003)(2616005)(38100700002)(83380400001)(53546011)(6506007)(26005)(6512007)(2906002)(44832011)(5660300002)(66946007)(478600001)(8936002)(8676002)(66556008)(41300700001)(15650500001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9GOTFybjdVZlZJeUdZelowTTRTRDZQbjdzSlg4NDZkbkQzV0lPVDNXMnlR?=
 =?utf-8?B?bHBsNXJUT2pIVE5VMWFFeDA3Zm5nQU1ucTFzaS8rOEc4QjdWMDJIbE1ubkF2?=
 =?utf-8?B?TzFxUnZkNmdWM2p3ZlZXYWVNbkFXUUtZcWpQaVpwR3FlVy9VMzdtcUhlQzR1?=
 =?utf-8?B?TVR6UmxqeDBpZFM5dnE3TUM0T2lndTUwRDdmd3pZZmdvVjB5S0JxUWpJd25s?=
 =?utf-8?B?UUg0ZlhJOUVJUkIwL01OcWhDSlJHaEZONFVDRHNWL0RMVWZUeC9kZ1k3MDlH?=
 =?utf-8?B?SHVFVVBLdHA5RkY3OVRzYmZsaG9ERU10QURvR3o3SkZXZzZUY3JHekpROUc0?=
 =?utf-8?B?K0dQSWZqQ0ZtdGExaE1hb3BLNUxHRHhEa21MU0N4a3hpbnNxU09CS0F5R3FP?=
 =?utf-8?B?SC9JVmgzaG13N2tLSGlqMUZCR3haTThFRTVIeGJKTHplYjVMcHhMZUVkQ29C?=
 =?utf-8?B?NFJja2E2dDVXckRRbzcycy8xU0N1dDZjSEdXZkl4VUJsMVBYcnI5aXQ0RzNH?=
 =?utf-8?B?ZTh1K211RmhSMm1wdDNLeEhyMVVFcjl5UGN6N0g3SWQ3RWhPa2VOQmx4NEQ3?=
 =?utf-8?B?NTg4VkpTSUFuclR2V1BmT3pCMXNMc3RTL0NkRnFMSEZDdHpyOXZCZ3Y4Z2Fq?=
 =?utf-8?B?QVhOREVoaDczZlE5ZytDbWp6T2x3a2dKT1I0VXdwTGZWSjRuZ2VCY3AySEtH?=
 =?utf-8?B?LzNUTUlqSUNrUjlaZ21VWW1uMXNtVTM2Q1RwelRiZlVXRkZpbklqTmJHMUZN?=
 =?utf-8?B?YnFaR3daZnFvTXVkQktDOEVldUdHMFh5bmFJWlZIVnYyYUFscDZVWnBQd3o1?=
 =?utf-8?B?ZzE0TGlMN29MdUgxTFM0clRwTHBldEVleDhOcmF6dGp5Nk1NQ2NuWCtRU1RI?=
 =?utf-8?B?VUhzc1dxWHhrOGJVRzlKOTk5alhIUkpPSEs0bkRwbVZYU1FFeHAyd0ZNVEdq?=
 =?utf-8?B?cUQzVzhYelRhQ21ibkJIVzFISmlnbVVLQ0hiS2pXQklhaEFiMDJ5OFhHMzRx?=
 =?utf-8?B?TjFFcVZFemFTM0RWNDdpaWEzcDgwSFgrVklQZlhKTnVyb0x2SjkveWM5czdo?=
 =?utf-8?B?S2xIYWtxWkxsZmdmaGphWVp2VTJmbEZKdVNBVDRrYzJSUVBKWHZKT0YreDRH?=
 =?utf-8?B?dHlUWmNNWnhiUENrSWxnZU9heFJsc0NzWHFIVXR0dTZKdUx6SlhxdW1VRG16?=
 =?utf-8?B?OHJqMnhZa1FJV3lCM2YrNGxvOWZvcDg1SUo2S1dEQktHbFRxTXcvSnV5eGtt?=
 =?utf-8?B?anNiOTB0TGdYQjk5R1I0dmFJNDlJaDBuQkVkZkRLSysxRHZwa1Jad0xPTXFJ?=
 =?utf-8?B?a1JRRVJYUS9NbjhSbUFveFl3cDJ4U1J6dzU0VmdISit0ZWxPZ2VBT2gvZVMy?=
 =?utf-8?B?UlQ0L25ubXBRMUc2NHhZNGtxdzV2WHVDZVEwempRNWxOMWZ3VDZTUmVFaDhh?=
 =?utf-8?B?WUxqOGNDeHI1Zzd4alVrOVB0R212VEJkUlZvOE9tWTdLRTBKNklldDhXTi96?=
 =?utf-8?B?Qi9FcDJJV2Zwd1VYdHZ5SUJDSnNiYllHS25FZTN4amJFeVRlQ0dhVUVXK1pP?=
 =?utf-8?B?N1R2R2xPZUZNRXBYM1BNYVQrYUtVSENzRGxwTzdGM2NxcHVJNjZLbkEyL2ky?=
 =?utf-8?B?SUJ4VFFzVGJ4eTRUU1hUNkt3MkRnQkd1RFB5WWVTeVUyMGt6MGFlcnB1Njc4?=
 =?utf-8?B?V0RGNDlGWkREd1R0d0RnMzFpNkh5cjZpTFpNc0JOYkppTTlKc21RMkw5SHQ0?=
 =?utf-8?B?NDhvT2JkZTdhVFQ5S3J0NnlZekNaRGw4L243SVRDM2Q5b0lZUllwR1I1bklP?=
 =?utf-8?B?bnlrRnlLUVloZ0RkcEZ0MkFEeGxDVy9FV2Uvd3R6Tit4VWI0b2xMWnNPWDhQ?=
 =?utf-8?B?aWJtTFUxdDZwSHFPbTlDUG0rNXVIUjlSQmZIQ3BoNFA4WitWVHNKOGV4ZXAz?=
 =?utf-8?B?dGZjejZPT0IzTFovT0xlSi9rUVhOWFhnaFVrVjZ1c093ckxSS2MzOU9oamdD?=
 =?utf-8?B?bXhGWlpaWi9rYWdmQS9TdGdDSUcyT2wxdVhXVTlaT2UwSVJBb0FFN0JHZGg0?=
 =?utf-8?B?d3NmYm10MjFVTFI3MGFiT24wR2FNQ29WMVQyMzdHNmZNbGQ1akZsVGYybW9Q?=
 =?utf-8?Q?TSb38vdwcpoE7AMsawB7Bpcob?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CyoMplapAATu1PQltqXmu1YZtj0xrWfNgQlsfRaaouMKWVQhCtFxptA1jTnzSyLNIyqZ6QgEw3LRiG4UAaWRZu1k1CYC/p5xMvNUw0YDOG4W+V1J8ju1FTxYIQJnLJ71uUFoaeQOPwJx+5eMRJXpYCn7XZ7oCrQ4Nm0qcsVPSRi+IBShpYxSUvwF09ciwiXbAoalq1cM+MrTvquWfeUDe3h1FNC81TCNSO62xNggIn1nfeVHKRjEoKFc5IABuqFtmdh9nzoqnKzJPgQOSAlxQv+7Gw3QA013/ivls2i7xatQ6UR039+aSx9opMRUpadVTSORkFIWj6Q7lnSUuLV6lwT5KtoXQFMiWotGLbqLkrcoFfpq2e+/couecRJqZ7vI2bAT86+SETKcvl8Wht4CLlUOUNuyIhGoE2qIosQy9mEXxIop8yDIS3o4PEDILx05yzApZdcM6zgg3ecCnxLeYbDsOFbFKWf5qT/zy8wTLXrsiyZxZ67jV45W5IKZkIxGrkReleD/ebzYYKoJm0XdEFGq279rra3iwo5k3wgaIG4xfJfzsTdp9nVoFGd7+aHCyOQ9XKRAcMzuSlksqNRFnjhQTbeY99KUr24FqTJ729lTqvVEaoQb1c82vHlUR553Bp9f98q9SaYHIMeRt+avypitAUqo+RYIc5p44znWXrcqstX+3EZ5M2r38mVikPbnq3dAoRrIyi78E/do/snCVDCXTbrmsY86AXGQ9K5c+s9oDBqHTdp2xRTPTQCoPi/rrwaryBHb4dRHTrNp7ljKY3lbPHl3zKDxoMg3jF3JKow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbd6787-0ae8-49fa-f982-08daf5569fc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 11:09:22.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i1l5sy0xXm681uOwxkIKpIX0Agzt05cFXEWza76Yyx0qnHpxT/7WQ+HNetK2+1Kwm3NYcLXrnf+Pwf5vOMhbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130075
X-Proofpoint-GUID: FuJJyRp98aUKsfhz6p0ljRWKNkdFm-_7
X-Proofpoint-ORIG-GUID: FuJJyRp98aUKsfhz6p0ljRWKNkdFm-_7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/13/23 18:43, Qu Wenruo wrote:
> [BUG]
>  From the introduction of per-fs feature sysfs interface
> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
> updated.
> 
> Thus for the following case, that directory will not show the new
> features like RAID56:
> 
>   # mkfs.btrfs -f $dev1 $dev2 $dev3
>   # mount $dev1 $mnt
>   # btrfs balance start -f -mconvert=raid5 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  skinny_metadata
> 
> While after unmount and mount, we got the correct features:
> 
>   # umount $mnt
>   # mount $dev1 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  raid56 skinny_metadata
> 
> [CAUSE]
> Because we never really try to update the content of per-fs features/
> directory.
> 
> We had an attempt to update the features directory dynamically in commit
> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
> files"), but unfortunately it get reverted in commit e410e34fad91
> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
> 
> The exported by never utilized function, btrfs_sysfs_feature_update() is
> the leftover of such attempt.
> 
> The problem in the original patch is, in the context of
> btrfs_create_chunk(), we can not afford to update the sysfs group.
> 
> As even if we go sysfs_update_group(), new files will need extra memory
> allocation, and we have no way to specify the sysfs update to go
> GFP_NOFS.
> 
> [FIX]
> This patch will address the old problem by doing asynchronous sysfs
> update in cleaner thread.
> 
> This involves the following changes:
> 
> - Allow __btrfs_(set|clear)_fs_(incompat|compat_ro) functions to return
>    bool
>    This allows us to know if we changed the feature.
> 
> - Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
>    BTRFS_FS_FEATURE_CHANGED flag when needed
> 
> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>    And drop unnecessary arguments.
> 
> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>    If we have the BTRFS_FS_FEATURE_CHANGED flag set.
> 
> - Wake up cleaner_kthread in btrfs_commit_transaction if we have
>    BTRFS_FS_FEATURE_CHANGED flag
> 
> By this, all the previously dangerous call sites like
> btrfs_create_chunk() can just call the new
> btrfs_async_update_feature_change() and call it a day.
> 
> The real work happens at cleaner_kthread, thus we pay the cost of
> delaying the update to sysfs directory, but the delayed time should be
> small enough that end user can not distinguish.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
> Changelog:
> v2:
> - Fix an unused variable in btrfs_parse_options()
>    Add the missing btrfs_async_update_feature_change() call.
> 
> v3:
> - Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
>    BTRFS_FS_FEATURE_CHANGED flag
>    So we don't need to check the return value and manually set the flag.
> 
> - Wake up the cleaner in btrfs_commit_transaction()
>    This can make the sysfs update as fast as happening in
>    btrfs_commit_transaction(), but still doesn't slow down
>    btrfs_commit_transaction().
> 
>    This also means we don't need to wake up the cleaner manually.
> 
> v4:
> - Move set_bit(BTRFS_FS_FEATURE_CHANGED) into
>    __btrfs_(set|clear)_fs_(incompat|compat_ro) helpers
> 
> - Remove unnecessary changes to btrfs_(set|clear)_fs_(incompat|compat_ro)
>    helpers
>    Since we no longer needsto check the return value, they can stay void.
>    This greately reduced the patch size.
> 
> - Update the error message for btrfs_sysfs_feature_update()
>    Now we output the full per-fs feature path.
> 
> - Fix the commit message
>    BTRFS_FS_FEATURE_CHANGING -> BTRFS_FS_FEATURE_CHANGED, only in commit
>    message.
> ---
>   fs/btrfs/disk-io.c     |  3 +++
>   fs/btrfs/fs.c          |  4 ++++
>   fs/btrfs/fs.h          |  6 ++++++
>   fs/btrfs/sysfs.c       | 29 ++++++++---------------------
>   fs/btrfs/sysfs.h       |  3 +--
>   fs/btrfs/transaction.c |  5 +++++
>   6 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7586a8e9b718..a6f89ac1c086 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1914,6 +1914,9 @@ static int cleaner_kthread(void *arg)
>   			goto sleep;
>   		}
>   
> +		if (test_and_clear_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags))
> +			btrfs_sysfs_feature_update(fs_info);
> +
>   		btrfs_run_delayed_iputs(fs_info);
>   
>   		again = btrfs_clean_one_deleted_snapshot(fs_info);
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 5553e1f8afe8..31c1648bc0b4 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -24,6 +24,7 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
>   
> @@ -46,6 +47,7 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
>   
> @@ -68,6 +70,7 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
>   
> @@ -90,5 +93,6 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 37b86acfcbcf..69ce270c5ff9 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -130,6 +130,12 @@ enum {
>   	BTRFS_FS_32BIT_ERROR,
>   	BTRFS_FS_32BIT_WARN,
>   #endif
> +
> +	/*
> +	 * Indicate if we have some features changed, this is mostly for
> +	 * cleaner thread to update the sysfs interface.
> +	 */
> +	BTRFS_FS_FEATURE_CHANGED,
>   };
>   
>   /*
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..b9f5d1052c0c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2272,36 +2272,23 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>    * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>    * values in superblock. Call after any changes to incompat/compat_ro flags
>    */
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set)
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_fs_devices *fs_devs;
>   	struct kobject *fsid_kobj;
> -	u64 __maybe_unused features;
> -	int __maybe_unused ret;
> +	int ret;
>   
>   	if (!fs_info)
>   		return;
>   
> -	/*
> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
> -	 * safe when called from some contexts (eg. balance)
> -	 */
> -	features = get_features(fs_info, set);
> -	ASSERT(bit & supported_feature_masks[set]);
> -
> -	fs_devs = fs_info->fs_devices;
> -	fsid_kobj = &fs_devs->fsid_kobj;
> -
> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>   	if (!fsid_kobj->state_initialized)
>   		return;
>   
> -	/*
> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
> -	 * to use sysfs_update_group but some refactoring is needed first.
> -	 */
> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
> +	if (ret < 0)
> +		btrfs_err(fs_info,
> +			  "failed to update /sys/fs/btrfs/%pU/features: %d",
> +			  fs_info->fs_devices->fsid, ret);
>   }
>   
>   int __init btrfs_init_sysfs(void)
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index bacef43f7267..86c7eef12873 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -19,8 +19,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device);
>   int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set);
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info);
>   void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
>   
>   int __init btrfs_init_sysfs(void);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 528efe559866..18329ebcb1cb 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2464,6 +2464,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	wake_up(&fs_info->transaction_wait);
>   	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
>   
> +	/* If we have features changed, wake up the cleaner to update sysfs. */
> +	if (test_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags) &&
> +	    fs_info->cleaner_kthread)
> +		wake_up_process(fs_info->cleaner_kthread);
> +
>   	ret = btrfs_write_and_wait_transaction(trans);
>   	if (ret) {
>   		btrfs_handle_fs_error(fs_info, ret,

