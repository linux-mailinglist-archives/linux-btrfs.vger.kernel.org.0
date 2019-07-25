Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0963075683
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGYSDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 14:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfGYSDX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 14:03:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B322AF78;
        Thu, 25 Jul 2019 18:03:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9617BDA7DE; Thu, 25 Jul 2019 20:03:58 +0200 (CEST)
Date:   Thu, 25 Jul 2019 20:03:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs-progs: mkfs, fix metadata corruption when using
 mixed mode
Message-ID: <20190725180358.GV2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190725102717.11688-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725102717.11688-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:27:17AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating a filesystem with mixed block groups, we are creating two
> space info objects to track used/reserved/pinned space, one only for data
> and another one only for metadata.
> 
> This is making fstests test case generic/416 fail, with btrfs' check
> reporting over an hundred errors about bad extents:
> 
>   (...)
>   bad extent [17186816, 17190912), type mismatch with chunk
>   bad extent [17195008, 17199104), type mismatch with chunk
>   bad extent [17203200, 17207296), type mismatch with chunk
>   (...)
> 
> Because, surprisingly, this results in block groups that do not have the
> BTRFS_BLOCK_GROUP_DATA flag set but have data extents allocated in them.
> This is a regression introduced in btrfs-progs v5.2.
> 
> So fix this by making sure we only create one space info object, for both
> metadata and data, when mixed block groups are enabled.
> 
> Fixes: c31edf610cbe1e ("btrfs-progs: Fix false ENOSPC alert by tracking used space correctly")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Applied, thanks.
