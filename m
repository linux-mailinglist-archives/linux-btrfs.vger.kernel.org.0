Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00543FF8F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 04:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbhICCsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 22:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhICCsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 22:48:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B92C061575
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 19:47:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id j18so5098201ioj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=V2KoVtGsZOwyOhko1TYvAtxndIgeFSxMxlJrZxVBuJw=;
        b=gbqvCjbvDJwj4Wtzfu1TkF+ewU8448owkDBOeq7UYZ3JYdIwa3cRN3be25jkx9c3PK
         J1/75xeTgmq2ONMz4T5Lt19lRa2Dv/IvfXTW4WoWdVXJm80POW8xRU3p4Wo/YaeqbJ7Q
         0sHxS4wsGnCsx13nSc1HCy9DvfIs1MA/aNcHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=V2KoVtGsZOwyOhko1TYvAtxndIgeFSxMxlJrZxVBuJw=;
        b=LKr1qt/0d0Uv60BZs7VVuvFTAChLgS9pVMtLYVwW62WWEeGxH3J44dfNhub66fyexW
         CFVI1xDbm/0M7GBNp5kwWHABqrzK0lhbUipS90bN3rl0N2TvFkMrDjFFAgB43Yjad+Yb
         OBbVFd0FTcTFcXkArQbKFkBadyADI8xLhTpym/CDHaGKamTxGHp8Q/hbZSOBmMA8+jhu
         VoXO17ouhTo1x9lJOERFYHmITF7CKjCg0uDk8RWc+POSNJsYSAmHczK39X7fUJLEQnNX
         HbG6cQvvFD2rTx/A5AGNqAC/ZflngY9tZgAC633/WYEEO+zCfSBDx1zZYghQUo7AyG9w
         nb/Q==
X-Gm-Message-State: AOAM531ZTrYSR08vroF9OMe4iS9w+b5mC30guIMIfrcVkr2HJOOmKktz
        Jyw7VCBOUFTiFh7Qd5H1RpwneFiJHCTb4A==
X-Google-Smtp-Source: ABdhPJzEWITUS8KbkcfU/mj1W1jPIvVDa1+P0FYvWoDyDBLQbKO+Z2ZlTDk+dG0YGRn1HnEmHTi2SA==
X-Received: by 2002:a05:6638:1301:: with SMTP id r1mr794701jad.32.1630637244685;
        Thu, 02 Sep 2021 19:47:24 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id d8sm1837398ilv.55.2021.09.02.19.47.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 19:47:24 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id s16so3883659ilo.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 19:47:24 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bc8:: with SMTP id x8mr922905ilv.138.1630637243712;
 Thu, 02 Sep 2021 19:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
In-Reply-To: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Thu, 2 Sep 2021 20:47:12 -0600
X-Gmail-Original-Message-ID: <CAA_aC983F+bZ-wQVMpm9j=ce0xEMaHu6PUYRauB9u65bsubnTw@mail.gmail.com>
Message-ID: <CAA_aC983F+bZ-wQVMpm9j=ce0xEMaHu6PUYRauB9u65bsubnTw@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One more thing of note.  I was running linux kernel 4.15.? when things
went bad.  I upgraded hoping that the newer tools could fix things.

On Thu, Sep 2, 2021 at 8:43 PM Robert Wyrick <rob@wyrick.org> wrote:
>
> I cannot mount my btrfs filesystem.
> $ uname -a
> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> $ btrfs version
> btrfs-progs v5.4.1
>
> I'm seeing the following from check:
> $ btrfs check -p /dev/sda
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> [1/7] checking root items                      (0:00:59 elapsed,
> 2649102 items checked)
> ERROR: invalid generation for extent 38179182174208, have
> 140737491486755 expect (0, 4057084]
> [2/7] checking extents                         (0:02:17 elapsed,
> 1116143 items checked)
> ERROR: errors found in extent allocation tree or chunk allocation
> cache and super generation don't match, space cache will be invalidated
> [3/7] checking free space cache                (0:00:00 elapsed)
> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
> filetype 2 errors 2, no dir index
> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype 2
> errors 5, no dir item, no inode ref
> [4/7] checking fs roots                        (0:00:42 elapsed,
> 108894 items checked)
> ERROR: errors found in fs roots
> found 15729059057664 bytes used, error(s) found
> total csum bytes: 15313288548
> total tree bytes: 18286739456
> total fs tree bytes: 1791819776
> total extent tree bytes: 229130240
> btree space waste bytes: 1018844959
> file data blocks allocated: 51587230502912
>  referenced 15627926712320
>
> I've tried everything I've found on the internet, but haven't
> attempted to repair based on the warnings...
>
> What more info do you need to help me diagnose/fix this?
>
> Thanks!
> -Rob
