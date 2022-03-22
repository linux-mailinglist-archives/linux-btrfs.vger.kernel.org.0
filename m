Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E14E3A8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiCVIZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiCVIZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 04:25:10 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB075EDFD
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1647937417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TthsinPhSFxlBkZqjpzWwmqDSJXzVYNrspenxdLJ/gc=;
        b=JAMlAd7TqB/O+URJ3s1mfWgY6TXxvP44Qqu7QTFqp1ZcQThNJCYflhWJk5f5Da51/CONrI
        omxpgNCe61XkVr/aEZEpngzS9nBHBeujxzZHwrPBskYjwzNrRXqbd+GkFFdbQAEJ+PMV0J
        Ht7otHgCxlB5pbi5KTxYMH4nmh/skYs=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-xuqN-e29Og-S-bj8FT6wvw-1; Tue, 22 Mar 2022 09:23:36 +0100
X-MC-Unique: xuqN-e29Og-S-bj8FT6wvw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrL86P5Quc5JlAl15zOm4eUzro3vlNZl8nDkfrP0Z4w5K/gkAMkLdZBvdRrjwlfZBpfudjy9v6C68TC6MvwC52mFZ17a/CSMr7YYOM5urPlpjF0aL7LfhUlNObO3Ax6Xml74blNUdzOTlZg83eN9wnrJIBmq/AodkMrIWrjDEoMNG6buLDdsfCRdiE2yZ7gUi84+uoK68XzdKMhvn1ps9qzwaiFYGtWmtqUazOgPN11q6N4EokmCTeNNcdpJmspxqj64kRMauQ3gpxxFg1bQmjwayKwQuOGM0ndUM/RMZOUc5M6brZOz0RRql9PpexTpxlcEi0DakDoZg1/5zSGS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TthsinPhSFxlBkZqjpzWwmqDSJXzVYNrspenxdLJ/gc=;
 b=jmlRrYuQxA6S7fDhHSCMno3bqRvgvRpXOOxyqPHxvaS2SGerShWshqZf6IXR8diBKILOGiDy+U7m75pRtwtIJNgpPB4rxqHeME4anJtM0mvTNCtXA/h8Kswwsncl8MMabt35eUHgL7MI0WinR+tjLUpCvUfAP+SpQTz0dkEotNS2ZJcuKW3d1eZHWFi4gb4CMEm3FiVHupFI1J4tAx1INO7/NuCGn5FRD9+WJguuz53L/1QOXY9aivsWsVseY3QhIA+dqWdiw1uTCsSfTgC6QptcmY+Tdr0kFO4fwdmUicGVX11EWAMljqee51PUvgZUwFi5fkCGXnUQWrnND7e6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM6PR04MB5029.eurprd04.prod.outlook.com (2603:10a6:20b:9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Tue, 22 Mar
 2022 08:23:35 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::39f2:9041:54c:eecc]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::39f2:9041:54c:eecc%8]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 08:23:35 +0000
Message-ID: <e7ba5053-0084-a48e-07b3-a4c186765587@suse.com>
Date:   Tue, 22 Mar 2022 16:23:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <27688f5ed1d59b26255f285843c4573322acfa39.1647926689.git.wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: verify the endio function at layer boundary
In-Reply-To: <27688f5ed1d59b26255f285843c4573322acfa39.1647926689.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b103de9-92e4-49db-c1d4-08da0bdd41f8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5029:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5029716A5270E94516AB6F32D6179@AM6PR04MB5029.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++w2GK+VOq86jhi0IL99THUHYWsMcSJyNV4q2NPQ+bR3RPKwH6Vwip9lPYp5IPQ1nKG68b20pVzxQBT7l96NORY8fLk5OAWGJneYjEB/4N3S091QLzKNWCKQnv3zov3vsqNxSfYY/S7PxeLQcPNsC19o/euzoa3T6aZrNVcuqorKDayz5bMFLpIKgJHW5CKYUOSE7xSEveNp/LnPy3KoiH/pUhCNrnJSa3JcDch8WpKyXioI2fv682Y+mbG2vdf9qZI19tGJqf/7TodzinNSuRtofrGPVC7wXLzdH1WGpOAt2Ovm7LXN5oM/BUZ2kmRiMOd2XIQ6jUd7P6nFRMbjMSmntNuanPKI3k0ENteIe8c0xHlphzJnenOqywgKKKyCAj34oDVQsNFqI/ZIYtM9iTNY6wDh2Dp/cgqjZDDhYxjtb2Gpm+v4UDPWQtL2OkFVs4OFVeVkNH9xyIgayTc99iUtMvsp+I2CaVp+1k6mDNRhByeJpIM9Kn9+TNfzHS6PlrjBGRmAMKbyIymUzvwsVj4M53pBGxYENiSH5ocyrFp/sM7RPL+NE0xuLnaVD+NYJsLRFY2mCeKa9hcRbsxYptQFuWndpxRntatS/HoCaCyb3ub4BljcSArb6dMYgXgGEtZK7XOAPjX8CFRw6Gzzvxn3J5VJURWm2YkkkXoscWK+9sMVjgwNElrYVvl+dgPMHbKi3iSOQv1cfhhmEcf2LXmePK+IKAbBw+5rgheg33M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(66476007)(6506007)(15650500001)(66556008)(508600001)(66946007)(6512007)(6666004)(5660300002)(36756003)(30864003)(31686004)(8936002)(8676002)(316002)(38100700002)(86362001)(26005)(31696002)(186003)(2616005)(6916009)(2906002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFE3b2N5b1ZaZXcvWWI3SjJsVGNvanJJVjBSVGx4YmpuWmlUNVJHUnRGM0R4?=
 =?utf-8?B?Q1pWeTkxRzI3RVo3THpUbzlNNGR0VXZFR05NelJ6cVBNNmZUTFUyaXBETTAz?=
 =?utf-8?B?cDI3ZmVGYjNFaGZIcTJ5czI3bjRycXprWFJFMWJINjJ3MlRyQURSd1RYZHJI?=
 =?utf-8?B?VDhEeG5uSG9OcmtMUkpTR0lTZFc5dE9RWldBVmIrN1I2WnlvUFJnNmx4Rm5W?=
 =?utf-8?B?M3BqTlJvZlFxVUVKd2RiZlVLamVXQW9XUDZNR2tEVlFPM0VLK0N5UWk0dXJD?=
 =?utf-8?B?cnpxVHNOOWE1VVBUb29WZ2IrSFN0MWUwZWFhdFJPbldxNnZsTmtxd0NzcC8w?=
 =?utf-8?B?OGJNWk8xSEUxRGgwbnB0a2dTV0tmVktWM2RpbklHdmtST1NkMHd5Y2RpWDh3?=
 =?utf-8?B?c1BDcFZOZncvUldLcitsMERSdlhEYk1wSmRGdW1FK3JDWWcvSDI4ajcyRzhJ?=
 =?utf-8?B?Z3Frakw3Y1hqaGJWWEF0aEZhLzAwZlc0QU9EbzErclFWUzdHUjZ6RExmajNC?=
 =?utf-8?B?Qm4yRmwwVmQwYWdCQ0d0SUJiR0ljMzFidzJwQy80eThUaFRnV0g1TFk4ZklT?=
 =?utf-8?B?U0xXTFVhb1BNYTJOVkdrRksvU2RCaXRseGlWUkpjS1V2SnlBTUVvaWVFblhw?=
 =?utf-8?B?aXFCeS9RaUJWaGxXVExXdlNGR1hodEtGem9GbUNWVXNBczNCa1NzdFRJUkc2?=
 =?utf-8?B?WVlsWDJuMTRHcEpWVWRaSTdrdUkyYm51MXpyM0hDTFZSQXA0QWljdHlBY2lK?=
 =?utf-8?B?QXVwTXVkRnRGRU9wWDlJaUdwc0RQcjNIZ1Q0aUtHQTF5cXVoOTFYRGpMVk1t?=
 =?utf-8?B?d1J3NGxOeFI1Y3haam5mU2lKNVhLa0hqRjRiTERjYWpFMlZEUHhWbU5aSWtw?=
 =?utf-8?B?TlJib3JvcEdYUTRNTTFBS1ZlS3BDVUdHOHJTcDV3bU5ZYlB0ZEluSHNGSXJs?=
 =?utf-8?B?M01pZGVPZXdsWGV0NDg1SFBZSzF2QVNiMTRFRXlidnNKUyt0a1BheGZtV3Zo?=
 =?utf-8?B?TjJnaGZzRkhhb3pHWlBYc2c0SEVON2xLVnNhdFl3SEhleXBoc1N4Zmw5eTdC?=
 =?utf-8?B?b0t4TkRDZnBSa0M3d2FYVTFCeVFnbEtyZ1VKZmRablZaKytHcXhXUzJxYTNv?=
 =?utf-8?B?SlY4c0duVUNvSWVnUTI3MjJMRnQzeGNTL1RraWlUQ0VsQ1RRS0p5dlhhN1Js?=
 =?utf-8?B?ZTBiaG9saVAxSUZZRlIwTTBLZktqZDNwUml6MmJGZ1N3bVlIcXVySlNHdUk3?=
 =?utf-8?B?c0Y5Q3ZESHExdXNLTmgwRzFuS1hVbHptY1lHREtQWmNDeGJZZmp6dVJpRk9E?=
 =?utf-8?B?ZVhuZERHSk01OCt1RGN3dlZoMTQ2Um43VFlveTVVUy85cklUUFdCL3dvQXda?=
 =?utf-8?B?a2thcmJnMy80M0JNTS9FL28wYXloRFNMek45YmpzcXZMQ3VPYTJmVWgrT3hv?=
 =?utf-8?B?WXIwNThuN09RN2FWWlpXMHRxeE52VUVWQzVUZ2wzdDdNU1A1NjlCMEZCdG1J?=
 =?utf-8?B?VTNZN2ptN1lMSFQxOW82dWQ3a0tuZUxQbTkxbzAvaVdqYU1lTjhydGttWk1T?=
 =?utf-8?B?bjd4YitrSWw0bDYrRnZJT3pXM0owbXZhcWY5Qm13QUJEQzE5R3hCcWI5YTF0?=
 =?utf-8?B?RWdiSSs4Uk5pRmFmS2h1UWd0QWZDRUxvUlF1RWpCb1JXakk4djFYT0YwMmhs?=
 =?utf-8?B?akp2cHAyaXpIdmJHTSthV0o1ZFBlV1NkTGN5dGlPOUxHQy9Zc2FUbXNiUHIy?=
 =?utf-8?B?OGtPeWc4azdOZ0hvaDdMVUs1UEsyeVdVRWg2NGVzZXJ3MUlybGM1eFllcVp3?=
 =?utf-8?B?cS83cGEwaDdjZ25vZkJydFhOamx5ZjFieGplY1g0dTVEUHBWaUg3bEpTbjNT?=
 =?utf-8?B?dU1ONm1vT1JvSDdYZmRQY0hXN0RGZTlQb1cxS2ZFTGFiRXFwRDZpVkt4ZE5G?=
 =?utf-8?Q?TX0xXkhVcUA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b103de9-92e4-49db-c1d4-08da0bdd41f8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:23:35.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c10YmMpRDO35YCDDuDo1HFSX409mQDZSjOj104l2Ldvg31/aBR1/Uto1Ozd3nLeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/22 13:37, Qu Wenruo wrote:
> Currently btrfs has two layer boundaries for its bios:
> 
>    inode address space
> 
>    ---------------------------    <- Operations like data read map those
>                                      bio to btrfs logical address space
>    btrfs logical address space
> 
>    ---------------------------    <- btrfs_map_bio() maps those bio to
>                                      device physical address space
> 
>    device physical address space
> 
> Unlike stacked drivers, btrfs handles all those operation in-house, thus
> we have very limited (although it's already 8 different functions) endio
> functions.
> 
> Here we verify the endio functions between btrfs logical address space
> and device physical address space.
> 
> This also helps to have a better layer separation.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This patch is based on previous bio split patchset.
> 
> Reason for RFC:
> 
> I want to make this thread a possible discussion on the future iomap
> integration.
> 
> Goldwyn is working on the iomap integration for buffered data read/write
> (direct IO is already using iomap).
> 
>  From the iomap point of view, it only cares if one read/write bio
> finishes without error. It doesn't care about if some range failed due
> to csum error.
> 
> Its all-or-nothing method is a perfect match for stacked drivers, which
> mostly uses chained bio to split bios for stripes.
> 
> But it can be problematic for btrfs, as btrfs needs to try to repair the
> exact corrupted range.
> 
> Thus if we're going to use iomap, we need btrfs to know if a bio should
> be ended like chained bios, or the endio function can be called for the
> split range.
> 
> Currently all involved functions are already split bio compatible, so
> this patch is just a sanity check.

Please discard this patch.

Firstly, the fs_info grabbed from btrfs_bio::device is not reliable, as 
device can be NULL for raid56.

Secondly, if we really go iomap integration, the upper layer endio 
function is inside iomap, which may or may not be exported.

Furthermore, this check doesn't take delayed endio (aka, the one using 
workqueue). It's fine on x86_64, but not for platforms which doesn't 
have fast/hardware checksum.

Thanks,
Qu
> ---
>   fs/btrfs/compression.c |  8 ++---
>   fs/btrfs/compression.h |  2 ++
>   fs/btrfs/ctree.h       |  2 ++
>   fs/btrfs/extent_io.c   | 73 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/extent_io.h   |  3 ++
>   fs/btrfs/inode.c       |  4 +--
>   fs/btrfs/volumes.c     |  1 +
>   7 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 2df034f6194c..b6c59c5cdacc 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -282,7 +282,7 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
>    * The compressed pages are freed here, and it must be run
>    * in process context
>    */
> -static void end_compressed_bio_read(struct bio *bio)
> +void btrfs_end_compressed_bio_read(struct bio *bio)
>   {
>   	struct compressed_bio *cb = bio->bi_private;
>   	struct inode *inode;
> @@ -406,7 +406,7 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
>    * This also calls the writeback end hooks for the file pages so that metadata
>    * and checksums can be updated in the file.
>    */
> -static void end_compressed_bio_write(struct bio *bio)
> +void btrfs_end_compressed_bio_write(struct bio *bio)
>   {
>   	struct compressed_bio *cb = bio->bi_private;
>   
> @@ -528,7 +528,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		/* Allocate new bio if submitted or not yet allocated */
>   		if (!bio) {
>   			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
> -				bio_op | write_flags, end_compressed_bio_write);
> +				bio_op | write_flags, btrfs_end_compressed_bio_write);
>   			if (IS_ERR(bio)) {
>   				ret = errno_to_blk_status(PTR_ERR(bio));
>   				bio = NULL;
> @@ -861,7 +861,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   		/* Allocate new bio if submitted or not yet allocated */
>   		if (!comp_bio) {
>   			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
> -					REQ_OP_READ, end_compressed_bio_read);
> +					REQ_OP_READ, btrfs_end_compressed_bio_read);
>   			if (IS_ERR(comp_bio)) {
>   				ret = errno_to_blk_status(PTR_ERR(comp_bio));
>   				comp_bio = NULL;
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index ac5b20731d2a..8c15ba63bd5d 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -183,5 +183,7 @@ struct list_head *zstd_alloc_workspace(unsigned int level);
>   void zstd_free_workspace(struct list_head *ws);
>   struct list_head *zstd_get_workspace(unsigned int level);
>   void zstd_put_workspace(struct list_head *ws);
> +void btrfs_end_compressed_bio_read(struct bio *bio);
> +void btrfs_end_compressed_bio_write(struct bio *bio);
>   
>   #endif
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db17bd05a21..bd78916d0001 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3225,6 +3225,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
>   /* inode.c */
>   blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>   				   int mirror_num, unsigned long bio_flags);
> +void btrfs_end_dio_bio(struct bio *bio);
> +void btrfs_encoded_read_endio(struct bio *bio);
>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a5764b89d020..d7a0ce3b82f3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -28,6 +28,7 @@
>   #include "subpage.h"
>   #include "zoned.h"
>   #include "block-group.h"
> +#include "compression.h"
>   
>   static struct kmem_cache *extent_state_cache;
>   static struct kmem_cache *extent_buffer_cache;
> @@ -3218,6 +3219,7 @@ static void split_bio_endio(struct bio *bio)
>   	ASSERT(parent && !btrfs_bio(parent)->is_split_bio);
>   
>   	bio->bi_end_io = bbio->orig_endio;
> +	btrfs_check_logical_endio(bbio->device->fs_info, bio);
>   	bio_endio(bio);
>   	bio_endio(parent);
>   }
> @@ -7540,3 +7542,74 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
>   				   btrfs_node_ptr_generation(node, slot),
>   				   btrfs_header_level(node) - 1);
>   }
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +/*
> + * Make sure the logical bio has correct endio function.
> + *
> + * In btrfs there are currently two types of endio:
> + * - Logical address space bio
> + *   They use logical bytenr
> + * - Device address space bio
> + *   They use physical bytenr of each device
> + *
> + * This function makes sure the bio has correct endio functions for its endio
> + * function.
> + *
> + * NOTE: There are some cases not covered by this function:
> + *
> + * - Scrub
> + *   It maintains its own device mapping, thus directly submit bio to device, without
> + *   using logical address space bio.
> + *
> + * - Read repair
> + *   The same as scrub.
> + *
> + * - RAID
> + *   They work at a lower level
> + *
> + */
> +void btrfs_check_logical_endio(const struct btrfs_fs_info *fs_info,
> +			       const struct bio *bio)
> +{
> +	/* For directIO, read write endio shares the same function */
> +	if (bio->bi_end_io == btrfs_end_dio_bio)
> +		return;
> +
> +	if (bio_op(bio) == REQ_OP_READ) {
> +		/*
> +		 * For read bio, we have the following valid endios for logical
> +		 * bios:
> +		 * - DirectIO (handled above)
> +		 * - Buffered read for both data and metadata
> +		 * - Compressed data read
> +		 * - Encoded data read
> +		 */
> +		if (likely(bio->bi_end_io == btrfs_encoded_read_endio ||
> +			   bio->bi_end_io == end_bio_extent_readpage ||
> +			   bio->bi_end_io == btrfs_end_compressed_bio_read))
> +			return;
> +	} else {
> +		/*
> +		 * For write bio, we have the following valid endios for logical
> +		 * bios:
> +		 * - DirectIO (handled above)
> +		 * - Buffered data write
> +		 * - Metadata write (only buffered)
> +		 *   This includes both endios for subpage and regular case
> +		 * - Compressed data write
> +		 */
> +		if (likely(bio->bi_end_io == end_bio_extent_writepage ||
> +			   bio->bi_end_io == end_bio_extent_buffer_writepage ||
> +			   bio->bi_end_io == end_bio_subpage_eb_writepage ||
> +			   bio->bi_end_io == btrfs_end_compressed_bio_write))
> +			return;
> +	}
> +
> +	/* Unknown end io functions for logical bio */
> +	btrfs_crit(fs_info,
> +	"unexpect endio function for logical bio, logical=%llu bi_end_io=%ps",
> +		   bio->bi_iter.bi_sector, bio->bi_end_io);
> +	BUG_ON(1);
> +}
> +#endif /* CONFIG_BTRFS_DEBUG */
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 493c2cd96424..97e91bce66b1 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -320,8 +320,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>   
>   #ifdef CONFIG_BTRFS_DEBUG
>   void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
> +void btrfs_check_logical_endio(const struct btrfs_fs_info *fs_info,
> +			       const struct bio *bio);
>   #else
>   #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
> +#define btrfs_check_logical_endio(fs_info, bio)		do {} while (0)
>   #endif
>   
>   #endif
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ecf039c272fc..83f48a4d2ef9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7881,7 +7881,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
>   }
>   
> -static void btrfs_end_dio_bio(struct bio *bio)
> +void btrfs_end_dio_bio(struct bio *bio)
>   {
>   	struct btrfs_dio_private *dip = bio->bi_private;
>   	struct bvec_iter iter;
> @@ -10301,7 +10301,7 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
>   	return BLK_STS_OK;
>   }
>   
> -static void btrfs_encoded_read_endio(struct bio *bio)
> +void btrfs_encoded_read_endio(struct bio *bio)
>   {
>   	struct btrfs_encoded_read_private *priv = bio->bi_private;
>   	struct btrfs_bio *bbio = btrfs_bio(bio);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 301491429e37..e70a272b41f9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6877,6 +6877,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>   	u64 cur_logical = orig_logical;
>   	int ret;
>   
> +	btrfs_check_logical_endio(fs_info, bio);
>   	while (cur_logical < orig_logical + orig_length) {
>   		u64 map_length = orig_logical + orig_length - cur_logical;
>   		struct btrfs_io_context *bioc = NULL;

