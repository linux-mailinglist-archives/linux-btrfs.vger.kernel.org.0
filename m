Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F087521E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjGMMwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 08:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGMMwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 08:52:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473B199E
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 05:52:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8C331FD8B;
        Thu, 13 Jul 2023 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689252738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5r0GwtALlY28z/efpVZ1b/y6GU2hTuNKb/IFsylBdsM=;
        b=cuMolVpjci9tVWNrLU3EhK9PwbptmuRkZYhNhQLZ0EM2XcYSE67qsH/qUPkxB2gihm2B4C
        in0dCNWG2KaSZ1OpFo/DBngP9NDe3df9Z2Bp7VGwjGMh0IG7Zn1WpMbiiFBZbnXlhOyrQZ
        4bzTgTOrtv5uHMUMCHMU9IW92QI48Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689252738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5r0GwtALlY28z/efpVZ1b/y6GU2hTuNKb/IFsylBdsM=;
        b=JuclylUS/Cu5oBiijdB37r0LnGFZfplqQawQpNWgrVheteGxnKfI7hGCC8v5Ti8WZ5NqeJ
        8rlxTeCfz0QBKhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD536133D6;
        Thu, 13 Jul 2023 12:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0abBKYLzr2S9OAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jul 2023 12:52:18 +0000
Message-ID: <b8f5d4e1-12c6-ec45-abb5-6ae65ecc8bb2@suse.cz>
Date:   Thu, 13 Jul 2023 14:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: disable slab merging in debug build
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230712191712.18860-1-dsterba@suse.com>
 <ZK/eJlk0jb1F4E2V@infradead.org> <20230713120303.GT30916@twin.jikos.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230713120303.GT30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/13/23 14:03, David Sterba wrote:
> On Thu, Jul 13, 2023 at 04:21:10AM -0700, Christoph Hellwig wrote:
>> On Wed, Jul 12, 2023 at 09:17:12PM +0200, David Sterba wrote:
>> > The slab allocator newly allows to disable merging per-slab (since
>> > commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag
>> > SLAB_NO_MERGE")). Set this for all caches in debug build so we can
>> > verify there are no leaks when module gets reloaded.
>> 
>> So we're having a discussion on linux-mm wether to just disbale slab
>> merging by default, because it really is a pain.  Maybe wait for that
>> to settle before adding per-subsystem hacks for what really is a slab
>> problem?
> 
> Yeah I can wait with the patch. That slab merging is considered bad is
> new.

Yeah, I wouldn't say it's universally accepted. But even if we change the
default, it's just a default that distros or users might not follow, so
there's still a space for per-cache enforcement IMHO.

> I remember discussions where Linus and (maybe?) xfs guys argued
> pro/against merging of slabs, where xfs wanted not-merging and had to
> resort to hacks like empty slab constructor that would prevent it. I
> can't find the link but that's base of my reasoning to add a flag
> assuming that merging makes sense by default.

Probably this discussion?

https://lore.kernel.org/all/CA+55aFyepmdpbg9U2Pvp+aHjKmmGCrTK2ywzqfmaOTMXQasYNw@mail.gmail.com/
