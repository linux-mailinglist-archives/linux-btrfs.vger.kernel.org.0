Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8035B5AD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiILNF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiILNF0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 09:05:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BED140C3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:05:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CD3ItS013362;
        Mon, 12 Sep 2022 13:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ExhvwHoK+A8hqOjJk+mNQWmhJKrjApbmBxyxw6htlHM=;
 b=2XYi9X/VLU9oIG2BQ6T8+KJ1GCYwLFbByvRbfsb7EvXKRr6ViyZ5f1OB+2s6HGFPsPJ9
 2FdOU6+l3DFUDwP77jor7lMD/J9UYBdPyQte/jn9n3b38JiGUhOiAPS9ysIzseEsmF3f
 +1X/7Pclqt4iMetkbKrZy3p0tNcddNpEPjaVV3japCBmwx0LRJEXLfL7Lg2swcqSMruF
 ZvrjMHCCB2jS6JqLI1Wc11ttDfYivojEPFk1hhJCbljYSavk6p/s7F5gMMgVTvBlIJF2
 0HxyueVux23YGwY+09n8KJuvMVUdzmu7RkIPQCjkDuHiOiZcVeAsa0ny8Wt3XiDRituX uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgh0c3eau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:05:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CCEgDC020410;
        Mon, 12 Sep 2022 13:05:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgj5b0hq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWDDsFyjZtuXVuGjIKLsVWVEZr4catqrjQRnOJnbAUJmfrMuIPudEXSjyLED44GoI3VfYtA975bsUdttgEWo9A+16k1zpJuz9E8w+t36smsg3IIwvOvVjKoTzNUrhsBLzot4HlJdedpQ+HUGUD9umm1j8gu4DK5OjXvok2jZIVnCFDYh1xhCTZVorFN/DD2Qt7S+rfaCseV1cagTq2yx2tAfdTawbJtCEP0IcazZhXhsbTZm/sUvPNWZcOahc8pxK9raUAmPIPuBZzHiU4mkkFYrmoxvP8hOEfN9I/AD3jHcXmvKqSaiw7GGQtbTJrVfZvmlAC7kqI4bp2ZLbL2wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExhvwHoK+A8hqOjJk+mNQWmhJKrjApbmBxyxw6htlHM=;
 b=k27Nh+JgEVexzaWBZev+/JBLBX/qv7b4nkJy1+ZYuSmbGFoWEqlJDGDa5fGD2Vw08ug2eEhMcZciytEqXRxtwCYQuqmrgVrKMQ6T0srLIrQL3hidOZE58svWPV1MFYl83oEqLCk4rrxfHTsV9MUzqL7PgP1r/3woRk1t2Y/+CEm/Cow0PR/sMPAmrrCPJXmSFEYPJr47tk/uzhhLogvQJn5rK/5Hj3vKMWLZuUJ9hQWs1e/P6pRimOv2uv00ss2wqC/z44qQ5faqKViNsjqf/gj5PLWHL6MiVAabsNHgIm4vEeEKMUX+rWVpYYy6akf22Rzk68u7KWnm/7BKeRD7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExhvwHoK+A8hqOjJk+mNQWmhJKrjApbmBxyxw6htlHM=;
 b=SVHKTPk8Xr6IPI5aXO5KKHLmdj6BoWvwLeXNO4arOHc9s43IxTLrPLLOa4OyLr9AL7ubI2sYNPa+PINSK9OyEdUE/+gziTYpUk7lod2eJPVTWLKg9I2VA4JXmEaUFt/+fHmot8tvpyBoC85FuictAPCqE0TF6w01oevYUyFi/xo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5247.namprd10.prod.outlook.com (2603:10b6:5:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 13:05:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:05:20 +0000
Message-ID: <d368b09a-7eff-01db-395c-c352898946aa@oracle.com>
Date:   Mon, 12 Sep 2022 21:05:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] btrfs: switch the page and disk_bytenr argument
 position for submit_extent_page()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1662963954.git.wqu@suse.com>
 <570918e453541705fb43762852de0f45dbafb568.1662963954.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <570918e453541705fb43762852de0f45dbafb568.1662963954.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: bd32a0c7-2857-4ffb-9210-08da94bf71ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyMeWLx61YBfvbFu7c8C5SQrkwYMntWfLae8LupaSjU7Si+w2FcM1VI7ZbzIwgOslAeKVY0vax25eUb+tFfFgJf1iQ7c7Pg9oZEu/tidm+Mu9JQLGs5+PBXfLxKnRJa1R38m9DM16G342vfBL6CbKF2et4Rn9698hFURvwLOvwkkrPq3gJP7HXCM2U4AJZIyprIP0cmKR2azxuz83mfXe6LdgmCQnlYDppLRnXulLkzJ6X6hzhZVfhenlhLe1YjPbPT1Apf+BO+h5m6vlscKFjkPinM92D8tH3uyIej127tqWAMVk3yOZLPDfaxBNluGhxcTaWFYyfPn6fFafPNfgnEKHnpToguBByXELABWsxauPuQXi9OmZq7YoaGPsx3zsgjcX8+BUDCP0cNkCtbr7P/rqOSXDNOWmC3U3lGCCIzqdtKl2BHz8dCsz7DxuDarhjgW4UpUbCWYuS0ZTZTIuJ0DkKLisZbMljYWqfTK4DQDA6j0Tu4ukKxJKILsoN6TPpBKAhTvnU4iru2J+tlM0WBE3jq9yvxZ8gxPJLPIeDwKlzQB8enBbvVc96DgwfDihZU5u+J+RXtmkqUBqDGz3DTZgsI69aMoYgdoM5jKPAWpuBfRt+lk0RRhQB9WsH+AYz7x6k42wuFqshagT9CaL8mR7/0rWE4D4SMT5AMOTe6rLRmZxzrWuewp0zId0XyxXJjR1oN/+6EnYCim/p92JcPyTfNWE/nKLajE/B2jVFSgrHjKgEiMGNtJgtKTPod+4Tl2l8XjX3E0iBIx1BzHsOtXYC5gcSfnatbfTpvwqFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(136003)(346002)(376002)(31696002)(8676002)(86362001)(38100700002)(6666004)(66476007)(41300700001)(8936002)(66946007)(66556008)(5660300002)(26005)(83380400001)(6486002)(478600001)(4744005)(316002)(6512007)(2906002)(2616005)(53546011)(186003)(44832011)(6506007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZkK3pjR0RKYUtTQUZ5bjZCNFg0dXorZHQwajFaQ0s0RnZSWDdUeDFSeDI5?=
 =?utf-8?B?N3JkNE5Bck0rcjZTTVVmWmYxTGUyUytVdGpNbkdqQTBYMEFwcCtDTUZwbjFy?=
 =?utf-8?B?cWdaaWhaZFFHMUsrdmJMTWJhOUw2NElENFVkcjBLU1BVdnNLS211WlR2Vkwx?=
 =?utf-8?B?cUs4aFFoOWQrcEc2dzlBQTlxODhTU1hNdm81cWNFL3JWNzhLQzIvYm83SXd5?=
 =?utf-8?B?alBKV1RPNE1LSG04U0lLRU92aEkyTm5GSzhZak9jTS9oYi9Ia2o5N1FCTDNl?=
 =?utf-8?B?SjNHQUFia0MvYVU5U2VKeGtocXo3U0NkTGtKOXZZc1hvL08zZm1oK1A3bGlB?=
 =?utf-8?B?d3NXNDNuV0NLK0VWc1k4TDVUY1lIcUdGaCtGV2tUamFqWFc3M043ODllRmtl?=
 =?utf-8?B?SzcvYm50V3Z1aVlFbEN6dWhydzdFak5aRUlrcU5zNFAwMS9sUnJLcFZQNHJS?=
 =?utf-8?B?Unp2bnIzYll5ZU5OSGlvbGVTZ3VVK3kzQUV6elVSRFByWU1LYWVDOUJQN1dY?=
 =?utf-8?B?VWxTQUZaUi9wak0vdEc5YUNxYjBpVEQ4TWhKaVdZWVFxKy94VkdtVk1nMjQy?=
 =?utf-8?B?NlMvQkhoSTh2Y3FlVlMraW1PY1ZzZ2JwcWhEY2xmczJTMVhXclhENllhQ3hJ?=
 =?utf-8?B?bnUwNDhINE4rV05qbzgzL0xldXdIUTRDUnh4V0RyMmhFTis2ZXdQTkRXcHBx?=
 =?utf-8?B?UUVsdzJNazRtdE5EZVlPSGsyM3c5TFhzYzc4L0l4Qm11ZmR2YkNORFNkd1NP?=
 =?utf-8?B?WG5LZ1RacXRYMnpTcnM3QTNyU3FaMHFDamNKbXBKT2JNMXE0MEJpSVE0S2FL?=
 =?utf-8?B?c3hkaHplQ1gvVGszR09Bd2RDYS9Ya2orMnpyUWU1OHZqbWJTM3pNM25iQmVy?=
 =?utf-8?B?djVkVmhabFh2RytaWGFwdm9RMDhoVVJXaDllRkJwT2k3Q0cvTFVNbTBxWXZh?=
 =?utf-8?B?NCtiS0tiMCswTjh1eURZeUg5RE0rUThtbUl6MGd5K2NVSDFvY2c3NUhlbnZn?=
 =?utf-8?B?dTArSzZFRnhHN1U0Wk92cDB2bU84KzJlRkxka2x6V3l0KzAxeFVtTkhOOHRN?=
 =?utf-8?B?RG14N3hJY2NsRDdvOUpFeGxJOWVZck1MR3pZRzY3OHh6RHZmaFF0VWRlTU1V?=
 =?utf-8?B?Q2RZcEtyUGYwSEt2STVTbWpPemhNelpuNjB3YlN4MTEzL3dGWWpEWXJsSXR3?=
 =?utf-8?B?VTBOalcvNzNZL1NZZTJ5cFhIMlNxRXRWYVpVcHcxVjBPOVdDeVp2ZjJxZjdY?=
 =?utf-8?B?VGVYVTc0UmJZRjFMSTh1bHRpZHcyV2JGaUswa1FOVTJraldDdVFGV0NvMFhZ?=
 =?utf-8?B?eklRSU9hajBoZHRyYWJ4ZEx6VW9yMUZGdk4vSkZXbWtORmYxOU5iTHNqK0hx?=
 =?utf-8?B?MWY1OWI4VEV0WWpjL1RKZzE4Q0dQR1ArK3hwQ3IySjBkc054Z2tLVkI1OUR0?=
 =?utf-8?B?YUNjOVFLeDEvcFRtdXQ0QkJMZ3hqL25UTjNUa3ptc3FwSENmNGdHd0xtVWMr?=
 =?utf-8?B?R1E3Y2JobkNPNzh6YkJqclhRaUZRUUN2azhxbm5wUHZ5LzE0RndXV0VqWmw3?=
 =?utf-8?B?YVNYei9SN1QvQkRqMFdnOEdSZzBveDBiK3JFRzdxKzFteStKT0c2R1BoSzlJ?=
 =?utf-8?B?L2E3YlZtZCtUYnVxdkJXUUFGcHRvZXBhR1gwdTNKU1BCZmZLdm1Eb2tDdEVh?=
 =?utf-8?B?bzdScjhiWW15NFZVbVdxWVlpbGo4QVJLRGNFbmxneTlkS0F6VTRWU2ZrOGJt?=
 =?utf-8?B?M0tKbW93NFgvWHRqcU5PNjRHUndnUGlKMG90ejZRc0RnSzdJdUlVeHovdk0v?=
 =?utf-8?B?U1Y5ZWMyejF2QmhuYXBxUnlhTmNSZElFeGpRSGR5MWwwenVxK2JDS0g3R0NB?=
 =?utf-8?B?SEdVUXlWZEpXazBhOHBkcXBFOFVBV0xwdzl2VkhDVjUxdTR6bS95RnRqQWJ1?=
 =?utf-8?B?UHovLzM5eTNrMk80RDJTNS9TdnJtRVlGQWhuWnQrSlhPeE5GYS8weEVhUlpQ?=
 =?utf-8?B?dndDSE9KMjAxb01SYklQWXRUejRVVVUvWlRwYlVGeFJ5djdBNmllaVpuMTAv?=
 =?utf-8?B?V0NMWm1YRHV5aVdnZTVYQndMQmNDSG9LWDJwaVRQNGNaTlphRUwxWUdVcmxW?=
 =?utf-8?Q?zJigezYLNmmC/Sd40xN5kgKnr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd32a0c7-2857-4ffb-9210-08da94bf71ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:05:20.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3wL3fJXERQbAmQK8QpN9Fv9PHgKqOzvg3TW8nPHeZHT9CECA4tOBP44fjAReUzZTCUz8hdLS3PQalE+IEGKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_08,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120044
X-Proofpoint-GUID: b11VQatOwapxGxUwpqcd7vKsd1VBsEzb
X-Proofpoint-ORIG-GUID: b11VQatOwapxGxUwpqcd7vKsd1VBsEzb
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/09/2022 14:28, Qu Wenruo wrote:
> Normally we put (page, pg_len, pg_offset) arguments together, just like
> what __bio_add_page() does.
> 
> But in submit_extent_page(), what we got is, (page, disk_bytenr, pg_len,
> pg_offset), which sometimes can be confusing.
> 
> Change the order to (disk_bytenr, page, pg_len, pg_offset) to make it
> to follow the common schema.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
