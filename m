Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF31778D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 15:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgCCO0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 09:26:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:50684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCCO0J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 09:26:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFDCEB21C;
        Tue,  3 Mar 2020 14:26:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97553DA7AE; Tue,  3 Mar 2020 15:25:45 +0100 (CET)
Date:   Tue, 3 Mar 2020 15:25:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH] btrfs: fix RAID direct I/O reads with alternate csums
Message-ID: <20200303142545.GB2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Johannes Thumshirn <jth@kernel.org>
References: <b88c888c800d66ad39b4a561ec6601d2db59529e.1583186403.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88c888c800d66ad39b4a561ec6601d2db59529e.1583186403.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 02:02:49PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> btrfs_lookup_and_bind_dio_csum() does pointer arithmetic which assumes
> 32-bit checksums. If using a larger checksum, this leads to spurious
> failures when a direct I/O read crosses a stripe. This is easy
> to reproduce:
> 
>   # mkfs.btrfs -f --checksum BLAKE2b -d raid0 /dev/vdc /dev/vdd
>   ...
>   # mount /dev/vdc /mnt
>   # cd /mnt
>   # dd if=/dev/urandom of=foo bs=1M count=1 status=none
>   # dd if=foo of=/dev/null bs=1M iflag=direct status=none
>   dd: error reading 'foo': Input/output error
>   # dmesg | tail -1
>   [  135.821568] BTRFS warning (device vdc): csum failed root 5 ino 257 off 421888 ...
> 
> Fix it by using the actual checksum size.
> 
> Fixes: 1e25a2e3ca0d ("btrfs: don't assume ordered sums to be 4 bytes")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> I wasn't sure what commit to point at for the fixes tag (or whether to
> just add a stable tag).

That one is fine, added to the rc queue so we can get it to stable soon.
Thanks.
