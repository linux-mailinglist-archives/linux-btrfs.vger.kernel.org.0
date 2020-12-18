Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16B92DE67A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgLRPYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 10:24:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:34248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgLRPYu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 10:24:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EE0CAD09;
        Fri, 18 Dec 2020 15:24:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F541DA806; Fri, 18 Dec 2020 16:22:28 +0100 (CET)
Date:   Fri, 18 Dec 2020 16:22:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 2/5] btrfs: print the actual offset in btrfs_root_name
Message-ID: <20201218152228.GZ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1608135381.git.josef@toxicpanda.com>
 <563f04c9be75df4f70a2b060802454f13af13cf5.1608135381.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563f04c9be75df4f70a2b060802454f13af13cf5.1608135381.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:18:44AM -0500, Josef Bacik wrote:
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -26,22 +26,22 @@ static const struct root_name_map root_map[] = {
>  	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
>  };
>  
> -const char *btrfs_root_name(u64 objectid, char *buf)
> +const char *btrfs_root_name(struct btrfs_key *key, char *buf)

I've added 'const' here.
