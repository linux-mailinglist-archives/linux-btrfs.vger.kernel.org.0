Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109262DB432
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgLOTCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 14:02:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:52610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbgLOTC0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 14:02:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F4FDAC7F;
        Tue, 15 Dec 2020 19:01:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1A9C1DA7C3; Tue, 15 Dec 2020 20:00:00 +0100 (CET)
Date:   Tue, 15 Dec 2020 20:00:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Support removal of ino cache leftover by btrfs check
Message-ID: <20201215185959.GE6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201203081742.3759528-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203081742.3759528-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 10:17:40AM +0200, Nikolay Borisov wrote:
> Following the removal of ino cache support in the kernel, let's add support
> for 'btrfs check --clear-ino-cache'. 2nd patch also adds a test to ensure we
> don't regress this functionality in the future.

Thanks, added to devel with some fixups. The test is really for check so
it should be in fsck-tests and the SUDO_HELPER is not necessary as
there's no mount/umount involved (that failed on my NFS setup), the
dump-tree -t N should not be numeric if it's for a named tree (fs,
csum).
