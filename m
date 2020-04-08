Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A01A22C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgDHNPd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 09:15:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39981 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHNPc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Apr 2020 09:15:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so7756114wrt.7
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Apr 2020 06:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JOSl5eYZlfMo8mpeMGlcc623ymS2nHMK+RAOQKnLx+U=;
        b=MME9xI9pYRA4gpYBEHBVbE6By3gTutTrDPWf/rSFlLLp0W5dCtBVzD5dxFA5NroL6q
         YDOlMSKqJMLmiXKrH9UG02ycMiJoX5BwTB0N9q1FBM91f701cWFEe0U86+TP5jTvcDhi
         PN2seNOJNc+DTiiLNSzupaDzGW0LOf+xUQkX5BiClOJ7Q9dzgEXzx/L5qNrJKpnSAWyl
         PaGF6YRpFEhoFo2t4CkM8QX2yI6VJ3GjHzcynyDqW1uV2sgBkAjX5SQNjfN8v1PXoHTT
         lH8NQ1GWol6L52EpdhlFhutUbfRE3KWyu4pZnV9dMzClVQm4NI2HLAV5MHFBzjURU8jA
         jvsg==
X-Gm-Message-State: AGi0PuabdwOi96TvOCmZte5DMyZ/A4fZ9MLtfbM8Ahn+6d6oPSrl5la0
        sHIsd0QhpWI4z8pMy7xNNlWq0l+Y
X-Google-Smtp-Source: APiQypJvvgPSW8OAnG1YBbPN6X5Mf2p+6P9/oMePiDyfHUvNdMp33ojNMsc/ZE+EFJe6M1BIjauWIA==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr8630901wrq.345.1586351730445;
        Wed, 08 Apr 2020 06:15:30 -0700 (PDT)
Received: from jkm (79-98-75-217.sys-data.com. [79.98.75.217])
        by smtp.gmail.com with ESMTPSA id j31sm30248234wre.36.2020.04.08.06.15.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:15:29 -0700 (PDT)
Date:   Wed, 8 Apr 2020 15:15:28 +0200
From:   Petr Janecek <janecek@ucw.cz>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 3/3] btrfs-progs: add '--background' option for
 '--full-balance'
Message-ID: <20200408131527.GD19101@jkm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the '--background' option to 'btrfs balance --full-balance'
(without the 'start').
---
 cmds/balance.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 3d4deb27..506016ba 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -939,11 +939,38 @@ static DEFINE_SIMPLE_COMMAND(balance_status, "status");
 static int cmd_balance_full(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	struct btrfs_ioctl_balance_args args;
+	unsigned start_flags = BALANCE_START_NOWARN;
 
 	memset(&args, 0, sizeof(args));
 	args.flags |= BTRFS_BALANCE_TYPE_MASK;
 
-	return do_balance(argv[1], &args, BALANCE_START_NOWARN);
+	optind = 0;
+	while (1) {
+		enum { GETOPT_VAL_BACKGROUND = 256 };
+		static const struct option longopts[] = {
+			{ "background", no_argument, NULL,
+				GETOPT_VAL_BACKGROUND },
+			{ "bg", no_argument, NULL, GETOPT_VAL_BACKGROUND },
+			{ NULL, 0, NULL, 0 }
+		};
+
+		int opt = getopt_long(argc, argv, "", longopts, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case GETOPT_VAL_BACKGROUND:
+			start_flags |= BALANCE_START_BACKGROUND;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+
+	if (check_argc_exact(argc - optind, 1))
+		return 1;
+
+	return do_balance(argv[optind], &args, start_flags);
 }
 static DEFINE_COMMAND(balance_full, "--full-balance", cmd_balance_full,
 		      NULL, NULL, CMD_HIDDEN);
-- 
2.26.0

