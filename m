Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4464334321F
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 12:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCULeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCULdu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 07:33:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA3C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 04:33:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e14so5095962plj.2
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=mkk7Wlcm8WSBg4OMmbWANQW2qDpymwuHExfB5bAnSDs=;
        b=Nx1ism3TDeZmbvpvUg2OrzwH+tiynsgegcOAlykUUF5QJLmGHhvspurNOS8tTei/tk
         4fK2ZUMloP/93e047fT+qg+gV6rPaYveCV6GpyIJBkfQYgXi0yEAL//jiswl8qujhmxF
         zYnm2noHV3nHLDauaU0b0V8YvHvFKBa2pwfejd4OC+kFSvuS/HdPZ2mfCGYe4L/5PUxF
         kcRcD6C4NV2WsXzwdfwWkeZm7t348ZpmsTOuIHAFB8GFQZJmvl2qbgKJ5FoT39fcPZpX
         2IEymym5jHdw14u251l9XZlcaaGaNfN+Be1xY8qTlujJ/uJ7vmQ9a20YU1FMeSOK+2Kj
         cAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=mkk7Wlcm8WSBg4OMmbWANQW2qDpymwuHExfB5bAnSDs=;
        b=fI1TaZg867NRtTuiB5NqtAJhlBUqn/7cjpcU+vDSzmlbqXTc+smr3f/XpqmuKY8IwO
         CvC8o4QFF91LjyFVq3deWb3DklOv9lt7XgWPKR7bM+GRpYik+QO1UWcMoamAwi7ACUi6
         6Xc2EZPyuqD17cMD38HNdjF/B9OlfHmHiMy4TVKN03gQlDPHYuQIEkqdHeUAqQZ/mY68
         F9QitGjJMgQadQf3RTu8gVjvSIrMgcxHOQBF7aj4wZERDE1BNxD6UrHg/fpWXArQkuNQ
         aW8AQd+sabSTglUu98WGSvEBf9QP/0/IXjX579xgPnfTRKKUymXoAS37dCs5PNwUnX4z
         qkpA==
X-Gm-Message-State: AOAM532/5lP3uzzSSfWC/VRpLflW9zDr+ZGfV75SidCfy4OW4wqETnZW
        agYMUg3ihlMxrwBzc0V8M2GtVC3og4IrKw==
X-Google-Smtp-Source: ABdhPJwxgT34cpB1KF1JFOtNAcwYumFQyToCtOMxTd+7mf75bRZLxFc/nbhEniXlPGFp4j46yPCR7w==
X-Received: by 2002:a17:902:169:b029:e6:d370:fa34 with SMTP id 96-20020a1709020169b02900e6d370fa34mr14078778plb.68.1616326429408;
        Sun, 21 Mar 2021 04:33:49 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t18sm11251796pfq.147.2021.03.21.04.33.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 04:33:49 -0700 (PDT)
Date:   Sun, 21 Mar 2021 11:33:42 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Simple question for comment in btrfs-progs qgroup code
Message-ID: <20210321113342.GA3319@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I see an comment in qgroup cmds below.

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 2da83ffd..a71089e9 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -84,6 +84,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct
*cmd, int assign,
	/*
	* FIXME src should accept subvol path
	*/

This comment is little confusing for me. src was parsed with
parse_qgroupid() and it also accepts subvol path. is it outdated
comment? or src should accept only lowest level of qgroup?

Thanks,
Sidong
