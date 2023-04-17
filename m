Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719F6E506E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDQSx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDQSxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 14:53:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301097
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 11:53:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3509A219E3;
        Mon, 17 Apr 2023 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681757633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07+As7JYxVvLIN+hxSB34KTCjuUGA+zOecyUhg7HPNI=;
        b=XhL9Qf4sG63eGKQAjIICNirbjWvFuGL1vi1rskpKxaqzRGn9p6YcT2RpWlCj1WeGAz7Oa5
        UL/NCQOhNcDtNIpLAN8QfMeNADoMPfyVxjunIQeI3Lp8fRngzfNdwNx0QJ3CA/4whQk8tI
        MPXkFmLiFoLmXWXlh/ArsqthnO0yBAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681757633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07+As7JYxVvLIN+hxSB34KTCjuUGA+zOecyUhg7HPNI=;
        b=qzTSKF/p814OUbwbKDrcWOmGnlHV0NbOdPwS/TAGM/A8Mmty4n5D0PUqYEr5+tqSZQFMVo
        BF7n8Xq92RdLAnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E98313319;
        Mon, 17 Apr 2023 18:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +qR1BsGVPWQ5HwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Apr 2023 18:53:53 +0000
Date:   Mon, 17 Apr 2023 20:53:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix for btrfs_prev_leaf() and unexport it
Message-ID: <20230417185344.GM19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681295111.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681295111.git.fdmanana@suse.com>
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

On Wed, Apr 12, 2023 at 11:33:08AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A fix for btrfs_prev_leaf() where due to races with concurrent insertions,
> can return the same key again, and unexport it since it's not used outside
> ctree.c. More details on the individual changelogs.
> 
> Filipe Manana (2):
>   btrfs: fix btrfs_prev_leaf() to not return the same key twice
>   btrfs: unexport btrfs_prev_leaf()

Added to misc-next, thanks.
