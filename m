Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3ED16B588
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 00:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgBXX3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 18:29:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:50384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgBXX3T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 18:29:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5576AD5D;
        Mon, 24 Feb 2020 23:29:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6502ADA726; Tue, 25 Feb 2020 00:28:57 +0100 (CET)
Date:   Tue, 25 Feb 2020 00:28:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH misc-next] btrfs: fix compilation error in
 btree_write_cache_pages()
Message-ID: <20200224232857.GE2902@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 05:22:51AM +0900, Johannes Thumshirn wrote:
> CC [M]  fs/btrfs/extent_io.o
> fs/btrfs/extent_io.c: In function ‘btree_write_cache_pages’:
> fs/btrfs/extent_io.c:3959:34: error: ‘tree’ undeclared (first use in this function); did you mean ‘true’?
>  3959 |  struct btrfs_fs_info *fs_info = tree->fs_info;
>       |                                  ^~~~
>       |                                  true
> fs/btrfs/extent_io.c:3959:34: note: each undeclared identifier is reported only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:268: fs/btrfs/extent_io.o] Error 1
> make[1]: *** [scripts/Makefile.build:505: fs/btrfs] Error 2
> make: *** [Makefile:1681: fs] Error 2
> 
> Fixes: 75c39607eb0a ("btrfs: Don't submit any btree write bio if the fs has errors")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Folded, thanks.
