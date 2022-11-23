Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D868636959
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 19:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiKWS40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 13:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiKWS4Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 13:56:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D08B106
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 10:56:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 394AF1F8A4;
        Wed, 23 Nov 2022 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669229782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiAHKWTuMqDNumRmhjtEgMhmYJjmNQ1mSlDCoTTpKmE=;
        b=v8gJqWdfw4R+GjFCzruhONrN6HyYt4BRWcj1jq+GU7cAGz8vBX39oSDT4XKCbaR1qqrTGd
        4fFThuNtLZKmkX+TwPGeshZCJShL1NPbJqNr+sNDCv8jlWtHkCaa8DsJEwnULRQoMfm7AF
        2FlkHmqFQb9d74eAHRCB+wl8s37JO7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669229782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiAHKWTuMqDNumRmhjtEgMhmYJjmNQ1mSlDCoTTpKmE=;
        b=IZcXmK4j6rcCD956pi503XIDIW2U9vuVv324AmcxoV3Od8nOxawOBAo1nxjF1s+TwqsqO2
        NQBRzwMrhmcrfkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FAE613AE7;
        Wed, 23 Nov 2022 18:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m4fyBtZsfmMcJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Nov 2022 18:56:22 +0000
Date:   Wed, 23 Nov 2022 19:55:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: receive: fix a silent data loss bug
 with encoded writes
Message-ID: <20221123185551.GN5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668529099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668529099.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 04:25:23PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using a v2 stream, with encoded writes, if the receiver fails to
> perform an encoded write, it fallbacks to decompressing the data and then
> write it using regular buffered IO. However that logic is currenty buggy,
> and it can result in writing less data than expected or no data at all.
> This results in a silent data loss.
> 
> Patch 3/3 fixes that bug and has all the details about how/why it happens,
> while previous patches just added debug messages to the callbacks for
> encoded writes and fallocate, which are currently missing and are very
> useful for debugging.
> 
> Filipe Manana (3):
>   btrfs-progs: receive: add debug messages when processing encoded writes
>   btrfs-progs: receive: add debug messages when processing fallocate
>   btrfs-progs: receive: fix silent data loss after fall back from encoded write

Added to devel, thanks.
