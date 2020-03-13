Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DF1850D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCMVRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:17:13 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]:37422 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:17:13 -0400
Received: by mail-qv1-f43.google.com with SMTP id n1so1651690qvz.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+5jhaeUCa19lRo06oWYgt2dd0K/0sNUqn25VZFKXGE=;
        b=0oN8XcnzPi2mmKgzHuOF4wmYPa+yP59LVNrr8CHLweBkIKGPxgxRYQfl1R2NmemXOu
         CXhT3JC4N6KxwDiYbaf+pRfGQt4xrHzaYyS2ki8BINqqwKlbEdWjqLOAcC2A49godzyo
         ubQyecqreNZcdr9ADmWy0baQ6wAwilKOtIRhsp8O3szn9uC5YlFOLejbYn5qaLu3YEp0
         Rv3WqQyRgFdx6nq6D/y13F3s3qVTchWZ9io7w50BtiOnYbh6tamadCmZiGKI63ZY74n0
         tHHjFWEsRMlTvd1xuWUwdKGj7/SiL9tvo6z8ZmA6ChhfKS9x1gjj36FfNtNlV5ML9tWI
         jj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+5jhaeUCa19lRo06oWYgt2dd0K/0sNUqn25VZFKXGE=;
        b=IZOOz/wFRbmPdmR+QKqWLZVYahfB53tRM4O7AyZVVugV/2ElwbGYanKS04q5O6T9pH
         Kv1BhenXMo1J4oJMGLFAhElEizAA0/MvqDon2VKBfjA+QaRey33CN3+SGJb97YacbmY0
         zNDCLjSYIcPQwBXRM0ZWXdV/emEDrDC7qiKs8Fy2szaQCqlsMj5YzxF2eMeKAveRyLw1
         ABPsXy3idlb+n7BiMpLumLDevxfDIY7oCe9LpOuVN5IIiAFftONu1Bv7eoqsaj8m4TJm
         iExNYbxSQIxsBs9jvOBKn0iea2RzPURgCzCbO63bGWzR/to0E3BkpLOV+hglk/Gj7rEx
         zKRQ==
X-Gm-Message-State: ANhLgQ1p3WbbruKTuFgw2NAolQBcgXGczAGdQuBF8YoOBxBnvAAHJlCY
        2G5h56ok3EoF8o4kT0mejfeV/xT9m2uf3g==
X-Google-Smtp-Source: ADFU+vvfUgzDv9RYaxlqRjGbrNj6RjXP1MMOVJnL90stZYaXm1vvKWmTAYfAswKAv4FjfCv+Fjoosg==
X-Received: by 2002:a0c:f8d1:: with SMTP id h17mr14549328qvo.19.1584134231559;
        Fri, 13 Mar 2020 14:17:11 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e66sm2596758qkd.129.2020.03.13.14.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:17:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] Relocation and backref resolution fixes
Date:   Fri, 13 Mar 2020 17:17:05 -0400
Message-Id: <20200313211709.148967-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are standalone fixes that came out of my debugging Zygo's problems.  The
first two address a problem with how we handle restarting relocation.
Previously this rarely happened, because if it had people would have complained.
The restart logic was broken in a few subtle ways, and these two patches address
those issues.

The third patch just boggles my mind.  We were recording reloc roots based on
their current bytenr.  This worked fine if we never restarted, but broke if we
had to lookup a ref to a reloc root that we found on the tree.  This is because
that would point at the commit root of the reloc root, but if we had modified
the reloc root we'd no longer be able to find it.

And finally the last one was a weird deadlock that Zygo's insane test rig found,
as he runs the dedup thing while balancing and deleting snapshots, which made
this thing fall out.  Thanks,

Josef

