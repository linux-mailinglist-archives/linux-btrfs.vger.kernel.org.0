Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C92299A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGVOCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:02:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgGVOCs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:02:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D680DAF38;
        Wed, 22 Jul 2020 14:02:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91626DA70B; Wed, 22 Jul 2020 16:02:20 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:02:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Fix a few lockdep splats
Message-ID: <20200722140220.GV3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200717191229.2283043-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717191229.2283043-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 03:12:26PM -0400, Josef Bacik wrote:
> We've had a longstanding lockdep splat in open_fs_devices that we've been
> ignoring for some time, since it's not actually a problem.  However this has
> been masking all the other lockdep issues that we have, since lockdep takes its
> ball and goes home as soon as you hit one problem.

Added to misc-next, thanks. There should be like 4 lockdep fixes, let's
see which tests with higher numbers were obscured due to the lockdep
first-only behaviour.
