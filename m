Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08230340923
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCRPqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 11:46:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhCRPpz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 11:45:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28D17AC23;
        Thu, 18 Mar 2021 15:45:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D98DDA6E2; Thu, 18 Mar 2021 16:43:51 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:43:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Handle bad dev_root properly with rescue=all
Message-ID: <20210318154351.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1615479658.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615479658.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 11:23:13AM -0500, Josef Bacik wrote:
[...]

> rescue=all working without panicing the machine,
> and I verified everything by
> using btrfs-corrupt-block to corrupt a dev root of a file system.  Thanks,

We need to have such testing part of some suite but it depends on the
utilities that we don't want to ship by default. Last time we discussed
how to make btrfs-corrupt-block or similar available in source form in
fstests it was not pretty, like having half of the btrfs-progs sources
providing code to read and modify the data structures.

So, what if: we have such tests in the btrfs-progs testsuite. As they're
potentially dangerous, not run by default, but available for easy setup
and test in a VM. The testsuite can be exported into a tarball, with the
binaries included. Or simply run it built from git, that works too just
needs more dependencies installed.

I was thinking about collecting all the stress tests into one place,
fstests already has some but my idea is to provide stress testing of
btrfs-specific features, more at once. Or require some 3rd party tools
and data sources to provide the load.

It would be some infrastructure duplication with fstests, but lots of
that is already done in btrfs-progs and I'd rather go with some
duplication instead of development-time-only testing.
