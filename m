Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E181C34B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEDInv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 04:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgEDInu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 04:43:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D995C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 01:43:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e26so7487934wmk.5
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ehiX/6BsorJJSQiKD1SzLDj/ZOeI4UXJNzYxBKTE/h4=;
        b=Io1HvQp30zkvU/ltsqm0FdmoMwswiGUwtLDWVF/PW8J+//v0PuuelGDEBRG4fG4YzU
         0sT+KYGaDuR76nETxVDsRtRb+l3VyTZc+ClB5DEvnIJB7auaFrt7DIcgNvGfXRk90Ilw
         hVxOekX69HuVteRUsP70CuHX8QECGXTTTemRLpuvTfUFKFBXj1X68TrFFbPS9ChuP2ki
         /SBtogRrUcTfLBeQlgQvL9uSKFtbxU3WxeQRqvrCScMrpHK/6X1IImBn2qI3yJ7PbNvn
         BkDJmzDrng/Oa19lh0h4kp/niIDsnyuldJNomPJFmbzFrH6Jed9HthY5Yt+K26GKY5xM
         O7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ehiX/6BsorJJSQiKD1SzLDj/ZOeI4UXJNzYxBKTE/h4=;
        b=aVAVT9/xL9pSvjwo3F1G/4KrXgEGaSCvSJywTi9HCa9IRmj71pyXeQAtG6uJp9r33Z
         EuWnVKLg58/1MAnV/vaiyvLTkRAJ7mr2v2XvOwMGovtLFDrQbVnwQr5E6czvl3dT863M
         Pw575QuTYo23v1ST4CpEOMUUl+JWkZJWWrC4fFDWA9sVFT4vNrnKvKp/TT/bFOtC/a0N
         UA4jIwH/XvBl9uO1Eco+q+GRznHjqj6Wuxg4cPFnInP12faXA7MR2mt5LHjwhnhYXKbL
         qyWFUQaKjfepAKFhHQxWNu0cofyPmDfbYmP0oQFz73zgGXqpH7uY7ScOBHj+VJ1zX8o1
         4lTA==
X-Gm-Message-State: AGi0Pub88Z9P1qsLnr0jAeub1UxO0emFTTRLktkVzZ/Zd6u++EfZLQZt
        M2nHpL/Q+dIoCVPVvLu5jjwMR87sFTTZwTNvdp1dng==
X-Google-Smtp-Source: APiQypJswDZ+uWQldH6qgeIw6xsz7iRwYmmZD3G2tT1rM0+eIblfvqPwhHlTnffFacaUQL0ENFUjfqDVbDWPwPz8qJE=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr13154859wmc.124.1588581828958;
 Mon, 04 May 2020 01:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
 <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
In-Reply-To: <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 02:43:32 -0600
Message-ID: <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Samples
  Children      Self  Shared Objec  Symbol
-   97.03%     0.01%  [kernel]      [k] entry_SYSCALL_64_after_hwframe

                              =E2=97=86
   - 52.00% entry_SYSCALL_64_after_hwframe

                              =E2=96=92
      - 51.95% do_syscall_64

                              =E2=96=92
         - 44.40% __x64_sys_splice

                              =E2=96=92
            - 65.95% do_splice

                              =E2=96=92
               - 31.93% mutex_unlock

                              =E2=96=92
               - 16.82% pipe_double_lock

                              =E2=96=92
                  - 10.75% mutex_lock

                              =E2=96=92
                     - 3.90% _cond_resched

                              =E2=96=92
                          1.52% rcu_all_qs

                              =E2=96=92
                  - 3.49% __mutex_lock.constprop.0

                              =E2=96=92
                       3.19% mutex_spin_on_owner

                              =E2=96=92
               - 9.99% mutex_lock

                              =E2=96=92
                  - 3.30% _cond_resched

                              =E2=96=92
                       1.07% rcu_all_qs

                              =E2=96=92
                 2.16% pipe_unlock

                              =E2=96=92
               - 1.27% __mutex_lock.constprop.0

                              =E2=96=92
                    1.25% mutex_spin_on_owner

                              =E2=96=92
         - 11.49% __x64_sys_ioctl

                              =E2=96=92
              ksys_ioctl

                              =E2=96=92
              rpc_populate.constprop.0

                              =E2=96=92
              _btrfs_ioctl_send

                              =E2=96=92
            - btrfs_ioctl_send

                              =E2=96=92
               - 12.87% process_extent

                              =E2=96=92
                  - 13.00% send_extent_data

                              =E2=96=92
                     - 4.72% send_cmd

                              =E2=96=92
                        - 4.64% kernel_write

                              =E2=96=92
                           - 4.73% vfs_write

                              =E2=96=92
                              - 4.52% new_sync_write

                              =E2=96=92
                                 - 4.83% pipe_write

                              =E2=96=92
                                    - 1.89% copy_page_from_iter

                              =E2=96=92
                                       - 3.13% _copy_from_iter

                              =E2=96=92
                                            2.93% memcpy_erms

                              =E2=96=92
                                    - 1.29% __alloc_pages_nodemask

                              =E2=96=92
                                         1.05% get_page_from_freelist

                              =E2=96=92
                                    - 0.72% schedule

                              =E2=96=92
                                         0.77% __schedule

                              =E2=96=92
                     - 2.72% __do_page_cache_readahead

                              =E2=96=92
                        - 2.07% read_pages.isra.0

                              =E2=96=92
                           - 2.05% extent_readpages

                              =E2=96=92
For a higher level overview, try: perf top --sort comm,dso

                              =E2=96=92
