Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD62F24A350
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHSPkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 11:40:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:57464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgHSPkT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 11:40:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F357AB5FD;
        Wed, 19 Aug 2020 15:40:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0393CDA703; Wed, 19 Aug 2020 17:39:12 +0200 (CEST)
Date:   Wed, 19 Aug 2020 17:39:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fixes to GCC warnings while compiling with W=1 level
Message-ID: <20200819153912.GP2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Leon Romanovsky <leon@kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200819141630.1338693-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819141630.1338693-1-leon@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 05:16:27PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> The series of trivial fixes for GCC warnings seen while compiling with W=1.
> 
> Leon Romanovsky (3):
>   fs/btfrs: Fix -Wunused-but-set-variable warnings
>   fs/btrfs: Fix -Wignored-qualifiers warnings
>   fs/btrfs: Fix -Wmissing-prototypes warnings

The warnings from patch 2 and 3 got fixed recently, it's in the
development branch that hasn't been pushed to linux-next yet.

Patch 1 reports unused variables, we get occasional patches that just
silence the warning but it needs to be fixed properly (move setting
feature bits out of sysfs context).  As it's probably the last code
warning with W=1 left I guess I'll apply it, I don't have ETA for the
proper fix but at least this would save people time reporing it.
