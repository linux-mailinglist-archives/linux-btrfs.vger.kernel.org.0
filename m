Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06B2EBA36
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 07:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbhAFGuR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 01:50:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:14726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFGuR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 01:50:17 -0500
IronPort-SDR: tUpA/ihs1bXEqdHSGvpPg+knSvQNjPsmJguAkZSfBKpNHAFCG3r9Tw72uPh9qNx54WV+5ZhpEF
 O0JTUmGV8HnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="156427763"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="156427763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 22:49:37 -0800
IronPort-SDR: UnDIG+U1v4JuI/GnQuwByAR5czCb5vjt9mXtw06cw1D3/G7/Dh9Sw1OIGVVRadRTpiTHsEXcWd
 nQicF7+2Oeug==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="379175659"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 22:49:35 -0800
Subject: Re: [PATCH v3 20/22] btrfs: introduce btrfs_subpage for data inodes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20210106010201.37864-21-wqu@suse.com>
 <202101061235.6i1d3d0Y-lkp@intel.com>
 <6dcda0b3-373f-71fd-d8eb-7a65ac9de4a6@gmx.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <6546bad5-b467-b246-4b5f-95d43b6658d9@intel.com>
Date:   Wed, 6 Jan 2021 14:48:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6dcda0b3-373f-71fd-d8eb-7a65ac9de4a6@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/6/21 1:32 PM, Qu Wenruo wrote:
>
>
> On 2021/1/6 下午1:04, kernel test robot wrote:
>> Hi Qu,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on kdave/for-next]
>> [also build test WARNING on v5.11-rc2 next-20210104]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url: 
>> https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-add-read-only-support-for-subpage-sector-size/20210106-090847
>> base: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git 
>> for-next
>> config: m68k-randconfig-s032-20210106 (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-208-g46a52ca4-dirty
>>          # 
>> https://github.com/0day-ci/linux/commit/2c54bbf363f66a7c4d489fa0b7967ce5fc960afb
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> Qu-Wenruo/btrfs-add-read-only-support-for-subpage-sector-size/20210106-090847
>>          git checkout 2c54bbf363f66a7c4d489fa0b7967ce5fc960afb
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 
>> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> "sparse warnings: (new ones prefixed by >>)"
>>>> fs/btrfs/inode.c:8352:13: sparse: sparse: incorrect type in 
>>>> assignment (different base types) @@     expected restricted 
>>>> vm_fault_t [assigned] [usertype] ret @@     got int @@
>>     fs/btrfs/inode.c:8352:13: sparse:     expected restricted 
>> vm_fault_t [assigned] [usertype] ret
>>     fs/btrfs/inode.c:8352:13: sparse:     got int
>>>> fs/btrfs/inode.c:8353:13: sparse: sparse: restricted vm_fault_t 
>>>> degrades to integer
>
> Why I always forgot this...
>
> Now it get properly fixed in github. Although the submitted patch is
> still using @ret other than @ret2.
>
> Is there anyway to let LKP to run on specific branch so that I can avoid
> similar problems.

Hi Qu,

LKP can test private branches if you can provide the git tree url, 
please see
https://github.com/intel/lkp-tests/wiki/LKP-FAQ#how-to-request-testing-a-new-kernel-tree-on-lkp

Best Regards,
Rong Chen

>
> Thanks,
> Qu
>>     fs/btrfs/inode.c: note: in included file (through 
>> include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
>>     include/linux/spinlock.h:394:9: sparse: sparse: context imbalance 
>> in 'run_delayed_iput_locked' - unexpected unlock
>>
>> vim +8352 fs/btrfs/inode.c
>>
>>    8275
>>    8276    /*
>>    8277     * btrfs_page_mkwrite() is not allowed to change the file 
>> size as it gets
>>    8278     * called from a page fault handler when a page is first 
>> dirtied. Hence we must
>>    8279     * be careful to check for EOF conditions here. We set the 
>> page up correctly
>>    8280     * for a written page which means we get ENOSPC checking 
>> when writing into
>>    8281     * holes and correct delalloc and unwritten extent mapping 
>> on filesystems that
>>    8282     * support these features.
>>    8283     *
>>    8284     * We are not allowed to take the i_mutex here so we have 
>> to play games to
>>    8285     * protect against truncate races as the page could now be 
>> beyond EOF.  Because
>>    8286     * truncate_setsize() writes the inode size before 
>> removing pages, once we have
>>    8287     * the page lock we can determine safely if the page is 
>> beyond EOF. If it is not
>>    8288     * beyond EOF, then the page is guaranteed safe against 
>> truncation until we
>>    8289     * unlock the page.
>>    8290     */
>>    8291    vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>>    8292    {
>>    8293        struct page *page = vmf->page;
>>    8294        struct inode *inode = file_inode(vmf->vma->vm_file);
>>    8295        struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>    8296        struct extent_io_tree *io_tree = 
>> &BTRFS_I(inode)->io_tree;
>>    8297        struct btrfs_ordered_extent *ordered;
>>    8298        struct extent_state *cached_state = NULL;
>>    8299        struct extent_changeset *data_reserved = NULL;
>>    8300        char *kaddr;
>>    8301        unsigned long zero_start;
>>    8302        loff_t size;
>>    8303        vm_fault_t ret;
>>    8304        int ret2;
>>    8305        int reserved = 0;
>>    8306        u64 reserved_space;
>>    8307        u64 page_start;
>>    8308        u64 page_end;
>>    8309        u64 end;
>>    8310
>>    8311        reserved_space = PAGE_SIZE;
>>    8312
>>    8313        sb_start_pagefault(inode->i_sb);
>>    8314        page_start = page_offset(page);
>>    8315        page_end = page_start + PAGE_SIZE - 1;
>>    8316        end = page_end;
>>    8317
>>    8318        /*
>>    8319         * Reserving delalloc space after obtaining the page 
>> lock can lead to
>>    8320         * deadlock. For example, if a dirty page is locked by 
>> this function
>>    8321         * and the call to btrfs_delalloc_reserve_space() ends 
>> up triggering
>>    8322         * dirty page write out, then the btrfs_writepage() 
>> function could
>>    8323         * end up waiting indefinitely to get a lock on the 
>> page currently
>>    8324         * being processed by btrfs_page_mkwrite() function.
>>    8325         */
>>    8326        ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), 
>> &data_reserved,
>>    8327                            page_start, reserved_space);
>>    8328        if (!ret2) {
>>    8329            ret2 = file_update_time(vmf->vma->vm_file);
>>    8330            reserved = 1;
>>    8331        }
>>    8332        if (ret2) {
>>    8333            ret = vmf_error(ret2);
>>    8334            if (reserved)
>>    8335                goto out;
>>    8336            goto out_noreserve;
>>    8337        }
>>    8338
>>    8339        ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
>>    8340    again:
>>    8341        lock_page(page);
>>    8342        size = i_size_read(inode);
>>    8343
>>    8344        if ((page->mapping != inode->i_mapping) ||
>>    8345            (page_start >= size)) {
>>    8346            /* page got truncated out from underneath us */
>>    8347            goto out_unlock;
>>    8348        }
>>    8349        wait_on_page_writeback(page);
>>    8350
>>    8351        lock_extent_bits(io_tree, page_start, page_end, 
>> &cached_state);
>>> 8352        ret = set_page_extent_mapped(page);
>>> 8353        if (ret < 0)
>>    8354            goto out_unlock;
>>    8355
>>    8356        /*
>>    8357         * we can't set the delalloc bits if there are pending 
>> ordered
>>    8358         * extents.  Drop our locks and wait for them to finish
>>    8359         */
>>    8360        ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), 
>> page_start,
>>    8361                PAGE_SIZE);
>>    8362        if (ordered) {
>>    8363            unlock_extent_cached(io_tree, page_start, page_end,
>>    8364                         &cached_state);
>>    8365            unlock_page(page);
>>    8366            btrfs_start_ordered_extent(ordered, 1);
>>    8367            btrfs_put_ordered_extent(ordered);
>>    8368            goto again;
>>    8369        }
>>    8370
>>    8371        if (page->index == ((size - 1) >> PAGE_SHIFT)) {
>>    8372            reserved_space = round_up(size - page_start,
>>    8373                          fs_info->sectorsize);
>>    8374            if (reserved_space < PAGE_SIZE) {
>>    8375                end = page_start + reserved_space - 1;
>>    8376 btrfs_delalloc_release_space(BTRFS_I(inode),
>>    8377                        data_reserved, page_start,
>>    8378                        PAGE_SIZE - reserved_space, true);
>>    8379            }
>>    8380        }
>>    8381
>>    8382        /*
>>    8383         * page_mkwrite gets called when the page is firstly 
>> dirtied after it's
>>    8384         * faulted in, but write(2) could also dirty a page 
>> and set delalloc
>>    8385         * bits, thus in this case for space account reason, 
>> we still need to
>>    8386         * clear any delalloc bits within this page range 
>> since we have to
>>    8387         * reserve data&meta space before lock_page() (see 
>> above comments).
>>    8388         */
>>    8389        clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, 
>> end,
>>    8390                  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
>>    8391                  EXTENT_DEFRAG, 0, 0, &cached_state);
>>    8392
>>    8393        ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), 
>> page_start, end, 0,
>>    8394                        &cached_state);
>>    8395        if (ret2) {
>>    8396            unlock_extent_cached(io_tree, page_start, page_end,
>>    8397                         &cached_state);
>>    8398            ret = VM_FAULT_SIGBUS;
>>    8399            goto out_unlock;
>>    8400        }
>>    8401
>>    8402        /* page is wholly or partially inside EOF */
>>    8403        if (page_start + PAGE_SIZE > size)
>>    8404            zero_start = offset_in_page(size);
>>    8405        else
>>    8406            zero_start = PAGE_SIZE;
>>    8407
>>    8408        if (zero_start != PAGE_SIZE) {
>>    8409            kaddr = kmap(page);
>>    8410            memset(kaddr + zero_start, 0, PAGE_SIZE - 
>> zero_start);
>>    8411            flush_dcache_page(page);
>>    8412            kunmap(page);
>>    8413        }
>>    8414        ClearPageChecked(page);
>>    8415        set_page_dirty(page);
>>    8416        SetPageUptodate(page);
>>    8417
>>    8418        BTRFS_I(inode)->last_trans = fs_info->generation;
>>    8419        BTRFS_I(inode)->last_sub_trans = 
>> BTRFS_I(inode)->root->log_transid;
>>    8420        BTRFS_I(inode)->last_log_commit = 
>> BTRFS_I(inode)->root->last_log_commit;
>>    8421
>>    8422        unlock_extent_cached(io_tree, page_start, page_end, 
>> &cached_state);
>>    8423
>>    8424        btrfs_delalloc_release_extents(BTRFS_I(inode), 
>> PAGE_SIZE);
>>    8425        sb_end_pagefault(inode->i_sb);
>>    8426        extent_changeset_free(data_reserved);
>>    8427        return VM_FAULT_LOCKED;
>>    8428
>>    8429    out_unlock:
>>    8430        unlock_page(page);
>>    8431    out:
>>    8432        btrfs_delalloc_release_extents(BTRFS_I(inode), 
>> PAGE_SIZE);
>>    8433        btrfs_delalloc_release_space(BTRFS_I(inode), 
>> data_reserved, page_start,
>>    8434                         reserved_space, (ret != 0));
>>    8435    out_noreserve:
>>    8436        sb_end_pagefault(inode->i_sb);
>>    8437        extent_changeset_free(data_reserved);
>>    8438        return ret;
>>    8439    }
>>    8440
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>

