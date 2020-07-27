Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7422FBC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 00:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgG0WE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 18:04:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:58034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0WE5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 18:04:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79505AB7A
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 22:05:06 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: Enumerate and export exclusive operations
Date:   Mon, 27 Jul 2020 17:04:48 -0500
Message-Id: <20200727220451.30680-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
and into the tools. However, if you feel that it is inappropriate, the
patch can be ignored.

For backward compatibility, the tools ignore if the sys file is not
present. Would you prefer an error if "--enqueue" option is issued on an
older kernel?

Regards,

-- 
Goldwyn


