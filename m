Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29B25A8079
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiHaOnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHaOms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 10:42:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C69C7B97
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 07:42:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0ABF220D0;
        Wed, 31 Aug 2022 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661956961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLVSH1ZA49jj5MSp9mxV7Yc2p9ha5N6BOQadDAlVF74=;
        b=eUX+qr48qoveFA5aNLBZpcKxQ+opF75aepF5g30L+xN7QldHfCZmDk5Zs+pX5rcfCYtuCw
        WZP9YFiga3NHHPxVc0ndjn5jtobehpRP6pN/Zi0LMzEMEgFlfub0gwrZTMGKj1BEdf8mCI
        YqZFkgNp0Lz2ZvEYb4LlFggM5r8LrFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661956961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLVSH1ZA49jj5MSp9mxV7Yc2p9ha5N6BOQadDAlVF74=;
        b=sybrINhxMU3RWqsmuPeWT6cncKpLEpQHL1DAh7I9n1c+SwP4Zukuxxx7RDV/tdlxeLAVKF
        peLoeTYZ8YYUsXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42A071332D;
        Wed, 31 Aug 2022 14:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m8JED2FzD2OdWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 14:42:41 +0000
Date:   Wed, 31 Aug 2022 16:37:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <glass@fydeos.io>
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su
Subject: Re: [PATCH] btrfs-progs: free extent buffer after repairing wrong
 transid eb
Message-ID: <20220831143721.GG13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <glass@fydeos.io>,
        linux-btrfs@vger.kernel.org, l@damenly.su
References: <20220830124752.45550-1-glass@fydeos.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830124752.45550-1-glass@fydeos.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 30, 2022 at 08:47:52PM +0800, Su Yue wrote:
> In read_tree_block, extent buffer EXTENT_BAD_TRANSID flagged will
> be added into fs_info->recow_ebs with an increment of its refs.
> 
> The corresponding free_extent_buffer should be called after we
> fix transid error by cowing extent buffer then remove them from
> fs_info->recow_ebs.
> 
> Otherwise, extent buffers will be leaked as fsck-tests/002 reports:
> ===================================================================
> ====== RUN CHECK /root/btrfs-progs/btrfs check --repair --force ./default_case.img.restored
> parent transid verify failed on 29360128 wanted 9 found 755944791
> parent transid verify failed on 29360128 wanted 9 found 755944791
> parent transid verify failed on 29360128 wanted 9 found 755944791
> Ignoring transid failure
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> extent buffer leak: start 29360128 len 4096
> enabling repair mode
> ===================================================================
> 
> Fixes: c64485544baa ("Btrfs-progs: keep track of transid failures and fix them if possible")
> Signed-off-by: Su Yue <glass@fydeos.io>

Added to devel, thanks.
