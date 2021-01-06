Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68CC2EB988
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 06:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFFej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 00:34:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:33609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbhAFFej (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 00:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609911178;
        bh=YBs7qwRZ5PBCBHcd8P8LV39jNpFLnffV6Dt6IG2srr0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eap4GUSV1xTF7T9zfiJ4rq9OvE30D46yVJvdyTI8TXCU2dIX9pOerhiEPrAsdjKxz
         i2aop235D51CcKHmmgsDoc9rIS4zxQ/M3Z0apCh3OyqrwXsRZIlJMdDAcmL2d5CQjh
         h+MuxYLAwnXuU7NcRT7ulb/dM4rE2K+keoXxqP38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzf6-1kX8bT33II-00R2pD; Wed, 06
 Jan 2021 06:32:58 +0100
Subject: Re: [PATCH v3 20/22] btrfs: introduce btrfs_subpage for data inodes
To:     kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20210106010201.37864-21-wqu@suse.com>
 <202101061235.6i1d3d0Y-lkp@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6dcda0b3-373f-71fd-d8eb-7a65ac9de4a6@gmx.com>
Date:   Wed, 6 Jan 2021 13:32:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202101061235.6i1d3d0Y-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BkIG7KlBiLlgW8T/otJ0tt107CjxcwAbYz3YnNRHP7UTc1/jcWj
 XChqAYN3VJAkEtqBQsjoGKde6BJl4j92k/uvERoMR+Vj0OmpiS7RSu/9EXU3pwXzR4KdEd6
 qIca3tCHJTjWb1nV+fFeqxzyj8fvvGl+bJW3L6ax48vmJ+YMoGBtmMtzmthKimS3bXCsbiE
 cQQGY+Iz5gDJ5MxKFjJOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bC6shW4cF7E=:y8lmkV5SQ8MLaykq/Hk6AV
 7qv1WTJ0EEsxZezk4Y5LgBkHFXMI94c7s07vFiHerwMvmyhPI19uD3OEdHmQsQEC77rI+48Q+
 NIV0zw5c3VM0J2BFRmc6cCZG51m06t2msdvpkR12E3bxUBEF7FVng5VOi+P+CkbQ+0cI+tCHt
 MIs1vV8vOu1+Z1xZ0UQzjRwVYQlR+a6ZUTWg33Bl6UkZz4EepX2pYfJuiMzk+B6gzQa8X7aF2
 0/du69Ba3LIbw72qkzn73dZWU6J8Savks3LcB2/CrZZt6N+xyqP/ONwdHzBWxiFw56G/tTXVD
 2Ob2TeTKvHeua8Gw4WFQfYc3nE6/IdfIp8Vvak87701enp3Yz48RXnGoxXjUKIWVYO0GMzqPX
 c2inBKCBxvAB7Zz5/vl0dfI0Huw4CiGJj8QEjEcmlY1iXJm4d12tzIWqtZop3LJi+6/uKCHAH
 D9Z6XNRGIRu9pww1O1GiDvhyk01AfslrgiMVia46oudLo6GU+TtTwVdpQxRDIGme+3tUwpLDi
 ewXg+toMT5QFYLGFTA+lyAXdcgWb+9knLQlGeeuscTpDtA2P7BwjAB5/kykN60D6f4QgEjO+W
 Me34+QNtjzsjClFnCmOEflC50ExtYQI1k6I4tmVfvRgQNrJnRRsudLWaW+cai4pCQuKaXOYHZ
 W+WY8Zc8fPVy2Q8+I3KcKPHYHhVM4HvE75MyMp2Q3hP+CfIBnG+T3Cxg8Pqb+Zrsf1vyLsYgD
 hxdO1+yTX/19wk6TWUo9xARqJGmU/Hquk/tTVx8CfJvORhZf5niEYyN25/kLl7P3wSE9P+SJq
 wfglGprsQj23dQ6f791so30ivcTGjtw7GzP28nOyuszbx/nRhCnLeHWlbhMJpjgf1nME6VWJB
 fH93jQgmcL/yZmJmLKog==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/6 =E4=B8=8B=E5=8D=881:04, kernel test robot wrote:
> Hi Qu,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on v5.11-rc2 next-20210104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-add-rea=
d-only-support-for-subpage-sector-size/20210106-090847
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> config: m68k-randconfig-s032-20210106 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-208-g46a52ca4-dirty
>          # https://github.com/0day-ci/linux/commit/2c54bbf363f66a7c4d489=
fa0b7967ce5fc960afb
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Qu-Wenruo/btrfs-add-read-only-=
support-for-subpage-sector-size/20210106-090847
>          git checkout 2c54bbf363f66a7c4d489fa0b7967ce5fc960afb
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cr=
oss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dm68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> "sparse warnings: (new ones prefixed by >>)"
>>> fs/btrfs/inode.c:8352:13: sparse: sparse: incorrect type in assignment=
 (different base types) @@     expected restricted vm_fault_t [assigned] [=
usertype] ret @@     got int @@
>     fs/btrfs/inode.c:8352:13: sparse:     expected restricted vm_fault_t=
 [assigned] [usertype] ret
>     fs/btrfs/inode.c:8352:13: sparse:     got int
>>> fs/btrfs/inode.c:8353:13: sparse: sparse: restricted vm_fault_t degrad=
es to integer

Why I always forgot this...

Now it get properly fixed in github. Although the submitted patch is
still using @ret other than @ret2.

Is there anyway to let LKP to run on specific branch so that I can avoid
similar problems.

Thanks,
Qu
>     fs/btrfs/inode.c: note: in included file (through include/linux/mmzo=
ne.h, include/linux/gfp.h, include/linux/slab.h, ...):
>     include/linux/spinlock.h:394:9: sparse: sparse: context imbalance in=
 'run_delayed_iput_locked' - unexpected unlock
>
> vim +8352 fs/btrfs/inode.c
>
>    8275
>    8276	/*
>    8277	 * btrfs_page_mkwrite() is not allowed to change the file size a=
s it gets
>    8278	 * called from a page fault handler when a page is first dirtied=
. Hence we must
>    8279	 * be careful to check for EOF conditions here. We set the page =
up correctly
>    8280	 * for a written page which means we get ENOSPC checking when wr=
iting into
>    8281	 * holes and correct delalloc and unwritten extent mapping on fi=
lesystems that
>    8282	 * support these features.
>    8283	 *
>    8284	 * We are not allowed to take the i_mutex here so we have to pla=
y games to
>    8285	 * protect against truncate races as the page could now be beyon=
d EOF.  Because
>    8286	 * truncate_setsize() writes the inode size before removing page=
s, once we have
>    8287	 * the page lock we can determine safely if the page is beyond E=
OF. If it is not
>    8288	 * beyond EOF, then the page is guaranteed safe against truncati=
on until we
>    8289	 * unlock the page.
>    8290	 */
>    8291	vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>    8292	{
>    8293		struct page *page =3D vmf->page;
>    8294		struct inode *inode =3D file_inode(vmf->vma->vm_file);
>    8295		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>    8296		struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
>    8297		struct btrfs_ordered_extent *ordered;
>    8298		struct extent_state *cached_state =3D NULL;
>    8299		struct extent_changeset *data_reserved =3D NULL;
>    8300		char *kaddr;
>    8301		unsigned long zero_start;
>    8302		loff_t size;
>    8303		vm_fault_t ret;
>    8304		int ret2;
>    8305		int reserved =3D 0;
>    8306		u64 reserved_space;
>    8307		u64 page_start;
>    8308		u64 page_end;
>    8309		u64 end;
>    8310
>    8311		reserved_space =3D PAGE_SIZE;
>    8312
>    8313		sb_start_pagefault(inode->i_sb);
>    8314		page_start =3D page_offset(page);
>    8315		page_end =3D page_start + PAGE_SIZE - 1;
>    8316		end =3D page_end;
>    8317
>    8318		/*
>    8319		 * Reserving delalloc space after obtaining the page lock can l=
ead to
>    8320		 * deadlock. For example, if a dirty page is locked by this fun=
ction
>    8321		 * and the call to btrfs_delalloc_reserve_space() ends up trigg=
ering
>    8322		 * dirty page write out, then the btrfs_writepage() function co=
uld
>    8323		 * end up waiting indefinitely to get a lock on the page curren=
tly
>    8324		 * being processed by btrfs_page_mkwrite() function.
>    8325		 */
>    8326		ret2 =3D btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_res=
erved,
>    8327						    page_start, reserved_space);
>    8328		if (!ret2) {
>    8329			ret2 =3D file_update_time(vmf->vma->vm_file);
>    8330			reserved =3D 1;
>    8331		}
>    8332		if (ret2) {
>    8333			ret =3D vmf_error(ret2);
>    8334			if (reserved)
>    8335				goto out;
>    8336			goto out_noreserve;
>    8337		}
>    8338
>    8339		ret =3D VM_FAULT_NOPAGE; /* make the VM retry the fault */
>    8340	again:
>    8341		lock_page(page);
>    8342		size =3D i_size_read(inode);
>    8343
>    8344		if ((page->mapping !=3D inode->i_mapping) ||
>    8345		    (page_start >=3D size)) {
>    8346			/* page got truncated out from underneath us */
>    8347			goto out_unlock;
>    8348		}
>    8349		wait_on_page_writeback(page);
>    8350
>    8351		lock_extent_bits(io_tree, page_start, page_end, &cached_state);
>> 8352		ret =3D set_page_extent_mapped(page);
>> 8353		if (ret < 0)
>    8354			goto out_unlock;
>    8355
>    8356		/*
>    8357		 * we can't set the delalloc bits if there are pending ordered
>    8358		 * extents.  Drop our locks and wait for them to finish
>    8359		 */
>    8360		ordered =3D btrfs_lookup_ordered_range(BTRFS_I(inode), page_sta=
rt,
>    8361				PAGE_SIZE);
>    8362		if (ordered) {
>    8363			unlock_extent_cached(io_tree, page_start, page_end,
>    8364					     &cached_state);
>    8365			unlock_page(page);
>    8366			btrfs_start_ordered_extent(ordered, 1);
>    8367			btrfs_put_ordered_extent(ordered);
>    8368			goto again;
>    8369		}
>    8370
>    8371		if (page->index =3D=3D ((size - 1) >> PAGE_SHIFT)) {
>    8372			reserved_space =3D round_up(size - page_start,
>    8373						  fs_info->sectorsize);
>    8374			if (reserved_space < PAGE_SIZE) {
>    8375				end =3D page_start + reserved_space - 1;
>    8376				btrfs_delalloc_release_space(BTRFS_I(inode),
>    8377						data_reserved, page_start,
>    8378						PAGE_SIZE - reserved_space, true);
>    8379			}
>    8380		}
>    8381
>    8382		/*
>    8383		 * page_mkwrite gets called when the page is firstly dirtied af=
ter it's
>    8384		 * faulted in, but write(2) could also dirty a page and set del=
alloc
>    8385		 * bits, thus in this case for space account reason, we still n=
eed to
>    8386		 * clear any delalloc bits within this page range since we have=
 to
>    8387		 * reserve data&meta space before lock_page() (see above commen=
ts).
>    8388		 */
>    8389		clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
>    8390				  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
>    8391				  EXTENT_DEFRAG, 0, 0, &cached_state);
>    8392
>    8393		ret2 =3D btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, =
end, 0,
>    8394						&cached_state);
>    8395		if (ret2) {
>    8396			unlock_extent_cached(io_tree, page_start, page_end,
>    8397					     &cached_state);
>    8398			ret =3D VM_FAULT_SIGBUS;
>    8399			goto out_unlock;
>    8400		}
>    8401
>    8402		/* page is wholly or partially inside EOF */
>    8403		if (page_start + PAGE_SIZE > size)
>    8404			zero_start =3D offset_in_page(size);
>    8405		else
>    8406			zero_start =3D PAGE_SIZE;
>    8407
>    8408		if (zero_start !=3D PAGE_SIZE) {
>    8409			kaddr =3D kmap(page);
>    8410			memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
>    8411			flush_dcache_page(page);
>    8412			kunmap(page);
>    8413		}
>    8414		ClearPageChecked(page);
>    8415		set_page_dirty(page);
>    8416		SetPageUptodate(page);
>    8417
>    8418		BTRFS_I(inode)->last_trans =3D fs_info->generation;
>    8419		BTRFS_I(inode)->last_sub_trans =3D BTRFS_I(inode)->root->log_tr=
ansid;
>    8420		BTRFS_I(inode)->last_log_commit =3D BTRFS_I(inode)->root->last_=
log_commit;
>    8421
>    8422		unlock_extent_cached(io_tree, page_start, page_end, &cached_sta=
te);
>    8423
>    8424		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
>    8425		sb_end_pagefault(inode->i_sb);
>    8426		extent_changeset_free(data_reserved);
>    8427		return VM_FAULT_LOCKED;
>    8428
>    8429	out_unlock:
>    8430		unlock_page(page);
>    8431	out:
>    8432		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
>    8433		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, pag=
e_start,
>    8434					     reserved_space, (ret !=3D 0));
>    8435	out_noreserve:
>    8436		sb_end_pagefault(inode->i_sb);
>    8437		extent_changeset_free(data_reserved);
>    8438		return ret;
>    8439	}
>    8440
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
