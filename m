Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A076B932
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjHAP44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHAP4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 11:56:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5D1B7
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 08:56:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5E1B6732D; Tue,  1 Aug 2023 17:56:49 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:56:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-ID: <20230801155649.GA13009@lst.de>
References: <20230801210400.F0DE.409509F4@e16-tech.com> <20230801145946.GA11625@lst.de> <20230801235123.B665.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801235123.B665.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 11:51:28PM +0800, Wang Yugui wrote:
> > Can you try a git-revert of 140fb1f734736a on the latest tree (which
> > should work cleanly) for an additional data point?
> 
> GOOD performance  when btrfs 6.5-rc4 with
> 	Revert "btrfs: determine synchronous writers from bio or writeback control"
> 	Revert "btrfs: submit IO synchronously for fast checksum implementations"

And with only a revert of

"btrfs: submit IO synchronously for fast checksum implementations"?

> 
> GOOD performance  when btrfs 6.5-rc4 with this fix too.
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f3e06ec6924..1b7344e673db 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -598,7 +598,7 @@ static void run_one_async_free(struct btrfs_work *work)
>  static bool should_async_write(struct btrfs_bio *bbio)
>  {
>         /* Submit synchronously if the checksum implementation is fast. */
> -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>                 return false;

This disables synchronous checksum calculation entirely for data I/O.
