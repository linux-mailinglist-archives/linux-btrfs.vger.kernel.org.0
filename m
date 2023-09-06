Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9D79415D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjIFQYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjIFQYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:24:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7412C1998
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:24:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3535E223F2;
        Wed,  6 Sep 2023 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694017479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyjZanSxiDVf2ltU+hSWbXV8mK87MW9QboPyc4qiFbE=;
        b=meYeC/pszniqKH+zhIZ0RnC52rj1Ko/yH0r+JTvFOqs7GjtvltcvDKfaV3ZfxdZ7abTx/i
        dB5fDbXvjqYGTWzNoLUvh+QkexW65Bl+KnNolaK0wrFo9pkKKLhbIxNcrQM026jJW1CLdi
        6qelTX/p4RSkwP4ghtjPj/q22Uow44g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694017479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyjZanSxiDVf2ltU+hSWbXV8mK87MW9QboPyc4qiFbE=;
        b=1btb+rg4WXI0zRhdBnVcA8gkcnWqcY7lTH3r8//zbD6YxTNe6VjRedJ6xL5jxkAcFjMBLf
        nYg+0hFipz42fVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 069601333E;
        Wed,  6 Sep 2023 16:24:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FdX6AMen+GRvfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 16:24:39 +0000
Date:   Wed, 6 Sep 2023 18:17:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] btrfs: initialize start_slot in
 btrfs_log_prealloc_extents
Message-ID: <20230906161758.GO14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693930391.git.josef@toxicpanda.com>
 <e0192694760936031cae7b4633ba738506eacdc1.1693930391.git.josef@toxicpanda.com>
 <2ef62e1e-a642-4dc8-9aec-427334a51e45@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ef62e1e-a642-4dc8-9aec-427334a51e45@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 06, 2023 at 06:51:26AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/6 00:15, Josef Bacik wrote:
> > Jens reported a compiler warning when using
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y that looks like this
> >
> > fs/btrfs/tree-log.c: In function ‘btrfs_log_prealloc_extents’:
> > fs/btrfs/tree-log.c:4828:23: warning: ‘start_slot’ may be used
> > uninitialized [-Wmaybe-uninitialized]
> >   4828 |                 ret = copy_items(trans, inode, dst_path, path,
> >        |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   4829 |                                  start_slot, ins_nr, 1, 0);
> >        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
> > fs/btrfs/tree-log.c:4725:13: note: ‘start_slot’ was declared here
> >   4725 |         int start_slot;
> >        |             ^~~~~~~~~~
> >
> > The compiler is incorrect, as we only use this code when ins_len > 0,
> > and when ins_len > 0 we have start_slot properly initialized.  However
> > we generally find the -Wmaybe-uninitialized warnings valuable, so
> > initialize start_slot to get rid of the warning.
> >
> > Reported-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I think we're in a dilemma, if we don't do the initialization, bad
> compiler may warn.
> 
> But if we do the initialization, some static checker may also warn...

I've seen static checkers to accept variables initialized to 0 and
unused, there's a lot of code that does that as a matter of coding style
so there would be too many warnings for a generally good practice.
If we see a warning from something else than compiler then we can
reconsider the way it's fixed but I think we'd see more compiler reports
than static checker reports.
