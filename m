Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0470FF9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 23:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjEXVDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEXVDs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 17:03:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DEE6
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 14:03:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A71721D44;
        Wed, 24 May 2023 21:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684962226;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jj8JPs8DR6b6RlhBtbmPrMbXa5x938hSu/2PGJG/Rmk=;
        b=FYfSg4/YJBA0PXqLp7qxNfDIpJdWwfkSRa7bS88jIFi+sjPA3aCh/VKkDxxcF4/7HV7iM4
        OQu4nRmqhs8I6O1kvNRnhhiu/A2WLXuTld7QDbxUpetMBkGRfPxelF2J+j8bL3gP0FNKBg
        feebqgohH6f6IwudrebJJYdeh4SXZ3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684962226;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jj8JPs8DR6b6RlhBtbmPrMbXa5x938hSu/2PGJG/Rmk=;
        b=g7ElDeq+Fz6ZVEZiuKk9EFBRRtq1r+qeOzizlnGOaBswrJFX89uDy7oEKgrL97NzQmvwHe
        QwrsW+hLQgKN8lCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 118EE13425;
        Wed, 24 May 2023 21:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N8B6A7J7bmSlRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 21:03:46 +0000
Date:   Wed, 24 May 2023 22:57:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] btrfs: metadata_uuid refactors part1
Message-ID: <20230524205738.GF30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684928629.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
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

On Wed, May 24, 2023 at 08:02:34PM +0800, Anand Jain wrote:
> v2: Addressed the review comments received on some patches. Please refer
>     to the individual patches for more details.
> 
> The metadata_uuid feature added later has significantly impacted code
> readability due to the numerous conditions that need to be checked.
> 
> This patch set aims to improve code organization and prepares for
> streamlining of the metadata_uuid checks and some simple fixes.
> 
> Anand Jain (9):
>   btrfs: reduce struct btrfs_fs_devices size relocate fsid_change
>   btrfs: streamline fsid checks in alloc_fs_devices
>   btrfs: localise has_metadata_uuid check in alloc_fs_devices args
>   btrfs: add comment about metadata_uuid in btrfs_fs_devices
>   btrfs: simplify check_tree_block_fsid return arg to bool
>   btrfs: refactor with match_fsid_fs_devices helper
>   btrfs: refactor with match_fsid_changed helper
>   btrfs: consolidate uuid memcmp in btrfs_validate_super
>   btrfs: add and fix comments in btrfs_fs_devices

Added to misc-next with some minor adjustments, thanks.
