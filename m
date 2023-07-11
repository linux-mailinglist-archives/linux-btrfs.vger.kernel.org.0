Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E459774F855
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGKTUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGKTUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 15:20:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DF1730
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 12:20:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9BC8E1FED0;
        Tue, 11 Jul 2023 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689103239;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZsKCFDVc9Zrkr5m6xoLdcVMiU7RIPEtc40TpXFLRLM=;
        b=hPk0werY3pT2pF0ORrZMaEgpT+rW7G2TM4L5uLJC2px/RpvkC9RxJefIilFii+ZMsxNMOu
        sL+WpzMArAXFrJXZ79ItHkmWC4bnn2gzNl1+p+zhVeUhnVUCjalrZzzrOv7Rv2DMckBtWj
        TluI1s4/WxKNkOsx3QlwxRYZTQUT4Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689103239;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZsKCFDVc9Zrkr5m6xoLdcVMiU7RIPEtc40TpXFLRLM=;
        b=XBrsWx/Gi2ddN3O15xOI+REIH5jVLWCmvVPYc5bWDex23SODPHku2HS1gBfB1O8eq8QwQi
        S2UY2Z9CxD1ZScAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 824821391C;
        Tue, 11 Jul 2023 19:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MsgEH4errWTkBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Jul 2023 19:20:39 +0000
Date:   Tue, 11 Jul 2023 21:14:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix leak after finding block group with super
 blocks on zoned fs
Message-ID: <20230711191403.GC30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 03, 2023 at 12:03:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At exclude_super_stripes(), if we happen to find a block group that has
> super blocks mapped to it and we are on a zoned filesystem, we error out
> as this is not supposed to happen, indicating either a bug or maybe some
> memory corruption for example. However we are exiting the function without
> freeing the memory allocated for the logical address of the super blocks.
> Fix this by freeing the logical address.
> 
> Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
