Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C317B515E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjJBLav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjJBLaF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 07:30:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF482FD
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 04:29:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F45E1F460;
        Mon,  2 Oct 2023 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696246189;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2wZuivO+RgZYKnCXJp51/rcCxLXpBD2OQRJWOvy+zg=;
        b=NxFeNnyH+aakK2atW2ipXTfMeTOu7vk1YQwffa07UBgqDr/d1WOz8S4d9TmXqfaYxv0/ia
        O8zXviHGKgktydm9s4WkBYgHK2cZ6msJm5kYtJeM0FxZQsNEnuwnguSX8UroTjVXnv87rR
        QC1dS7Jj/Z9Lc9FMVeqQfzqLjZZ3HeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696246189;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2wZuivO+RgZYKnCXJp51/rcCxLXpBD2OQRJWOvy+zg=;
        b=f0Yk+FuBxXBPOIQN9wtxUrhd2eH/SoAW6VlheNYmzQ2V1FFMhpNsb8ojBWNlSJu+eJOtpo
        rZUBnIEvoyfACqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6625513456;
        Mon,  2 Oct 2023 11:29:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ffo6GK2pGmUsBgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 11:29:49 +0000
Date:   Mon, 2 Oct 2023 13:23:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: adjust reservation sizes for block group item
 updates/inserts
Message-ID: <20231002112308.GJ13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695895841.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695895841.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 11:12:48AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patches adjust how we calculate the size for block group
> item insertions and updates, so that we stop reserving/accounting
> excessive space for these operations, specially when the free space tree
> is being used (a default nowadays). More details on the changelogs.
> 
> Filipe Manana (2):
>   btrfs: stop reserving excessive space for block group item updates
>   btrfs: stop reserving excessive space for block group item insertions

Added to misc-next, thanks.
