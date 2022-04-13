Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4DE50029A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 01:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiDMXal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDMXak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 19:30:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439171D305
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649892493;
        bh=kQQmrUq3+s2Dt3mpAFNaxlZGX288YikjCZkSXSsyVew=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=G0e3WR5vVc+yRpVTXEyuPzMauGKxsTrjPplyc24/BGaXhWJUPLG4D0LSP5/6uminA
         L17mzvmlu+dUQS+SXMSCRRhVSpo7yZyrqo5iCORSzuuI8xXFx96oSyExHr7z3FN6O5
         e5Fc/jCQjMHjfSscsab4h0EY1dAdHk2jwXx40Dwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1nIhBc3DkG-00M7nA; Thu, 14
 Apr 2022 01:28:13 +0200
Message-ID: <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
Date:   Thu, 14 Apr 2022 07:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220413191456.GN15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oV2ISjn1ll68dNZKFrpeEeqFwZzFyjsXwQAnY5tc/GEJODA4m+6
 tJg7LJJuC6KONqofE/48FUMipsL7sK2q8qCMlrjnapKHpJFZAnSTGPT3C7FkCa7qM7acIcm
 N7ab3X0QNWUWl3kL9DMXfgcBo1Pp8gWb3HTdp1UAGdX9Y7NtTHPoiEXvA5wNHSORFasmmj2
 9B/0cs+2UxsWeHvt3gbow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGXWzOjhl1k=:nXFvr7SAQphh0p1aFkAFdo
 K4ZsmsgdPL0Fmg26QN7A4BRpp+SIV6/XpmRX0aeFOi9UEw5ngn+Lp3yuhJ94NG/MtuUSRMv4y
 hdY7d5NOIpQ7jrlpI7/4E2tCxq9yUKHr4FqtwtQjgxJ3u4kXAFd3mrE+vpdLN4Wrb34Y1V7SZ
 L4eXFHY7ioNxdXf6mQdBcgM4zurkiHNvYD8uxvPDT9J6MOYOVDlWjlC8LKU/L4f0LNvJ6l4Vq
 wzo7fPqI2LnQOmzG28lHB4k0jOUwArFlPgSEIWvHNCXydEQICYnKSahY25pikBg4BHafSCdDM
 c/1AD1oIr4XyyYSq5TWh1AXYiNlip0KdXtE4azQzS6tcVJzo5EqM/rUpQAAetNSTkjMtS8o+f
 PDToioLIo81kY9j/7N0L1KPNh4NJn2/SYFZsBcZ4bfZak0vIEAxY25TiZS8XUyKPdwaCrE3gG
 sWWbNiVX0Z8rzNbN43Si8sa4wzRmie4XyGkpt1BW2mGcmtpI9xEGNiGhiktMBSfLUsnft7T9u
 /NclSammSR5tVb55GTbyKLkma1T+B5HBw7U6gJctICrAzf78uH/01yeogp8iGC6HRzwhs/075
 JtjdCLsA9SaBmVOhHGi1gwIbsRQT0TCbxN/aiv6JdMTOMF6xraes8eutgu/oUljLHaH+oZ5ru
 5M3f7MF57m4vMILPZfdSbt7jke8Os4459Fw4KNEs1qCwfd45YMt3LYEe09w00v/BlupQUgTaW
 vsoLJQURZvRqVgiqpb7nWlBRI5zttRnNftlN5gjqbMLgd2nFZPNPKpi+7KsaAY1V62TnJB0kV
 cfLVNyv7sPC2QkjLQMhe0cfuTn7LvqfFgTLpKOnLPt7ujH+UJlPINs0oMa5r/yhGvXyAMkifr
 YNxWYG9CrzG5xmnnR7l4i0f4XgY58h+KyCkfvZZcF6OUBPsmMOvHOnAhqpgl3hNbYyoq8noKG
 2i12MTIO3hBOvy+gXiWEd7BnnB49jgNBMv2z3aYMEkYlGC9YTq7FKyznkFHyvpk/rTdIF3jKZ
 c8g/xvezdkh9A9wRUBkCLo9H+xdX7uLYqtyrEE+TSMjsyNrcKuaTvM0bO+iqETJfE5MH/sdet
 bBO7DHJ0kmHv30=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/14 03:14, David Sterba wrote:
> There's an assertion failure reported by btrfs/023
>
> On Tue, Apr 12, 2022 at 05:32:57PM +0800, Qu Wenruo wrote:
>> +static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
>> +			      struct bio_list *bio_list,
>> +			      struct sector_ptr *sector,
>> +			      unsigned int stripe_nr,
>> +			      unsigned int sector_nr,
>> +			      unsigned long bio_max_len, unsigned int opf)
>>   {
>> +	const u32 sectorsize =3D rbio->bioc->fs_info->sectorsize;
>>   	struct bio *last =3D bio_list->tail;
>>   	int ret;
>>   	struct bio *bio;
>>   	struct btrfs_io_stripe *stripe;
>>   	u64 disk_start;
>>
>> +	/*
>> +	 * NOTE: here stripe_nr has taken device replace into consideration,
>> +	 * thus it can be larger than rbio->real_stripe.
>> +	 * So here we check against bioc->num_stripes, not rbio->real_stripes=
.
>> +	 */
>> +	ASSERT(stripe_nr >=3D 0 && stripe_nr < rbio->bioc->num_stripes);
>> +	ASSERT(sector_nr >=3D 0 && sector_nr < rbio->stripe_nsectors);
>> +	ASSERT(sector->page);
>
> This one ^^^

Failed to reproduce here, both x86_64 and aarch64 survived over 64 loops
of btrfs/023.

Although that's withy my github branch. Let me check the current branch
to see what's wrong.

Thanks,
Qu

>
> [ 2280.705765] assertion failed: sector->page, in fs/btrfs/raid56.c:1145
> [ 2280.707844] ------------[ cut here ]------------
> [ 2280.709401] kernel BUG at fs/btrfs/ctree.h:3614!
> [ 2280.711084] invalid opcode: 0000 [#1] PREEMPT SMP
> [ 2280.712822] CPU: 3 PID: 4084 Comm: kworker/u8:2 Not tainted 5.18.0-rc=
2-default+ #1697
> [ 2280.715648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 2280.719656] Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
> [ 2280.721775] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 2280.729575] RSP: 0018:ffffad6d071afda0 EFLAGS: 00010246
> [ 2280.730844] RAX: 0000000000000039 RBX: 0000000000000000 RCX: 00000000=
00000000
> [ 2280.732449] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000=
ffffffff
> [ 2280.733992] RBP: ffff8e51d5465000 R08: 0000000000000003 R09: 00000000=
00000002
> [ 2280.735535] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000=
00000003
> [ 2280.737093] R13: ffff8e51d5465000 R14: ffff8e51d5465d78 R15: 00000000=
00001000
> [ 2280.738613] FS:  0000000000000000(0000) GS:ffff8e523dc00000(0000) knl=
GS:0000000000000000
> [ 2280.740392] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2280.741794] CR2: 000055f48fe51ab0 CR3: 000000001f805001 CR4: 00000000=
00170ea0
> [ 2280.743532] Call Trace:
> [ 2280.744136]  <TASK>
> [ 2280.744701]  rbio_add_io_sector.cold+0x11/0x33 [btrfs]
> [ 2280.745846]  ? _raw_spin_unlock_irq+0x2f/0x50
> [ 2280.746782]  raid56_rmw_stripe.isra.0+0x153/0x320 [btrfs]
> [ 2280.747965]  btrfs_work_helper+0xd6/0x1d0 [btrfs]
> [ 2280.749018]  process_one_work+0x264/0x5f0
> [ 2280.749806]  worker_thread+0x52/0x3b0
> [ 2280.750523]  ? process_one_work+0x5f0/0x5f0
> [ 2280.751395]  kthread+0xea/0x110
> [ 2280.752097]  ? kthread_complete_and_exit+0x20/0x20
> [ 2280.753112]  ret_from_fork+0x1f/0x30
>
>
>> +
>> +	/* We don't yet support subpage, thus pgoff should always be 0 */
>> +	ASSERT(sector->pgoff =3D=3D 0);
>> +
>>   	stripe =3D &rbio->bioc->stripes[stripe_nr];
>> -	disk_start =3D stripe->physical + (page_index << PAGE_SHIFT);
>> +	disk_start =3D stripe->physical + sector_nr * sectorsize;
>>
>>   	/* if the device is missing, just fail this stripe */
>>   	if (!stripe->dev->bdev)
>> @@ -1156,8 +1226,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio=
 *rbio,
>>   		 */
>>   		if (last_end =3D=3D disk_start && !last->bi_status &&
>>   		    last->bi_bdev =3D=3D stripe->dev->bdev) {
>> -			ret =3D bio_add_page(last, page, PAGE_SIZE, 0);
>> -			if (ret =3D=3D PAGE_SIZE)
>> +			ret =3D bio_add_page(last, sector->page, sectorsize,
>> +					   sector->pgoff);
>> +			if (ret =3D=3D sectorsize)
>>   				return 0;
>>   		}
>>   	}
>> @@ -1168,7 +1239,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio=
 *rbio,
>>   	bio->bi_iter.bi_sector =3D disk_start >> 9;
>>   	bio->bi_private =3D rbio;
>>
>> -	bio_add_page(bio, page, PAGE_SIZE, 0);
>> +	bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
>>   	bio_list_add(bio_list, bio);
>>   	return 0;
>>   }
>> @@ -1265,7 +1336,7 @@ static noinline void finish_rmw(struct btrfs_raid=
_bio *rbio)
>>   	void **pointers =3D rbio->finish_pointers;
>>   	int nr_data =3D rbio->nr_data;
>>   	int stripe;
>> -	int pagenr;
>> +	int sectornr;
>>   	bool has_qstripe;
>>   	struct bio_list bio_list;
>>   	struct bio *bio;
>> @@ -1309,16 +1380,16 @@ static noinline void finish_rmw(struct btrfs_ra=
id_bio *rbio)
>>   	else
>>   		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
>>
>> -	for (pagenr =3D 0; pagenr < rbio->stripe_npages; pagenr++) {
>> +	for (sectornr =3D 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>>   		struct page *p;
>>   		/* first collect one page from each data stripe */
>>   		for (stripe =3D 0; stripe < nr_data; stripe++) {
>> -			p =3D page_in_rbio(rbio, stripe, pagenr, 0);
>> +			p =3D page_in_rbio(rbio, stripe, sectornr, 0);
>>   			pointers[stripe] =3D kmap_local_page(p);
>>   		}
>>
>>   		/* then add the parity stripe */
>> -		p =3D rbio_pstripe_page(rbio, pagenr);
>> +		p =3D rbio_pstripe_page(rbio, sectornr);
>>   		SetPageUptodate(p);
>>   		pointers[stripe++] =3D kmap_local_page(p);
>>
>> @@ -1328,7 +1399,7 @@ static noinline void finish_rmw(struct btrfs_raid=
_bio *rbio)
>>   			 * raid6, add the qstripe and call the
>>   			 * library function to fill in our p/q
>>   			 */
>> -			p =3D rbio_qstripe_page(rbio, pagenr);
>> +			p =3D rbio_qstripe_page(rbio, sectornr);
>>   			SetPageUptodate(p);
>>   			pointers[stripe++] =3D kmap_local_page(p);
>>
>> @@ -1349,19 +1420,19 @@ static noinline void finish_rmw(struct btrfs_ra=
id_bio *rbio)
>>   	 * everything else.
>>   	 */
>>   	for (stripe =3D 0; stripe < rbio->real_stripes; stripe++) {
>> -		for (pagenr =3D 0; pagenr < rbio->stripe_npages; pagenr++) {
>> -			struct page *page;
>> +		for (sectornr =3D 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>> +			struct sector_ptr *sector;
>> +
>>   			if (stripe < rbio->nr_data) {
>> -				page =3D page_in_rbio(rbio, stripe, pagenr, 1);
>> -				if (!page)
>> +				sector =3D sector_in_rbio(rbio, stripe, sectornr, 1);
>> +				if (!sector)
>>   					continue;
>>   			} else {
>> -			       page =3D rbio_stripe_page(rbio, stripe, pagenr);
>> +				sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>>   			}
>>
>> -			ret =3D rbio_add_io_page(rbio, &bio_list,
>> -				       page, stripe, pagenr, rbio->stripe_len,
>> -				       REQ_OP_WRITE);
>> +			ret =3D rbio_add_io_sector(rbio, &bio_list, sector, stripe,
>> +						 sectornr, rbio->stripe_len, REQ_OP_WRITE);
>>   			if (ret)
>>   				goto cleanup;
>>   		}
>> @@ -1374,20 +1445,21 @@ static noinline void finish_rmw(struct btrfs_ra=
id_bio *rbio)
>>   		if (!bioc->tgtdev_map[stripe])
>>   			continue;
>>
>> -		for (pagenr =3D 0; pagenr < rbio->stripe_npages; pagenr++) {
>> -			struct page *page;
>> +		for (sectornr =3D 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>> +			struct sector_ptr *sector;
>> +
>>   			if (stripe < rbio->nr_data) {
>> -				page =3D page_in_rbio(rbio, stripe, pagenr, 1);
>> -				if (!page)
>> +				sector =3D sector_in_rbio(rbio, stripe, sectornr, 1);
>> +				if (!sector)
>>   					continue;
>>   			} else {
>> -			       page =3D rbio_stripe_page(rbio, stripe, pagenr);
>> +				sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>>   			}
>>
>> -			ret =3D rbio_add_io_page(rbio, &bio_list, page,
>> -					       rbio->bioc->tgtdev_map[stripe],
>> -					       pagenr, rbio->stripe_len,
>> -					       REQ_OP_WRITE);
>> +			ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>> +						 rbio->bioc->tgtdev_map[stripe],
>> +						 sectornr, rbio->stripe_len,
>> +						 REQ_OP_WRITE);
>>   			if (ret)
>>   				goto cleanup;
>>   		}
>> @@ -1563,7 +1635,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bi=
o *rbio)
>>   	int bios_to_read =3D 0;
>>   	struct bio_list bio_list;
>>   	int ret;
>> -	int pagenr;
>> +	int sectornr;
>>   	int stripe;
>>   	struct bio *bio;
>>
>> @@ -1581,28 +1653,29 @@ static int raid56_rmw_stripe(struct btrfs_raid_=
bio *rbio)
>>   	 * stripe
>>   	 */
>>   	for (stripe =3D 0; stripe < rbio->nr_data; stripe++) {
>> -		for (pagenr =3D 0; pagenr < rbio->stripe_npages; pagenr++) {
>> -			struct page *page;
>> +		for (sectornr =3D 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>> +			struct sector_ptr *sector;
>> +
>>   			/*
>> -			 * we want to find all the pages missing from
>> +			 * We want to find all the sectors missing from
>>   			 * the rbio and read them from the disk.  If
>> -			 * page_in_rbio finds a page in the bio list
>> +			 * sector_in_rbio() finds a page in the bio list
>>   			 * we don't need to read it off the stripe.
>>   			 */
>> -			page =3D page_in_rbio(rbio, stripe, pagenr, 1);
>> -			if (page)
>> +			sector =3D sector_in_rbio(rbio, stripe, sectornr, 1);
>> +			if (sector)
>>   				continue;
>>
>> -			page =3D rbio_stripe_page(rbio, stripe, pagenr);
>> +			sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>>   			/*
>> -			 * the bio cache may have handed us an uptodate
>> +			 * The bio cache may have handed us an uptodate
>>   			 * page.  If so, be happy and use it
>>   			 */
>> -			if (PageUptodate(page))
>> +			if (sector->uptodate)
>>   				continue;
>>
>> -			ret =3D rbio_add_io_page(rbio, &bio_list, page,
>> -				       stripe, pagenr, rbio->stripe_len,
>> +			ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>> +				       stripe, sectornr, rbio->stripe_len,
>>   				       REQ_OP_READ);
>>   			if (ret)
>>   				goto cleanup;
>> @@ -2107,7 +2180,7 @@ static int __raid56_parity_recover(struct btrfs_r=
aid_bio *rbio)
>>   	int bios_to_read =3D 0;
>>   	struct bio_list bio_list;
>>   	int ret;
>> -	int pagenr;
>> +	int sectornr;
>>   	int stripe;
>>   	struct bio *bio;
>>
>> @@ -2130,21 +2203,20 @@ static int __raid56_parity_recover(struct btrfs=
_raid_bio *rbio)
>>   			continue;
>>   		}
>>
>> -		for (pagenr =3D 0; pagenr < rbio->stripe_npages; pagenr++) {
>> -			struct page *p;
>> +		for (sectornr =3D 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>> +			struct sector_ptr *sector;
>>
>>   			/*
>>   			 * the rmw code may have already read this
>>   			 * page in
>>   			 */
>> -			p =3D rbio_stripe_page(rbio, stripe, pagenr);
>> -			if (PageUptodate(p))
>> +			sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>> +			if (sector->uptodate)
>>   				continue;
>>
>> -			ret =3D rbio_add_io_page(rbio, &bio_list,
>> -				       rbio_stripe_page(rbio, stripe, pagenr),
>> -				       stripe, pagenr, rbio->stripe_len,
>> -				       REQ_OP_READ);
>> +			ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>> +						 stripe, sectornr,
>> +						 rbio->stripe_len, REQ_OP_READ);
>>   			if (ret < 0)
>>   				goto cleanup;
>>   		}
>> @@ -2399,7 +2471,7 @@ static noinline void finish_parity_scrub(struct b=
trfs_raid_bio *rbio,
>>   	unsigned long *pbitmap =3D rbio->finish_pbitmap;
>>   	int nr_data =3D rbio->nr_data;
>>   	int stripe;
>> -	int pagenr;
>> +	int sectornr;
>>   	bool has_qstripe;
>>   	struct page *p_page =3D NULL;
>>   	struct page *q_page =3D NULL;
>> @@ -2419,7 +2491,7 @@ static noinline void finish_parity_scrub(struct b=
trfs_raid_bio *rbio,
>>
>>   	if (bioc->num_tgtdevs && bioc->tgtdev_map[rbio->scrubp]) {
>>   		is_replace =3D 1;
>> -		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_npages);
>> +		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_nsectors);
>>   	}
>>
>>   	/*
>> @@ -2453,12 +2525,12 @@ static noinline void finish_parity_scrub(struct=
 btrfs_raid_bio *rbio,
>>   	/* Map the parity stripe just once */
>>   	pointers[nr_data] =3D kmap_local_page(p_page);
>>
>> -	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
>> +	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
>>   		struct page *p;
>>   		void *parity;
>>   		/* first collect one page from each data stripe */
>>   		for (stripe =3D 0; stripe < nr_data; stripe++) {
>> -			p =3D page_in_rbio(rbio, stripe, pagenr, 0);
>> +			p =3D page_in_rbio(rbio, stripe, sectornr, 0);
>>   			pointers[stripe] =3D kmap_local_page(p);
>>   		}
>>
>> @@ -2473,13 +2545,13 @@ static noinline void finish_parity_scrub(struct=
 btrfs_raid_bio *rbio,
>>   		}
>>
>>   		/* Check scrubbing parity and repair it */
>> -		p =3D rbio_stripe_page(rbio, rbio->scrubp, pagenr);
>> +		p =3D rbio_stripe_page(rbio, rbio->scrubp, sectornr);
>>   		parity =3D kmap_local_page(p);
>>   		if (memcmp(parity, pointers[rbio->scrubp], PAGE_SIZE))
>>   			copy_page(parity, pointers[rbio->scrubp]);
>>   		else
>>   			/* Parity is right, needn't writeback */
>> -			bitmap_clear(rbio->dbitmap, pagenr, 1);
>> +			bitmap_clear(rbio->dbitmap, sectornr, 1);
>>   		kunmap_local(parity);
>>
>>   		for (stripe =3D nr_data - 1; stripe >=3D 0; stripe--)
>> @@ -2499,12 +2571,13 @@ static noinline void finish_parity_scrub(struct=
 btrfs_raid_bio *rbio,
>>   	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
>>   	 * everything else.
>>   	 */
>> -	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
>> -		struct page *page;
>> +	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
>> +		struct sector_ptr *sector;
>>
>> -		page =3D rbio_stripe_page(rbio, rbio->scrubp, pagenr);
>> -		ret =3D rbio_add_io_page(rbio, &bio_list, page, rbio->scrubp,
>> -				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
>> +		sector =3D rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
>> +		ret =3D rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
>> +					 sectornr, rbio->stripe_len,
>> +					 REQ_OP_WRITE);
>>   		if (ret)
>>   			goto cleanup;
>>   	}
>> @@ -2512,13 +2585,13 @@ static noinline void finish_parity_scrub(struct=
 btrfs_raid_bio *rbio,
>>   	if (!is_replace)
>>   		goto submit_write;
>>
>> -	for_each_set_bit(pagenr, pbitmap, rbio->stripe_npages) {
>> -		struct page *page;
>> +	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
>> +		struct sector_ptr *sector;
>>
>> -		page =3D rbio_stripe_page(rbio, rbio->scrubp, pagenr);
>> -		ret =3D rbio_add_io_page(rbio, &bio_list, page,
>> +		sector =3D rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
>> +		ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>>   				       bioc->tgtdev_map[rbio->scrubp],
>> -				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
>> +				       sectornr, rbio->stripe_len, REQ_OP_WRITE);
>>   		if (ret)
>>   			goto cleanup;
>>   	}
>> @@ -2650,7 +2723,7 @@ static void raid56_parity_scrub_stripe(struct btr=
fs_raid_bio *rbio)
>>   	int bios_to_read =3D 0;
>>   	struct bio_list bio_list;
>>   	int ret;
>> -	int pagenr;
>> +	int sectornr;
>>   	int stripe;
>>   	struct bio *bio;
>>
>> @@ -2666,28 +2739,30 @@ static void raid56_parity_scrub_stripe(struct b=
trfs_raid_bio *rbio)
>>   	 * stripe
>>   	 */
>>   	for (stripe =3D 0; stripe < rbio->real_stripes; stripe++) {
>> -		for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
>> -			struct page *page;
>> +		for_each_set_bit(sectornr, rbio->dbitmap,
>> +				 rbio->stripe_nsectors) {
>> +			struct sector_ptr *sector;
>>   			/*
>> -			 * we want to find all the pages missing from
>> +			 * We want to find all the sectors missing from
>>   			 * the rbio and read them from the disk.  If
>> -			 * page_in_rbio finds a page in the bio list
>> +			 * sector_in_rbio() finds a sector in the bio list
>>   			 * we don't need to read it off the stripe.
>>   			 */
>> -			page =3D page_in_rbio(rbio, stripe, pagenr, 1);
>> -			if (page)
>> +			sector =3D sector_in_rbio(rbio, stripe, sectornr, 1);
>> +			if (sector)
>>   				continue;
>>
>> -			page =3D rbio_stripe_page(rbio, stripe, pagenr);
>> +			sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>>   			/*
>> -			 * the bio cache may have handed us an uptodate
>> -			 * page.  If so, be happy and use it
>> +			 * The bio cache may have handed us an uptodate
>> +			 * sector.  If so, be happy and use it
>>   			 */
>> -			if (PageUptodate(page))
>> +			if (sector->uptodate)
>>   				continue;
>>
>> -			ret =3D rbio_add_io_page(rbio, &bio_list, page, stripe,
>> -					       pagenr, rbio->stripe_len, REQ_OP_READ);
>> +			ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>> +						 stripe, sectornr,
>> +						 rbio->stripe_len, REQ_OP_READ);
>>   			if (ret)
>>   				goto cleanup;
>>   		}
>> --
>> 2.35.1
