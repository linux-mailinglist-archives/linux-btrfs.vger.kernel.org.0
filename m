Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986BE1C6794
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 07:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEFFsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 01:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgEFFsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 01:48:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451E6C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 22:48:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s8so611236wrt.9
        for <linux-btrfs@vger.kernel.org>; Tue, 05 May 2020 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nb+ZAsd+36az6v5YABcysXKinaFM9KUQkzrdaFAWvl4=;
        b=TDE0BXVyXxJjxxkYnEVBCw4QEwsUIbYWLsgu63wzIpLXab4dWWhQEvuIi7dZwp2Vl+
         Ijk4wykzW+v5CqR1JCZf9b/BRPVly6ecn/zJv2uH7iVkzM9yf1JNeygE4ydzuGQseiYu
         zqWtc/UkHrhMiqTKkU/A8c4x9DA35lNgRo9HhjNMMaoBQEsOoXE29hSsl+WKnCi1y0Sm
         IJmaxs4bdbuMapjlLP0GT3VuKA6N0NqtxX9+LsseXAfq8HxRCvHO4XZL2f82G2grLswK
         +fBLXVSh5lQJeSVVFTGnRzMcWoQjey+R+Ai+tsdbuo/I6NQJijsrj2+yfxUMpwsHHCKb
         XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nb+ZAsd+36az6v5YABcysXKinaFM9KUQkzrdaFAWvl4=;
        b=PhXD3nvuhGEhM+kp9uRqZvXgWaqDuCk7wsWHBdBuWcCPMuIeLLBqtz8gYww+i1KokP
         pyrjvemEocMWKUXN0E+WWjlTMEIsexgocA6W2TROO3HUp97b7k/4slggTUMvRAmYtmCn
         2tI3oSXNHWbRzHxI17pc+GKfum6mJijZiIsfFWeGHob1MjoFrmELvHqgtWXOkERlRSCR
         emuayaYeP9HD8OaUl5dOzshzjYLN6YFvK6Wiev9MEdOfmAZ2apcotE4czQqOIyS+0F5W
         9IQC5ec0lPFuqwLZRB4y/UapNykQ5tdFQ8NW/BsQZ2b6PD1B4V2lFeAlajiMX6OW5inA
         9XRg==
X-Gm-Message-State: AGi0Pua9osRJEf5ige2AxPQe5uNj++3yvH6v+JJqz22SaAI+RLx0815B
        sBniOyyII5h+DkrUtSvlyd69oo70CW1ciSg+coTQdw==
X-Google-Smtp-Source: APiQypLW92g+MhcLzHa9XkDdg9PiMhUSnGqj6MLaDiI39mCkY574pwgufgCbmU39hNLL6fdqjOywq3/Hjq4ejW2II4I=
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr2719966wrv.252.1588744098013;
 Tue, 05 May 2020 22:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
 <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
 <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com>
In-Reply-To: <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 5 May 2020 23:48:01 -0600
Message-ID: <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs-5.6-1.fc32.x86_64
kernel-5.6.8-300.fc32.x86_64

I've created a new file system, filled it with ~600G, set the seed
flag, and I'm creating a sprout by adding a 2nd device and removing
the 1st. This used to go at device speeds. Today it's running at
~35M/s where I expect 95-120M/s. I don't know that it's related to
send/receive performance.

The remove process with 'perf top -g -U' is only using 7% CPU, unlike
the send/receive cases.

Samples
  Children      Self  Shared Objec  Symbol
-   82.39%     0.04%  [kernel]      [k] relocate_block_group
   - 17.88% relocate_block_group
      - 7.78% prepare_to_relocate
         - 7.21% btrfs_commit_transaction
            - 7.51% btrfs_run_delayed_refs
               - __btrfs_run_delayed_refs
                  - 3.19% __tracepoint_kvm_mmu_spte_requested
                     - 3.15% pipapo_get.constprop.0
                        - 3.57% __add_to_free_space_tree
                             3.61% btrfs_del_items
                             1.37% btrfs_insert_empty_items
                  - 1.41% __tracepoint_kvm_entry
                    0.92% __tracepoint_kvm_apic_accept_irq
      - 6.41% relocate_data_extent
         - 7.52% relocate_file_extent_cluster
            - 2.35% __do_page_cache_readahead
               - 1.70% read_pages.isra.0
                  - 2.03% extent_readpages
                       1.32% __do_readpage
                 0.93% __alloc_pages_nodemask
            - 1.67% clear_extent_bit
                 1.92% __clear_extent_bit
            - 1.40% lock_extent_bits
                 1.59% __set_extent_bit
              1.19% btrfs_delalloc_reserve_metadata
              1.15% __set_page_dirty_nobuffers
      - 2.23% prepare_to_merge
         - 1.84% btrfs_commit_transaction
            - 2.15% btrfs_run_delayed_refs
               - __btrfs_run_delayed_refs
                    1.47% __btrfs_inc_extent_ref.isra.0
+   38.75%     0.47%  [kernel]      [k] __btrfs_run_delayed_refs
+   32.98%     0.21%  [kernel]      [k] relocate_file_extent_cluster
+   29.88%     0.00%  [kernel]      [k] relocate_data_extent
+   21.63%     0.00%  libc-2.31.so  [.] __GI___ioctl
+   21.46%     0.00%  [kernel]      [k] entry_SYSCALL_64_after_hwframe
+   21.46%     0.00%  [kernel]      [k] do_syscall_64
+   21.46%     0.00%  [kernel]      [k] __x64_sys_ioctl
+   21.46%     0.00%  [kernel]      [k] ksys_ioctl
+   21.46%     0.00%  [kernel]      [k] rpc_info_open
+   21.46%     0.00%  [kernel]      [k] btrfs_rm_device
For a higher level overview, try: perf top --sort comm,dso


And also running perf doesn't improve performance, which it does
rather remarkably for send/receive.


--
Chris Murphy
