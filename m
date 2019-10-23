Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74940E1899
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404584AbfJWLQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 07:16:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404554AbfJWLQd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 07:16:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CA45B1AD;
        Wed, 23 Oct 2019 11:16:28 +0000 (UTC)
Subject: Re: [PATCH 5/5] btrfs: document extent buffer locking
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
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
Message-ID: <ca92c081-7991-fd12-70e6-b392ba107260@suse.com>
Date:   Wed, 23 Oct 2019 14:16:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.10.19 г. 22:39 ч., David Sterba wrote:
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/locking.c | 110 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 96 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index e0e0430577aa..2a0e828b4470 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -13,6 +13,48 @@
>  #include "extent_io.h"
>  #include "locking.h"
>  
> +/*
> + * Extent buffer locking
> + * ~~~~~~~~~~~~~~~~~~~~~
> + *
> + * The locks use a custom scheme that allows to do more operations than are
> + * available fromt current locking primitives. The building blocks are still
> + * rwlock and wait queues.
> + *
> + * Required semantics:
> + *
> + * - reader/writer exclusion
> + * - writer/writer exclusion
> + * - reader/reader sharing
> + * - spinning lock semantics
> + * - blocking lock semantics
> + * - try-lock semantics for readers and writers
> + * - one level nesting, allowing read lock to be taken by the same thread that
> + *   already has write lock
> + *
> + * The extent buffer locks (also called tree locks) manage access to eb data.
> + * We want concurrency of many readers and safe updates. The underlying locking
> + * is done by read-write spinlock and the blocking part is implemented using
> + * counters and wait queues.
> + *
> + * spinning semantics - the low-level rwlock is held so all other threads that
> + *                      want to take it are spinning on it.
> + *
> + * blocking semantics - the low-level rwlock is not held but the counter
> + *                      denotes how many times the blocking lock was held;
> + *                      sleeping is possible
> + *
> + * Write lock always allows only one thread to access the data.
> + *
> + *
> + * Debugging
> + * ~~~~~~~~~
> + *
> + * There are additional state counters that are asserted in various contexts,
> + * removed from non-debug build to reduce extent_buffer size and for
> + * performance reasons.
> + */
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  static inline void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
>  {
> @@ -80,6 +122,15 @@ static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb) { }
>  static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
>  #endif
>  
> +/*
> + * Mark already held read lock as blocking. Can be nested in write lock by the
> + * same thread.
> + *
> + * Use when there are potentially long operations ahead so other thread waiting
> + * on the lock will not actively spin but sleep instead.
> + *
> + * The rwlock is released and blocking reader counter is increased.
> + */
>  void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
>  {

I think for this and it's write counterpart a
lockdep_assert_held(eb->lock) will be a better way to document the fact
the lock needs to be held when those functions are called.

>  	trace_btrfs_set_lock_blocking_read(eb);

<snip>

>  /*
> - * drop a blocking read lock
> + * Release read lock, previously set to blocking by a pairing call to
> + * btrfs_set_lock_blocking_read(). Can be nested in write lock by the same
> + * thread.
> + *
> + * State of rwlock is unchanged, last reader wakes waiting threads.
>   */
>  void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
>  {
> @@ -279,8 +354,10 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
>  }
>  
>  /*
> - * take a spinning write lock.  This will wait for both
> - * blocking readers or writers
> + * Lock for write. Wait for all blocking and spinning readers and writers. This
> + * starts context where reader lock could be nested by the same thread.

Imo you shouldn't ommit the explicit mention this takes a spinning lock.

> + *
> + * The rwlock is held for write upon exit.
>   */
>  void btrfs_tree_lock(struct extent_buffer *eb)
>  {
> @@ -307,7 +384,12 @@ void btrfs_tree_lock(struct extent_buffer *eb)
>  }
>  
>  /*
> - * drop a spinning or a blocking write lock.
> + * Release the write lock, either blocking or spinning (ie. there's no need
> + * for an explicit blocking unlock, like btrfs_tree_read_unlock_blocking).
> + * This also ends the context for nesting, the read lock must have been
> + * released already.
> + *
> + * Tasks blocked and waiting are woken, rwlock is not held upon exit.
>   */
>  void btrfs_tree_unlock(struct extent_buffer *eb)
>  {
> 
