Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59285289923
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbgJIUJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391547AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFAC0613B2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:38 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id 13so5340779qvc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIK7tVifUGgk58DzxwFwK37ndYe6FMYgsBUKVRozxME=;
        b=UFyd8qUDjO/XMXTXKNMNdwSvjuFRCHldEebqRLU3u/sccSI3GSvqF4BGQRZ9ICoFqH
         Ra2OFBsbddP1GrtAR9YZxNHaMyLg2dWaw5MpG5oAdw7T+TUReqgVG3RrA2xKaqjWK50Z
         xqi9Wea9BYSN7wrXeDwIwbigSteZree+75scqdeK58yMZW2XDfU+TixuRk3Siig2gyUK
         qnsXhJY0g2MwXwfnYoMuYAo9QH8zpUb5ZnORFHnj45x2EhWzcH5Tg8w5Z8q5YwMgqSgf
         KLtMnQu8E6YB3ppikL1X1zlr5TaMeugQgLe3egp4DlWTtZun7QCcugeZaAT3JYNPcTrE
         hoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIK7tVifUGgk58DzxwFwK37ndYe6FMYgsBUKVRozxME=;
        b=ZvQb2ufnxt59lOJR/RtopzrB9VgpifeQdbM/RmIEiFfS2IMwbnuCwlMwj/SfvmOkTG
         BKN/ODgyYM3xUTv+n7fVKA5Jgc3z0it8hQV13Q2vjDphZjAXuNPXdmeFLu8d1/mEUZk6
         JTisGJM5UeV5cwCYmcV/21XGTLEzvrz0Mb6Qmjc/19UTsWYlSGMH7RMpN6wKyqAUxBiC
         Ic/yk8XPP7G2S+ysto4XoTz7xCexQllT/sPqMYBC7085h5k9nDC3q9g3uatuSmU4xD2V
         PGROkbmFR0jas3cuIoLZHhrJ16SL0dwWtU00jJsTVL6TqhR/BNnFm+wm3KCMpLylJTDB
         MTUA==
X-Gm-Message-State: AOAM531pY3pyQVxQlbBn25pYbqFYrADm7+84zxixHi+6TFAplK00jb+w
        hUjxHSzMKR/poeOzhPSD3lN6o/46zIVdnVzI
X-Google-Smtp-Source: ABdhPJz82NYgkHMXLH+jXfyzJb9/MiGyLSmCcDpsl48NC9bjheTvMO5cg7idimwsLeunCbyQIrHw9g==
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr14698877qvv.50.1602274057016;
        Fri, 09 Oct 2020 13:07:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r190sm7192305qkf.101.2020.10.09.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 8/8] btrfs: introduce rescue=all
Date:   Fri,  9 Oct 2020 16:07:20 -0400
Message-Id: <168dc328f4643647a9d9302a7adc7a259233fe7d.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have the building blocks for some better recovery options
with corrupted file systems, add a rescue=all option to enable all of
the relevant rescue options.  This will allow distro's to simply default
to rescue=all for the "oh dear lord the world's on fire" recovery
without needing to know all the different options that we have and may
add in the future.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 11 +++++++++++
 fs/btrfs/sysfs.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index becb61204eb5..fb468bab1114 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -362,6 +362,7 @@ enum {
 	Opt_nologreplay,
 	Opt_ignorebadroots,
 	Opt_ignoredatacsums,
+	Opt_all,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -461,6 +462,7 @@ static const match_table_t rescue_tokens = {
 	{Opt_ignorebadroots, "ibadroots"},
 	{Opt_ignoredatacsums, "ignoredatacsums"},
 	{Opt_ignoredatacsums, "idatacsums"},
+	{Opt_all, "all"},
 	{Opt_err, NULL},
 };
 
@@ -512,6 +514,15 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, IGNOREDATACSUMS,
 					   "ignoring data csums");
 			break;
+		case Opt_all:
+			btrfs_info(info, "enabling all of the rescue options");
+			btrfs_set_and_info(info, IGNOREDATACSUMS,
+					   "ignoring data csums");
+			btrfs_set_and_info(info, IGNOREBADROOTS,
+					   "ignoring bad roots");
+			btrfs_set_and_info(info, NOLOGREPLAY,
+					   "disabling log replay at mount time");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8edc51f3d894..862c954b7f69 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -334,6 +334,7 @@ static const char *rescue_opts[] = {
 	"nologreplay",
 	"ignorebadroots",
 	"ignoredatacsums",
+	"all",
 };
 
 static ssize_t supported_rescue_options_show(struct kobject *kobj,
-- 
2.26.2

