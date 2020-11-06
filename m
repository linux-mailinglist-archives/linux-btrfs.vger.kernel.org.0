Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D52A97E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFOuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 09:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFOuz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 09:50:55 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DFC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 06:50:53 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so136882qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 06:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5vKgukkKbWlyp00hNEJpVbr8pzSqW64uYogBmp7y5x8=;
        b=Pin5ELJLRdURgegJRRcY08AzQu33RDo4EGC43x/qrOtT+THdpwZg5liEEaztcomeCI
         O/897jBciVUiAjjMoLFZLi2avnpJfbkzCOv9DVW/7isWOip6qkuq63IwBal+T9E0Nv6Z
         wbOoo6bKcPE6deELImBRxaUgEszTC4VSIlA9wvMtlielwGccqJRfoY2+yX+w3vlTWTUm
         rVbNp5QUocjrNozhW0fizN4L29CufapShwUfhG7a4iRUnJHSyHT51lJk0I8EByeEOX11
         CBp0T16fEVlBQAgDSe8VX08bb8u49XyRgHV/Wfv5TTagrQWbMRw4chv6jsl+bm4zgufL
         Hz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5vKgukkKbWlyp00hNEJpVbr8pzSqW64uYogBmp7y5x8=;
        b=T1A7ZIa1aP+Pc++MAMwWxVd5y3gxyrBeE8/ZDrVmQAJAwV6nEl38NauOgObvWTcuK1
         AiapgKH2hekChcZlUCexOTYyIaqMe5TQTaTiBckcZk4TTK1Hs+eSBD6hIr+ejrWsgJU1
         WhUUOZK5DvWtuQTwBzfqZIBonDZjDuv0L2C+E30J8J881b5gYweMQ1hSeRiFnc1tAvIk
         tLJrSK79MUCEbVaodELrG6lhTwb2Q76aRnxC4w7j9PAWFY3m0tC+GriEaO3DsQLUgZL4
         06kA55EO0wjuZEh9KOUXr1L1H941eRvNkFnY53f067yy2dI18rx9Mzn6VgY07eCOMmBv
         638Q==
X-Gm-Message-State: AOAM5325gM0FXhHQG0CkWen7yj9yOC1iH0B9HTlPPR0Tr5S6ki+Ff+UK
        Jkck8bilPGZrYb3pwYDQMn4EzLvklmrMsaDr
X-Google-Smtp-Source: ABdhPJxkPcqrRi2lPIqHBQDlSapG84mjQGa6CBI1p/nZsvahhndhkOGjhfRPrnfZcyPm9VuXe0wfYQ==
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr1859419qke.403.1604674252772;
        Fri, 06 Nov 2020 06:50:52 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j5sm614358qtv.91.2020.11.06.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 06:50:51 -0800 (PST)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: [WORKFLOW] Git commit hooks now in btrfs-workflow tree
Message-ID: <1e24d616-ab45-4a11-9e9a-0d6187b7049a@toxicpanda.com>
Date:   Fri, 6 Nov 2020 09:50:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've added two git hooks to our btrfs-workflow tree here

https://github.com/btrfs/btrfs-workflow

I've added a hook for running a local copy of checkpatch.pl against our patches 
before they apply, and a commit message hook to run codespell against the commit 
message.  This is to help cut down on the silly things that are wrong in patches 
so reviewers can focus on the meat of the commits.

To enable, simply clone the tree, and then run

btrfs-workflow/scripts/btrfs-setup-git-hooks /path/to/your/tree

this will install the symlinks to the git hooks, so you can simply git pull the 
btrfs-workflow tree occasionally to get new updates.

A few notes, none of these hooks will stop you from committing anything.  The 
checkpatch one will show you the errors and prompt you if you want to go fix the 
errors, but you can answer 'n' to bypass the hook and commit as normal.  For 
silly things that checkpatch gets wrong please open an issue against 
btrfs-workflow so we can fix the script, or if you have commit access feel free 
to fix it yourself.

The codespell check is also optional, but it doesn't prompt, as you can easily 
just git commit --amend afterwards.  We can change this if people have a strong 
preference, but for now it just tells you there are spelling mistakes.  If it 
complains about something that we use all the time, you can simply add that word 
to btrfs-workflow/scripts/ignore-list, one word per line.  If you don't have 
commit access just ping one of the developers and we'll fix it up for you.

Again the idea is to make this as painless as possible, we simply want to enable 
us developers to handle as many mistakes and nits as possible at commit time, 
before it goes to reviewers.  This will hopefully result in less time wasted for 
everybody.  Thanks,

Josef
