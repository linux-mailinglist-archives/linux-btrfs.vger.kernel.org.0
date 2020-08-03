Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FC23AE18
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 22:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHCU3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 16:29:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCU3W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 16:29:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DFA0AC94
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 20:29:35 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: Enumerate and export exclusive operations
Date:   Mon,  3 Aug 2020 15:29:09 -0500
Message-Id: <20200803202913.15913-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series enumerates the exlcusive operation currently being
perfomed by the current filesystem and exports it in the sys filesytem
at /sys/fs/btrfs/<fsid>/exclusive_operation.

This would enable our tools to specify precisely which operation is
running on why starting an exclusive operation failed. The series also
adds a sysfs_notify() to alert userspace when the state changes, so
userspace can perform select() on it to get notified of the change.
This would enable us to enqueue a command which will wait for current
exclusive operation to complete before issuing the next exclusive
operation. This has been done synchronously as opposed to a background
process, or else error collection (if any) will become a nightmare.

This third patch further expands the balance information such as the
state and the current statistics. I am hoping that it could be used to
move the logic of guessing/managing the right ioctls out of the kernel
and into the tools.

For backward compatibility, the tools continue working as before if the
sys file is not present.

Changes since v1:
 - Corrected call for btrfs_start_exop() in btrfs_ioctl_dev_replace()
 - Use fsid_str[] instead of fsid[] to save on uuid_parse()



