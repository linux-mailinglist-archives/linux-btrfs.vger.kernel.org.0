Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4879EA6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjIMOF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjIMOF2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 10:05:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D719B1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 07:05:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A1262183F;
        Wed, 13 Sep 2023 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694613922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CoqJmkhPz9vGNNzufyQJ9d/1TzZTXdnGnN9k9iD8BQ=;
        b=Wc1HqC9Sa9MyUVgM6r/xIEphmIydRezmIEOdDYj0kEntgkPkiBGnxalU0HBR0PkOm6ONm8
        Q1jNbiHyr9jrqc78SPZmR2M7qiPpCHQ5kOdJ6bp+/InH6df6ekk/YzEixnGuDUinLrFwy3
        jrKysPM4qsj2e0flI7RtVc5uL+xy99U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694613922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CoqJmkhPz9vGNNzufyQJ9d/1TzZTXdnGnN9k9iD8BQ=;
        b=EWBXwrYAvCUXnFlN+MzAiTxtBOyXuPwYyT+MEsUlarCY4qKOnkV4xO9PXz115OoDD5N1aE
        uJMGYwgUP1LTctAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72BD013582;
        Wed, 13 Sep 2023 14:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Tx08G6LBAWVyWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 14:05:22 +0000
Date:   Wed, 13 Sep 2023 16:05:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless loop from
 btrfs_update_block_group()
Message-ID: <20230913140520.GK20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cc34f95eab414767ea9c95bfbbd1700267ef1dd0.1694604142.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc34f95eab414767ea9c95bfbbd1700267ef1dd0.1694604142.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 13, 2023 at 12:23:18PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When an extent is allocated or freed, we call btrfs_update_block_group()
> to update its block group and space info. An extent always belongs to a
> single block group, it can never span multiple block groups, so the loop
> we have at btrfs_update_block_group() is pointless, as it always has a
> single iteration. The loop was added in the very early days, 2007, when
> the block group code was added in commit 9078a3e1e4e4 ("Btrfs: start of
> block group code"), but even back then it seemed pointless.
> 
> So remove the loop and assert the block group containg the start offset
> of the extent also contains the whole extent.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
