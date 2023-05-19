Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F070A364
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 May 2023 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjESXej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjESXei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 19:34:38 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56681B3;
        Fri, 19 May 2023 16:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfAqRw4lXVKW+aR5hTnai/UW9kKiAcUcEOgoPkTTzWzZmQe+mHnzOhEdUVOSatuY59itCJyT3QcXHKXH5EysMw0guXIJmjDF8wjAAG8orXyxQpo67XJAK7YbXbbfA4+p1VCagY4wlGBklxzL1UjqvKjtAQWZeoTw/yBicREgijYtbBXWC9QRATYzAOmk54NpetnUUb8ihGNkN2DZC04GyCoQh+2/4mC8o5UcVbZJ7mxXYzsXpYnwATHY1qtIHj0x5gnKiggE6WcGInxQiwgVeki+m7pI5MowZbikjvSycQIHMxIiNrhTNbkPA5WN5aD/6u7YTTYiJ/UfgAfkVJeNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed4A3Mzu40ObwOE/CjCQgIJ62fEb8Kgp+aDRu58pxGc=;
 b=EzxO/ZxRwgEBClv2t15LGYjPfq9l2gI6oK9lC3FIIdOkJMTGcYXilQzDAGeNvheJy9jxQaBlkcFyxjICOYLtdeOea8p2JLf8Lqdqhe4sw/xOmCqPDBq9cLSZ3IDLs6aSFtC4MKrJyIYcsNaAL+Jo15odeaDekWH6IHLZ4wb18qE8ekTUboNVsQS6POicVwVdoINvnEHy1JSkDLYkdBrN1jrnkkz+lLLin6RTygGBS+llRmXlEDWHFdnv0UIbaok14waasAXtxOAppPU8kiSxssQO+qP+cqPGrZr+wI+zmvE7prYpbw38Oh3zARHGcLQoHz9ljwWZuKxQ1qCzv5uXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed4A3Mzu40ObwOE/CjCQgIJ62fEb8Kgp+aDRu58pxGc=;
 b=ymoKn0IdJKh4vHlnz7QVOCn4HERFxuVxpisEeYuc7pSpvg8yOQsAjNB904NPs+MJI6Y7ckvULHd0AarYEHCaNwXA9HlhpSbcU36hi4FlM7fPONb+w/Uk9sWVCsu7g1bQc60API6p2aC4Dpx2+25fLeSlypgJHPMP5+ChstesRR5RDYOhWDPrfbOwMl3aEnl23FaPsvvgDox/ULknHTIZg+vriPQ6btOqPtWQ2pMh2jT64B3cMdqZ/HC0o6pWoI6ZBYwApsqzaZkwY7/fyKDwYt17t1sFnv8RC7wpF/FcbtMDjZHhSzuSqLTyhVUs6d+CzKu3ICJsoUlMLNvWtFsYAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB9114.eurprd04.prod.outlook.com (2603:10a6:10:2f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 23:34:33 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 23:34:33 +0000
Message-ID: <baa42ee1-c2fd-7405-092e-525f2441a281@suse.com>
Date:   Sat, 20 May 2023 07:34:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] btrfs/213: avoid occasional failure due to already
 finished balance
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
 <ff12321e5ddfdb763b9258f746e67fe3f6ea1321.1684489375.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <ff12321e5ddfdb763b9258f746e67fe3f6ea1321.1684489375.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0672335a-0bb1-47b6-180c-08db58c199ba
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7EjIHwaxvz56nz8IUF+SJN+qlI3GyiIdBGLymHosUxGVC0gg+9+MExv/+Di0JYJmEN4S5o6M5xWm3wEJ5ZRYt2ELhrhbKQmGZGvhXTDdDA070qs0C0oLF3D0gzgoAs0xHgmCKrHjcL7ROlP4nGl7nGcdkS0UsMc2QPmme1e7QeCrpL9Pn7VYGskBScciOx+P9pZm4d+vL94+Jxr8hmdkOiFraSrZxoS0lDNOi6r0y3SfGXY5+6ueDphjA+Mor4U2RVdr/jZ3JeQbXi5D0XMrlB0I4Iw8kpL4HBBVNr37oy60HjBBOGxLAeVX6H82pjSKQKhjCiNbSSQLmUle/He+r/kIs+RtVm7//JXywfscWtQBqh+HEOY7D3I5Wk9/eGWq6poCs0o1pFeyHoNQN4d+cBFlad7YAehwvsoaaV8IRdiV388QcafY/2BxMn7vH8INQVxqse4lrVHsgOqYQMqpw4XYKvfah+iGiIWsaUB/f2w5g9tDw5NyQphmsvoAVMZ27MCPZL/uYmE2EQhECe4e4DF9IExdiKdCuLwDP/DE3NpPSpke0UgsqMQyYyM4qCzjOlQQkEUL0dVAQczUP3/+5L65r7BuQJ+YCY9eFpzJgoKggVqFoRpZOq2qKdP4UFkeTH/Gyiht8gr5XhVfnVQbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39850400004)(376002)(346002)(451199021)(66556008)(66946007)(66476007)(4326008)(8676002)(8936002)(316002)(31686004)(478600001)(41300700001)(6666004)(86362001)(2906002)(31696002)(53546011)(6506007)(6512007)(36756003)(6486002)(107886003)(38100700002)(186003)(5660300002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDY2REhEQ3ZiVWhFNi8vZ0JMZUtTOVE1Tmp1bzIxSjJrdTBlK0ltOFlMQ0RL?=
 =?utf-8?B?eHYvYUlVNmdCOUdUM3EzSmVGUFJWU2FSbCsreGd3R3BhRkd3UWdkQ1hicWZX?=
 =?utf-8?B?K0JXdGZabVN4NU9yRDk2bU55N1Vuakk5NVMrMHRzOGFCeVM0S2hBdWlSeUVt?=
 =?utf-8?B?NUNFZGk1QW4zNmtBdG9ub0pVMWU4d0o3c1ZVZFVvckl0TEtxK1plNHhwSCtW?=
 =?utf-8?B?dG5sQVF0UFg2Y0xzc25UT0FSWm9nMnRXSjhxdUlCS1FqT2Y5cWgwY1ltd0s1?=
 =?utf-8?B?eVJoSDVDRjdEUkZnc2dDS1BTZ2FRd0lZNGdobnd1Ky9uUFplTklzNi9vNkZo?=
 =?utf-8?B?ODRwbStGbkZIVkVLcWFtb0ZicWEvM2tuT1RSZnhsdUtuRlQwT29RR0p3ZHJj?=
 =?utf-8?B?Vmo2a1d2NFBzOXpQb2o1RFlXbWhoczhyWEdtdmZCeHkxR3lkVnc1V3k2c1BO?=
 =?utf-8?B?dWlTSXJaV0w2dGxKVHdVbEwyYkdkdDZVTjNOSHNNRmdhMDliQUQwK0tzZkt5?=
 =?utf-8?B?cUdKWUg3NDNGNUZMWDczRXBvVzE3aDZ3NFF3ZDlxZmFYZGduUngzd0R5R1JR?=
 =?utf-8?B?WTdBK1hFTWwzaExLOTYxYmJwTHVNSGxleHRDOGtIMmtsNG8yZExtU3ZQWVdo?=
 =?utf-8?B?U3J2SUFRbkd0cDNXMTdGSy9TbWZrNjAzZExJRFlRZGlwSEk3N0xZd0VYaWEx?=
 =?utf-8?B?UUtsa3hCaXdIdVpZdVA3bHdsUTlJWmExdERtcTJzampBWmFJSmhiQnJaVjBN?=
 =?utf-8?B?SDRVRGtxUCt4L1Vtc0lUMExJd0NUWmttRGRVN2xmSHJ1V1BBRDdFYStEZFdQ?=
 =?utf-8?B?MytOMGJvVjRxeFBZcVFjcTJ6YVNYSFBnUDRMSEp1VGNDa3BXRzY4QThBWVBi?=
 =?utf-8?B?VUh6QmE3QWdEb0kzamZtNy8xb0ErdEM4YlJEQ0FKSlhxMzZ3OXZ5QmNvR094?=
 =?utf-8?B?RzVpNFBxUlpFdElEM2xQYmZwZmJINVMwcFkwM3pKU1l6dTlTaXBQT3FHZ3RQ?=
 =?utf-8?B?bVphSFg1WXMycGM0VVlZS2VFTitZTElnMnBwQ1pYRkYwa2VjUmVSeHRnclFI?=
 =?utf-8?B?Q0Y5N1VyMlFXNjJxaUcrbitpSnUzZHRFc2NhMkZrWE5hMjR3ajNDSG9ZT1dK?=
 =?utf-8?B?amw0UnpHN3UxVmc2WUFFVFFONGIreHY5YkJHaHRtY3ZDUlhaWFZuMFBvbzdm?=
 =?utf-8?B?NzhWMm5KZDJxYjh1TVpqYmtXdDZQQmtLR1lXVTEveWJsSndvcVZxQm5tRlZ3?=
 =?utf-8?B?bndBZEt4OXZoMlVOQjJENkNIb0YvN0FUeE5hWklZV0d2STBHMnZBdnpzSE45?=
 =?utf-8?B?SEdBa1UyajQrS29Pa0NDd1QrVUlZTmt0NzlNVWQ1cktBNzZkNzUvUFp0blM3?=
 =?utf-8?B?ZnJVV25mMnVpbGwrRWk1dXBjZWRqVVBJWS95MnpTKzQrTWt5d1hKUDg1STJx?=
 =?utf-8?B?ajZmb25BM0pqR0RYSDg3dHdtblR5MzYweGJWZnF3azZYLzRjRmRIdWxHRGp3?=
 =?utf-8?B?QUd5WEt2U1RzaTlnTEl2UDFWeXZ6Y2VNV1hkdG8zS2swRlpiQzBSOCtOU2gz?=
 =?utf-8?B?bGdUbDJSeWZkSFI3SDU1WG9YTnAvS0lydTFQRVpUSGxoendmK2VoZk0wcXFy?=
 =?utf-8?B?OEdIcDV6TW1HTHZtcU01Y2ZxUWltc0w2cHhkUSs2Q0p0cnhHUDRsMmVQcS9k?=
 =?utf-8?B?OTJBVFU4UHZaUnNjdXpmdXQ4VmdmUXZpcllzSTQyQkpkY1poQjlwdjZaMzd5?=
 =?utf-8?B?dnMwUVArZTd6QzMxNnlLbkN6VnE1Wmh6cmZkNjZRRU5HQUl4K3R3ckZ5dm9Z?=
 =?utf-8?B?ODZkd3dxRDJneEw4TzJPQWtQQkd1Tnc1ZlNXZnpsOTczeFRXSDBPc1lXT1hJ?=
 =?utf-8?B?RUxFN3kycGFuclRSUmVMY3B5Q2w0MFc0VFN2bjdsWUJhRXJPS2hiYVY4dVhn?=
 =?utf-8?B?N21NYy9DRGVRYmladjZwT21ERTJiMlVIem11TytPMzJBK0F0SHJ5SldjcGVr?=
 =?utf-8?B?Y0FPUEVmN0wzTWV5a1dCblZHTytha2FyMEJQWklFSXNKR0RNMmx1UkQ4NE01?=
 =?utf-8?B?MXkxVHRwV1V2RVZaVU1MQ254aSsvczNxckVXMUsyZUl6WFZ6WWtGalViQ0V0?=
 =?utf-8?B?MFhyaXFuWnY5MkJUQk9hVVlqL054TSt0aVZuOWk0SkdmS2QwSWFwdHJFRW85?=
 =?utf-8?Q?fmyDgFvShHlbufyqkza/IC0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0672335a-0bb1-47b6-180c-08db58c199ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 23:34:33.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMmhafD5uKTtpHqDgOVfXrzyGpzisFDKtLU4d9rSNy0xh11phWbdnTi+nNCKlu9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9114
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/19 17:57, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/213 writes data, in 1M extents, for 4 seconds into a file, then
> triggers a balance and then after 2 seconds it tries to cancel the
> balance operation. More often than not, this works because the balance
> is still running after 2 seconds. However it also fails sporadically
> because balance has finished in less than 2 seconds, which is plausible
> since data and metadata are cached or other factors such as virtualized
> environment. When that's the case, it fails like this:
> 
>    $ ./check btrfs/213
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc1-btrfs-next-131+ #1 SMP PREEMPT_DYNAMIC Thu May 11 11:26:19 WEST 2023
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/213 51s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad)
>        --- tests/btrfs/213.out	2020-06-10 19:29:03.822519250 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad	2023-05-17 15:39:32.653727223 +0100
>        @@ -1,2 +1,3 @@
>         QA output created by 213
>        +ERROR: balance cancel on '/home/fdmanana/btrfs-tests/scratch_1' failed: Not in progress
>         Silence is golden
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/213.out /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad'  to see the entire diff)
>    Ran: btrfs/213
>    Failures: btrfs/213
>    Failed 1 of 1 tests
> 
> To make it much less likely that balance has already finished before we
> try to cancel it, unmount and mount again the filesystem before starting
> balance, to clear cached metadata and data, and also double the time we
> spend writing 1M data extents. Also make the test not run with an
> informative message if we detect that balance finished before we could
> cancel it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> 
> v2: Make the test _notrun if we detect that balance finished before we
>      could cancel it.
> 
>   tests/btrfs/213 | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> index e16e41c0..5666d9b9 100755
> --- a/tests/btrfs/213
> +++ b/tests/btrfs/213
> @@ -31,7 +31,7 @@ _fixed_by_kernel_commit 1dae7e0e58b4 \
>   _scratch_mkfs >> $seqres.full
>   _scratch_mount
>   
> -runtime=4
> +runtime=8
>   
>   # Create enough IO so that we need around $runtime seconds to relocate it.
>   #
> @@ -42,11 +42,21 @@ sleep $runtime
>   kill $write_pid
>   wait $write_pid
>   
> +# Unmount and mount again the fs to clear any cached data and metadata, so that
> +# it's less likely balance has already finished when we try to cancel it below.
> +_scratch_cycle_mount
> +
>   # Now balance should take at least $runtime seconds, we can cancel it at
>   # $runtime/2 to ensure a success cancel.
>   _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
> -sleep $(($runtime / 2))
> -$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> +sleep $(($runtime / 4))
> +# It's possible that balance has already completed. It's unlikely but often
> +# it may happen due to virtualization, caching and other factors, so ignore
> +# any error about no balance currently running.
> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in progress'
> +if [ $? -eq 0 ]; then
> +	_not_run "balance finished before we could cancel it"
> +fi
>   
>   # Now check if we can finish relocating metadata, which should finish very
>   # quickly.
