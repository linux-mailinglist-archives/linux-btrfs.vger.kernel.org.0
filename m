Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78653F1B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 23:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiFFV3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 17:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiFFV3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 17:29:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDDE09
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 14:29:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CB4A1F99C;
        Mon,  6 Jun 2022 21:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654550969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g5RLkV3bLhSWik7N2fskR7OqhVfMZ9zlNgWkg6rYLoc=;
        b=e2lJsqWpDX447TGAH9hbZUCfOiMnd3dA/Pxmx/D3h1XNvH5QCVyQ6BP2fwdYBh39i/jXrp
        elRrqo5aoG0MXypXr7VV0eBnZBvlokSzDCSnISF1x70FHCk1V6h3C6vRC4wcUlnc/8LYDY
        lxwQekpZyuhW1otfMJhhR4gJwPL0B/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654550969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g5RLkV3bLhSWik7N2fskR7OqhVfMZ9zlNgWkg6rYLoc=;
        b=y7GaJESLq1JsKCJwo6ec0zGzTUyuY5zWkAVpSPXDIAHnBj3fIqPMJq66IFAJvsoFDfIKOX
        BVInpw8he4ID4jAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D5AD139F5;
        Mon,  6 Jun 2022 21:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kxRfArlxnmI9XgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Jun 2022 21:29:29 +0000
Date:   Mon, 6 Jun 2022 23:25:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: simple synchronous read repair v2
Message-ID: <20220606212500.GI20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
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

On Fri, May 27, 2022 at 10:43:11AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is my take on the read repair code.  It borrow a lot of concepts
> and patches from Qu's attempt.  The big difference is that it does away
> with multiple in-flight repair bios, but instead just does one at a
> time, but tries to make it as big as possible.
> 
> My aim here is mostly to fix up the messy I/O completions for the
> direct I/O path, that make further bio optimizations rather annoying,
> but it also gives better I/O patterns for repair (although I'm not sure
> anyone cares) and removes a fair chunk of code.
> 
> [this is on top of a not commit yet series.  I kinda hate doing that, but
>  with all the hot repair discussion going on right now we might as well
>  have an uptodate version of this series out on the list]
> 
> Git tree:
> 
>    git://git.infradead.org/users/hch/misc.git btrfs-read_repair
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-read_repair
> 
> Changes since v1:
>  - rebased on top of the "misc btrfs cleanups" series that contains
>    various patches previously in this series and the
>    "cleanup btrfs bio handling, part 2 v4" series
>  - handle partial reads due to checksum failures
>  - handle large I/O for parity RAID repair as well
>  - add a lot more comments
>  - rename btrfs_read_repair_end to btrfs_read_repair_finish

The preparatory patches and other bio patches are now in misc-next, so
I'm adding this branch for-next. At this point I'm cosidering this for
merge as it has better performance compared to the simple repair from
Qu, though I still need some time to finish the review.
