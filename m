Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398412D59A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgLJLug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 06:50:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:53356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgLJLuP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A377EAD87;
        Thu, 10 Dec 2020 11:49:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1FA2FDA7D9; Thu, 10 Dec 2020 12:47:57 +0100 (CET)
Date:   Thu, 10 Dec 2020 12:47:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        osandov@osandov.com
Subject: Re: [PATCH 1/2] btrfs: Fold generic_write_checks() in
 btrfs_write_check()
Message-ID: <20201210114756.GD6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        osandov@osandov.com
References: <cover.1607449636.git.rgoldwyn@suse.com>
 <8dabce11b6bc9dc4ba534a2d5cf169ca3d0a812d.1607449636.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dabce11b6bc9dc4ba534a2d5cf169ca3d0a812d.1607449636.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 08, 2020 at 12:42:40PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Code Cleanup.
> 
> Fold generic_write_checks() in btrfs_write_check(), because
> generic_write_checks() is called before btrfs_write_check() in both
> cases. The prototype of btrfs_write_check() has been changed to return
> ssize_t and it can return zero as a valid error code. btrfs_write_check
> now returns the count of I/O to be performed.

That's effectively reverting what Omar sent as a fix to your initial
patch:

https://lore.kernel.org/linux-btrfs/b096cecce8277b30e1c7e26efd0450c0bc12ff31.1605723568.git.osandov@fb.com/

fixing a problem. Now you revert that to fix another problem, now with
the lock added. I'd rather have one patch without this cleanup and given
that this is technically fixing a regression in the new 5.11 code it'll
go to post rc1 pull request.
