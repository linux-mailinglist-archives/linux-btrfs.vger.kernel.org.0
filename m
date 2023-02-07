Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB068DD41
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 16:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjBGPqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 10:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjBGPqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 10:46:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AE3B0DE
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 07:46:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9794205B2;
        Tue,  7 Feb 2023 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675784770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i15K2ntXyPku3uvV733695aECnHrQ77jM5d8d8V0Xek=;
        b=3F40agcgDq3xkFkE44dQJPOz/til4EGpB60I4OK1+DwTIkh8QLG1ffi/pJgEHLSP2cEsam
        opNOATJ3bQkkuv1kpbdmojmtL/LLdAkiAERx+pNBfWyd6epPruQW0gwpR1FTFHEoBSh8D+
        rQNEHzPwTTZOZZhVugylnF65mssBuis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675784770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i15K2ntXyPku3uvV733695aECnHrQ77jM5d8d8V0Xek=;
        b=96+d7x1ZEXvWFD+Y9N6ynPRPQlS0BJnqPHPS2M2F5TJKMduM5tm6kuxa/kGRatTU91kTS1
        8Km09jWbG0h1NIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88DF813467;
        Tue,  7 Feb 2023 15:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dwAsIEJy4mP+MQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Feb 2023 15:46:10 +0000
Date:   Tue, 7 Feb 2023 16:40:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: lock the inode in shared mode before starting
 fiemap
Message-ID: <20230207154021.GG28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5c6c1cefa7df5fbe9c4dc2fe517f521760a2f4be.1674492773.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6c1cefa7df5fbe9c4dc2fe517f521760a2f4be.1674492773.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 23, 2023 at 04:54:46PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>

> Fix this by taking the inode's lock (VFS lock) in shared mode when
> entering fiemap. This effectively serializes fiemap with fsync (except the
> most expensive part of fsync, the log sync), preventing this deadlock.

Could this be a problem, when a continuous fiemap would block fsync on a
file? Fsync is more important and I'd give it priority when the inode
lock is contended, fiemap is only informative and best effort. The
deadlock needs to be fixed of course but some mechanism should be in
place to favor other lock holders than fiemap. Quick idea is to relock
after each say 100 extents.
