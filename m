Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC8436A9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUSgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJUSgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 14:36:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D28C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:34:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so1061625plb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=CiWS9/1S6zrKt0ENJCxqYP10rP6bX60XNybpDMoOuvI=;
        b=vJbAdpvwdfAxEufswyJu0m9wtIyOITLlEaIcBp/he17/t+eLxneONLz+v0JtNPAcqP
         pmkls54Lh1qrMokaZAkd9EkfQtHgCA8qBjcwyjvZ4iPfq7iqkAf90b5TSE68CMCEpL74
         xRNUrFimhyOIVEcsvJ2xXF51gAXT/cIhCPz6qF+ujOnIOWvvfrOHBYEKaBQqMOcjdX5O
         6lcMoDmA5/TlU7CUiObwE2rnlZBFlDqe/r6L7srN4vW/T7h/tzg7niOlpHPpZffR/V+Y
         Bjt53hR49k2bLopz/yWzIXdGLHJpDmvaX26Wp/xvhOT1ieBLt2l1yU5H2K1UnBLmuUZk
         OO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=CiWS9/1S6zrKt0ENJCxqYP10rP6bX60XNybpDMoOuvI=;
        b=FNhkgCiUYAF2a/k63S1cw7sWWdKKs7N4Nac+D4XznTEVrYUl3rx1fAAkpVeZPpNQga
         Fye73wefVpCb4CYnUTvwgVmY2Cca0EjwrpgqYQk0dst4w8mYN08QBzcLWK0eyiYzUw2r
         gA8BgD1Jdr0+h891XTyRhrJCUz6I3lMASSmHIRPsEXjzA7n16aByJi9GfSXgFrLxuYKk
         0f1JBHZLFP1uCel9n+z9r3THB2xKK9lNS5Vj5NNh3mt5f48xdhWxDe54r9cPuTWB9BSr
         0/1ynBDycpz10la8FBhiCWWU3w9DUkgQUb65kDGJZ9pIGu5Bsesd4H0RyhvsX5ZOWc2E
         HDmA==
X-Gm-Message-State: AOAM531j+WbyiMj8u1xXACec1tHFGQO8xWi6tKFxaP8qP4ClLafMmDbx
        QZZbg6LD0iN3yhXtdvfT/OutV8oshZg9DA==
X-Google-Smtp-Source: ABdhPJwEXRvnVooPM3XgrTr2WQwlm9Qq67eXJ6yiCEf+scadRCJmobM8axHjYmX7AwmNio7qX9uNFg==
X-Received: by 2002:a17:90a:4dc6:: with SMTP id r6mr8690966pjl.5.1634841261809;
        Thu, 21 Oct 2021 11:34:21 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:69a9])
        by smtp.gmail.com with ESMTPSA id gf23sm7115584pjb.26.2021.10.21.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:34:21 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:34:19 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, kernel-team@fb.com
Subject: Btrfs Fscrypt Design Document
Message-ID: <YXGyq+buM79A1S0L@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've been working on adding fscrypt support to Btrfs. Btrfs has some
features (namely, reflinks and snapshots) that don't work well with the
existing fscrypt encryption policies. I've been discussing and
prototyping how to support these Btrfs features with fscrypt, so I
figured it was high time I write it down and loop in the fscrypt
developers as well.

Here is the Google Doc:
https://docs.google.com/document/d/1iNnrqyZqJ2I5nfWKt7cd1T9xwU0iHhjhk9ALQW3XuII/edit?usp=sharing

Please feel free to comment there or via email.

Thanks,
Omar
