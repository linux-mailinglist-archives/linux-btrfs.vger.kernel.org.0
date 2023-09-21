Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7C7AA076
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjIUUiA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjIUUhd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B63185D22
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:37:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A95C4E67B;
        Thu, 21 Sep 2023 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695300611;
        bh=PgaI8OzK/dXU+smPSgUXlMTZwU7Z1LCPqMOa76hqDI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqCZbksYZSXe4IxC3wkfWx3Hq0V/CYODAmyn2lQoW9IB6wQlPmm4mvZA5LTCjKBKr
         AiHJGSYO6J9zYey3fXwWzDSoqrJxXEwkz2SrwepzreL0mNZQZdjWOTa/o8xobXQrtC
         qX78CAEhzyCWn9XtNhVxi0fc09wvcCkZn9pk9okAnnPZ2i5pLtRoGKCS3thuUDvBp9
         Qn3n0mmPwbnXAnXVk0PV9EStgK7E3F4ESFKz0rIXBZOdDvMIMq6/9w2qrbULm+M5Uy
         ZjMUZKfVlINRw5CdvmwMt9sYTz1mO3I0j+Qfvyd3Fu37NHe+gfA9AS5PqzVDhGcGdg
         zAWK7ckcenCEg==
Date:   Thu, 21 Sep 2023 14:50:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230921-wettrennen-warfen-1067d17aef27@brauner>
References: <20230921121945.4701-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230921121945.4701-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 02:19:45PM +0200, Jan Kara wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The file system type is not a very useful holder as it doesn't allow us
> to go back to the actual file system instance.  Pass the super_block
> instead which is useful when passed back to the file system driver.
> 
> This matches what is done for all other block device based file systems and it
> also fixes an issue that block device freezing (as used e.g. by LVM when
> performing device snapshots) starts working for btrfs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Message-Id: <20230811100828.1897174-7-hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/btrfs/super.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> Hello,
> 
> I'm resending this btrfs fix. Can you please merge it David? It's the only bit
> remaining from the original Christoph's block device opening patches and is
> blocking me in pushing out the opening of block devices using bdev_handle.
> Thanks!

Thanks for resending.

Next time we will ensure that a vfs triggered conversion must go through
a vfs tree as this half converted state with forgotten patches is not
something that we should repeat.

Christian
