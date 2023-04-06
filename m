Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6D6D9BB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjDFPFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbjDFPFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 11:05:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C742A273
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 08:05:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9ECB225E7;
        Thu,  6 Apr 2023 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680793532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0P/+vOueI+vFq3SC9f8/f+H7nREovCkWwhKxZ6+nmVA=;
        b=MBoFlqbOSSQYIM8BSZ6pUUKzrKqpkx2/uj4R4UxPba4KUDnoXmoaMY2axd02/BDtBgt7ql
        VDu3Bj7cACwVtcwE/NanX/a2Qi3bfNVZ/52eZjW3ggjABBavDIIC0sOqcjUYw5ZsjEUqna
        sHhDrjwjXH5mfKmN99DgSang7eJRmbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680793532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0P/+vOueI+vFq3SC9f8/f+H7nREovCkWwhKxZ6+nmVA=;
        b=JQl+cWZ9oOO4rjsjRNbBVZboRs77Mjq8stWDpcStMdat/PcGsRrtnjUfoAy7y0qKaWzxHn
        LT8P7FKWULAdpXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF9A6133E5;
        Thu,  6 Apr 2023 15:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4hYGMrzfLmSvQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 15:05:32 +0000
Date:   Thu, 6 Apr 2023 17:05:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless loop at
 btrfs_get_next_valid_item()
Message-ID: <20230406150529.GT19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa1b109d4ae1739890dfd379f10dc0540164e1cb.1680716909.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1b109d4ae1739890dfd379f10dc0540164e1cb.1680716909.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 06:52:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's pointless to have a while loop at btrfs_get_next_valid_item(), as if
> the slot on the current leaf is beyond the last item, we call
> btrfs_next_leaf(), which leaves us at a valid slot of the next leaf (or
> a valid slot in the current leaf if after releasing the path an item gets
> pushed from the next leaf to the current leaf).
> 
> So just call btrfs_next_leaf() if the current slot on the current leaf is
> beyond the last item.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
