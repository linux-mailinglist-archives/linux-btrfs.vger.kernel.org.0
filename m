Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAE7375C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFTUNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjFTUNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 16:13:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01519B5;
        Tue, 20 Jun 2023 13:12:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA570218A4;
        Tue, 20 Jun 2023 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687291973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Zol/ooqdI2ax9MkI9TIa4tWOWyf9tSffoVLyu/tigA=;
        b=V5bpMbBctxRSCm2WfMWxSEjANOySZhyqzSAhUpimC6RpKdbRLNWCTs9uU+S+5sZYWso445
        TDhU70dea90cg9X8smDHOpj9cuDvkDIEwuOapcTxb+WTlJQEtvnPgR1DM4Lao/p6SRIHnx
        2JypbAPw68xDZnZCsIUpgO9UIY9NhIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687291973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Zol/ooqdI2ax9MkI9TIa4tWOWyf9tSffoVLyu/tigA=;
        b=90dBt8dlBrczuvvaQ3pMffeviClFyi+VgCsca6Ln+IOIs52tIpk+rSMj9/ZXcvZiyTeMsO
        LZpGqOtXQnWXuiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9D0B1346D;
        Tue, 20 Jun 2023 20:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TQB9LEUIkmR8bwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Jun 2023 20:12:53 +0000
Date:   Tue, 20 Jun 2023 22:06:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fix for 6.4-rc8
Message-ID: <20230620200630.GM16168@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687283675.git.dsterba@suse.com>
 <CAHk-=whH1oW+bFGxbWOdfkB930fZMm7maKywgvpKXkWXmQi2zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whH1oW+bFGxbWOdfkB930fZMm7maKywgvpKXkWXmQi2zQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 12:00:35PM -0700, Linus Torvalds wrote:
> On Tue, 20 Jun 2023 at 11:30, David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag
> 
> I think you forgot to push the tag.
> 
> I see 'refs/heads/for-6.4-rc7' in your repo that contains the commit
> you mention, but no corresponding signed tag.

Ah right, sorry, now pushed.
