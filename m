Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC875D7DE
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 01:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGUXYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUXYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 19:24:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D31BE4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 16:24:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E82E3218FD;
        Fri, 21 Jul 2023 23:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689981872;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PvX1edvS6cH9/zwsmQIPd0ijr8GUeLi0n7nS+WrHe4I=;
        b=bV7O1eKFykl6vNStHfgmv6FxS2vIJi2Vrv//tm+RqoFYaH1yeEM+vtof3g/Lli446oipwP
        E2CJ9zSXOEaryQs3lmJ4HmAJaBeRlQ6M3aiSX8VHxbvxBYSNM+FH/TD+F1hOy5P4Q+Z2Wf
        oQQlcQksxPBg3PL3Ds+uxNWXAOTlFOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689981872;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PvX1edvS6cH9/zwsmQIPd0ijr8GUeLi0n7nS+WrHe4I=;
        b=AeAfnY89IpZyCrD2fOHSweR4flfvkIV6NP7U8bNiSGYbKkYTxambTrmn4MYZs+5nmZpyaY
        Aiu01t1RTzH1aGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99A7134BA;
        Fri, 21 Jul 2023 23:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Un5yJrATu2QfbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 21 Jul 2023 23:24:32 +0000
Date:   Sat, 22 Jul 2023 01:17:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for missing error reporting when
 attaching to a transaction
Message-ID: <20230721231751.GG20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689932501.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689932501.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 10:49:19AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix missing error checks and returns when attaching to a transaction
> in barrier mode, and waiting for a transaction to commit and finish. These
> can make things like an fsync that fallbacks to a transaction commit to
> report success to user space when a transaction was aborted and the inode
> changes were therefore not persisted. More details on the change logs.
> 
> Filipe Manana (2):
>   btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
>   btrfs: check for commit error at btrfs_attach_transaction_barrier()

Added to misc-next, thanks.
