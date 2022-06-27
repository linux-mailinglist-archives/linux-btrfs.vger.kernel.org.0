Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF555D671
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiF0STe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiF0STc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 14:19:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3EE008;
        Mon, 27 Jun 2022 11:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F468B81A2E;
        Mon, 27 Jun 2022 18:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E2BC3411D;
        Mon, 27 Jun 2022 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656353969;
        bh=TWYurZfD/jUE/28ERIZq8LqjtfVRpiQiuznUyRsMsO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FeAwLx+rI+mBj0NI0QoHuA4Rvcx16ZYK+rUfbIaWckGhHUG3auHvoG7DiEo27CxjZ
         Or0f6z+BNgZY2MAa270mBYYezoq1NWsREaFd+XKeSK7xj8hfT8F1fpz3SFBnoMTSxl
         /E1FBs2J9PvQ62Si3qjuZde6FIQGne1a+3Bh+mks=
Date:   Mon, 27 Jun 2022 11:19:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [RESEND PATCH v4 1/2] highmem: Make __kunmap_{local,atomic}()
 take "const void *"
Message-Id: <20220627111927.3ef94745aab4491901d43028@linux-foundation.org>
In-Reply-To: <2192593.iZASKD2KPV@opensuse>
References: <20220616210037.7060-1-fmdefrancesco@gmail.com>
        <20220616210037.7060-2-fmdefrancesco@gmail.com>
        <2192593.iZASKD2KPV@opensuse>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 27 Jun 2022 19:02:31 +0200 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:

> > v1->v2: Change the commit message to clearly explain why these functions
> >         should require pointers to const void. The fundamental argument
> >         behind the commit message changes is semantic correctness.
> >         Obviously, there are no changes to the code.
> >         Many thanks to David Sterba and Ira Weiny for suggestions and
> >         reviews.
> >
> >  arch/parisc/include/asm/cacheflush.h |  6 +++---
> >  arch/parisc/kernel/cache.c           |  2 +-
> >  include/linux/highmem-internal.h     | 10 +++++-----
> >  mm/highmem.c                         |  2 +-
> >  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> @Andrew:
> 
> Ira Weiny asked David Sterba for taking this patch through his tree because 
> it is a pre-requisite for a patch to fs/btrfs. He agreed with the above-
> mentioned suggestion, however I suppose that an ACK by you is needed.
> 
> Can you please take a look at this patch and say what you think about it?

Looks OK to me.  It's one of those "if it compiles, it's good" things.

I don't believe the patch has ever appeared on linux-mm?  Please send
it there for some review then go ahead and merge it up.

