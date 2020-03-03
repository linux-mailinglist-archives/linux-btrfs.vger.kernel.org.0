Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42C177D6A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 18:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgCCRZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 12:25:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:41482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730315AbgCCRZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 12:25:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82612AE35;
        Tue,  3 Mar 2020 17:25:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE260DA7AE; Tue,  3 Mar 2020 18:25:23 +0100 (CET)
Date:   Tue, 3 Mar 2020 18:25:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 01/10] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
Message-ID: <20200303172523.GJ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302094553.58827-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 05:45:44PM +0800, Qu Wenruo wrote:
> +struct btrfs_backref_iter {
> +	u64 bytenr;
> +	struct btrfs_path *path;
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_key cur_key;

> +	unsigned long item_ptr;
> +	unsigned long cur_ptr;
> +	unsigned long end_ptr;

I think these can be u32, only processing the leaf data, this would save
some stack space consumed by the iterators.
