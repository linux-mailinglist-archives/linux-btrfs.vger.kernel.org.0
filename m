Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9F4C71FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 17:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiB1Qwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 11:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiB1Qwm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 11:52:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493185BFB;
        Mon, 28 Feb 2022 08:52:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 79765219AE;
        Mon, 28 Feb 2022 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646067121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XocCnGjm2EQXZ0laNpIeMqRP6VR8fqTUlbHXocSsTtc=;
        b=OSD1g+gnDTctBNt0JAVhfwCEE0FfzGz72nb14G7Z6yegCoTGabziegffuhYyGT4LqIrAjJ
        m2xtgmr29J1fw0zlRQFySRNlWteNXVDP4WyBHVdWwqrPD3x+4/mXjJxn3QqIs/qUyrL9NQ
        tV1qC/WkiR8wZ/nTsd8YUlDtha3baLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646067121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XocCnGjm2EQXZ0laNpIeMqRP6VR8fqTUlbHXocSsTtc=;
        b=CUMJ0mU9zPQqboqou/A2n4GfErSVQkqKd36wRxosoZL4GjTDrhCLxEjmIzRNsLXXuBwAjN
        Du2iJBUgvk0/CcBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6D5B6A3B87;
        Mon, 28 Feb 2022 16:52:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43D88DA823; Mon, 28 Feb 2022 17:48:10 +0100 (CET)
Date:   Mon, 28 Feb 2022 17:48:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4] btrfs: add fs state details to error messages.
Message-ID: <20220228164810.GI12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <a059920460fe13f773fd9a2e870ceb9a8e3a105a.1645644489.git.sweettea-kernel@dorminy.me>
 <20220224132210.GS12643@twin.jikos.cz>
 <284ccc08-8de7-9188-19d8-20f4eda56cb4@dorminy.me>
 <20220224184231.GZ12643@twin.jikos.cz>
 <20f14d85-6a07-e66d-4711-c16c6930c2a3@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20f14d85-6a07-e66d-4711-c16c6930c2a3@dorminy.me>
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

On Thu, Feb 24, 2022 at 03:09:08PM -0500, Sweet Tea Dorminy wrote:
> >> All the other interactions with info->fs_state are test/set/clear_bit,
> >> which treat the argument as volatile and are therefore safe to do from
> >> multiple threads. Without the READ_ONCE (reading it as a volatile),
> >> the compiler or cpu could turn the reads of info->fs_state in
> >> for_each_set_bit() into writes of random stuff into info->fs_state,
> >> potentially clearing the state bits or filling them with garbage.
> > I'm not sure I'm missing something, but I find the above hard to
> > believe. Concurrent access to a variable from multiple threads may not
> > produce consistent results, but random writes should not happen when
> > we're just reading.
> 
> Maybe I've been reading too many articles about the things compilers are 
> technically allowed to do. But as per the following link, the C standard 
> does permit compilers inventing writes except to atomics and volatiles: 
> https://lwn.net/Articles/793253/#Invented%20Stores

There's a difference between technically allowed to do and actually
doing it. The article sections says that no such compiler is known with
some exception of an old one that got fixed. Also as I read the example
of the invented write, it's very specific and I don't se how it applies
here at all.

> >> Even if this is right, it'd be rare, but it would be exceeding weird
> >> for a message to be logged listing an error and then future messages
> >> be logged without any such state, or with a random collection of
> >> garbage states.
> > How would that happen? The volatile keyword is only a compiler hint not
> > to do optimizations on the variable, what actually happens on the CPU
> > level depends if the instruction is locked or not, so different threads
> > may read different bits.
> > You seem to imply that once a variable is not used with volatile
> > semantics, even just for read, the result could lead to random writes
> > because it's otherwise undefined.
> 
> Pretty much; once a variable is read without READ_ONCE, it's unsafe to 
> write a new value on another thread that depends on the old value. 

You're giving 'volatile' too much credit for guaranteeing safety for
interprocess operation, it's just a compiler hint to avoid
optimizations, it's not a synchronization primitive. In some cases
lockless reads are safe, as long as there are no updates or potential
reloads between reads that could be changed by another thread. We use
READ_ONCE in many cases, compiler in most cases generates the same
instructions as without it and it's merely an annotation and a way of
syntactic comment to denote special handling.

> Imagine a compiler which invents stores; then if you are both reading 
> and setting a variable 'a' on different threads, the following could happen:
> 
> thread 1 (reads)       thread 2 (modifies)
> 
> reads a into tmp
> 
> stores junk into a
> 
>                                  reads junk from a
> 
> stores tmp into a
> 
>                                  writes junk | 2 to a
> 
> 
> Now a contains junk indefinitely.

But we're only reading here, that why I don't see any real risk. We read
a variable, potentially changed from other thread, and actually changed
by atomic bit operations. Where are the invented writes going to come
from, can't we rely on the bit handling primitives?

If you're example above would be real, we'd either lack proper locking
or there's a serious problem with compiler that would blow up in many
places (like inventing newly set bits in flags or random values
appearing in regular variables).

> But if it's too theoretical, I'm happy to drop it and amend my paranoia 
> level.

I think it's highly theoretical but the READ_ONCE should be there as a
matter of clean code practice, so I've updated the code.
