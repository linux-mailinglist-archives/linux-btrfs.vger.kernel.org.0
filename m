Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D36109B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 07:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJ1FXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 01:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ1FXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 01:23:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203411B4C77
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 22:23:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMO4uu016719;
        Fri, 28 Oct 2022 05:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eTqVFwM9h4YMojqzeCGGWKCisd0qNFEbf6Hk2gtdBnE=;
 b=y1YT+bo1c1T3GDv0Q72HmscKtJ9R/ZBtYzueY7u3bRv56tgOpHAQzO3dnM1sVMtgvj0L
 yHzZfhxbdk5WJ723lSdkdD+V38Nm6DgaSg6Y3lwuagNH33duvtu5KOElTYm1cCPIyJf9
 S/VYmMinTSIP/tMnU/JiV8jtLFL4uR7Q8QZdr0y70CesMrF5EqaU/6d74UWuUALWg/TU
 nCn8pQQ3LZo1Pu3cyr8yK8ROdS/ecBjMSQZHpVke7Iy0uFGQV0WtYKJ5lSLiyXn+Hh3w
 Do5FPnncdrumjDMelysR+Cvx1bBqW1lhlEycsmj0EFfrsa2t1stVjWJW7XPM0KCzKAXW Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrv270-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:23:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S1ntgh026673;
        Fri, 28 Oct 2022 05:23:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqqxwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKiWrMmqSvYMdntRw7JWp20V27tW9XBmtNy3vmaBbogpTMxa2TP0fYNdjOKt66PyXssNW5hOKYDUfRAUweB7h2p70stSA4g1dojJhSPbYtT/KO8tL+Q5h6aVMT8lSPwjLzl1YnOPf/Ja/+liZqhLRQok7Ef/9sFh+z5tFK0iDZ435vHspFx6KQdPGZc0rcBdD6mXbGtIyttK0AlIevo0e1xv6qW9EulvaXSEiR+QL7NI/t8IXKjc+Slxdz3OtiibeYeuEiBUExGcQf6cqnjHGlgwrXBBcRG2mRVMVicfcouxbL7lBYI2WLSH1mbRX5Rumxzzq7bNk0CSREleMPgo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTqVFwM9h4YMojqzeCGGWKCisd0qNFEbf6Hk2gtdBnE=;
 b=FSZnYKE8VYlOlgJAf0tATIVjtVpTXR/KbF83HRGagVKxks+GtDuRhY4aLHepeDB5L/WZFQXQJU6/Ujr08rkiYEha0dutue51U2u//ZjIsIfgWC8w6bIVf72mdOfHhXAjbwEM8VRpXqxu9W0g+Q2Jql93dpqXqYbABvhseiyLixbAGWcTL56fDCV87UKAExZcEl1l6VR46e2ZkVVu/a2TMfN6IDZeoYJbLoqv4n3AJxQGBOfi7lOsM55hUXmQRIhu1PhArzcmrlptph/gigYoacF7PptFZKehGqrx311hjPZtXdlUH1WMVbPZInqgw69TeorF6L5xlpcNXxplZFzwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTqVFwM9h4YMojqzeCGGWKCisd0qNFEbf6Hk2gtdBnE=;
 b=ePHeth6BV4yJEx4HhcmcGhyRiM9TWquk50l6nEUtjtF2CnhzX2Tk9s1gnwvdWFj1D7SXPkDAC8WQFuZ52xBqdQDMom2+IbozjCHYVM5hyPixUrGZtT7XbaGUnSaEQbCfyCF4hE3uOFVPa/ECUbTD4CvtFTU0s2MRJn42a4tSICY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6057.namprd10.prod.outlook.com (2603:10b6:510:1ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 28 Oct
 2022 05:23:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 05:23:01 +0000
Message-ID: <974d0f7b-1272-1c7f-cf34-88104642e7ca@oracle.com>
Date:   Fri, 28 Oct 2022 13:22:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 05/26] btrfs: move the printk and assert helpers to
 messages.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1666811038.git.josef@toxicpanda.com>
 <051b9887171d14d8d5eb30d3274a946427ed3c69.1666811038.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <051b9887171d14d8d5eb30d3274a946427ed3c69.1666811038.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d479669-78e1-40e0-f40f-08dab8a47b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLlXBwUoPp2QJKWG+MPl14sqJqWdE7Py1EvIVMDtUnC2FmFjM85XSYb6XcHEHb8tBbc/WRVl0UJMtj3KQ/Vfa9o99ILjX7jzwa57bWU/m1gYOfiKwR/m1V2y91mVFc6UzaeZb+swuQ3SukhnSox6pMaVBmgAIj62NwFhDJBc27POG23XpDU4HFXchbXcPU8g1YHaEYUsea+E5Zh8xiU1wZGwHio88CdOZxxw3/l5ICunmUPxl3B4EEdh+oGlA/gXJK7DreVUEQWgSO5PmE+gPieuL74v7VpTsaoB+rJKwQKXA+1NRh9aOsevz0RsISlZYaLzwUIAIuyvzeb1S/Xpi1sUaRcSM3/5EZPUF69HlZssi15IUXQJ6pyPO3EIbPSqwOxmVgBrnqUA791xfWT2NlOgeEtLPhTMLESEWDRkaKObCy9XpDK873UpJtxiyI5hJayAabjRQbDt0JOpDT0kadBXcPLFyWstSGKY0beWhZ4qiF+8HV9TL8kkdH4+LeGeUj2TFlXDuTmG6Hfwg11O9TzK0B3MlDv06asJ2i3u1MeZP7JMtWyh6wYpHX7bGUJQe70r2BbkAuLg0qaFGAlyhGpZgWqEytGFUhFnS3ZmX9Y/dfwscKZmcEcJ7FRKEsAde5f9leao0zyS0vEhZa2nNxTnRzvsB3D2NosAra1UhRn7Fvpyq2kOS4nCbKrUhqvEGMhCJ9r0nFACjbxtxtCggB7HA4WG6Zk3Qgq0wCL96LNvYuKGNL0NLvX9L6ZQuBTSTBIbRFkM5UQKPP5dVn5/0qntb0BrWGN6M+MPBhTSlwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(31686004)(36756003)(31696002)(316002)(38100700002)(8676002)(26005)(44832011)(83380400001)(66946007)(41300700001)(2906002)(66556008)(5660300002)(478600001)(8936002)(86362001)(186003)(66476007)(6512007)(6506007)(6486002)(2616005)(6666004)(53546011)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDRVMmI1dXBTd0tGb3M3U0QzcWpYWXo1TjVldzJ4d0Uzd1NxYXZkc2FVc25T?=
 =?utf-8?B?b25nWVVkN3Z2MkpYUnpCZDh4WHpUNzFKTjV0RXVSdUJwYVlxRmgrK1BySEJs?=
 =?utf-8?B?ZjRWUUJDRGViRjhkWXBFeUduS0c4b1F2NGkxUG9leEJhTFlMUGpROEJzS0pD?=
 =?utf-8?B?NlhQTU1EQ2R4bUl4Q3p5azFJS0NoVXQzbXJjZEJBRTR3RFFTaURJNHJVM0d6?=
 =?utf-8?B?ME9yVXhvSHVrNEZaMEVSNDFJT0ZEclowQ3NuTDR2dEdaUW5hbkZmZ2NPN2Rw?=
 =?utf-8?B?V3Y3cmxtVXMwcHhURGJxNE5ZQitsNms2SDBHYVBxdkRlWkdoK3phV1hzNXpN?=
 =?utf-8?B?N2JrVEk5NXdtMWJuU2lETXJZNzJoblZzMTVWYWZ5ZXVZUDdBOWdYU1l2TXZi?=
 =?utf-8?B?YitpUVgzdExtUmVORk00TEVBMHRGdUI0aFpENXArNi84TFM5NVlQTExqcmVj?=
 =?utf-8?B?VlVWYTV3eWhKa25VZHFYWEsvT1Q1TWp0NXMyWjhYY0ZOSjZtY3FZdTY4djhR?=
 =?utf-8?B?ejNVbENZdGdEUWw2RWZkVnJRaDA4Y2tmQ1I0R1MrYjEzMy9XZ2JpRnE3K0Y2?=
 =?utf-8?B?RTNqR0JtaUlZcWhGQTJrdGdsWHJ4UitubkU0NXF3d3B4Qk4xRGtYdlVyV0l1?=
 =?utf-8?B?ZDF6bU9Pam83T1Bsbm11MWQrbmdlQzNyeUptY29WSjU3YWtpV2JNSndIVGJa?=
 =?utf-8?B?eXB6WFJURzVxOW5LV25UeWFMNEZuSDh3QUFHVEUwdGh5bi9ucUxPeG1wcXd5?=
 =?utf-8?B?NTJGaGpzaVFodndRbVpLRmc0L2FHUitXK1lmMGJieWJaZEUxUEZhTVh4YWtt?=
 =?utf-8?B?UjR4NFA3bDN1MU1zcGlOSGFSVkd4VkovNmg0b2IyQWJocDJSbWJFM0hYM2JX?=
 =?utf-8?B?Qmd2QXhTbXZFTTI0WmprTzVISURwdk5OaFVMVFl4Q3ZhSWdIYUxjZHBNMGZh?=
 =?utf-8?B?Y2ltRDZ2NGZiS1RMWkRlM2pyN2toUmxEWk4vRmFORy9Lb3dWOTkwOS9EQ0ww?=
 =?utf-8?B?LzMwcElqRWh6RExWMGoyWG4xeVR5TTVyc2FZTGwxdHFvVzRwVEFmblFuNDRt?=
 =?utf-8?B?LzRZNjhFSVhaNDcvbDAxUEtEdVZDQ3lPVmh6MklYUHVOakNrV1dwMS8wc3Fs?=
 =?utf-8?B?Ny9DbUFvOUVJWGF2d0s5cW4raTR3eVI3MUhhQkY0alNNbXJQQ210dHc0blhH?=
 =?utf-8?B?ODBKdmMxMHptN0lTNVpLWGxOUUZUV1BWMWkvUUZlMUJjRDFQL2x4czlBQlZE?=
 =?utf-8?B?YkVkQytiUXRHM3NtdXBmWUg4cjJ1SnlBdCtZNjBnZmE4cXRyS240WjZ3dmtC?=
 =?utf-8?B?MVdIcUFac1J0a2ZYYmpaVnZrN3J2d2Z2N0hVWnJNUkJRVFZteiszSEhIUzZm?=
 =?utf-8?B?d2cvYjhzWllvQXB0ekhNV2JPWXdHSGJqTUZKL1FpdUhFaEh6UldhRHBQTE5z?=
 =?utf-8?B?NzlKcEhDNWxMMC9ITVBpamFkeGU3TXVVb2tqR3k0VUYyTkZhbit3NlZRQVJ4?=
 =?utf-8?B?TFowTUx5bUVPOTF4dUdaTHA5TnIvSlF0NXBtV01JeWdXaEpXeXZEMjd6aHEw?=
 =?utf-8?B?VGp3a2RTNTlEMjBZN0xPSVo1TFB3RWJ5YVRlOGFOZ1dsU2FqRnRaL28rdlNE?=
 =?utf-8?B?QTNJeVhFbUg5SnIvMjZkZm1WWFk2VGd3djJRVS9hYnNSUmZ2ekV3OTRXRTY1?=
 =?utf-8?B?SFdrUE9COEVOZVI2S0lSczRyUndMUVdqcHpuQWVpOTZBblczcnlmNzl2UWRR?=
 =?utf-8?B?ZnB1c05WRXlaNUJMREF1Z29VYkdzWkpEQld3ajcyNVdXNksrMVk2cVJGZlVn?=
 =?utf-8?B?eWtFKzVlUjJFWkh0MDh4WlF6KzFtNjk2VXlMbWExeHlBTUR2ZGVXdmhNZlcv?=
 =?utf-8?B?R2xhbGxuckkzNGRodjRvd3Y5clFabjFVNythaEN1R3FSZHAweFhHQkkyZ1BB?=
 =?utf-8?B?dWZWWWZseGdjbnlsd1FZdlU4aWovVDM0NjFvWlE0QmFkSDYyL0pvOVdOd3JO?=
 =?utf-8?B?ZmcvVFhWVXdxaENWakVsZGtmN0l1dzZSMU90VWk5eWlOdGpOK0JqUVBHQTJm?=
 =?utf-8?B?YkpiQWcwUEdZV2swTmlCeHF1SFBRUkVqUEdsdXdMQ2l3TlRmSzRCdGVMQ0tE?=
 =?utf-8?Q?26cq0yDbwwaKAIssoKU1/uACP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d479669-78e1-40e0-f40f-08dab8a47b2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:23:01.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi38KdWlZ0TpHPbSWZ16KI7UyiX/DqzbjtTAFrAifUqQaKmwbtW73O0rADBqOxxxVAuQ+s4GC3ZBwZxDSzoLfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280034
X-Proofpoint-ORIG-GUID: P3FgYYvYB_rOe6ZFSd8pnC210tDVnVnA
X-Proofpoint-GUID: P3FgYYvYB_rOe6ZFSd8pnC210tDVnVnA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2022 03:08, Josef Bacik wrote:
> These helpers are core to btrfs, and in order to more easily sync
> various parts of the btrfs kernel code into btrfs-progs we need to be
> able to carry these helpers with us.  However we want to have our own
> implementation for the helpers themselves, currently they're implemented
> in different files that we want to sync inside of btrfs-progs itself.
> Move these into their own C file, this will allow us to contain our
> overrides in btrfs-progs in it's own file without messing with the rest
> of the codebase.
> 
> In copying things over I fixed up a few whitespace errors that already
> existed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>


a nit below:

> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> new file mode 100644
> index 000000000000..a94a213da02e
> --- /dev/null
> +++ b/fs/btrfs/messages.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "fs.h"

> +#include "messages.h"

messages.h is not required to include.





