Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBD79271B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjIEQCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354387AbjIELNM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 07:13:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8941AB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 04:13:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D8551F88C;
        Tue,  5 Sep 2023 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693912387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JK0VBnIRAw2FqEv/6GpXmhN2mbtfxg+B1sTGek05x2c=;
        b=MzhQIgJBShHuS0LKLGBfFPpAGiifk5xiEwLACIPnDZe9j1CUKhkHaNZYh/edf6ODtaOymn
        1uNgVDpDR7a2N2x1/53DnASolKDmYPSuEesYNd7M2oZa5a8VQsAgoOYkYp9pARG1R2BUOQ
        mn+WcWKdFmM4/pE9LAvpucObXU6wjyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693912387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JK0VBnIRAw2FqEv/6GpXmhN2mbtfxg+B1sTGek05x2c=;
        b=tAQDRdtd/apVVSjSMLVQTP320uA7jJ6RtceYigp726/7Dc0RnvJ2mQCjqi5smgeAbTaLNK
        yUs7YklvR+1GNoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B1CB13499;
        Tue,  5 Sep 2023 11:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wLOaGEMN92R1aQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 11:13:07 +0000
Date:   Tue, 5 Sep 2023 13:06:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update comment for reservation of metadata space
 for delayed items
Message-ID: <20230905110627.GR14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <283a7c5087a950342a862fba42922fad4fc71365.1693208275.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283a7c5087a950342a862fba42922fad4fc71365.1693208275.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 28, 2023 at 08:38:36AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The second comment at btrfs_delayed_item_reserve_metadata() refers to a
> field named "index_items_size" of a delayed inode, however that field
> does not exists - it existed in a previous patch version, but then it
> split into the fields "curr_index_batch_size" and "index_item_leaves"
> in the final patch version that was picked. So update the comment.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
