Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985B87CEB9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 01:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRXLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRXLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 19:11:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C894113
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 16:11:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEF491F88B;
        Wed, 18 Oct 2023 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697670664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXoW7C9w0WxGQN14rkwTQNV6cFadPwVOQRi7ZIvo4xo=;
        b=z3jAeGJBL+LWsWBJ1+ySz8pQI+5QlLuOpwIfuM5c2UUbiQ0UrGQEpoxnDpJoQhAwcDvRFb
        jYo2RFwlle/rokRMoQLqCd9AH+C6Cx1Z2D3pdQTvElLFTDXvrJWaoc3zHsaTc9Prxpu36f
        oeF0WweOkpLXMv95k7LljcScfsub/JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697670664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXoW7C9w0WxGQN14rkwTQNV6cFadPwVOQRi7ZIvo4xo=;
        b=gPQoC1ZsMDyrxsULnumCkHZ69jMn/LYopvG3gf+zpm7+RHL991C9TV6kAq7e5gSu9jjNEl
        G5sNzQ5seKrNv2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91BEF13915;
        Wed, 18 Oct 2023 23:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cvC6IghmMGWjRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 Oct 2023 23:11:04 +0000
Date:   Thu, 19 Oct 2023 01:04:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
Message-ID: <20231018230413.GD26353@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
 <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
 <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
 <20231009235910.GY28758@twin.jikos.cz>
 <179437dc-8be2-2ff1-e8c5-a322c29f13da@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179437dc-8be2-2ff1-e8c5-a322c29f13da@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmx.com];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,suse.com,gmx.com]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 18, 2023 at 03:37:54PM +0200, Guilherme G. Piccoli wrote:
> On 10/10/2023 01:59, David Sterba wrote:
> > On Mon, Oct 09, 2023 at 01:37:22PM +0530, Anand Jain wrote:
> >>>> Can Guilherme send an RFC patch for feedback from others and
> >>>> copy suggested-by. Because, I haven't found a compelling reason
> >>>> for the restriction, except to improve the user experience.
> >>
> >> My comments about the superblock flag are above.
> >>
> >> User experiences are subjective, so we need others to comment;
> >> an RFC will help.
> > 
> > A few things changed, the incompat bit was supposed to prevent
> > accidentally duplicated fsids but with your recent changes this is safe.
> > This would need to let Guilherme check if the A/B use case still works
> > but this seems to be so as I'm reading the changelog.
> > 
> > In a controlled environment the incompat bit will not bring much value
> > other than yet another sanity check preventing some user error, but
> > related only to the multiple devices.
> 
> Hi David and Anand, I've manage to test misc-next of today, that
> includes both this patchset as well as the "support cloned-device mount
> capability​" one.
> 
> It seems to be working fine for our use case, though I'll test a bit
> more on Deck. I was able to mount the same filesystem (spread in 2 nvme
> devices) at the same time, in any order...the second one always get the
> temp-fsid. Tested also re-mounting the devices on other locations, and
> it seems all consistent, with no error observed.

Great, thanks.

> I also question the value of the incompat flag, not seeing much use for
> that..looping Qu Wenruo as they first suggested this flag-based
> approach, in case there is some more feedback...

Yeah at this point I don't see the need for the incompat bit, which is
the better outcome.

> Anyway, thanks for your improved approach Anand and to David: is it
> expected to land on 6.7?

Yes, what's in misc-next is queued for 6.7, also we have the whole
development cycle to fix remaining bugs.
