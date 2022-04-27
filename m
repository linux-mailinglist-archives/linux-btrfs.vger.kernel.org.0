Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EDB5122AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiD0TaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiD0T3N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 15:29:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CF15A19
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 12:25:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E3F8210E6;
        Wed, 27 Apr 2022 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651087520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yO6Hi1rD4PhlRaq8Jzq1JnBm7uWWrrd4PnDu5Ygl8PI=;
        b=wAKCDSLByN8xWE3djOjA8VLtmn6V+w3aErni0n7T3x3jlsKJPwMzvy73q3SVoq8vHUpoiJ
        ODd6bdeUsmWJkkuwOijzLS69cRppNf/YwHLM7j2hSBJUt/nRKOh5H/A1nM0hYsDF8yDhTg
        gMDPRwDf1DD9+QBKgsgQRj/lac9BLgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651087520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yO6Hi1rD4PhlRaq8Jzq1JnBm7uWWrrd4PnDu5Ygl8PI=;
        b=sBsmEr7Va2RRLujqwe7gBwoBUOn5qL63Qm/+kVDpxS4p8HVAhXwdMMuwNDTYIJa4nnBI5l
        VlDpdOCVGuUdR1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 149AE13A39;
        Wed, 27 Apr 2022 19:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pMgSBKCYaWKhbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Apr 2022 19:25:20 +0000
Date:   Wed, 27 Apr 2022 21:21:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220427192111.GZ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220426214525.14192-1-gniebler@suse.com>
 <b110e69e-d371-a29e-fd89-f810a4391e7b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b110e69e-d371-a29e-fd89-f810a4391e7b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 04:51:07PM +0200, Gabriel Niebler wrote:
> >   	while (!list_empty(&fs_info->dead_roots)) {
> > [...]   
> > -		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
> > -			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
> > -		btrfs_put_root(gang[0]);
> > +		if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state))
> > +			btrfs_drop_and_free_fs_root(fs_info, root);
> > +		btrfs_put_root(root);
> 
> It occurs to me that BTRFS_ROOT_IN_RADIX should probably be renamed to 
> something else within or following this patch...
> 
> ... but what to rename it /to/?

Good point about the naming but I don't have a concrete idea. The naming
could reflect the status of the entry rather than where is it tracked.

> Naming things is hard. Here are some ideas I've had:
> 
> BTRFS_ROOT_IN_XARRAY is obvious, but it also includes kind of a needless 
> implementation detail.

This could be a fallback that at least follows the same pattern but yeah
it's not the best one.
