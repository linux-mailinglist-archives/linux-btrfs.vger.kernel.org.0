Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56076A0B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGaSwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjGaSwg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 14:52:36 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE01AE
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:52:33 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VHWj7X007178;
        Mon, 31 Jul 2023 11:52:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=L98pSipl1hY/Bbu8AplWB8Bsua0G76UdlgPlXCoGDHk=;
 b=W39AcQN2uHWpNXEG1M4Qhxqt1Jj3MZDuSs+n/MTzBxSOykXpJtEjPaMSt/IIzaUPHBD7
 VlDZe4hlQMQ8LIeD8h2SHTYadVDSMISXQRtowDU2DQrEwVMCpd8uwRZTUlsyoNnW/Xpj
 6ODMzw9yxlydemVAF10Le5vKgM0+dxGt4It8tP3TzOK3SKWrymqFga43glFHGzcHIrw7
 u4D1Rm3A5IhE/PSOTlFu1uCaezu55BUSbkNlcSCxxL3z6LJr7bXSuHVb2puB7cWiftrI
 HVnHZATxsjZFETD5khCq3KHptmovkOya9bb9PHwrPGPBGQx6LD6AXOK0S+T5yvj4DzN2 rQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s50kyhpkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4imJ9ChpVucMnmlEvvzY+7Dsns8prN+nhdThYTxaEkZvc1aGrEXpaulbL6Y3om6eytuoxRfSYos/vRQwVXI880sT3i4TbJ0WDaqPzEInPx/Gb+aVMOrCEpZEku1waFA9Ert3gElouhwVC3LjmgwrMcDg+6i8QeQWBvgP6pWnHAE5FpEmAmUJb1QoHM9Sxgi4PHb39fVEfXPxzv9pA0KpsX9HiZB9CEJ8U4LhvRXjxNZjQ8hq35UM1ZYRFnZcVku4BdLTA2AGy3uIPLqgU0LUaeK2eAUkJOstGbIVeyMkRWmWAJDGjm1bfLTbywhckAvQl7G0+M0MNF87Ltt+ZBKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L98pSipl1hY/Bbu8AplWB8Bsua0G76UdlgPlXCoGDHk=;
 b=LCdWJDtuDpztn7h/1438hm22jqHzWmqcU4NHwI8dJ/6FEgiSIT5tpW0365ro8FmuspaEFgxUfdyetq622uo8E7rrCHdYaeQ2PnZy2ZszQA18fo2mYf7hya/qynEt1Bkdq+Hf9QoxFVksuy/4CknqqQ2zeY4gGzUOcEIgmagWh+hBhGmN0v9IQlexwqC/QcrZymqW5qD558X4BPTBzqR5uf0C3nob58C57Uo3xrcbgsBDud/KvQrZ9TieI6zeCZGEXZDSJRA585RyEwtgR8sof5jKEgVcp1wDrRks9BeJAPV9HuE1C/Ljnm5IDJ5VylqU67lal/0UmP4bo/BaL/wK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by SA1PR15MB4609.namprd15.prod.outlook.com (2603:10b6:806:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:52:26 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80%5]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 18:52:26 +0000
Message-ID: <35b14d0e-3a53-fca7-8290-b26f31d07fb5@meta.com>
Date:   Mon, 31 Jul 2023 14:52:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
References: <20230730190226.4001117-1-clm@fb.com>
 <20230731070025.GA31096@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230731070025.GA31096@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|SA1PR15MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 6193080f-1b5e-4eb8-4966-08db91f74863
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ml1IAm6qs1zyNl+/7cVDPoAHgsfrhCpDFfxJ6W+rwLMa9nL2m1/DuLpu27QxcMvYcvmkK8vKG/c1PxC7wp0HRG4OKC3zv8xchQ0QB8R1tC2SfGA+Es8UYhnpVCbe58pNzl3c0e77R/X+aTKbHBfD621TaAMsPN5k2E0v1PRAnLklXI6OBaThRE0MdvRVXCCSItg2C5/fa74pVLqdiZyS9NT5WMoQG1T+qfETk0BF/knHWemZ3j1PtlDKJR4BRDmnzsfb7aCpUcNS879lU/0Jtwz6ZEBXNWdCV7dcjf/vUh4twWbnrvTsdQVUDLrMp78N3e1Cq39NDhTqDNMpezKeOQRpBb1KKepPchI0XgkjSuFWyYas9s8w4vlJHsdLxKKctv1s5vOoDcTt2/QyXjazgclNjJsApfGLn19pdAGMoNFgxxkQsDnQ5D9brrlX5GctyWMTkGxmFXbJoMz7TgwGWPq1G01Rk1EIQUxwzF3LwZAl/2Uutt6deWrYegunZ9K33wPk3j1u+N/CAgj3mFizusV8mhSisCRTiVshqYc8oqX6EkJY3LL6fTdhPCjxkmx8+wq6tzEpPWgC/evEL/CnB6/3zgZnLQyPSWMzwizfafXst1A86xy8qrWyVCwyrtydFdiKKj7zO273u+1eCwMGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(8936002)(8676002)(36756003)(31686004)(6486002)(41300700001)(478600001)(2616005)(2906002)(6666004)(83380400001)(316002)(186003)(31696002)(86362001)(6506007)(5660300002)(38100700002)(6512007)(4326008)(53546011)(110136005)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWMwMW5hY2k0aUdDODJtSlZWcldLMk82aTcweE96ZG55MWs4cGN4cno5RzZq?=
 =?utf-8?B?TGd1L0RmU25MWVpVZVBQWDBBUkF2bmlYeHNFUWlOc1hDOGliZEhXZDdMa3RD?=
 =?utf-8?B?SUtLY0NOcVpkWldleXhjZFdDTEFZL0xEUVg3cHdtbjdSYzV0czhFWndzc2J2?=
 =?utf-8?B?d1ZFQUQ4dCtOanMzcWdrNjhQTmZNNG0yUFFJR0lyQnBsWUhjTG00QVBpZ1N1?=
 =?utf-8?B?VlprdDlyQUpWSlRDTlJ5RmJ1eWd1anVLVEI0TU8wUmVKTUxPTGRzd2tNTmlQ?=
 =?utf-8?B?VElSSS9ZVU04UE1mS0kzTWNYTW5jejdNbjVoM3V6Q1BVdWl2U0pnUWlqVXpz?=
 =?utf-8?B?RzVNTzNPQWhHeFBoMDU4ejd4T1pkU2l1OE8yTWFONXRQandybHFjL0FpZlpv?=
 =?utf-8?B?M2ZJTHNsZTN5ank3ZU9KRXlHeWJkRnFYL2ZEU1VBc3ZQSEpPRktDRTArMFhm?=
 =?utf-8?B?RS9LcFZhdk9iR2c4ai92eHQ0SHAvam5aNTNDU2hBWUxjMWhOUjM2Y3RZYU1D?=
 =?utf-8?B?b0wyMDdCV0tQcHpzTitwL09zWlB1a2lTemJPc0lDdEdNaGxCMlZQdHRIMGVY?=
 =?utf-8?B?N0tvVFppN21pc2E3b2FiUVhwVnNhQ0Y4cXh6K1VaYWwzV1ZKbDVtdWMrMWpE?=
 =?utf-8?B?a0VZWWMxRTduV0FKQitVOW4wbCtpd2EvSzlVL1hQemwwaXkrUjUrUndsVFpa?=
 =?utf-8?B?MVZ0YmVrYXVxRVBtcVE4OVlEZG90WGk1NFRaVzhtOVU4dGJpdnJVNmozbThx?=
 =?utf-8?B?Vms1SXlUUjgrOHhaeHJKV01uK1JHcW10YXlqSi8wK1hDeUthVjV0WVFJTHph?=
 =?utf-8?B?b0dERmxrZTNITnJ3eFRwYVBPRUYxb2hidlJJVjJoQi8yemtDQldGYjB1Nnov?=
 =?utf-8?B?NXZpUE9jQWhESDBpeUVrSXlkdE9HWkhOOXJtT2FDS2pJUkRlSW52TmpuQkFs?=
 =?utf-8?B?YlNuNXFLMEU2eFpkN1FkK2xJbkxZc3ExRk50N2FYQVcyekR5OHRRT2hUdzNK?=
 =?utf-8?B?SHJxekJVS29oUjRmcE5WWG5nSEVDWFBPUnIvS1dvaVFHMlc5eDFFeXZoaC93?=
 =?utf-8?B?b09tYnBpVy9ZcnJsajgyMVpJRldNYmdpODlrbFhTN1dpam92M0p5Ri9XS3E4?=
 =?utf-8?B?dURRYkVOanZrd29xWjQrU01VZXo0cFJRNjRkMXd0c1lVNE40VFRJQndqZ2U4?=
 =?utf-8?B?TElqV2tyR3dXU00xOUpmTkJFRVBWdzY5cmNxY1hJVXNIZTZ3cGkrd0daWFM2?=
 =?utf-8?B?TkNwSlZpZ3piYlhSTE1qUitHL0NLUERDSmFJNTFOZmJ6MG5XZ3RXdUxhT3Fn?=
 =?utf-8?B?RG14dHlDbGlQcGV0alpPU0hwa2VMWFQzbitabHhyS2xDK1h4YnAwN2NVTmdn?=
 =?utf-8?B?L2ZLVHB2enJaZlQvZktzUDJBRmh5WVNPQjYyUnZJRnhteDhHRTNDWE5QbURk?=
 =?utf-8?B?dTNuTldGMjBIekMvelI5ejFDdE0xOEZMakJpMDNvcUlJbnhSUHhxNk1qcU55?=
 =?utf-8?B?MHVIT01OMWJYbGFkelg1dzR1L1RqZ0doTEdVMCs3MDlUN0EvRERVckVGemdh?=
 =?utf-8?B?QVptVEFSc1lyeGNDZFVuU010RWRJeDlCVEpSMjRMTFZscGZodzI4cEJucmdy?=
 =?utf-8?B?a2toZEVzRzUvSjUyaThVbmhJaVF4ckE1ejBxSVl0TVVwWmpIaGNhcEF0WXQz?=
 =?utf-8?B?NEpKa09OTDFBa2RsRlgzaXNEWlZ2L1piTVZOZytmS2JDZzd1Mk5LYW5zOXZt?=
 =?utf-8?B?R0drNnRoTDZpRWozTWpxSXFnV2FHRFpzYjlCSUZ6aDFWQjNmZmRBSThmYjE2?=
 =?utf-8?B?VFVWUDFJb1IyaTRPWnkyVlluelBIbWpxZStTeTBNRVF3a2M2WFh4VXMzK2s4?=
 =?utf-8?B?cGFKN2xtYk5CK2ZUU2dQVlg1WGxaa3VOVWliZitWSkZBdXZHNllsVlpVNldD?=
 =?utf-8?B?aFU3cnVaMGlzdVRrMm9DQWZHT3Z3QjJlekErQWlMajVRdlFvUTJXazc2aGNC?=
 =?utf-8?B?aitjT2hvcDdnakFvSDVQRXlIUUxTWGhGRnFVd1EvZUFEcW96QWt4a0swZktW?=
 =?utf-8?B?YXJTd1ZLSU5ZMDBxK21QUVM3NTVBeGV3UjhsZVhGS2c1cXJDVklIOFJ3MUhG?=
 =?utf-8?B?blgxVC81UW9rTXZmcS91VjdtWnJRWDB4TnIvcjlHdU55eEVyeUszVjUxdDA2?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6193080f-1b5e-4eb8-4966-08db91f74863
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:52:26.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH3Bq6VpyRVAL0sCcuefhUAVzo+C4iXWCCQv2ya62jIUQPf4YZqN4h+pcAaUdS6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4609
X-Proofpoint-ORIG-GUID: 5t-gVEyQXSEs3Xaj167kZLyid15nwymC
X-Proofpoint-GUID: 5t-gVEyQXSEs3Xaj167kZLyid15nwymC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_12,2023-07-31_02,2023-05-22_02
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

On 7/31/23 3:00 AM, Christoph Hellwig wrote:
> On Sun, Jul 30, 2023 at 12:02:26PM -0700, Chris Mason wrote:
>> [ This is an RFC because Christoph switched us to almost always set
>> len_to_oe_boundary in a patch in for-next  I think we still need this
>> commit for strange corners, but it's already pretty hard to hit reliably
>> so I wanted to toss it out for discussion. We should consider either
>> Christoph's "btrfs: limit write bios to a single ordered extent" or this
>> commit for 6.4 stable as well ]
> 
> I'm torn.  On the one hand "btrfs: limit write bios to a single ordered
> extent" is a pretty significant behavior change, on the other hand
> stable-only patches with totally different behavior are always a bit
> strange.

When are we creating bios without bio_ctrl->wbc set?  I think reads will
do this?

> 
> Note that with my entire pending queue, len_to_oe_boundary goes away
> entirely, but with the current speed of patch application it might take
> another 6 to 8 month to get there.
> 
>> This is hard to trigger because bio_add_page() isn't going to make a bio
>> of U32_MAX size unless you give it a perfect set of pages and fully
>> contiguous extents on disk.  We can hit it pretty reliably while making
>> large swapfiles during provisioning because the machine is freshly
>> booted, mostly idle, and the disk is freshly formatted.
> 
> It might be useful to create and xfstests for that, even if it only
> hits on a freshly booted machine, although we'll need some reordering
> in the xfstests sequence to make sure it gets run early..
> 

The test below works for me on 6.4 but not Linus git.  In theory the
swapfile component is entirely unrelated, but I haven't been able to
trigger without it.

It usually takes about 5 or 6 loops on a virtual machine with 32 cpus,
32GB of ram, and an ssd that can push 800MB/s streaming writes on
/dev/vdb.  I'm happy to add an xfstest, but the failure rate is low
enough that I'm not sure it'll catch anything.

As part of testing 6.4, we booted 100 machines and put them through
provisioning.  17 made it out the other end, and the rest hit a message
similar to this one.  Some had a one byte IO, some had a 4095 byte IO,
it was just whichever bio of our split page happened to finish first:

BTRFS error (device nvme0n1p2): partial page write in btrfs with offset
4095 and length 1

followed by a pretty unsurprising:

kernel BUG at mm/filemap.c:1622!

        if (!__folio_end_writeback(folio))
                BUG();

#!/bin/bash

SUBVOL=/btrfs/swapvol
SWAPFILE=$SUBVOL/swapfile
SZMB=8192

mkfs.btrfs -f /dev/vdb
mount /dev/vdb /btrfs

btrfs subvol create $SUBVOL
sync
chattr +C $SUBVOL

while(true) ; do
    swapoff -a
    dd if=/dev/zero of=$SWAPFILE bs=1M count=$SZMB
    mkswap $SWAPFILE
    swapon $SWAPFILE
done


