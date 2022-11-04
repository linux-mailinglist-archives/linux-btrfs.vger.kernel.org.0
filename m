Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6FC61A3C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 23:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKDWAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKDWAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 18:00:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0045EF3
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 15:00:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1ABBD2188E;
        Fri,  4 Nov 2022 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667599229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYPvpUi0vOEivUu7hd18P15tjMBadYw6frXcNkIUhLs=;
        b=EhyDMwIandcJ9dLR9KPoY1JWQKL7UD4a4THWMbPDqMzCJyph+PbuOWkZ4hD9ttmzD4BSU0
        QOaGDvqQGAmJtLV7m5E1pzNeB6nyW+JwDJeN7VtMTphhkzKNoGrIAApypd+OKLQmhndeiT
        GNzmlcB3+MNeXpaoy1P0ckbSTuNRz/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667599229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYPvpUi0vOEivUu7hd18P15tjMBadYw6frXcNkIUhLs=;
        b=99+ot9DB5zfh0kCb87ybRMQlFhJfSypJFKw6x620/d5zxO0GKn+5Q5oMdv8SWei9hwjB0D
        44U5UmflRWwpI6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5EE513216;
        Fri,  4 Nov 2022 22:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TdMtN3yLZWMXFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 04 Nov 2022 22:00:28 +0000
Date:   Fri, 4 Nov 2022 23:00:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix improper error handling in btrfs_unlink
Message-ID: <20221104220008.GR5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d1213451ff43c39304d949881a2fa4e8a8b561b3.1667523745.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1213451ff43c39304d949881a2fa4e8a8b561b3.1667523745.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 03, 2022 at 06:02:44PM -0700, Boris Burkov wrote:
> While running fstests, I am periodically seeing the following Oops:
> 
> Fixes: 6a1d44efb9d0 ("btrfs: setup qstr from dentrys using fscrypt helper")

Thanks, folded to that patch.
