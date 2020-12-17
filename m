Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894F82DD794
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgLQSKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 13:10:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:53810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbgLQSKe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 13:10:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74671ABC6;
        Thu, 17 Dec 2020 18:09:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6ED72DA83A; Thu, 17 Dec 2020 19:08:12 +0100 (CET)
Date:   Thu, 17 Dec 2020 19:08:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: fix transaction leaks and crashes during
 unmount
Message-ID: <20201217180812.GX6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1607940240.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 10:10:44AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are some cases where we can leak a transaction and crash during unmount
> after remounting the filesystem in RO mode or mounting RO. These issues were
> actually being hit by automated tests from the openQA for openSUSE Tumbleweed
> (bugzilla https://bugzilla.suse.com/show_bug.cgi?id=1164503).
> 
> Filipe Manana (5):
>   btrfs: fix transaction leak and crash after RO remount caused by
>     qgroup rescan
>   btrfs: fix transaction leak and crash after cleaning up orphans on RO
>     mount
>   btrfs: fix race between RO remount and the cleaner task
>   btrfs: add assertion for empty list of transactions at late stage of
>     umount
>   btrfs: run delayed iputs when remounting RO to avoid leaking them

Added to misc-next, thanks.
