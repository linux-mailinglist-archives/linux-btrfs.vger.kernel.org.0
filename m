Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98080EA7D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 00:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfJ3Xet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 19:34:49 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:44248 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJ3Xes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 19:34:48 -0400
Received: by mail-qk1-f175.google.com with SMTP id m16so4490323qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/N9E7ULsRydeKAv0sRp5OU/NL2F6LtxCx93MmNsRpmo=;
        b=geiDVIWDTVNu6Bs+CgOYPL/ZiD5hGOSqiiDcTmp5l3yDbUPF7rCiTwB1U4VpvMdg71
         RBTainSfbBICTo2PuYrJi1xTKKErLRymxDeW9s2fo77eIVhQdfdeUmjW8Vz9jj86y8I4
         97wD+eQXBV6S/m5886MdpxFoi/8vVWvbLhOBiMqT68mFI+JKZC3po0/PeiEjkigWyfWi
         FUcWmoKYGHUvjQj8lPt7I+VGE99cCvOxhWw9Y5mBPWbaB3cTKZEV6va9Ma39plL/v5yX
         55sedGewwcYcR2U+F9TgQ6Hmnzts6f0GgKD5mxeVNPUZIjUNjKqEZHfDyi1GeN6/bV3+
         dpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/N9E7ULsRydeKAv0sRp5OU/NL2F6LtxCx93MmNsRpmo=;
        b=tqtRzAWnfA4qsnw9rl6CXneSSwjCB+fMGawWHXIVRCjyznKV4j2V+zLAL494aIBOJS
         SkBgGJkIOuFP+dGU98tCcHTWChZbvisgKhC70+496mxc6cxe80bdAbMG7f2R3KgJUGxh
         0mVOLmVvoFlBjGgACUGvafqF87M5l4W2cWw7zqPZOJhb0E93sw7DT7sgZPWefRhn1q7F
         K2W+vRHqJyb2EwlkJHXJwbMyEfVEWl0HD/Pp/XJZV7Bk0jrVDJ3la/wJHwMpCXPpElhN
         +ITw2uXAtdmR0M8LBxRZ2f905U1v1l2pev5x1M+k2jUF6T34HJ5CC99U8MOaNHXIwNOu
         f4tg==
X-Gm-Message-State: APjAAAUAgSFvgkgyxgNC+TgxtHDrAI69KaBVYxMa1tmFVAXaTlT7ZLKM
        LdnQPwK5Sca4J3frbkl4Jm4=
X-Google-Smtp-Source: APXvYqzsos5Nk0i5V8LIU8UJflysq5XvDXPcWDCxfuiuy4V64+VMqmPSNPt75zQ456/ss6ou4bDyQQ==
X-Received: by 2002:ae9:f204:: with SMTP id m4mr2530943qkg.300.1572478486198;
        Wed, 30 Oct 2019 16:34:46 -0700 (PDT)
Received: from localhost.localdomain (179.187.204.103.dynamic.adsl.gvt.net.br. [179.187.204.103])
        by smtp.gmail.com with ESMTPSA id c185sm820317qkf.122.2019.10.30.16.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 16:34:45 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com,
        anand.jain@oracle.com
Subject: [PATCH btrfs-progs 1/2] btrfs-progs: balance: Don't set stderr to /dev/null on balance_start
Date:   Wed, 30 Oct 2019 20:36:40 -0300
Message-Id: <20191030233641.30123-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030233641.30123-1-marcos.souza.org@gmail.com>
References: <20191030233641.30123-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Remove the close/open calls in order to receive the error messages when
starting balance in the background.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/balance.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 32830002..f0394a2e 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -659,10 +659,8 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 				i = chdir("/");
 				close(0);
 				close(1);
-				close(2);
 				open("/dev/null", O_RDONLY);
 				open("/dev/null", O_WRONLY);
-				open("/dev/null", O_WRONLY);
 				break;
 			default:
 				exit(0);
-- 
2.23.0

