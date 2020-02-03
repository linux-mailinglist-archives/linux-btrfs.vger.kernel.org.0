Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3F15113C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCUok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:44:40 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:38399 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUok (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:44:40 -0500
Received: by mail-qt1-f174.google.com with SMTP id c24so12595903qtp.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qm8Orx2zffk4BzAzV+xhAEtz4baHODheS21wcgPc9HI=;
        b=X/fEQDua1PnevU3F6nAWp/fUE7/UuXceoZutdgFHX/HaQT161jbOWvS6wa1XNYd58S
         r50IYjCGZ8iEbiUe5nxs8T8YuQK4HMou7s6jkE0nt79XYFhbdkts6EwzMc0o+6DPXITh
         OTvUqmrI/eL8mVXKMdsa7aA6T6bNy1n8LgsZ0oh7lUMSuqEz1p//LIiEJbWvr0IktoBY
         bc0v2FVp5LvUxqu5PbARGIJazTJ2jDwxZmmIVOtypr2nBolB/Fyrxe8wq8Kg1SSAk2ER
         WzilsrqqOMcvTVKmRJHlaEr1IO9SdbhV8XNdlcv9cIE4RaKR93RzCOVh8NxQ/uq6Sx1Z
         mqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qm8Orx2zffk4BzAzV+xhAEtz4baHODheS21wcgPc9HI=;
        b=Vn3yHWjhKx1//Utek52Vtvs+w4QEieWbGomO0bn7ALxfrjlzvD2XrQ5Vc25AQGd2fs
         1Ca2P0B6aIUq0fw4LqNBLVPb/4Y6+dy/VqRkZs962pNetBMNRHSS68kmDxDjk7/rxGIE
         cduG4wnZF0Up1asxA5owzHJ/50PJZY3bWgElf5w37u/5dhTx9yilCLLvP+KNRsLoYXlm
         UgtqMMkwrUdFlT6oDtoqDbetWighwRAM6PSfF9l2/3yQjWoQxXGG9pnmOhcGRI6F7CfB
         CmK4bVDYdiEGFHdpGGabsfVAphM9RkJthnd/VOHf8HNHNUYwiIQGG9y6boutNuwLG4eV
         JhRw==
X-Gm-Message-State: APjAAAUHO7hzya26nS3vnVhoDJUM1BtravsEacodbHkbXe/KWZGF/jLL
        2YrHECIZLbBnOb+fg3VkGxeI3UZEOX6ZbA==
X-Google-Smtp-Source: APXvYqwhWx7OKBv3zqB+6kn134jng3kynTQq0m3oK+Y26UKi3Jd4/EJ3+oywvXLzDWuyvcSqxWL4ig==
X-Received: by 2002:ac8:4d94:: with SMTP id a20mr25683669qtw.66.1580762678902;
        Mon, 03 Feb 2020 12:44:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 199sm10078186qkj.47.2020.02.03.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:44:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Add comments describing how space reservation works
Date:   Mon,  3 Feb 2020 15:44:33 -0500
Message-Id: <20200203204436.517473-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In talking with Nikolay about the data reservation patches it became clear that
there's way more about the space reservation system that exists soley in my head
than I thought.  I've written three big comments on the different sections of
the space reservation system to hopefully help people understand how the system
works generally.  Again this is from my point of view, and since I'm the one who
wrote it I'm not sure where the gaps in peoples understanding is, so if there's
something that is not clear here now is the time to bring it up.  Hopefully this
will make reviewing patches I submit to this system less scary for reviewers.
Thanks,

Josef

