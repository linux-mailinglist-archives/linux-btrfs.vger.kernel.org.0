Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0AE455B77
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344650AbhKRMZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 07:25:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344643AbhKRMZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 07:25:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EB9DB1FD29;
        Thu, 18 Nov 2021 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637238159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d7T4YCiwvTJShU4kJMnr7CvApsEpNeyZAbIslUdpXc=;
        b=OZZomw0pcbOTs2eu5FR9bYDC/WkGVdWPqzfD9FrDSCwlp7CNTaxkVJE3Hkm/RxBaOv4jUh
        0C0YSuL9NrFGK+w58Lc6Qc8kvWpyRjGOE6HA7Hvr6XPrdsoPK4lBGkqHzIwkwl50dGFUoG
        xyPCc+0Tv+o8XfS4HvY84wF3FsjrdAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637238159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d7T4YCiwvTJShU4kJMnr7CvApsEpNeyZAbIslUdpXc=;
        b=MYec50FUYNvkGDXwBbpgXTkGIe/OfgXE+UNoJPZ64j16o5nJbykzzybWMDAYwViRMKzDyW
        aWoGkrMFrq8RCBAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DF139A3B87;
        Thu, 18 Nov 2021 12:22:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82D08DA735; Thu, 18 Nov 2021 13:22:35 +0100 (CET)
Date:   Thu, 18 Nov 2021 13:22:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 25/25] btrfs: track the csum, extent, and free space
 trees in a rb tree
Message-ID: <20211118122235.GA28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636144971.git.josef@toxicpanda.com>
 <9b8e6728cf5a0ee5980fa1336ba3e3e8b257076a.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8e6728cf5a0ee5980fa1336ba3e3e8b257076a.1636144971.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 04:45:51PM -0400, Josef Bacik wrote:
> @@ -1242,6 +1243,82 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info)
>  }
>  #endif
>  
> +static int global_root_cmp(struct rb_node *a_node, const struct rb_node *b_node)
> +{
> +	struct btrfs_root *a = rb_entry(a_node, struct btrfs_root, rb_node);
> +	struct btrfs_root *b = rb_entry(b_node, struct btrfs_root, rb_node);

Comparators can use some consts, at least for the local variables. The
rb_add_new comparator prototype has const only for the node, so
global_root_cmp is OK. I'll update the commit.

> +	return btrfs_comp_cpu_keys(&a->root_key, &b->root_key);
> +}
