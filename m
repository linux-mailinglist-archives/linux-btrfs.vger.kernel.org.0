Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58B30F75B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 17:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhBDQM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 11:12:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:47066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237852AbhBDQLQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 11:11:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF045ABD5;
        Thu,  4 Feb 2021 16:10:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0ABB1DA849; Thu,  4 Feb 2021 17:08:43 +0100 (CET)
Date:   Thu, 4 Feb 2021 17:08:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix extent buffer leak on failure to copy root
Message-ID: <20210204160843.GH1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <aa032e11aa2b8667a28a93b90691d6f790711c62.1612449293.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa032e11aa2b8667a28a93b90691d6f790711c62.1612449293.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 02:35:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_copy_root(), if the call to btrfs_inc_ref() fails we end up
> returning without unlocking and releasing our reference on the extent
> buffer named "cow" we previously allocated with btrfs_alloc_tree_block().
> 
> So fix that by unlocking the extent buffer and dropping our reference on
> it before returning.
> 
> Fixes: be20aa9dbadc8c ("Btrfs: Add mount option to turn off data cow")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
