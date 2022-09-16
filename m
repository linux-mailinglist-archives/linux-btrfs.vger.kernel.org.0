Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA45BADFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIPNVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIPNVS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 09:21:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE44A599F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 06:21:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GCv2D8024228;
        Fri, 16 Sep 2022 13:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=854IUD6g2ujWjpwRKvlHkTZvOoohAttc8nrA1dWZu08=;
 b=wcgAKztfdDytxh0pMkWKYcRdcMy8EGQFErEtgJ/QTO8VX+9cTR5wNR3uTmd/Od9H3qOS
 /Lw9Sp3qk1VgPejIRSlE0KMa2MB4CyF81taDl66GVcSWV5zWJXbiUMSMWwd21dW2iOLu
 AcibFPMXNSVLsR/LVAGCS1eUfKFcvnnmqdTCogf2CBWT+hbE1iDhGvP+b+GgxXTlBqOS
 ymvtKVoWBvkW5NIilT9FgK2nGROqR0ivSnBO/BotOzO8LlRQcZe2wptUp5Sxh9GToIXo
 A/ZazrljVxKMzV5B2WO+Y89ayMuv50vJEzWJNdG+cTWEw+i9VyeycYaDGNAs2AUqeoZc NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8x8afm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 13:21:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GB02Zn004232;
        Fri, 16 Sep 2022 13:21:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xf9t5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 13:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYnFsh/BiEogpzXFhz4ErB6jH/Wo/v8zuI+znovfJo5ERtA/hnD+49RJQDy3KDO+YIPX4vDfFU8FEvqc6dUqzXUrzLf+XfHZpQeoz3WQPLw1I35AuhsuWgjGFrFvRHbYEr8iv1zlMsCVZvGoCenjjpLVJ6d0//WOJ6aCuP3/cjK5ivn1t0m5rX0eQJyOSKLhOurwsHzmESLdIjsVO/EhrghIojk38r0NEbQsIMIU7xX6ZA51+FpNQxVwrHtnGqny7TfEE2wdu2HluGe9rrwcZCeoDOrAwhopg2n6jKsdeRXq17LxBQM+dXudlQyBt1ASJmhYmMwvd20XCZlEt9keeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=854IUD6g2ujWjpwRKvlHkTZvOoohAttc8nrA1dWZu08=;
 b=YOCX5hmX1Clk7FWVMz6GRwWYhs2oLn8uG64mbekeiPU5UKD4t4LvDp1rDWnCzu41NxSqKEfaOp2LReTchh4fStvLAKnlL94Y/Aodn0QAE6voVg+bkJ6A9tjoDmY+0etyWI0PB04CY/ibne4VRQAq9LI9yibA1GVb1pMl5X2gIUUKSoRdOfyNQe36U3nwJWMMmZgX4pPhxCQzJ1Ax/ntU3dDGiU7mKRb7ugyUkABKvFEGZNf0oty7YIEFUQja3qTXZbLv3Im+sl//YWiyTusziV5CrR20nMIVL0pxDuVqjN6ah+RJCImn0zmijapN0yNrEAJEk6iPAyniG7dkTMMKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=854IUD6g2ujWjpwRKvlHkTZvOoohAttc8nrA1dWZu08=;
 b=WrnEylqXzNB7Cft2MPq9kKEicUWCuKBFn1gO7XK9x7RF7k0OxIfZos7PSswCZwH03s6Kk5PQsZK+9NWyG2IAcf33aYxsWCjJTduTYgC9E5S0QldeM9KrITTET5uzex8jNp4yRWw9Q2qL8VsdKSN2tYvcOvfUGAfPm9aXoGGxCZM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 13:21:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 13:21:11 +0000
Message-ID: <50904823-cd0a-84e6-acfb-920ca1f03efa@oracle.com>
Date:   Fri, 16 Sep 2022 21:21:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 05/16] btrfs: move assert and error helpers out of
 btrfs-printk.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <c4f2113c748ba79e0e0b19da6fa5bca14b3d14ca.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c4f2113c748ba79e0e0b19da6fa5bca14b3d14ca.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f29d01f-ef93-4c7f-5dd6-08da97e65273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WounL049CbYGAPidfl4NjHySzSKklCdVXV5xPzbd5MDjrGQZIqNA2K6GQKJNIHdTVQxBKisrjtFj3Tud4lhJLS99Q6BSmUO+c1U59EF2RCz/dO8eDIQaYhiSKWKvrN4nfokulqUUe78dlDXQ0bxP7D3fRwoFtYTjTKe29LQYmIgCiAfPjq4nkWdgqUwvD9FgI+eWgwJ22E/DbnjfvsFYc4l8qHWk1xDKyNkag4AIhEB3O1yLd4/ezV/dydIDj+QHvfWb9wvkZLeWSpjklestkU3nZK0y68BdV5ZrXG0ywQn3RmPULREuwEd9LNajbcGwbMOeFcl+IUaHgLZ06HrwG/ryjNRGT7oPATookqN+AZ9CpYKTpaDXn4/Q2BOIzQrF5hwOF0+xn21AEhJ7haeQfaOUtrEqus8owyvFvFuXAT7gPE8AzIuTK/9FXi+j08mnW9DWHRYp+altj30Xf7ZB3qwyeTwU7Jnp2+CN3u02JUNS+oY87OO03E3zpMXSR8AFDyDy+WxJLJNwlY1gwOhgz4i2eF60DtrGxM9B0W8s9qarL3Fqsc5weDn/mi6CgCa6HgB7PRqJu4q5+hMYGgUPD3dBo0g/h4GXJ7lFQCWkiAMVjJOreUjCCBuP0RnpIqoIa0xFUGFtk75JR7jxL8sU3xUBUNOrhcb1bhhRBesG/f+t8nKioXiFmeyjwzQcUsxL2/Nx+Ir8D6jr30eGVJLbQXXhUV0SBqBw0ZBjFuw0/jynVXjgDpqL8NZyxPy5vBrUBcFR2aca6xzX8o3HxNinlLMvVj9iwt0q5kk1zvNNT6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(31686004)(2906002)(5660300002)(44832011)(8936002)(6486002)(478600001)(186003)(2616005)(26005)(6512007)(6506007)(6666004)(41300700001)(53546011)(38100700002)(558084003)(86362001)(8676002)(36756003)(66556008)(31696002)(66946007)(316002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpxSXYwVWI5ZytEVGoraDZjN0lnSTRKV3VSRDZyRHdIQTRmNU0xcDZGand2?=
 =?utf-8?B?SnNhdE4zdXZoRVVKWmFyYnJHbGxYUG9IWWFoemt1UXJ0SUdjU0tGMC9SYTIw?=
 =?utf-8?B?WmR0aHE0VGVOYkFFK2hmRFNCemVYcFc1Z09KL0dzZW9NWWFLUE9wais1ZE1Q?=
 =?utf-8?B?ZEdRMkpaN0ZBQjNJazdTN2RSUlR3ZU53aFhkRUltSU5qQzlLZnRlUDdaYVoy?=
 =?utf-8?B?dG9jMWRCV0xWeFVCRnBkV2hVVm1xclI5R2F2SWhmZHhkSzZzdzBJdlJNQ0JT?=
 =?utf-8?B?bGw2ejc3NzlZSlpzTXNLV00xc3B1cTl1T3VONlR0am5vYkI1N0QrNm8rQURE?=
 =?utf-8?B?Mk16Qi9DcldtZFdYREd1N3B6bFpmYzE5M0xia01BQzJNTUhsdTAvY1FVSzdV?=
 =?utf-8?B?dlpLQzE5bHQ5TmFWbXByczlwcUdOVjlJaWhSeEs2M1FoMjZNRjhpaXJWOFdZ?=
 =?utf-8?B?emI2cXYvbEJJTk5YdG1YcDJVanVycE9oL08wNEF0bk8rdlFWcklFNFlSYXkv?=
 =?utf-8?B?Q1JXNHg1R1hLOXVoVURjNTZZVklqYXVyaU16RzZ5RW5lc1hSWVRSOFhha3J3?=
 =?utf-8?B?bk9MTzRkUzRzUUxqYVhkN2w0NW8wSDhWV0F3TjZzNjFGU2cyMXoxKzExSnI4?=
 =?utf-8?B?dnBhcFNhRzc3ODNzWGN2b0tTSGVRY2ljTGlNa1ZERmxwa084WS9ZWVFPOUpN?=
 =?utf-8?B?cWZCTHRxdy9qUW8rQjNuYVlVWDRvc1F1MGpzN2dia1Boa1RuT0Vtays0a09P?=
 =?utf-8?B?NURoWGpob25UOHlMamxKWE1VZW5YenY4Yys0aWoxZis1ZmZmNDVHRkNmc0d4?=
 =?utf-8?B?VnFvODJuVmg3VDV2aWcyQ2g4Rkp2MEo1cCtNQ255bS9PRmU2Skt1aThuWTNz?=
 =?utf-8?B?Ry94Titzb1VtdjBaVzhlTG1HNVR1MmlseEdhT21HcDhQSGZKcXhXSUZPOE5Q?=
 =?utf-8?B?OFNsK0RyYTdJaFVDZmZySlhucCtFdXhvcHJwZmJ2Z0JaZW52YW1ra1ZUVTZu?=
 =?utf-8?B?cUNoQkhCZlBacXpRRzBrNEV5andjWU1jRmhvbGNuWC8yY2lmUWV2djIweVF6?=
 =?utf-8?B?WEJQRUtKbTdjdjFHalRJd3FRUitrNitPbFdCdjVDNWkxVzhHVHFKKzZrWFc2?=
 =?utf-8?B?STFZdEJieFN2T3RONlFlemwrYzlCZmlZTmI0azFLa0xFQ2hWTlNQdjMyMTVQ?=
 =?utf-8?B?ejV6eDBSZ0p1MHJ2QXQxa2xlaDh2Qk5mU3RjcDRMZ2ZvWlRRR21SYXJCSGNz?=
 =?utf-8?B?aUM3YWd5dGxDUXJPd1BpWU1IOEd1Tk02U0hzNUVGYVZqWURhK245UW1CZ3dr?=
 =?utf-8?B?YkZHbDdIQTRwMmJqZU5RcVYrYjZCNnJlY3RJM2owbW5tZmhXSEwzOU1uM3hh?=
 =?utf-8?B?YjRiKzNRMkNuTWUweURUQXNZZUNQVGtNYVBFZUtua0tmcUNkNng0ZHF0RVhU?=
 =?utf-8?B?UlVCaVU2Z1FCV2pqQnRvZGlWREZIRk5xbmg5MXJjUTRMRnE5MzFaeWhINXcv?=
 =?utf-8?B?eWF3TGRZbFNUZ2huOWUrZjkxOXIvUlhnb3RlTnNPTHBSSXg1UU1zZHpaNytk?=
 =?utf-8?B?UDRPR1AyYk1tVXMydUFBd3JlVVFhbzljZ1RBOFlmUEdLOWw5SFluVmQzdk5u?=
 =?utf-8?B?Vk1qNmdFZlIxdWtnckFadk9ydmRES3pCMHJ1SXV4b0RubmJNUWJpcUhXYml3?=
 =?utf-8?B?Z0FwRU02U0hEb2pscklCV1dIeU8zQktlVy9zazI2ak9rMno4UVdFaDV6MHFW?=
 =?utf-8?B?NytKNlFFMXJSaTBuTzkvSHJKSVo3VGF6aXlTQTJ1c2oyNlhtcWRWdTNYSTcw?=
 =?utf-8?B?WFEyemJWY0wrb3FmOHlXNkNLazJvdDg2VGFHck1pM0JkKzNLTllISHBpaHg4?=
 =?utf-8?B?QjFUeE52L0Z3d3VCNTdDZU1oV2RCcTFQUEZNYnhVME40V3BnV3AyRjE1MjUx?=
 =?utf-8?B?R1ZzMm90OHFmb2FiZnNIcElobnAyb2F6WFFFMlBuMmZxc0hVUkFlYW82b1p6?=
 =?utf-8?B?V2liVGd5bVg4eTRYNHpUUXozMW1KNzR3OXNWclh4VjlmaDdUSGNOMjFkYlBy?=
 =?utf-8?B?cGx1QWxYREMrUXVVN0kyYmdBSzFQR212NWNTMzlLaXZLbzFnYVJNNnB3VFZz?=
 =?utf-8?Q?2Dk+5sYGpciUzJ3Z9HxqkL1qc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f29d01f-ef93-4c7f-5dd6-08da97e65273
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 13:21:11.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NE4pV81GJhFdyLwqjHgBH2weN4JXQ7H4smMTGyCSHqF24cr1YqyMW/koXUdlC5kKw/ItRcKQWzPMck7Xq9mMTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160098
X-Proofpoint-GUID: DtHHEpL8Jmv7iNhxa1n_-u5QBNRsr2fl
X-Proofpoint-ORIG-GUID: DtHHEpL8Jmv7iNhxa1n_-u5QBNRsr2fl
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 01:18, Josef Bacik wrote:
> These helpers call functions that aren't defined inside of
> btrfs-printk.h, move them into super.c where the rest of the helpers
> exist.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
