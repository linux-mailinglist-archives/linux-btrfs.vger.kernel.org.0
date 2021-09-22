Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF4413EE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 03:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIVBME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhIVBME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 21:12:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25032C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 18:10:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 5so657373plo.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rxPyx41rTYBd41GqtbX7600qQowjoXe4K+DH2TMXG3w=;
        b=ImrT+4FqT1sFlkowA92KUCz/AFlLZpGvHsNHlwXFV+eDyuuH0yHdKvHqdPEUAxYQNx
         Fp2FKLx5YVQnLTk0Q/tbDiQUIPYbxIsjFphMZM+wPBjzc2vuOxpdfV6mPFJnKt6CvUoq
         8uJmrY4vmcz3na6C8U66s0+JdOlV71fRZRI4Hp5YXJkC9Y/H3v64sUXCFFLmp5VW+Gta
         0In2LSEEzj7vE5xUAhEdnWQTM+LGf3D3TFz340EBeW1sK/h5AI6QiwwYW3QCC9DDzxul
         wHxHxoRu5MMfUfBixtvNPqRirf+k8tTS+Uscs+kPpmr+mvko1Vbhu2Pb6NfVfPupAjix
         T29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxPyx41rTYBd41GqtbX7600qQowjoXe4K+DH2TMXG3w=;
        b=STfSm8JhY1MRMzJmyFEe8eMbWTz981yrcQ2TqtW7IBrLlldGjgvD9ia1DzcEqQR3O6
         qNrngKgxvmC9DLic9d5NJOMWV6r6m/wlYS74zS/n5/fLwS+xK0ABUni8AjSYiiU7eGLT
         OtLCJtRTncxAd2slf/185GI/OjnHa1jZDUst+5btB2Z7hjOtgFNr3Y3NAV/2+qnis26/
         d3PjC/lvl9RRRMugKKuGoNiltvEOMMSz+HH5F3QSQ2uN2DVmk8rr17Danzr6Eyl0z0jx
         jtJCKD17Rnqu9lB6RGmE7KfDVQsXaX45hoRX1/mk46u0JMTr1//1Xd9b4fdSb7Lg6/+0
         g4iQ==
X-Gm-Message-State: AOAM532W/2y8wfzKFAGj7BY/816RyNyvbYBwr8RaKuoZ97zrCbP1bkpC
        f4/SZ1lJVoVSEQiSnDH2BuZXcouL6dE=
X-Google-Smtp-Source: ABdhPJx66l53fw9yagT8pyJ6yS18lXi+8A9dwS0NxmLleDpI15xOmCA6g8M7bD6bzCE3mquCnba5Ng==
X-Received: by 2002:a17:90a:a60d:: with SMTP id c13mr8379525pjq.148.1632273034285;
        Tue, 21 Sep 2021 18:10:34 -0700 (PDT)
Received: from tfr.localnet ([63.138.85.69])
        by smtp.gmail.com with ESMTPSA id b1sm258981pjl.4.2021.09.21.18.10.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 18:10:33 -0700 (PDT)
From:   "Garry T. Williams" <gtwilliams@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.14.1
Date:   Tue, 21 Sep 2021 21:10:32 -0400
Message-ID: <4680483.31r3eYUQgx@tfr>
In-Reply-To: <20210920162224.27927-1-dsterba@suse.com>
References: <20210920162224.27927-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Monday, September 20, 2021 12:22:24 PM EDT David Sterba wrote:
> Hi,
> 
> btrfs-progs version 5.14.1 have been released. This is a bugfix release.

FYI,

    === START TEST /home/garry/src/btrfs-progs/tests/fsck-tests/013-extent-tree-rebuild
    $TEST_DEV not given, using /home/garry/src/btrfs-progs/tests/test.img as fallback
    ====== RUN CHECK root_helper /home/garry/src/btrfs-progs/mkfs.btrfs -f /home/garry/src/btrfs-progs/tests/test.img
    ERROR: /home/garry/src/btrfs-progs/tests/test.img is mounted
    btrfs-progs v5.13.1 
    See http://btrfs.wiki.kernel.org for more information.

    failed: root_helper /home/garry/src/btrfs-progs/mkfs.btrfs -f /home/garry/src/btrfs-progs/tests/test.img
    test failed for case 013-extent-tree-rebuild

-- 
Garry T. Williams



