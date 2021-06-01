Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF7396DCA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 09:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhFAHPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAHPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 03:15:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24E6C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Jun 2021 00:13:28 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so14583982oiv.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jun 2021 00:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bamLLSSDqSx3zYV9j2ML4dg+p1WnnDQOAtxV6Juxd4o=;
        b=XbVQic7G5+1IG0y2gWUbKj17Amp3O9XEXxia/uVO+/GcaR/iyY9OzDOFT6etYUph8k
         LOrloaq5nihsbBiGI5dCgVeXN7ZPXTwDAhJ4UZU/Yzr2DmSdxuQm/PstbV973nJ6LJKF
         8U6eC1tZIEWevf6bjD5AE0H+rhq1jkdBXDMVdw1qlCnHfZvn73e+gYlpPQ9f157qMq29
         6xCG3GvGUiOgi/+WjhNL7qtYVt1OWH/BJAGd5s5CV9Wj6raiMZMryraI2pKOU3t3o4AB
         IhMipFPaWzuN9y17scO6WKpFacTbqJs1yK+zTLbVkW2wLYd/jgZvtkXf+D5mu54RN+vF
         gz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bamLLSSDqSx3zYV9j2ML4dg+p1WnnDQOAtxV6Juxd4o=;
        b=PtS18Bt1oShcpeZAavKGR1O+sIjG6QkSgHymlSN00pF5EkaJnyO2npeFgbG80EEKOK
         +YhdNi9iHSw0SfL65KiVlBh7ESJjVa/xe8OJms6UB9YlKakgXgBh7CaaqpytCiJBoPTC
         NNOoP7Q4luxagV7WcwI44TRoG9GO69IGqS4/wWIOdAhR+c32obhiHRGuh6qZ6ydahRjF
         3nHoqY+kixF3fnojUm6xzRGecoDNVmH+m6xPCjxikGeFGo5ALlhdvTH9lPd8LzlLDHxP
         vlH7ZnybOwCJ2ssTAFUjHgTonMWzrXNvBS4tTY/Lq33Ta5vYG7GZI+nEAkwskXr3lYl0
         JLYg==
X-Gm-Message-State: AOAM532qbw4du+fi4F8dsR1zBRd8Nd7yNlS5V+FLNJiOjmBzGwHj54CF
        XxyMN6sisX7SMpfyXnJRgJh4gSiQ9XqStpLJ3KBq853+XV7TIg==
X-Google-Smtp-Source: ABdhPJyFf1xFqEKPiE1u/bYXmrbSgAq4+9FFq7Y75JNRjCJtMZb2H0Wxix8334/91vx06BtkxVge/UCiWfwWQ3rv7zo=
X-Received: by 2002:a05:6808:a02:: with SMTP id n2mr2008906oij.104.1622531607657;
 Tue, 01 Jun 2021 00:13:27 -0700 (PDT)
MIME-Version: 1.0
From:   Sampson Fung <sampsonfung@gmail.com>
Date:   Tue, 1 Jun 2021 15:13:25 +0800
Message-ID: <CACEy+ETCvJ+cKn6N4maL0Dq1608pKtCXYSX6CO0oz4B8X1=gLw@mail.gmail.com>
Subject: btrfs send -c: ERROR: parent determination failed for 330
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My full test setup is post at
https://ask.fedoraproject.org/t/can-i-continue-incremental-send-after-subvol-is-split/14597?u=sampsonf

In short:

1.  create a new subvol A
2.  create 8 new files in A
3.  create readonly snapshot as A0
4.  send over by btrfs send /source/A0 | btrfs receive .
5.  split A into two subvols A & B, and move 4 files over
A/file1-file4
A/B/file5-file8
6.  create readonly snapshot.  A as A10 & B as B10
7.  send A10 over by btrfs -p A1 A10
8.  send B10 over by btrfs -c A1 B10, then error

Why was that?  What is the most efficient way to send over B10?
