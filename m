Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5BE33EFE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhCQLzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 07:55:40 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:33508 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhCQLzL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 07:55:11 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1lMUjU-00HZqe-Mu
        for linux-btrfs@vger.kernel.org; Wed, 17 Mar 2021 12:53:00 +0100
Date:   Wed, 17 Mar 2021 12:53:00 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Fwd: btrfs-progs: libbtrfsutil is under LGPL-3.0 and statically
 liked into btrfs
Message-ID: <YFHtnGvRH+QlwRN6@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is https://bugs.debian.org/985400

----- Forwarded message from Claudius Heine <ch@denx.de> -----

Dear Maintainer,

I looked into the licenses of the btrfs-progs project and found that the
libbtrfsutils library is licensed under LGPL-3.0-or-later [1]

The `copyright` file does not show this this.

IANAL, but I think since `btrfs` (under GPL-2.0-only [2]) links to `libbtrfsutil`
statically this might cause a license conflict. See [3]. This would be the part
that might require upstream fixing.

regards,
Claudius

[1] https://github.com/kdave/btrfs-progs/blob/master/libbtrfsutil/btrfsutil.h
[2] https://github.com/kdave/btrfs-progs/blob/master/btrfs.c
[3] http://gplv3.fsf.org/dd3-faq#gpl-compat-matrix
