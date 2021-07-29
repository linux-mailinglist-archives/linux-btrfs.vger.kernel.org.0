Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BB33DAA32
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhG2Rae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 13:30:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45656 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhG2Rad (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 13:30:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC11F1FD6C;
        Thu, 29 Jul 2021 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627579829;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0p8dQsEovul3WXjUaa00gLQxOCKve3opbyrXhXTobPA=;
        b=bHhvijzYVaWotbxgFnmcWrMFm1oVNZsy14jd5QW0iSsQ07ZOvXxjFl9yVGJn3fO5tf4oTW
        NgQsoSEWbzUxGHz2xuNIvklgNw5IQ5GeiE08ePrBtnFUIWJ7+HeCvgIHCCCul4gSPHqfpz
        Hk+m0soQR1ntVTWkLk8yzrNGNn+jgaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627579829;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0p8dQsEovul3WXjUaa00gLQxOCKve3opbyrXhXTobPA=;
        b=oL9G+Fx6n+/4T+oCC1pG2iCLdANCdLcxHhTYF3VNkgIcxMXRErA+sgwM+egcSSr1iuzlKt
        0M0/7tXayU0g1rDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C9F31A3B83;
        Thu, 29 Jul 2021 17:30:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C003DA882; Thu, 29 Jul 2021 19:27:44 +0200 (CEST)
Date:   Thu, 29 Jul 2021 19:27:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary NULL check for the new inode
 during rename exchange
Message-ID: <20210729172743.GA5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <8dd8e8f3020a5bd13ae22a1f21b8328adc1f4636.1627568438.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd8e8f3020a5bd13ae22a1f21b8328adc1f4636.1627568438.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 03:28:34PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At the very end of btrfs_rename_exchange(), in case an error happened, we
> are checking if 'new_inode' is NULL, but that is not needed since during a
> rename exchange, unlike regular renames, 'new_inode' can never be NULL,
> and if it were, we would have a crash much earlier when we dereference it
> multiple times.
> 
> So remove the check because it is not necessary and because it is causing
> static checkers to emit a warning. I probably introduced the check by
> copy-pasting similar code from btrfs_rename(), where 'new_inode' can be
> NULL, in commit 86e8aa0e772cab ("Btrfs: unpin logs if rename exchange
> operation fails").
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
