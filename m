Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677854033D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbiFGQBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbiFGQBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 12:01:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B210CBE167
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:01:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EA3021B9E;
        Tue,  7 Jun 2022 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654617667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Euwp7xyMtVvhY1RzMXPar5Y6rj7yMOTDKLUetIB3Uxs=;
        b=yWZkVYpFeKg2CtmMgytnKB4L4qitv8TCw6g04QtvoaXhof6PvvKEFrnMQVCCW7awVUF+2I
        fg3kzLh187tdyDV/HhF9PQ6fKHywpmcZ5e7bwVRrIrSQwpsKkA2wl6Ukl6lALmb4b7E5XM
        ShnLWip7RgpFkEGrWRLNuseL9G0yXdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654617667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Euwp7xyMtVvhY1RzMXPar5Y6rj7yMOTDKLUetIB3Uxs=;
        b=FnXFxK/6nplpYqefrYble3ZljhlbXsHwmGVeexq1bftEG4gtz9VETivF94L7Q8vkSH0uoC
        EAnCFd2L50yJIeBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A77513638;
        Tue,  7 Jun 2022 16:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RSxNDUN2n2LrbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Jun 2022 16:01:07 +0000
Date:   Tue, 7 Jun 2022 17:56:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop looking at btrfs_bio->iter in index_one_bio
Message-ID: <20220607155637.GM20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20220603065742.40931-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603065742.40931-1-hch@lst.de>
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

On Fri, Jun 03, 2022 at 08:57:42AM +0200, Christoph Hellwig wrote:
> All the bios that index_one_bio operates on are the bios submitted by the
> upper layer.  These are never resubmitted to an actual device by the
> raid56 code, and thus the iter never changes from the initial state.
> Thus we can always just use bi_iter directly as it will be the same as
> the saved copy.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
