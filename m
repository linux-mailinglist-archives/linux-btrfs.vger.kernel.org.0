Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5900D4DB63E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiCPQey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiCPQew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 12:34:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF215A0F
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 09:33:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3DE0E210F3;
        Wed, 16 Mar 2022 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647448416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6aKKqw/m1exPChVKspy1V6/l9rna0csQi0zxfffu8E=;
        b=SZYGirIC1/vFuEzscSXl6N0LtcXxQeeEwIdsrlAkPSiGQYg3jvZ/0UP/jLYBz4hWCAU5Q4
        qDI+NlAgLqmWZFqMxGmJlLpbhFi0MreVPUKRES34RxRj5rmjhw1dFa2g7B0w/oF1nZbB8A
        ncq8wPtJn0SLOpoNKC5oYkxRZLqBksw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647448416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6aKKqw/m1exPChVKspy1V6/l9rna0csQi0zxfffu8E=;
        b=zeDgHojv8EcjQ2438BNN66JqqyK2/l7opkteooFuo177Mn46FqHcpu5DrQjtOjobjzdN7+
        bk6wq4aq7pxDooDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 34476A3B81;
        Wed, 16 Mar 2022 16:33:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6F34DA7E1; Wed, 16 Mar 2022 17:29:36 +0100 (CET)
Date:   Wed, 16 Mar 2022 17:29:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/7] btrfs: one fallocate fix and removing outdated
 code for fallocate and reflinks
Message-ID: <20220316162936.GA12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1647340917.git.fdmanana@suse.com>
 <cover.1647357395.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647357395.git.fdmanana@suse.com>
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

On Tue, Mar 15, 2022 at 03:22:34PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch fixes a bug in fallocate (more details on its changelog),
> while the remaining just remove some code and logic that is no longer
> needed. The removals/clean ups are independent of the bug fix.
> 
> V3: Added missing inode unlock in error path (patch 5/7).
> V2: Added one extra patch, 5/7, which was missing in v1. Fixed a typo
>     in the changelog of the first patch as well.
> 
> Filipe Manana (7):
>   btrfs: only reserve the needed data space amount during fallocate
>   btrfs: remove useless dio wait call when doing fallocate zero range
>   btrfs: remove inode_dio_wait() calls when starting reflink operations
>   btrfs: remove ordered extent check and wait during fallocate
>   btrfs: lock the inode first before flushing range when punching hole
>   btrfs: remove ordered extent check and wait during hole punching and
>     zero range
>   btrfs: add and use helper to assert an inode range is clean

Added to misc-next, thanks.
