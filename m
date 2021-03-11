Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23D5337B28
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 18:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCKRlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 12:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCKRlo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 12:41:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FC06600CC
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615484504;
        bh=nXAgEbXTIBrXznuJtCFAtv+CfDVu5ti/Z8DjMvEfOkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tdi34esKbvYs4brZu8RcKsIsi5tNwRVALtWsHcwa68lXGxIZutdTozENyedpyul9O
         QbMl4hOxC/Z8crVsSq6P0/6JzpDAzDn+W2huK7wg6+kf0wd/LFHlwMnIyHHXrH3ndq
         uq81aigQLOD8KhQ6cZU/8nCEi9EIrONqG+k1gvmt04JzhYVjst1rs488X6z6bNGncF
         OTb5h/LtFkyZd5EkRx7ClUuHL4Jvko2fNQNtfz/2wttMq1PX6hs0YFSimwjMiTZ6Yi
         +YmoSMzbaAf+wNzQm8R8f1oltwlRLW/Fzu1Fi3PqNIJpXECz3yRjAtvVTaLTgWBa8w
         9jh+JK8QuRtJg==
Received: by mail-qk1-f169.google.com with SMTP id b130so21444306qkc.10
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 09:41:44 -0800 (PST)
X-Gm-Message-State: AOAM5324Zojo4nvnRG3yU0id0uWz1AoacBi0/Y2df8sYUMBYBQk70jk3
        72e7uHux8uSUtuRFUZQxrf0Z+qTh9Vy+ZSo57Ng=
X-Google-Smtp-Source: ABdhPJzDTI26iTCeiokQrK/tMk89Ssjc3tAt/DzgIqtWPRE3gS/sIv1wOcKwGvwCSTPKVrnT/1nV3aZVc6miZQ1HQcY=
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr8944299qke.383.1615484503318;
 Thu, 11 Mar 2021 09:41:43 -0800 (PST)
MIME-Version: 1.0
References: <ac64033d4afeff5c10c4993323e7c1a388304aff.1615472583.git.fdmanana@suse.com>
 <202103120146.nWyeg1sH-lkp@intel.com>
In-Reply-To: <202103120146.nWyeg1sH-lkp@intel.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 11 Mar 2021 17:41:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4RRn5PWKVRcNWKG5Q-jNxjtp+3Bj2MmExXLM=iNDg9gg@mail.gmail.com>
Message-ID: <CAL3q7H4RRn5PWKVRcNWKG5Q-jNxjtp+3Bj2MmExXLM=iNDg9gg@mail.gmail.com>
Subject: Re: [PATCH 3/9] btrfs: move the tree mod log code into its own file
To:     kernel test robot <lkp@intel.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kbuild-all@lists.01.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 5:27 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on v5.12-rc2]
> [also build test WARNING on next-20210311]
> [cannot apply to kdave/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/fdmanana-kernel-org/btrfs-bug-fixes-for-the-tree-mod-log-and-small-refactorings/20210311-223429
> base:    a38fd8748464831584a19438cbb3082b5a2dab15
> config: x86_64-randconfig-m001-20210311 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> smatch warnings:
> fs/btrfs/tree-mod-log.c:286 btrfs_tree_mod_log_insert_move() warn: missing error code 'ret'
> fs/btrfs/tree-mod-log.c:519 btrfs_tree_mod_log_eb_copy() warn: missing error code 'ret'
> fs/btrfs/tree-mod-log.c:577 btrfs_tree_mod_log_free_eb() warn: missing error code 'ret'

No, those are all ok.
For all cases, 'ret' was initialized to 0 when declared, and that's
what we want to return when tree_mod_dont_log() returns true.

>
> vim +/ret +286 fs/btrfs/tree-mod-log.c
>
>    246
>    247  int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
>    248                                     int dst_slot, int src_slot,
>    249                                     int nr_items)
>    250  {
>    251          struct tree_mod_elem *tm = NULL;
>    252          struct tree_mod_elem **tm_list = NULL;
>    253          int ret = 0;
>    254          int i;
>    255          int locked = 0;
>    256
>    257          if (!tree_mod_need_log(eb->fs_info, eb))
>    258                  return 0;
>    259
>    260          tm_list = kcalloc(nr_items, sizeof(struct tree_mod_elem *), GFP_NOFS);
>    261          if (!tm_list)
>    262                  return -ENOMEM;
>    263
>    264          tm = kzalloc(sizeof(*tm), GFP_NOFS);
>    265          if (!tm) {
>    266                  ret = -ENOMEM;
>    267                  goto free_tms;
>    268          }
>    269
>    270          tm->logical = eb->start;
>    271          tm->slot = src_slot;
>    272          tm->move.dst_slot = dst_slot;
>    273          tm->move.nr_items = nr_items;
>    274          tm->op = BTRFS_MOD_LOG_MOVE_KEYS;
>    275
>    276          for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
>    277                  tm_list[i] = alloc_tree_mod_elem(eb, i + dst_slot,
>    278                      BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING, GFP_NOFS);
>    279                  if (!tm_list[i]) {
>    280                          ret = -ENOMEM;
>    281                          goto free_tms;
>    282                  }
>    283          }
>    284
>    285          if (tree_mod_dont_log(eb->fs_info, eb))
>  > 286                  goto free_tms;
>    287          locked = 1;
>    288
>    289          /*
>    290           * When we override something during the move, we log these removals.
>    291           * This can only happen when we move towards the beginning of the
>    292           * buffer, i.e. dst_slot < src_slot.
>    293           */
>    294          for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
>    295                  ret = tree_mod_log_insert(eb->fs_info, tm_list[i]);
>    296                  if (ret)
>    297                          goto free_tms;
>    298          }
>    299
>    300          ret = tree_mod_log_insert(eb->fs_info, tm);
>    301          if (ret)
>    302                  goto free_tms;
>    303          write_unlock(&eb->fs_info->tree_mod_log_lock);
>    304          kfree(tm_list);
>    305
>    306          return 0;
>    307  free_tms:
>    308          for (i = 0; i < nr_items; i++) {
>    309                  if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
>    310                          rb_erase(&tm_list[i]->node, &eb->fs_info->tree_mod_log);
>    311                  kfree(tm_list[i]);
>    312          }
>    313          if (locked)
>    314                  write_unlock(&eb->fs_info->tree_mod_log_lock);
>    315          kfree(tm_list);
>    316          kfree(tm);
>    317
>    318          return ret;
>    319  }
>    320
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
