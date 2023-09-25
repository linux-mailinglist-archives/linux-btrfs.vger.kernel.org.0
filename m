Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3897ADCF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjIYQUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjIYQUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 12:20:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77009B8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 09:20:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 39D521F7AB;
        Mon, 25 Sep 2023 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695658805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hUK/7lwTpeapTlZXV44yaMXNyqUh7/yAl6bhRXXXJc=;
        b=LLnJVpp/Ioe0qTsHJkKergYKmfmsReG3gL1Hn+nkWW9DPEpqfYyB4Eg4PdnAD2XVd6L9rV
        SG1b7JQAM+FPr71Wndx4tlqtdZprK5eHk824DTGG6221OJdpUzw3ZvbwVge+mGQmA6Ajm3
        1jsCNNpIkxkvpSP7g+nnKTm51OD2BR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695658805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hUK/7lwTpeapTlZXV44yaMXNyqUh7/yAl6bhRXXXJc=;
        b=gLCKY0DIfYVGn+z6Ki1L17qTFP7leQxhxCUe2iuPydfZw4D5dkCSx2+H6mTfHeevv4JcQZ
        gUY9YSbkwH2JBwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D554B1358F;
        Mon, 25 Sep 2023 16:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CwPTMjSzEWWccgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 16:20:04 +0000
Date:   Mon, 25 Sep 2023 18:13:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230925161327.GP13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230921121945.4701-1-jack@suse.cz>
 <20230921-wettrennen-warfen-1067d17aef27@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-wettrennen-warfen-1067d17aef27@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 02:50:07PM +0200, Christian Brauner wrote:
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

Taking this as an example, I really don't want to let such patches go
through VFS git. I understand there are API-level cleanups done in
VFS that require reorganizing code in the filesystems but IMO the
conversions must be done in the filesystems first and the VFS cleanups
as a followup.

We have conflicting goals, you want better API and filesystems stand in
the way so you/somebody fix it in a seemingly correct way and you want
to merge it because it's ok for you. I view it as change from the
outside potentially introducing bugs that we'll have to deal and unless
we have somebody who's familiar with the changes to recognize the
problems and fix bugs eventually it's risky.

What I can do right now is that I'll keep the patches in linux-next,
with the additional fix so the series is complete. I'll let you know if
there's a change regarding the reviews or merge.
