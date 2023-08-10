Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14872777EC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHJRGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHJRGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 13:06:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6C2690
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 10:06:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49DA221865;
        Thu, 10 Aug 2023 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691687197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG3MWYQTk23RDUbpfQcXisXUNE6CtxFoGqTKK9r0rI4=;
        b=WikXbMXk+kGXGh1qkEtGBRR3BEwcSVyOcd/j3+VNULuFzSnKUiVruDJe9leWFs3dMmwDGM
        XqdnFBX+wUMqJM+Q9RLgc8OBvqrfnX+2eguwEfHVlvfhAQCNw+U+L+StcMaQD0Xv/p3b6c
        0YMliWLNYYQkIPIfCvlBD3VsKcVq3Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691687197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG3MWYQTk23RDUbpfQcXisXUNE6CtxFoGqTKK9r0rI4=;
        b=myPcRXE29xjbEGWqH168+REKayxE6KFOK2b5bnHdSoP3ajYEfGFgl6ozxybybTJrkr50h4
        8L6G7OrmeBzgijAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 262AB138E0;
        Thu, 10 Aug 2023 17:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4uJ6CB0Z1WTrSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 17:06:37 +0000
Date:   Thu, 10 Aug 2023 19:00:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs: use nocow_end for the loop iteration in
 run_delalloc_cow
Message-ID: <20230810170012.GI2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724142243.5742-1-hch@lst.de>
 <20230724142243.5742-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142243.5742-6-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 07:22:42AM -0700, Christoph Hellwig wrote:
> When run_delalloc_cow allocates an ordered extent for an actual
> NOCOW range, it uses the nocow_end variable calculated based on
> the current offset and the nocow_args.num_bytes value returned
> from can_nocow_file_extent for all the actual I/O, but the loop
> iteration then resets cur_offset to extent_end, which caused
> me a lot of confusion.  It turns out that nocow_end is based
> of the minimum of the extent end and the range end, and thus
> actually works perfectly fine for the loop iteration, but
> using a different variable here from the actual I/O submission
> is horribly confusing and wasted some of my precious brain
> cells when train to understand the logic.

I'm editing out such personal notes from changelogs or rephrase them to
be relevant to the code regarding readability. In the long term nobody
cares how a developer felt while understanding or writing the code, we
always know better in the hindsight.
