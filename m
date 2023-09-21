Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B27A9ED3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjIUUNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIUUMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 16:12:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9C5B427
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:21:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F25C9338A5;
        Thu, 21 Sep 2023 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695301650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hyYhIkIZE4hLkbOr+51KfLhQsT7oVY1zTqte4x0R570=;
        b=nQIq8fIRdBvBq6jcc7ERE3qW2b5SQsDHHHEHOrk3q+utjbdeJkPF9GAWMFIabG3DtDZm2c
        ZD7Aq+LOjgC98QWR7TO7S7IqHbM4KtWZRdyNSGm2qYB99MPs2TH90po5ww6I0wojFB64Te
        EwVVHBFELY3bJ14jIxeiddiDeFpY+9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695301650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hyYhIkIZE4hLkbOr+51KfLhQsT7oVY1zTqte4x0R570=;
        b=K7x+L2DqZHLpQ1QsSfRMh5CaZ4DjWqOrO7tTCT36peb48K8Ar6tnGEkuifvtL4AdVz1VZd
        oNqwQ0WDJcnSIHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E592C134B0;
        Thu, 21 Sep 2023 13:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mvMEOBFADGUTLgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 21 Sep 2023 13:07:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 75F47A077D; Thu, 21 Sep 2023 15:07:29 +0200 (CEST)
Date:   Thu, 21 Sep 2023 15:07:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230921130729.rmxq43efbod4gd3a@quack3>
References: <20230921121945.4701-1-jack@suse.cz>
 <20230921-wettrennen-warfen-1067d17aef27@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-wettrennen-warfen-1067d17aef27@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 21-09-23 14:50:07, Christian Brauner wrote:
> On Thu, Sep 21, 2023 at 02:19:45PM +0200, Jan Kara wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > The file system type is not a very useful holder as it doesn't allow us
> > to go back to the actual file system instance.  Pass the super_block
> > instead which is useful when passed back to the file system driver.
> > 
> > This matches what is done for all other block device based file systems and it
> > also fixes an issue that block device freezing (as used e.g. by LVM when
> > performing device snapshots) starts working for btrfs.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Message-Id: <20230811100828.1897174-7-hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/btrfs/super.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > Hello,
> > 
> > I'm resending this btrfs fix. Can you please merge it David? It's the only bit
> > remaining from the original Christoph's block device opening patches and is
> > blocking me in pushing out the opening of block devices using bdev_handle.
> > Thanks!
> 
> Thanks for resending.
> 
> Next time we will ensure that a vfs triggered conversion must go through
> a vfs tree as this half converted state with forgotten patches is not
> something that we should repeat.

Yeah, I agree it would be good to find a smoother way to handle such
merges. I understand David's desire to give changes proper testing which
generally doesn't happen in linux-next but on maintainer's own branches and
infrastructure but perhaps some stable branch in VFS tree that filesystem
maintainers could pull when putting together the branch they push out to
the testing infrastructure would work?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
