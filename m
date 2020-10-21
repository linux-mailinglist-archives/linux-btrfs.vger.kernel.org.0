Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A50294FE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502452AbgJUPUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 11:20:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502132AbgJUPUx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 11:20:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC3B4ACA0;
        Wed, 21 Oct 2020 15:20:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0000ADA7C5; Wed, 21 Oct 2020 17:19:21 +0200 (CEST)
Date:   Wed, 21 Oct 2020 17:19:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs: drop the path before adding qgroup items when
 enabling qgroups
Message-ID: <20201021151921.GE6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1603137558.git.josef@toxicpanda.com>
 <f0fc7512506f008dd356cffe49a17990199ff6f4.1603137558.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0fc7512506f008dd356cffe49a17990199ff6f4.1603137558.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 19, 2020 at 04:02:29PM -0400, Josef Bacik wrote:
> When enabling qgroups we walk the tree_root and then add a qgroup item
> for every root that we have.  This creates a lock dependency on the
> tree_root and qgroup_root, which results in the following lockdep splat

This should mention that it's with the rwsem and that we've seen it on
btrfs/022 and btrfs/017.

That it's with rwsem is in the cover letter but we need it in the
patches too.
