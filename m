Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E132A349B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 20:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKBTw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgKBTwR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 14:52:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E5C0617A6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Nov 2020 11:52:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a15so6756688edy.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Nov 2020 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infegy.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=vSjdgF6nhxrVNLKx+QQJl1brX1awGM8WBY3XWck985g=;
        b=i//hsnhrtP+dI1KO3fRRQkzAKG81syMrPKLOXPYhtjxR/7y19fZI52o6l34WsXuR/+
         dd38YWjByOyChjFVHuxhuWaYe/GeHSFFXdJRx7ywYpLL9rxN8aDfcoy6SKHAHusMQKc8
         oQz3hPAaho0W1FGImrWxIAehJBK8YxW/yyCCclwnoUZ7XCfFYo2aP+BMGHpbDtYQICEq
         QHoPOEcqFm1g4yzFj6WesOSnoDAdD2qVTKG12Hf3vsom1yOANdEX3cXY9ibqpopjBXKq
         y2IJAk1Von1U1jcDRhVL6WuaaV8aUdomjWQSL7YSYhzerEpAOX/+W5BHU7rEOPmZOrmE
         gcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vSjdgF6nhxrVNLKx+QQJl1brX1awGM8WBY3XWck985g=;
        b=MmjVaIGsdSxXQ0ieoxYFHutipa6e90X0pqIRJJObeutYtXI0nwq5wvAczuOyQDfwF0
         n6g8CYTSowhv4YPyvPTH/dNcAcwMB867nuPmdYs0+9x70JBCJVo70LYCR0yPUyJ7prbN
         Q/O5JHb/rYvpIYU4Ytt1j7geH55/FxQFUPqNPwzPuMcnUDPv+RqHNEFooVpDcxt1wQ33
         G+MxoWeoBRAnpDW+AMZ6WMOIs2vngpIhUmQ1pNk1YMOrXMdO9bRJESmd8m1CPj4C2Pwd
         jeW/XwzVESjBKMMWCG8oTnXjbyDL9lZAIkvRNdDDM5hjSlD6+8Zs1DUMcLGTD7p+YPxr
         j5rw==
X-Gm-Message-State: AOAM533N4LHcn1WB7HN8N0qfVS8DlO+QIOt8Vz6nxXAy19ERwCZYaXRi
        OuWDAdQ7iLTcCT4+tXQcTw0Trap/XwZ9U5sjsJSrmEd+aja9yDua
X-Google-Smtp-Source: ABdhPJwf6Zh8xJJG0d9wkkSmdhNralLd14nLoBWwV7QrncoBPbRIL/xR8dQHJny05r/4hDLZv/dkdWQDzymaavBDQVw=
X-Received: by 2002:a05:6402:1158:: with SMTP id g24mr17446799edw.323.1604346735709;
 Mon, 02 Nov 2020 11:52:15 -0800 (PST)
MIME-Version: 1.0
From:   Jim Erickson <jim@infegy.com>
Date:   Mon, 2 Nov 2020 13:52:04 -0600
Message-ID: <CAAGWYw9aA7o7yBMb7Ty9Exy7KcQQVAQtKa-xGbO=fc+axY2B5g@mail.gmail.com>
Subject: btrfs CPU usage limiting performance
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are experimenting with btrfs on 6 NVMe devices, using raid5 (yes, I
know!), in comparison to xfs on mdraid5. We saw very high CPU usage
with btrfs, so decided to try a new filesystem with nodatacow, and
also nodatasum, for experimentation. In any case, in a highly-parallel
test, btrfs consumes all available CPU, and performance is limited.

In other words, nodatacow/nodatasum seems to have no impact at all on
CPU performance and peak read throughput. In this test, kernel 5.9
also made no difference at all. In every case, performance peaks at
the same place, CPU usage is 100%.

What is btrfs doing with the CPU without checksumming enabled? The
lack of change was surprising to me. Any thoughts on reducing CPU
usage?

When comparing the btrfs modes against md5+xfs, in the md5+xfs result,
the CPU is 80% idle, and the machine is IO-bound while btrfs showed
many live processes and consumed virtually all CPU

The CPU is a 2990wx (32-core Threadripper 2). The drives are 6 Samsung
970 Evo 2TB units.

Thank you for any feedback! I am really excited by btrfs, and if we
can work around this ceiling somehow, it'd be just about perfect!
