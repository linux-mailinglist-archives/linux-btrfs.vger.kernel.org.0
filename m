Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD056765362
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjG0MQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjG0MQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 08:16:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F152710
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 05:16:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFE291F747;
        Thu, 27 Jul 2023 12:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690460176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgV8NdBow+RR+PeFS8Pp7D7qSqcQxKe+ukHnegpTdIM=;
        b=S/0iSTmYc9ypUQKsUDoHUZejMDcmE3EOO5WXDuBbh/bBkVVg1qWasuxGpi+ZEj6vbW0jcW
        UBBgvpFmv8tFJ5m3hlvOarRMhT08r+uKL9K9j3aiXFcOXDmSJyNO3az8rzIj6IsSvtwGJj
        N4h5+6I53CqoCLR7iCpQinYR4KF4Ss4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690460176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgV8NdBow+RR+PeFS8Pp7D7qSqcQxKe+ukHnegpTdIM=;
        b=cjUQ+6dg9WXzM52Nhi/a6jZ3XOqBw9nEBWDZTMdn7+QfFjDgo9jPkPTcBxO1/yCgD5GJBH
        VjCDgbui5DaiCiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D888F138E5;
        Thu, 27 Jul 2023 12:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fPHPMxBgwmQ1RgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 12:16:16 +0000
Date:   Thu, 27 Jul 2023 14:09:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: do not commit transaction canceling a
 suspended replace
Message-ID: <20230727120955.GB17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690437675.git.wqu@suse.com>
 <18f1e6d4afa0db4aad56569bbab15b220f03236f.1690437675.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f1e6d4afa0db4aad56569bbab15b220f03236f.1690437675.git.wqu@suse.com>
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

On Thu, Jul 27, 2023 at 02:07:54PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a very rare corner case that, if the filesystem falls into a
> deadly ENOSPC trap (metadata is so full that committing a transaction
> would trigger transaction abort and falls RO), and the user needs to
> cancel a suspended dev-replace, it would fail.
> 
> This is because the dev-replace canceling itself would commit the
> current transaction, and falls RO first.
> 
> [CAUSE]
> There are two involved situations:
> 
> - Cancel a running dev-replace
>   We just call btrfs_scrub_cancel(), it doesn't commit transaction
>   anyway.
> 
> - Cancel a suspended dev-replace
>   We only need to cleanup the various in-memory replace structure, which
>   is no difference than the previous situation.

There's dev_replace->item_needs_writeback = 1, and somewhere in
transaction commit it's synced to disk.

btrfs_commit_transaction
  commit_cowonly_roots
    btrfs_run_dev_replace
      item_needs_writeback is checked

so it's not just cleaning the memory structures, it also stores the
state on disk. A delayed commit will have to write it again, which means
that the problem is only postponed.
