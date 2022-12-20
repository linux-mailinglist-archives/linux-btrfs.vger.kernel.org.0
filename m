Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF165265B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 19:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiLTSg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 13:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiLTSg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 13:36:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354CBD2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 10:36:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81D684D712;
        Tue, 20 Dec 2022 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671561386;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMoAuXhgbHmrUk3HTRLmjfdaoe0M0ZzyZ3RwvO4WTvc=;
        b=rgIemdZXdhWRgCUYfAxDoU0mD86SrBjwVGS07T4703gm3XTkA+ExSX25K1mx7AHvM4Mm+r
        bhUy5j0wItS8hY9VXZcd7TXQ/AFE71wEsvyQn6t8n5TLiO4eI9K+Sv/y4QJAhaXw12jFO3
        lF7oAqT+7cmqNMffAHyYVz6nEn/qEg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671561386;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMoAuXhgbHmrUk3HTRLmjfdaoe0M0ZzyZ3RwvO4WTvc=;
        b=LrvD9GywlkUV1ID6jdNlZZ8vYNFPL0PFpAmz5oc58KQO1eNPL/Bgrn0OycaOsOOcC1kTtD
        VlnBwnoycXC7M2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 642021390E;
        Tue, 20 Dec 2022 18:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8cd4F6oAomM0KQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 18:36:26 +0000
Date:   Tue, 20 Dec 2022 19:35:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fscrypt name leak after failure to join log
 transaction
Message-ID: <20221220183540.GN10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c76a4f058227e32861e0afe1e1851137304a2169.1671534537.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76a4f058227e32861e0afe1e1851137304a2169.1671534537.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 11:13:33AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging a new name, we don't expect to fail joining a log transaction
> since we know at least one of the inodes was logged before in the current
> transaction. However if we fail for some unexpected reason, we end up not
> freeing the fscrypt name we previously allocated. So fix that by freeing
> the name in case we failed to join a log transaction.
> 
> Fixes: ab3c5c18e8fa ("btrfs: setup qstr from dentrys using fscrypt helper")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
