Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F228712E936
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 18:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgABRTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 12:19:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:40944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgABRTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 12:19:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59356AB92;
        Thu,  2 Jan 2020 17:19:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65651DA790; Thu,  2 Jan 2020 18:19:28 +0100 (CET)
Date:   Thu, 2 Jan 2020 18:19:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org, Damenly_Su@gmx.com
Subject: Re: [PATCH v2] btrfs-progs: misc-tests/038: fix wrong field filtered
 under root directory
Message-ID: <20200102171928.GO3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org, Damenly_Su@gmx.com
References: <20191202115454.4749-1-Damenly_Su@gmx.com>
 <20191202123523.6544-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202123523.6544-1-Damenly_Su@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 08:35:23PM +0800, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> Ran misc-tests/038 in /root/btrfs-progs:
> ======================================================================
> make test-misc TEST=038\*
>     [TEST]   misc-tests.sh
>     [TEST/misc]   038-backup-root-corruption
> ./test.sh: line 33: [: bytenr=65536,: integer expression expected
> Backup slot 2 is not in use
> test failed for case 038-backup-root-corruption
> make: *** [Makefile:401: test-misc] Error 1
> ======================================================================
> 
> It's caused by the wrong line filtered by
> $(dump_super | grep root | head -n1 | awk '{print $2}').
> 
> The $(dump-super | grep root) outputs
> ======================================================================
> superblock: bytenr=65536, device=/root/btrfs-progs/tests/test.img
> root                    30605312
> chunk_root_generation   5
> root_level              0
> chunk_root              22036480
> chunk_root_level        0
> log_root                0
> log_root_transid        0
> log_root_level          0
> root_dir                6
> backup_roots[4]:
> ======================================================================
> 
> Here
> "superblock: bytenr=65536, device=/root/btrfs-progs/tests/test.img" is
> selected but not the line "root                    30605312".
> 
> Restricting the awk rule can fix it.
> 
> Fixes: 78a3831d46ec ("btrfs-progs: tests: Test backup root retention logic")
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Applied, thanks.
