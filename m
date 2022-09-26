Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B15EADBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIZRMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiIZRMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 13:12:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF36BCE0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 09:21:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B382021FA5;
        Mon, 26 Sep 2022 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664209299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjqJTgYwwsbk5Jh8NxL/Vh94uZ0+LZcIk1EGpM/ekMA=;
        b=HOrlvvpZRuvrjk8+/HcOBbWGP+e/NMpw1d1JBr9PfS0lKR56NpEC8yLpPgrynPtPie92Fj
        LstOpI7eLQ23D4tzMFno55ebcf0gDVdDUaI/flIr/CBxWPXCtD894ZJwsvRRS191RcLw+8
        A8Z8VKkPWHCyUFq7fgKuddMkOvVUOp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664209299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjqJTgYwwsbk5Jh8NxL/Vh94uZ0+LZcIk1EGpM/ekMA=;
        b=yGEI1wtyM+vpLtQZJqT2FZw87IdS0PMmvM/wG+lq05cg3ECsd040UU4LTAzV9P+KsYIE0R
        rxa/f3lRngqq/wAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95F0F139BD;
        Mon, 26 Sep 2022 16:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a8zCI5PRMWNDPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 26 Sep 2022 16:21:39 +0000
Date:   Mon, 26 Sep 2022 18:16:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: fstests btrfs/232 triggle warning of
 btrfs_extent_buffer_leak_debug_check
Message-ID: <20220926161604.GA13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220925141807.168A.409509F4@e16-tech.com>
 <CAL3q7H5wth3OR9obGTh7fbdaqsR7A4LDKmp4uQqBvF+F24CgDg@mail.gmail.com>
 <20220926201940.B938.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926201940.B938.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 26, 2022 at 08:19:43PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Sun, Sep 25, 2022 at 8:06 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi,
> > >
> > > fstests btrfs/232 triggle warning of btrfs_extent_buffer_leak_debug_check
> > 
> > Try the fixup I reported here:
> > 
> > https://lore.kernel.org/linux-btrfs/20220926091440.GA1198392@falcondesktop/
> > 
> > And see if it still triggers the leak.
> > Thanks.
> 
> With this fixup, this leak does not happen again.
> test times: 3
> 
> Thanks a lot.

Thank you for the report and test.
