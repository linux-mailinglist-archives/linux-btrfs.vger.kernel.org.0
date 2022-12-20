Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AA6526BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiLTTEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 14:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTTEV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 14:04:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C77D7F
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:04:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 67C2D76856;
        Tue, 20 Dec 2022 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671563059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ImpQCN4UYFLwxeio2nM0/YMC+fGV0xjva6lenoAixXI=;
        b=EQkICw/N6CGaaCxM5nbzeWbP0JJ4MNrCV9X+CgBoW2BY3btPwtFEeg/5PZE35FnuVIE6Lf
        DXy7PmQyE4l4QqEYpKEJZ5mRvIYJlG3+5b8XIX3PYiAQS+HYr1hUKR0d9bVx11PquSL3Qb
        qusgcudeCNNSFcnfEhbbsNyyO4UtkDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671563059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ImpQCN4UYFLwxeio2nM0/YMC+fGV0xjva6lenoAixXI=;
        b=kUFOc+edve9FQ8L3zGU1FV+PnXg2bw8yRmabrs+RlNQ+nlwskCrNMtpL7DfoTfHfjrtNY1
        lfqfNQ1Aiux3ysBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D921390E;
        Tue, 20 Dec 2022 19:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U6tIEDMHomN/NAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 19:04:19 +0000
Date:   Tue, 20 Dec 2022 20:03:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/8] btrfs: fix uninit warning in run_one_async_start
Message-ID: <20221220190333.GP10499@twin.jikos.cz>
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
> +               ASSERT(0);

The assert and default: would probably make sense to catch any
accidental misuse of the async API. All the submit_cmd values are from a
fixed set and all are in the source code so any problem should be caught
at development time.

I'm not sure if there should be any fallback for the case where asserts
are complied out and what's the expected outcome of the BLK_STS_NOTSUPP.
This is a case that should never happen.
