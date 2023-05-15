Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE0702B46
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbjEOLTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbjEOLTD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 07:19:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3F114
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 04:18:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE2EF1FD88;
        Mon, 15 May 2023 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684149516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEUnfBTU2Zqkrt1AoBmpzjEKULEC+914WIbNx60za1g=;
        b=1suPjdxtUKy5t5KZrJxLcC5V3SAMSukAGc96YjD5OmbXLZbZAroDqR/h/oU+43rDEp4pvp
        mtlCFXCHNK5qbpolNbpxyftOy6rKNNXkbaNYSx70T0EStlWgpZVtLmniSmwIYxDdiNVmiC
        GvJTZybM6YlAFMs0K6w01s/vzREARCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684149516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEUnfBTU2Zqkrt1AoBmpzjEKULEC+914WIbNx60za1g=;
        b=xT5PPK/7ROuk1zRuniFkfiaafjrlKdXJ6SO6WtDHCMtMOR6QtzpdBKY7J0Z3Q+B9i9eM2Y
        8IuO/CMqWyQNu0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B303913466;
        Mon, 15 May 2023 11:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sRfsKgwVYmR+BAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 15 May 2023 11:18:36 +0000
Date:   Mon, 15 May 2023 13:12:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: add an ordered_extent pointer to struct btrfs_bio
Message-ID: <20230515111234.GG32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508160843.133013-1-hch@lst.de>
 <20230515064048.GA10647@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515064048.GA10647@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 15, 2023 at 08:40:48AM +0200, Christoph Hellwig wrote:
> It turns out this broke the zoned case that's splitting the bio.
> I didn't notice as my zoned tests where with a follow on page
> series fixing this again.
> 
> Dave, sorry for the mess, but can you drop this?  I'll try to
> rebase it on the other ordered_extent changes and will resubmit
> them.  It might end up needing a prep series before this one.

No big deal yet, I've moved the patchset to a branch and deleted it from
misc-next, for-next has been also refreshed.
