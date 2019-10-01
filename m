Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79AD7C3FBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfJASXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 14:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731560AbfJASXe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 14:23:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73BA0ABE9;
        Tue,  1 Oct 2019 18:23:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3ADBBDA88C; Tue,  1 Oct 2019 20:23:51 +0200 (CEST)
Date:   Tue, 1 Oct 2019 20:23:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v3] btrfs: add a force_chunk_alloc to space_info's sysfs
Message-ID: <20191001182350.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190805183153.22712-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805183153.22712-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 02:31:53PM -0400, Josef Bacik wrote:
> In testing various things such as the btrfsck patch to detect over
> allocation of chunks, empty block group deletion, and balance I've had
> various ways to force chunk allocations for debug purposes.  Add a sysfs
> file to enable forcing of chunk allocation for the owning space info in
> order to enable us to add testcases in the future to test these various
> features easier.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v2->v3:
> - as per Qu's suggestion, moved this to sysfs where it's easier to mess with and
>   makes more sense.
> - added side-effect is mixed bg forced allocation works with this scheme as
>   well.
> - had to add get_btrfs_kobj() to get to fs_info, not sure this is better than
>   just adding the fs_info to the space_info, am open to other opinions here.

I believe v3 is the latest version, but I don't see the new file being
added to the debug/ directory (ie. /sys/fs/btrfs/UUID/debug/)

As it has been discussed, whether to make the file always visible or
only with CONFIG_BTRFS_DEBUG, I'd rather keep it debugging-only. The
testing coverage should be sufficient for fstests that are run with the
config option and not giving users a knob to paper over allocator
problems sounds desirable.
