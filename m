Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF53905BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhEYPnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 11:43:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhEYPnu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 11:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621957339;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0JsL76dx90DKDjQuyRy0IOv8oTG/Yr/+siq+5l3Xnuk=;
        b=XrnHji71DR6FoDYxFUnjTuLwnv0BVA1nrA1/yocLM2y8US8BPkZIFZ8bBL+MI7Wil4mUGe
        2P0DQWhIP/r47rntYujEh2eKEV5VZjEKU0RyMMNAXC6xmz6tmDL/idrIqFCOzRnt9CFaTK
        R/y0xeny5pdPN14yI5CZvjAVvnDOsV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621957339;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0JsL76dx90DKDjQuyRy0IOv8oTG/Yr/+siq+5l3Xnuk=;
        b=+7zJMnvFa5CS2+R8/NKWO7zrXjT2/GCBvyKeVYulpIKJN11heuYo3RpmB28ZQHr58jIyUh
        JFa7WKC1yhuMhaBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97286AB71;
        Tue, 25 May 2021 15:42:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E708DA70B; Tue, 25 May 2021 17:39:43 +0200 (CEST)
Date:   Tue, 25 May 2021 17:39:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Rework fs error handling
Message-ID: <20210525153942.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1621523846.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621523846.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 11:21:30AM -0400, Josef Bacik wrote:
> Josef Bacik (3):
>   btrfs: always abort the transaction if we abort a trans handle

This one now added to misc-next.

>   btrfs: add a btrfs_has_fs_error helper
>   btrfs: do not infinite loop in data reclaim if we aborted

I can fix up the 2nd patch locally, it's basically only a rename but the
fs and transaction bits getting out of sync as mentioned could be a
problem (or not). Patch 3 depends on the 2nd so I'll keep both in
for-next for the time being.
