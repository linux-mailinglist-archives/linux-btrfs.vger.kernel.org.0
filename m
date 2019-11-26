Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9D10A205
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfKZQ0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:26:01 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:40397 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKZQ0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:26:01 -0500
Received: by mail-qt1-f169.google.com with SMTP id z22so1180110qto.7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmDI6lfnoLnN0pBWOc5J9y268VITkDbfdatVaOdD4bU=;
        b=Rv3fIUMIXQT+9J8zJJ8cPAfaj+2NWyiHYR8uuUkYFoa8uEDqpuNwuOrDxBo525sfH6
         EiAoFOeCzjVOpVaZT0sPMyheWJyTdhHHLTFnfpcmMlLJHKPcM3akOcPLzLq8HcJlIALL
         kSoBTAfcJBPstbr0mWGqxEcATXURkpLKQiDg3wF0O5cag+AqbhO2rHb/oTTnbEs8SXCs
         Y4pmjbAMTy7y5Jw4MMZU3Dx4Sy6toRg3zoZfoqo8IV+Z34lARPM/7BKMBRuj9KDGMkJt
         /7XbXtqdPMBRDzfC+dwM0TPIzmFZ+7CGuLYOmR1p7hPVizXxC4dlX9TvxE2GnD4JYlYu
         BYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmDI6lfnoLnN0pBWOc5J9y268VITkDbfdatVaOdD4bU=;
        b=mF3hX7WHceHXWP6OTQe3u8kxAIVij3LuBucKADouSvqGIekaPIhKIYtyZS/WXLDRVE
         7oygDQlZ4dui5ojMJAZbWH1f7ROEHc4Nw4ld5Tjej9paN+dbBkl+miO3e2JNtRg6yY3s
         RUDNPIzua8Tz9UsBBxK63UFogKAlHsQiHfPRBq3qr+LRChzBfVUfI/NeIZkeiejaFoVa
         aj7+b8S5D8R3tq1EG42znwp54ErediEp1WphN3qkogCtzCgwms7umKN6+ths8aCJcBfT
         j/WmgfdIabKA6282gAlFYUVH+2o62uwrW/3EjDbjd7hNLDegnzGBzuH6BPhmUpYKgj9s
         /UTA==
X-Gm-Message-State: APjAAAUzMIRcTdY+P3qtAUpZExIV1BVQmOobYJw0DpqLqvUuf7KDXKUv
        ysBGfrEekU561XSudF9lKDt4hFcYo0cMSw==
X-Google-Smtp-Source: APXvYqwCWYLL90ZGm3aUuh+xd5skMyXLsEfItpDOYyAsdrdREH01TDgK5bLiCT9SvWvo9xR2Xk5SSQ==
X-Received: by 2002:ac8:6644:: with SMTP id j4mr33525325qtp.213.1574785560062;
        Tue, 26 Nov 2019 08:26:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d6sm6081707qtn.16.2019.11.26.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:25:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 0/4][v2] clean up how we mark block groups read only
Date:   Tue, 26 Nov 2019 11:25:52 -0500
Message-Id: <20191126162556.150483-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Fixed the typo where I wasn't checking against total_bytes.
- Added the force check to the read only list addition check at the top.
- Fixed the comment stating that sinfo_used + num_bytes should be <=
  total_bytes, that's not the case at all.
- Added the various reviewed-by's.

Original message below.

-------------------------------
Qu has been looking into ENOSPC during relocation and noticed some weirdness
with inc_block_group_ro.  The problem is this code hasn't changed to keep up
with the rest of the reservation system.  It still assumes that the amount of
space used will always be less than the total space for the space info, which
hasn't been true for years since I introduced overcommitting.  This logic is
correct for DATA, but not for METADATA or SYSTEM.

The first few patches are just cleanups, and can probably be taken as is.  The
final patch is the real meat of the problem to address Qu's issues.  This is an
RFC because I'm elbow deep in another problem and haven't tested this beyond
compile testing, but I think it'll work.  Once I've gotten a chance to test it
and Qu has tested it I'll update the list if it's good to go as is, or send a V2
with any changes.  Thanks,

Josef

