Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503B7ADC93
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjIYQA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 12:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjIYQAz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 12:00:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13841B6
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 09:00:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 102FD1F45F;
        Mon, 25 Sep 2023 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695657647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcHbniI/LSU4SOj7/1qUEMuZnu6aCKVm0HMMgMdjpMs=;
        b=KGgxtT0gJ55cD2wFer9XqicJEv64Omk3uuJRZxMtNLkTJ2dH8UukcrPQV524Zg140pPo9H
        wdk1qhqTExHf6184OPYHe3vxdf9+0OQYulXXlmqrmDGhasIYKgCMInuqXzDRKcymppt7nv
        a4/+1TmkK650TqwIqtpNsUBzue+l+EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695657647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcHbniI/LSU4SOj7/1qUEMuZnu6aCKVm0HMMgMdjpMs=;
        b=9w9aOEyJ0/Y+Q5DyNnibPNxqQO7uMUPhThY70nd8Lj0xOMBsGJHvrVhUoQg0/qCOfZjlwI
        qd5KdPCQe0wdGnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 917981358F;
        Mon, 25 Sep 2023 16:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l4x0IK6uEWWYaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 16:00:46 +0000
Date:   Mon, 25 Sep 2023 17:54:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230925155409.GO13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230921121945.4701-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921121945.4701-1-jack@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

I'll add the patch to the rest of the series, thanks. I don't have a
timeframe when this will be moved to the main patch queue, until then
it'll be in linux-next. The series has been sitting in the review
backlog for a few weeks but no takers. I try to have a look from time
to time but the kind of changes done there are not trivial so I'm still
not confident enough to put to the main patch queue.
