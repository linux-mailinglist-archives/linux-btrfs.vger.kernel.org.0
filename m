Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526F87B3FC6
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Sep 2023 11:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjI3JqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Sep 2023 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjI3JqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Sep 2023 05:46:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDB193;
        Sat, 30 Sep 2023 02:46:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38U3OHbV003773;
        Sat, 30 Sep 2023 09:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NKxRgfY0O6mZha9/vChgWOtIIQKAzDFTWK4XUQ2RhOM=;
 b=QzZmY45uWyBqOBGvm3HlqCCIiNil8qOTj/GoZie+5QQWUxcmLaitzhse0lP70rm6kixN
 OZWJ15ftdey1GXaIMGjok7Vx+FINCZlJAMcV53xbcoDb8k5fZdtfhTlO4qq+RrASpQ7g
 YQI8AinxuRRVvnGF/konYCwJcILRYLUt/dpuZT5Vv6xGUMR5KOBPDlJewW+cJIH5Nb5E
 mB0yO2E/Ahc5q7W1Q47a6WQlaY8JQE84sVczCFmwy1VH+QTzs17z9f0mRfUgNBMzTkYT
 xJN7+ZsXkgH1aTiEPyEA005u1dG3keRhRDovIjOekiMsIl2H1DWh2pbs9f36CHVRWIcG cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdr9pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 09:46:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38U5bCuh035742;
        Sat, 30 Sep 2023 09:46:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea431y0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 09:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCj9qctZ0i4CLHv2mVWXf5rtQfoujobpjmQLaR0QIrfhkFcYpxNP4r+une9Pqia0kQ0GeZ9l02YqTuuqNi2MZKKQ3typIH7sjaQ1T7bdXVHVIrRnc1K9gZz3zZ4UgLJa914lUwIy2Mvy1G5IEV3gKojmoyU2lIzPhqEbBj/SiABWm9sv541Y44piGb484tzSybKaSVFjNH1vkNsfMrpMYvZMfypCmPDPDwabD1BETsOJHvdLKI3BTIEj2r0UXB67kZiChETFgErdfvgeELCGb0ifYYbXbBTBrihUYoqpWxD4ve1komRUUP1+fSvCaYq9Twupwkd/OY/K508RXR9dwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKxRgfY0O6mZha9/vChgWOtIIQKAzDFTWK4XUQ2RhOM=;
 b=CnOmpifHPcpLR/KyyUB24dMph8q4gmahcbRppioA7FyRLvQTl+ZQKBp7JOUgmjA/CmQbZRqBRJBjXumt7srTl8rtB6UQQ+uSSP1GtctSVv/mOWOs46zsiUg9ih3YAm+tJftTz0s5uxS/G59SzCqBe6Dk41yaUpFeC+KKilxz5wmWhaVVxHFHrfAjgE1jMusCn6Ufp0BpsOJ1c/zw8Q45G27OsTfuRsQShthgYj3/yEo7fIDNPJFQ8MuxJoyw1mgRc7kCOMj1rTFL2Gut9HtrakZvmAd+7vjzEtojEslgdFxcXCo43QR8N26WDkUj5NAykt5mRjfeEouYdLZv3KYu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKxRgfY0O6mZha9/vChgWOtIIQKAzDFTWK4XUQ2RhOM=;
 b=xWh/D1qntlCz7rI2uXNo7G2JdGylk+W0c7Z/NG+Eo9sgEfnX+GG/YDLN762OzRb9kZqTq0lf1majsocOsQkPUMNMDtLAl2n8ZicPhFCPlF3/OCUo/fm2cuXK725ksEWvlbfrqEv3rRq0/uXT07WwiqMLviwLveSuVgV3iqBlS9U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sat, 30 Sep
 2023 09:46:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 09:46:02 +0000
Message-ID: <59124721-0e07-7b5f-d650-d58d9ce9fcb2@oracle.com>
Date:   Sat, 30 Sep 2023 17:45:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 0/6] btrfs: simple quotas fstests
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1695942727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1966e9-65e1-430e-9101-08dbc19a0ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eU3RunJ4mntz54ZMJz1XkzxkLD2rqPDytUXMzmiO5NHzqKL8uXzUnXM9yGmvY3B2ql/ruz/1ZsU1mJdnc/MQAIA1CmFzwquR82wgYwMMaHKQcXYLdYrJUYCZWSCeCXOuHPM55df6EdErWs6CGVpzWWs4pbrWqc2ttkqoyIa3ZDedrqxwB2o12SsRe3xgsfNYrLYg6Du+MqAJshdnSFIbxXqiv6zQ3dlhZttZbECk8ubdrdG7X4/30GRDjdS0+4j5XlnK2V8VNVgHBuSMIn/muDi0Tdt9xH+dJ1pPAUlywI7s4lqXBgaYrccQIvYUXCe6I764faJzQ5zuNRPOf5QyVaNCvjGDaLzW/IMNWgUstm3l4bY7I3LpxF+MH8+QNIwIaFzeN54mEolZ3JkBGo3eVh7lprkMVmcMJZCEy9ebU3KCYq89FOKVlnfQYAVuVoy4A3Z9K9Dh09iq9CnJQuof5pVkWEHvSH5T/mYT+Lw/kTKhHG2YJlt2C/FzSFaNhs9GBZS63f6bh/4gZygXfYncq8yGR6izhA9ahVo9nHyrWI2DpsVu3peGMMu+imKyPggcJQXgPsFZ0HVGg5vlCghExhIHWQ8Vk1PGWLOVIfxZyLQFOtYPPEoE7Qzp4BKJUZBABLAvKOBeSw8AX2MlWPGogJ/NMSMmR6tYokgvT/tqoFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66556008)(66476007)(66946007)(44832011)(5660300002)(31686004)(41300700001)(966005)(8676002)(38100700002)(83380400001)(478600001)(31696002)(6512007)(15650500001)(86362001)(2906002)(8936002)(36756003)(6486002)(6506007)(6666004)(2616005)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFueTMyY3hzM3dRRjA3b2hDMGdzT2RGVXFzd0cwbTdyck1YdXdIQTYzQ1do?=
 =?utf-8?B?bzdjWkNaTmpTb2tQVEQzMFdadG5EQkxHbng1U1hqMnpYSEF5V28xUFdlZmpZ?=
 =?utf-8?B?dko5THlqM1MvdmU0TTNPTmxnVHJ5ekxlZzI5WHI2ZGZLblk5RWpIUVVRNkYy?=
 =?utf-8?B?Ymd0VGxNK3FyQUgvSTRtNVRSOUZwbTJ4S1VqUmhEeVJuRmJPRU5wQit4TGor?=
 =?utf-8?B?UlpPZnB2Y3pLT2c5QTZHdWd0YjhsdSt6amR0c1h6ZHlPdEM2QTljRjJGNVV2?=
 =?utf-8?B?Q3RNeGMrYnFrTmM2MjBwS0ZsV3dqWmtLTmtVcGxnR2ZiQi8vdzZEVVVrRUdZ?=
 =?utf-8?B?UTN1RFVHa3RWS05Uckp1dy9DQWJJc0VNbU5TWFNkQTB6UTBUUkJqQi9qaU1F?=
 =?utf-8?B?TEZTMjJOd3RSeHFaL0wzL0hzbU5jekJyUlpiWFUzam5iZDVaNEJTeDRlbGtt?=
 =?utf-8?B?UCtQYTlpanphcENHTmQvV01wRmRpdGNoQ3BQOWdKVzFHcGhkU3FyemJkRktp?=
 =?utf-8?B?MFhyNndqWFVyNjkyLy9WTGtLb1hneCs5d2daR0xYdU8rb2RuSlA3RlFRYVBy?=
 =?utf-8?B?VEp6VFliWlRDbVpXUHFjTVowZWFQS1JEd2FUeTNEanllbUNkRmNXUnJpc0Jq?=
 =?utf-8?B?d09HNHFXM3RHc01oK1crRXQ1YkVVcCtNaWVuZFk3cGhvTU14akN1aDN0WU1i?=
 =?utf-8?B?VU9Yd1NlaGdnYVJmRDdndHREUVI4Nm4ySzMwVUlYbnNlaWFBS21oVXRKeXhW?=
 =?utf-8?B?aEZFVUI2ampVNXlsS0E2U2ZPTUhocU1pZFA4bXRDMCtGUHFxZDg2Mit3VWs5?=
 =?utf-8?B?Z1VlZ3pvMWhIRTRVQ0QrSXF0U3FqSTR1TzUrd3JJUDEvNU4zRFRSMGQvTEh0?=
 =?utf-8?B?UlZMSE1FWXVCdnB5SmlGSTg3ZlZmMG1zTjRMRzVBTkpvTC9kSGdLaC9PVDFt?=
 =?utf-8?B?b3FSS0IzV0k1cHZhT1RrcjV4WmVQQ05yWXJHbTV2cVNHdE1NQXFPQmxBc3Rq?=
 =?utf-8?B?NTVPK2Y2aFRpMFJnaGYrWCtmSzVDRVJuVnB3Z1RXdjcxWXZpN05iUDJEdkpQ?=
 =?utf-8?B?LzZWNzMvRkpVckE1R0VvVVFNTU5hWVZwdWtoS01jT2Y3Vkp2aXJWVUVjcFZG?=
 =?utf-8?B?dklkZUFCSFhQU1lBd2hHd0lBM2QyMThNRUlwNm55Y1Z4NzFxREFyU2hBT0dh?=
 =?utf-8?B?WStlbnE4alp2bTdqUEYyUUVia01nZVlCUlhGNlExOU9oTjA3VlI4RkdRd0x6?=
 =?utf-8?B?Zm5ac2ZIYnR5UndSWHR5YldvNHBPUVNXaGlOVytyVE9RL01ieWpmU1lYMVlB?=
 =?utf-8?B?VWNlZFFJS2pYNC9QMjk4WVdjWituVTR5WTFtNkN1YXZBZUk3NUU0ZE05YjNq?=
 =?utf-8?B?aERhVzJCaEduOExhRjVwempqTFcvSW52ZEppN2FUdU5wY2ZUMUNyRUxoZVhs?=
 =?utf-8?B?MFk2dktUUHpMT2NwaWx0bjNwTzVqQXFRYzJqVmRoRGVzTUNPUUVralA2Rk80?=
 =?utf-8?B?OXJ0dmdRL0FuZHBpZ1JENzRybnprSmR6QU8xSkdPSkc0MCtRWTAwaEtCcHl4?=
 =?utf-8?B?S2oxY3p5elE0elVjSW5NaHZKQTNIRWg5K0VaNEgzL2pjMDBLVDNidFVnUHFB?=
 =?utf-8?B?QXZCa2Y4R1NkOFl3bkRTVTc5SFg1TW4vN3c4UkdnZy9MV3JKOFJZOVFCUC9U?=
 =?utf-8?B?REg0Qms0c1lybW9tdklQWndNbHo5TWtIYThlU2x6QXV0clpEdVB4RnBnZHJj?=
 =?utf-8?B?amlDQ0w4WEQxSGg2U051QWJOOUFxRHpXVUtvUk1GbGNsMzJpci8xWmRsQXBB?=
 =?utf-8?B?K3ZIRDZUalVQbjFKMWZ0OU9OamlQQjRPMW9lWU1WbWJDZm95MWpaeHhEOGd1?=
 =?utf-8?B?QzE5aFNsN3hkRW9OaFBZVXE5MmZHRUo2NWZHSkVJSUM3STVGdzIvNjFZRWxK?=
 =?utf-8?B?Qm4zNTBwdU0xNEZoYjBTUUNlbmlzRVgvazkrdEhWOEZCZDlQYXlvNWxKTnYr?=
 =?utf-8?B?VXd0Q0VzRlhSb0VveFBFRy9pcHdUdU1oWXMxVTFQUkZSaWsvSkYzYkQ3eWdN?=
 =?utf-8?B?bDJNcWM1a1lVdzhScVp5TWtWZGpqZWFWdzQyZUttWi9qQ1E0alk5TUhyekxv?=
 =?utf-8?B?UmVBcU5MUHN6WUJzaTF0SCtEYXJvWHBZRUUreEtyN0t4b20ySHdOMCs1MGg5?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yLdmTeJ5HXxBX8ymwvq8NuDHiiCFgmFpkp+LZ6sQ6lgDEl50oLMwF9FzDkiRuHtwD7yb+rsUmJKfjcNm6RpKZ5BP43ZQa+evSE8QzgI25gmpnG5aHB1fHnvJfuhGtKBC9xP6f3wT+sH6ymbjKsnWgj6yPUNfoMZvrqU//rp1TVLrkUtjeksBdibkPtwoyhzOvi8p5p6uVLDYfDP1aHzVpA2r7ahOzZFnGaUBHeRMICLNEBaq1aREgR9A0FNJbgBOdrbvtvsFGJgRz90ZD7364dkDY3kNgHVCK4LUVTHbIstFcYKFBz8pbIGRx8zOBENipGznLSFed87O/iyBeJ392Z/K0PVcyXYV457tsa0qesVQNQfDwIz/DZQBZ3nq0+Qmr4/OO9Q/uPqPz1d83TDSbs3399zOaEYA8MevYW76arQc1yFKb+2ZIGUVa7QDYSWC8Ttj40dHYx9fpWC2X2oZnOiH9vOD9H+riI4Xz3wevfYgU7h9dZJEHsFIPjKd6RFkqtRCBapWO/XTu3dtezVW+Cw3oL9NHlhIRRDRqzrho02nou5N4GI5x1p+DJlthPcLq84K+MPyoiqfRTqUB3GQfD/K3J013uk7Xw4eLIz78mbLOjQTy8ViGAZsc0iNC87aRJEF5L0tZqZwr8Q4AubsI6S+sABxD/B9Aars8eOu1B8cvGSGmuFmAdrF0vemrIgjg1C5SkmXTHAu4OSsVmy67XtH/cx87qmmRNrsEnM9rHj/FQDUgxRySW0ELmwe88msFKnsO072PuYuyZr21DPhhAgBe1odjuDuuj8iYs6dXVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1966e9-65e1-430e-9101-08dbc19a0ed6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 09:46:02.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msPEGwGxCHd3ijENgdQzCP73MVmbpOrlI75NsW/15QCSc4Z0nKL0vlR6TSt70vVsRLabYBpVGICZDB9qPN1LeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309300078
X-Proofpoint-GUID: bf843oV8LabUFzatfZAphWWP-JOmmYdD
X-Proofpoint-ORIG-GUID: bf843oV8LabUFzatfZAphWWP-JOmmYdD
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 07:16, Boris Burkov wrote:
> Add a new test for specific squota scenarios (btrfs/301)
> 
> Also made modifications for passing existing qgroups tests when possible
> and for passing all tests with simple quota enabled via mkfs and with
> squota-aware `btrfs check`. Since this required reading sysfs files of
> scratch fses, did a bit of refactoring to make those checks target a
> device rather than assuming TEST_DEV.
> 
> btrfs/301 depends on the kernel patchset:
> https://lore.kernel.org/linux-btrfs/cover.1694563454.git.boris@bur.io/
> and the btrfs-progs patchset:
> https://lore.kernel.org/linux-btrfs/cover.1695836680.git.boris@bur.io/
> (and config appropriate binaries to use squota-aware versions)
> ---
> Changelog:
> v4:
> - fix rescan helper bug
> - fix broken tab/spaces in squota helper
> - cleanup comments
> - improve test names, add some comments
> - switch to remount commit=1 for forcing cleaner
> - fix group list for 301
> - use reflink helpers
> - output errors to 301.out (and have expected ones there waiting)
> - cleanup "/dev/ksmg" writes I missed when grepping for /dev/kmsg
> - cleanup variable names
> - proper fio/btrfs/xfs_io requires
> - read nodesize from dump_super
> - sync before dump_tree
> - documented all calls to sync
> v3:
> - change btrfs/400 to btrfs/301
> v2:
> - new sysfs helpers in common
> - better gating for the new squota test
> - fix various formatting issues
> - get rid of noisy dmesg logging
> 
> 
> Boris Burkov (6):
>    common: refactor sysfs_attr functions
>    btrfs: quota mode helpers
>    btrfs/301: new test for simple quotas
>    btrfs: quota rescan helpers
>    btrfs: use new rescan wrapper
>    btrfs: skip squota incompatible tests
> 
>   common/btrfs        |  56 ++++++
>   common/rc           | 127 ++++++++-----
>   tests/btrfs/017     |   1 +
>   tests/btrfs/022     |   1 +
>   tests/btrfs/028     |   2 +-
>   tests/btrfs/057     |   1 +
>   tests/btrfs/091     |   3 +-
>   tests/btrfs/104     |   2 +-
>   tests/btrfs/123     |   2 +-
>   tests/btrfs/126     |   2 +-
>   tests/btrfs/139     |   2 +-
>   tests/btrfs/153     |   2 +-
>   tests/btrfs/171     |   6 +-
>   tests/btrfs/179     |   2 +-
>   tests/btrfs/180     |   2 +-
>   tests/btrfs/190     |   2 +-
>   tests/btrfs/193     |   2 +-
>   tests/btrfs/210     |   2 +-
>   tests/btrfs/224     |   6 +-
>   tests/btrfs/230     |   2 +-
>   tests/btrfs/232     |   2 +-
>   tests/btrfs/301     | 435 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/301.out |  18 ++
>   23 files changed, 615 insertions(+), 65 deletions(-)
>   create mode 100755 tests/btrfs/301
>   create mode 100644 tests/btrfs/301.out
> 

All test cases modified here run fine on a system with PAGESIZE=64K,
except for btrfs/153 with and without MKFS_OPTIONS="-O squota".
btrfs/153 is successful on kernel v5.15 (I haven't tried other kernels)

btrfs/153 2s ... - output mismatch (see 
/xfstests-dev/results//btrfs/153.out.bad)
     --- tests/btrfs/153.out	2021-07-13 08:07:54.096971521 -0400
     +++ /xfstests-dev/results//btrfs/153.out.bad	2023-09-30 
05:33:53.560640258 -0400
     @@ -1,2 +1,3 @@
      QA output created by 153
     +pwrite: Disk quota exceeded
      Silence is golden
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/153.out 
/xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)


Thanks, Anand

