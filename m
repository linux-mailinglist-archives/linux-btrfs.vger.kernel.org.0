Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B86115344
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFOhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:37:23 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44988 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLFOhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:37:23 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so2695106qvg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0pQq+Y77vtt7ikXJkHBsX7sGsCSPyy1oGdYdUJxJgo=;
        b=xLaAdOdpJqikjiBV91nd7eoSbmj2um7O3c0HQeWHUh3PriX894EBfoIUhwhXOvMfuq
         RXvwHETEYDgXBTCcTQAv2RgYHezyqtHXgMDRidRLfWcgqnrhPP31x+n11IItqmcirsFU
         I5jPqP5dxwwng21EdU2c5LfG+s/4rr9zydt4PqeQzSOCKK3INMkghr/YXRc7yUxiy1bx
         eB4jgGDoOh6Wg/1qIZeiYedabO8nB8ypCk9lHewBPa3l41GuLb02fpNpoYGEdGlM6UTU
         AdhbhLEYBMT0zoDoD/7nLy/CXmTRChZheFo8e+wOkzVUERDySSTI4tljVqbuWnhvAmme
         SxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0pQq+Y77vtt7ikXJkHBsX7sGsCSPyy1oGdYdUJxJgo=;
        b=ZXYu5ULFVweZxCDeJC6U+IjOSP90TX7yY66BMWYSlhg/1b8ihLL/m80JVl8Vw2Jlik
         LYVy8KCnt3k8xtl0c350PxTet58XSxasZIP3i4iu6CukJl1SGr+D0/KeqiiA0o9yPLF8
         3s8kUXrEu5oYQUK/ban4sb5vbWAikxH18qqKHL7BVzvCF12S0vQOQBztFpoSRelIncGc
         gquFRaVFIcYsq1nnLbiO2gJMv+3BUFgp2u2OdMDXq9hoSBa9EPdeSKmbgtHEZtn2sy13
         FFEudW2N9024pRpVbTXV4dNetEmn1s9TqZSrnuqUsFqEwpyC8h8Wea8zMRVbTb8zmfxB
         FnQA==
X-Gm-Message-State: APjAAAW7a11C/GhLqmWhYYNETH0zjWb+o5CG0YYzZCBcdCroAxTrt3XX
        sTOsbLbzN17mvBn17uucKG22wclNsoGDvw==
X-Google-Smtp-Source: APXvYqyOhLf4FmECZcClMZE8PvSrBREitFpWIZT6KXY+r3bOopue79enbkcLB2PRoq203d+Chns2Ow==
X-Received: by 2002:a0c:baad:: with SMTP id x45mr12452360qvf.230.1575643041283;
        Fri, 06 Dec 2019 06:37:21 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b35sm6631430qtc.9.2019.12.06.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:37:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] Various fixes
Date:   Fri,  6 Dec 2019 09:37:13 -0500
Message-Id: <20191206143718.167998-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These were discovered while reworking how we handle root refs.  They are all
relatively straightforward and mostly deal with error cases, with the exception
of

[PATCH 1/5] btrfs: drop log root for dropped roots
[PATCH 4/5] btrfs: skip log replay on orphaned roots

These two are pretty important and were uncovered with my fsstress patch.  The
first fixes a space leak in the case that we delete a subvol that has a tree log
attached to it.  The leak does not persist across mounts so it's not too bad,
but still pretty important.  The second patch I've only seen in production once
in the last 90 days, but could keep us from mounting if we have a subvol that
was deleted with a tree log that we didn't finish deleting.

The rest of these are just for various error conditions and are less important,
but should be safe enough to send along now if desired.  Thanks,

Josef

