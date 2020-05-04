Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57101C344D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEDIZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 04:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDIZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 04:25:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A4C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 01:25:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so7428460wmk.5
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qtWRGm059oiS4ZjWBkmPkg6BCVa3uwP55uEIcAaxgV8=;
        b=1HIHRQKVKuQBT7Z15VwMvCsC+kuQbcupVvnma6TA8OSlYuor00yF2vuYKRkPgr+KKO
         35ujHQw3YZVMe0psHdqeoyMPz3lWVyg+uZbCYkyJROnPOpEaB1Uwbx3sdxVJRuT5Rf5t
         y6KmRIxPL+CyYJ+yyxQ6APfh4wTkNpt256wdZpOrY7KlQpDmcgIGPLaScTOojIjbmfb8
         vRhIPpmyRfhFIP+LnqskHilmX/YCIXlVtLjX7ZkqLUde+9qlFtRJmCVozSVZXl3mj4o9
         pHl/KdDBaKth9qq5mFs1uNq7OeF6c3otQlJORQE8648V4yJlEThA8fReAED4RJogBE2c
         i7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qtWRGm059oiS4ZjWBkmPkg6BCVa3uwP55uEIcAaxgV8=;
        b=PXr8ZlpZFSIuZ3PEpBWXT4jE8cJLYgRk3IfivZpgyO+JF7Ug1d/AuiRhSCvBezlpxC
         67SaKMpqjZKkwNx20/JX57UCAIvCEDbnvMz+6upEM1LmW8oXw9hoAbY5UaOM4wb8aq8K
         VwStbeVPu/6SVx+Hv5ZxIfHuw+hQPqhlvUKE5hb8Kv+pHjGKG18SkbUjL2+lBXuI4Y3H
         L4CJi3rE2OCUJ0OJEswlSGG4IIkm4RWLtZy12aDL6mYDvHqa6mLUxDFMmJjgRIDJ/XGR
         Jrb9ihpZeMLKc90aTTSOwZgufNwYqIx3CRna8ZO30sdL/f/Xe5nkwul10dIiY75pmWEH
         gY8w==
X-Gm-Message-State: AGi0PuZsh6ZiwMPt3P5Ad5K8qHcrFnJOC4M3AYR1Eit/l7vxZQbn6gVC
        /QKkXsUuc7YxU8wvVfA/vHooQ2C60GpfaP7SX3C+VQ==
X-Google-Smtp-Source: APiQypIS5J6gOHvFjUpvSQIhdKvFurHZqrgTkZHVQ8VMRg5t80ulnVxoD+sjIzpepIcrBrPgTloFgGLkgSzgRlYaoOs=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr13100586wmy.168.1588580748003;
 Mon, 04 May 2020 01:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com> <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com>
In-Reply-To: <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 02:25:31 -0600
Message-ID: <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 4, 2020 at 2:13 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 4.05.20 =D0=B3. 11:03 =D1=87., Chris Murphy wrote:
> > receive (rw,noatime,seclabel,compress-force=3Dzstd:5,space_cache=3Dv2,s=
ubvolid=3D5,subvol=3D/)
> > send    (rw,noatime,seclabel,compress=3Dzstd:1,nossd,notreelog,space_ca=
che=3Dv2,subvolid=3D5,subvol=3D/)
> >
> > Both are on dm-crypt.
> >
> > perf top -g -U consumes about 85% CPU according to top, and every time
> > I run it, the btrfs send performance *increases*. When I cancel this
> > perf top command, it returns to the slower performance. Curious.
> >
>
> Well this still doesn't show the stack traces, after all the + sign
> means you can expand that (with the 'e' key). But looking at this I
> don't see any particular lock contention - just compression-related
> functions.

I'm not sure which ones...

Samples
  Children      Self  Shared Object       Symbol
-   62.58%     0.10%  [kernel]            [k]
entry_SYSCALL_64_after_hwframe
                                                       =E2=97=86
   - 62.47% entry_SYSCALL_64_after_hwframe

                              =E2=96=92
      - 62.17% do_syscall_64

                              =E2=96=92
         - 23.84% ksys_read

                              =E2=96=92
            - 23.62% vfs_read

                              =E2=96=92
               - 14.79% proc_reg_read

                              =E2=96=92
                  - seq_read

                              =E2=96=92
                     - 7.07% s_show

                              =E2=96=92
                        - seq_printf

                              =E2=96=92
                           - vsnprintf

                              =E2=96=92
                                1.87% format_decode

                              =E2=96=92
                                1.49% number

                              =E2=96=92
                                0.84% string

                              =E2=96=92
                                0.68% memcpy_erms

                              =E2=96=92
                     - 6.23% s_next

                              =E2=96=92
                        - update_iter

                              =E2=96=92
                             4.49% module_get_kallsym

                              =E2=96=92
                             1.41% kallsyms_expand_symbol.constprop.0

                              =E2=96=92
                     - 0.79% s_start

                              =E2=96=92
                        - update_iter

                              =E2=96=92
                             0.57% module_get_kallsym

                              =E2=96=92
               - 8.38% new_sync_read

                              =E2=96=92
                  - 8.35% pipe_read

                              =E2=96=92
                     - 6.46% __mutex_lock.constprop.0

                              =E2=96=92
                          6.33% mutex_spin_on_owner

                              =E2=96=92
                     - 0.86% copy_page_to_iter

                              =E2=96=92
                        - 0.78% copyout

                              =E2=96=92
                             0.77% copy_user_enhanced_fast_string

                              =E2=96=92
         - 17.96% __x64_sys_splice

                              =E2=96=92
            - 17.92% do_splice

                              =E2=96=92
                 7.80% mutex_unlock

                              =E2=96=92
               - 4.55% pipe_double_lock

                              =E2=96=92
                  - 2.88% mutex_lock

                              =E2=96=92
                       0.95% _cond_resched

                              =E2=96=92
               - 2.61% mutex_lock

                              =E2=96=92
                    0.82% _cond_resched

                              =E2=96=92
                 0.52% pipe_unlock

                              =E2=96=92
         - 9.80% __x64_sys_ioctl

                              =E2=96=92
            - ksys_ioctl

                              =E2=96=92
               - 9.79% rpc_populate.constprop.0

                              =E2=96=92
For a higher level overview, try: perf top --sort comm,dso

                              =E2=96=92


--=20
Chris Murphy
