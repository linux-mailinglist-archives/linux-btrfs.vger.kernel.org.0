Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23927CD18
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgI2Mlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 08:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgI2Mln (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 08:41:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC04CAF10;
        Tue, 29 Sep 2020 12:41:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9C5BDA701; Tue, 29 Sep 2020 14:40:21 +0200 (CEST)
Date:   Tue, 29 Sep 2020 14:40:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH -next]  btrfs: Fix wild pointer reference in
 btrfs_set_buffer_lockdep_class
Message-ID: <20200929124020.GE6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ye Bin <yebin10@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20200929123357.930605-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929123357.930605-1-yebin10@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 08:33:57PM +0800, Ye Bin wrote:
> 'ks' is pointer type, but not initialized, so ks->keys will reference
> wild pointer.

> -	struct btrfs_lockdep_keyset *ks;
> +	struct btrfs_lockdep_keyset *ks = btrfs_lockdep_keysets;
>  
>  	BUG_ON(level >= ARRAY_SIZE(ks->keys));

ARRAY_SIZE does not dereference the pointer, it uses only the type
information, in this case 'struct btrfs_lockdep_keyset::keys'.
