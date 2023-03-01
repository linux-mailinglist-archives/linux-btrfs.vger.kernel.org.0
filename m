Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59A6A732C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 19:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCASN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCASNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 13:13:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801451DB89
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 10:13:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52D291FE23;
        Wed,  1 Mar 2023 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677694401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qsy0TZTgkdY9ZghRa7MUADlii37jI12yOBzF9HvnbM0=;
        b=p3JvZJvpbM0SYB6SrVhCtK7LewU9V6tWCNBWiAXI8aVMrxPvh+6q8NK7REZZEPxQWx212U
        +Jc+iA4nmgxwE5DVQd21S567qy56X0ijvF9niqTUbRwC1SpfpxCyhbl6F7SSuY1ZTDcomg
        pdjq9b47cFj6NWcuMYZoPcu5jBehk1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677694401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qsy0TZTgkdY9ZghRa7MUADlii37jI12yOBzF9HvnbM0=;
        b=MYMNy/G+FI0PwYt2M/ydffEKO4zTncXhvIWFqtBkAaOO+a4xY0oCv0FQnlJFuEV8eXEg/l
        hmPR4+OwkZsXqHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B90913A3E;
        Wed,  1 Mar 2023 18:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id obawBcGV/2OxOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 18:13:21 +0000
Date:   Wed, 1 Mar 2023 19:07:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz,
        Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.2
Message-ID: <20230301180721.GV10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230228192335.12451-1-dsterba@suse.com>
 <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
 <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
 <20230301001504.GT10580@suse.cz>
 <a6fbb53a-f5bd-3d01-5944-1e7dfe60985e@gmx.com>
 <20230301013546.GU10580@suse.cz>
 <d9f2e86a-c4f7-3846-ce05-54a4113612bb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f2e86a-c4f7-3846-ce05-54a4113612bb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 01, 2023 at 09:00:11PM +0800, Qu Wenruo wrote:
> Just one question, why we support external crypto libraries in the first 
> place?

For static build of btrfs-progs we need a fallback implementation
because distros don't provide static versions of the crypto libraries.

External libraries can get a certification so if distro has to meet the
criteria then it must use only the certified libraries. This was
requested e.g. for SLES back then for the authenticated hashes.  More
libraries give users the freedom to choose the one they use.

> IIRC the built-in ones are already utilizing various optimization,

Only crc32c had an optimized version and not the fastest one, so in 6.2
there's at least one acelerated if possible.

> and 
> I'd argue that performance should not be the critical aspect for btrfs 
> anyway, as only btrfs check and btrfs-restore are really involved for 
> performance but they are all single-thread workload, far from 
> performance critical.

The checksums are still verified at read time and on a fast device the
CPU is the bottleneck, not the IO, so this is basically to keep up with
hardware speeds.

That it's single threaded is actually a problem and there's one issue
asking to make 'check --init-csum-tree' parallel. The proper checksum
switch does only checksumming so this should be accelerated and/or
parallelized. If this can shorten time to do eg. check or uuid switch or
other things then it IMO makes sense to implement.

> For best compatibility, the external crypto libs can even be a problem.

Yes, so there's the fallback.
