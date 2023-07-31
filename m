Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74076A26A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGaVGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 17:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGaVGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 17:06:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D36194
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 14:06:02 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VHWaEd001216;
        Mon, 31 Jul 2023 14:05:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2Xv6LWCK2PJzHxi/NuCKHVIqHJxFB+2ler8mxT5q2bs=;
 b=WJ+aNCWj3Ns48j5QZox97KZaRaPqIU1Yb/dKCZ8AoAzWgPIfHS8xjQGhSR6axs6bImcm
 hcjm4thNrF+4Nv7w2hljqNXwHmKO2gVcwmwbRgGCd5iie5MQV099by4jeIOGCma3y6yP
 Mh3JQugkDQVeRzkUmNtjigF1i1uPnv+Pky4pJ2I0Ucq/ILDLgTV5I+IS54DofNfO809N
 cCBybQaTEFtoPbCsmZIwHL77Fm1PKh+H4+EgNJXlUfVzUvb2i1H0bAvSdaXfOr/AV+AH
 bmrO+oik7F5+CqqVTTP53DD51PRL11X7XE3rBrITkUvBCbfHJnH1T9sI7eYfSzjw4KNV yg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s5rytt8kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 14:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM/9k0LYHJKDpC9xm+gi27Kd4qT7n6WOFbOzrRoLQfvv2VvTtc7fq0niyEZBh+8CQPbKw/mrhJehl7RYooLHfEaXZQehcuRPMQ+6EJ5GThWoBHCFLFsEtmMziw4GduKsTj0t0igtOmwCSfl2kl79cuRWDiSLEmjl7jFZvuNrtgBwmIQrgKiuA1KIBJWbZgKfHhWBBvXuKwXfzn7d2JK5fq1YR3vgqU7Jc0NqmXUvSxgBr6jgGEGPzI20j6c4AwK6dY39eqTpCkRA88K2X46/V/TolMPdJmm8EiS5fIvdmaq5NSJR/aCcivJBF4X9c6oZd5hhCNwrtrIFp+Vmv9UUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xv6LWCK2PJzHxi/NuCKHVIqHJxFB+2ler8mxT5q2bs=;
 b=A5uuqqQ1FsheFw0j0hUV0mUMxI3bMvGh8y4oUYZr0ngT+IZ1czWvxRLVXEXRX/W24Odn4J/uj0z2p941aPefc/R5HCqyYWzPAtma+niI1inXWw7jtpi8OapGKvP6TIYYHYto39i4FMEatTZKdyvAb4Thet6rS7mKRCaxDhnwg8Luou1uDywZinoDG/epgW5bkDtb7UzmLFJjRc+V3r4YNM4CuU82U4iQvgl+6GQHgr1qO3vI0zd4OQgYHMT07cSZjhkbXLRY/XrSUfKnSM6fUiRS0k13cj5rF2sabuYFSwO/XCBUlzww4R4wDJYw0NBosbHjrYrSzL+tsTrupcK2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BY3PR15MB4897.namprd15.prod.outlook.com (2603:10b6:a03:3c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 21:05:20 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80%5]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 21:05:19 +0000
Message-ID: <a12c5565-81c6-1c70-725f-c5130c18f7f6@meta.com>
Date:   Mon, 31 Jul 2023 17:05:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com
References: <20230730190226.4001117-1-clm@fb.com>
 <20230731070025.GA31096@lst.de>
 <35b14d0e-3a53-fca7-8290-b26f31d07fb5@meta.com>
 <20230731193543.GA13557@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230731193543.GA13557@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|BY3PR15MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f6f103-3eb3-45f5-862b-08db9209d8d6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4USMR2WpxBIF492XiXCHLZBj68Xmon5X76metnzssH56F8+lUkLtybwG17HuXFPZQyb6ZRGaMrcuYottXGmYVoQSBWMpkQxofzJHQVfCfCGhDiaYsoLJB5sBThTS+ACLd98TVSQhsxoEvQir1mADUQIQNLzGHCeNj8ds02UGjONPnUSjDyKPhQL9fAUn04dGnjhbfPLldZ9gh1UdS/GDAq1rZ2Ju6l4E5U/gExGFOmd9yn6kNpxAyIWjxKl+GyYd8a0khvCZ24c/4PcQbDN0S8+RBmjxsEDaRa5QcAL5B3aZpuZNguY+wynTYUQfqbx2/jeN/MENNhORmbZuAoCvol4pBo+vztU51BEhH3dvOYc7Y+3Cf8mIsF1kh06JiUaiNGze6sNMkilE1j/ukJ9b8W6m8hHM4oZivqUl27nj0Tt6vW6TXLBOY7BA7RoIRDm8n0MyYmRYtJh/I3dmeXloRHlX1ebMzFWGjB20kvXoJyu3SDHUgRCBbQpePSmaugznxpFfJvW85fzc7Dq01xWPtUv/UinIaFps/ZmHkx5L2NwF4eZBsmVfH7AvcPsKHzRMCxJMHSw49YGHYTTaYw1DvZP4NYlu31z58QODF+n0LqF96gvKafbxy/IAxJlx4C6L78/njQTqGkpojeRxNqMXnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(6506007)(5660300002)(66556008)(4326008)(66946007)(6916009)(66476007)(41300700001)(8676002)(8936002)(186003)(6512007)(31686004)(6486002)(2616005)(83380400001)(53546011)(38100700002)(86362001)(31696002)(316002)(36756003)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJuTVgyY3JyUHkyTTZmSEVZcERaZjVKaU5lTHZkQjBBbms3am92UktSUFNO?=
 =?utf-8?B?MXdDTVk2dDRPZE1hNnQxSld0U0FUWHNwbGJvVlpLa3BNbXBpWHRwWkErMnhR?=
 =?utf-8?B?L1Y1Y0FoRFFCeXFhejVpWGcwcnhqU0k4SC96VlE2Vlhqd2Nia01RemdBaWty?=
 =?utf-8?B?UnlTOEJtQTNuYXlUS3cxSXRVU1UzTGYzdDV1YWJuZE83WFFENnQrd0ExcWs1?=
 =?utf-8?B?bHN4Z0U3dHQ4M0JVa29TRGowMlA0ZUJZSW9GeGtlRGFENjNBTXhzR2lpZjg2?=
 =?utf-8?B?ZmZRd2ZMSlVxSDBTdGFWQThHYVpjcThmQ2xkUm5CRTRuNVNDSGJHSnBsaEFD?=
 =?utf-8?B?QWVOOXdlcnRPU2lEcmNkZkgvMnBMWW5oNnZqSzRxNzNLUjRUQUFuekJlKzkx?=
 =?utf-8?B?ZmNkcXM5WmJDSThSTFVEMXdmVklLcGJ1WVB2ZmR6MUUwYk5ZNXJaY1dRbkda?=
 =?utf-8?B?N0VwQkdVbEY0YW54NjhTSDJYYWtQMk1BZk5RT0s4aDZzVTdzY05VVTFQQVNZ?=
 =?utf-8?B?N2Z1a0JxSkh2T3l6OEV4Q2dIdXhFQWFweDVuOWdzNEIrakhkYTlYNEkzY01s?=
 =?utf-8?B?OVVUTkFVWGVvRzloVmdDVFNOYzN5ZXFZT2p1MzN3Y3FaU1pTTng0Nm1TZWRr?=
 =?utf-8?B?Z1hIYmoxcjYxQ1MyNjVYTnhHaTg2aWROU2kwSEh0d1pjWlh6eDFhNEZzTE5N?=
 =?utf-8?B?THB3anlrdXpqaVdJbjYrWkJ0eW83SzlsQ0k3dVBSTzBSczd6S0lnNWdidm4r?=
 =?utf-8?B?ckI4eUNaYUJld3pIVlRBRVlTSkx2OTkyc2Z5dUZ2MVUyUjIwK1A5QjQ5bFpI?=
 =?utf-8?B?d0dQem5DVGswSC9FVDhEMGcwWVY4aDJLaHgrNytiSm5EMmJpc1RJWkx2RjNt?=
 =?utf-8?B?cnlRR0hLNjIxdTNzTktkUEZQZWNET1pCUGl3ODRTUUFyY3VYQXZwb1RKWEs5?=
 =?utf-8?B?QVM3cDlEZ1czd3pTVWFrVldJYmFiS2lEc1BPWmREb29OZ1c5eWpqNGpqMDBk?=
 =?utf-8?B?Ukx3ZVE1UlJra0lGRWVndi9IWS9BTTJFbTh6YzI3QTFWK2Q1QVcwZmVtdkoy?=
 =?utf-8?B?TUVXTk40a0dUWDZUYkxBNUViczBSeUs1c2ovR0Fua3J5R0tkbmN2M2wzZnlp?=
 =?utf-8?B?UlVHbmJjRit0UUtob3VocWMvU0l0bEFJWWlFWGZ1ckttNVJEVkEwcE9yZXI5?=
 =?utf-8?B?T0ZBeXBNby9KbmFFZVEyY2lhV0xmT0VVb1NLK3RkOE5hQXN1bFUrU2IrNzhk?=
 =?utf-8?B?bGNOSzkwdit2TG8wUjhPU0FZaGNDS29UeEJqc2U0OG43NTlFeFlKeFNzTlYw?=
 =?utf-8?B?SE1rMUs3RkJQZjVaNTArdFFuU2YwaFM5TzZIQi9KVkVIU1VjeWRRVTlMa3l0?=
 =?utf-8?B?RGUvZUJXU2FxZWEzZWlETkZuaGl3aVhhQ1h1T3pjOFFkdVAzWFUyMG1ZL09k?=
 =?utf-8?B?TDVEMVlZb3FJcEw4SmFBOG8rWkpBY3hsLzFCKzFLdjUzNFlFeGVhUzdiYVpk?=
 =?utf-8?B?cWZjbnJwTmMvZzNBc1NrczhHbDNTNkFKL2Rwd1BFc2xMdlJnYTNKRllTeXZo?=
 =?utf-8?B?aVZGTHYxVmxwUXJ5TFpHcGtqcjJNclJ0cm1tdy9SMXRyaWt6NzlzSllTRGNY?=
 =?utf-8?B?N0ppYTBTbmZOWnZobDRENitmR2JGT0l6aEtiTU52L2RvRjZ4bHVVTVhDUnRW?=
 =?utf-8?B?QU0xSW9PYVJvTG5iSUpjQS8yd0F4L2RCczA2Skt4aUZYZVVFbFpCRWsrTnVM?=
 =?utf-8?B?L1U3eUJZeVV2OStEdmowUGlUS0Z5Y09xMDN2c2V6L3NvdldJM2VsTWFpSUJ0?=
 =?utf-8?B?NG5qR0hTVHVqZEtkdnlqcVNkVFArTkNiRmxvUW14b2tBc2Q0S2lPaHhTcnZl?=
 =?utf-8?B?aUJYWTN4Q3owdFRmc1k3Ylo3YWJDVGlOK1NsR2JmeUFES0YxRmFzbUQ5T3BJ?=
 =?utf-8?B?eTBCTWpNdGlrSkZYOEhkQWMrdFBZeWpFdi9vYW5PcVJmTkhFSWtWcEZ4Mzc5?=
 =?utf-8?B?WEJVQUx3SUsySEJvK1J1K241MWV3emsvVEVTd3hhNC9HYTByN0FxSjZKQ1B2?=
 =?utf-8?B?UWczOTdkL3RYN0NMZFI5MEFoSHhFUmZONjBmL3ZGN0hyejA4NHkwRHVJa2hY?=
 =?utf-8?B?K21kNTY3QWowTDZ4UDZaSGtZMW0zZmJxZFA1U3V6TEY3TWFYYTdPMHUvYjRQ?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f6f103-3eb3-45f5-862b-08db9209d8d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 21:05:19.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5FTydkDTrYTjwvvkQApmwUzovKICedTSrSU7SAnog/TYL/G+N2hccw3GpVpqC6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4897
X-Proofpoint-GUID: Hnt-KhrEhqnZqr2HNGodHtViye5Uzk43
X-Proofpoint-ORIG-GUID: Hnt-KhrEhqnZqr2HNGodHtViye5Uzk43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/31/23 3:35 PM, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 02:52:23PM -0400, Chris Mason wrote:
>>> I'm torn.  On the one hand "btrfs: limit write bios to a single ordered
>>> extent" is a pretty significant behavior change, on the other hand
>>> stable-only patches with totally different behavior are always a bit
>>> strange.
>>
>> When are we creating bios without bio_ctrl->wbc set?  I think reads will
>> do this?
> 
> Yes.  These days the bio_ctrl is only used for data I/O, and
> bio_ctrl->wbc is set for all writeback I/O, and clear for all read I/O.

Ok, the script needs updating to set the read_ahead_kb on the correct bdi,
but it triggers reliably for me upstream after 6 or 7 loops.

The trace is different, but we never recover:

[  109.156226] rcu: INFO: rcu_sched self-detected stall on CPU
[  109.157147] rcu:     21-....: (21000 ticks this GP) idle=c25c/1/0x4000000000000000 softirq=250/250 fqs=5249
[  109.158587] rcu:     (t=21003 jiffies g=2425 q=1 ncpus=32)
[  109.159392] Sending NMI from CPU 21 to CPUs 5:
[  109.160119] NMI backtrace for cpu 5
[  109.160131] CPU: 5 PID: 378 Comm: kworker/u64:6 Tainted: G            E      6.5.0-rc3-g57012c57536f #21
[  109.160138] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qem4
[  109.160140] Workqueue: btrfs-endio btrfs_end_bio_work
[  109.160158] RIP: 0010:btrfs_data_csum_ok+0x37/0x270

#!/bin/bash

SUBVOL=/btrfs/swapvol
SWAPFILE=$SUBVOL/swapfile
SZMB=8192

mkfs.btrfs -f /dev/vdb
mount /dev/vdb /btrfs

btrfs subvol create $SUBVOL
sync
chattr +C $SUBVOL
dd if=/dev/zero of=$SWAPFILE bs=1M count=$SZMB
sync;sync;sync

echo 4 > /proc/sys/vm/drop_caches

# UPDATE ME TO THE RIGHT BDI!
echo 4194304 > /sys/class/bdi/btrfs-2/read_ahead_kb

while(true) ; do
        echo 1 > /proc/sys/vm/drop_caches
        echo 1 > /proc/sys/vm/drop_caches
        dd of=/dev/zero if=$SWAPFILE bs=4096M count=2 iflag=fullblock
done
---------------

If you want to convince yourself the bug is happening as described,
add something like this (+/- whitespace munging from my lazy copy)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 79e29b5d3d8d..55716d5feb5e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -984,6 +985,9 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
                        ASSERT(bio_ctrl->compress_type == BTRFS_COMPRESS_NONE);
                        ASSERT(is_data_inode(&inode->vfs_inode));
                        len = bio_ctrl->len_to_oe_boundary;
+                       if (len & 4095) {
+                               printk(KERN_CRIT "new len %u, bio size %u\n", len, bio_ctrl->bbio->bio.bi_iter.bi_size);
+                       }
                }

                if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) != len) {

