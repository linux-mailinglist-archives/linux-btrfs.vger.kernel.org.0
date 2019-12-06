Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71951154F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 17:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFQRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 11:17:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfLFQRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 11:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FfwzEcorkXbM8vzjX38dJsbMyLfJpA+SOA2PraA0uq4=; b=FTpqPQZKYGxlRzIKQK0d4SO9E
        g7zWp7NZxc3HPWc7mrdYAdoZQV+kQS22TETVLcgTEx/IdM3R+LfXeaMKa8ZBzxXHTqrT886NySwqE
        TMYwey2Fg5hvpowobL+LcMxg3BQ6HaSA4GZ4McLl1Si+jp5YG7ilVtkNJwCvhEmKkJs+LlZwDmQaP
        sdLcb6QNThw72RD7AiTRW5rlE7/c4x4cx2vTPvahUcFWe0uoX1WTD7chUTwNoyPyFA/wKPxUgkYCE
        XQNYdUkQsC2X4sB5zrkYK7J6guJnzMPcGK3xN4+IV4SEMDciCTjG3wVcqVVHCd/SavTMz3W5qtsZG
        yc7D9IeHA==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idGIN-00013t-5Y; Fri, 06 Dec 2019 16:17:31 +0000
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <20191206135406.563336e7@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
Date:   Fri, 6 Dec 2019 08:17:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206135406.563336e7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/5/19 6:54 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material for v5.6 to your linux-next included
> trees until after v5.5-rc1 has been released.
> 
> Changes since 20191204:
> 

on x86_64:

fs/btrfs/ctree.o: warning: objtool: btrfs_search_slot()+0x2d4: unreachable instruction
fs/btrfs/extent-tree.o: warning: objtool: btrfs_get_extent_inline_ref_type()+0x161: unreachable instruction
fs/btrfs/disk-io.o: warning: objtool: btrfs_init_fs_root()+0x1d9: unreachable instruction
fs/btrfs/transaction.o: warning: objtool: btrfs_trans_release_metadata()+0x96: unreachable instruction
fs/btrfs/inode.o: warning: objtool: btrfs_retry_endio()+0x77: unreachable instruction
fs/btrfs/file.o: warning: objtool: __btrfs_drop_extents()+0x4aa: unreachable instruction
fs/btrfs/extent_map.o: warning: objtool: mergable_maps()+0x100: unreachable instruction
fs/btrfs/xattr.o: warning: objtool: btrfs_setxattr()+0x86: unreachable instruction
fs/btrfs/extent_io.o: warning: objtool: __process_pages_contig()+0x1af: unreachable instruction
fs/btrfs/volumes.o: warning: objtool: find_live_mirror.isra.23()+0x49: unreachable instruction
fs/btrfs/ioctl.o: warning: objtool: btrfs_clone()+0xcc9: unreachable instruction
fs/btrfs/free-space-cache.o: warning: objtool: search_bitmap()+0xca: unreachable instruction
fs/btrfs/tree-log.o: warning: objtool: btrfs_log_all_xattrs()+0x204: unreachable instruction
fs/btrfs/compression.o: warning: objtool: end_compressed_bio_read()+0xb6: unreachable instruction
fs/btrfs/delayed-ref.o: warning: objtool: insert_delayed_ref.isra.6()+0x23e: unreachable instruction
fs/btrfs/relocation.o: warning: objtool: add_tree_block.isra.26()+0x26e: unreachable instruction
fs/btrfs/scrub.o: warning: objtool: scrub_find_csum()+0x1eb: unreachable instruction
fs/btrfs/send.o: warning: objtool: inconsistent_snapshot_error()+0x53: unreachable instruction
fs/btrfs/dev-replace.o: warning: objtool: btrfs_dev_replace_by_ioctl()+0x70e: unreachable instruction
fs/btrfs/raid56.o: warning: objtool: raid56_parity_recover()+0x262: unreachable instruction
fs/btrfs/free-space-tree.o: warning: objtool: btrfs_search_prev_slot.constprop.6()+0x2b: unreachable instruction
fs/btrfs/block-group.o: warning: objtool: btrfs_start_trans_remove_block_group()+0x6a: unreachable instruction
fs/btrfs/ref-verify.o: warning: objtool: add_tree_block()+0x15e: unreachable instruction
samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0: unreachable instruction
samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0: unreachable instruction
samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0: unreachable instruction
kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x21: unreachable instruction
kernel/cred.o: warning: objtool: prepare_creds()+0x2c3: unreachable instruction
net/core/skbuff.o: warning: objtool: skb_push()+0x6d: unreachable instruction
drivers/gpu/drm/ttm/ttm_bo.o: warning: objtool: ttm_bo_del_from_lru()+0xed: unreachable instruction


gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
