Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0991E57A66F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiGSSYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiGSSYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 14:24:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D75C9CD
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 11:24:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 509891FE8E;
        Tue, 19 Jul 2022 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658255061;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SV6KudBB6zfjuOdDV+dSgLVwyukqRhoOQThznsJSC8=;
        b=E1WyzY/uR6V+rCE0rGUKNY7S4cCxhrwa/R/ysSRbO1NjyD1PLrJGNzmuq/gQXlLDViZYcZ
        jDR4MkpaBc3uuzBMChPJ21ynQ7jvt/kwKLDJAnQKPQYYddz4o6vQkFnp+ZybMINyREpk2D
        OjmdMjVZMJ7yvHd7eBCJqNzF7QDf5bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658255061;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SV6KudBB6zfjuOdDV+dSgLVwyukqRhoOQThznsJSC8=;
        b=fDdkk1R7+5eKl6bOIhZ/sRg+ffRySEO4oV1fpVqXzh1Nmg9cWuoFCYiR86rGokRtC6TcwX
        FLENAQLCbYVTlWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 284EB13A72;
        Tue, 19 Jul 2022 18:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i4ftCNX21mIpVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Jul 2022 18:24:21 +0000
Date:   Tue, 19 Jul 2022 20:19:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: fix read repair on compressed extents v3
Message-ID: <20220719181927.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220707053331.211259-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707053331.211259-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 07, 2022 at 07:33:25AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> while looking into the repair code I found that read repair of compressed
> extents is current fundamentally broken, in that repair tries to write
> the uncompressed data into a corrupted extent during a repair.  This is
> demonstrated by the "btrfs: test read repair on a corrupted compressed
> extent" test submitted to xfstests.
> 
> This series fixes that, but is a bit invaside as it requires both
> refactoring of the compression code and changes to the repair code to
> not look up the logic address on every repair attempt.  On the plus
> side it removes a whole lot of code.
> 
> The series is on top of the for-next branch, as that includes other
> bio changes not in misc-next yet.
> 
> Changes since v2:
>  - include the previous submitted and reviewed repair all mirrors patch
>    to simplify the stack of patches
>  - include an additional cleanup patch at the end
>  - improve a commit log
>  
> Changes since v1:
>  - describe the partial revert that happens in patch 1 better in the
>    commit log
>  - drop a now incorrect comment
>  - do not add a prototype for a non-existent function

Moved from topic branch to misc-next, with some fixup, thanks.
