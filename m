Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87669D484
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 21:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjBTUMW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 15:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjBTUMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 15:12:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D31F4A3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 12:12:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 459D43398F;
        Mon, 20 Feb 2023 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676923939;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nBm0eWQgXyAJ4SgS57gWuR0H5sLpNLQDU5SSNk/cv3M=;
        b=SOXEHborxmteFHWYseAEMEd1Qz/VCylO+qxEqp6FgXTuPvrP5AeytQ0xScoFADcFDYRV0w
        cLXvrNcWbpI5u4otv0hZK5rSyhiosIpRwGLxs3an9vHjzodYzJ5A0u1QFYk6zyZ8cJ4BXy
        j+Uh2S07vA0U5uWjiiTTuqOC2gd1sx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676923939;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nBm0eWQgXyAJ4SgS57gWuR0H5sLpNLQDU5SSNk/cv3M=;
        b=iGGAtckdQE+U3uPZiOLMD6Q+wdlWXKNO7fIRGV+KdGTjvuBHyYHLDkjBlJPEuFhg66RJwL
        mOE0k2blGlRcz9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CF3C139DB;
        Mon, 20 Feb 2023 20:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sw3+BSPU82NrVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 20:12:19 +0000
Date:   Mon, 20 Feb 2023 21:06:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: the raid56 code does not need irqsafe locking
Message-ID: <20230220200623.GG10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230120074657.1095829-1-hch@lst.de>
 <20230215201325.GY28288@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215201325.GY28288@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 09:13:25PM +0100, David Sterba wrote:
> On Fri, Jan 20, 2023 at 08:46:57AM +0100, Christoph Hellwig wrote:
> > These days all the operations that take locks in the raid56.c code
> > are run from user context (mostly workqueues).  Drop all the irqsafe
> > locking that is not required any more.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Added to for-next, thansk.

Moved to misc-next.
