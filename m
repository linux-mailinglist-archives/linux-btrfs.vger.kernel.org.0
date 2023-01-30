Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78B680676
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 08:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjA3H2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 02:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjA3H2i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 02:28:38 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED282331E
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 23:28:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwn4OvvN71SbDWkPpy5HH8Wxgmce8O2bQWCIhwjIujao1TNZ089in+AZH96RPq4JCbNengYHnjPga+R8WZnO6H5aN0j5NijtmZKTtGSMWnmDyTinR8k0MF5yTZzwc9cPkahoeMxShcsy5Mxx0RsQjWlwXzL37Qf8A0tHSD3nFw2AOtdLWF8gU15sPsyIcwgo8qfo6YQ2fN+UA0zkqW2yNZCIVeExfj2lsZxWyGL4/P8DU4wNkexlCxmV8W75M5L/JfEFNcLeKsoZOxeNDXEXl7pbmR6wDtayznALOcd1QltXmM54QmGy2Wkc5mSwDkMESH9uX2OC8igxV/wOgO0Z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsqQFFPwgO7Ir4mNQjpe7GhMwNsYlsa2tjh3cr34AwE=;
 b=K8Agq0SrYWDllgIIXBMoaOz9t2O9s/w0OD9ANrBJbScIpwwx+M4qnW/yOlrirr3fNemmf+UB199HRmBhPYENB5uqjh3CXjHWR4fbAkh9P68D2v3z5lxJiT9SbnTitoOnKzW3VI4MKOTyM63AIA8L/pFNfxId2Bq9Z0h1Br/yjFkpDn6msuqPvkKTildSfWsp4Pk7vEfZiAVKU0y1ZoF75/MUdshXpwUefHU8qN3oljju2MsO9aAsiPvYE10HTHMlC0HN0htS4N4dny566EgZspyockqzx2spSv6WhRtGoNuZD3JbhSarZCowun2hVB0kIOgUN7L2fPXwqW7t3Un/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsqQFFPwgO7Ir4mNQjpe7GhMwNsYlsa2tjh3cr34AwE=;
 b=tzD/f4bNemJlRK+DyEJNfcHKJnRUkqPYE/I2F4KFwQ+J1cT/tNiBqAHeD/Ydk1J/jIuWQBa64pu+rDm6qLRT5KcCDj++fMPf+f87vr50099qeZo5rk3XJJ+/8FfDJ/vo+geEu4dFOoyrLEpHZq5vKewI2fT24pkod1jZaCNqtULzq2ZNlNDPZh5ArBX4iL2QMdzEUJqe7V60hDfxjFnRajUm60d0I0/YKSj/tKLbDuo9OF6kHWIomXV0BucLjw1ZRCN6cxyQ62PWl0izoaXlg7hD5Vvb6Oh6qxR4/6uCJnidQ+fKxfH/o3tJbXvalQYdNpDioMPV4fB3Kf9LXvKNOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB7089.eurprd04.prod.outlook.com (2603:10a6:208:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Mon, 30 Jan
 2023 07:28:33 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%9]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 07:28:33 +0000
Message-ID: <e16dd0dc-da4f-e49c-2257-9180b636f59d@suse.com>
Date:   Mon, 30 Jan 2023 15:28:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/5] btrfs-progs: minor fixes for clang warnings
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1674797823.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b76d0b9-8e50-4f25-5e0f-08db02939787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnwOaWb52XErVM+G7Li+Aua1tK2H/WCdhN1LvlUKeOSpf9SNi99FhhHAb6GtjAvBGqjcWwgN+Spnup4y4hnM6py3SvKVzvjKF86CdPE6ypjERMU3imekr+Ml72ZUdFa3FZuj+FKddOQGFxxNPoO7tx5kI9XVp9RL+1M24JNiTEP3BhbTv977a8aEJPS0258xExlf7KrKT83u2/U1Pb6yPutZUuferZFnORHMFzuT962QgO27wVjU7JuqHlSQtD98c0GmPCq71930RRRnbw8TyIO57Od3Xbt7P+j74jisW+lziQB6PndkaslOPik5K9NYR6tfKwD/3Kp3Wgp6RdOCTkooKwA60cFldeWQGF936PvtTufmoW6dN7GPNn7EVW1feYUW530Vq8Zo6JMyBxJkX9MimCqmFq+2rWoyXFP3GWDl3OXBh8idqfD2QzISSSXy5TSHc50Mauoz+A4FJUd0BbG/UHmfnx3BlGYW3FkWx/q5J4rTTk/eUtvwPkOj2/xO39Lah5UmPRKxuQCoxpGsyqrpmDaLgcuHCWzOgx8yE/MhFXZFEsefO3GMoIcYz3H7ovqCAmRHEZfrSm9aL8fVoBBk67TmB4AteZ+2oqL7vszYLnOeyZ5Cer99dXpiggyKi0hjwe/ixFrERKhpIjramcsvlqODHjDAzisBTKMJAXdhi4QC/hV6s7pqHWdzOtqFgJoQtgJucPfP7o4GwyUSJGgrK9gYlMcC3KSYlRFVXOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(8676002)(6916009)(66476007)(66946007)(8936002)(66556008)(316002)(5660300002)(31686004)(41300700001)(2906002)(6512007)(6486002)(478600001)(6506007)(6666004)(53546011)(2616005)(36756003)(186003)(83380400001)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdCeGZ6U3BDZ3d5eldtNjZvNzFlRm1RWmQweVNqdjZJOFJYbDFtR2FMVzN6?=
 =?utf-8?B?RGpmeWpzSTFiellEemY4NTdVdDZWaW5iQTNKVXZ6UTZVaGp0S1VISTZmc0tQ?=
 =?utf-8?B?eHhlUjQ3ajlTNUo2eVMzT3dhV09XZ0FPaC90WHl6ekcwZEtKQVRILzg5K1Nj?=
 =?utf-8?B?eDI3dXpQQnk1WFJBUDQ1Z0YraWhjNGI3cWptMThZWU14ektNQUtrOXBybHkz?=
 =?utf-8?B?UkxITU54NE0yMER5L0lGdkpBWGhPV0RDcGRhNS9FeEZUa2RyMkNRcVRoMVFx?=
 =?utf-8?B?OGNRMEZNbVZjRVNzNFlQR3JpR0VDNGhHa1NrRXRTTlJkeFN4Q2lRN1VsVldP?=
 =?utf-8?B?Q3M0dytGSXdCM3R2dXd4QlhnTDcwR3k1ZjJNeHpSbmwybGs4UTdoaXI4bkNx?=
 =?utf-8?B?L3pxenBCYjVjdm82M0ZVbjBqT3BhVzUwZHpDY3FaRXRBcmdlVTVwZ2E0M2pO?=
 =?utf-8?B?TmswaTdGTmhtWXBsNzlsK01HRkVQemJFbjJvQmdRRzJ5WFA0R1c3T1lYRFg1?=
 =?utf-8?B?cXlYcit2cTJrZVhBZkRVK2k5eFBXUHdTR21JMkxLRk1ONDlYbHQxUjh5aFgz?=
 =?utf-8?B?N2xxVkU0dE03MDBuOVlSRFZta01xd1M1NmsvVlJuVWtXbDVpZFJyWjZpL1Y4?=
 =?utf-8?B?QjlzaWszbnNLUUJhN214alkxRTc3SC9UWm9XRUlKUWwvQ3kwYlBlMzZTcU5T?=
 =?utf-8?B?MWU1ZmJYVldURzZiTnV0aitGVGp3YXRzRm5Gc2JFekxzWGdRMzFSczBaTkVq?=
 =?utf-8?B?VEJqbjFhYk1iNXd0ZmRsQTFlN3FvZU5ZcUtlZ3h4NXdjZUFwbjdha0pNMXR2?=
 =?utf-8?B?amticGExcm95OSsxZi92Ty8waE9udWt3WVduTW8yTkhYZThzV2pkYzd3eUc1?=
 =?utf-8?B?RDgrbWdRY1lHWEZNL3NpMm1XRXhRRWJJSUZMTHQ3TGk1L2Z0dnhvQ3hObExP?=
 =?utf-8?B?Mk9kSGNHWmZBNGJBTXZCaDdiQUxibklpZ0dTTUY1YUlhL0k0VWFhQ3kvMkw0?=
 =?utf-8?B?K0ZCVDg5R2dnZGFnVG9xemI2SWtma01Td3NKdjljZmdoeFJGcDNMRWJGR0Np?=
 =?utf-8?B?c3NQc2VxbGxPZ0lORzE3V29Ra085Q1g2MUF2YXEzTnVoUE5BdzA4ellUVWtO?=
 =?utf-8?B?MUx6OWdzQjUyWjdWSWk2bXp2Q3JteUw3YU9DRUQyVVVLd3c2VU1XUjdwMTdE?=
 =?utf-8?B?Zk9iZ3RHRlAwdXVxVVd4SHFSYzlGUjduWTVHL3FtVHpHUmc1T0drai9EUEx2?=
 =?utf-8?B?UXN2T0pDWVd6aGw3bUFVWHJnQXNENVUzR3d3R29UZUlxMnlMZHY1c2Z2aTdq?=
 =?utf-8?B?d3JCOVAwVndpSFVYZ3RqU0t5R1MreCtlWWkvU2ZNTTZ0VDdkM25saUhKQkow?=
 =?utf-8?B?MUxIUnQxTThnWVpFRUdXQ2ZXTG96N3Z2S05QVlE0OEJ1QkYwNFVTbzJYZzJH?=
 =?utf-8?B?Z2lQR3NMY2ZZbmlLR01GOTkrcG5xY2FTalVBWmFQcWduQzRwMHRpMjdzZmRE?=
 =?utf-8?B?Q3FKR3JGSkdIWTFtRTlPSElFQzZIVzdqZE1DVFVrSldVTHBaVlhyTDBNdml5?=
 =?utf-8?B?ZnZrVXFKcllNM2dsK0grdWhHckdVYXNtUXl2NzdRcWlRUlNrU3hObjlxU1dr?=
 =?utf-8?B?eGpCTm1EbVJuWHNWM1dESzc4WDYxRGw4QmFLRUJBOEJ0dUhQU3Rvemw5RndB?=
 =?utf-8?B?SUZUQ2srTXJwT29LQ2NxekRoR0RtcHAwejEwR1BTN1hpWnFUK2NmV0Vhd0ZH?=
 =?utf-8?B?a2dkZ0tKbWs1NFNLVjc3NWw3Yk05M1JBUDRQWDFxRTB3UTF4OE8yVWh2Mkts?=
 =?utf-8?B?T2N3US8ydks2TXFwcFM2eU5SREtpMHVQTUl6OGhKUGxNMERuc0tpTi9MbVc3?=
 =?utf-8?B?TFBwekNKdFdTNm1IdVdielF2cG0ydmRFdHN5eXViYTRTTlcyTTgxUHRrM3Zm?=
 =?utf-8?B?Qkg1bWNTT01uVmFvNkdleWExejc4UzZVa1RNaUpmZlhtT2o2WWNGOWdCZXF3?=
 =?utf-8?B?b0VFdTE1elplaStFS0h4K3RsRng1RzVkM0pGeE1zT2F5MXJLZUNqdGhFRXk5?=
 =?utf-8?B?RGo3MlJJeGpOR2s4amlncnB1TXBVc0hibHd1a2tFOXo5WEFpV1dMaE1BWXJu?=
 =?utf-8?B?UzVaQjJEYWsrK2tld1F4YjJhOEE0YTVIWktKbkV2WEFCYUJsd2lvMzNXNnVy?=
 =?utf-8?Q?75xfn848cjKsoXhf5vmtIso=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b76d0b9-8e50-4f25-5e0f-08db02939787
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 07:28:33.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i9QkxGxIKRqemts1Wpxo9TjA83L2YDdl3wHsraV7EXrhrEQloKYAbdMaWDhu4ww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/27 13:41, Qu Wenruo wrote:
> Recently I'm migrating my default compiler from GCC to clang, mostly to
> get short comiling time (especially important on my aarch64 machines).

Just to mention, although the cleanup itself still makes sense, it 
doesn't make any sense to migrate to clang, at least on my aarch64 machines.

GCC takes only 22min for my trimmed kernel config, while the same config 
takes clang 32min...

Thanks,
Qu

> 
> Thus I hit those (mostly false alerts) warnings in btrfs-progs, and come
> up with this patchset.
> 
> Unfortunately there is still libbtrfsutils causing warnings in
> setuptools, as it's still using the default flags from gcc no matter
> what.
> 
> Qu Wenruo (5):
>    btrfs-progs: remove an unnecessary branch to silent the clang warning
>    btrfs-progs: fix a false alert on an uninitialized variable when
>      BUG_ON() is involved.
>    btrfs-progs: fix fallthrough cases with proper attributes
>    btrfs-progs: move a union with variable sized type to the end
>    btrfs-progs: fix set but not used variables
> 
>   cmds/reflink.c              |  2 +-
>   cmds/scrub.c                | 12 +++---
>   common/format-output.c      |  2 +-
>   common/parse-utils.c        | 12 +++---
>   common/units.c              |  6 +--
>   crypto/xxhash.c             | 73 +++++++++++++++++++------------------
>   image/main.c                | 15 +++-----
>   kerncompat.h                |  8 ++++
>   kernel-shared/ctree.c       | 18 +++++----
>   kernel-shared/extent-tree.c |  4 +-
>   kernel-shared/print-tree.c  |  2 +-
>   kernel-shared/volumes.c     |  3 +-
>   kernel-shared/zoned.c       |  6 +--
>   mkfs/main.c                 |  4 --
>   14 files changed, 84 insertions(+), 83 deletions(-)
> 
