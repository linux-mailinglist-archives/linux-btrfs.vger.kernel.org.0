Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2EF77E51
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2019 08:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfG1Gs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jul 2019 02:48:29 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:43776 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfG1Gs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jul 2019 02:48:29 -0400
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hrcym-0002yC-2P; Sun, 28 Jul 2019 08:48:25 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1hrcyl-0004AX-Pl; Sun, 28 Jul 2019 08:48:23 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sun, 28 Jul 2019 08:47:36 +0200
Message-Id: <20190728064735.15979-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618130746.GM19057@twin.jikos.cz>
References: <20190618130746.GM19057@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en
Subject: [PATCH] btrfs-progs: check: fix option parsing for -E
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On Mon, Jun 17, 2019 at 06:45:48PM +0200, Adam Borowski wrote:
> > It has a mandatory argument, thus it always crashed.
>
> Applied, thanks.

Seems like this has fallen through the cracks -- could you please re-apply?

--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--8x--

It has a mandatory argument, thus it always crashed.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 0cc6fdba..866da8dc 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9867,7 +9867,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "as:br:pEQ", long_options, NULL);
+		c = getopt_long(argc, argv, "as:br:pE:Q", long_options, NULL);
 		if (c < 0)
 			break;
 		switch(c) {
-- 
2.22.0

