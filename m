Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D16C835B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCXR3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCXR3U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 13:29:20 -0400
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 10:29:19 PDT
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAFAF12
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 10:29:19 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4PjprT0166z9vKMJ
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 17:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id du-K3TC-Rter for <linux-btrfs@vger.kernel.org>;
        Fri, 24 Mar 2023 12:20:40 -0500 (CDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4PjprS4zq8z9vKM5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 12:20:40 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4PjprS4zq8z9vKM5
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4PjprS4zq8z9vKM5
Received: by mail-pf1-f198.google.com with SMTP id i15-20020aa78d8f000000b005edc307b103so1302679pfr.17
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1679678440;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=192i+/S1FWeHYp/CgxiRyxhZy81Legi2/JkyYfa+kjU=;
        b=M24tlBvl+j5jZZraONKQ55S9jz9KAYBmsgkMBAvypyvtir6ObdasQ4BMjAmcsocD9b
         ge+rCHB+iNNXkYZQb9Eb1b96OQvWp/+tqw0qLkO6hZEZWmpvj1chm90M3KqpXchb7FGh
         Ch9PreIxAbatn20FRZhvD6U2Mb93YKLL+oMNvlcX67jYfV/PDN0sJmD5bsq1fUYdU/wj
         N5HiMMcSe9Y0nMXjxWgpIaY0mO1gdwJkJB3zH//B7qu3qACCDGdkVb+8qcO1rQBVpaqk
         x4PSn7nIoBUHY2fpP2DcEXWmOZSbbCyYEfCwY2wMNOECBAxiNXOCCijUWCPt/lNREWF7
         HIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678440;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=192i+/S1FWeHYp/CgxiRyxhZy81Legi2/JkyYfa+kjU=;
        b=WoFsIUglyhgCYppoEdxhsOxzr11Erm7nRyCFEImpUSIG6cWi2gEebkBYmgSwfUunZ+
         +d+mjoJfQoAReBufDrJdig/JD51DO7eRFw3FYDRe6v//GoGGFn/q5Wms71nOdI+/llLs
         8ZcDlWfOmgIkAzHfiWnwYZrw0oFuxVSklLyEWB6TUU9s3VXjyCSYnubTBAmcZolenFHz
         XD0szlQwoIWcgcT77tXz/j2yx9yywuNGitutCC1V3MDLihSWvMPFObLh7SBR4u9bd6oW
         L7oVjT7IoA4KScdLsmlditCQR9msQmYcD085CVBSj1xCrN1BedqQteHzTspJcnPI4MnA
         Dipg==
X-Gm-Message-State: AAQBX9cagMJKca+mfQDj+RKog6g1sbNQpRSDRF5Q9GSPCL1VqdtXYThu
        5pKqDteVwAWwij4iLyhNgK43m+NGv5DiqT2hjhsAH4yThAC1Gfg5E+OLSCnZnp7piiiztrLDnnH
        13Ed+8G2cVG5RwK+d8Ng2MgZ9wJBX9cbWu03E4GwPVXBbnKMhuYvKjg==
X-Received: by 2002:a17:902:8bc4:b0:19f:1d62:4393 with SMTP id r4-20020a1709028bc400b0019f1d624393mr1040359plo.7.1679678440044;
        Fri, 24 Mar 2023 10:20:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YElbUGPlm1smDLHB5oBKznsMWUiUXc2+YmEuwjda6+1XPLrhGzhYv2ZKhAwXl0J8EqG5xsrgMZG67aKj/lVpo=
X-Received: by 2002:a17:902:8bc4:b0:19f:1d62:4393 with SMTP id
 r4-20020a1709028bc400b0019f1d624393mr1040357plo.7.1679678439735; Fri, 24 Mar
 2023 10:20:39 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Fri, 24 Mar 2023 12:20:28 -0500
Message-ID: <CAOLfK3VnoHksj2J-r-r360yJ6T6Dd1LX2iTNJ9njmmfttvc8bg@mail.gmail.com>
Subject: help with mounting subvolumes
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,

I do not use subvolumes (yet). I've searched the internet for some
tutorials on mounting subvolumes, but the documentation seems lacking.

So far, I've tried...

# btrfs subvolume create /foo
# mount -t btrfs -o subvol=foo,defaults,nodatacow
/dev/disk/by-uuid/5f33a159-4475-44e5-a5f8-40a23e18983a /mntfoo
mount: /mntfoo: mount(2) system call failed: No such file or directory.
       dmesg(1) may have more information after failed mount system call.

However /mntfoo exists:

# stat /mntfoo
  File: /mntfoo
  Size: 0               Blocks: 0          IO Block: 4096   directory
Device: 0,28    Inode: 9719644     Links: 1
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-03-23 17:10:27.323613246 -0500
Modify: 2023-03-23 17:10:27.323613246 -0500
Change: 2023-03-23 17:10:27.323613246 -0500
 Birth: 2023-03-23 17:10:27.323613246 -0500

Also, dmesg does not have any additional info on the error.

Is there canonical documentation about mounting subvolumes?

What am I missing regarding subvolumes and mounting them?

Thanks for the help!

-m
