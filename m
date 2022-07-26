Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80F581832
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiGZRND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGZRNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 13:13:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25341D0EF
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 10:13:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78E37379A0;
        Tue, 26 Jul 2022 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658855580;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QG/cP6+ZtvuTjagdOTaeBtSYIzJQmNnV77ffiF1t2YY=;
        b=GgaIA8FIaGG0haiDaTMhM79/yu3ZrbJOXINyy0AI2NiKIR7IFrKv/zoXMsekLOj50dIrtQ
        pkLLISTsFXkEcFMXqd31jBZy2ThNDXSEyw8TJmmgKCinrz/5TCKbTS2yFCOyJIKxGDyWZE
        VciMQh6EsbPOvo1/pWkMWjZGiu5B8rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658855580;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QG/cP6+ZtvuTjagdOTaeBtSYIzJQmNnV77ffiF1t2YY=;
        b=OY0C6i1RTGxCoGvzfQLEcETia4p2gvjXF2l4vpMhBFas+B2g0MK00LxJkj40zGB2sof1nr
        2p0MQs+MpDToiAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E65313322;
        Tue, 26 Jul 2022 17:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5x0fEpwg4GKpfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 17:13:00 +0000
Date:   Tue, 26 Jul 2022 19:08:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
Message-ID: <20220726170802.GF13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20220723074936.30FD.409509F4@e16-tech.com>
 <20220725134149.GY13489@twin.jikos.cz>
 <20220726062537.D2E7.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726062537.D2E7.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 06:25:38AM +0800, Wang Yugui wrote:
> > On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
> > > In this patch, the max chunk size is changed from 
> > > BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?
> > 
> > The patch hasn't been merged, the change from 1G to 10G without proper
> > evaluation won't happen. The sysfs knob is available for users who want
> > to test it or know that the non-default value works in their
> > environment.
> 
> this patch is in misc-next( 5.19.0-rc8 based, 5.19.0-rc7 based) now.
> 
> 5.19.0-rc8 based:
> f6fca3917b4d btrfs: store chunk size in space-info struct
>
> The sysfs knob show that current default chunk size is 1G, not 10G as
> older version.

So there are two things regarding chunk size, the default size and that
it's settable by user (with some limitations). I was replying to the
default size change while you are concerned about the max_chunk_size.

You're right that the value changed in the patch, but as I'm reading the
code it should not have any effect. When user sets a value in
btrfs_chunk_size_store() it's limited inside the sysfs handler to the
10G. Also there are various adjustments when the chunk size is
initialized (init_alloc_chunk_ctl_policy_regular).

The only difference I can see comparing master and misc-next is in
decide_stripe_size_regular()

5259         /*
5260          * Use the number of data stripes to figure out how big this chunk is
5261          * really going to be in terms of logical address space, and compare
5262          * that answer with the max chunk size. If it's higher, we try to
5263          * reduce stripe_size.
5264          */
5265         if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
^^^^
5266                 /*
5267                  * Reduce stripe_size, round it up to a 16MB boundary again and
5268                  * then use it, unless it ends up being even bigger than the
5269                  * previous value we had already.
5270                  */
5271                 ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
5272                                                         data_stripes), SZ_16M),
5273                                        ctl->stripe_size);
5274         }

Here it could lead to a different stripe_size when max_chunk_size would
be 1G vs 10G, though the other adjustments could change the upper value.
