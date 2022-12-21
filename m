Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9F653661
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiLUScG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 13:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiLUSbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 13:31:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D526115
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 10:31:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD3F4171DE;
        Wed, 21 Dec 2022 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671647509;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAZnNQHt8/2GkA/gJYUonDpdxuQTR4EmdprwZjyydhY=;
        b=0gYFnA+jf+AeNd1BSbOu416Z4esf1QYiNlXrdAe9kyhPDa7xC5lHSzpKGMY/OUjb4oIyAF
        M1/HUzmpDxlbvkgZgUNkoGArojPoRzMEOE7nF9b6sFURHrpiCLGQ8g4iFz6O3bulvh4Lnn
        8hvL/mv4Q1NOgo8O3ryJRlZe8POtjK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671647509;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAZnNQHt8/2GkA/gJYUonDpdxuQTR4EmdprwZjyydhY=;
        b=8CbD1Npnrsvtsgn5Z8BxI6uWWyoZB3t6dRhSWM/sg1rAbyamOR9zCsJScaS9eNQZfInwRp
        +UCzV0Fhz+l4JLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83AF213913;
        Wed, 21 Dec 2022 18:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BCczHxVRo2M9fwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Dec 2022 18:31:49 +0000
Date:   Wed, 21 Dec 2022 19:26:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/8] btrfs: fix uninit warning in run_one_async_start
Message-ID: <20221221182625.GB2415@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <5501d33f6ac5af3f371c8734793baeddcde75b4d.1671221596.git.josef@toxicpanda.com>
 <d9396fa4-0ad7-ce3c-e2d8-69bd8e08c898@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9396fa4-0ad7-ce3c-e2d8-69bd8e08c898@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 19, 2022 at 07:51:31AM +0000, Johannes Thumshirn wrote:
> On 16.12.22 21:17, Josef Bacik wrote:
> > With -Wmaybe-uninitialized complains about ret being possibly
> > uninitialized, which isn't possible, however we can init the value to
> > get rid of the warning.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/disk-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 0888d484df80..c25b444027d6 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -693,7 +693,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
> >  static void run_one_async_start(struct btrfs_work *work)
> >  {
> >  	struct async_submit_bio *async;
> > -	blk_status_t ret;
> > +	blk_status_t ret = BLK_STS_OK;
> >  
> >  	async = container_of(work, struct  async_submit_bio, work);
> >  	switch (async->submit_cmd) {
> 
> Wouldn't that be more future proof:
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 40f9c99aa44a..6ad5e5c6c858 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -707,6 +707,9 @@ static void run_one_async_start(struct btrfs_work *work)
>                 ret = btrfs_submit_bio_start_direct_io(async->inode,
>                                 async->bio, async->dio_file_offset);
>                 break;
> +       default:
> +               ret = BLK_STS_NOTSUPP;

I've committed version with BLK_STS_IOERR as it's a noisier error, I'm
not sure how much the op-not-supported would be noticed by any userspace
application if we ever reach this code but this is in the 'cannot
happen' realm.

Naohiro sent an update to the zoned fix so now we have all the warnings
fixed and I'll add the last patch to enable the warning.
