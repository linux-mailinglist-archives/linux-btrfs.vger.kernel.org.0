Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3F6D257A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjCaQ3E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 12:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjCaQ2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 12:28:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C02953A
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 09:24:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B40E1FD63;
        Fri, 31 Mar 2023 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680279812;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ymt/am1c/TfRt2nBFp8eAzPaxS38M9Cw66jlzAYUEA=;
        b=LuZ5CVbPoW6gBWRXJi90RYbrPAOKfb52fsjUNZ3zekYwMMw2PHnoOAR35wERLz/0tt5y5s
        xtRi6swB/yORYzTMu9A1kqVUMN/qYRpxGnwKBa959Gz41S8vUROoZ/ldqltGMLg+TVQRpp
        yKFiWnMVAnBXoM2LbuHW0usbkhM8bak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680279812;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ymt/am1c/TfRt2nBFp8eAzPaxS38M9Cw66jlzAYUEA=;
        b=WRUFAQEFbFoimHppTp5uY5Y6k3Ra/KcaylBWdpVri39NZkHLaA42rB+bO0Q4U6BwqhiNnL
        4BqQFV9saBM1XtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F3D6134F7;
        Fri, 31 Mar 2023 16:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I7ahDgQJJ2T8JAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 31 Mar 2023 16:23:32 +0000
Date:   Fri, 31 Mar 2023 18:17:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <20230331161716.GV10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680225140.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680225140.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 31, 2023 at 09:20:03AM +0800, Qu Wenruo wrote:
> This series can be found in my github repo:
> 
> https://github.com/adam900710/linux/tree/scrub_stripe

This also includes the cleanup branch so I'll use this as topic branch
in for-next.
