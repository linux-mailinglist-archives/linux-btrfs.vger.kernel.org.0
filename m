Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2544D29D6A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgJ1WRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbgJ1WRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEFC0613D1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:17:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r7so532512qkf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UPznccgkyrd/L+kMdOFK82Mz1idNa4sbOJxrYVh/hIw=;
        b=lfr5yp/5zNP5FcNauZpNRDrM4Hv0Ajt9iNdGKUPwdNatOvZXs+I1xq1/YITbDdZ/c0
         XZ9X8Xmy6xZdTML64B4ulFNSaCw22F6B+h7toECRtVHqSGtLFVYsOY+DIccYLA/7Ckxp
         2LE1PpMB3p9WJmzjaOEvlDj2lb8x7+CrzvFw/s8PWZi24YLXEmh3JCyI4FC8Nij2a/wI
         ufF41RX7zbPEn/r1pKmyW6qSRYIJpJ+QBLv3EE+r0qYAkY6L6mTWcie+uUoGYmurzQYj
         bTSJEo9msFT4IABXEv91hecz81nirQq/hw9SjoN9g3upel94ePZDyx4j+GxjBO0MEJ+E
         au9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UPznccgkyrd/L+kMdOFK82Mz1idNa4sbOJxrYVh/hIw=;
        b=Rlk/eHjuWaygYhD+tAOcz26cXdG96e5vpc4CEd4RpQfahUq9YNzoiPKMkdxQznDNEF
         IapQLjftPq3NRItU58V6gHQUaq50043X2NtTARaxjaMwWvy6PcSZ6hA6s132u4j/DYjL
         PInubtgBEV3VOAZ8O9iOsfUgsOjP4cp+iKix8hLTO/GkbHMAWJ8MY1D7ajRIb/0yLcHU
         5JNQSlujYRHRrfUuWScZ9P60V59yJhw8iME4mLxYz5Uub8ORl5IO4OsA1wmq1gv4MYP+
         nMBexzOGfpbMyIELCBpR/von5Fi7K2tvEvnq0gFOnC09n7wBwVE+FTJY4kJcDx+Ds/eq
         dawA==
X-Gm-Message-State: AOAM530aCaY9QLypmn8wQ24ogPZvWfVpAWSYR88uZeA587uS9NvEujQa
        tCatd53BkIPuN9w0WOH7oJMNtbo+86cSnyqMq5u7KT7R
X-Google-Smtp-Source: ABdhPJyDaSa08aiGh8OukK0Et9LtpkHAVCbt6TlMJiXkpUj02on6vhfWId/TcnW1DvH6kkYixGgwt++t8AQgrS7q0JA=
X-Received: by 2002:ac8:71cc:: with SMTP id i12mr6446142qtp.262.1603884355809;
 Wed, 28 Oct 2020 04:25:55 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 28 Oct 2020 12:25:45 +0100
Message-ID: <CAA85sZtGM1Gia7FjunVN4+r4uikQeAPTYAU53QCcT=QQTyt1bg@mail.gmail.com>
Subject: questions about qemu io_uring/dio
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

From what i understand, DIO is supposed to be supported...

But when i switched qemu to use io_uring it seems like the filesystems
on the VM:s get silently corrupted... (they also run btrfs, and it's
thus detected)

The system is mounted as nodatacow, I can't set +C with chattr so I
assume that the images are actually noncow

Any ideas?
