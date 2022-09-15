Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1E5B9D8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIOOlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiIOOl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:41:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC722EF1A
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:40:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0FAD21A0E;
        Thu, 15 Sep 2022 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663252800;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NF/ojw+sKuJGHuK2iVFnlrUokCoppNyCQW6vVtFVs64=;
        b=rbZt4b0LaUAlEddwKy/a6qwEby/OkRYOUtzUlRHgsnyZ81UCKMLBPxpvjwdydNMcalifN2
        1ILQyy+2NqhAV0+Ll3Nl3rXY2gn0/nsW6O0P47J52c2dpduZfBNHKe21EsumOepOin6OlD
        jPi1mx0YP7TO5UeQrMHSISHuhPkt2YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663252800;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NF/ojw+sKuJGHuK2iVFnlrUokCoppNyCQW6vVtFVs64=;
        b=traFFo3n8i45whZN1h8zh9T/7j3mmn2gzfJvu6FmYwsd9SxDp+eYeWlBgLFFmr0n3f3R0H
        Bz6h/1/wuo7bNJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4376133B6;
        Thu, 15 Sep 2022 14:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F60JJ0A5I2PmfQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 15 Sep 2022 14:40:00 +0000
Date:   Thu, 15 Sep 2022 16:34:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: make corrupt-block metadata geneartion
 corruption work again
Message-ID: <20220915143432.GP32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663053391.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663053391.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 13, 2022 at 03:19:24PM +0800, Qu Wenruo wrote:
> This is preparing for the incoming metadata validation refactor in
> kernel, thus I need a way to corrupt transid reliably with correct
> checksum.
> 
> The first patch is to unexport csum_tree_block() which also has a stale
> definition .
> 
> The second patch is to fix the csum for metadata block with corrupted
> generation.
> 
> Now btrfs-corrupt-block can properly corrupt the generation of a tree
> block.
> 
> (But unfortunately it corrupts all copies, which is still not exactly
> what I need, but is already good enough)
> 
> Qu Wenruo (2):
>   btrfs-progs: unexport csum_tree_block()
>   btrfs-progs: corrupt-block: re-generate the checksum for generation
>     corruption

Added to devel, thanks.
