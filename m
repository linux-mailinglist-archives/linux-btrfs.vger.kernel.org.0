Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99E2A813D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgKEOri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 09:47:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:50452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKEOrh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 09:47:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BDD7FAAF1;
        Thu,  5 Nov 2020 14:47:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C0F8DA6E3; Thu,  5 Nov 2020 15:45:58 +0100 (CET)
Date:   Thu, 5 Nov 2020 15:45:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/14] btrfs: Make btrfs_truncate_inode_items take
 btrfs_inode
Message-ID: <20201105144557.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201102144906.3767963-1-nborisov@suse.com>
 <20201102144906.3767963-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102144906.3767963-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 04:48:55PM +0200, Nikolay Borisov wrote:
> @@ -4297,7 +4296,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>  				if (test_bit(BTRFS_ROOT_SHAREABLE,
>  					     &root->state) &&
>  				    extent_start != 0)
> -					inode_sub_bytes(inode, num_dec);
> +					inode_sub_bytes(&inode->vfs_info,
> +							num_dec);

  CC [M]  fs/btrfs/tree-log.o
fs/btrfs/inode.c: In function ‘btrfs_truncate_inode_items’:
fs/btrfs/inode.c:4364:30: error: ‘struct btrfs_inode’ has no member named ‘vfs_info’; did you mean ‘vfs_inode’?
 4364 |      inode_sub_bytes(&inode->vfs_info,
      |                              ^~~~~~~~
      |                              vfs_inode
