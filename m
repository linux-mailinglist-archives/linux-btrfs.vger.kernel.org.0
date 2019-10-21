Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D149DF149
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfJUP0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 11:26:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUP0E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 11:26:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CFEBB208;
        Mon, 21 Oct 2019 15:26:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A522DA905; Mon, 21 Oct 2019 17:26:16 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:26:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/7] btrfs-progs: Support for BG_TREE feature
Message-ID: <20191021152616.GO3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191010064156.31782-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010064156.31782-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 02:41:49PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/bg_tree
> Which is based on v5.2.2 tag.
> 
> This patchset provides the needed user space infrastructure for BG_TREE
> feature.
> 
> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
> is needed to convert existing fs (unmounted) to new format.
> 
> Now btrfstune can convert regular extent tree fs to bg tree fs to
> improve mount time.
> 
> For the performance improvement, please check the kernel patchset cover
> letter or the last patch.
> (SPOILER ALERT: It's super fast)
> 
> Changelog:
> v2:
> - Rebase to v5.2.2 tag
> - Add btrfstune ability to convert existing fs to BG_TREE feature
> 
> v3:
> - Fix a bug that temp chunks are not cleaned up properly
>   This is caused by wrong timing btrfs_convert_to_bg_tree() is called.
>   It should be called after temp chunks cleaned up.
> 
> - Fix a bug that an extent buffer get leaked
>   This is caused by newly created bg tree not added to dirty list.
> 
> Qu Wenruo (7):
>   btrfs-progs: Refactor excluded extent functions to use fs_info
>   btrfs-progs: Refactor btrfs_read_block_groups()

I'll add 1 and 2 to devel as they're independent. Thanks.
