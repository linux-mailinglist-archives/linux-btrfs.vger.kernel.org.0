Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324A69D4F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 21:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjBTUYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 15:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjBTUYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 15:24:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307C21CAD0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 12:24:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EAEF2339C7;
        Mon, 20 Feb 2023 20:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676924590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qjn9615gwzme9J4VShC6Ke4B0AZDaBpuPVB5mDyAdkI=;
        b=O9aanbaL5d79KQKfvwM1AtAiOibligYQvdpqvO9mvP9iiInPDJm4UWl7XOTqvpj9ouuCDG
        NDJx5P4X9v5fM6Ha0V5gRMYQKnrZ4huq/GjZOB4vw+e1m8k5IjtmWgrl/h/kQe7HqIakTu
        U4KPfAxLvtxlDpj30RH4FRy225nZNYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676924590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qjn9615gwzme9J4VShC6Ke4B0AZDaBpuPVB5mDyAdkI=;
        b=gm/34kM1H1jmvybORSxnn8kP/DggLoXf487fUqCPrin/MOyHBgetWByHv2fZB7Z8lI1A81
        vqOTSBB0NrQJ68Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A79139DB;
        Mon, 20 Feb 2023 20:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MoQXMq7W82MPXAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 20:23:10 +0000
Date:   Mon, 20 Feb 2023 21:17:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fix and optimize btrfs_lookup_bio_sums()
Message-ID: <20230220201715.GI10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676041962.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676041962.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 11, 2023 at 12:15:53AM +0800, Anand Jain wrote:
> The function btrfs_lookup_bio_sums() has %ret declaration two times
>  blk_status_t ret = BLK_STS_OK;
> and also in an if statement block.
>  int ret;
> 
> Patch 1/2 addresses this issue, while patch 2/2 optimizes the return
> value of search_file_offset_in_bio().
> 
> Anand Jain (2):
>   btrfs: avoid reusing variable names in nested blocks
>   btrfs: optimize search_file_offset_in_bio return value to bool

Added to misc-next with some fixups, thanks.
