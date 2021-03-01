Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9CC328CD6
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 20:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhCATAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 14:00:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:39032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240796AbhCAS5z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 13:57:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8477EAD5C;
        Mon,  1 Mar 2021 18:57:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB391DA7AA; Mon,  1 Mar 2021 19:55:18 +0100 (CET)
Date:   Mon, 1 Mar 2021 19:55:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Qgroup/delayed node related fixes
Message-ID: <20210301185518.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222164047.978768-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 06:40:41PM +0200, Nikolay Borisov wrote:
> This series contains a couple of fixes and code simplifications around qgroup
> and delayed node interation. The first 3 patches fix 2 separate issues - one
> possible underflow when freeing qgroup-reserved space and the other one is a
> deadlock. Next 3 patches build on the fixes to clean up and simplify qgroup's
> flushing code.
> 
> Nikolay Borisov (6):
>   btrfs: Free correct amount of space in btrfs_delayed_inode_reserve_metadata
>   btrfs: Export qgroup_reserve_meta
>   btrfs: Don't flush from btrfs_delayed_inode_reserve_metadata
>   btrfs: Cleanup try_flush_qgroup
>   btrfs: Remove btrfs_inode from btrfs_delayed_inode_reserve_metadata
>   btrfs: Simplify code flow in btrfs_delayed_inode_reserve_metadata

Patchset added to misc-next, thanks.
