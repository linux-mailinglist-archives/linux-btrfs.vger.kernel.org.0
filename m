Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A687722C21
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjFEQEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjFEQET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 12:04:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443AAB7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 09:04:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1FAC1F8CC;
        Mon,  5 Jun 2023 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685981056;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFQpHkmL69hzvater7kr/irD2P63/PqyUz4tbVqpPAs=;
        b=D/Coyt9FQoOyYRP6qKYgAX0u+icDZ5Z99HSaD9t3yTDbtzAozlB9faUTnfnXtD3RmD2ILA
        0UY3nZHjYOUF5DA1hur/tr+S8VpusUVW9zWEXcjHdGivrIG532ABP82Mf9Aayre2qZpjbV
        Xs7YTpULHTIMmNVp6siMQ1VsStc29BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685981056;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFQpHkmL69hzvater7kr/irD2P63/PqyUz4tbVqpPAs=;
        b=z93hjiCNMgD4qY0QUkUPkhBb7QbQBZL+ImgUHKHo6XIYK9EVLUCy4xqSABPf3hEkQlW8kJ
        4qkB+83yOPvBp8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9F5E139C7;
        Mon,  5 Jun 2023 16:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQumLH8HfmTUCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Jun 2023 16:04:15 +0000
Date:   Mon, 5 Jun 2023 17:58:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Message-ID: <20230605155801.GA25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508145839.43725-1-hch@lst.de>
 <20230508145839.43725-4-hch@lst.de>
 <20230509225737.GK32559@twin.jikos.cz>
 <20230515092254.GA21580@lst.de>
 <20230530155648.GB30110@twin.jikos.cz>
 <20230531041626.GA32582@lst.de>
 <lf4rdsuwr74avwruytrngh5e4tre3g6xz2mazhrjeh2g7pjsrr@aofeztgnhdgn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lf4rdsuwr74avwruytrngh5e4tre3g6xz2mazhrjeh2g7pjsrr@aofeztgnhdgn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 03:04:26PM +0000, Naohiro Aota wrote:
> On Wed, May 31, 2023 at 06:16:26AM +0200, Christoph Hellwig wrote:
> > On Tue, May 30, 2023 at 05:56:48PM +0200, David Sterba wrote:
> > > > > I'd appreciate more eyes on this patch, with the indirections and
> > > > > writeback involved it's not clear to me that we don't need the list at
> > > > > all.
> > > > 
> > > > My suspicision is that Aoto-san wanted the extra safety of the extra
> > > > reference because he didn't want to trust or hadn't noticed the
> > > > extent_buffer_under_io() magic.  Auto-san, can you confirm or deny? :)
> > > 
> > > The number of patches above this one in the queue is increasing so it
> > > would get harder to remove it. I took another look and agree that
> > > regarding the references it's safe but would still like a confirmation.
> > 
> > As stated, I am very confident that this is safe based on all my
> > recent work with the extent_buffer code base.  I'd love to hear
> > from Aota, but there's not much more I can add here myself.
> 
> Sorry. I missed this thread is on-going.
> 
> I ran my test runs on misc-next containing this patch, and got no issue
> regarding this. So, the patch should be good.
> 
> I didn't notice the extent_buffer_under_io() magic. If we can remove it,
> let's remove unnecessary variable from extent_buffer.
> 
> Also, I dig into the "redirty" history to make it sure. In the first place,
> it used releasing_list to hold all the to-be-released extent buffers, and
> decided which buffers to re-dirty at the commit time. Then, in a later
> version, I change the behavior to re-dirty a necessary buffer and add
> re-dirtied one to the list in btrfs_free_tree_block(). In short, the list
> was there mostly for the patch series' historical reason.
> 
> So, not sure still I can add this but, for the whole series:
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

Perfect, thanks. Changelog updated and rev-by added.
