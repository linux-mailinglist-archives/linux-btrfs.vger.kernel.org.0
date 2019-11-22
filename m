Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389B2105F37
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 05:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKVE16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 23:27:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42401 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVE15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 23:27:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so2559126plt.9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 20:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMVG6+Kx1xhwjBWiCA3I3pAlD6vo349K1VEd3grV/SA=;
        b=iiAAKav/zFBWk2bWkyI+jpwsSZx7YQ+pL6pveRk/bTsfrXLwToOL8PIoy8uOuLSpaH
         Dyjb6EZOiCyQZ5LicenIhwqrfEqHne4Ms6de0P+m+ptPLGIYW0nDcW6L+d7hEdLHHMGC
         T9c8VcRf7uagHA0MkMonkIaMrcUT5DqTLo35zjw+d8X4xtQ8F4T/HWvLvhtmwyfHRUHP
         AiLeltEpvOVvOO0ojASWnbRzl7OFv+yQ3fSh55IZ7Vns3I2xaWDqtvg4z1h4hWywkX03
         gvOwY9mxfhdEdWNaXR1/MN2yqd34Vbsqcgro34VjTZKrdTpT8vIgVawn+F7AIFiBJAfH
         SWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMVG6+Kx1xhwjBWiCA3I3pAlD6vo349K1VEd3grV/SA=;
        b=RwNb42IDYWV0PirAnfWQ9TRw5zdpXDUGt3cUA8GtHR3hM9Y6tAVZepeQcSovti61IT
         BYy+bDpH56FFCWhpf712KyrVRj9gokARdVPQZ20AW9hnFiJoXM/2KJVIYpb4ULAbpaJP
         aluAMU8ylP7mYpAPp6yCngHCXO/boML073bDOkyuoi3K1OKHu5T8hHIjD8J3chXLxLfP
         +8QzEkrlQvljsXjYZLLmmFXRerZTqrLERynVJRcEozgc5Mp9fKgYqf7b3PSOCmIrNpya
         NfsR24L2jIRrezd5r1rBUppOYbiere7++uJ53l2PbA8X1lVQq2vyIq/P6j7kRX7Twdh+
         4OCQ==
X-Gm-Message-State: APjAAAUF8K+FTaznRtH0WGZ9ulXy2kdpDqafdIKA0Ai+R0PCBuk0FfVg
        9KLPXnDbYOwplFwz6BbWtr1ptgMJ8mGcowHW0RlVgw==
X-Google-Smtp-Source: APXvYqwKPdD8Om7y8KR1Pys2eGj5h7bV1NruwKpmk9y9Um1R3x3XxAJJWi/in81KPsNXlYMSSP8DAr1ZyzHIyTtDidw=
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr11787383plo.119.1574396875002;
 Thu, 21 Nov 2019 20:27:55 -0800 (PST)
MIME-Version: 1.0
References: <201911220351.HPI9gxNo%lkp@intel.com>
In-Reply-To: <201911220351.HPI9gxNo%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Nov 2019 20:27:43 -0800
Message-ID: <CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com>
Subject: Re: [PATCH 05/22] btrfs: add the beginning of async discard, discard workqueue
To:     dennis@kernel.org
Cc:     kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, osandov@osandov.com,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Dennis,
Below is a 0day bot report from a build w/ Clang. Warning looks legit,
can you please take a look?

On Thu, Nov 21, 2019 at 11:27 AM kbuild test robot <lkp@intel.com> wrote:
>
> CC: kbuild-all@lists.01.org
> In-Reply-To: <63d3257efe1158a6fbbd7abe865cd9250b494438.1574282259.git.dennis@kernel.org>
> References: <63d3257efe1158a6fbbd7abe865cd9250b494438.1574282259.git.dennis@kernel.org>
> TO: Dennis Zhou <dennis@kernel.org>
> CC: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Omar Sandoval <osandov@osandov.com>
> CC: kernel-team@fb.com, linux-btrfs@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
>
> Hi Dennis,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on next-20191121]
> [cannot apply to v5.4-rc8]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Dennis-Zhou/btrfs-async-discard-support/20191121-230429
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> config: arm64-defconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project cf823ce4ad9d04c69b7c29d236f7b14c875111c2)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> fs/btrfs/free-space-cache.c:3238:6: warning: variable 'trim_state' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>            if (!ret) {
>                ^~~~
>    fs/btrfs/free-space-cache.c:3251:53: note: uninitialized use occurs here
>            __btrfs_add_free_space(fs_info, ctl, start, bytes, trim_state);
>                                                               ^~~~~~~~~~
>    fs/btrfs/free-space-cache.c:3238:2: note: remove the 'if' if its condition is always true
>            if (!ret) {
>            ^~~~~~~~~~
>    fs/btrfs/free-space-cache.c:3224:2: note: variable 'trim_state' is declared here
>            enum btrfs_trim_state trim_state;
>            ^
>    1 warning generated.
>
> vim +3238 fs/btrfs/free-space-cache.c
>
>   3210
>   3211  static int do_trimming(struct btrfs_block_group *block_group,
>   3212                         u64 *total_trimmed, u64 start, u64 bytes,
>   3213                         u64 reserved_start, u64 reserved_bytes,
>   3214                         enum btrfs_trim_state reserved_trim_state,
>   3215                         struct btrfs_trim_range *trim_entry)
>   3216  {
>   3217          struct btrfs_space_info *space_info = block_group->space_info;
>   3218          struct btrfs_fs_info *fs_info = block_group->fs_info;
>   3219          struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>   3220          int ret;
>   3221          int update = 0;
>   3222          u64 end = start + bytes;
>   3223          u64 reserved_end = reserved_start + reserved_bytes;
>   3224          enum btrfs_trim_state trim_state;
>   3225          u64 trimmed = 0;
>   3226
>   3227          spin_lock(&space_info->lock);
>   3228          spin_lock(&block_group->lock);
>   3229          if (!block_group->ro) {
>   3230                  block_group->reserved += reserved_bytes;
>   3231                  space_info->bytes_reserved += reserved_bytes;
>   3232                  update = 1;
>   3233          }
>   3234          spin_unlock(&block_group->lock);
>   3235          spin_unlock(&space_info->lock);
>   3236
>   3237          ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
> > 3238          if (!ret) {
>   3239                  *total_trimmed += trimmed;
>   3240                  trim_state = BTRFS_TRIM_STATE_TRIMMED;
>   3241          }
>   3242
>   3243          mutex_lock(&ctl->cache_writeout_mutex);
>   3244          if (reserved_start < start)
>   3245                  __btrfs_add_free_space(fs_info, ctl, reserved_start,
>   3246                                         start - reserved_start,
>   3247                                         reserved_trim_state);
>   3248          if (start + bytes < reserved_start + reserved_bytes)
>   3249                  __btrfs_add_free_space(fs_info, ctl, end, reserved_end - end,
>   3250                                         reserved_trim_state);
>   3251          __btrfs_add_free_space(fs_info, ctl, start, bytes, trim_state);

^ oops

>   3252          list_del(&trim_entry->list);
>   3253          mutex_unlock(&ctl->cache_writeout_mutex);
>   3254
>   3255          if (update) {
>   3256                  spin_lock(&space_info->lock);
>   3257                  spin_lock(&block_group->lock);
>   3258                  if (block_group->ro)
>   3259                          space_info->bytes_readonly += reserved_bytes;
>   3260                  block_group->reserved -= reserved_bytes;
>   3261                  space_info->bytes_reserved -= reserved_bytes;
>   3262                  spin_unlock(&block_group->lock);
>   3263                  spin_unlock(&space_info->lock);
>   3264          }
>   3265
>   3266          return ret;
>   3267  }
>   3268
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation



-- 
Thanks,
~Nick Desaulniers
