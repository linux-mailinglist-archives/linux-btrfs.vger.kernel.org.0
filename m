Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EA7979AB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbjIGRSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbjIGRSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:18:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB21FCC
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 10:17:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19C0A2188C;
        Thu,  7 Sep 2023 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694093959;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovaKBGbrrwxlcIxZIZX2PsAMqyGB/sYs1/qaGa79AJU=;
        b=KU133Rv8HaJyEocUlWr+5qid1ZckX2t4x3yqL2NmZfnf4nduerhvnhsJ55s4q1X9kAjiON
        7LEQn/Q/2Wz1q+27nXx38h2dEz3/k88HhuX6tZnNhBA7phckuA5bG4k5bi6gYmOjHBAVAu
        PxJJvUSl13Pp1iFtNzFoXA+CAW2g8XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694093959;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovaKBGbrrwxlcIxZIZX2PsAMqyGB/sYs1/qaGa79AJU=;
        b=h7EBYjuEJ267+GPtWNNaBjtquQXD8FOK678nUlk0FeczE/HgBEZDQ98w4z5MeUdB8BEoLQ
        ZjbX3Z9taCl2ERDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4DBE138FA;
        Thu,  7 Sep 2023 13:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VYcgN4bS+WTZQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 13:39:18 +0000
Date:   Thu, 7 Sep 2023 15:32:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs-progs: add extent buffer leak detection to
 make test
Message-ID: <20230907133246.GN3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693945163.git.josef@toxicpanda.com>
 <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
 <fe4c041b-e7a3-46ee-97fc-6ead9b2e2875@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4c041b-e7a3-46ee-97fc-6ead9b2e2875@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 06, 2023 at 06:57:55AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/6 04:21, Josef Bacik wrote:
> > I introduced a regression where we were leaking extent buffers, and this
> > resulted in the CI failing because we were spewing these errors.
> >
> > Instead of waiting for fstests to catch my mistakes, check every command
> > output for leak messages, and fail the test if we detect any of these
> > messages.  I've made this generic enough that we could check for other
> > debug messages in the future.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Another solution is to make debug build of btrfs-progs more noisy when
> eb leak is detected.
> 
> Instead of a graceful exit (which is suitable for release build), a
> noisy BUG_ON()/ASSERT() would definitely catch our attention, and
> requires less work in the test framework.

The eb leak checks are in the kernel-shared directory that does not
share much with the debugging helpers in the other code. Eg. the message
helpers, so we can't even grep for ERROR in the logs when there are no
supposed to be seen.
