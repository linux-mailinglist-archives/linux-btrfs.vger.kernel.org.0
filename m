Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962F75213E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGMM0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjGMM0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 08:26:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD60268F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 05:26:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C27A1FD8B;
        Thu, 13 Jul 2023 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689250871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S3a3fsUxxCR7Xh4sO+7UxW5UV//5nq/4jdc+JMg0c1g=;
        b=beYvpoE6QhpyudnAfFUx+vZh8PWz+5WSgdRpzd7mLo63RBLz7uVbNieMg4rFspSMsQRODN
        NJ5f3h0kn8dNwTtPNeiSEG+dYTrqovzbwHXImrHwkfwJ05yRsm+9+oEm+hGa7I9eMsMzPL
        VEbwAXYFvltsPqbmXmXoWDlWOxNkITw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689250871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S3a3fsUxxCR7Xh4sO+7UxW5UV//5nq/4jdc+JMg0c1g=;
        b=mV8pV5dgw9qCUQy+NQ4d6vmwc5ireVARPn1HBnrv8FKbIJv2ow5aQBA7YTu1hBkol22Z6e
        Ro5cGqlfAMUbhTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F39E8133D6;
        Thu, 13 Jul 2023 12:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UXa0Ojbsr2R4KAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 12:21:10 +0000
Date:   Thu, 13 Jul 2023 14:14:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] btrfs: scrub: introduce SCRUB_LOGICAL flag
Message-ID: <20230713121434.GV30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688368617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 03, 2023 at 03:32:24PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> RFC->v1:
> - Add RAID56 support
>   Which is the biggest advantage of the new scrub mode.

Great, thanks. The new functionality will have to wait until the scrub
performance regression is fixed though.
