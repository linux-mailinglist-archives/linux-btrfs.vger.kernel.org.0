Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4097A6B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfG3LRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 07:17:20 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:35150 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfG3LRT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 07:17:19 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 72555440242;
        Tue, 30 Jul 2019 14:17:16 +0300 (IDT)
References: <20190726155847.12970-1-dsterba@suse.com>
User-agent: mu4e 1.2.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.2.1
In-reply-to: <20190726155847.12970-1-dsterba@suse.com>
Date:   Tue, 30 Jul 2019 14:17:16 +0300
Message-ID: <87tvb3wz43.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On Fri, Jul 26 2019, David Sterba wrote:
> btrfs-progs version 5.2.1 have been released. This is a bugfix release.
>
> Changes:
>   * scrub status: fix ETA calculation after resume
>   * check: fix crash when using -Q
>   * restore: fix symlink owner restoration
>   * mkfs: fix regression with mixed block groups
>   * core: fix commit to process all delayed refs
>   * other:
>     * minor cleanups
>     * test updates
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

The last commit in this repo's master branch is 608fd900ca45 ("Btrfs
progs v5.2"). Where can I find the updated git repo?

Thanks,
baruch

> Shortlog:
>
> Adam Borowski (1):
>       btrfs-progs: fix a printf format string fatal warning
>
> David Sterba (7):
>       btrfs-progs: props: update descriptions
>       btrfs-progs: props: convert to C99 initializers
>       btrfs-progs: props: update help texts
>       btrfs-progs: tests: switch messages to _log
>       btrfs-progs: restore: fix chown of a symlink
>       btrfs-progs: update CHANGES for v5.2.1
>       Btrfs progs v5.2.1
>
> Filipe Manana (1):
>       Btrfs-progs: mkfs, fix metadata corruption when using mixed mode
>
> Grzegorz Kowal (2):
>       btrfs-progs: scrub: fix ETA calculation
>       btrfs-progs: scrub: fix status lines alignment
>
> Josef Bacik (1):
>       btrfs-progs: deal with drop_progress properly in fsck
>
> Naohiro Aota (1):
>       btrfs-progs: check: initialize qgroup_item_count in earlier stage
>
> Omar Sandoval (1):
>       btrfs-progs: receive: get rid of unnecessary strdup()
>
> Qu Wenruo (3):
>       btrfs-progs: Exhaust delayed refs and dirty block groups to prevent delayed refs lost
>       btrfs-progs: extent-tree: Unify the parameters of btrfs_inc_extent_ref()
>       btrfs-progs: tests: Avoid debug log populating stdout


-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
