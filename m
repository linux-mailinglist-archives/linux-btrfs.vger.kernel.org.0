Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A485B3ACD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIIOiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiIIOiV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 10:38:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C90128C3F
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 07:38:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 392DE22B41;
        Fri,  9 Sep 2022 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662734299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7Vl+cNp+6JI7UufFC7f3dvLsdrdeN/PtTdcwM3+/KE=;
        b=GQ141f2P9PkwVos8M819g2cls+yjuvrZ4FZUmvRMFSjGk8O/0WdefSWxtlripTPdp0Cj+0
        qAbP75g/sdUtSdhUVEhmfKTeD8+Fbn2Z6Zx33sNLuXfT6mLrmV81nGaClbqy+CEAGIRK/F
        xHA9MYzUVmk2XLmVDrbIqQL4Fgr1gq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662734299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7Vl+cNp+6JI7UufFC7f3dvLsdrdeN/PtTdcwM3+/KE=;
        b=79zWLl29Kvv7Tfu7MD6mApeX5c8lqgTevzqRXTosM0CB6yLfI79OmyKN5bzTVtf8CXcU2h
        YdqHopE4cyiGkNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E4B313A93;
        Fri,  9 Sep 2022 14:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id amtbBttPG2OPXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 14:38:19 +0000
Date:   Fri, 9 Sep 2022 16:32:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a couple of hangs during unmount caused
 by races
Message-ID: <20220909143254.GZ32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662636489.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662636489.git.fdmanana@suse.com>
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

On Thu, Sep 08, 2022 at 12:31:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Due to some races or bad timmings, we can hang during unmount when trying
> to stop the block group reclaim task or one of the space reclaim tasks.
> The second case if often triggered by generic/562 for a while, but the
> underlying problem has been there for a long time, despite seeming to be
> more frequent recently. More details in the changelogs.
> 
> Filipe Manana (3):
>   btrfs: fix hang during unmount when stopping block group reclaim worker
>   btrfs: fix hang during unmount when stopping a space reclaim worker
>   btrfs: remove useless used space increment during space reservation

Added to for-next, thanks.
