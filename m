Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7D5AB152
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 15:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiIBNWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 09:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiIBNVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 09:21:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B75140C1
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 05:58:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2130C3461C;
        Fri,  2 Sep 2022 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662123408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQ2S+uWC84QDPIpw0iQRuFdFop1fDiM57me13Etgdeg=;
        b=fSuAjlScgWkk9IKnvnGF7aKK6KJVdmek2n+B/7IcSP1YsAuphHKSjP6jHiy/iWh2/okSHc
        p7DmYxSbtPPICM0ZzZ7DRssngGxWjTZzzYvQGQTXajWuwCt6gUQ+jWftQG2xs+Y+wH63E8
        qbP+A527NydgpL01gWqiz2FPdTHSNBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662123408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQ2S+uWC84QDPIpw0iQRuFdFop1fDiM57me13Etgdeg=;
        b=63Igjos7+EvXOPiS278/pxGC11I5iAuzgzXkJK0mGdYgBLS+w1FEfZogG8qgHu3n6UCXG0
        WQK2aDxtbJykEuDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0C061330E;
        Fri,  2 Sep 2022 12:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4tTcOY/9EWNVcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 12:56:47 +0000
Date:   Fri, 2 Sep 2022 14:51:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Message-ID: <20220902125127.GX13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <5db1f702-f6fa-3b0e-e34b-30c7ac6358e4@suse.com>
 <ab444642-8a17-cc97-8fff-3446d1ddef0e@gmx.com>
 <20220818122624.GJ13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818122624.GJ13489@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 02:26:24PM +0200, David Sterba wrote:
> On Mon, Jul 11, 2022 at 04:47:25PM +0800, Qu Wenruo wrote:
> > No need to completely cancel each other.
> > 
> > In fact, just COWing a path without adding/deleting new cousins would be
> > enough, and that would be very common for a lot of tree block operations.
> 
> I would be interested in numbers too, a percentage of skip/total would
> be good for some workloads so we have at least some idea.

I'll keep the patch in for-next until we see some numbers about how much
the optimization is used.
