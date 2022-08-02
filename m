Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF95881D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiHBSVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiHBSVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 14:21:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584603ED75
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 11:21:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 817971FE0D;
        Tue,  2 Aug 2022 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659464488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfM82AaayIHxCYw40L2oMVxTCMCxhvURzOG1/mSsKko=;
        b=liDgmwOGr68ZwL9kF//Q9rQCn5QkCAR07qzScFpduUn0aM8+hZIbHuN7oc2p3ifi1wB6EX
        ZFRkwSoCLet4TozAyqxu9HtXZzhje0RoR7oObbYONOEY8cwsnRBiXyEE5A/AczGdQ1m1VO
        FvG2P1a6CmdsCDcH3NpBddAboIvZ3Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659464488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfM82AaayIHxCYw40L2oMVxTCMCxhvURzOG1/mSsKko=;
        b=MXo1uAiAd5F1WxjofgDNFcdtn5hFldQfFxaM6eabmge23dcfoB5eckny01KZW2W3QTVnAu
        pyufmuEhJeTyrRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A9651345B;
        Tue,  2 Aug 2022 18:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lmgsFShr6WJYUgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 18:21:28 +0000
Date:   Tue, 2 Aug 2022 20:16:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix infinite loop with dio faulting
Message-ID: <20220802181626.GY13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
 <20220802171744.GU13489@twin.jikos.cz>
 <CAL3q7H4i891513XvuGoDgWtpg_GggLsCkoqthadRfYg4+op1MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4i891513XvuGoDgWtpg_GggLsCkoqthadRfYg4+op1MA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 07:09:28PM +0100, Filipe Manana wrote:
> On Tue, Aug 2, 2022 at 7:00 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Jul 21, 2022 at 12:10:14PM -0400, Josef Bacik wrote:
> > > Filipe removed the check for the case where we are constantly trying to
> > > fault in the buffer from user space for DIO reads.  He left it for
> > > writes, but for reads you can end up in this infinite loop trying to
> > > fault in a page that won't fault in.  This is the patch I applied ontop
> > > of his patch, without this I was able to get generic/475 to get stuck
> > > infinite looping.
> > >
> > > This patch is currently staged so we can probably just fold this into
> > > his actual patch.
> >
> > Folded to the patch, thanks.
> 
> Please don't, revert instead the original patch.

OK, patch removed from misc-next, no need to revert.
