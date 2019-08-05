Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD92D820FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHEP7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 11:59:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:43506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfHEP7p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 11:59:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56839ADD9;
        Mon,  5 Aug 2019 15:59:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D5C77DABC7; Mon,  5 Aug 2019 18:00:16 +0200 (CEST)
Date:   Mon, 5 Aug 2019 18:00:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
Message-ID: <20190805160016.GB28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190805131942.8669-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805131942.8669-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 09:19:42AM -0400, Josef Bacik wrote:
> In testing block group removal it's sometimes handy to be able to create
> block groups on demand.  Add an ioctl to allow us to force allocation
> from userspace.

For debugging and testing purposes that's possible to add, but certainly
not as a high-level command of 'btrfs filesystem'.

> +#define BTRFS_IOC_ALLOC_CHUNK _IOR(BTRFS_IOCTL_MAGIC, 63, __u64)

From interface POV, this is wrong on several levels.

* it addresses a single narrow usecase

* the parameters are non-extensible so when you're going to need one
  more u64 next week or month, it'll cost another ioctl, but this one
  has to stay forever

* ioctl for debugging is not always the best interface (sysfs was
  suggested)

It would help if you explain the 'sometimes handy' in more detail
otherwise I'm going to be suspecting the usecase is not to help
debugging but to paper over inefficient chunk allocator behaviour.
I hope I'm wrong on that one but user interest under the patch shows
otherwise.

Regarding the points above, the sysfs is IMO more suitable:

* single file representing a command to the filesystem is fine for a
  narrow usecase, ie.
  'echo metadata > /sys/fs/btrfs/UUID/debug/force_chunk_alloc'
  is acceptable for testing

* string-based commands are extensible, as long as we pass eg. key=value
