Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216A56AAEF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiGGSi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiGGSi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 14:38:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5121E18
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 11:38:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA1E421F89;
        Thu,  7 Jul 2022 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657219135;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yagw0YFimNlRQwBTvOQN7j2IxgIXRaI2w/9Y1ng7Ozk=;
        b=kQf3oAQw89T6dvvivfickffID1zNj2IHqLbKwVydKgzKsIDqrAz2Yny0fxpZAvhKWyT6hr
        7SfarOiBb3xtM3t1D6KMjMjrjCKKNE7s7iinUhLkvUouzn0nmQrxdVN+iHUiGLffIf+kv6
        3iMp9vspyxKBwpPEJjMO/T5Pr5qHN54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657219135;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yagw0YFimNlRQwBTvOQN7j2IxgIXRaI2w/9Y1ng7Ozk=;
        b=SmKJPtyZrMoVJLsblFl4yrsLrfNtNdQI523XhRKcc6nKhKu5xhu/UAiADxdjSppP8MdiOE
        l6a4V42Q5b7BpTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E9CA13A33;
        Thu,  7 Jul 2022 18:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aRe1JT8ox2KzFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 18:38:55 +0000
Date:   Thu, 7 Jul 2022 20:34:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Message-ID: <20220707183409.GL15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-11-hch@lst.de>
 <20220622160725.GJ20633@twin.jikos.cz>
 <20220622161546.GA683@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622161546.GA683@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 06:15:46PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 06:07:25PM +0200, David Sterba wrote:
> > On Fri, Jun 17, 2022 at 12:04:14PM +0200, Christoph Hellwig wrote:
> > > Replace the stripes_pending field with the pending counter in the bio.
> > > This avoid an extra field and prepares splitting the btrfs_bio at the
> > > stripe boundary.
> > 
> > This does not seem sufficient as changelog, does not explain why the
> > stripes_pending is being removed, just that it's some prep work. Given
> > the questions that Nikolay had I think this needs to be expanded. I'll
> > try to summarize the discussion but in the bio code nothing is that
> > simple that reading the patch would answer all questions.
> 
> Maybe just skip this patch for now then.  I also have two follows up
> for it, so I can resend it with an updated version of this one.

Ok, I'll move the series from topic branch to misc-next without the last
patch.

> But the single sentence summary is: use the block layer infrastructure
> instead of reinveting it poorly.

A summay is perhaps good as the first sentence but not as explanation or
reasoning why a patch that changes logical structure, data structures,
code flow etc. is correct. IMHO it should be a sort of a proof or steps
to follow and verify during review not just an "abstract".
