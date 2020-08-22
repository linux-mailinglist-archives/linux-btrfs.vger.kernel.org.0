Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD824E645
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Aug 2020 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHVIJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Aug 2020 04:09:51 -0400
Received: from mail.bhatia.eu ([77.244.245.211]:47972 "EHLO mail.bhatia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgHVIJv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:51 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Aug 2020 04:09:50 EDT
Received: from webmail.bhatia.eu (www.bhatia.eu [77.244.245.212])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.bhatia.eu (Postfix) with ESMTPSA id 88762160085;
        Sat, 22 Aug 2020 10:03:46 +0200 (CEST)
Received: from 2001:470:981c:0:29e0:e101:e188:f770
 via [172.17.0.1]
 by wm.bhatia.eu
 with HTTP (HTTP/1.0 POST); Sat, 22 Aug 2020 10:03:46 +0200
MIME-Version: 1.0
Date:   Sat, 22 Aug 2020 10:03:46 +0200
From:   Raoul Bhatia <raoul@bhatia.at>
To:     linux-btrfs@vger.kernel.org
Cc:     Raoul Bhatia <raoul@bhatia.at>
Subject: [PATCH] btrfs-progs: restore: Redirect looping prompt to stderr
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <20200822080130.5910-1-raoul@bhatia.at>
X-Sender: raoul@bhatia.at
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 From: Raoul Bhatia <raoul@bhatia.at>

When initiating a btrfs restore, i.e. in verbose mode, it might be
helpful to redirect stdout to a log file.  stdout redirection to a file
is usually fully buffered, so the looping prompt is likely not flushed
to the log file for the user to notice.

Thus, btrfs restore might seem to hang, while it is actually waiting for
a user interaction.

To improve the user experience, send the looping prompt to (unbuffered)
stderr.

Signed-off-by: Raoul Bhatia <raoul@bhatia.at>
---
  cmds/restore.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 858ac6ea..d7df383c 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -477,8 +477,8 @@ static enum loop_response ask_to_continue(const char 
*file)
  	char buf[16];
  	char *ret;

-	printf("We seem to be looping a lot on %s, do you want to keep going "
-	       "on ? (y/N/a): ", file);
+	fprintf(stderr, "We seem to be looping a lot on %s, "
+               "do you want to keep going on ? (y/N/a): ", file);
  again:
  	ret = fgets(buf, 16, stdin);
  	if (!ret || *ret == '\n' || tolower(*ret) == 'n')
-- 
2.11.0
