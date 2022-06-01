Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C653A472
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbiFAL4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 07:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiFAL4I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 07:56:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF636D965
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 04:56:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B242D21A9B;
        Wed,  1 Jun 2022 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654084565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCXA/ejYSDygqprNrTfeLiBDdzEHIfQ2tD/DTa7XHlg=;
        b=Ezw84ve9el2gZgZF+DcJbcp0PRCZOOEp1OKkSYkJeCkwkbGU+PGArUcmU1Ei4OTkSB4X8/
        EmirgrFHFgXFpk+uN9giF5ZSC68ImqIcyypToNIAd2HbEwQ96YIG9g+OanWxDC9Ug4UFyk
        pp3GhHUpKf/5j7NUWM4jmDD39ai98P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654084565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCXA/ejYSDygqprNrTfeLiBDdzEHIfQ2tD/DTa7XHlg=;
        b=j0XUOCZylouIwg98m/qcXaL6OoFcxpdUPlb0IjRpjoRtwm+m3ZcJllCO4HNWa0E+vGSeot
        j2Is3oUW7e4nXmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8568213A8F;
        Wed,  1 Jun 2022 11:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5vnBH9VTl2IgQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 11:56:05 +0000
Date:   Wed, 1 Jun 2022 13:51:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/12] btrfs: free the path earlier when creating a new
 inode
Message-ID: <20220601115139.GJ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <b3c7ae5b6d09c442fc7546660dd5535302d11a7e.1654009356.git.fdmanana@suse.com>
 <44eeb8b2-e826-4aa0-56dd-5ec90e157018@oracle.com>
 <20220601093433.GA3279070@falcondesktop>
 <e2548660-462d-1b08-9824-1f7fd4655fde@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2548660-462d-1b08-9824-1f7fd4655fde@oracle.com>
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

On Wed, Jun 01, 2022 at 04:41:02PM +0530, Anand Jain wrote:
> >>> -	btrfs_release_path(path);
> >>> +	/*
> >>> +	 * We don't need the path anymore, plus inheriting properties, adding
> >>> +	 * ACLs, security xattrs, orphan item or adding the link, will result in
> >>> +	 * allocating yet another path. So just free our path.
> >>> +	 */
> >>> +	btrfs_free_path(path);
> >>> +	path = NULL;
> >>>    	if (args->subvol) {
> >>>    		struct inode *parent;
> >>
> >>
> >>
> >>> @@ -6437,8 +6443,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
> >>>    		goto discard;
> >>>    	}
> >>
> >> At discard, we free path again and leads to double free.
> > 
> > No, there's no double free. The path was set to NULL after being freed.
> 
> Got it. There is no double free. Why not make btrfs_free_path() inline 
> so to avoid a function call.

Would that make any difference? Making a function inline makes sense for
code where the function call overhead is measurable, ie. loops or hot
paths, but freeing path is once per function and inlining would increase
the size of code as there's the if check, call to release path and call
to kmem cache free. With about 250 calls to btrfs_free_path that would
not be negligble increase of the module.
