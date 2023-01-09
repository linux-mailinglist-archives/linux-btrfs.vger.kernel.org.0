Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE694663159
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjAIUVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 15:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjAIUVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 15:21:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7871E2B
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Jan 2023 12:20:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6577D20A08;
        Mon,  9 Jan 2023 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673295653;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbUaYHfR22kbdMs1aiPfrSl9arltiE/tK6NcW6jopw4=;
        b=etMv0ALbEp6eic7bShc1gV2yh4IgS1MuywlZiJ6b2jZ1e0MRQfd0rGY7YByizysDeo2vim
        1l0rn0nlV5KH6uoqeF+/mAM3T5srAfBdv4HsurnV28VoZ0lFJVq89fYpSvESQ1q+bVf7on
        4aKfr9ic0dEoNnxAdj1hMvGELRfz3o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673295653;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbUaYHfR22kbdMs1aiPfrSl9arltiE/tK6NcW6jopw4=;
        b=qJbKRDlT2QEXWQE1DuNDa/JqvciozwF6x2o+tNrxy9om/sNakLPc5esn6za26gvNG4SA9J
        lZk+DpMPrW9Gh/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2781013583;
        Mon,  9 Jan 2023 20:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q2Q1CCV3vGOtZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Jan 2023 20:20:53 +0000
Date:   Mon, 9 Jan 2023 21:15:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: minor sb clearing improvements
Message-ID: <20230109201519.GX11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221121174749.387407-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121174749.387407-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 21, 2022 at 06:47:47PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series moves btrfs off the deprecated write_one_page API that
> requires ->writepage to be implemented (in this case on the block
> device inode), and while doing so also avoids a pointless sb read
> for zoned file systems.
> 
> Diffstat:
>  volumes.c |   50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

Added to misc-next, thanks.
