Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2104B10A973
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 05:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK0EoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 23:44:10 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48374 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfK0EoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 23:44:10 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 7D8B74F8A7B;
        Tue, 26 Nov 2019 23:37:45 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1iZp5F-0003PZ-2q; Tue, 26 Nov 2019 23:37:45 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs-progs: inspect-internal: document new logical-resolve options and kernel requirements
Date:   Tue, 26 Nov 2019 22:55:09 -0500
Message-Id: <20191127035509.15011-7-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
References: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Document the new options requiring the V2 ioctl and the increased
default buffer size.

Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
---
 Documentation/btrfs-inspect-internal.asciidoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
index 2abf044a..39e41e74 100644
--- a/Documentation/btrfs-inspect-internal.asciidoc
+++ b/Documentation/btrfs-inspect-internal.asciidoc
@@ -125,7 +125,7 @@ at 'path', ie. all hardlinks
 -v::::
 verbose mode, print count of returned paths and ioctl() return value
 
-*logical-resolve* [-Pv] [-s <bufsize>] <logical> <path>::
+*logical-resolve* [-Pvo] [-s <bufsize>] <logical> <path>::
 (needs root privileges)
 +
 resolve paths to all files at given 'logical' address in the linear filesystem space
@@ -136,8 +136,10 @@ resolve paths to all files at given 'logical' address in the linear filesystem s
 skip the path resolving and print the inodes instead
 -v::::
 verbose mode, print count of returned paths and all ioctl() return values
+-o::::
+ignore offsets, find all references to an extent instead of a single block.  Requires kernel support for the V2 ioctl.
 -s <bufsize>::::
-set internal buffer for storing the file names to 'bufsize', default is 4096, maximum 64k
+set internal buffer for storing the file names to 'bufsize', default is 64k, maximum 16m.  Buffer sizes over 64K require kernel support for the V2 ioctl.
 
 *min-dev-size* [options] <path>::
 (needs root privileges)
-- 
2.20.1

