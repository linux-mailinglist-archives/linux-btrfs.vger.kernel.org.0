Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6176553480
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351569AbiFUOaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351573AbiFUOaW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 10:30:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E88237C1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 07:30:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C864F21B5B;
        Tue, 21 Jun 2022 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655821818;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YhuZwkc8R0APp7ayKme1tn/zeZ87wUD18EozPvEf2E=;
        b=wkVM2VCPSRCS6hPUlQsJMALpLO6lFFLvJxM4zHKR2CTBYBWbWMMSiYnfxpw9gL7nLd8yTR
        v90x0JZTy7a14laO/UO3gLgdp05sgdcrb2aMdGEIDhvYUaIozB+1nEXDQCSDUqtxqXQFE4
        d+ASNEAGPHO0DZhoryNYzBYSVyqpj/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655821818;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YhuZwkc8R0APp7ayKme1tn/zeZ87wUD18EozPvEf2E=;
        b=l7uJSFI6HZYH9a4WurH1eEkjF6Ypb64vI1MKCVZZHbRfalpTwNk+5UNy81hrUP1gAlAlnu
        xxcbBNuRSqnEf1CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D53E13638;
        Tue, 21 Jun 2022 14:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qTl9JfrVsWJjTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 14:30:18 +0000
Date:   Tue, 21 Jun 2022 16:25:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Zhang Boyang <zhangboyang.id@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [IDEA RFC] Forward error correction (FEC) / Error correction
 code (ECC) for BTRFS
Message-ID: <20220621142541.GZ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Phillip Susi <phill@thesusis.net>,
        Zhang Boyang <zhangboyang.id@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <f5cc6c6f-2238-b126-3b0e-00e9e49b0706@gmail.com>
 <87zgi65cn5.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgi65cn5.fsf@vps.thesusis.net>
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

On Tue, Jun 21, 2022 at 09:56:48AM -0400, Phillip Susi wrote:
> 
> Zhang Boyang <zhangboyang.id@gmail.com> writes:
> 
> > Here are some detailed approaches:
> >
> > 1) Zero-cost approach
> 
> <snip>
> 
> > 2) Low-cost approach:
> 
> Both of these home brew methods rely on guess and check to repair, which
> has a high computational cost and the possibility of false repair.  It
> also requires that only a minescule amount of silent corruption has
> occured.  Disk drives already have highly robust error correction and
> detection in place, so it is almost unheard of for them to silently
> corrupt data, but rather they refuse to read the whole sector.  If
> corrupt data somehow managed to pass the error detection code in the
> drive, it is highly likely that a lot more than one or two bytes will be wrong.
> 
> 
> > 3) Reed-Solomon approach:
> 
> If you are going to do error correction, this or another real FEC
> altorithm is the way to go.  Also since the drive reports corrupt
> sectors, you can use RS in erasure mode where it can correct T errors
> instead of T/2.  There is a handy tool called par2 that lets you create
> a small RS FEC archive of a file that you can later use to repair damaged
> portions of it.
> 
> Another common behavior of drives is for them to fail outright with 100%
> data loss rather than just have a few bad sectors.  For that reason, I
> think that anyone who really cares about their data should be using a
> raid and making regular backups rather than relying on an automatic on
> the fly FEC in the filesystem.  If they don't care enough to do that
> then they probably don't care enough to think the cost of online FEC is
> worth it either.

I basically agree with all the points above. Adding the FEC is an
interesting idea but it's another layer with own correction and there
are other mechanisms that protect against isolated data loss.

The introduction why to implement this lightly touches on the reasons of
the corruptions, but I think this is the crucial part. For a security
feature this would be the threat model, for storage and correctness it's
an equivalent I don't know name for.

Most common source of byte-level errors is faulty RAM, one or two bits,
and FEC can't fix all problems once a corrupted value spreads in the
structures. That's why we don't have automatic repair even for such a
"simple" type of error. If there are more bits corrupeted in different
bytes, the repair code would have to be upgraded for that.

Storage devices tend to lose data in bigger chunks, we'd have to have
large correction codes, but I think device level redundancy solves that
in a more robust way.

Ad 1, we can already do bruteforce repair, enumerating bit flipped
values for data and matching against the checksum, but it's an
unreliable guess work.

Ad 2 and 3, costly compared to plain checksum and additional measures
like redundant devices and profiles.
