Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE85C070
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfGAPkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 11:40:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728537AbfGAPkZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 11:40:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED0DCAFFB;
        Mon,  1 Jul 2019 15:40:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67713DA840; Mon,  1 Jul 2019 17:41:08 +0200 (CEST)
Date:   Mon, 1 Jul 2019 17:41:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org, Su Yue <Damenly_Su@gmx.com>
Subject: Re: [PATCH] btrfs-progs: misc-tests/029: exit manually after
 run_mayfail()
Message-ID: <20190701154108.GL20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org, Su Yue <Damenly_Su@gmx.com>
References: <20190623105324.12466-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623105324.12466-1-Damenly_Su@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 23, 2019 at 06:53:24PM +0800, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> Since the commmit 8dd3e5dc2df5
> ("btrfs-progs: tests: fix misc-tests/029 to run on NFS") added the
> compatibility of NFS, it called run_mayfail() in the last of the test.
> 
> However, run_mayfail() always return the original code. If the test
> case is not running on NFS, the last `run_mayfail rmdir "$SUBVOL_MNT"`
> will fail with return value 1 then the test fails:
> ================================================================
> ====== RUN MAYFAIL rmdir btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> rmdir: failed to remove 'btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt': No such file or director
> failed (ignored, ret=1): rmdir btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> test failed for case 029-send-p-different-mountpoints
> =================================================================
> 
> Every instrument in this script handles its error well, so do exit 0
> manually in the last.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202645
> Fixes: 8dd3e5dc2df5 ("btrfs-progs: tests: fix misc-tests/029 to run on NFS")
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Applied, thanks.
