Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515F7520D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjGMMJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjGMMJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 08:09:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DDF1FCD
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 05:09:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 806601FD97;
        Thu, 13 Jul 2023 12:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689250179;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkaK9JqSddIVxe1XJq8dXosWC4+LVlvo55mZEimgEts=;
        b=G+z80ck0Xb0VRYsS+y+R2Jbh/n1TdJ4C52UNVSpyXHV7TBKjHL76+HsRv5EnHcUd5c9la8
        dWmKrovUXULmRa/sBAm27xo3M5oqSoLB9UO0rqjmlqSqDP0zhcBOiDxvEs4CzOznU1729A
        wTzlzns9COUhlWmAyGruqXXAZJ2+7R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689250179;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkaK9JqSddIVxe1XJq8dXosWC4+LVlvo55mZEimgEts=;
        b=3fVKpufGPQSGV8KKWUP5SD1uraDhCBH70nfG2HLByDZ4piaSSszqH5YR+/16LAml8WNdfS
        oSQAPx/iuoYA00DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E9FF133D6;
        Thu, 13 Jul 2023 12:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O++0FYPpr2SZIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 12:09:39 +0000
Date:   Thu, 13 Jul 2023 14:03:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        vbabka@suse.cz, linux-mm@kvack.org
Subject: Re: [PATCH] btrfs: disable slab merging in debug build
Message-ID: <20230713120303.GT30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230712191712.18860-1-dsterba@suse.com>
 <ZK/eJlk0jb1F4E2V@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/eJlk0jb1F4E2V@infradead.org>
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

On Thu, Jul 13, 2023 at 04:21:10AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 09:17:12PM +0200, David Sterba wrote:
> > The slab allocator newly allows to disable merging per-slab (since
> > commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag
> > SLAB_NO_MERGE")). Set this for all caches in debug build so we can
> > verify there are no leaks when module gets reloaded.
> 
> So we're having a discussion on linux-mm wether to just disbale slab
> merging by default, because it really is a pain.  Maybe wait for that
> to settle before adding per-subsystem hacks for what really is a slab
> problem?

Yeah I can wait with the patch. That slab merging is considered bad is
new. I remember discussions where Linus and (maybe?) xfs guys argued
pro/against merging of slabs, where xfs wanted not-merging and had to
resort to hacks like empty slab constructor that would prevent it. I
can't find the link but that's base of my reasoning to add a flag
assuming that merging makes sense by default.
