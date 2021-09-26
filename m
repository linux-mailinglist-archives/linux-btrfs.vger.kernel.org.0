Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9FE41892F
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Sep 2021 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhIZN7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Sep 2021 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhIZN7G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Sep 2021 09:59:06 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4EC061570
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 06:57:30 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id i26-20020a4ad09a000000b002a9d58c24f5so5084146oor.0
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Lgw3yYy8PifsT9cUWMIALAHbupmih3SrjmUsw+645MY=;
        b=iY4zk//egUfiLwnZOK4kfAwniJcMeNhxI7EtmG39Y8Pw+2ANmgcP2j20sG/tv1sXaN
         GSmdaVIiPEkeeXEQG06aNmET2+Fwv882rmUedExJe8J+d8xIEZyN66A4NRl07pC1gph7
         oW6JzZct2mmk9n53HOzcMuU/5oh2qV5CzKeaO+6wJpPX4+P68a6yFUHd8jeBkUuvmwUR
         GvtzJ65x5p2r0cPsAUfZGZFXYbfrrdzQ3VgBZ5fMHcU1B5FzFgNsOpJXIwcIwiCU3uPo
         hbE3JlvRBYWAMxK+qlKEWXPH8ZXqLnw0IjUqAOluY5LrAOZ47JrdybGzGYabDDMsMrKL
         eg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Lgw3yYy8PifsT9cUWMIALAHbupmih3SrjmUsw+645MY=;
        b=SydDhNpTvxbQuGqaVnfR1jezWXeubWwPCnITpRSCDbOmZGyG5ST2FI2KNy7BdN1Asd
         UPAFpA3EKMPkBsfs2LkzL7q3F3Xsry/EUVDmo6h5Z2b6INdKJjaLswYMdiHWCYcs1hT/
         kgigrDPnQW8e9Pu0iYhYz1Qm/m60eDmaFpqn3k8SK/MKUwxgoYeHZFueHqFG2crKemFP
         61zcdo/AFZymb6zULOIJ5n4NgZfzuZB431w5D3yEbePFFKJGxwxwR7QzQRcwSI3TmijO
         6rjmnz1P7UpyabOg1wx8Oz6LfIX4Iji67+6FGWl+QcJxpkKk30KSm8ftKFflKfmyfxs8
         DBJw==
X-Gm-Message-State: AOAM530BN2AcBeI6rjVx3QReaZSLvsH1FWvju/38hP3o+hhO+uGe62wt
        y2sIfHUhk8WzomCwSaKGCB4vCUIwuKXz/Ul1F3XWZQAA6b/qtLFl
X-Google-Smtp-Source: ABdhPJxDyx6RfbxizJOob4RZu/t5kPr0mIBkDTMh7Y1Q+LS0NHbIGDnlsuXpW/5VfLL7jV0IUJ/xLCUpKSpOwvj0HWI=
X-Received: by 2002:a4a:da05:: with SMTP id e5mr16784699oou.52.1632664649660;
 Sun, 26 Sep 2021 06:57:29 -0700 (PDT)
MIME-Version: 1.0
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Sun, 26 Sep 2021 21:57:18 +0800
Message-ID: <CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com>
Subject: seagate hm-smr issue
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
Btrfs works very well on WD/HGST disks, we got some Seagate HM-SMR
disks recently,  model number is ST14000NM0428,
mkfs.btrfs works fine, and I can mount it, and push data into disk.
once we used up the capacity, and umount it. then we are unable to
re-mount it again.
The mount process will never end, the process just hangs there.

Anybody can help me with this?

Thanks.
