Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6568C799
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 21:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBFUY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 15:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBFUY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 15:24:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016E17CFF;
        Mon,  6 Feb 2023 12:24:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A109360992;
        Mon,  6 Feb 2023 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675715064;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/BcOBGjoXSzNnn+UWZhaQJzEUM9mrbxaHHpGP8Eq08=;
        b=oJ9Wz3mSmSgktwkNB/DKp0NuhWc74d2PiDqVh10w9djBN6uYoIJK2QOlx1rYkK3e8WzDP0
        Pz22tW3jqoeWkcHhuSi1Is1Q9sNqAfD71GY2sPSQgjUjKTGeo7NRkWXrMG/36FYasjkQLJ
        6b+wg8d9JN6Cos40S99uT0bqy1AynF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675715064;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/BcOBGjoXSzNnn+UWZhaQJzEUM9mrbxaHHpGP8Eq08=;
        b=Pb03ZMjCDSUQLvH0FO94VXPpmLst1FbQNNmO1fShQpwCu4Phjy/JhSNmDtjR8he8v57oC5
        X+OuXAebm0c2QxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D1DE138E7;
        Mon,  6 Feb 2023 20:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O6ijHfhh4WPadAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Feb 2023 20:24:24 +0000
Date:   Mon, 6 Feb 2023 21:18:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for v6.2-rc8
Message-ID: <20230206201836.GE28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1675710734.git.dsterba@suse.com>
 <CAHk-=wge=yaJ47XewZ0n4EbOLh222M8mCjjmhZji=n--3eyupg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wge=yaJ47XewZ0n4EbOLh222M8mCjjmhZji=n--3eyupg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 06, 2023 at 12:15:41PM -0800, Linus Torvalds wrote:
> On Mon, Feb 6, 2023 at 11:55 AM David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag
> 
> No such ref.
> 
> I see the unsigned branch 'for-6.2-rc7' but there's no actual tag there.
> 
> Forgot to push it out?

Yes, sorry, now pushed.
