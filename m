Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086C736FB67
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhD3N0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 09:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhD3N0M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 09:26:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5306161474;
        Fri, 30 Apr 2021 13:25:20 +0000 (UTC)
Date:   Fri, 30 Apr 2021 15:25:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Aleksa Sarai <cyphar@cyphar.com>
Subject: Supporting idmapped mounts
Message-ID: <20210430132517.ef7gvr7e5n5wdn33@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey everyone,

Userspace seems to already be catching up with idmapped mount support.
Systemd has started making use of it in their container manager and is
in the process of expanding useage throughout their codebase (cf. [1]).
One of the first requests obviously was "When can we get btrfs"? So I
was thinking about starting to work on patches for btrfs to support
them. Would you be interested in this if we implement it? I'm preparing
the necessary vfs changes currently. I already added a comprehensive
generic test-suite to xfstests which would then also cover btrfs as
well.

Thanks!
Christian

[1]: https://github.com/systemd/systemd/pull/19438#discussion_r622807165
