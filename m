Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540511093D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKYS7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 13:59:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45217 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYS7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 13:59:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id 30so18381846qtz.12
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/KYYXYuqaB090SqViyroJfGxL4UJb9+gwjRE2Js0qyQ=;
        b=B1F1ncTwpXyBL58ottGEtNF2y935fWj6l5YyYNLhok6BbE6h8i0FwbN/FLYA7ncx/O
         epB6iC3357uTuqLgcxkqFNU4v2+TUudLz8fP2JFyxqeWxQm0Tyl7NaiglnV00ELksWTg
         CydK8s9szutmN4vKCKeHM55MLOA569tkCszPJVLPtj0xTAaKY1UHXokmNBLwzgo8JHlk
         XjBgeDMChNIt1GbJ2oIN53byGikt+PSQqf3l8rQJ95Erw5jJaRNm6a108oXItrRikwYm
         iWu9As+nCmtqKzrBQ88IyksPLbJfl5D2qk6G4W8UKFd8cPEYNCgbeqJqBsETglXfRP5a
         vtiQ==
X-Gm-Message-State: APjAAAXoMzaYMkz5H2+7/GW1YRRErr5OdcuL3nS6g9YyFmaskKj1vmiM
        wB+ugOqkqFesBmKn/uegrNA=
X-Google-Smtp-Source: APXvYqx72Uxx7PDJxNfrN9l1SyeOnpnUNpXj3DhvgMSP8EdvJgItcBKcT4hMTLNk4t7xidZYJfUBOQ==
X-Received: by 2002:ac8:7202:: with SMTP id a2mr27161908qtp.247.1574708374398;
        Mon, 25 Nov 2019 10:59:34 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:6080])
        by smtp.gmail.com with ESMTPSA id y21sm3872751qka.49.2019.11.25.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 10:59:33 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:59:31 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dennis@kernel.org, kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, osandov@osandov.com,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/22] btrfs: add the beginning of async discard, discard
 workqueue
Message-ID: <20191125185931.GA30548@dennisz-mbp.dhcp.thefacebook.com>
References: <201911220351.HPI9gxNo%lkp@intel.com>
 <CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 08:27:43PM -0800, Nick Desaulniers wrote:
> Hi Dennis,
> Below is a 0day bot report from a build w/ Clang. Warning looks legit,
> can you please take a look?
> 

Ah thanks for this! Yeah that was a miss when I switched from flags ->
an enum and didn't update the declaration properly. I'll be sending out
a v4 as another fix for arm has some rebase conflicts.

Is there a way to enable so I get these emails directly?

Thanks,
Dennis

> On Thu, Nov 21, 2019 at 11:27 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > CC: kbuild-all@lists.01.org
> > In-Reply-To: <63d3257efe1158a6fbbd7abe865cd9250b494438.1574282259.git.dennis@kernel.org>
> > References: <63d3257efe1158a6fbbd7abe865cd9250b494438.1574282259.git.dennis@kernel.org>
> > TO: Dennis Zhou <dennis@kernel.org>
> > CC: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Omar Sandoval <osandov@osandov.com>
> > CC: kernel-team@fb.com, linux-btrfs@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
> >
> > Hi Dennis,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on kdave/for-next]
> > [also build test WARNING on next-20191121]
> > [cannot apply to v5.4-rc8]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Dennis-Zhou/btrfs-async-discard-support/20191121-230429
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> > config: arm64-defconfig (attached as .config)
> > compiler: clang version 10.0.0 (git://gitmirror/llvm_project cf823ce4ad9d04c69b7c29d236f7b14c875111c2)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=arm64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> fs/btrfs/free-space-cache.c:3238:6: warning: variable 'trim_state' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >            if (!ret) {
> >                ^~~~
> >    fs/btrfs/free-space-cache.c:3251:53: note: uninitialized use occurs here
> >            __btrfs_add_free_space(fs_info, ctl, start, bytes, trim_state);
> >                                                               ^~~~~~~~~~
> >    fs/btrfs/free-space-cache.c:3238:2: note: remove the 'if' if its condition is always true
> >            if (!ret) {
> >            ^~~~~~~~~~
> >    fs/btrfs/free-space-cache.c:3224:2: note: variable 'trim_state' is declared here
> >            enum btrfs_trim_state trim_state;
> >            ^
> >    1 warning generated.
> >
> > vim +3238 fs/btrfs/free-space-cache.c
> >
> >   3210
> >   3211  static int do_trimming(struct btrfs_block_group *block_group,
> >   3212                         u64 *total_trimmed, u64 start, u64 bytes,
> >   3213                         u64 reserved_start, u64 reserved_bytes,
> >   3214                         enum btrfs_trim_state reserved_trim_state,
> >   3215                         struct btrfs_trim_range *trim_entry)
> >   3216  {
> >   3217          struct btrfs_space_info *space_info = block_group->space_info;
> >   3218          struct btrfs_fs_info *fs_info = block_group->fs_info;
> >   3219          struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
> >   3220          int ret;
> >   3221          int update = 0;
> >   3222          u64 end = start + bytes;
> >   3223          u64 reserved_end = reserved_start + reserved_bytes;
> >   3224          enum btrfs_trim_state trim_state;
> >   3225          u64 trimmed = 0;
> >   3226
> >   3227          spin_lock(&space_info->lock);
> >   3228          spin_lock(&block_group->lock);
> >   3229          if (!block_group->ro) {
> >   3230                  block_group->reserved += reserved_bytes;
> >   3231                  space_info->bytes_reserved += reserved_bytes;
> >   3232                  update = 1;
> >   3233          }
> >   3234          spin_unlock(&block_group->lock);
> >   3235          spin_unlock(&space_info->lock);
> >   3236
> >   3237          ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
> > > 3238          if (!ret) {
> >   3239                  *total_trimmed += trimmed;
> >   3240                  trim_state = BTRFS_TRIM_STATE_TRIMMED;
> >   3241          }
> >   3242
> >   3243          mutex_lock(&ctl->cache_writeout_mutex);
> >   3244          if (reserved_start < start)
> >   3245                  __btrfs_add_free_space(fs_info, ctl, reserved_start,
> >   3246                                         start - reserved_start,
> >   3247                                         reserved_trim_state);
> >   3248          if (start + bytes < reserved_start + reserved_bytes)
> >   3249                  __btrfs_add_free_space(fs_info, ctl, end, reserved_end - end,
> >   3250                                         reserved_trim_state);
> >   3251          __btrfs_add_free_space(fs_info, ctl, start, bytes, trim_state);
> 
> ^ oops
> 
> >   3252          list_del(&trim_entry->list);
> >   3253          mutex_unlock(&ctl->cache_writeout_mutex);
> >   3254
> >   3255          if (update) {
> >   3256                  spin_lock(&space_info->lock);
> >   3257                  spin_lock(&block_group->lock);
> >   3258                  if (block_group->ro)
> >   3259                          space_info->bytes_readonly += reserved_bytes;
> >   3260                  block_group->reserved -= reserved_bytes;
> >   3261                  space_info->bytes_reserved -= reserved_bytes;
> >   3262                  spin_unlock(&block_group->lock);
> >   3263                  spin_unlock(&space_info->lock);
> >   3264          }
> >   3265
> >   3266          return ret;
> >   3267  }
> >   3268
> >
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
