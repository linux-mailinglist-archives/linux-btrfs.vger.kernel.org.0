Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21F5B0CB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 20:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIGSxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIGSxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 14:53:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF7B774C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 11:53:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A424A34051;
        Wed,  7 Sep 2022 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662576810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/ZWljjF1xQJa7DGZBrGxS79rRG95FzqEUe0t4tZ1ms=;
        b=ksyw3MxjZhoL33s1xKNGfptVWrZT6OocPNPBr5joHfVNCl7zO7SSLBv+epjHBDs2fE7dd9
        8VjZaw2Csf5tQJHi0PF5yepKASpFFhj7K7DTjG0NErx7v73VHFacDA584rXNKTT4RzTtVO
        8O/KI5dQIIfxJ7iWGqX8MjvakSwPRoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662576810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/ZWljjF1xQJa7DGZBrGxS79rRG95FzqEUe0t4tZ1ms=;
        b=TPHBMAkv47m2N/IEHM2cjNYQ+NKMU7qv58Hxw3mY0PdIcLaKm8IXJs8ET65hDLjPceIMsR
        g4ukMnE5kCFbRPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76D4313486;
        Wed,  7 Sep 2022 18:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QKIXHKroGGNWJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 18:53:30 +0000
Date:   Wed, 7 Sep 2022 20:48:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 27/31] btrfs: get rid of ->dirty_bytes
Message-ID: <20220907184807.GC32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
 <9e5e464b37fbc7973534375ff18b0fae9bf0365e.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5e464b37fbc7973534375ff18b0fae9bf0365e.1662149276.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 04:16:32PM -0400, Josef Bacik wrote:
> This was used as an optimization for count_range_bits(EXTENT_DIRTY), but
> we no longer do that, thus nothing actually uses the ->dirty_bytes
> counter in the extent_io_tree.

Same comment as for 26/31
