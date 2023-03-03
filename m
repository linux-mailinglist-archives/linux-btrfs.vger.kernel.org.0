Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5B6A938B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCCJQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCCJQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:16:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906651633D
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:16:00 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233hx91004590;
        Fri, 3 Mar 2023 09:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w5XaTnPWTR2e9baHE5XjdPiyb4oRJL/XBNO5xvuW2Fk=;
 b=LIdghx9p5T10m7VO6OieClCy1yf6/S3j961/Gu9r/KVDbF5lFj2of7fLr2TTxtzi+zzF
 Z6oymP+bQG/0re/61ldwnHL5hi4o0lKBaGLwzeOWtCfq38yCBDESGjHzNvcEiRnC/h7v
 RZQ4USAlbgLm2mTJIdvY4mI5VNrExzdo4SpcSZsBByzKyXyg25H2ALRFURSlX+u7RWBK
 p4SNzvBbeuibOhQxSEhNonYtLkfRcP0IU4IV9rT+iITfU2xvKWC153PLEPH5ia6uuuiw
 igiq5eWu9FJY1iyEnIXhslPb0Kg7bEG/kVksFktO77ECfjliCrGjVjOmjumaq7sQgkbD Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6enuhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32370NG1034864;
        Fri, 3 Mar 2023 09:15:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shbbjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR7rfk/7V2DsOzxZLcBikOSqhrC8Uza6keJhRgmioVixGFEIOLVmLjAFGBu2wLnkpgOV0VpD+qDolxKEmuRQ0yYWNL81KHQH+yEJfDk8jY92bOd05w/rDpuPMYFBi/WbTK8PMy7J3LiF6GLvC/R7sBcM0FDP32iMS+/9uUPv2HMaRqVL6k+jJ1mz31M5KmoYtMpbjVezONULY8iEvzi3xNKPnQ6W4HUCat4YrKJ/ZhUKB2jAP1Lzs0QnbZ5VVLKKoHp6/hgV8TBEZFLiDBP5wXHc5rBETuVf68b6FqzcO+SCAu/WT9eEcHq8bSDl3dPQgd8VEZeDjlgB07pub/+hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5XaTnPWTR2e9baHE5XjdPiyb4oRJL/XBNO5xvuW2Fk=;
 b=CK4h+bs7jgZZ6rbiaFNwwILU3WFTiTCEuAAdVy50E3cK832smTquFLExWT20KhSxFv1KfjlA9Ocge452mAjkwUMCfxb41VfOrQ9GNNC5IO8zOn3ZAxANaIM6W8YIkYvZXbKbeZ5TPOmBmMl7RmbC3Dkp/IZ+xzX6O3bmEwSYHfjr5fy6tPEqC0ugs+2sBCM8sxnRTTSk+mfdHfRQ1UiTpuhmQD6cZyHFOQdlHEFUSQ7ngLaDGsqYnx356T/mecrh8/Gjz0NPFIfJmSlYTmQ97BqqQ9R1GqbnKQH6nc+PbT/1lpLI1rb2R5ICoWblGBtkxdIjaJLjs+R7Eur0qHuOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5XaTnPWTR2e9baHE5XjdPiyb4oRJL/XBNO5xvuW2Fk=;
 b=GWCXAEdNnRSFFdmbVJT+mDVg1ThLFQcyq+Ck05YrI6DWadLoz5fKrwT7e5plS4OZf73JLUb9V4KkngODc/YuW74nurXRJ2CqAsZFWd6x8vUnDm0CnkjBC5/ZCFKPyowT0ITVAmyxEj5OlKC4p9jbR69VoRZ0a8pDJYoXFrdGw1M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:15:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:15:50 +0000
Message-ID: <abecaded-0376-8b90-2ae1-c0591e87b3f9@oracle.com>
Date:   Fri, 3 Mar 2023 17:15:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/10] btrfs: pass a btrfs_bio to
 btrfs_submit_compressed_read
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-6-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 548a5620-f3c4-48a3-5418-08db1bc7e195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5Xb0vB2Cv4Pvc93B/OL6cfOV5clx3EDrwy8PYd0Hx7+qIoOtahEetNGnQpjxKUq/NJljT85NwBPUtuph22lklCnVRdszTyjylySZgm8pgaDz9qY5dfFL8AmPBH3/B1IyTwwW/bsSa30BA9bhKHITdWnXbJmsZM/QuDEOD49ZKz0/ZqPrHseC/xPVIpsEYkifXzCC14QS0e7epslpwQiEfOF/faiyMl3cZ3ougwRbugLIvH9F5BHbJO6zb/3YCJTn5y+9lGFMKGP8PI0ZJSb7I9VT0dM1WaByFtRtOIBRP2SepyOdHTciwlQhOxvoBhHSlGVejVVGegisD3SMTZYd9T7GLNPh2RoevAeBcWzJw390XffZBHupj2fgcSq1jOvucxfS7NtcWlgfzhRppDBYn+S4ea1BGKUaa++gUPMtRzxsg7+Um/PzKnoW/6N478BrPOs35Nsad6JEWYGQdCS1UVz/i5EvOAre0eYVY/I9ueGmNy6OecIfes5rujomUN/7vsapgbha9T7XZhT+2jyqgKHlIlZVhZBM8L8ZUSfPYAgeabJGwjac2QAU0u0WkRrcsJ+bcQFeGMwdsPSrqhaAKYY898d2tM0NZwQomhKUQItrlth1Z8x7H1MqC0dyqekl1DHX08lQXSuDeE4JQyiP9oJGNY3EqVr0ou5eaG7oh3gPNHuJJ+gxWmFckroN4Qx8fzTV/xk3rjJWuoYPVe+GrZjZUn2DGWLVWn5yNnRY/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(66476007)(66556008)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpJclZ1VUdxU0tQcG0yaFpNeW5jcnExby9NVllyM0hMUHpMb3pkTnVJRnZB?=
 =?utf-8?B?ci9ORjU2eXJaS3VPeXpiWXptWktEdE8wVEVpWGJEMkYrdmFMdzRUY0Y1cTRq?=
 =?utf-8?B?c3dRaXdZQ0RzUFBsbnVrcWJDcnJ2RHRBaUxLOTFlLzVlbVNMZmQ4S0hCK3NZ?=
 =?utf-8?B?NnRVNDZlMGVLb1gyMmtLcTNyUG43U3JBZmM3Sk1XSkl1dWFEY3JWN2ZRZDdr?=
 =?utf-8?B?T0c2Z1RkNDNUR2JLV2h4bHZCeHRLbXcxTEFhblVtQytwTkttaGJiaUIwRlFT?=
 =?utf-8?B?alNIa3lrWnNqTWJHSDVjcmZUTmU5QlNKTWpFT3V3U05KVjBZdHdiQTd5S1JG?=
 =?utf-8?B?enpmaVk2azlSSFh0ZjdRSjgwOXAwWWMvN1dNMHR5OElvdVdQaEE0aHkydzZv?=
 =?utf-8?B?UnpUazFlS1ovdFRiK0hWK1dIang5aXlIYXhZMFVaaWNybGdnbmxwSVVPWFJ0?=
 =?utf-8?B?Sk0xN1pVcHFCbkZQSVcyOVNuV29LOWZQQU1Tam45THdIekp4YTFYeThGWnls?=
 =?utf-8?B?THp3RG4xL0ppNmlUYnZMeVpwY0Uxd3hBZktneklIWW9RSmRSSk9rSUcyeHFj?=
 =?utf-8?B?QXRtVWdaOFlRQ21OMXNhK3pDckxjU1VSSStxQy9jNk1WR1BaOTlqWnl3Sy9Q?=
 =?utf-8?B?ZGRDenJkaE1aQ0U2d013Q2F1TXYwWEc1dnBxUGRPaDFuZnB6aWF3cjZRWkQy?=
 =?utf-8?B?SXREckVRN1FQbnNWeDF4WEw0UzVUL1R1M3U1UHgvam9qVXdXczlxYW5WT29Z?=
 =?utf-8?B?c3BKclRPZGNaWHhwamNCcTdLTUVjNW5EemV4aXZLSHpiZ2gxeUEwcjFUYjc4?=
 =?utf-8?B?eUczZ3RWcThhdEJqSENUMVZJcjc0QjlmUXNUWkxvNjlxZlFGSWhjZ0J3Q0pz?=
 =?utf-8?B?a3o4TGUzM0tJdmJHbkZaNlNNT2lQSTMyU3FxU3g5UnB0a3QwQXNrNXNhb0dw?=
 =?utf-8?B?Qlk5bEMyWmVVdHNGcjVjSWdEMk5FV1hsZW1CcHA3QkJOZGZtL01PVWloMDI1?=
 =?utf-8?B?RHpOeW90N0MvTW5IbHVjT0M3SGFodk1maDRBNGFjTHJsWkNPdEJzeW92RDZE?=
 =?utf-8?B?Z3haT294RG9rK0hnL0owL1BWQitQM1ZGQm5sNmVPblIvYXpaSGgwckR3UVhq?=
 =?utf-8?B?VkgvaDhkbko3Ty9PSVFlWE8vdjdKa0pnQlQzVFZvNzFjcEdHRlpsTEkzbXE0?=
 =?utf-8?B?WVFzSkZTSUZHZ2FaSU9zWGdhbVVEdmFxcGQxM0t0QS81QkpjSHQzaVUzakdR?=
 =?utf-8?B?STRheTNpRHhGY2syL2M0M0FyeDEwVGNIMGk3SFMyNStlOUxEREtvWFRFRU82?=
 =?utf-8?B?T1RCWnQ2bFJBL1cxck1MTlJUTG9Lc2c0ckZJMitsMmNFbzV2MVZ6dWd3d0hJ?=
 =?utf-8?B?WFI4NjZtaWxkQ1FTUEwwNHFHbW1TaFRwWVdYa2V6WTM1dWd0Ym5jSC9Vb29L?=
 =?utf-8?B?SmE4V0RRQW5mSFc0QVN0c0dJeksvMTRhQWtmZ1hZOE02M1ppd2JicHhKNG1E?=
 =?utf-8?B?SXhqd05rRlhqdWUrRHdhUmdxTjY3YlZmYWFpVzRNaDVIQWJrLzRxSlZ0dGt5?=
 =?utf-8?B?cXUxVlN0aEU1VHB6Qk5JWkMzanNUQzB0RC9XcnlVY2g5Mks2T3l4YjJiT2U2?=
 =?utf-8?B?T2kzMFRybm1pNzhiSjgzL2g5QTNwVlRFZUZFcDNBQjZvck5HU0Z1OXJBYm1B?=
 =?utf-8?B?OVNxNThOQTh6cnMyVHU2dFhNbzhxdUc0K3cxK1FzcmdpYXptUUY0SnBzZlI1?=
 =?utf-8?B?Q2ZaemlhUjZiODVZMFNLTm9WUC94QXQyM2xxekxhYVRkV0tPLzZDclNjbDdF?=
 =?utf-8?B?RG1nYVJjU1Q5VzBaK3gvYUZCTkhxVVg3a2ZyTm9EbVdOU3RZVU5yQlo2Nklv?=
 =?utf-8?B?bzU2S2tUaEdwdDBUaDM2cWs3aDh5RmVIazFtWWlSQnhDbGJkbWpaU29RUU9E?=
 =?utf-8?B?UFhGRjhGS3MvWkpROHpPNFkzVUIyZlNEK2xNMzZrR0JiWkRZZEJ2bUJlUTVh?=
 =?utf-8?B?T1E3WmNUZkpDcFRIWkdaSFRhSzdHNWxjOGJZRndhMzB5Y25pMEFYYWo3c0Z3?=
 =?utf-8?B?RjZ0cW5TZXloNnhYVVVnbGxWdUIzMjIvK2NJY1hlT1RabFVtZG4wRXFGY3Nr?=
 =?utf-8?Q?Ssg+a/US5+PRkv/7jWFPxVsvz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rYo5DsgWFwZnGeKPtNaQgHixqcMhfGpn3uak3VsDFJ2Kfx5s80QRLHFOWStbUkw00IGxPMBEIcpBxURuZgbu2zMXtgmVqNYs1ZIColSvSIT+RPqgrCivNzJXKKZWW5hFTpoNXZpzOMq1x2oLqGc30uIvZqDhzAWUDkYVungZF82aLgcVB+LRlCh8saR4wyfcvxwcvFwKzfVTkBYDBn8Qi3xJGQVglpMtAC5XbamGZ5wp4kF4tRdNyQOO+/cXUoScS2vXbE0hcihxXZmrj5Dg0YNf+F7YQSIv89W3c7IlnHPfuLPFuER+7lDi0ExeGs7JaNCyBjVdVPKziVVUN3xiOTjWozdHDL3gRd67ovXXL1px6YiYeJAgFQADBLvT2caV26aszSrl5tJBIl2eQHs8ikzAiwJglnUPyqaNIyqx88Yc4AMT0vze8sQ1ABgcUzZO88uVxTEPaLu+3U2YSVmNuGTKnIbziaU64hkYZDOZ8LRCQBLfcRPWHFek/20gaIywvPbK2r3N1N9sr2KRdzDBjL8XTQ/Bgpej9oxNoFl2bVquqTddgw2Rni/ndeuPpWNzOs5DCcemFhqgxgvSettjL+noCqY5o4XoYto7DgLSTZG3b/R+nTHmCMFJWa5fNjqxc8qm3LpGQD88Q+tlrF0th8V/Hq8QvapwI+fHkhljL8H8b1aiYhO4yvdfbS53aUxtCSfbELO9vA/bf9sQ+SjdG8qBVcV39v3wpJOdTYREB1PcRXPenlxoa40OgmfnzSfVK4tOi4/6C0DOAA8Io/c+LIW8CTz01fr/t8BU9W5zJhAxaPWyOQNYyMxE+cHrIrYqs8D1JX6pYWJZPy2WMroAojhHsVElxzJ6AKyRd3HsEuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548a5620-f3c4-48a3-5418-08db1bc7e195
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:15:50.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uCuGbDZByPyXIpN3uEomDtT4Qpn3ThML6ITlCC/MhFDL7Fh+4cW5yqh1L3n5dKgJHiLgys2jGll5CztbqhjVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030082
X-Proofpoint-ORIG-GUID: rQAKzXeAfwDXzFeDpzwrM4TvR2rNYSlU
X-Proofpoint-GUID: rQAKzXeAfwDXzFeDpzwrM4TvR2rNYSlU
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> btrfs_submit_compressed_read expects the bio passed to it to be embedded
> into a btrfs_bio structure.  Pass the btrfs_bio directly to inrease type

Typo: inrease->increase

> safety and make the code self-documenting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

A nit is below..

> ---
>   fs/btrfs/compression.c | 16 ++++++++--------
>   fs/btrfs/compression.h |  2 +-
>   fs/btrfs/extent_io.c   |  2 +-
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 27bea05cab1a1b..c12e317e133624 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -498,15 +498,15 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>    * After the compressed pages are read, we copy the bytes into the
>    * bio we were passed and then call the bio end_io calls
>    */
> -void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
> +void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
>   {
> -	struct btrfs_inode *inode = btrfs_bio(bio)->inode;
> +	struct btrfs_inode *inode = bbio->inode;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct extent_map_tree *em_tree = &inode->extent_tree;
>   	struct compressed_bio *cb;
>   	unsigned int compressed_len;

Simplify by declaring and assigning bio directly:
         struct bio *bio = bbio->bio;
This eliminates the need to dereference bbio->bio three times
later in the code.

1.
> -	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> -	u64 file_offset = btrfs_bio(bio)->file_offset;
> +	const u64 disk_bytenr = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 file_offset = bbio->file_offset;


>   	u64 em_len;
>   	u64 em_start;
>   	struct extent_map *em;
> @@ -534,10 +534,10 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
>   	em_len = em->len;
>   	em_start = em->start;
>   

2.
> -	cb->len = bio->bi_iter.bi_size;
> +	cb->len = bbio->bio.bi_iter.bi_size;


>   	cb->compressed_len = compressed_len;
>   	cb->compress_type = em->compress_type > -	cb->orig_bio = bio;
> +	cb->orig_bio = &bbio->bio;
>   
>   	free_extent_map(em);
>   
> @@ -558,7 +558,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
>   			 &pflags);
>   
>   	/* include any pages we added in add_ra-bio_pages */

3.
> -	cb->len = bio->bi_iter.bi_size;
> +	cb->len = bbio->bio.bi_iter.bi_size;


Thanks.
Anand

