Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F483FFEED
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbhICLWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 07:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348733AbhICLWA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 07:22:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5BC061757
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Sep 2021 04:21:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id c6so9437080ybm.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Sep 2021 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=uuKPdEBJH6/bl2anSqQnFEwmoD2XBi3ISnDGwBJsVO8=;
        b=eI+CMWsnrKHpUyD9xbeSESvizPgPN8D+V2gYJnXLbZVC31XoPYntxyJUYTRQMFNmoW
         5VXCL0DENulc1Q6KiGvxQz2kM34v/z2A3qEldRB0qoNjrmmn378fjZJhG8nwQe0sAnfD
         u8dEpEz3uAqbtfQGUqsoGLaSV2+5KrrNBRwSAPozJzSKh1qSeKPb1v4cBdqhQp8p+nTB
         JZ7JZ5FuFAPHTyTv7a//YfDVcnkyp6jMRFhb9bMTEL4Ng++4ktKBIfpSOEVrRTGrBTdi
         paG9Nqnnsrd/KI0pzwA5l3W2io1ISasVqn9qLp0+fdpIVv+ykYoZbkdkaXXLqudM8Cg5
         mPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=uuKPdEBJH6/bl2anSqQnFEwmoD2XBi3ISnDGwBJsVO8=;
        b=LTnHFMj2pL0gL6lAxfgzSN1DkmX+7iXabGQDolb9pTuukkZ02bqQjE+/zvZB8+h5ZS
         tuBzQAVhYti2/IRDo0K9RVtlxOSXbQQFJxULmFbhZ4/oor1Z+2Zi763z4lbZctrntiA9
         XM4bX8B4xWCIQaNI8rfCNFI8B2blSDTBIueagq3gDkjvW7Tm3hhgmf9STmhyOHr04YP+
         CbVC/m2W6LPtlUgSI5NNN8LV3M8MquQcICIQbirJlZJvv5GVpW+//OUWBb8tY2jfUqV+
         8bB50u8hlZA6M1533QIiulx56n870rU+g7oQV3St2jQ83yXMMYXYiYn5+VTWD5Lz2x+h
         HNbA==
X-Gm-Message-State: AOAM531eBSPlUZM37Q5pIkRmIYuSxM4lt37F//zvgJK0Q35E/qZ2g3/W
        BIdNjVIkq/SBL14vznSwft1R4Vh5Gzu9ivUBt3w=
X-Google-Smtp-Source: ABdhPJzcrSfXwiPqcnDrigpiYazBuo8HJxoWXOvjuxCNvDX5U/MeUp3pheDhhHfxR0trSubsKprFTuIi4EZKhtdSEm8=
X-Received: by 2002:a25:2155:: with SMTP id h82mr3972037ybh.177.1630668059930;
 Fri, 03 Sep 2021 04:20:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:645:0:0:0:0:0 with HTTP; Fri, 3 Sep 2021 04:20:58 -0700 (PDT)
Reply-To: j8108477@gmail.com
In-Reply-To: <CACVOnGEAvA1R93QjJL4ZnYGu6Ye3Poo+Qj4BroHHrXthU7ieOQ@mail.gmail.com>
References: <CACVOnGEAvA1R93QjJL4ZnYGu6Ye3Poo+Qj4BroHHrXthU7ieOQ@mail.gmail.com>
From:   MR NORAH JANE <alicejolie80@gmail.com>
Date:   Fri, 3 Sep 2021 13:20:58 +0200
Message-ID: <CACVOnGHO-E+JwB_4B73Ty13M1W7ojCwEJhsgde0aLfk0k1bZ0w@mail.gmail.com>
Subject: Fwd:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

---------- Forwarded message ----------
From: MR NORAH JANE <alicejolie80@gmail.com>
Date: Fri, 3 Sep 2021 13:20:30 +0200
Subject:
To: alicejolie80@gmail.com

HI, DID YOU RECEIVE MY MAIL?
