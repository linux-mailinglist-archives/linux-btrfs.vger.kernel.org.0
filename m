Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDA70BE6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjEVMgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEVMgB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:36:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672DE58
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:35:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB46F1FECE;
        Mon, 22 May 2023 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684758566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcsiVuFK/pFfBHfh8vu5OxzAKvN+7TP0Lmf3CnYFu5U=;
        b=dkjMAxj+Y6qVUJKDGLvhjLEVVtvvlDajzu/hdAsLZXEwQsXO+zVhC7pI+KabuqU1Cp8zYY
        0Dc5Szqe7RJVkMROU+fZFB7zAZZ7PR1hxSaRubEgbi+WaTLb/AG6LbHBdnRzrwJFWf+F9Z
        yCkiZkkO5Dq5UKgjI+k4UEiuftpla0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684758566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcsiVuFK/pFfBHfh8vu5OxzAKvN+7TP0Lmf3CnYFu5U=;
        b=GcG9Dc24M684gXSd9t8eRAy9X1wBLAqOU6VCQgYPCFLBCKPLanqqJrIZj/cdNWiwEW1iRK
        TpIPUPJEjlc1k6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9041113776;
        Mon, 22 May 2023 12:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A8csIiZga2Q7WAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 12:29:26 +0000
Date:   Mon, 22 May 2023 14:23:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: dump-tree: skip tree-checker when dumpping
 tree blocks
Message-ID: <20230522122320.GO32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a6b4198481004f1ddcdbac00f8559c787646557e.1684236530.git.wqu@suse.com>
 <4263b93e-8154-b4c2-56a0-095a26653f29@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263b93e-8154-b4c2-56a0-095a26653f29@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 11:58:33AM +0800, Anand Jain wrote:
> On 16/5/23 19:28, Qu Wenruo wrote:
> > Since commit c8593f65cbf3 ("btrfs-progs: sync tree-checker.[ch] from
> > kernel"), btrfs-progs can do the kernel level tree block checks, which
> > is not really sutiable for dump-tree.
> > 
> > Under a lot of cases, we're using dump-tree tool to debug to collect the
> > details from end users.
> > If it's a bitflip causing a rejection, we would be unable to determine
> > the cause.
> > 
> 
>   Yep. Agreed.
> 
> > So this patch would add OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS for dump-tree.
> 
>   By default, it is a good idea to skip the tree checker for the
>   dump-tree. Additionally, we may requires an option to dump the
>   tree with the tree checker. However, I don't see any use case yet.

Yeah we can add an option to "fail on first error" if needed.
