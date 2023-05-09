Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701E46FD087
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjEIVHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 17:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEIVHc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 17:07:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00312726
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 14:07:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 986401F38C;
        Tue,  9 May 2023 21:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683666448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ic0GHYofbuf0S5yRjCLZ6Qc5kCaCfFOWT7o9vWiX6M=;
        b=bdqb81r6fDDVutI/rH+gK1CzTbsix3k8E72IXL4PC5UxcqG1nzWMGfCSsNytlVBzT7PDBd
        D9DEzv6frfZD8k2R+oOTfs8t6RBC6aGkIbH+sY2nVBG0kre4DlJo2NBNEfQ8bvJhzpCRJl
        e4pUZuvM+oL28Y1pSSK9jXBWrSP0DKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683666448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ic0GHYofbuf0S5yRjCLZ6Qc5kCaCfFOWT7o9vWiX6M=;
        b=drXbyI+7dP8jA9ZUHC8VI9s0ffVbZIqkT9O41tqCadBx2DykLruo71qov8WUdh+d4Ijsrd
        oQM14D8Whqjk00BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65581139B3;
        Tue,  9 May 2023 21:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9efeFxC2WmRzVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 21:07:28 +0000
Date:   Tue, 9 May 2023 23:01:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 06/12] btrfs: extend btrfs_leaf_check to return
 btrfs_tree_block_status
Message-ID: <20230509210129.GC32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682798736.git.josef@toxicpanda.com>
 <a528c8c37d20b53a0608185ecb83f870026a9917.1682798736.git.josef@toxicpanda.com>
 <96e9bc20-c2b5-9f7c-a91c-70458fa45e08@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e9bc20-c2b5-9f7c-a91c-70458fa45e08@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 12:03:54PM +0000, Johannes Thumshirn wrote:
> On 29.04.23 22:08, Josef Bacik wrote:
> > diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
> > index 5e06d9ad2862..3b8de6d36141 100644
> > --- a/fs/btrfs/tree-checker.h
> > +++ b/fs/btrfs/tree-checker.h
> > @@ -50,8 +50,15 @@ enum btrfs_tree_block_status {
> >  	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
> >  	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
> >  	BTRFS_TREE_BLOCK_INVALID_ITEM,
> > +	BTRFS_TREE_BLOCK_INVALID_OWNER,
> >  };
> 
> Why didn't you add 'BTRFS_TREE_BLOCK_INVALID_OWNER' in patch 4?

Moved to the patch adding all the other enums.
