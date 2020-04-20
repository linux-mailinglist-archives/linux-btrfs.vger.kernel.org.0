Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC611B0E23
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgDTOS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727890AbgDTOS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 10:18:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2289C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Apr 2020 07:18:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so12354755wrg.11
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Apr 2020 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:mail-followup-to:date:message-id:user-agent:mime-version;
        bh=918h+4DCGhPy2wPhXAThICSYSxFuHN1aXiG2zqgqH1w=;
        b=dc3EUw9mxHG1TCzWbtPVVqJzso6/gZfkVsaeP3L6KfoHIlE7P8UpKAONtlpPmpJqil
         wGcc4pXl0rR4X/znKOG2DwdKHLpvRQ09ZAo2tMlW9SWJVMbgNNxWZBlQ10bif6/7qgsW
         bPAzJPGcRcTvJJ6hVnxhI+Loj46z0oHbK+E1K9xW3ZlxoYtrwVBt+DVN13xeamwZOf7V
         y6qJEQukYm0RoY5n1Xz+AuynU0C6/3kH9/Cie/flWl8FUFh2Jq17WJG7L62AO2rX42n/
         JepGQyN7pFugCpRPw3M80e+B1gp4Xw7F/exntJ0FHShkwFTNIGwzfVQ3kEqTr/Z204Dg
         jC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:mail-followup-to:date:message-id
         :user-agent:mime-version;
        bh=918h+4DCGhPy2wPhXAThICSYSxFuHN1aXiG2zqgqH1w=;
        b=YYpwuEGWkFEFEoS1/k6/IalTARHdb7R+TlS095vlQsSzaNlI6mj8pEX/bs+ZlGJSY7
         jRc5PiVXnX0xpyhH1LmoLQLe/0IML6sMGo3lusSqCuveuM5ROcPbcUj9w7G45c6EozYt
         3FPUhTMRHutFs7plRnpG4U4HpmMLcHu4T6lCphFDGgEzKzLFjKcYBswqxXF0Xyl4kD0a
         Yjhre8PiMgVgvq/AkNmF8gjwXTL17sjJaocULLFOAgL08ksw5kq8ind5i6U1Bw+NWmxR
         K3dANBoDMwSxSaZqxZ8UztZcK5VIAHLobs4VnvVNk0Pe0Q0sVbltACbxSJLicLcSWBy/
         brpQ==
X-Gm-Message-State: AGi0PuYePSljXy41Gu4L3uMTUYc7ZsaYbeowg7eNk2c/NMS0vVOYB9Iu
        l/o+RQug77QTaV5A6Pfx12CupoD4
X-Google-Smtp-Source: APiQypJhQ1VgcV1ggf+M4+9jct4E4yX9c73DiP471G/lovYrEB5RfYhFbl8yKLAnC4y3SwZWPZnBWw==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr19824724wrm.187.1587392337401;
        Mon, 20 Apr 2020 07:18:57 -0700 (PDT)
Received: from MSI ([82.132.184.245])
        by smtp.gmail.com with ESMTPSA id n2sm1609750wrq.74.2020.04.20.07.18.55
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 07:18:56 -0700 (PDT)
From:   Dekks Herton <dekkzz78@gmail.com>
To:     linux-btrfs@vger.kernel.org
Mail-Followup-To: linux-btrfs@vger.kernel.org
Date:   Mon, 20 Apr 2020 15:18:47 +0100
Message-ID: <86mu76i6k8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

unsubscribe linux-btrfs
