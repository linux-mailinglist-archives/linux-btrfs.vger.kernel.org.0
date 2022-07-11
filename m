Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22E35708A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiGKRIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGKRIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 13:08:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4263A3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 10:08:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53E6B1FDBA;
        Mon, 11 Jul 2022 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657559318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nDGNsJTWS9OfC0ZCR/PHYlLd/UCJfey+faoRumg1DU=;
        b=ukYuKmSCOFBkWGz/TeQgRxEqkgzjBiiy+cVd4X5YtfbcxIU7GspwIo+9OhsWsNeRuSjBmv
        F+aFkDM7uN5ros61FiTQhNDQxHJHoiOpeinRcNOHBDnYXol4ezkwav4WPZtflwoTGZ6KVt
        Jsa0HeSNsbflCSTBnwrm2qsmfmtYSvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657559318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nDGNsJTWS9OfC0ZCR/PHYlLd/UCJfey+faoRumg1DU=;
        b=gR3zhnLjKOVn1Uj4w8+tvNmmPvDxqIo4fOLxNIIXaVSryKTd6KzzaAGaEsbAW8Nlk7KlyG
        AU5Rnz8We+Q0q+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B22713524;
        Mon, 11 Jul 2022 17:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W3WrCRZZzGK8CgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Jul 2022 17:08:38 +0000
Date:   Mon, 11 Jul 2022 19:03:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: optimize btrfs_ino()
Message-ID: <20220711170349.GA15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1657549024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657549024.git.fdmanana@suse.com>
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

On Mon, Jul 11, 2022 at 03:22:48PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset optimizes btrfs_ino(), an inline function that is
> used pretty much everywhere, to avoid doing less work and be trivial on
> 64 bits systems. Details on the changelogs of the patches.
> 
> Filipe Manana (2):
>   btrfs: set the objectid of the btree inode's location key
>   btrfs: add optimized btrfs_ino() version for 64 bits systems

Great, thanks. The module size on a release build is -7k.
