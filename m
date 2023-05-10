Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308A6FE2A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEJQi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjEJQi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 12:38:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389F7D97
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 09:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43B501F461;
        Wed, 10 May 2023 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683736701;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw4LgRum7nifoJiNgtQlMclzzJSr95gvchwFJn293iM=;
        b=2EGSoRTUyImwoczbpGDnMAdr7mIedHZUb63YHUXqvg6wnJa7vBgSlgmvJ4wf8qEcMyjz3f
        ajA/ZLF+l32Ao1FrQ0EcaxU1IXWh+p3/nXOxHV7apl2hfdUgLfTplkvgudRr4M296By+xt
        eafVY+bB/c1pWpCKcxJhqDlCY+ESDBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683736701;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw4LgRum7nifoJiNgtQlMclzzJSr95gvchwFJn293iM=;
        b=lep6lVUhO/ONWBgeI2Xczsz6uzCBhtQt6lpZlnIAqiRPNKJpO2Ji2QBcWlQWdiCJQkQKfT
        GqEi92dthLJsZiCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19DAD138E5;
        Wed, 10 May 2023 16:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4tFLBX3IW2S4dQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 16:38:21 +0000
Date:   Wed, 10 May 2023 18:32:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: add an ordered_extent pointer to struct btrfs_bio
Message-ID: <20230510163221.GT32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 08, 2023 at 09:08:22AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a pointer to the ordered_extent to struct btrfs_bio to
> reduce the repeated lookups in the rbtree.  For non-buffered I/Os the
> I/O will now never do a lookup of the ordered extent tree (other places
> like waiting for I/O still do).  For buffered I/O there is still a lookup
> as the writepages code is structured in a way that makes it impossible
> to just pass the ordered_extent down.  With some of the work from Goldwyn
> this should eventually become possible as well, though.

Series added as topic branch to for-next, thanks. I edited the patches
with the suggested changes (renaming to is_data_bbio), no need to
resend. If you have any minor updates please send them as incremental
diff or reply to the patch.

> Note that the first patch from Johannes is included here to avoid a
> conflict.  It really should be merged independently and ASAP.

Now in misc-next.
