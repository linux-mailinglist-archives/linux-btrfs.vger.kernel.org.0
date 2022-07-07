Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD256A8A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiGGQwe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiGGQwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 12:52:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29457200
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 09:52:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5580621FE1;
        Thu,  7 Jul 2022 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657212743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gTUl6c7wv6QQ0iR9NVEOKsO5XJ/lX51qMTXbK9caEro=;
        b=NwRblmWbdzZLeTrZfhGyv1rqNZ8mTnFJ/EAOqTFmPVZ1lBvwCHIBI6aNULeQZ78ovx8erj
        buSXYZ8fBLVStbPyPe2m80k+bhVGYGPSemtjEUywTAczueB2z24INdWHwMAOrnnZoOA5tQ
        67sAg/h2y0E1xywQcm61visQ3g5s0EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657212743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gTUl6c7wv6QQ0iR9NVEOKsO5XJ/lX51qMTXbK9caEro=;
        b=NQuKu0wJEW1gAQzNrFgl9ZxcflD4HBzkOYyuZmwfpR2N+RGvMNFasZMiewp78Djyc3KUjA
        cqdw3kS4h2RRedCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 334FC13461;
        Thu,  7 Jul 2022 16:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K41UC0cPx2LwbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 16:52:23 +0000
Date:   Thu, 7 Jul 2022 18:47:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: return -EAGAIN for NOWAIT dio reads/writes on
 compressed and inline extents
Message-ID: <20220707164736.GH15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1656934419.git.fdmanana@suse.com>
 <b3864441547e49a69d45c7771aa8cc5e595d18fc.1656934419.git.fdmanana@suse.com>
 <YsLVtZ+SpKOfiD5Z@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLVtZ+SpKOfiD5Z@infradead.org>
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

On Mon, Jul 04, 2022 at 04:57:41AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 04, 2022 at 12:42:03PM +0100, fdmanana@kernel.org wrote:
> > +		 * filemap_read(), we fail to fault in pages for the read buffer,
> > +		 * in which case filemap_read() returns a short read (the number
> > +		 * of bytes previously read is > 0, so it does not return -EFAULT).
> 
> Two overly long lines here, which are especially annoying in block
> comments as they completely break the layout.

The only line that is not under 81 is the last one and what does not if
is "T).". This is within the acceptable overflow and I adjust many lines
in patches based on how the code looks (ie. avoiding some line breaks)
and if the potentially overflown text does not obscure the meaning.

Keeping the lines under 80 makes sense for me personally when resolving
conflicts in the 3+1 vimdiff view, but the limit is not strict and the
criteria is if the code follows the common patterns we've settled on and
what people in the btrfs group are used to, either reading or writing.
The kernel coding style does not cover everything and is a good starting
point. The rest is at
https://btrfs.wiki.kernel.org/index.php/Development_notes#Coding_style_preferences
