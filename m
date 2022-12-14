Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0537964CDDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiLNQUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 11:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbiLNQUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 11:20:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929C275C7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 08:20:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C16821FF1;
        Wed, 14 Dec 2022 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671034813;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZnRKOvrM6CgvvIj6OXQ+8B06WK+RLnWme/iVKYYd3k=;
        b=sDlaSmIk7oe0rAGLQsVLmFvNKgf1t5k0R/qACl+dJ+vgu/G2Kmpsjxj2F5nPClfrDyftVU
        GhsIHXKDnZSjRWWUiNQnZt9e6eqnYc7Wc9tlBP0OIVDRq9G30PyncoNR9kllkYdwdlZuN0
        qUb7q67Y71/AqQ2b1mMv11SBAUZ6URM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671034813;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZnRKOvrM6CgvvIj6OXQ+8B06WK+RLnWme/iVKYYd3k=;
        b=Uw8F8jYFX9TxtGSKYeeE5Sf57rvjnH3eS7PQiCp5mHUypvxRBpkDHitkq7GoN6DlFRE9aA
        4rcAQbQN+zyHMeAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B3F2138F6;
        Wed, 14 Dec 2022 16:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jO1NEb33mWM3ZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 16:20:13 +0000
Date:   Wed, 14 Dec 2022 17:19:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use BTRFS_SEQ_LAST for qgroups backref lookup
Message-ID: <20221214161930.GC10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d456fe2306107280d66ceaceb8612e85f2a9428a.1670968657.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d456fe2306107280d66ceaceb8612e85f2a9428a.1670968657.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 04:57:44PM -0500, Josef Bacik wrote:
> In the patch 5850e883cf23 ("btrfs: use a structure to pass arguments to
> backref walking functions") Filipe converted everybody to using a new
> context struct to use for backref lookups, but accidentally dropped the
> BTRFS_SEQ_LAST usage that exists for qgroups.  Add this back so we have
> the previous behavior.
> 
> Fixes: 5850e883cf23 ("btrfs: use a structure to pass arguments to backref walking functions")

This commit id is from some old branch, by the subject I found the
commit as a2c8d27e5ee810b7149b42b88ddf7298e5b8dfe0

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
