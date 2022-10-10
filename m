Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C75FA042
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJJOeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJJOeQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 10:34:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BE5FDE8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 07:34:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CBE0219C7;
        Mon, 10 Oct 2022 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665412453;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p29fq+WAWmJVRcUJjrt+UeYx21wMLEihxAuSG9yARFk=;
        b=nGDVYdrb/2Vjs3nSsdoVIZd+JHY08vMlNKHFLWGggh2f+n/kWIPMvRmYvtXDwrKBmuzNqg
        WHTOv4KLpx5SEuiBJjoazwdM6DXvSZ7vUOQA8DdbcLnQIVq9muKsuurXO6cieezwgqBjNt
        9FmEDfAONy7k9ypQLlRU5VTPpNW8fI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665412453;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p29fq+WAWmJVRcUJjrt+UeYx21wMLEihxAuSG9yARFk=;
        b=P/9mgO/NNESwJ64kgdNzS7XWQW2vMEyKuK+Q1ruwqD34Q0lBZRBsIpYWt9s8OtF43oj4y5
        3cKPb2jqqraj15AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11C6613479;
        Mon, 10 Oct 2022 14:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7epXA2UtRGMkHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Oct 2022 14:34:13 +0000
Date:   Mon, 10 Oct 2022 16:34:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: mkfs: extent-tree-v2 related fixes
Message-ID: <20221010143408.GE13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665143843.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665143843.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 07, 2022 at 08:02:59PM +0800, Qu Wenruo wrote:
> Although recently we still have some uncertainty around the on-disk
> format for extent-tree-v2, related to how to determine the number
> of global roots, most of the on-disk format is fixed.
> 
> And even with the uncertain part involved, mkfs.btrfs should not crash
> for extent-tree-v2 feature (hidden behind the experimental builds).
> 
> There are two bugs involved:
> 
> - A crash caused by incorrectly set chunk_objectid for block group item
>   As extent-tree-v2 feature reuse that member to indicate which extent
>   tree a block group belongs to.
> 
>   But the regular fs uses a fixed 256 for that chunk_objectid, and no
>   extent-tree-v2 btrfs would have that many global roots.
> 
>   This leads to btrfs_extent_root() to return NULL, and cause later
>   segfault.
> 
>   Fix it by properly setting chunk_objectid.
>   This is a regression caused by 1430b41427b5 ("btrfs-progs: separate
>   block group tree from extent tree v2").
> 
> - A stack-over-flow caused by too long feature string
>   With extent-tree-v2 enabled, we have at least 84 bytes long feature
>   string (unified features, including compat_ro features likle fst).
> 
>   This is beyond the hard-coded 64 bytes limit.
> 
>   Fix it by introducing a new macro to indicate a minimal safe buf size,
>   and a sanity check to make sure that macro is really large enough.
> 
> Qu Wenruo (2):
>   btrfs-progs: mkfs: fix a crash when enabling extent-tree-v2
>   btrfs-progs: mkfs: fix a stack over-flow when features string are too
>     long

Added to devel, thanks.
