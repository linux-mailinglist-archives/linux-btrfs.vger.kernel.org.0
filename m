Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF81F180CEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 01:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCKAkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 20:40:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgCKAkj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 20:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32836B17A;
        Wed, 11 Mar 2020 00:40:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8016DA7A7; Wed, 11 Mar 2020 01:40:12 +0100 (CET)
Date:   Wed, 11 Mar 2020 01:40:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3] btrfs: implement migratepage callback
Message-ID: <20200311004012.GC12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Roman Gushchin <guro@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
References: <20200305005735.583008-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305005735.583008-1-guro@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 04, 2020 at 04:57:35PM -0800, Roman Gushchin wrote:
> Currently btrfs doesn't provide a migratepage callback. It means that
> fallback_migrate_page()	is used to migrate btrfs pages.

The callback exists for the metadata pages (btree_migratepage), so I've
added 'for data pages' where appropriate.

> fallback_migrate_page() cannot move dirty pages, instead it tries to
> flush them (in sync mode) or just fails (in async mode).
> 
> In the sync mode pages which are scheduled to be processed by
> btrfs_writepage_fixup_worker() can't be effectively flushed by the
> migration code, because there is no established way to wait for the
> completion of the delayed work.
> 
> It all leads to page migration failures.
> 
> To fix it the patch implements a btrs-specific migratepage callback,
> which is similar to iomap_migrate_page() used by some other fs, except
> it does take care of the PagePrivate2 flag which is used for data
> ordering purposes.
> 
> v3: fixed the build issue once again
> v2: fixed the build issue found by the kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Chris Mason <clm@fb.com>

Added to devel queue, thanks.
