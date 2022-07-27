Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94DB58327D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiG0Sya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiG0Sxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 14:53:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD96557C
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 10:52:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 057FE20078;
        Wed, 27 Jul 2022 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658944345;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VagTfcZcH+y1lXT+CwDnRSGo8j2eRZiWB2uExKh4u6E=;
        b=C17YIG0cAOYnbISoWsZcBGh3zJuenFanQvi9lgbaex+SpkC2MGOqY5YEJ9KtR3MwbhkDJE
        OgL5ILurzeo7iTDJcWecei88MVkCGHQ98R/EFmG6LyTzKorJV28S26YbhnQ8q3MFHRBKyv
        DQisWo4OCWJ33BX6QpuLKrNu3ClCq1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658944345;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VagTfcZcH+y1lXT+CwDnRSGo8j2eRZiWB2uExKh4u6E=;
        b=hppriu8XriG1F+1nf3+F6SrHwQmupeqhTxeNv5kcSUtTrokiKC5H1XVgRRGSUsv04jnhb5
        JUDQlZCL5/fdMGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8B2613A8E;
        Wed, 27 Jul 2022 17:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /pFhL1h74WKmJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 17:52:24 +0000
Date:   Wed, 27 Jul 2022 19:47:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: Using async discard by default with SSDs?
Message-ID: <20220727174726.GU13489@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz>
 <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
 <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com>
 <20220727145640.GS13489@suse.cz>
 <f14ed453-390b-4537-8a8c-0600e08d4278@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f14ed453-390b-4537-8a8c-0600e08d4278@www.fastmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 11:14:01AM -0400, Chris Murphy wrote:
> 
> 
> On Wed, Jul 27, 2022, at 10:56 AM, David Sterba wrote:
> > On Wed, Jul 27, 2022 at 10:50:01AM -0400, Chris Murphy wrote:
> >> What is a likely target kernel version to make discard=async the
> >> default? The merge window for 5.20 closes August 14. Is 5.21 a
> >> practical target?
> >
> > The changes for the next merge window are supposed to be done a week or
> > two before it opens, but as this is a simple change I think I can
> > squeeze it in.
> 
> For 5.20?

Yes, 5.20.

> I'm not aware of any conflict with fstrim. But I wonder if there's a
> preference to coordinate the change with util-linux folks? 

The -o discard and fstrim are independent and can be used at the same
time.

> Currently, util-linux provides fstrim.timer which runs fstrim.service every Monday at 00:00 local time. The command is:
> 
> ExecStart=/usr/sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo --verbose --quiet-unsupported
> 
> I'm not sure how they'd go about implementing an exception for Btrfs,
> either entirely or only if a discard mount option is detected. But I
> can ask?

No need for an exception, during mount btrfs track ranges that have been
trimmed and skips them when discard is requested by fstrim, so it's a
no-op.
