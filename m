Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99881176321
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgCBSsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:03 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:40980 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgCBSsC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:02 -0500
Received: by mail-qt1-f178.google.com with SMTP id l21so763413qtr.8
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyMMPyKkFjciX+fN4LzaYyYEwCCtHP598Z9VBvPwKYY=;
        b=TvlTq5AzXJLBXedN4wpEHPBhSdqc0vukhdrdgTjnMDOWXFBSSdGfTHK1HyXFuZQKkp
         mvlzvYrAPtH7iF0wMa9PoHqA49ar5cvx131VR9f0XYtoQy1c19DnNRC1xwXxR9uVu15o
         8anL77iZKk6ajJDLj5segpATh1uRNxjK/eaE6MtXA/UWtXSi9m8EnTMgpY6YIWEdLuGE
         GHe6BFvIF0QXdYKoQ5tqSiGKGZK/InBCOTX/F0DvlzbCIFG6j8u//v2B19oDbe5pEY9Z
         H6R0oSp64Ldq9wuqDVmM0VOv2oHIm/2+JyPcPjvXGfA37uLL2erDCeX96WlolyAtSimg
         yzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyMMPyKkFjciX+fN4LzaYyYEwCCtHP598Z9VBvPwKYY=;
        b=tio0zh8aqREMN93ND2hXQAmPI1USTL+F2HkUidzfB/yFqnRtzvHwORunol65CSK2oU
         byJ1sNxyYs9cGR1Hz4Wb+l/pmlNvXhblqKbV7ZF+BkdezU3EXsL0AmdvbQayimgSkhWM
         baUj7V4DI1T+qEQ9ttz0izv+AfpbM19kR6TzSaaVHHyFmtKAS09xTjJ9g4uK3Ughhvs2
         G+KN8IFllnmWHXkPo08ohAPxTZPUIY63WMNouYMmnL/8wALYLxVdgSjMm4ZcIshGKG40
         64ItND2n1vZtjkW6AYj6WCGZsnfB4bxDhVn8Vy4vLD3nETSuTu3JT5I3ornpqW5/iwbq
         +gBQ==
X-Gm-Message-State: ANhLgQ27OP8n1c1EjARfFfz9QP0Cri3yJnth8ETRLO8eoHIJbiWSVXQM
        wNAqDAE8HIwdw1n7ou6/DVeucA==
X-Google-Smtp-Source: ADFU+vu3KNLsuhDuvs2ORfIOymliXQJ3p9lxc2RQ9tXvvOt/ug7RziYAUa2MjNs9r1O3clKTTp04/Q==
X-Received: by 2002:ac8:4993:: with SMTP id f19mr1035720qtq.305.1583174880399;
        Mon, 02 Mar 2020 10:48:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o3sm10396988qkk.87.2020.03.02.10.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:47:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] relocation error handling fixes
Date:   Mon,  2 Mar 2020 13:47:50 -0500
Message-Id: <20200302184757.44176-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My root ref patches have uncovered weird failures in some of our xfstests,
particularly those that do balance while having errors.

I ran relocation through my eio-stress bpf script and loads of things fell out,
these are the fixes required to make the stress test run to completion.

Dave this is just based on my master, I assume it'll apply cleanly to what you
have, but if not let me know which branch you want me to rebase onto to get it
to work right.

Most of these are straightforward, the only tricky/subtle one is 7/7, and I've
added a lot of explanation there around my reasoning.  6/7 is also a little bit
more complicated as it changes the rules slightly for reference holding for
roots.  Before we just sort of hoped and prayed we go the right reference
dropped when we dropped root->reloc_root.  Now we hold one ref for the list of
reloc roots and one ref for root->reloc_root, so it's more clear when we need to
be dropping references.  Everything else is relatively straightforward.  Thanks,

Josef 

