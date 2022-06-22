Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0855550C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359444AbiFVTs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbiFVTsQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 15:48:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B191117D
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 12:48:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF7AB1F86A;
        Wed, 22 Jun 2022 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655927293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOXNHcCeyQtHtbrrwMS9t5qRnnMzdEs78jcRyh+/GZ4=;
        b=GA4vRfV0WFH09pU07ydMSYIDnBXGawZdHVcjPZ7jFvJ/XOsWlheEtFlD9/OFiZ12zKTBKp
        ySkFrBK5GH2oVQ0HpKSPZHHkC9tFYnlWW5tK+Xd8NV/L7zpsggUSMK0jWoPG2c9emEk0Ur
        OfhYZSkUVdVC7oTGZ+GEjBQFC/HICao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655927293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOXNHcCeyQtHtbrrwMS9t5qRnnMzdEs78jcRyh+/GZ4=;
        b=VlEBDnMaUeS3CZRkogBteKW5kQ11UHO8a4IZopjKXl/6q9fp/rc6gfY4vaNg/RnHyd4imo
        /fsRRXSA5X1mvtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91990134A9;
        Wed, 22 Jun 2022 19:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xeGWIv1xs2JiXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 19:48:13 +0000
Date:   Wed, 22 Jun 2022 21:43:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: reset block group chunk force if we have to wait
Message-ID: <20220622194335.GN20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
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

On Mon, Jun 13, 2022 at 06:31:17PM -0400, Josef Bacik wrote:
> If you try to force a chunk allocation, but you race with another chunk
> allocation, you will end up waiting on the chunk allocation that just
> occurred and then allocate another chunk.  If you have many threads all
> doing this at once you can way over-allocate chunks.
> 
> Fix this by resetting force to NO_FORCE, that way if we think we need to
> allocate we can, otherwise we don't force another chunk allocation if
> one is already happening.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
