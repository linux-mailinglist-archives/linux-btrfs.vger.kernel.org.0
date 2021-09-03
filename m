Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5D3FF8E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhICCpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 22:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhICCpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 22:45:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A059C061575
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 19:44:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x5so3886040ill.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=lmVnU2K28INVw1ADSggQJxba9rMtrWNtITze4ofjzOk=;
        b=iOn9kADQstawu55uwuk/0eo7YpP3a+jvBA6TZ5VeHnK6ZgnJD0w2Zw622hTkPOf6jz
         NARtz0XApgWG7DGHZ6Msyp3iDFiyYeAeVXgshTqF9Cn2BPXtJUhznJ3DCHFhlda7NphI
         AuwYxm82TIhpymTGRE1PbJ9Q2kiTJoPMIMLNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lmVnU2K28INVw1ADSggQJxba9rMtrWNtITze4ofjzOk=;
        b=fLLJjh70Abv0l8FIRy3LQfLWowhf4CiO9tEbfyQt9Jy72cT6cs1g4vKwGqYYEYlcE4
         kL0VNxjd17SXyMqeOcrrWCjmMjlwBRBxms6W2irTQAbNI3n7s1mnl5fvyNUSwGBhwgbH
         VwbDxupxW50BRVe7R8+sVXAC/jZJXWDIH1yPaGEFQMcQr3aRcugKdgKB/t971IHNNr6W
         o25Gb52GnDGGj6HlFkE/DJf75qls555Got3ISwgZhH4ufNB6PT/fZEZHGmme5NYxRzze
         WYQxWOq2+8aKVZJTMRgAVBDbwoSF8uel1eix1AAZuFTR+9VcAJSH/jLLKqvpmoksnCRY
         iRXQ==
X-Gm-Message-State: AOAM532J/fcOnSz0TghvKkuJ/AsawMMcnhETGvWLgTlf2GJPVmrATFBN
        KlCnQJKGfSm67dQPsc/xRqhz19r0khgdLg==
X-Google-Smtp-Source: ABdhPJxrcw4wP8VSVzSnrBiV6dv2g26SHN3aDboW3TIBstnq0q+GXkR6h3NUzRb6aIJ6K7CfCuLrag==
X-Received: by 2002:a92:1944:: with SMTP id e4mr943801ilm.186.1630637046206;
        Thu, 02 Sep 2021 19:44:06 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id n11sm1984045ioo.44.2021.09.02.19.44.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 19:44:05 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id v2so3858879ilg.12
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 19:44:05 -0700 (PDT)
X-Received: by 2002:a92:8742:: with SMTP id d2mr965077ilm.58.1630637045316;
 Thu, 02 Sep 2021 19:44:05 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Wyrick <rob@wyrick.org>
Date:   Thu, 2 Sep 2021 20:43:54 -0600
X-Gmail-Original-Message-ID: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
Message-ID: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
Subject: Next steps in recovery?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I cannot mount my btrfs filesystem.
$ uname -a
Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
$ btrfs version
btrfs-progs v5.4.1

I'm seeing the following from check:
$ btrfs check -p /dev/sda
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
[1/7] checking root items                      (0:00:59 elapsed,
2649102 items checked)
ERROR: invalid generation for extent 38179182174208, have
140737491486755 expect (0, 4057084]
[2/7] checking extents                         (0:02:17 elapsed,
1116143 items checked)
ERROR: errors found in extent allocation tree or chunk allocation
cache and super generation don't match, space cache will be invalidated
[3/7] checking free space cache                (0:00:00 elapsed)
[4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
filetype 2 errors 2, no dir index
unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype 2
errors 5, no dir item, no inode ref
[4/7] checking fs roots                        (0:00:42 elapsed,
108894 items checked)
ERROR: errors found in fs roots
found 15729059057664 bytes used, error(s) found
total csum bytes: 15313288548
total tree bytes: 18286739456
total fs tree bytes: 1791819776
total extent tree bytes: 229130240
btree space waste bytes: 1018844959
file data blocks allocated: 51587230502912
 referenced 15627926712320

I've tried everything I've found on the internet, but haven't
attempted to repair based on the warnings...

What more info do you need to help me diagnose/fix this?

Thanks!
-Rob
