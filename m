Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4688B58044E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 21:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiGYTNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 15:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGYTNM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 15:13:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB27BCAA
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 12:13:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27AC51F8CA;
        Mon, 25 Jul 2022 19:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658776389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1+3anAEBxuP2wTkU7p1ZhcAyaM6yFkezvlRTZKLrsQ=;
        b=LuxAXyruDYuRerEstve2dd9ZJ2YQ0nye0AlSNl4H5e1gGOyv2up4Qt4hfFBhVcJcrN2TPI
        xsyi4fKIaRU9CVQQ9t8SZ2qhMq/Pz/V3BlgRGnxk6IaMMTurpzRTt+ePvBTAcU6lcFn05N
        ERlpZKbGMuJy6/PlHibaVKYEXlwhEwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658776389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1+3anAEBxuP2wTkU7p1ZhcAyaM6yFkezvlRTZKLrsQ=;
        b=X2vzSiabojtQAc4xPwds60aQUFwDHydvRs5daM2c0jHbKXtsQcfiFFGzWkLhJBqmLtD7pO
        hynxVuq+GP8KLDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 049DC13A8D;
        Mon, 25 Jul 2022 19:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vPM/AEXr3mJKBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Jul 2022 19:13:08 +0000
Date:   Mon, 25 Jul 2022 21:08:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: Using async discard by default with SSDs?
Message-ID: <20220725190811.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 02:43:16PM -0400, Neal Gompa wrote:
> Hey all,
> 
> I was talking with Chris Mason today at a Fedora Hatch event about
> async discards (as we were thinking about doing this in Fedora some
> time ago[1]), and he seemed to consider it reasonable to make it so
> Btrfs uses async discards by default when being formatted on SSDs.
> 
> He and I couldn't think of a reason why not to, other than the
> potential lack of "discard=none" option to turn off discards if the
> user wanted it to. Do we already have this option? Are there any other
> reasons not to do this? Or is this something we should have changed in
> Btrfs so everyone gets async discards by default going forward?

I think it's safe to use by default, with the usual question who could
be affected by that negatively. The async triggers, timeouts and
thresholds are preset conservatively and so far there have been no
complaints.

The tunables have been hidden under debug, but there are also some stats
(like how many bytes could be discarded in the next round), so it would
be good to also publish that when it's on by default.
