Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4755421CB21
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgGLTdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 15:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgGLTdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 15:33:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41867C061794
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jul 2020 12:33:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f2so4512595plr.8
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jul 2020 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:user-agent;
        bh=iPHrAwh/I6LdHdDngN6o15P8EjNanSMIIyTPQRdDFXE=;
        b=b1JqgyKmsOb/LXmspcLfKuB3hWgmGQHBc/6tgR03LZnLsz9hXsz6/jUAwfMxRi5t2x
         2xHnnSBjL+duwSeekz5siwelKV4HT9vCDG1Prm41L2nM/+3np0Wmx9jIcMMR+uZoP6bP
         Cqq9buDBFUhjqUVQLCkIchaTRZ0Rf9oUb0L8TFmRKwrOJAE48ugulemt1PY96kKCq3WI
         ZfN1Kf+oOxFZxOwhV7xL/lcsxSYLYXm7zWl2xVOzxc/1kVEkAi/KjBTMK+jB+KNwBe5t
         +fm8v039TgtHcOW/38FVzs81nHmrjlm+y8YqX15pwStqAUxkYXvb1e+Vy9m4xrjzbC4b
         keoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:user-agent;
        bh=iPHrAwh/I6LdHdDngN6o15P8EjNanSMIIyTPQRdDFXE=;
        b=bY5YTFhW29hKyuwq3+g+iHCuW4kbuUy5pVqw5LBgYs4fNvax3MPgDrUHRo8bOFtmqs
         2m5PQ2duV6AjKELlwB4ECp8xTUi6YcvpwXeeEc5crFOfamQPLbs6qqUEIAS3iEQE+mfQ
         Gu5B9h0FdnT17OeCSpDLQIjBsIpGShXKLo2G8RHbMFwTW4vj5K5t3y0k3gRos8eXfcD1
         ZWT7bXbOBq2/uJh5Ghoc+9lg/tGf5kEwfQXTGOSc0ubU2oGnzcNDC3AZ8lpfQt9bVFvN
         rT1CRwJsdXeTW5EQFiLGDtuERDIWYQk35Sayu50LRTLsw8a/H7F6VZWsZuqhg9n+ww1o
         judQ==
X-Gm-Message-State: AOAM531z7P65GT+VR4KPGoBTG++MD959wrD6lgypssvRGQ0M0MpOE3Oy
        uxrjojP43qd5ii7jGyHM23kEAmWTCqc=
X-Google-Smtp-Source: ABdhPJwEmu2koQRiPWWT3/IwPlK4KYh1kkUh0qf6KEPoN4Wf1uOt5HPbd7gFufxkc3P2BiS88tv4Pg==
X-Received: by 2002:a17:90a:8009:: with SMTP id b9mr17613956pjn.190.1594582380732;
        Sun, 12 Jul 2020 12:33:00 -0700 (PDT)
Received: from ersa.localdomain (node-1w7jr9qqyrgwg590lie18grb0.ipv6.telus.net. [2001:569:7a01:a900:f4ab:71f5:21ab:fa3c])
        by smtp.gmail.com with ESMTPSA id m1sm11944752pjy.0.2020.07.12.12.32.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 12:33:00 -0700 (PDT)
Date:   Sun, 12 Jul 2020 13:32:59 -0600
From:   Ersa <paul.kulyk@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Balance bug
Message-ID: <20200712193259.iRwJJ%paul.kulyk@gmail.com>
User-Agent: mail v14.9.19
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

post.txt
