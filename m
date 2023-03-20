Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568C66C1070
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCTLNA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCTLMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 07:12:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165C93F5
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 04:09:47 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1qdPua2TR0-013aGe; Mon, 20
 Mar 2023 12:09:35 +0100
Message-ID: <7df9da59-fb61-b4b0-13c2-701161796089@gmx.com>
Date:   Mon, 20 Mar 2023 19:09:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/10] btrfs: refactor btrfs_end_io_wq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230314165910.373347-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R+r+EDyIeAtxhKOcfCpsvUvTYv6qwsttl0Tw4MISF5qEP1CzOt7
 CjUKbI2vsC4pgu7Dkq1yOEI9kIxZmJxTQPFH5vJ/h4Cb/r1+wnXa9BZv+t/vHtIA/7Qi0+u
 MUNLHpfdOLzooSRRWL+KvcMLG04eayuQn/Cq1Ff4IHqtO4S2p8TQIiW+cojvSC7OU9CH2Zi
 R/zYV+AS35F7aZ5drvofw==
UI-OutboundReport: notjunk:1;M01:P0:O6MYWXQBpgo=;DtXGBhNt8GZHM+eBcLPODuRKl4r
 ye0aPuptg3X/VdC7oPqxev7dZbYhi0nGsAgyEitiGRUBLPZEhcvpz1cEV/lIZ/7wNitfaFV3J
 +AEJWaoDV+P7C5eeYNY/UM+RR5T2vuVGZH35bO2LQNJVrU4wbuxKI7DAGTlsG+rShM+71iHwc
 1pmJnp5WWD84vcd5/EgklZcsIcV0e149c8/j7sgN/2U9P6qCAUgr4NQHSk533x4a0bu6mzBm+
 Z9XhVkTlGSFboWuVPRTrdZcPX1ASO+hTg/M8BStf93zpxvIEOBCs4SB1DPPrQLIaImvUN+yEk
 u6kkRZGdZP3nocfDXTPt0F+PBzxg3469aZRdlZefrnshJeFllyyCSK56kNO5CGL0DMdjzDGAG
 Nch8Xox/LO1FO7JTAuDxla4cdLkFnTVvYPltzARpk/g0mVGbXv+sLM0MazUEUTHg7fKScUVmI
 EMJwrfSd8M238hiMDaAWtrJptCo2xP56DumBXHHpyVbSwaU15nqHMbADn7q+O1CweoWCnQbW3
 zzpbaew313Aa19JaBiDSKkOj1ON/S+BakYfwBjM4MwcmCyga1CkPCaJKzfrmqzbADvGszMPy/
 BzIUg1D1c58T2hVgqwdDYmijCiinP8fMpo3g2xcuYyJ5tPgJvC5pp1MMzVDfDXrakbaYKrJu5
 EBDNGtio+rTIvkxt/234DePmFgvarC/nnw4lFqHJ4j7FL05+JPOEC0yyJWiPOhsoCt0Hhh5sV
 CkLAXt6Nn3wLAVwYUPgXfpZLiMEiSA+332aQHSy3C7d/stS6y+uSTk84EEX7yQyWBOvut07Rs
 8fwdtA7GYpDp40hMx7J8B9hhgmQzm0KB9mTrJqIKs1II0LYGXLnCEXC2TqW1LjnMYe2mOHlDq
 5V1hu26kG0JgaJpiddiIsDz/euqeoxNIf1vJKyug2cydTpu60H2c2Pe7XNi4ZZ/1ZXi931i88
 zFexxsazLouOIxqvGGJfEDv1+Ds=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 00:59, Christoph Hellwig wrote:
> Pass a btrfs_bio instead of a fs_info and bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/bio.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index cf09c6271edbee..85539964864a34 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -296,10 +296,11 @@ static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
>   		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
>   }
>   
> -static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_info,
> -						struct bio *bio)
> +static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_bio *bbio)
>   {
> -	if (bio->bi_opf & REQ_META)
> +	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
> +
> +	if (bbio->bio.bi_opf & REQ_META)
>   		return fs_info->endio_meta_workers;
>   	return fs_info->endio_workers;
>   }
> @@ -319,16 +320,15 @@ static void btrfs_simple_end_io(struct bio *bio)
>   {
>   	struct btrfs_bio *bbio = btrfs_bio(bio);
>   	struct btrfs_device *dev = bio->bi_private;
> -	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
>   
> -	btrfs_bio_counter_dec(fs_info);
> +	btrfs_bio_counter_dec(bbio->inode->root->fs_info);
>   
>   	if (bio->bi_status)
>   		btrfs_log_dev_io_error(bio, dev);
>   
>   	if (bio_op(bio) == REQ_OP_READ) {
>   		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
> -		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
> +		queue_work(btrfs_end_io_wq(bbio), &bbio->end_io_work);
>   	} else {
>   		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
>   			btrfs_record_physical_zoned(bbio);
