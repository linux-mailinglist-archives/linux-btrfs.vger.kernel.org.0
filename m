Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AA70CDAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 00:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjEVWSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 18:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEVWSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 18:18:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695329E
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 15:18:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29994221EE;
        Mon, 22 May 2023 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684793890;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DnrQB4RyuuKz47WhttGAZN1AYtOk/ShYNFD0KlrCD4=;
        b=tK2KTBJe8M88LRf02wZKWr42qO1tFxklCPuxR/0u3RkJ5SAH3kYiLpz40I7S+IXwdiW8JB
        YTy6lK00rFubEGGVOMDdaZeFr3id6tAb+Fb/OcVNPXDHhniAc/DTcqO9qWP3+yRFGhDLa9
        G7OyAmuD/OiBe8/aBa+QX+iaY66tYJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684793890;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DnrQB4RyuuKz47WhttGAZN1AYtOk/ShYNFD0KlrCD4=;
        b=xWbyZn12+xDfyRZNL6pP1SK07easzDFw5dzX3nLJpxXO760vwqDO7QeKR+YgGffxKWc9PZ
        j5T98LufpIujIABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01CBD13776;
        Mon, 22 May 2023 22:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bcUpOyHqa2TNeQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 22:18:09 +0000
Date:   Tue, 23 May 2023 00:12:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: call btrfs_orig_bbio_end_io when
 btrfs_end_bio_work
Message-ID: <20230522221203.GU32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230515091821.304310-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515091821.304310-1-hch@lst.de>
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

On Mon, May 15, 2023 at 11:18:21AM +0200, Christoph Hellwig wrote:
> When I implemented the storage layer bio splitting, I was under the
> assumption that we'll never split metadata bios.  But Qu reminded me that
> this can actually happen with very old file systems with unaligned
> metadata chunks and RAID0.  I still haven't seen such a case in practice,
> but we better handled this case, especially as it is fairly easily
> to do not calling the ->end_іo method directly in btrfs_end_io_work,
> and using the proper btrfs_orig_bbio_end_io helper instead.
> 
> Fixes: 103c19723c80 ("btrfs: split the bio submission path into a separate file")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, with an update to changelog with your additional
explanation.

Commit 103c19723c80 is 6.2 but there are some intermediate changes so
the backport won't be straightforward, for 6.3 it seems doable.
