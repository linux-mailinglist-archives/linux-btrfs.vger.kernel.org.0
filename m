Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97176DDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfGZPaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 11:30:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbfGZPaD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F15B8B628;
        Fri, 26 Jul 2019 15:29:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 3/5] Btrfs: only associate the locked page with one
 async_cow struct
To:     Chris Mason <clm@fb.com>
Cc:     Kernel Team <Kernel-team@fb.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        David Sterba <dsterba@suse.com>, "jack@suse.cz" <jack@suse.cz>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190710192818.1069475-1-tj@kernel.org>
 <20190710192818.1069475-4-tj@kernel.org>
 <0522e068-57d0-f7f2-6500-f431225bdc73@suse.com>
 <C459F9B6-8154-4099-BC62-C3DCCAF56CE2@fb.com>
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
Message-ID: <c2419d01-5c84-3fb4-189e-4db519d08796@suse.com>
Date:   Fri, 26 Jul 2019 18:29:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <C459F9B6-8154-4099-BC62-C3DCCAF56CE2@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.07.19 г. 22:52 ч., Chris Mason wrote:
> On 11 Jul 2019, at 12:00, Nikolay Borisov wrote:
> 
>> On 10.07.19 г. 22:28 ч., Tejun Heo wrote:
>>> From: Chris Mason <clm@fb.com>
>>>
>>> The btrfs writepages function collects a large range of pages flagged
>>> for delayed allocation, and then sends them down through the COW code
>>> for processing.  When compression is on, we allocate one async_cow
>>
>> nit: The code no longer uses async_cow to represent in-flight chunks 
>> but
>> the more aptly named async_chunk. Presumably this patchset predates
>> those changes.
> 
> Not by much, but yes.
> 
>>
>>>
>>> The end result is that cowA is completed and cleaned up before cowB 
>>> even
>>> starts processing.  This means we can free locked_page() and reuse it
>>> elsewhere.  If we get really lucky, it'll have the same page->index 
>>> in
>>> its new home as it did before.
>>>
>>> While we're processing cowB, we might decide we need to fall back to
>>> uncompressed IO, and so compress_file_range() will call
>>> __set_page_dirty_nobufers() on cowB->locked_page.
>>>
>>> Without cgroups in use, this creates as a phantom dirty page, which> 
>>> isn't great but isn't the end of the world.  With cgroups in use, we
>>
>> Having a phantom dirty page is not great but not terrible without
>> cgroups but apart from that, does it have any other implications?
> 
> Best case, it'll go through the writepage fixup worker and go through 
> the whole cow machinery again.  Worst case we go to this code more than 
> once:
> 
>                          /*
>                           * if page_started, cow_file_range inserted an
>                           * inline extent and took care of all the 
> unlocking
>                           * and IO for us.  Otherwise, we need to submit
>                           * all those pages down to the drive.
>                           */
>                          if (!page_started && !ret)
>                                  extent_write_locked_range(inode,
>                                                    async_extent->start,
>                                                    async_extent->start +
>                                                    async_extent->ram_size 
> - 1,
>                                                    WB_SYNC_ALL);
>                          else if (ret)
>                                  unlock_page(async_chunk->locked_page);
> 
> 
> That never happened in production as far as I can tell, but it seems 
> possible.
> 
>>
>>
>>> might crash in the accounting code because page->mapping->i_wb isn't
>>> set.
>>>
>>> [ 8308.523110] BUG: unable to handle kernel NULL pointer dereference 
>>> at 00000000000000d0
>>> [ 8308.531084] IP: percpu_counter_add_batch+0x11/0x70
>>> [ 8308.538371] PGD 66534e067 P4D 66534e067 PUD 66534f067 PMD 0
>>> [ 8308.541750] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
>>> [ 8308.551948] CPU: 16 PID: 2172 Comm: rm Not tainted
>>> [ 8308.566883] RIP: 0010:percpu_counter_add_batch+0x11/0x70
>>> [ 8308.567891] RSP: 0018:ffffc9000a97bbe0 EFLAGS: 00010286
>>> [ 8308.568986] RAX: 0000000000000005 RBX: 0000000000000090 RCX: 
>>> 0000000000026115
>>> [ 8308.570734] RDX: 0000000000000030 RSI: ffffffffffffffff RDI: 
>>> 0000000000000090
>>> [ 8308.572543] RBP: 0000000000000000 R08: fffffffffffffff5 R09: 
>>> 0000000000000000
>>> [ 8308.573856] R10: 00000000000260c0 R11: ffff881037fc26c0 R12: 
>>> ffffffffffffffff
>>> [ 8308.580099] R13: ffff880fe4111548 R14: ffffc9000a97bc90 R15: 
>>> 0000000000000001
>>> [ 8308.582520] FS:  00007f5503ced480(0000) GS:ffff880ff7200000(0000) 
>>> knlGS:0000000000000000
>>> [ 8308.585440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 8308.587951] CR2: 00000000000000d0 CR3: 00000001e0459005 CR4: 
>>> 0000000000360ee0
>>> [ 8308.590707] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [ 8308.592865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>> 0000000000000400
>>> [ 8308.594469] Call Trace:
>>> [ 8308.595149]  account_page_cleaned+0x15b/0x1f0
>>> [ 8308.596340]  __cancel_dirty_page+0x146/0x200
>>> [ 8308.599395]  truncate_cleanup_page+0x92/0xb0
>>> [ 8308.600480]  truncate_inode_pages_range+0x202/0x7d0
>>> [ 8308.617392]  btrfs_evict_inode+0x92/0x5a0
>>> [ 8308.619108]  evict+0xc1/0x190
>>> [ 8308.620023]  do_unlinkat+0x176/0x280
>>> [ 8308.621202]  do_syscall_64+0x63/0x1a0
>>> [ 8308.623451]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>>
>>> The fix here is to make asyc_cow->locked_page NULL everywhere but the
>>> one async_cow struct that's allowed to do things to the locked page.
>>>
>>> Signed-off-by: Chris Mason <clm@fb.com>
>>> Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and 
>>> reads")
>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>  fs/btrfs/extent_io.c |  2 +-
>>>  fs/btrfs/inode.c     | 25 +++++++++++++++++++++----
>>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 5106008f5e28..a31574df06aa 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -1838,7 +1838,7 @@ static int __process_pages_contig(struct 
>>> address_space *mapping,
>>>  			if (page_ops & PAGE_SET_PRIVATE2)
>>>  				SetPagePrivate2(pages[i]);
>>>
>>> -			if (pages[i] == locked_page) {
>>> +			if (locked_page && pages[i] == locked_page) {
>>
>> Why not make the check just if (locked_page) then clean it up, since 
>> if
>> __process_pages_contig is called from the owner of the page then it's
>> guaranteed that the page will fall within it's range.
> 
> I'm not convinced that every single caller of __process_pages_contig is 
> making sure to only send locked_page for ranges that correspond to the 
> locked_page.  I'm not sure exactly what you're asking for though, it 
> looks like it would require some larger changes to the flow of that 
> loop.


What I meant it is to simply factor out the code dealing with locked
page outside of the loop and still place it inside
__process_pages_contig. Also looking at the way locked_pages is passed
across different call chains I arrive at:


compress_file_range  <-- locked page is null
 extent_clear_unlock_delalloc
  __process_pages_contig

submit_compressed_extents <---- locked page is null
 extent_clear_unlock_delalloc
  __process_pages_contig

btrfs_run_delalloc_range | run_delalloc_nocow
 cow_file_range <--- [when called from btrfs_run_delalloc_range we are
all fine and dandy because it will always iterates a range which belongs
to the page. So we can free the page and set it null for subsequent
passes of the loop.]

Looking run_delalloc_nocow I see the page is used 5
times - 2 of those, at the beginning and end of the function, are only
used during error cases. The other 2 times is if cow_start is different
than -1 , which happens if !nocow is true. I've yet to wrap my head
around run_delalloc_nocow but I think it should also be safe to pass
locked page just once.

cow_file_range_async <--- always called with the correct locked page, in
this case the function is called before any async chunks are going to be
submitted.
 extent_clear_unlock_delalloc
  __process_pages_contig

btrfs_run_delalloc_range <--- this one is called with locked_page
belonging to the passed delalloc range.
 run_delalloc_nocow
  extent_clear_unlock_delalloc
   __process_pages_contig


writepage_delalloc <-- calls find_lock_delalloc_range only if we aren't
caalled from compress path and the start range always belongs to the page
 find_lock_delalloc_range <----  if the range is not delalloc it will
retry. But that function is also called with the correct page.
  lock_delalloc_pages <--- ignores range which belongs only to this page
    __unlock_for_delaloc <--- ignores range which belongs only to this page




<snip>
