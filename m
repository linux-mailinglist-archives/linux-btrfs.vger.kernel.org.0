Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857F2365CA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhDTPue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhDTPue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 11:50:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110BC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 08:50:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v7so11717287qkj.13
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7iRSA2SNOTLWpdtc+381g0/NltSsoGB+e3jAIMLmTg8=;
        b=JwRqmnPFZIt54PIO012rPlGktSiOOGYp1aDOtLtI7R1TMfG6CNwBNQ9tgzIRc8caX5
         zX2xvFRbYA14PjpaHBWnxOZVIsV5v97hxLkRqOlbEoIIrmIPeoHe4QLDCxNdy2zCM961
         UD3vFoE43ZrrrnT3+6/wwNcQBTqmjmOCu/jqIVPnKvsSp1TpVAW/bqkWPJSy+VkNRNwr
         Xnx3xTp0oZVFqGtpjTdj+6B2lzYdWZ7fsVWSau5qAxlMhpEZ1ZseyL9Ld51ikUK8JYeb
         H9bt9+FAYt6B3bqJqhB3Tp8UthQ3+sg90mrePIUngixwE8OJs2tEgNa1tL6lwzVASLBe
         fmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=7iRSA2SNOTLWpdtc+381g0/NltSsoGB+e3jAIMLmTg8=;
        b=F93myiPpCQGmtBDlACgWAV9uP5eFsk2tu/WnaYXoyddmqllxNewSifvGlvaoAeOt3W
         1nelOrJvnZV6IEokLVIj7pTm5eN+4Y8j6Z6Ml/4OUJc/+MFAkBkmrISwqWwJ3jICq2a/
         dkwQtoOfJ1eF1CUYPkaqhUehhA1+EcO9oL6KrYyL93YLRLTkJ/umIzw634Ol/5DA7sCo
         8BbRvAepeXZFN7ROEPoZ0kTC3SamalRyX8K1Zi4EFbPeRkfRWBDKulXBLHA/SJ1Q8BbE
         70Y/sHltdvsVsLGzmgJq9H8zUEc9fpJTf/P0g04gh8utcUWcHQb+48+kAQWGNUAwYB1T
         xCpA==
X-Gm-Message-State: AOAM532YU7bbCkK7wcjrMzpb2EznOFRP1Nov+O/W5sPLneuNgFavqsOO
        0jdDhE0jZ/aU4wC11zxdU4391R11k3g=
X-Google-Smtp-Source: ABdhPJwN1j0pGGBRukPWIrgTOVMpKiNJGyxLZALTL+Id6w3XSQxj8Nf6DACLZ846MiLcvPzPKG8J7A==
X-Received: by 2002:a37:e10d:: with SMTP id c13mr18486375qkm.322.1618933801886;
        Tue, 20 Apr 2021 08:50:01 -0700 (PDT)
Received: from [192.168.1.9] (c-73-249-174-88.hsd1.nh.comcast.net. [73.249.174.88])
        by smtp.gmail.com with ESMTPSA id q125sm12377153qkf.68.2021.04.20.08.50.00
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:50:01 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Forrest Aldrich <forrie@gmail.com>
Subject: Converting EXT4
Message-ID: <be7a946f-c5c6-c95b-4715-a7132bedd7ee@gmail.com>
Date:   Tue, 20 Apr 2021 11:49:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have been experimenting with both BTRFS and EXT4 on hacked up, 
external RAID5 array made of USB disks.  Yes, I know, crazy -- but 
they're laying around, so I figured why not use them for long-term storage?

Anyway, in my latest transfer of multiple terabytes of data, to an EXT4 
filesystem (it was BTRFS before), I used the open-source tool "rclone" 
which was pretty fast.   I ended up with (for example) images files that 
are now of file type "data" and others that appear to not be what 
they're supposed to be.   There are checksumming operations that go on, 
I repeated the process a couple of times to ensure all data were copied.

My question here is if I convert this to BTRFS might that correct some 
of these issues or did I run into another issue?


_F

