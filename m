Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17967132C49
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAGQzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:55:51 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:35827 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgAGQzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 11:55:51 -0500
Received: by mail-qt1-f170.google.com with SMTP id e12so348746qto.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpXnwPXyr8tXDiy7kEFIiafSbEdLAqdCUWAx8vDbwjk=;
        b=OcqkYiU1R3O5YYUg7nlD6aoxU+N/bjzocElv++2M/NfqO3D2e6tDD3SgR7RQEO8yeR
         bgmiKSD0duAgsCtjTOcSiHAOprl2xFbfzdW2+/fhztBVQP/YvM0go+VlaOeKLBnfmPuh
         x//ulTisG6PE3RdPhkirr7fS+FhVEdpuBuSkcix1ywKi1ZBw5akXX7Is3vauvpKULlkA
         wTkX2y8h3zRwxpcvDGFoftMOpzadir5ljFYczN4vlEArpWmZZcDUR41bM8L8qnlToCcU
         RefatCQQAw0f34GQPRg+lA2Drb9e9fSSpBoTPwc5zY5P1s1reGc2tFvZ0qK8I5Gehqtz
         rEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpXnwPXyr8tXDiy7kEFIiafSbEdLAqdCUWAx8vDbwjk=;
        b=mAYT3GZ3nrOVKoxtcBmKwCOS60/xLyJ/j9O/8uEIOAj3Wv5QtBJORnvMt7uinb8WQU
         XVOb683fTvAaLA7LvZz5y+Y3G6WnkFEjBUPI447m0+L5xA5hpSNDq9Dk2nUpzy9MRn4t
         jrwEhCpKuOPZQGqbdGvyjaUb88Jv7ZqgVpoTlukN/icRgeGRTYzgdhZozJxrY5rB79Eo
         F1hnQj48wYrbqKPm5Ptd5xxau+ZeGlqEIZ41P92TSvPTMXsz4uvZGpJ2wgb2yyZNJO1m
         3Fv4J2Q9Ixk5tlCyZLVjH4KQ+EwtgUzgqPIOlkmLo/8SLPWy25BSjUmyJEYCDZaBRPRR
         CgUQ==
X-Gm-Message-State: APjAAAULxuWWqJcRHJmJfKIOQEQrVyAgc+bPAAg+PGTCNDGZgT7h8HJj
        gaauYxB7wV8cWmI/aOKbnDt6qQ==
X-Google-Smtp-Source: APXvYqznW1xDrFgzzvGpdCMkFDfCDg48uFe7Li7qGGeh90gTgl6RVDd2Ln7XaUfl8V2avbdpQOwpKQ==
X-Received: by 2002:aed:256f:: with SMTP id w44mr74397881qtc.331.1578416149856;
        Tue, 07 Jan 2020 08:55:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r6sm124924qtm.63.2020.01.07.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:55:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] Some fsx improvements
Date:   Tue,  7 Jan 2020 11:55:39 -0500
Message-Id: <20200107165542.70108-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was fixing a i_size problem in btrfs and I used fsx to reproduce the issue,
but I needed to make a few changes to actually reproduce the problem.  The
individual explanations are in the patch changelogs themselves.  One thing that
may trip people up is that I've done system("echo 3 > /proc/sys/vm/drop_caches")
for dropping caches, but this is consistent with several other tools we have in
fstests.  These are all small and straightforward fixes, and don't really affect
any of the other tests.  The only exception is generic/521 which is a soak test,
I figure we want that thing to cover as much ground as possible, so enabling the
close+open operation is desired there.  Thanks,

Josef

