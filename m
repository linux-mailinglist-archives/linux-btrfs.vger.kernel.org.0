Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5712830B26D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBAV6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:58:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:48232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhBAV6h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:58:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52FB4AC45;
        Mon,  1 Feb 2021 21:57:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC4EFDA6FC; Mon,  1 Feb 2021 22:56:04 +0100 (CET)
Date:   Mon, 1 Feb 2021 22:56:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: more performance improvements for dbench
 workloads
Message-ID: <20210201215604.GW1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1611742865.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 10:34:53AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset brings one more batch of performance improvements
> with dbench workloads, or anything that mixes file creation, file writes,
> renames, unlinks, etc with fsync like dbench does. This patchset is mostly
> based on avoiding logging directory inodes multiple times when not necessary,
> falling back to transaction commits less frequently and often waiting less
> time for transaction commits to complete. Performance results are listed in
> the change log of the last patch, but in short, I've experienced a reduction
> of maximum latency up to about -40% and throuhput gains up to about +6%.

Nice, added to misc-next, thanks.
