Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3461C7B35E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjI2OkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjI2OkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 10:40:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991D1A8
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 07:40:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3525621872;
        Fri, 29 Sep 2023 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695998408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRZNEIgpCwfHPlOqnPAjjsSYZgbowKMNAwdXIpuamQQ=;
        b=e5HL/yqdT6bNJUBIsJmdZlZ4DNBCNUoiBxwO5Xa7XERUMXuJlmBTqe4CVZ1QMelA7F97ve
        AlKQGOFa6ORVDMfV0ORGShSUqoEHSKlAEnuluPSTx9QGidVCqkLbOA/pHjSw4RQZxJC8dX
        wWR6MJhxjCCAXFKbXniTm552corvKsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695998408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRZNEIgpCwfHPlOqnPAjjsSYZgbowKMNAwdXIpuamQQ=;
        b=kDECYwAnXOYAtLcWC32TE+6HB3KuF8xwg2Nf136gtd11sYdnEGa6W9caoBiVyAQDHJwwgR
        i0pjqIHSj5ZskGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D17B1390A;
        Fri, 29 Sep 2023 14:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l71sBsjhFmVTIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Sep 2023 14:40:08 +0000
Date:   Fri, 29 Sep 2023 16:33:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] btrfs: some fixes and cleanups around
 btrfs_cow_block()
Message-ID: <20230929143328.GE13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695812791.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695812791.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 12:09:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This adds some missing error handling for highly unexpected but critical
> conditions when COWing a tree block, some cleanups and moving some defrag
> specific code out of ctree.c into defrag.c. More details on the changelogs.
> 
> V2: Fix compilation error on big endian systems (patch 7/8).
>     Use transaction abort in patches 1/8 and 3/8.
> 
> Filipe Manana (8):
>   btrfs: error out when COWing block using a stale transaction
>   btrfs: error when COWing block from a root that is being deleted
>   btrfs: error out when reallocating block for defrag using a stale transaction
>   btrfs: remove noinline attribute from btrfs_cow_block()
>   btrfs: use round_down() to align block offset at btrfs_cow_block()
>   btrfs: rename and export __btrfs_cow_block()
>   btrfs: export comp_keys() from ctree.c as btrfs_comp_keys()
>   btrfs: move btrfs_realloc_node() from ctree.c into defrag.c

Added to misc-next, thanks.
