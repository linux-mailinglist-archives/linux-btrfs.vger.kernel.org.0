Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C8569257
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 21:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiGFTHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGFTHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 15:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E81C11C;
        Wed,  6 Jul 2022 12:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9716D62074;
        Wed,  6 Jul 2022 19:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AECC3411C;
        Wed,  6 Jul 2022 19:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657134434;
        bh=K38rVZ1m/HFXpPYNXoStTqJQXufHClahIpkV/lUJaus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iu3oMjLgVa4VT0I8PzUHKZ8okMFKeXKQV5F7gYfc1Rs/y7wXKrjDwm9jifcHo2FwE
         OLlblTM1qQzekK4zwzsdoSBnhP9uPhaVqUQXy10GjMaeBtVNSXsnN9pqjplsY1CPF2
         1lpdYlYRvtsiwk3uILEzHv7/7p11vvyIUoK5xbI8=
Date:   Wed, 6 Jul 2022 12:07:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v6 1/2] highmem: Make __kunmap_{local,atomic}() take
 "const void *"
Message-Id: <20220706120712.31b4313f17cb7ae08618c90e@linux-foundation.org>
In-Reply-To: <20220706111520.12858-2-fmdefrancesco@gmail.com>
References: <20220706111520.12858-1-fmdefrancesco@gmail.com>
        <20220706111520.12858-2-fmdefrancesco@gmail.com>
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

On Wed,  6 Jul 2022 13:15:19 +0200 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:

> __kunmap_ {local,atomic}() currently take pointers to void. However, this
> is semantically incorrect, since these functions do not change the memory
> their arguments point to.
> 
> Therefore, make this semantics explicit by modifying the
> __kunmap_{local,atomic}() prototypes to take pointers to const void.
> 
> As a side effect, compilers will likely produce more efficient code.
> 

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please include this in the btrfs tree if/when [2/2] is added.
