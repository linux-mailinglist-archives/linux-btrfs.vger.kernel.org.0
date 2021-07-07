Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558B63BED2E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhGGRiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 13:38:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhGGRiJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 13:38:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3CA19200D7;
        Wed,  7 Jul 2021 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625679325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDDuf22lF3Oqu2PSGuMWbszeRjDanUJmZyXNiZNL2O8=;
        b=gOdWGthy8RkV8SGyMXV2/Jv2fTv8zywLMZ0e/OO334/hzu4Nc6zK2fQxrJVpfSdSk/qfC3
        3X2dpHpau8vvikelt1QzNqy2V+eGVIXPaRigyS3SI9spKWITeVt15+RvtXxqnNrtYpCT1J
        KxFsSxYhUfV8Ze4taw9iVWcccvNNoxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625679325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDDuf22lF3Oqu2PSGuMWbszeRjDanUJmZyXNiZNL2O8=;
        b=OpMj2bhln7Nq5hwoTikDBDQSlHlzqzsqwREsYnHXKsxKezvX22bxw94ZVMSdxv0vtGfb19
        ihEvILO7yu3ULCAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 351B5A3B9A;
        Wed,  7 Jul 2021 17:35:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61C4DDB29A; Wed,  7 Jul 2021 19:32:51 +0200 (CEST)
Date:   Wed, 7 Jul 2021 19:32:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix wrong mutex unlock on failure to
 allocate log root tree
Message-ID: <20210707173251.GQ2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <11314a6ca7a70deee42785d3ee79c97813b528ab.1625656963.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11314a6ca7a70deee42785d3ee79c97813b528ab.1625656963.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 07, 2021 at 12:23:45PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When syncing the log, if we fail to allocate the root node for the log
> root tree:
> 
> 1) We are unlocking fs_info->tree_log_mutex, but at this point we have
>    not yet locked this mutex;
> 
> 2) We have locked fs_info->tree_root->log_mutex, but we end up not
>    unlocking it;
> 
> So fix this by unlocking fs_info->tree_root->log_mutex instead of
> fs_info->tree_log_mutex.
> 
> Fixes: e75f9fd194090e ("btrfs: zoned: move log tree node allocation out of log_root_tree->log_mutex")
> CC: stable@vger.kernel.org # 5.13+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
