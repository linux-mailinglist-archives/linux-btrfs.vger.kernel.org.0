Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F18342CAE
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCTMCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 08:02:32 -0400
Received: from smtp26.services.sfr.fr ([93.17.128.192]:46506 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCTMCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 08:02:15 -0400
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by msfrf2606.sfr.fr (SMTP Server) with ESMTPS id 801E21C003140
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 10:27:28 +0100 (CET)
X-mail-filterd: 1.0.0
X-sfr-mailing: LEGIT
X-sfr-spamrating: 40
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=neuf.fr; s=202006;
 t=1616232448; h=From:To:Subject:Date; bh=Y1Q1rKZbY2sV8waQ3wnMxKDYaTXbj7LtXjn
  zS9QE0as=; b=DN6xmwlvHVspUFqfQoXQL46nHP6wbcqXGMwD9c67bI34CKQ5/TFDem5xVIXUqs+
  qsCBYQmsfkqLtD6dsQfJTSmGpRd3kBXKywaCe016wcKnFYjXWNlhTNwM4P6egOAUiYK6xyZ+huGf
  +EwseKIgHg21JmglQcn3XrlwIgZcj1ctJ+2zUhoRt+FIEThsQy9hPsYOiyIROAfDh954a1oBfRgR
  ZGPbtCB/WBT+nYU1uDb4n0splXSEBMUll6JZ7YwEpL2IP6LnpMRB2GJR1nowtINKoTvfO7p0K2UG
  kuLKbxfMQM/wjvjQVaoWwsO+MbJUyqjIyRC+jrSX7OMlZzIiyKw==;
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        by msfrf2606.sfr.fr (SMTP Server) with ESMTP id 6A5C31C001036
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 10:27:28 +0100 (CET)
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pierre.labastie@neuf.fr)
        by msfrf2606.sfr.fr (SMTP Server) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 10:27:28 +0100 (CET)
Authentication-Results: sfr.fr; auth=pass (PLAIN) smtp.auth=pierre.labastie@neuf.fr
Received: from pierre by neuf.fr with local (Exim 4.94)
        (envelope-from <pierre@neuf.fr>)
        id 1lNXtI-0006Qi-1D
        for linux-btrfs@vger.kernel.org; Sat, 20 Mar 2021 10:27:28 +0100
From:   pierre.labastie@neuf.fr
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/1] btrfs-progs: build system - do not use AC_DEFINE twice
Date:   Sat, 20 Mar 2021 10:27:27 +0100
Message-Id: <20210320092728.24673-1-pierre.labastie@neuf.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Pierre Labastie <pierre.labastie@neuf.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Pierre Labastie <pierre.labastie@neuf.fr>

Autoheader uses the AC_DEFINE macros (and a few others) to populate
the config.h.in file. The autotools documentation does not tell
what happens if AC_DEFINE is used twice for the same identifier.

This patch prevents using AC_DEFINE twice for
HAVE_OWN_FIEMAP_EXTENT_DEFINE, preserving the logic (using the
fact that an undefined identifier in a preprocessor directive is
taken as zero).

Note that I doubt this check is needed in configure:
HAVE_OWN_FIEMAP_EXTENT_DEFINE is used only once in cmds/filesystem-du.c
in:
#if !defined(FIEMAP_EXTENT_SHARED) && (HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE == 1)
but HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE is set to 1 by configure only if
FIEMAP_EXTENT_SHARED is not defined in the kernel headers.

If you agree, I'll send a patch to completely remove this check.

Pierre Labastie (1):
  btrfs-progs: build system - do not use AC_DEFINE twice

 configure.ac | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.30.2

