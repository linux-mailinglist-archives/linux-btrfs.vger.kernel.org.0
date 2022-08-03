Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1AE5892FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiHCUKL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiHCUKK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 16:10:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD053D25
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 13:10:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 606B520450;
        Wed,  3 Aug 2022 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659557407;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPZMuBr+fQu8b/IKqox52avV7mwlqtr0GfeS5XUsE8Q=;
        b=WypDdmdakcg6EiuOby+sU5z1lsf6F4mGK8RaFAeYxfPYFir8PYhzQGitGXLtSCuXboYO8R
        +vCdWAJ/ApRTX8IoG4uJtglQ3cgv94h2t2lguoFsMSRnyNFwqTmJU0L4I/ZY9vWzeF0iNC
        sNUJT4FQfZt0NT1JNxIdYfdN8MbxggI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659557407;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPZMuBr+fQu8b/IKqox52avV7mwlqtr0GfeS5XUsE8Q=;
        b=qJGPde/hcoUa4PCPYAVl+NWeN9d2Ok2KfiIyaBKd8WyN+AmtPeKEWRjOGNrkweAfOq0tWl
        mluMWIM10MNN32CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 417A013A94;
        Wed,  3 Aug 2022 20:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5urDDh/W6mKEJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 20:10:07 +0000
Date:   Wed, 3 Aug 2022 22:05:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: a couple fixes for log replay and a
 refactoring
Message-ID: <20220803200504.GL13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1659361747.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659361747.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 01, 2022 at 02:57:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix two minor issues during log replay, when processing inode references,
> and rework a bit the processing of new inode references to remove some
> special code for special cases.
> 
> Filipe Manana (3):
>   btrfs: fix lost error handling when looking up extended ref on log
>     replay
>   btrfs: fix warning during log replay when bumping inode link count
>   btrfs: simplify adding and replacing references during log replay

Added to misc-next, thanks.
