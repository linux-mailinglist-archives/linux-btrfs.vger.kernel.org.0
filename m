Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238B76366D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 18:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiKWRSW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 12:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiKWRSI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 12:18:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72B209A4
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 09:18:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C77181F890;
        Wed, 23 Nov 2022 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669223884;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6i8ZX2Je5+uuPZ2Vaq/oDui76ls6sqf3tP2kvi+USwk=;
        b=D1sWZ2ky1nT+u6uGXA0YyvtdMmvjQk0FAQPiz3+X6z/+lkYVmSge40K6IxZNE5VugWfruF
        qK13MUnBIZr0ZFmKx8VUyxRiLfaLKuuXfgkn3wjHWsWGLjr4ZyVDAm8nyAcluhTnvA/5iI
        q1OnQQGnSWbW2aNXxenTt+eacEBRvCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669223884;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6i8ZX2Je5+uuPZ2Vaq/oDui76ls6sqf3tP2kvi+USwk=;
        b=leBoU+O1E9dli2kLjT2AoQVnDyjKGeid6DDaXawYlICcoU465vkvs1pM/DdqiJUUk57+E7
        MYbwa7gSYG1SLxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E3AC13AE7;
        Wed, 23 Nov 2022 17:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZMN3IcxVfmOTdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Nov 2022 17:18:04 +0000
Date:   Wed, 23 Nov 2022 18:17:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
Message-ID: <20221123171733.GM5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221115094407.1626250-1-hch@lst.de>
 <20221115094407.1626250-2-hch@lst.de>
 <20221118140722.GO5824@twin.jikos.cz>
 <20221120124114.GA7245@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120124114.GA7245@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 20, 2022 at 01:41:14PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 18, 2022 at 03:07:23PM +0100, David Sterba wrote:
> > On Tue, Nov 15, 2022 at 10:44:04AM +0100, Christoph Hellwig wrote:
> > > Move struct btrfs_tree_parent_check out of disk-io.h so that volumes.h
> > > an various .c files don't have to include disk-io.h just for it.
> > 
> > Splitting that from disk-io.h makes sense but why creating a new file
> > that has just the one structure?
> 
> Because there is no other header where it obviously fits.
> 
> > We have the tree-checker.h that seems
> > like a place for various checks so I'll move it there.
> 
> Despite the similar naming there's actually no overlap between the
> functionality offered in tree-checker.h and these uses of
> struct btrfs_tree_parent_check at all.

That's not true, the overlap is quite clear. Tree checker verifies
metadata blocks at read time from the available items in the leaves and
links between the parent/child nodes is another extension of that.
Functions like validate_extent_buffer are in disk-io.c but they are the
to tree checker functionality.
