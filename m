Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C47824D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjHUHsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjHUHsL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 03:48:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F792;
        Mon, 21 Aug 2023 00:48:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KNcjdR025716;
        Mon, 21 Aug 2023 07:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8caxFghoOKBZ3Ae8HSfu2K9opIKiCC6PX+4qiPT+vYc=;
 b=O4Jfs54gglxILIZ2dI3YQ9q9nRLS84s5GbIFAIZECYe8aGMJ9BihcsAI+ys+gVQd6qnZ
 B0mIK29T2FSmB0GtdaLaJ6DwHzxB740GejFTBIL9XE7dR8wbXKAdKxsoT8RjA/XFURr3
 isuc7TPhR023NMkr4UYt8o1WM0ChzOUck48fmizP81yIMDHpHfmIRUk6dbbfOOXA3Gay
 x/pF0O0VCGI3ZUgZHnAncdI1c8YcwxZZ85+n8QjnbZZ2GxSuEEvPFho5A+gn4Vx9TcU9
 2DOav4cq47wsL1/C73/tcZBHHI0R0u8Td7aZ5b/MEBcf8dQH+6T7D7nV2uSNG2MY6b6g xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1tadb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 07:48:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L5e5Gk017622;
        Mon, 21 Aug 2023 07:47:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm69m0xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 07:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjfrZ+jkGst1/D8DA6kUHMTNyYByW420aHH7if08zcawbW8ISNVyJrXFXn04u3NM+iOCkbnF+dNJvbR60yWaHAT8OCc2tB+0w9wC+H5uhxYYIRy2EsLviYSH1WwXOgt13mVIO7+t1lgi7h6l6GYzmUOw5p8FjeM6XoeJTozUjD24jCBGj9Fit+/2npIuA20Df++u4eTqD9OV72T/ve3foBDmmDet25bdo2PSzUvZ37d3OYiOx6b1+nt9eBh807vyOIFXl4qgOSGrmhC6Sf1BmyKpHLwxMWHSbdQ65yB81pzynJr1nR9fngGt2I/j5s1DO4Vc8n+Arq/+w+HIBR20WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8caxFghoOKBZ3Ae8HSfu2K9opIKiCC6PX+4qiPT+vYc=;
 b=OCV205zhcaBcOb/+xWb0eEsFYF/zVy7rq6vtIbS+RZC+1HvyHmGuZo/1XepTPFugvwvLgKwcm4z+33GbrH2RcBlo4GzByvFso/a20ENEevzU+Kz0F+yQPePBSkoRGBqBO2Fyqyc+GMHXwi5gh64X9EB1q4hxFNIJ6tyBFdEaTO6yb24rr/Fif66NTuhGh5oUs4u3vQjkJ8TBdVfgaYBuFQFEGvh+u1nZWJ8k9lqNqEEaBZqLIGoJwbGkPQq2afCNL0gFBnDlLNE0B+64SLmLjRRtuEJ+qnvmqpSzLRNhdkVsujSdqOr3ZQBo+Z1c2REUAyOQipLWhG/RBE/IK5yisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8caxFghoOKBZ3Ae8HSfu2K9opIKiCC6PX+4qiPT+vYc=;
 b=gHMqUXYsRir1vBKmH4sjyY6CqK8fTdWlfZbZy89qDj9g5RPO8T/pf4l9y18Pbner0s4WjHenFQ8rU3ijRXVZ93fJl8HCwZrT0s7B5PaAiU7Jr7y//z4BVYYxXrrKTw8uBh6xpWNNwzTq6BBYkEEhm6qDcqtUBAWAOxpw3NO2K6k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5401.namprd10.prod.outlook.com (2603:10b6:510:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 07:47:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 07:47:57 +0000
Message-ID: <8c687b36-0adc-1a1d-72e8-25806ca72216@oracle.com>
Date:   Mon, 21 Aug 2023 15:47:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] fstests: use btrfs check repair for repairing btrfs
 filesystems
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com, ddiss@suse.de
References: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
 <20230818151346.GR11340@frogsfrogsfrogs>
In-Reply-To: <20230818151346.GR11340@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd6a67c-8fa1-4cde-37e1-08dba21aef98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZD97+fxBAka/IVyCK30ip14NDipXxqjyN8hX2rz/FJaguQjAa+ZYzJpHAtQtszkfHtGrOhOmgpzqEjMeczbrn1nseNLYlxPIMbRvzcI1bojNFVejT/PQCGRe3S9IMe95K0YqVf+qBZ1Yfgy/rANi/fOJ57jYVNEXyJLnGInpo3wne5YnanXkf6jDCU13FsV8Iyo0iAaXjJQmNS21W/3wkYBU4xz8UiejenWmrub3JbgEmTwdySLgrts1rjV+CEj1eXe12QDLKixJz0QXDy4HPhIdU7s6y3itnkCCU888ruYAnKbWH8yxsrJBTPGlaTQWsBosfp4zQzqDGTNXkyvGcPcRqHWugGycyOZEPO4J1OAaWxtF8bvxt9rJ5HadwufyN6VO+DtKqn9e1qmF0jsR7UznU21fDROCMF599TwFg26EJZ8UTU2qSNbWyRGASIgqtML7UEf67SdBrqaDFqEMsrlYG3xQ6Vcb6yaZR60btEiy8B2rgke1dSmXtfz1K6FwLdaKe8aaO5di51S0cFGq9JBsIW/XqBwhbWkhaSpJUpzTSups878JpnXM5cTelQuPiTam4XSf2N0hPUeGMj3JrnFj3fopYX7rCX8S1dta6GdMgDgrsmMc5a8dr29318q5nH+Ss6sVhRSzvS1DnCXzIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(66946007)(6512007)(316002)(8676002)(2616005)(8936002)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3RQNW92aXhiTE5FUjkrbHVWZ29IcnNrelQ0NEFHWGVGdDFBSDY0Vm4xcytS?=
 =?utf-8?B?Z25MdzVIWU9aQnVnUTJxTEY5NHdWUmtFcE1paGtxYWxmWCtoL0dIS0ZpeUNa?=
 =?utf-8?B?MFd2aTFzSEF1SlJJTUUwU2NMREk0MjZ2SXdDY0EzWnZ0czRkeVlGNGdOTzJq?=
 =?utf-8?B?OGVhUnhwNEgrSzZmMks0WGtkWU5ncjFNS2ZOSlZFb0VqR2FmU0ZqK0NVMXdK?=
 =?utf-8?B?bnlhbWErNmlWTVIwOFhpbVM0MDNZVVRvSGhINlNsNXVHbGRSZ2J4OTNpWmVj?=
 =?utf-8?B?U3VBRzZ6c1lQOE9nRUtsYVRmOEZXVWdRRlVEZ1BDVlJqdDIwcmM2aFRNQ1NP?=
 =?utf-8?B?MG5LKzBCdDIrR0lRaDY2dUpaOXJiQmQwMElFdjJZVDd6ZjhFRGFKaGJBenV6?=
 =?utf-8?B?Um1sMkUrU1FnaHlXTWVMUm1hRkpudE1uV0h4VDFTUHR4UUFjRC9zMW9ZcklU?=
 =?utf-8?B?OXh0OTRnaENxdVNIR2doYWY0OUJnWUNScENjUDBQVmRXc28rT1c5dmMvdFhz?=
 =?utf-8?B?VWl6MXc0MkZFeVBoNnVhK0twdDBvZ2tuNGVZdjlqbWdIUE1XRmU2Wlg2NzNK?=
 =?utf-8?B?VkpCZDljNEdoN2NkdHRMMC9TOEtyRmM1WFJySmhseGtjdXlObGtIY2ZkUkJ5?=
 =?utf-8?B?cnRMMm9hbW1NdGR2RDFLa2tMTlNzZmpxanJqb1BhZTMxVlVjV3o0NDR6c2NH?=
 =?utf-8?B?ZEpNTGgrZEpFM2Q3c1NLSDJNNUYyU2s2SWxPLzh3am9tei9PZ01La0RiRFl6?=
 =?utf-8?B?VlEyNXpSZ0NuMVByRUo5M1M4NCtXeXVDZkMvaUNVeGIvSEx4Z2pMRVdqN0JY?=
 =?utf-8?B?eWxpSFBhUVBmL3JnSHNLdC9IT0E0ZXhnc0dxNjZIOXpJelNkNUJqU0dFM2Nk?=
 =?utf-8?B?alVRMi9tNzgwZmdBREhpeUt0c3N4Q2VXdVhPTGVKN21zWlB6R0R6blQ2NUQy?=
 =?utf-8?B?bXV4M1VYNjI1SjBONk5XMFRlSkczcjdKYmJ5OWF4amZENHU4dlh4RXdOWlZD?=
 =?utf-8?B?YXlHVEpYeEE1bG05UGdaZkFGYThTSng2UWtHQVU0dHpMekRtK1FEYmp2UWp0?=
 =?utf-8?B?VUdPeUZoem0vTU1mckZkTkk2TVU3THFZSnJpbUlSTjFMME5WZnN0bUNxN3FT?=
 =?utf-8?B?MnpjN0FBZXp5NTNVdWFKNTdDUVNrK0NRUGVKdW1melViWVZ1eUNEOE9WYVBu?=
 =?utf-8?B?OG9vU0pNVTd6WjErY2N0UFpWLyttcFpWVDlKM25rbjVybGRDUktkRlgwYWJ1?=
 =?utf-8?B?VWJzSXprQ0tnZXFMVGJwdFpOUmZqTDdRNlhXTkg5MlhLa3p5TEVGMlp1aitI?=
 =?utf-8?B?cGRMSmFlelgrdk5yQkdPbk9IWTFJMGJwclo0MWFIUmV5K3pTcVZoOGVXS2Zw?=
 =?utf-8?B?Vi9uWGY1SFUvY0JheW1DT0hCbUJmbTBaUit2OTVvU0xuUUgyb1BsY1g1UHMx?=
 =?utf-8?B?YnZjTHNrR2xFWUVJKzNaRk9lVnJCdXZTY0l2dGVDYTd0OGF0UFVrY3FQb3hC?=
 =?utf-8?B?Q25OaGlnODNXRzR3UDg3QXV5MHU2QjEvb0Q5NkdZMVF2NmJPNXUvVm91QU55?=
 =?utf-8?B?UTdBQjdHbUJ4VTJOUmkwaUV0amRYV2I3bHM1Y01zeFRzZi9USklVbVZwVUJn?=
 =?utf-8?B?TWVpVCtRdFRlaU5sYkRLMlBsSVNRRDlGUkUrdlVtbEhHTDNZZzJoWmJ4Rzgz?=
 =?utf-8?B?MGNaQldibXVuQXVWT0RMdkpWalgyWFJLdVpDRFlYTWlJOHQzcktuNUZINkx2?=
 =?utf-8?B?NjFiMTB3QlBJY3c5K1loSlZzL1lZdkVkZjR2Y3ZSaVNPU28yaEhEcml1RjB2?=
 =?utf-8?B?TG9ZVGdTdlFIWHArSHlCZ3ZmaW12VTNPakk4d1Z6SkJtWDh2YzdzR3Rtdko3?=
 =?utf-8?B?YUxncWVpQmNXZ3NZUUlkUkVzY2RNQitGMStvM0MwZlljNGM2ck1WVndzYVdi?=
 =?utf-8?B?UGgzRUx1YUpubmlkSXRJSHJOQ0tsM3ZBRGpDTWsvcVZ5R1VMOURkcDEwLzBw?=
 =?utf-8?B?eDJDeDhWYytuM1V1VlpITGZmVjQ0VEhmZCtrMmVTWGwwZzJYZXI1YkFHdEd5?=
 =?utf-8?B?OUk5dGtQRFRrTElubmVGZllrdUowbVpNQ2FsNWV2emZ5eEdPRmREMHBhV09h?=
 =?utf-8?Q?U4F+tXmZGcHdETM5Iqh67BKo9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ibmb5fY9VV7+cfdguRjlGxiWO1Zw55FfFKleo5ci4XwgPherT2wTQd8JXxfDUShEXLs7ozE6tAeNayHAE7j+iA5O8dwqCIaa7nkeEAI0xZhmhfEQnQxXfYL1XjR5OEksO/7/90889s3OU1uS6g/bBy0Rp2vTv7Bu/lFFEhN1ULxDtHRfm0j1I/JVSZdRV/ebt81OBLa984cBBDLRWDF2hLQ9E3v48lv1k/It8UIwtd/YHB2CynT/p/rlnnLzFWnxb//0SI6d4MVBwxokppgxqAU+PtfnYzLVl5Ow4Gt7U24ZxZYl3NyCuNg0BjCLYTPNUpsJ4SxYFuTGtmepjJHlM9tlv8VCl4oFQC0Usozl4saFIrl7WP550kMCps+bOuYdG0W5NC259CyOQTPlUhRFpU5mRPjq0zPrBMh/aehnbsO+AvY+Q52vtt9pxj2nnOGXkSWIbYdCGkPiR8RDBJQvvBb0DUhgFi7e75HIePEJW67ftrVM7Gen/WBUglFu/p5AhoYDML+whyrubN2YEMPSNG2+NJGYa4Z+R8DV2cfXrCaN0ai3mHisMkL3vBPDBTfCXe9ZRzIyYrRjVAqbZCRQ/cCrX3NqI/fvGkPc4BgRmc5CrCdh4rvIxvFcKjRQ2xr2WN17Cz1uU7RrTrEWwt1pZv5j/tresrDSJXy/TWcOWmsmfLrk8g8rbZKaCZ8Z/f4g/EjZT5GqL/tdDQzY9DgCVOyGWyxcCJGt2kdQh5Es5x9SG9HBJtV+HJ3e1UIe3SranvGRC+XVmzIHnS2L9nyTnK4+X2rhAv4VTHcd1W0I0OqJMTO91AvMyRcdTujvTqqe4+3mHuD4lXvGFOfWE16Sg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd6a67c-8fa1-4cde-37e1-08dba21aef98
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 07:47:57.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3oWAfjmyiZREH5Zdd1mwGothUqavpiX99BYkOQcn0NH7FDyeVR9WPxofnMt8tGVVnyZf4AzXJ0X2Ksit1WN/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210070
X-Proofpoint-ORIG-GUID: 9d5c0aBveExz9EOa5oIjZOwIOUs7vjup
X-Proofpoint-GUID: 9d5c0aBveExz9EOa5oIjZOwIOUs7vjup
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/08/2023 23:13, Darrick J. Wong wrote:
> On Thu, Aug 17, 2023 at 11:40:04PM +0800, Anand Jain wrote:
>> There are two repair functions: _repair_scratch_fs() and
>> _repair_test_fs(). As the names suggest, these functions are designed to
>> repair the filesystems SCRATCH_DEV and TEST_DEV, respectively. However,
>> these functions never called proper comamnd for the filesystem type btrfs.
>> This patch fixes it. Thx.
> 
> Heh.  This sounds like a good improvement. :)

:-)  (btrfs-progs has eloborate repair test cases.)

> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/rc | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 66d270acf069..49effbf760c0 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1177,6 +1177,15 @@ _repair_scratch_fs()
>>   	fi
>>   	return $res
>>           ;;
>> +    btrfs)
>> +	echo "btrfs check --repair --force $SCRATCH_DEV"
>> +	btrfs check --repair --force $SCRATCH_DEV 2>&1
> 
> Should you allow callers of _repair_{test,scratch}_fs to pass in
> arguments?

As I searched, no caller is passing any arguments, so we could
enhance it when required, IMO.

The _xfs_repair_test_fs() function is not found. It looks like
it needs a fix.

Thanks, Anand


> --D
> 
>> +	local res=$?
>> +	if [ $res -ne 0 ]; then
>> +		_dump_err2 "btrfs repair failed, err=$res"
>> +	fi
>> +	return $res
>> +	;;
>>       bcachefs)
>>   	# With bcachefs, if fsck detects any errors we consider it a bug and we
>>   	# want the test to fail:
>> @@ -1229,6 +1238,11 @@ _repair_test_fs()
>>   			res=$?
>>   		fi
>>   		;;
>> +	btrfs)
>> +		echo 'btrfs check --repair --force "$@"' > /tmp.repair 2>&1
>> +		btrfs check --repair --force "$@" >> /tmp.repair 2>&1
>> +		res=$?
>> +		;;
>>   	*)
>>   		# Let's hope fsck -y suffices...
>>   		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
>> -- 
>> 2.39.3
>>
