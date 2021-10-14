Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17242D5AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNJLp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 05:11:45 -0400
Received: from verein.lst.de ([213.95.11.211]:49303 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhJNJLp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 05:11:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7782E68B05; Thu, 14 Oct 2021 11:09:38 +0200 (CEST)
Date:   Thu, 14 Oct 2021 11:09:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: "btrfs: update the bdev time directly when closing" is broken
Message-ID: <20211014090937.GA1740@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

commit 8f96a5bfa150 ("btrfs: update the bdev time directly when closing")
changes the behavior from updating the timestamps on the device node
that is visible in the file system to that of the internal block device
inode.  These internal timestamp inodes are never written back anywhere,
so these updates are useless.  I'm not sure how useful these timestamp
updates were to start with (they look a little odd to me), but the new
version is just dead code.

