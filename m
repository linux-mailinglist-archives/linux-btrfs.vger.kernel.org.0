Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C755512C25
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbiD1HFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbiD1HFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 03:05:04 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4819078FC9
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651129308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBSQttfEurhQpc2Ql+DxGCwbvvr45WuEIwjDdHaP9yc=;
        b=dghiVDVtHvGWwPzk1xXiDSsoSdb+voE8oQHvSgghV9Knc4hBDswVh3FFbexmE8fie2yG79
        qz8nxnQiZZKs+76vHPNyK6Y/4opYAO0zC19Q7Wqe68vj2lKBGLJBUVL3wTk7vpPeNaftb2
        WfkKlbb0aQYYHnrH79nzeVJx0rGOU6I=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-gR9Y8Gg3N7uq3XCVvqQFHg-1; Thu, 28 Apr 2022 09:01:47 +0200
X-MC-Unique: gR9Y8Gg3N7uq3XCVvqQFHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVk7ARu6nViLjpGXy9OR2wucNkcrrg4radM6nN+WdRQnw0+sPgbuZV3NgXdEQK9gI0JphVGIkMq9kvwFWg269mYUhMye7KbysO+Lgpo+iIqt0lM5nLaOO7sNXaNOyjp4mQ1IUAB8yBYw3t6/jgZp+lEYks7oQBUprnsyq5uAI5XFBS49JMDuDFiFMWvUdE3LTYy0xotO4/N0MHxylSoXA0oeFbc+sNVaRtpnSuvN819b+a5Oej1pCFWcGSJiE/gdcVh7fyGGK3GbCvpzPBGcDR1QXc8vukB6+rTDAW5eYZXdZ+o8cxHikoRQXv8ZFBmdgpxpsFaJjFwvCbLirVYd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBSQttfEurhQpc2Ql+DxGCwbvvr45WuEIwjDdHaP9yc=;
 b=HPFGUFkJzKkVOks0842NlEYo9wd1oosY8pKA1fd3I4VVnT5aTuZ/dXcmbxFbuSSeQC1Ku20DTnkkdf9ZO4QvGLQdwRj+hH+PRml6SPWKAhah9N9PseZZ05LX1C5Q1aha4nCBYh2yyAsxM6Qg5EgvTxSQ73dqrMDLoJGbqh/sHDz6l/qPCge3EruCl9weVRS5tOFyXvXPsj8lXYa+kWRcwcs44T0+WmgvRMVcQHDB2NNeylIBAGddIXUPyHiD4EhkEtbbWi5/Ww74N4s+buYjnoQu6t7hujR34uTwU+ZbZak+e8xyS1VyEJq1EDJFUrUwzkJ4RHQaGU6N/I+pkUIZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM6PR04MB5606.eurprd04.prod.outlook.com (2603:10a6:20b:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 07:01:45 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f%7]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 07:01:45 +0000
Message-ID: <b1627c20-1a24-ee13-eae6-f6c273ce56d9@suse.com>
Date:   Thu, 28 Apr 2022 15:01:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1651042800.git.wqu@suse.com>
Subject: Re: [PATCH RFC v2 00/12] btrfs: make read repair work in synchronous
 mode
In-Reply-To: <cover.1651042800.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:510:f::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6697eae0-813f-4d0b-1cb8-08da28e4f4ad
X-MS-TrafficTypeDiagnostic: AM6PR04MB5606:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB560612F6036E17A7CE05399FD6FD9@AM6PR04MB5606.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc9GY4AwKhQqNwxardxhSPfqSqI972JwXZZPP9tsG4cBWf3JYbU1QG0Dkyz0VqCK5mXseN4ThmUejc4hbhCVuUxQES1u4DZ28esvNIoIcyRL0v+prEdRsypJodcLEMZXZjrXEe814nNoTrhT+o6kD7wsX59oPq+NtKlJ5vtbdU4pgH5WrQmqrSFqX1dBKUeBbwamXAi6PdBPaXAK8Tkbj5LkhW3NcfmuIX23AyFFbz14UJcMRw+MTW89uPpHHGIE2pAo4MMDI+cFEUi5XvOzcQetzq34ZOf7o10EATkB1wrmd+/qHnWRyTUO0PVUeStTIbVgaVAznKi2MdCwQjVlsRwyjzfIuQZ6o//m+iQkV11IJOBhLB7ko/Pj9tKGIDm2QobakGUyMc63MyevvN/znGfTJvEOehn0JCcai235nIDKpl/QR/w/GYLvqhBTWD/Tym9F5+eNtaN78ko5/NAbiC3i1JpHUt4Z7+PGi6iXBU9eNhEX3Z3BCOpHPbTLG7EdbQdpSEXO28BzEk8Dlpn9FzjO2p6TwG7hCUb3mSV4WoVQl69pS4eGWMu43GW7sEU37EcgDUwjv0C9wqLPIuDVbR8TW2LyQHzXh2gQC44QYjwSWfbpA5E6tbuuSZbpRpjLVGtY3TrChaohOOU6xx+u/zZfN0LiyvBqN9frWavZcWhXE5mzN7dgVT1BDVh6D3zTwOttE7hbI5sIjIFO9qo5Jd8nl36xpm/cocnziiNYFz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(6486002)(508600001)(2616005)(86362001)(26005)(6506007)(6512007)(53546011)(38100700002)(6666004)(66556008)(186003)(66476007)(316002)(66946007)(2906002)(36756003)(5660300002)(8936002)(31686004)(83380400001)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJZblpuZGNkd2pOeTRZTjY5VXhjZTdXRDlMd1V5c2RBU2lONWZYcGtUQUNa?=
 =?utf-8?B?T28zVkhoa1FHWjVrejhUanVINUd1ZHRZbDA3TEplL1RYY0RHd2htTW5QTWRN?=
 =?utf-8?B?elVzMXZkeGk4aTRVYlFsc1hXeC9RSVdmRUdOeEFzNlhjQmppaEZZY0U4d3Zt?=
 =?utf-8?B?dWNDT3YyOCtkdjR1N3Q5eHp1b013NytqS0dLeVd5TWYzSGlOQnR1Y2t2NFlT?=
 =?utf-8?B?OUtxRVBNU2oyeVhQdmp6SS9NSUp2dGZOTzJHMGVQeHNrZThuV1FyU242UWdk?=
 =?utf-8?B?WjN0Z2FGWVFscVZqNlppemNFZG1QVnFHY1JwQlRXUkJaTmZRdWZ2QzdOZUJz?=
 =?utf-8?B?YTRhM3lUY1FoWC9jSkNYU1NtS3IzVVJoRC9MazFtZ3pZWDJ6SDZnRkc3d1Vz?=
 =?utf-8?B?bHRiZ0d5ZUhqeUtBMmhJb2VReEhDb1crbThsdUpvejRzaFh2aUpsdFBveG1z?=
 =?utf-8?B?STA0bWUzdXFYV2czUndlMklOM2tLZzhEdnhBNWNvaUdWcy81bHduT3J1TDNj?=
 =?utf-8?B?LzZUSVY4UVhISFRlVzNWWGh6RjdQUTJ1YXZ2T1dXMXJWNlgwZ09CdWEyYUZI?=
 =?utf-8?B?OGpyQXJQaGRFTVRZd1g5Q2FmbUpWS3UyUVNhOXdyeWwxZVFxcit5VDZHYklZ?=
 =?utf-8?B?NVFyQ3VscElQcmVicTB0eEd4djN1SkpUckFEbGZqSkhJeWdIQWZmaGtpSVg2?=
 =?utf-8?B?dCt4a3k3bmphOWRYV1lDSzhBZG8xZ2JXcVIwa2xVVngzelZtZUROMEZZMys5?=
 =?utf-8?B?d2xDL0MvTzdvMkJCd2RRYzdwd0pSbGdxUnk3TDVSc0Y3UFdjc240MkVtS01P?=
 =?utf-8?B?c0lPcGxjWGEwWVNiT0xhdVJOZk1ERkQxaDZsQW00ZCtIWGFHODJtVzRNUHVN?=
 =?utf-8?B?aUYvRlFtTkIza2MvOHBIcmtYbVVkV1ZubGo1WllnaXQ5c3lORFZnamtwNVph?=
 =?utf-8?B?VjdkQTQ3RkxvREZxZWdyOFIrWkxBdFZsbnNhbG1KdjQwYWV3Uy95Tkc1Qlg0?=
 =?utf-8?B?VE44a3E1OFVKUllybytyNmpqU1hMMUxZbUxub1ZsYk5oMGpkNk50WXhHcTlV?=
 =?utf-8?B?WWRzOTI2QUhteG9YL3I3eEFCWnllVVp3cWlXRUttTVhaaXRieVRlcTR1UXFn?=
 =?utf-8?B?U24rZVZERWdZNmRKRlRWbC9yajh4c2doZkx0NTQydld4SXJqT0x4YzlLS1BE?=
 =?utf-8?B?VEg5N2lFcktVZW42OExDRkFEalBkemtsZ0FCQVNKbjVKNTZxKzROYUl3N0xQ?=
 =?utf-8?B?Z01VZmthUUtJV29hV2ZLYkp0ZjR1WkhvcnBYdjVUUVhlanNiamx1eEVJN1Qx?=
 =?utf-8?B?Q3huZmJWbjYweVU4VDdiTGtVOGg3eUk3ZllwUUZteFFYNVBnQW5hdkQzZURH?=
 =?utf-8?B?NlBoMzFMMlgybmxUS2wzM1Z3cUtjbGxZbGpnTXludGtoUjYxT3FyelRNQzVr?=
 =?utf-8?B?NXVIakFUY1o3K0tqT21URXEyUHNodWF6L0QrbFpJOUtBSzMzbUpBSG5vRmov?=
 =?utf-8?B?eFhuc2dXK1NWaHRNaDcvOThnRUxSUGFRSERtMGV4QXU5UTdFSlVzWGNhTVZq?=
 =?utf-8?B?dytiWC84RDJWcmFodEpnd3pkNmZkZk9ZS2JTL0NoSy9JdDJ6MVlXL1ZteERW?=
 =?utf-8?B?ckJqa1ArWXIzcXk1c0JPbzNBTUJaczF1aXBkZ2IyTnRxd2pYd0JnQTU5ZFd2?=
 =?utf-8?B?cTViUXhta0ZFRWhDT25IYjdSeFJHdXhEaGxzWlFyN2dOWVY5cE1QTGhKZ1JM?=
 =?utf-8?B?c3E3ekpSempFV2lTWXhCTFpRSkZ5Z0xKSUQ2a29oT1NMbEpkRkI2UWpMNXR0?=
 =?utf-8?B?OFQwLy9Jc0tMSTRLSFhlaFRkQWpXQlN0dXBHdTRSaWZXTEZGNTJ4cEh0dlFK?=
 =?utf-8?B?dVMrRlVMNGFNVm1PdEpZMHFnMkJIL2F4RnZTODdRMUU2L1JOY0wxY20wT3FC?=
 =?utf-8?B?anoyQStqY3k5R2V1QkhKSHU5ZlRlVGZDMVMvd3lENE1yRXpxdFRaT0RxR2lX?=
 =?utf-8?B?YjRiSjBoWjQvQTF1Rml4N2ZxUzlqUXoweXBFSlJhMWRpcW1vMVR6R2luZ0Vk?=
 =?utf-8?B?MVZ0dmluRVNOcGFNMHZZRS9ZR0x4MjVqaG11Z3RzZWVpZUpsVG8rck9vRk12?=
 =?utf-8?B?eXNYaUY5b1E1MTV3TXh4M2p4bmhSZkpMUHFQMkVybnkzVlo5NmF3ckhXNFox?=
 =?utf-8?B?S0MrSmV3bHVpdTdlSDRLVXZMcisxL3c1RHJEeFp5UEdtaEVSanhTUlVMU3dF?=
 =?utf-8?B?Zmk1ZU1PaXFoanR2ZXZmQmxuYmJXTVRmSFpZNjU2OUI5UXJlQnRZN0VVVyt0?=
 =?utf-8?Q?HqXoktW7syfPZUg7Ao?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6697eae0-813f-4d0b-1cb8-08da28e4f4ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 07:01:45.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BA7JsSNx3gCSFYICXlQyXlHn6Y+iJ5pHJGNNMHP37AzuXL//Q61ZOyHD015cZ1RL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5606
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/27 15:18, Qu Wenruo wrote:
> [CHANGELOG]
> RFC v1 -> RFC v2:
> - Assemble a bio list for read/write bios and submit them in one go
>    This allows less submit bio hooks, while still allow us to wait
>    for them all to finish.
> 
> - Completely remove io_failure_tree infrastructure
>    Now we don't need to remember which mirror we hit error.
>    At end_bio_extent_readpage() we either get good data and done the
>    repair already, or we there aren't enough mirrors for us to recover
>    all data.
> 
>    This is mostly trading on-stack memory of end_bio_extent_readpage()
>    with btrfs_inode::io_failure_tree.
>    The latter tree has a much longer lifespan, thus I think it's still a
>    win overall
> 
> [RFC POINTS]
> - How to improve read_repair_get_sector()?
>    Currently we always iterate the whole bio to grab the target
>    page/pgoff.
> 
>    Is there any better cached method to avoid such iteration?
> 
> - Is this new code logically more reader-friendly?
>    It's more for sure straight-forward, but I doubt if it's any easier to
>    read compared to the old code.
> 
> - btrfs/157 failure
>    Need extra check to find out why btrfs/157 failed.
>    In theory, we should just iterate through all mirrors, I guess it's we
>    have no way to exhaust all combinations, thus the extra 2 "mirrors"
>    can gave us wrong result for RAID6.

This is related to the writeback behavior for bad mirrors.

For RAID56, the mirror_num is not really indicating a mirror, but an 
hint on how to rebuild the data.

For RAID6 it can be as large as the number of stripes. The data stripe 
where our read is, is always corrupted (or we won't need to rebuild).
The mirror number can be used to iterate through all combination of the 
next possible corrupted stripe.

When we got the correct data using a specific mirror number, we should 
not write back the correct data for RAID56.

As it will trigger RMW, and RMW always read data stripes from disk 
(including the other corrupted data in RAID6), thus the write back will 
in fact cause the other corrupted data to be eternal.

In that case, we just need to skip the unnecessary writeback for RAID56.

This will not write the correct full stripe back to disk, but it's way 
better than corrupting the data furthermore.

The fix is already updated in my github repo.

Thanks,
Qu

> 
> [BEFORE]
> For corrupted sectors, we just record the logical bytenr and mirror
> number into io_failure_tree, then re-queue the same block with different
> mirror number and call it a day.
> 
> The re-queued read will trigger enter the same endio function, with
> extra failrec handling to either continue re-queue (csum mismatch/read
> failure), or clear the current failrec and submit a write to fix the
> corrupted mirror (read succeeded and csum match/no csum).
> 
> This is harder to read, as we need to enter the same river twice or even
> more.
> 
> [AFTER]
> For corrupted sectors, we record the following things into an on-stack
> structure in end_bio_extent_readpage():
> 
> - The original bio
> 
> - The original file offset of the bio
>    This is for direct IO case, as we can not grab file offset just using
>    page_offset()
> 
> - Offset inside the bio of the corrupted sector
> 
> - Corrupted mirror
> 
> Then in the new btrfs_read_repair_ctrl structure, we hold those info
> like:
> 
> Original bio logical = X, file_offset = Y, inode=(R/I)
> 
> Offset inside bio: 0  4k 8K 12K 16K
> cur_bad_bitmap     | X| X|  | X|
> 
> Each set bit will indicate we have a corrupted sector inside the
> original bio.
> 
> During endio function, we only populate the cur_bad_bitmap.
> 
> After we have iterated all sectors of the original bio, then we call
> btrfs_read_repair_finish() to do the real repair by:
> 
> - Build a list of bios for cur_bad_bitmap
>    For above case, bio offset [0, 8K) will be inside one bio, while another bio
>    for bio offset [12K, 16K).
> 
>    And the page/pgoff will be extracted from the orignial bio.
> 
>    This is a little different from the old behavior, as old behavior will
>    submit a new bio for each sector.
>    The new behavior will save some btrfs_map_bio() calls.
> 
> - Submit all the bios in the bio list and wait them to finish
> 
> - Re-verify the read result
> 
> - Submit write for the corrupted mirror
>    Currently the write is still submitted for each sector and we will
>    wait for each sector to finish.
>    This needs some optimization.
> 
>    And for repaired sectors, remove them from @cur_bad_bitmap.
> 
> - Do the same loop until either 1) we tried all mirrors, or 2) no more
>    corrupted sectors
>    
> - Handle the remaining corrupted sectors
>    Either mark them error for buffered read, or just return an error for
>    direct IO.
> 
> By this we can:
> - Remove the re-entry behavior of endio function
>    Now everything is handled inside end_bio_extent_readpage().
> 
> - Remove the io_failure_tree completely
>    As we don't need to record which mirror has failed.
> 
> - Slightly reduced overhead on read repair
>    Now we won't call btrfs_map_bio() for each corrupted sector, as we can
>    merge the sectors into a much larger bio.
> 
> 
> Qu Wenruo (12):
>    btrfs: introduce a pure data checksum checking helper
>    btrfs: always save bio::bi_iter into btrfs_bio::iter before submitting
>    btrfs: remove duplicated parameters from submit_data_read_repair()
>    btrfs: add btrfs_read_repair_ctrl to record corrupted sectors
>    btrfs: add a helper to queue a corrupted sector for read repair
>    btrfs: introduce a helper to repair from one mirror
>    btrfs: allow btrfs read repair to submit all writes in one go
>    btrfs: switch buffered read to the new btrfs_read_repair_* based
>      repair routine
>    btrfs: switch direct IO routine to use btrfs_read_repair_ctrl
>    btrfs: cleanup btrfs_repair_one_sector()
>    btrfs: remove io_failure_record infrastructure completely
>    btrfs: remove btrfs_inode::io_failure_tree
> 
>   fs/btrfs/btrfs_inode.h       |   5 -
>   fs/btrfs/compression.c       |  12 +-
>   fs/btrfs/ctree.h             |   2 +
>   fs/btrfs/extent-io-tree.h    |  15 -
>   fs/btrfs/extent_io.c         | 744 ++++++++++++++++++-----------------
>   fs/btrfs/extent_io.h         |  89 +++--
>   fs/btrfs/inode.c             | 108 +++--
>   include/trace/events/btrfs.h |   1 -
>   8 files changed, 518 insertions(+), 458 deletions(-)
> 

