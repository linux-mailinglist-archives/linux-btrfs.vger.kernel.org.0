Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6EB2E9AD8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbhADQTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 11:19:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:44110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbhADQTZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 11:19:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C36D8ACAF;
        Mon,  4 Jan 2021 16:18:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4BBB3DA882; Mon,  4 Jan 2021 17:16:55 +0100 (CET)
Date:   Mon, 4 Jan 2021 17:16:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Lesimple 
        <stephane_btrfs2@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: fix wrong file extent type check to
 avoid false -ENOENT error
Message-ID: <20210104161655.GJ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs2@lesimple.fr>
References: <20201229132934.117325-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201229132934.117325-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 29, 2020 at 09:29:34PM +0800, Qu Wenruo wrote:
> [BUG]
> There are several bug reports about recent kernel unable to relocate
> certain data block groups.
> 
> Sometimes the error just go away, but there is one reporter who can
> reproduce it reliably.
> 
> The dmesg would look like:
> [  438.260483] BTRFS info (device dm-10): balance: start -dvrange=34625344765952..34625344765953
> [  438.269018] BTRFS info (device dm-10): relocating block group 34625344765952 flags data|raid1
> [  450.439609] BTRFS info (device dm-10): found 167 extents, stage: move data extents
> [  463.501781] BTRFS info (device dm-10): balance: ended with status: -2
> 
> [CAUSE]
> The -ENOENT error is returned from the following chall chain:
> 
> add_data_references()
> |- delete_v1_space_cache();
>    |- if (!found)
>          return -ENOENT;
> 
> The variable @found is set to true if we find a data extent whose
> disk bytenr matches parameter @data_bytes.
> 
> With extra debug, the offending tree block looks like this:
>   leaf bytenr = 42676709441536, data_bytenr = 34626327621632
> 
>                 ctime 1567904822.739884119 (2019-09-08 03:07:02)
>                 mtime 0.0 (1970-01-01 01:00:00)
>                 otime 0.0 (1970-01-01 01:00:00)
>         item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>                 generation 1517381 type 2 (prealloc)
>                 prealloc data disk byte 34626327621632 nr 262144 <<<
>                 prealloc data offset 0 nr 262144
>         item 28 key (52262 ROOT_ITEM 0) itemoff 9415 itemsize 439
>                 generation 2618893 root_dirid 256 bytenr 42677048360960 level 3 refs 1
>                 lastsnap 2618893 byte_limit 0 bytes_used 5557338112 flags 0x0(none)
>                 uuid d0d4361f-d231-6d40-8901-fe506e4b2b53
> 
> Although item 27 has disk bytenr 34626327621632, which matches the
> data_bytenr, its type is prealloc, not reg.
> This makes the existing code skip that item, and return -ENOENT.
> 
> [FIX]
> The code is modified in commit  19b546d7a1b2 ("btrfs: relocation: Use
> btrfs_find_all_leafs to locate data extent parent tree leaves"), before
> that commit, we use something like
> "if (type == BTRFS_FILE_EXTENT_INLINE) continue;".
> 
> But in that offending commit, we use (type == BTRFS_FILE_EXTENT_REG),
> ignoring BTRFS_FILE_EXTENT_PREALLOC.
> 
> Fix it by also checking BTRFS_FILE_EXTENT_PREALLOC.
> 
> Reported-by: Stéphane Lesimple <stephane_btrfs2@lesimple.fr>
> Fixes: 19b546d7a1b2 ("btrfs: relocation: Use btrfs_find_all_leafs to locate data extent parent tree leaves")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thank you all for tracking down the bug, added to misc-next.
