Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4894850180A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiDNQA1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350121AbiDNPQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 11:16:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65860DFD67
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 07:58:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CA8F21618;
        Thu, 14 Apr 2022 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649948334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSa3MbWzz0JlPDZjT9u363rAkxZctYYIJERG4VwVSgo=;
        b=h3fTACVPDo6RSqLjOPshc8UNthQDgwntLO9YvxL/5Smmjr37xnttX6GuQBYAN7P83RxgZF
        X6Eq0Q+9a2SYZ9cVTo9hKEUnR6GKPjMkuFGA2piwY3P0zHXu5y6BOo7h2VFtyQmJDdMRHl
        ZNDR+9DgGionJiXphMJiAu1BF7eqnPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649948334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSa3MbWzz0JlPDZjT9u363rAkxZctYYIJERG4VwVSgo=;
        b=Jb7v41y4B67EX+wi3X26Jz2Ta93gkXksa7tZ6oz4GOPqF/ieDowbNb85yRRq7kYXc+tdeh
        Y/cWOPKv++bMX+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDF7113A86;
        Thu, 14 Apr 2022 14:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3650Na02WGIuaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Apr 2022 14:58:53 +0000
Date:   Thu, 14 Apr 2022 16:54:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v3] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220414145446.GO15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220414101054.15230-1-gniebler@suse.com>
 <d108b994-3583-e794-d14e-f07e4cc3d91a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d108b994-3583-e794-d14e-f07e4cc3d91a@suse.com>
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

On Thu, Apr 14, 2022 at 04:18:53PM +0300, Nikolay Borisov wrote:
> > -	radix_tree_preload_end();
> 
> nit: One suggestion instead of relying on the goto again; do implement what's
> essentially a do {} while() loop, this code can be easily turned into a
> well-formed do {} while(). Usually this type of construct (label to implement a loop)
> is used to reduce indentation levels however in this case I did the transformation
> and we are not breaking the 80 chars line:
> 
>      21         do {
>      20                 node = btrfs_get_delayed_node(btrfs_inode);
>      19                 if (node)
>      18                         return node;
>      17
>      16                 node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
>      15                 if (!node)
>      14                         return ERR_PTR(-ENOMEM);
>      13                 btrfs_init_delayed_node(node, root, ino);
>      12
>      11                 /* cached in the btrfs inode and can be accessed */
>      10                 refcount_set(&node->refs, 2);
>       9
>       8                 spin_lock(&root->inode_lock);
>       7                 ret = xa_insert(&root->delayed_nodes, ino, node, GFP_NOFS);
>       6                 if (ret) {
>       5                         spin_unlock(&root->inode_lock);
>       4                         kmem_cache_free(delayed_node_cache, node);
>       3                         if (ret != -EBUSY)
>       2                                 return ERR_PTR(ret);
>       1                 }
>    152          } while (ret);
> 
> I personally dislike using labels like that but since you are changing this code now might be
> a good time to also fix this wrinkle but this is not a deal breaker and I'd be happy to see David's
> opinion.

I also dislike the while and again: label and turning that th do/while
is good as long as it does not obscure the real change. In this case and
given the example above I think it makes sense, the loop body is short
enough and we need to review the whole logic after the structure switch
anyway.
