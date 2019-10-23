Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC1E16DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbfJWJ5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 05:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390880AbfJWJ5E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 05:57:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5794FAD54;
        Wed, 23 Oct 2019 09:57:01 +0000 (UTC)
Subject: Re: [PATCH 4/5] btrfs: serialize blocking_writers updates
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <2a310858bfa3754f6f7a4d4b7693959b0fdd7005.1571340084.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <be519bc7-c541-34ee-80b9-57fe63135f06@suse.com>
Date:   Wed, 23 Oct 2019 12:57:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2a310858bfa3754f6f7a4d4b7693959b0fdd7005.1571340084.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.10.19 г. 22:39 ч., David Sterba wrote:
> There's one potential memory ordering problem regarding
> eb::blocking_writers, although this hasn't been hit in practice. On TSO
> (total store ordering) architectures, the writes will always be seen in
> right order.
> 
> In case the calls in btrfs_set_lock_blocking_write are seen in this
> (wrong) order on another CPU:
> 
> 0:  /* blocking_writers == 0 */
> 1:  write_unlock()
> 2:  blocking_writers = 1
> 
> btrfs_try_tree_read_lock, btrfs_tree_read_lock_atomic or
> btrfs_try_tree_write_lock would have to squeeze all of this between 1:
> and 2:

This is only a problem for unlocked (optimistic) accesses in those
functions. Simply because from its POV the eb->lock doesn't play any
role e.g. they don't know about it at all.

This implies there needs to be yet another synchronization/ordering
mechanism only for blocking_writer. But then further down you say that
there are no read side barrier because observing the accesses in a
particular order is not important for correctness.

Given this I fail to see what this smp_wmb affects ordering.
> 
> - check if blocking_writers is 0 (it is, continue)
> - try read lock, read lock or write lock (succeeds after 1:)
> - check blocking_writers again (continue)
> 
> All of that assumes that the reordered writes can survive for quite some
> time (unlikely if its in the internal store buffer).
> 
> Another point against observing that in practice is that
> blocking_writers and the lock are on the same cacheline (64B), so it's
> more likely both values are stored in order, or some sort of pending
> write flush will update blocking_writers, rwlock before the try lock
> happens. Assuming the CPUs work like that and don't hide other
> surprises.
> 
> struct extent_buffer {
> 	u64                        start;                /*     0     8 */
> 	long unsigned int          len;                  /*     8     8 */
> 	long unsigned int          bflags;               /*    16     8 */
> 	struct btrfs_fs_info *     fs_info;              /*    24     8 */
> 	spinlock_t                 refs_lock;            /*    32     4 */
> 	atomic_t                   refs;                 /*    36     4 */
> 	atomic_t                   io_pages;             /*    40     4 */
> 	int                        read_mirror;          /*    44     4 */
> 	struct callback_head callback_head __attribute__((__aligned__(8))); /*    48    16 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	pid_t                      lock_owner;           /*    64     4 */
> 	int                        blocking_writers;     /*    68     4 */
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 	atomic_t                   blocking_readers;     /*    72     4 */
> 	bool                       lock_nested;          /*    76     1 */
> 
> 	/* XXX 1 byte hole, try to pack */
> 
> 	short int                  log_index;            /*    78     2 */
> 	rwlock_t                   lock;                 /*    80     8 */
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 	wait_queue_head_t          write_lock_wq;        /*    88    24 */
> 	wait_queue_head_t          read_lock_wq;         /*   112    24 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 	struct page *              pages[16];            /*   136   128 */
> 
> 	/* size: 264, cachelines: 5, members: 18 */
> 	/* sum members: 263, holes: 1, sum holes: 1 */
> 	/* forced alignments: 1 */
> 	/* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));
> 
> Add the barriers for correctness sake.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/locking.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index a12f3edc3505..e0e0430577aa 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -110,6 +110,18 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
>  		btrfs_assert_spinning_writers_put(eb);
>  		btrfs_assert_tree_locked(eb);
>  		WRITE_ONCE(eb->blocking_writers, 1);
> +		/*
> +		 * Writers must be be updated before the lock is released so
> +		 * that other threads see that in order. Otherwise this could
> +		 * theoretically lead to blocking_writers be still set to 1 but
> +		 * this would be unexpected eg. for spinning locks.
> +		 *
> +		 * There are no pairing read barriers for unlocked access as we
> +		 * don't strictly need them for correctness (eg. in
> +		 * btrfs_try_tree_read_lock), and the unlock/lock is an implied
> +		 * barrier in other cases.
> +		 */
> +		smp_wmb();
>  		write_unlock(&eb->lock);

That comment sounds to me as if you only care about the readers of
blocking_writers _after_ they have acquired the eb::lock for reading. In
this case this smp_wmb is pointless because write_unlock/write_lock
imply release/acquire semantics.

Unlocked readers are not affected by this wmb.

>  	}
>  }
> @@ -316,7 +328,9 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
>  		/*
>  		 * We need to order modifying blocking_writers above with
>  		 * actually waking up the sleepers to ensure they see the
> -		 * updated value of blocking_writers
> +		 * updated value of blocking_writers.
> +		 *
> +		 * cond_wake_up calls smp_mb
>  		 */
>  		cond_wake_up(&eb->write_lock_wq);
>  	} else {
> 
