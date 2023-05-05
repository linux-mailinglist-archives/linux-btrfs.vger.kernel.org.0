Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81AF6F84E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjEEOcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjEEOcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 10:32:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404451634D
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 07:32:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02A3821D5E;
        Fri,  5 May 2023 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683297172;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIB8iR4fpozev0EZ6enoCx9bya8yx643oWTG9wgu+go=;
        b=vsUdpHQkf5GUEtPIaaJzpMJxtYLpgz9RZmlk1taQnAf2akROVEtNCuiG4z8Cydk/I5ppXJ
        BEtgdyKWb0QDsFyfLbDnFQ47waTWYpWZDhkKAFuAnSgpHhxmqN2miCOSbf7dvmErovhHd+
        KOmHGCDJrEqB8wsDApiDy/QOqub/Obw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683297172;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIB8iR4fpozev0EZ6enoCx9bya8yx643oWTG9wgu+go=;
        b=gjmySneKGd9sqT3Td/pcyd0EhGnGJRZlMvNiLv5jvMKNfyNgXluDq6O0AiSCNXoxVSsPRH
        1UfULfdjgSWht/CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2DD913513;
        Fri,  5 May 2023 14:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PyKcMpMTVWTndQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 14:32:51 +0000
Date:   Fri, 5 May 2023 16:26:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix may be used uninitialized in
 __set_extent_bit
Message-ID: <20230505142655.GS6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <377fe88656a9ebaa34e60debc5ae80638e277076.1683210012.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377fe88656a9ebaa34e60debc5ae80638e277076.1683210012.git.anand.jain@oracle.com>
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

On Thu, May 04, 2023 at 10:37:08PM +0800, Anand Jain wrote:
> Compiler is throwing out this false positive warning in the following
> function flow. Apparently, %parent and %p are initialized in tree_search_for_insert().
> 
>   __set_extent_bit()
>   state = tree_search_for_insert(tree, start, &p, &parent);
>   insert_state_fast(tree, prealloc, p, parent, bits, changeset);
>    rb_link_node(&state->rb_node, parent, node);
> 
> 
> Compile warnings:
> 
> In file included from ./common/extent-cache.h:23,
>                  from kernel-shared/ctree.h:26,
>                  from kernel-shared/extent-io-tree.c:4:
> kernel-shared/extent-io-tree.c: In function ‘__set_extent_bit’:
> ./kernel-lib/rbtree.h:80:28: warning: ‘parent’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   node->__rb_parent_color = (unsigned long)parent;
>                             ^~~~~~~~~~~~~~~~~~~~~
> kernel-shared/extent-io-tree.c:996:18: note: ‘parent’ was declared here
>   struct rb_node *parent;
>                   ^~~~~~
> In file included from ./common/extent-cache.h:23,
>                  from kernel-shared/ctree.h:26,
>                  from kernel-shared/extent-io-tree.c:4:
> ./kernel-lib/rbtree.h:83:11: warning: ‘p’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   *rb_link = node;
>   ~~~~~~~~~^~~~~~
> kernel-shared/extent-io-tree.c:995:19: note: ‘p’ was declared here
>   struct rb_node **p;
> 
> 
> Fix:
> 
>  Initialize to NULL, as in the kernel.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.
