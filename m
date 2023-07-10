Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5DD74DBD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGJRBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGJRBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 13:01:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733BD7;
        Mon, 10 Jul 2023 10:01:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6326D22395;
        Mon, 10 Jul 2023 17:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689008501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOtTX6s7w9z7D6aTHjb/pLRsGubENakrzEs/lihRqvc=;
        b=i0AXtNanxc92LvaBMNLrkL+g2Hw11JA1Q/s0KG3ESKayp5bleB9MqynOl7k0FceGmJ4ydg
        cSgdkWqIAWaDWaoqfBxiL8NuG3U5a1s0u6912uTcIrk5i6k0K1ujTNmuPjKoKehTwpHWlB
        QVX4La3o1NvN+y5qswzakw5YuncmZDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689008501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOtTX6s7w9z7D6aTHjb/pLRsGubENakrzEs/lihRqvc=;
        b=DB0AuoCvyPdxv0/oFtG7v1HQPXaYNpA1K42+/sp5Sec3cycozrj1uMYe0PQedXyh2cwM1a
        G9nhijO99RBrKpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AFEB13A05;
        Mon, 10 Jul 2023 17:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHi8CXU5rGSkCwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Jul 2023 17:01:41 +0000
Date:   Mon, 10 Jul 2023 18:55:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: avoid Wmaybe-uninitialized warnings
Message-ID: <20230710165506.GA30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230705140117.795478-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705140117.795478-1-arnd@kernel.org>
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

On Wed, Jul 05, 2023 at 04:01:08PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The -Wmaybe-uninitialized warning option in gcc produces tons of false
> positive warnings when KASAN is enabled, as that turns off some required
> optimizations.

Which version of gcc produces the warnings? I have KASAN enabled and
don't see any warnings, with gcc 13. Making the warning conditional
would effectively turn it off for me which means I can't catch the
warnings early. We do get reports from various build bots with
various arch/compiler combinations and fix the warnings.

If there's a know minimum compiler version where there are no reports
(or reasonably small nubmer to fix) then I'd rather make the condition
bassed on that, neither on KASAN nor any similar feature for that matter.
