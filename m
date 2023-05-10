Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C76FE2BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjEJQsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEJQs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 12:48:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B2130FE
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 09:48:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20569218EE;
        Wed, 10 May 2023 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683737307;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYh0yNdXLg8nB0mF2HNuTcgLjHCWJg7Si2oPbaSnKzk=;
        b=dJ6tevyVAFY0xoaaSz0NMndQJsXVDpiWYFJgwdLOGTnI8wo8yzAupYd+KDM6i2ZeVd27h2
        ujlElSb0sUxmG6E2Vbzjj7QYmrieW4NYCosBschbDfIWDZAHw11j1F1NK2hlM7AL+AEtxr
        cy9z8i/0+JQp8+l85KHSWpKQeasRWLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683737307;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYh0yNdXLg8nB0mF2HNuTcgLjHCWJg7Si2oPbaSnKzk=;
        b=8hvDj9v3efvB2thPKiAyq8ovr7IdS0TN0F7CyNlw7aXIGt5IZFEiRrW0t/XIUA3jzjuE3H
        /RgcqkqwTFBDj1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 031AC138E5;
        Wed, 10 May 2023 16:48:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LcFeO9rKW2S4egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 16:48:26 +0000
Date:   Wed, 10 May 2023 18:42:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: convert: fix csum generation for
 migrated ranges
Message-ID: <20230510164227.GU32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683592875.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683592875.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 08:43:13AM +0800, Qu Wenruo wrote:
> There is an internal report that btrfs/012 failed on 64K page size
> systems.
> 
> It turns out that with 64K block size for ext4, even an empty ext4 can
> lead to csum errors for the image file.
> 
> The root cause is the bad csum generation, which read incorrect data
> from the disk, and leads to bad csum generated. (while the on-disk data
> is still correct).
> 
> This patchset would fix the bug and add a test case for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: convert: fix bad csum for migrated range.
>   btrfs-progs: tests/convert: add a test case to check the csum for the
>     image file

Added to devel, thanks.
