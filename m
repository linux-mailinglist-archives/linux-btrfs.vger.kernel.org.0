Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076B782D35
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjHUP0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjHUP0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 11:26:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7BEE
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 08:26:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D103C1F74D;
        Mon, 21 Aug 2023 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692631573;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJzuPnuQ3QrsdeuvxjmofHmjTNHldw5QtNZz/J8AvPQ=;
        b=j27RacsE6Xcu9DNOt+YXtxq1Fs7c4DSWC/rT5NQ34tIj921zkrKW+f7qYDepvpDZV+yugI
        rXYPQUgTU3cFR53lGnufDMTDrcNiHVmE4zUC63cTITCRMNfS5T15j5/xTkxdzLJBiH6Kfb
        0JlLzSa1v15/D3STojN9qGhgxO/UKW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692631573;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJzuPnuQ3QrsdeuvxjmofHmjTNHldw5QtNZz/J8AvPQ=;
        b=koqSflLOboFIGrnTZI5PQPx9tXIFKx8Xtxo+DwOTqMbTi9RtJMI5oDlq0KkQ5EmaCWfiPw
        idPZEPXVw0lmqrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE61C13421;
        Mon, 21 Aug 2023 15:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g9VUKRWC42RKHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Aug 2023 15:26:13 +0000
Date:   Mon, 21 Aug 2023 17:19:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Heiss <christoph@c8h4.io>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: implement json output for subvolume
 subcommands
Message-ID: <20230821151942.GD2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230813094555.106052-1-christoph@c8h4.io>
 <20230817193437.GU2420@twin.jikos.cz>
 <yp65dkmsmuw77rhsvokj73jc6h4vhbrnqch73qk5epw2eaqs5v@y5uozai7motj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yp65dkmsmuw77rhsvokj73jc6h4vhbrnqch73qk5epw2eaqs5v@y5uozai7motj>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 18, 2023 at 08:39:58PM +0200, Christoph Heiss wrote:
> First of, thanks for the review & merging right away!
> On Thu, Aug 17, 2023 at 09:34:37PM +0200, David Sterba wrote:
> >
> > On Sun, Aug 13, 2023 at 11:44:55AM +0200, Christoph Heiss wrote:
> > > [..]
> >
> > Thanks. There are a few things regarding the json output that are still
> > to be figured out and to set examples to follow. The plain and json
> > output does not match 1:1 in the printed information, here the
> > 'top level' does not need to be in the json output or there could be
> > more subvolume related info in the map.
> 
> > The textual output is unfortunatelly parsed by many tools nowadays so
> > we can't change the format. With json it's easier to filter out the
> > interesting data so "more is better" in this case.
> Right, makes sense. I skimmed through your additional commits on top,
> e.g. the null uuid thing. So all "optional" fields should rather be
> `null` than missing.
> 
> >
> > The formatter is designed in a way to allow plain text and json to be
> > printed by the same lines of code but this is namely for line oriented
> > output, like 'subvolume show'.
> Yeah, I figured that after looking at it a bit more - that's why I
> decided to leave most of the stuff as-is for now.
> 
> > [..]
> >
> > I'll put some guidelines to the documentation, the key naming must be
> > unified, e.g. 'gen' or 'generation' but there's also 'transid' used in
> > some cases etc.
> >
> > As the json format is also an ABI we need to get it finalized first
> Does it make sense to explicitly document all the possible json outputs
> with all their fields, i.e provide example outputs?

Yes, examples are very useful, all of the commands supporting json
should have coverage in the tests. For startes a command that does not
change the state could just duplicate the one done in test but with
`--format=json'. Then it'll appear in the test logs and is easy to
review or copy elsewhere.

The tests/json-formatter-test.c should cover all the basic stuff, it's
also not complete so it can serve as example provider.

We may want to put the examples into the documentation then it's also
good for understanding, though this coud get out of sync over time.

> > so I'll merge the series but put the actual support for --json option
> > under experimental build.
> Thanks! Makes it easier to improve on it gradually in any case. I will
> send some more patches your way rectifying these things as soon as I get
> to it.

Thanks.
