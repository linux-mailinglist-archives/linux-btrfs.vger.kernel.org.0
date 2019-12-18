Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6A125692
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 23:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLRWUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 17:20:34 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35713 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRWUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 17:20:33 -0500
Received: by mail-qk1-f173.google.com with SMTP id z76so3349174qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18GhDXy5ZprlrIn4Sztziky97rAMO43rwHhwsO1H6Yc=;
        b=gEmnyXieokBfuu27femh3HVUWOFa88smrknnU18ORYs6x18wzx8iXhJQ+iwbpyGcgp
         2NQRgr7S4qo5xguyPurQMkJEKVIvqVQDgXRGt0Sui9T2SdQG5vydOI/aQZXMllP5UL05
         WyN+iecwlcwcqSX6Dq6vD75GxFLc8CWIVYhPeMnCLDWC7wOdw9++p7MIcEDStXf4gSr/
         lGhnqkKiR5gHAWMgvzT8Vuk2DLcXA4f8+BrsMqJ8WVCy9En1lNuD5TPdBCaFUUGfvJ2p
         VjneV5qnXuRO7ISoMJ5hvr3jTK9gyGsJX5SfeOH/yQIJP3ULKzZuxZH0DS6tPWDk716Y
         XaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18GhDXy5ZprlrIn4Sztziky97rAMO43rwHhwsO1H6Yc=;
        b=eJoOiY11NFqR5cNTedO4KfEKj9bs6h2vuThXJS6hecKkxOdzXWDO62TRKbjc0PGxAd
         384uuHpLh8zw27HG/PqE2kTZVLE6E/TP54ySklI3Ac3hH+yK+hd56URxPML9TtjLsdgd
         sAUTKA8283+K33HMaJlRd6xCrIC6QGDNQOBZO8AkhO1sKxJw5OKjfHtW8A5LLl9z6M0A
         seaFS2mj1ZyGyFhs67tfTZwIVLu4XymVRsddMCpABXe1i0HFLcA4H5LXPDDUNwglRc5h
         8pOROtm5mT/yUsSADV73cHggvg8D/k9pk51cAMH3dxpWvOE5Na6ohVxkHMiZFo15i6uX
         /c3w==
X-Gm-Message-State: APjAAAVn9v8bAut3OeSf2F+C0qwAi1FdASizVZn/xUPnEcRAunJxgii6
        xSuiKi6d8eLMmErk2hFW5F47KBdyY6Tq6w==
X-Google-Smtp-Source: APXvYqzlQghnVU+gViFdAZO18pXFsnWot26fg7K+iLYbYC+eEkJQ6ATdnwRktzL5EGadtyzf6Ntyqg==
X-Received: by 2002:a37:9f94:: with SMTP id i142mr5214926qke.244.1576707631720;
        Wed, 18 Dec 2019 14:20:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r41sm1230403qtc.6.2019.12.18.14.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:20:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Fix transaction abort when rmdir'ing a subvol
Date:   Wed, 18 Dec 2019 17:20:26 -0500
Message-Id: <20191218222029.49178-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/004 with my new fsstress was sometimes failing with a transaction abort
while trying to remove a root ref.  This turned out to be because of how we stub
out subvol links in snapshot'ed subvolumes.  The specific steps are detailed in
"btrfs: fix invalid removal of root ref", but they are relatively
straightforward.  A xfstest is forthcoming, I want to get an overnight run of
fsstress with these patches in place to make sure there are no other
rename+removal shenanigans left.  With these patches we pass my basic test and
no longer abort the transaction.  Thanks,

Josef

