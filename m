Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD44623E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 23:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhK2WFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 17:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhK2WDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 17:03:55 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51061C0619FA
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 11:33:46 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p8so23054696ljo.5
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 11:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Jm6GX4/oHsxujBWD+qUbtj54rsVwLjbslTkW7nhlF4=;
        b=LjKYtNYC60XJslQhF2XjHI6lQCBM9vN7gQDMasNVhr9DeEwUW+Dn9gjSSR0UwUwSFl
         5e0up/XZx7WOXT2dak4X7GfvkGDnOadE6syLqPIM5N1yUeKL2ULRbA3DEAfGpVxMnDEn
         t7NuUbcE2gzVBSp2M9xeM6mFOABao9S0aTXDWeQL0q6mJk4oy+EkKZccr9DmAINdPU/m
         b7tOuJDtyg4qqISpP6p+Rq6TpPOgAQsuh+rVsq0U4Bu7ldaHmsA1fD/vnTvPeiavZ/aF
         fGD+HeSCdsLADR4UlVRUvW1mjM396jIftWBPyXR7hABja9z2MocCUXPkh+veYSbROpwr
         5EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Jm6GX4/oHsxujBWD+qUbtj54rsVwLjbslTkW7nhlF4=;
        b=u6/eRPI19BfeUxs8Ml4QvvgF6hV/p+yBBd85Rg1551/74GmimNRfYzSQmNPTFIvDD+
         VFp0MZ+yOUzMT3rtjXRSPsyK7sSNI3ZdrGTxDvWN0aX2aexcuwv0LrL/cEvd3ZBtk9a9
         hlBAFnz9/siPnkZCcT8vQswJ11EFZHl+VETVzF7BTT4sknRkAXMBDHo6R+vgYigYkPJn
         917tcrIlkcRawFOIortPiXMrcuzGaHV3dpFozrAj8PyHj7T7O/2J/g8AgmASMPLWJd4l
         iMgTAWPRdEye8AokDUmKPeA+CxSWJgakd+wWeCxw1G6Wv+f69ejcX5OGZ5SS53V/OSMb
         7xgQ==
X-Gm-Message-State: AOAM532hUNGGLO1R7JuHoY9BVYqtwGwX48GGMW4bgtOqnLsbWgxfZdvp
        6r4S2xE0f7CX+P6QgNpdfZTUewxBfUrrO4d9nAebkQ==
X-Google-Smtp-Source: ABdhPJxqq2X6mv7AUaMWXJlKtEXpVQ0OVwGJX4gP+7/WswrNaa/In2JlrveShU6maJJbrbgu+BibdFpj5ogLSmujP6M=
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr52038188ljo.220.1638214424071;
 Mon, 29 Nov 2021 11:33:44 -0800 (PST)
MIME-Version: 1.0
References: <202111270255.UYOoN5VN-lkp@intel.com>
In-Reply-To: <202111270255.UYOoN5VN-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Nov 2021 11:33:32 -0800
Message-ID: <CAKwvOdm7L4_q=+P0HWRVK6YdyZwpsTiTRCf=TggqaAqEqA_wSw@mail.gmail.com>
Subject: Re: fs/btrfs/inode.c:569:2: error: call to __compiletime_assert_921
 declared with 'error' attribute: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED %
 PAGE_SIZE) != 0
To:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>, Chris Mason <clm@fb.com>,
        Brian Cain <bcain@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 26, 2021 at 10:22 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a4849f6000e29235a2707f22e39da6b897bb9543
> commit: b83a908498d68fafca931e1276e145b339cac5fb compiler_attributes.h: move __compiletime_{error|warning}
> date:   3 months ago
> config: hexagon-randconfig-r034-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270255.UYOoN5VN-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b83a908498d68fafca931e1276e145b339cac5fb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b83a908498d68fafca931e1276e145b339cac5fb
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/ prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> fs/btrfs/inode.c:569:2: error: call to __compiletime_assert_921 declared with 'error' attribute: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
>            BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0);
>            ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>            ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^
>    include/linux/compiler_types.h:322:2: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ^
>    include/linux/compiler_types.h:310:2: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ^
>    include/linux/compiler_types.h:303:4: note: expanded from macro '__compiletime_assert'
>                            prefix ## suffix();                             \
>                            ^
>    <scratch space>:59:1: note: expanded from here
>    __compiletime_assert_921
>    ^
> >> fs/btrfs/inode.c:569:2: error: call to __compiletime_assert_921 declared with 'error' attribute: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>            ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^
>    include/linux/compiler_types.h:322:2: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ^
>    include/linux/compiler_types.h:310:2: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ^
>    include/linux/compiler_types.h:303:4: note: expanded from macro '__compiletime_assert'
>                            prefix ## suffix();                             \
>                            ^
>    <scratch space>:59:1: note: expanded from here
>    __compiletime_assert_921
>    ^

Filed https://github.com/ClangBuiltLinux/linux/issues/1518 for now.
But when I run `make olddefconfig` with the provided randconfig, I do
see the following Kconfig warnings:

WARNING: unmet direct dependencies detected for BTRFS_FS
  Depends on [n]: BLOCK [=y] && !PPC_256K_PAGES && !PAGE_SIZE_256KB [=y]
  Selected by [m]:
  - TEST_KMOD [=m] && RUNTIME_TESTING_MENU [=y] && m && MODULES [=y]
&& NETDEVICES [=y] && NET_CORE [=y] && INET [=y] && BLOCK [=y]

WARNING: unmet direct dependencies detected for BTRFS_FS
  Depends on [n]: BLOCK [=y] && !PPC_256K_PAGES && !PAGE_SIZE_256KB [=y]
  Selected by [m]:
  - TEST_KMOD [=m] && RUNTIME_TESTING_MENU [=y] && m && MODULES [=y]
&& NETDEVICES [=y] && NET_CORE [=y] && INET [=y] && BLOCK [=y]

WARNING: unmet direct dependencies detected for BTRFS_FS
  Depends on [n]: BLOCK [=y] && !PPC_256K_PAGES && !PAGE_SIZE_256KB [=y]
  Selected by [m]:
  - TEST_KMOD [=m] && RUNTIME_TESTING_MENU [=y] && m && MODULES [=y]
&& NETDEVICES [=y] && NET_CORE [=y] && INET [=y] && BLOCK [=y]

It looks like CONFIG_BLOCK=y, CONFIG_PPC_256K_PAGES=n, and
PAGE_SIZE_256KB=y in the randconfig, so I don't grok the Kconfig
warning.

---

If CONFIG_PAGE_SIZE_256KB is set, then in
arch/hexagon/include/asm/page.h we have:
 30 #ifdef CONFIG_PAGE_SIZE_256KB
 31 #define PAGE_SHIFT 18
...
 53 #define PAGE_SIZE  (1UL << PAGE_SHIFT)

then
fs/btrfs/compression.h:24:#define BTRFS_MAX_COMPRESSED          (SZ_128K)
include/linux/sizes.h:
28 #define SZ_128K       0x00020000


so that's (1 << 18) == 0x40000. The failing assert is checking
(0x20000 % 0x40000 != 0) (0x20000 % 0x40000 == 0x20000).

Not really sure what to do at this point, but that's why this assert
is failing for this randconfig.


>    2 errors generated.
>
>
> vim +/error +569 fs/btrfs/inode.c
>
> 26d30f852907236 Anand Jain         2016-12-19  512
> d352ac68148b699 Chris Mason        2008-09-29  513  /*
> 771ed689d2cd534 Chris Mason        2008-11-06  514   * we create compressed extents in two phases.  The first
> 771ed689d2cd534 Chris Mason        2008-11-06  515   * phase compresses a range of pages that have already been
> 771ed689d2cd534 Chris Mason        2008-11-06  516   * locked (both pages and state bits are locked).
> c8b978188c9a0fd Chris Mason        2008-10-29  517   *
> 771ed689d2cd534 Chris Mason        2008-11-06  518   * This is done inside an ordered work queue, and the compression
> 771ed689d2cd534 Chris Mason        2008-11-06  519   * is spread across many cpus.  The actual IO submission is step
> 771ed689d2cd534 Chris Mason        2008-11-06  520   * two, and the ordered work queue takes care of making sure that
> 771ed689d2cd534 Chris Mason        2008-11-06  521   * happens in the same order things were put onto the queue by
> 771ed689d2cd534 Chris Mason        2008-11-06  522   * writepages and friends.
> c8b978188c9a0fd Chris Mason        2008-10-29  523   *
> 771ed689d2cd534 Chris Mason        2008-11-06  524   * If this code finds it can't get good compression, it puts an
> 771ed689d2cd534 Chris Mason        2008-11-06  525   * entry onto the work queue to write the uncompressed bytes.  This
> 771ed689d2cd534 Chris Mason        2008-11-06  526   * makes sure that both compressed inodes and uncompressed inodes
> b257031408945eb Artem Bityutskiy   2012-07-25  527   * are written in the same order that the flusher thread sent them
> b257031408945eb Artem Bityutskiy   2012-07-25  528   * down.
> d352ac68148b699 Chris Mason        2008-09-29  529   */
> ac3e99334d640b6 Nikolay Borisov    2019-07-17  530  static noinline int compress_file_range(struct async_chunk *async_chunk)
> b888db2bd7b67f1 Chris Mason        2007-08-27  531  {
> 1368c6dac7f10a1 Nikolay Borisov    2019-03-12  532      struct inode *inode = async_chunk->inode;
> 0b246afa62b0cf5 Jeff Mahoney       2016-06-22  533      struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> 0b246afa62b0cf5 Jeff Mahoney       2016-06-22  534      u64 blocksize = fs_info->sectorsize;
> 1368c6dac7f10a1 Nikolay Borisov    2019-03-12  535      u64 start = async_chunk->start;
> 1368c6dac7f10a1 Nikolay Borisov    2019-03-12  536      u64 end = async_chunk->end;
> c8b978188c9a0fd Chris Mason        2008-10-29  537      u64 actual_end;
> d98da49977f6739 Josef Bacik        2019-10-11  538      u64 i_size;
> e6dcd2dc9c48910 Chris Mason        2008-07-17  539      int ret = 0;
> c8b978188c9a0fd Chris Mason        2008-10-29  540      struct page **pages = NULL;
> c8b978188c9a0fd Chris Mason        2008-10-29  541      unsigned long nr_pages;
> c8b978188c9a0fd Chris Mason        2008-10-29  542      unsigned long total_compressed = 0;
> c8b978188c9a0fd Chris Mason        2008-10-29  543      unsigned long total_in = 0;
> c8b978188c9a0fd Chris Mason        2008-10-29  544      int i;
> c8b978188c9a0fd Chris Mason        2008-10-29  545      int will_compress;
> 0b246afa62b0cf5 Jeff Mahoney       2016-06-22  546      int compress_type = fs_info->compress_type;
> ac3e99334d640b6 Nikolay Borisov    2019-07-17  547      int compressed_extents = 0;
> 4adaa611020fa6a Chris Mason        2013-03-26  548      int redirty = 0;
> b888db2bd7b67f1 Chris Mason        2007-08-27  549
> 6158e1ce1cc620d Nikolay Borisov    2017-02-20  550      inode_should_defrag(BTRFS_I(inode), start, end, end - start + 1,
> 6158e1ce1cc620d Nikolay Borisov    2017-02-20  551                      SZ_16K);
> 4cb5300bc839b8a Chris Mason        2011-05-24  552
> d98da49977f6739 Josef Bacik        2019-10-11  553      /*
> d98da49977f6739 Josef Bacik        2019-10-11  554       * We need to save i_size before now because it could change in between
> d98da49977f6739 Josef Bacik        2019-10-11  555       * us evaluating the size and assigning it.  This is because we lock and
> d98da49977f6739 Josef Bacik        2019-10-11  556       * unlock the page in truncate and fallocate, and then modify the i_size
> d98da49977f6739 Josef Bacik        2019-10-11  557       * later on.
> d98da49977f6739 Josef Bacik        2019-10-11  558       *
> d98da49977f6739 Josef Bacik        2019-10-11  559       * The barriers are to emulate READ_ONCE, remove that once i_size_read
> d98da49977f6739 Josef Bacik        2019-10-11  560       * does that for us.
> d98da49977f6739 Josef Bacik        2019-10-11  561       */
> d98da49977f6739 Josef Bacik        2019-10-11  562      barrier();
> d98da49977f6739 Josef Bacik        2019-10-11  563      i_size = i_size_read(inode);
> d98da49977f6739 Josef Bacik        2019-10-11  564      barrier();
> d98da49977f6739 Josef Bacik        2019-10-11  565      actual_end = min_t(u64, i_size, end + 1);
> c8b978188c9a0fd Chris Mason        2008-10-29  566  again:
> c8b978188c9a0fd Chris Mason        2008-10-29  567      will_compress = 0;
> 09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  568      nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
> 069eac7850890ac David Sterba       2017-02-14 @569      BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0);
> 069eac7850890ac David Sterba       2017-02-14  570      nr_pages = min_t(unsigned long, nr_pages,
> 069eac7850890ac David Sterba       2017-02-14  571                      BTRFS_MAX_COMPRESSED / PAGE_SIZE);
> c8b978188c9a0fd Chris Mason        2008-10-29  572
> f03d9301f15fb69 Chris Mason        2009-02-04  573      /*
> f03d9301f15fb69 Chris Mason        2009-02-04  574       * we don't want to send crud past the end of i_size through
> f03d9301f15fb69 Chris Mason        2009-02-04  575       * compression, that's just a waste of CPU time.  So, if the
> f03d9301f15fb69 Chris Mason        2009-02-04  576       * end of the file is before the start of our current
> f03d9301f15fb69 Chris Mason        2009-02-04  577       * requested range of bytes, we bail out to the uncompressed
> f03d9301f15fb69 Chris Mason        2009-02-04  578       * cleanup code that can deal with all of this.
> f03d9301f15fb69 Chris Mason        2009-02-04  579       *
> f03d9301f15fb69 Chris Mason        2009-02-04  580       * It isn't really the fastest way to fix things, but this is a
> f03d9301f15fb69 Chris Mason        2009-02-04  581       * very uncommon corner.
> f03d9301f15fb69 Chris Mason        2009-02-04  582       */
> f03d9301f15fb69 Chris Mason        2009-02-04  583      if (actual_end <= start)
> f03d9301f15fb69 Chris Mason        2009-02-04  584              goto cleanup_and_bail_uncompressed;
> f03d9301f15fb69 Chris Mason        2009-02-04  585
> c8b978188c9a0fd Chris Mason        2008-10-29  586      total_compressed = actual_end - start;
> c8b978188c9a0fd Chris Mason        2008-10-29  587
> 4bcbb33255131ad Shilong Wang       2014-10-07  588      /*
> 4bcbb33255131ad Shilong Wang       2014-10-07  589       * skip compression for a small file range(<=blocksize) that
> 0132761017e012a Nicholas D Steeves 2016-05-19  590       * isn't an inline extent, since it doesn't save disk space at all.
> 4bcbb33255131ad Shilong Wang       2014-10-07  591       */
> 4bcbb33255131ad Shilong Wang       2014-10-07  592      if (total_compressed <= blocksize &&
> 4bcbb33255131ad Shilong Wang       2014-10-07  593         (start > 0 || end + 1 < BTRFS_I(inode)->disk_i_size))
> 4bcbb33255131ad Shilong Wang       2014-10-07  594              goto cleanup_and_bail_uncompressed;
> 4bcbb33255131ad Shilong Wang       2014-10-07  595
> 069eac7850890ac David Sterba       2017-02-14  596      total_compressed = min_t(unsigned long, total_compressed,
> 069eac7850890ac David Sterba       2017-02-14  597                      BTRFS_MAX_UNCOMPRESSED);
> c8b978188c9a0fd Chris Mason        2008-10-29  598      total_in = 0;
> c8b978188c9a0fd Chris Mason        2008-10-29  599      ret = 0;
> db94535db75e67f Chris Mason        2007-10-15  600
> 771ed689d2cd534 Chris Mason        2008-11-06  601      /*
> 771ed689d2cd534 Chris Mason        2008-11-06  602       * we do compression for mount -o compress and when the
> 771ed689d2cd534 Chris Mason        2008-11-06  603       * inode has not been flagged as nocompress.  This flag can
> 771ed689d2cd534 Chris Mason        2008-11-06  604       * change at any time if we discover bad compression ratios.
> c8b978188c9a0fd Chris Mason        2008-10-29  605       */
> 808a12923203ee1 Nikolay Borisov    2020-06-03  606      if (inode_need_compress(BTRFS_I(inode), start, end)) {
> c8b978188c9a0fd Chris Mason        2008-10-29  607              WARN_ON(pages);
> 31e818fe7375d60 David Sterba       2015-02-20  608              pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> 560f7d75457f86a Li Zefan           2011-09-08  609              if (!pages) {
> 560f7d75457f86a Li Zefan           2011-09-08  610                      /* just bail out to the uncompressed code */
> 3527a018c00e5db Filipe Manana      2018-10-13  611                      nr_pages = 0;
> 560f7d75457f86a Li Zefan           2011-09-08  612                      goto cont;
> 560f7d75457f86a Li Zefan           2011-09-08  613              }
> c8b978188c9a0fd Chris Mason        2008-10-29  614
> eec63c65dcbeb14 David Sterba       2017-07-17  615              if (BTRFS_I(inode)->defrag_compress)
> eec63c65dcbeb14 David Sterba       2017-07-17  616                      compress_type = BTRFS_I(inode)->defrag_compress;
> eec63c65dcbeb14 David Sterba       2017-07-17  617              else if (BTRFS_I(inode)->prop_compress)
> b52aa8c93e1fec9 David Sterba       2017-07-17  618                      compress_type = BTRFS_I(inode)->prop_compress;
> 261507a02ccba9a Li Zefan           2010-12-17  619
> 4adaa611020fa6a Chris Mason        2013-03-26  620              /*
> 4adaa611020fa6a Chris Mason        2013-03-26  621               * we need to call clear_page_dirty_for_io on each
> 4adaa611020fa6a Chris Mason        2013-03-26  622               * page in the range.  Otherwise applications with the file
> 4adaa611020fa6a Chris Mason        2013-03-26  623               * mmap'd can wander in and change the page contents while
> 4adaa611020fa6a Chris Mason        2013-03-26  624               * we are compressing them.
> 4adaa611020fa6a Chris Mason        2013-03-26  625               *
> 4adaa611020fa6a Chris Mason        2013-03-26  626               * If the compression fails for any reason, we set the pages
> 4adaa611020fa6a Chris Mason        2013-03-26  627               * dirty again later on.
> e9679de3fdcb11a Timofey Titovets   2017-10-24  628               *
> e9679de3fdcb11a Timofey Titovets   2017-10-24  629               * Note that the remaining part is redirtied, the start pointer
> e9679de3fdcb11a Timofey Titovets   2017-10-24  630               * has moved, the end is the original one.
> 4adaa611020fa6a Chris Mason        2013-03-26  631               */
> e9679de3fdcb11a Timofey Titovets   2017-10-24  632              if (!redirty) {
> 4adaa611020fa6a Chris Mason        2013-03-26  633                      extent_range_clear_dirty_for_io(inode, start, end);
> 4adaa611020fa6a Chris Mason        2013-03-26  634                      redirty = 1;
> e9679de3fdcb11a Timofey Titovets   2017-10-24  635              }
> f51d2b59120ff36 David Sterba       2017-09-15  636
> f51d2b59120ff36 David Sterba       2017-09-15  637              /* Compression level is applied here and only here */
> f51d2b59120ff36 David Sterba       2017-09-15  638              ret = btrfs_compress_pages(
> f51d2b59120ff36 David Sterba       2017-09-15  639                      compress_type | (fs_info->compress_level << 4),
> 261507a02ccba9a Li Zefan           2010-12-17  640                                         inode->i_mapping, start,
> 38c31464089f639 David Sterba       2017-02-14  641                                         pages,
> 4d3a800ebb12999 David Sterba       2017-02-14  642                                         &nr_pages,
> c8b978188c9a0fd Chris Mason        2008-10-29  643                                         &total_in,
> e5d74902362f1a0 David Sterba       2017-02-14  644                                         &total_compressed);
> c8b978188c9a0fd Chris Mason        2008-10-29  645
> c8b978188c9a0fd Chris Mason        2008-10-29  646              if (!ret) {
> 7073017aeb98db3 Johannes Thumshirn 2018-12-05  647                      unsigned long offset = offset_in_page(total_compressed);
> 4d3a800ebb12999 David Sterba       2017-02-14  648                      struct page *page = pages[nr_pages - 1];
> c8b978188c9a0fd Chris Mason        2008-10-29  649
> c8b978188c9a0fd Chris Mason        2008-10-29  650                      /* zero the tail end of the last page, we might be
> c8b978188c9a0fd Chris Mason        2008-10-29  651                       * sending it down to disk
> c8b978188c9a0fd Chris Mason        2008-10-29  652                       */
> d048b9c2a737eb7 Ira Weiny          2021-05-04  653                      if (offset)
> d048b9c2a737eb7 Ira Weiny          2021-05-04  654                              memzero_page(page, offset, PAGE_SIZE - offset);
> c8b978188c9a0fd Chris Mason        2008-10-29  655                      will_compress = 1;
> c8b978188c9a0fd Chris Mason        2008-10-29  656              }
> c8b978188c9a0fd Chris Mason        2008-10-29  657      }
> 560f7d75457f86a Li Zefan           2011-09-08  658  cont:
> c8b978188c9a0fd Chris Mason        2008-10-29  659      if (start == 0) {
> c8b978188c9a0fd Chris Mason        2008-10-29  660              /* lets try to make an inline extent */
> 6018ba0a0e1bc23 Timofey Titovets   2017-09-15  661              if (ret || total_in < actual_end) {
> c8b978188c9a0fd Chris Mason        2008-10-29  662                      /* we didn't compress the entire range, try
> 771ed689d2cd534 Chris Mason        2008-11-06  663                       * to make an uncompressed inline extent.
> c8b978188c9a0fd Chris Mason        2008-10-29  664                       */
> a0349401c14f507 Nikolay Borisov    2020-06-03  665                      ret = cow_file_range_inline(BTRFS_I(inode), start, end,
> a0349401c14f507 Nikolay Borisov    2020-06-03  666                                                  0, BTRFS_COMPRESS_NONE,
> a0349401c14f507 Nikolay Borisov    2020-06-03  667                                                  NULL);
> c8b978188c9a0fd Chris Mason        2008-10-29  668              } else {
> 771ed689d2cd534 Chris Mason        2008-11-06  669                      /* try making a compressed inline extent */
> a0349401c14f507 Nikolay Borisov    2020-06-03  670                      ret = cow_file_range_inline(BTRFS_I(inode), start, end,
> fe3f566cd19bb6d Li Zefan           2011-03-28  671                                                  total_compressed,
> fe3f566cd19bb6d Li Zefan           2011-03-28  672                                                  compress_type, pages);
> c8b978188c9a0fd Chris Mason        2008-10-29  673              }
> 79787eaab46121d Jeff Mahoney       2012-03-12  674              if (ret <= 0) {
> 151a41bc46df2a9 Josef Bacik        2013-07-29  675                      unsigned long clear_flags = EXTENT_DELALLOC |
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  676                              EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  677                              EXTENT_DO_ACCOUNTING;
> e6eb43142a72ba3 Filipe Manana      2014-10-10  678                      unsigned long page_error_op;
> e6eb43142a72ba3 Filipe Manana      2014-10-10  679
> e6eb43142a72ba3 Filipe Manana      2014-10-10  680                      page_error_op = ret < 0 ? PAGE_SET_ERROR : 0;
> 151a41bc46df2a9 Josef Bacik        2013-07-29  681
> 771ed689d2cd534 Chris Mason        2008-11-06  682                      /*
> 79787eaab46121d Jeff Mahoney       2012-03-12  683                       * inline extent creation worked or returned error,
> 79787eaab46121d Jeff Mahoney       2012-03-12  684                       * we don't need to create any more async work items.
> 79787eaab46121d Jeff Mahoney       2012-03-12  685                       * Unlock and free up our temp pages.
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  686                       *
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  687                       * We use DO_ACCOUNTING here because we need the
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  688                       * delalloc_release_metadata to be done _after_ we drop
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  689                       * our outstanding extent for clearing delalloc for this
> 8b62f87bad9cf06 Josef Bacik        2017-10-19  690                       * range.
> 771ed689d2cd534 Chris Mason        2008-11-06  691                       */
> ad7ff17b65a0567 Nikolay Borisov    2020-06-03  692                      extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
> ad7ff17b65a0567 Nikolay Borisov    2020-06-03  693                                                   NULL,
> 74e9194afb2c5c6 Nikolay Borisov    2019-07-17  694                                                   clear_flags,
> ba8b04c1d4adbc6 Qu Wenruo          2016-07-19  695                                                   PAGE_UNLOCK |
> 6869b0a8be775e9 Qu Wenruo          2021-01-26  696                                                   PAGE_START_WRITEBACK |
> e6eb43142a72ba3 Filipe Manana      2014-10-10  697                                                   page_error_op |
> c2790a2e2bc8240 Josef Bacik        2013-07-29  698                                                   PAGE_END_WRITEBACK);
> cecc8d9038d164e Nikolay Borisov    2019-07-17  699
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  700                      /*
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  701                       * Ensure we only free the compressed pages if we have
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  702                       * them allocated, as we can still reach here with
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  703                       * inode_need_compress() == false.
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  704                       */
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  705                      if (pages) {
> cecc8d9038d164e Nikolay Borisov    2019-07-17  706                              for (i = 0; i < nr_pages; i++) {
> cecc8d9038d164e Nikolay Borisov    2019-07-17  707                                      WARN_ON(pages[i]->mapping);
> cecc8d9038d164e Nikolay Borisov    2019-07-17  708                                      put_page(pages[i]);
> cecc8d9038d164e Nikolay Borisov    2019-07-17  709                              }
> cecc8d9038d164e Nikolay Borisov    2019-07-17  710                              kfree(pages);
> 1e6e238c3002ea3 Qu Wenruo          2020-07-28  711                      }
> cecc8d9038d164e Nikolay Borisov    2019-07-17  712                      return 0;
> c8b978188c9a0fd Chris Mason        2008-10-29  713              }
> c8b978188c9a0fd Chris Mason        2008-10-29  714      }
> c8b978188c9a0fd Chris Mason        2008-10-29  715
> c8b978188c9a0fd Chris Mason        2008-10-29  716      if (will_compress) {
> c8b978188c9a0fd Chris Mason        2008-10-29  717              /*
> c8b978188c9a0fd Chris Mason        2008-10-29  718               * we aren't doing an inline extent round the compressed size
> c8b978188c9a0fd Chris Mason        2008-10-29  719               * up to a block size boundary so the allocator does sane
> c8b978188c9a0fd Chris Mason        2008-10-29  720               * things
> c8b978188c9a0fd Chris Mason        2008-10-29  721               */
> fda2832febb1928 Qu Wenruo          2013-02-26  722              total_compressed = ALIGN(total_compressed, blocksize);
> c8b978188c9a0fd Chris Mason        2008-10-29  723
> c8b978188c9a0fd Chris Mason        2008-10-29  724              /*
> c8b978188c9a0fd Chris Mason        2008-10-29  725               * one last check to make sure the compression is really a
> 170607ebd9c891d Timofey Titovets   2017-06-06  726               * win, compare the page count read with the blocks on disk,
> 170607ebd9c891d Timofey Titovets   2017-06-06  727               * compression must free at least one sector size
> c8b978188c9a0fd Chris Mason        2008-10-29  728               */
> 09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  729              total_in = ALIGN(total_in, PAGE_SIZE);
> 170607ebd9c891d Timofey Titovets   2017-06-06  730              if (total_compressed + blocksize <= total_in) {
> ac3e99334d640b6 Nikolay Borisov    2019-07-17  731                      compressed_extents++;
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  732
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  733                      /*
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  734                       * The async work queues will take care of doing actual
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  735                       * allocation on disk for these compressed pages, and
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  736                       * will submit them to the elevator.
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  737                       */
> b5326271e791ea9 Nikolay Borisov    2019-03-12  738                      add_async_extent(async_chunk, start, total_in,
> 4d3a800ebb12999 David Sterba       2017-02-14  739                                      total_compressed, pages, nr_pages,
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  740                                      compress_type);
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  741
> 1170862d783a3b4 Timofey Titovets   2017-10-03  742                      if (start + total_in < end) {
> 1170862d783a3b4 Timofey Titovets   2017-10-03  743                              start += total_in;
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  744                              pages = NULL;
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  745                              cond_resched();
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  746                              goto again;
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  747                      }
> ac3e99334d640b6 Nikolay Borisov    2019-07-17  748                      return compressed_extents;
> c8b978188c9a0fd Chris Mason        2008-10-29  749              }
> c8b978188c9a0fd Chris Mason        2008-10-29  750      }
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  751      if (pages) {
> c8b978188c9a0fd Chris Mason        2008-10-29  752              /*
> c8b978188c9a0fd Chris Mason        2008-10-29  753               * the compression code ran but failed to make things smaller,
> c8b978188c9a0fd Chris Mason        2008-10-29  754               * free any pages it allocated and our page pointer array
> c8b978188c9a0fd Chris Mason        2008-10-29  755               */
> 4d3a800ebb12999 David Sterba       2017-02-14  756              for (i = 0; i < nr_pages; i++) {
> 70b99e6959a4c28 Chris Mason        2008-10-31  757                      WARN_ON(pages[i]->mapping);
> 09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  758                      put_page(pages[i]);
> c8b978188c9a0fd Chris Mason        2008-10-29  759              }
> c8b978188c9a0fd Chris Mason        2008-10-29  760              kfree(pages);
> c8b978188c9a0fd Chris Mason        2008-10-29  761              pages = NULL;
> c8b978188c9a0fd Chris Mason        2008-10-29  762              total_compressed = 0;
> 4d3a800ebb12999 David Sterba       2017-02-14  763              nr_pages = 0;
> c8b978188c9a0fd Chris Mason        2008-10-29  764
> c8b978188c9a0fd Chris Mason        2008-10-29  765              /* flag the file so we don't compress in the future */
> 0b246afa62b0cf5 Jeff Mahoney       2016-06-22  766              if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) &&
> b52aa8c93e1fec9 David Sterba       2017-07-17  767                  !(BTRFS_I(inode)->prop_compress)) {
> 6cbff00f4632c80 Christoph Hellwig  2009-04-17  768                      BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
> c8b978188c9a0fd Chris Mason        2008-10-29  769              }
> 1e701a3292e25a6 Chris Mason        2010-03-11  770      }
> f03d9301f15fb69 Chris Mason        2009-02-04  771  cleanup_and_bail_uncompressed:
> 771ed689d2cd534 Chris Mason        2008-11-06  772      /*
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  773       * No compression, but we still need to write the pages in the file
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  774       * we've been given so far.  redirty the locked page if it corresponds
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  775       * to our extent and set things up for the async work queue to run
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  776       * cow_file_range to do the normal delalloc dance.
> 771ed689d2cd534 Chris Mason        2008-11-06  777       */
> 1d53c9e6723022b Chris Mason        2019-07-10  778      if (async_chunk->locked_page &&
> 1d53c9e6723022b Chris Mason        2019-07-10  779          (page_offset(async_chunk->locked_page) >= start &&
> 1d53c9e6723022b Chris Mason        2019-07-10  780           page_offset(async_chunk->locked_page)) <= end) {
> 1368c6dac7f10a1 Nikolay Borisov    2019-03-12  781              __set_page_dirty_nobuffers(async_chunk->locked_page);
> 771ed689d2cd534 Chris Mason        2008-11-06  782              /* unlocked later on in the async handlers */
> 1d53c9e6723022b Chris Mason        2019-07-10  783      }
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  784
> 4adaa611020fa6a Chris Mason        2013-03-26  785      if (redirty)
> 4adaa611020fa6a Chris Mason        2013-03-26  786              extent_range_redirty_for_io(inode, start, end);
> b5326271e791ea9 Nikolay Borisov    2019-03-12  787      add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
> c8bb0c8bd22a4b9 Ashish Samant      2016-03-25  788                       BTRFS_COMPRESS_NONE);
> ac3e99334d640b6 Nikolay Borisov    2019-07-17  789      compressed_extents++;
> 3b951516ed703af Chris Mason        2008-04-17  790
> ac3e99334d640b6 Nikolay Borisov    2019-07-17  791      return compressed_extents;
> 771ed689d2cd534 Chris Mason        2008-11-06  792  }
> 771ed689d2cd534 Chris Mason        2008-11-06  793
>
> :::::: The code at line 569 was first introduced by commit
> :::::: 069eac7850890acf0d3c21a6c8ca9f33ddb34a0d btrfs: use predefined limits for calculating maximum number of pages for compression
>
> :::::: TO: David Sterba <dsterba@suse.com>
> :::::: CC: David Sterba <dsterba@suse.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
