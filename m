Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8CD2EC0F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhAFQTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 11:19:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbhAFQTt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 11:19:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7C12AA35;
        Wed,  6 Jan 2021 16:19:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A9BDDA6E9; Wed,  6 Jan 2021 17:17:18 +0100 (CET)
Date:   Wed, 6 Jan 2021 17:17:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: properly exclude leaves for lowmem
Message-ID: <20210106161718.GT6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <845796bfab85f02919d64908b63f3f7201a2abb3.1609882807.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845796bfab85f02919d64908b63f3f7201a2abb3.1609882807.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 05, 2021 at 04:40:18PM -0500, Josef Bacik wrote:
> The lowmem mode excludes all referenced blocks from the allocator in
> order to avoid accidentally overwriting blocks while fixing the file
> system.  However for leaves it wouldn't exclude anything, it would just
> pin them down, which gets cleaned up on transaction commit.  We're safe
> for the first modification, but subsequent modifications could blow up
> in our face.  Fix this by properly excluding leaves as well as all of
> the nodes.

This sounds like a test case can be easily written.
