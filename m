Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F1227C5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 12:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGUKBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 06:01:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:46952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgGUKBV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 06:01:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 784E6AC12;
        Tue, 21 Jul 2020 10:01:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76FDDDA9B7; Tue, 21 Jul 2020 12:00:55 +0200 (CEST)
Date:   Tue, 21 Jul 2020 12:00:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Fix a few lockdep splats
Message-ID: <20200721100055.GK3703@twin.jikos.cz>
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

That lockdep does not report anything past the first warning is making
it hard to test, I got an unrelated splat with btrfs/078 so can't
actually verify that the fstests run is clean with your patchset.
