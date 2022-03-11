Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D94D6A9C
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 00:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiCKXS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 18:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiCKXS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 18:18:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D308912CC08
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647040666;
        bh=anQRrVZJ1Qm9nsST40flO7AZ58iFglXIpOpdp17mI7c=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=KBOY1I5ZkFYtnLG2hUzpMbyIRPCALVsViHF5gMVev37g+USOxgzDipdboM/QyhcEn
         keENrl/M0czCvFAuGIeHrjyI5nDTf+J+wzsZfhBS7TPq5hRLBVhQ7XxDYHfWYQmmqY
         SyscLTCpAAgneuz0+FL73Ue9b2Cn01XKElnE3FRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5iZ-1nlAse18k9-00J2Bq; Sat, 12
 Mar 2022 00:17:46 +0100
Message-ID: <3c5ddeae-69dd-2dd9-c15b-a811396a8981@gmx.com>
Date:   Sat, 12 Mar 2022 07:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646983771.git.wqu@suse.com>
 <b971391a31a3cee8f7c19d02dd2a48328c580d1b.1646983771.git.wqu@suse.com>
 <20220311174914.GE12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 1/3] btrfs: scrub: rename members related to
 scrub_block::pagev
In-Reply-To: <20220311174914.GE12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JKq2rGBhpOwE4TDq0A/otqiV/Pz18JbF7aht/yStJN1pt4pW7Tt
 NA1sIa+6TZCyyIbAOK/O1uon4BqOclGYDnv3WM3sk4Y7F9XqO71+MM8ZuIBHNnQpNYeQD4Y
 sJkQDyOYjz6diPW89eWYS0nhhEcF3JfM0c+hLSYo0hGFqjUjIr/FHxZwgYuYE906xNOAw0M
 9vuBfXBP2XPUBz1fZDo8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E8ydwsCbnaw=:czVH+RYV9iVp1ZD2M+JAxp
 05huefoHRtQN93Ijqp9sPuGmoUvMYMN4TMEA3v2rYU2OuFPC6M3UdzUt2ovAJCfqUl1IdA4+I
 C2xf3WF5FnboJsGjNVp4SZ8Dgh5QkqZRRnYENSxJvHPEUV7i8WuPTXJ+XsF2B8gKJfclJu9W7
 DAfCy5SivFvxK2kMvH54WLYfgJS/HbXJu9/P3P8it0dYCPchSVqI+D/7kkb5DVsQLRM36kKP+
 YuOwU8AojkL45XunJyuN1MsLmAYz5D/QhMGsXzq5sd4M/v6G3X+LeHiHtO5Ah0wnEMGg1MIET
 g25vvjrF/PgAkDl4ootg7zBoSgBOCVeuR6rSbSzwd23VR3oocec2jUuoK82RFQde8nvAouhNv
 5HI3VNDSSOIk64DuM8NbvQukjue6mXtgkwcjo4CvpCCv4PJxzw2c2KPbA01QCa9nP2Ju/bA40
 oaJIF6HeLVdVD1WABTkW7gV9oY2Js+M2vvUJWEBcv+8m/Yq+cBTXC+lQtSVPUdL4f4fxhwrqn
 o43SwG9lP1D+dipsHzK/vwllbUs6qyKvWxnzjHzJqfyzv7oCri0gIPD+IIAj9HsbcRM7LDHxj
 DrI+Jcx1v/CoJlOqEkuZw66CQhNXQv6Oru8ym42IilERQMLpuK2EFBibK5fT8550QYHA5nS19
 ryMgRWjody9TeonFjRf3mQuGTerOKwsxSVf7EIyHu75EBlJBmdvuSEthxFzFj0N1a1I6pmWeM
 t2Apwl4GaR2d3XSA17kUsJ8gcYb9S9SU5dWlsw0JUJRsZMtyr+7/vJBONh2/zOZt9Kyvsj2XM
 a2XfXSaOWOTauPiUA1L27FZ4kensLQ05f6aL8/21mGTgYApFcDIaNTG5SZ5KH8rAQb5yVKiuz
 fIXYdrJMOKiw1uT4Zijz1D78FvNvUJ/e/SreUg3Lk9mMyeaHObuRXnQ5J0JmHa16Mryl2hqY4
 b9tc3hJ64cO9IAuL+2/h47nAa/Fb1JxoeZMJeLcUUCIwLssJZ/G8qvqZCUS8jLUqB+BCGnHA9
 jTGWDi7LiYNODEDE2G5CPM7PR/t0grH6WPxDJIDPKJCmuuyBHYXCu7RLPAmM/NYmcJf0s76I6
 nLb61O0BqOQ618=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/12 01:49, David Sterba wrote:
> On Fri, Mar 11, 2022 at 03:34:18PM +0800, Qu Wenruo wrote:
>> The following will be renamed in this patch:
>>
>> - scrub_block::pagev -> sectorv
>
> I think you can come up with a different naming scheme and not copy the
> original, eg. something closer what we've been using elsewhere. Here the
> 'pagev' is a page vector, but 'sectors' is IMHO fine and also
> understandable.

OK, I would to 'sectors' as I'm not a fan of the 'v' suffix either.

>
>>
>> - scrub_block::page_count -> sector_count
>>
>> - SCRUB_MAX_PAGES_PER_BLOCK -> SCRUB_MAX_SECTORS_PER_BLOCK
>>
>> - page_num -> sector_num to iterate scrub_block::sectorv
>>
>> For now scrub_page is not yet renamed, as the current changeset is
>> already large enough.
>>
>> The rename for scrub_page will come in a separate patch.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 220 +++++++++++++++++++++++-----------------------=
-
>>   1 file changed, 110 insertions(+), 110 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 11089568b287..fd67e1acdba6 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -52,7 +52,7 @@ struct scrub_ctx;
>>    * The following value times PAGE_SIZE needs to be large enough to ma=
tch the
>>    * largest node/leaf/sector size that shall be supported.
>>    */
>> -#define SCRUB_MAX_PAGES_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4=
K)
>> +#define SCRUB_MAX_SECTORS_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ=
_4K)
>>
>>   struct scrub_recover {
>>   	refcount_t		refs;
>> @@ -94,8 +94,8 @@ struct scrub_bio {
>>   };
>>
>>   struct scrub_block {
>> -	struct scrub_page	*pagev[SCRUB_MAX_PAGES_PER_BLOCK];
>> -	int			page_count;
>> +	struct scrub_page	*sectorv[SCRUB_MAX_SECTORS_PER_BLOCK];
>> +	int			sector_count;
>>   	atomic_t		outstanding_pages;
>>   	refcount_t		refs; /* free mem on transition to zero */
>>   	struct scrub_ctx	*sctx;
>> @@ -728,16 +728,16 @@ static void scrub_print_warning(const char *errst=
r, struct scrub_block *sblock)
>>   	u8 ref_level =3D 0;
>>   	int ret;
>>
>> -	WARN_ON(sblock->page_count < 1);
>> -	dev =3D sblock->pagev[0]->dev;
>> +	WARN_ON(sblock->sector_count < 1);
>> +	dev =3D sblock->sectorv[0]->dev;
>>   	fs_info =3D sblock->sctx->fs_info;
>>
>>   	path =3D btrfs_alloc_path();
>>   	if (!path)
>>   		return;
>>
>> -	swarn.physical =3D sblock->pagev[0]->physical;
>> -	swarn.logical =3D sblock->pagev[0]->logical;
>> +	swarn.physical =3D sblock->sectorv[0]->physical;
>> +	swarn.logical =3D sblock->sectorv[0]->logical;
>>   	swarn.errstr =3D errstr;
>>   	swarn.dev =3D NULL;
>>
>> @@ -817,16 +817,16 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>>   	struct scrub_block *sblock_bad;
>>   	int ret;
>>   	int mirror_index;
>> -	int page_num;
>> +	int sector_num;
>>   	int success;
>>   	bool full_stripe_locked;
>>   	unsigned int nofs_flag;
>>   	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>>   				      DEFAULT_RATELIMIT_BURST);
>>
>> -	BUG_ON(sblock_to_check->page_count < 1);
>> +	BUG_ON(sblock_to_check->sector_count < 1);
>>   	fs_info =3D sctx->fs_info;
>> -	if (sblock_to_check->pagev[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
>> +	if (sblock_to_check->sectorv[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
>>   		/*
>>   		 * if we find an error in a super block, we just report it.
>>   		 * They will get written with the next transaction commit
>> @@ -837,13 +837,13 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>>   		spin_unlock(&sctx->stat_lock);
>>   		return 0;
>>   	}
>> -	logical =3D sblock_to_check->pagev[0]->logical;
>> -	BUG_ON(sblock_to_check->pagev[0]->mirror_num < 1);
>> -	failed_mirror_index =3D sblock_to_check->pagev[0]->mirror_num - 1;
>> -	is_metadata =3D !(sblock_to_check->pagev[0]->flags &
>> +	logical =3D sblock_to_check->sectorv[0]->logical;
>> +	BUG_ON(sblock_to_check->sectorv[0]->mirror_num < 1);
>> +	failed_mirror_index =3D sblock_to_check->sectorv[0]->mirror_num - 1;
>> +	is_metadata =3D !(sblock_to_check->sectorv[0]->flags &
>>   			BTRFS_EXTENT_FLAG_DATA);
>> -	have_csum =3D sblock_to_check->pagev[0]->have_csum;
>> -	dev =3D sblock_to_check->pagev[0]->dev;
>> +	have_csum =3D sblock_to_check->sectorv[0]->have_csum;
>> +	dev =3D sblock_to_check->sectorv[0]->dev;
>>
>>   	if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logical)=
)
>>   		return 0;
>> @@ -1011,25 +1011,25 @@ static int scrub_handle_errored_block(struct sc=
rub_block *sblock_to_check)
>>   			continue;
>>
>>   		/* raid56's mirror can be more than BTRFS_MAX_MIRRORS */
>> -		if (!scrub_is_page_on_raid56(sblock_bad->pagev[0])) {
>> +		if (!scrub_is_page_on_raid56(sblock_bad->sectorv[0])) {
>>   			if (mirror_index >=3D BTRFS_MAX_MIRRORS)
>>   				break;
>> -			if (!sblocks_for_recheck[mirror_index].page_count)
>> +			if (!sblocks_for_recheck[mirror_index].sector_count)
>>   				break;
>>
>>   			sblock_other =3D sblocks_for_recheck + mirror_index;
>>   		} else {
>> -			struct scrub_recover *r =3D sblock_bad->pagev[0]->recover;
>> +			struct scrub_recover *r =3D sblock_bad->sectorv[0]->recover;
>>   			int max_allowed =3D r->bioc->num_stripes - r->bioc->num_tgtdevs;
>>
>>   			if (mirror_index >=3D max_allowed)
>>   				break;
>> -			if (!sblocks_for_recheck[1].page_count)
>> +			if (!sblocks_for_recheck[1].sector_count)
>>   				break;
>>
>>   			ASSERT(failed_mirror_index =3D=3D 0);
>>   			sblock_other =3D sblocks_for_recheck + 1;
>> -			sblock_other->pagev[0]->mirror_num =3D 1 + mirror_index;
>> +			sblock_other->sectorv[0]->mirror_num =3D 1 + mirror_index;
>>   		}
>>
>>   		/* build and submit the bios, check checksums */
>> @@ -1078,16 +1078,16 @@ static int scrub_handle_errored_block(struct sc=
rub_block *sblock_to_check)
>>   	 * area are unreadable.
>>   	 */
>>   	success =3D 1;
>> -	for (page_num =3D 0; page_num < sblock_bad->page_count;
>> -	     page_num++) {
>> -		struct scrub_page *spage_bad =3D sblock_bad->pagev[page_num];
>> +	for (sector_num =3D 0; sector_num < sblock_bad->sector_count;
>
> This is a simple indexing, so while sector_num is accurate a plain 'i'
> would work too. It would also make some lines shorter.

Here I intentionally avoid using single letter, because the existing
code is doing a pretty bad practice by doing a double for loop.

Here we're doing two different loops, one is iterating all the sectors,
the other one is iterating all the mirrors.

Thus we need to distinguish them, or it' can easily get screwed up using
different loop indexes.

>
>> +	     sector_num++) {
>> +		struct scrub_page *spage_bad =3D sblock_bad->sectorv[sector_num];
>>   		struct scrub_block *sblock_other =3D NULL;
>>
>>   		/* skip no-io-error page in scrub */
>>   		if (!spage_bad->io_error && !sctx->is_dev_replace)
>>   			continue;
>>
>> -		if (scrub_is_page_on_raid56(sblock_bad->pagev[0])) {
>> +		if (scrub_is_page_on_raid56(sblock_bad->sectorv[0])) {
>>   			/*
>>   			 * In case of dev replace, if raid56 rebuild process
>>   			 * didn't work out correct data, then copy the content
>> @@ -1100,10 +1100,10 @@ static int scrub_handle_errored_block(struct sc=
rub_block *sblock_to_check)
>>   			/* try to find no-io-error page in mirrors */
>>   			for (mirror_index =3D 0;
>>   			     mirror_index < BTRFS_MAX_MIRRORS &&
>> -			     sblocks_for_recheck[mirror_index].page_count > 0;
>> +			     sblocks_for_recheck[mirror_index].sector_count > 0;

See, the 2nd loop iterator.

Thus I guess that's why the original code is using @mirror_index and
@page_index.

>>   			     mirror_index++) {
>>   				if (!sblocks_for_recheck[mirror_index].
>> -				    pagev[page_num]->io_error) {
>> +				    sectorv[sector_num]->io_error) {
>>   					sblock_other =3D sblocks_for_recheck +
>>   						       mirror_index;
>>   					break;
>> @@ -1125,7 +1125,7 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>>   				sblock_other =3D sblock_bad;
>>
>>   			if (scrub_write_page_to_dev_replace(sblock_other,
>> -							    page_num) !=3D 0) {
>> +							    sector_num) !=3D 0) {
>>   				atomic64_inc(
>>   					&fs_info->dev_replace.num_write_errors);
>>   				success =3D 0;
>> @@ -1133,7 +1133,7 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>>   		} else if (sblock_other) {
>>   			ret =3D scrub_repair_page_from_good_copy(sblock_bad,
>>   							       sblock_other,
>> -							       page_num, 0);
>> +							       sector_num, 0);
>>   			if (0 =3D=3D ret)
>>   				spage_bad->io_error =3D 0;
>>   			else
>> @@ -1186,18 +1186,18 @@ static int scrub_handle_errored_block(struct sc=
rub_block *sblock_to_check)
>>   			struct scrub_block *sblock =3D sblocks_for_recheck +
>>   						     mirror_index;
>>   			struct scrub_recover *recover;
>> -			int page_index;
>> +			int sector_index;
>>
>> -			for (page_index =3D 0; page_index < sblock->page_count;
>> -			     page_index++) {
>> -				sblock->pagev[page_index]->sblock =3D NULL;
>> -				recover =3D sblock->pagev[page_index]->recover;
>> +			for (sector_index =3D 0; sector_index < sblock->sector_count;
>> +			     sector_index++) {
>> +				sblock->sectorv[sector_index]->sblock =3D NULL;
>> +				recover =3D sblock->sectorv[sector_index]->recover;
>>   				if (recover) {
>>   					scrub_put_recover(fs_info, recover);
>> -					sblock->pagev[page_index]->recover =3D
>> +					sblock->sectorv[sector_index]->recover =3D
>>   									NULL;
>>   				}
>> -				scrub_page_put(sblock->pagev[page_index]);
>> +				scrub_page_put(sblock->sectorv[sector_index]);
>>   			}
>>   		}
>>   		kfree(sblocks_for_recheck);
>> @@ -1255,18 +1255,18 @@ static int scrub_setup_recheck_block(struct scr=
ub_block *original_sblock,
>>   {
>>   	struct scrub_ctx *sctx =3D original_sblock->sctx;
>>   	struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>> -	u64 length =3D original_sblock->page_count * fs_info->sectorsize;
>> -	u64 logical =3D original_sblock->pagev[0]->logical;
>> -	u64 generation =3D original_sblock->pagev[0]->generation;
>> -	u64 flags =3D original_sblock->pagev[0]->flags;
>> -	u64 have_csum =3D original_sblock->pagev[0]->have_csum;
>> +	u64 length =3D original_sblock->sector_count * fs_info->sectorsize;
>
> 						>> fs_info->sectorsize_bits

Well, that's why I kept everything just a renaming, as the shift is in a
wrong direction...

>
>> +	u64 logical =3D original_sblock->sectorv[0]->logical;
>> +	u64 generation =3D original_sblock->sectorv[0]->generation;
>> +	u64 flags =3D original_sblock->sectorv[0]->flags;
>> +	u64 have_csum =3D original_sblock->sectorv[0]->have_csum;
>>   	struct scrub_recover *recover;
>>   	struct btrfs_io_context *bioc;
>>   	u64 sublen;
>>   	u64 mapped_length;
>>   	u64 stripe_offset;
>>   	int stripe_index;
>> -	int page_index =3D 0;
>> +	int sector_index =3D 0;
>>   	int mirror_index;
>>   	int nmirrors;
>>   	int ret;
>> @@ -1306,7 +1306,7 @@ static int scrub_setup_recheck_block(struct scrub=
_block *original_sblock,
>>   		recover->bioc =3D bioc;
>>   		recover->map_length =3D mapped_length;
>>
>> -		ASSERT(page_index < SCRUB_MAX_PAGES_PER_BLOCK);
>> +		ASSERT(sector_index < SCRUB_MAX_SECTORS_PER_BLOCK);
>>
>>   		nmirrors =3D min(scrub_nr_raid_mirrors(bioc), BTRFS_MAX_MIRRORS);
>>
>> @@ -1328,7 +1328,7 @@ static int scrub_setup_recheck_block(struct scrub=
_block *original_sblock,
>>   				return -ENOMEM;
>>   			}
>>   			scrub_page_get(spage);
>> -			sblock->pagev[page_index] =3D spage;
>> +			sblock->sectorv[sector_index] =3D spage;
>>   			spage->sblock =3D sblock;
>>   			spage->flags =3D flags;
>>   			spage->generation =3D generation;
>> @@ -1336,7 +1336,7 @@ static int scrub_setup_recheck_block(struct scrub=
_block *original_sblock,
>>   			spage->have_csum =3D have_csum;
>>   			if (have_csum)
>>   				memcpy(spage->csum,
>> -				       original_sblock->pagev[0]->csum,
>> +				       original_sblock->sectorv[0]->csum,
>>   				       sctx->fs_info->csum_size);
>>
>>   			scrub_stripe_index_and_offset(logical,
>> @@ -1352,13 +1352,13 @@ static int scrub_setup_recheck_block(struct scr=
ub_block *original_sblock,
>>   					 stripe_offset;
>>   			spage->dev =3D bioc->stripes[stripe_index].dev;
>>
>> -			BUG_ON(page_index >=3D original_sblock->page_count);
>> +			BUG_ON(sector_index >=3D original_sblock->sector_count);
>>   			spage->physical_for_dev_replace =3D
>> -				original_sblock->pagev[page_index]->
>> +				original_sblock->sectorv[sector_index]->
>>   				physical_for_dev_replace;
>>   			/* for missing devices, dev->bdev is NULL */
>>   			spage->mirror_num =3D mirror_index + 1;
>> -			sblock->page_count++;
>> +			sblock->sector_count++;
>>   			spage->page =3D alloc_page(GFP_NOFS);
>>   			if (!spage->page)
>>   				goto leave_nomem;
>> @@ -1369,7 +1369,7 @@ static int scrub_setup_recheck_block(struct scrub=
_block *original_sblock,
>>   		scrub_put_recover(fs_info, recover);
>>   		length -=3D sublen;
>>   		logical +=3D sublen;
>> -		page_index++;
>> +		sector_index++;
>>   	}
>>
>>   	return 0;
>> @@ -1392,7 +1392,7 @@ static int scrub_submit_raid56_bio_wait(struct bt=
rfs_fs_info *fs_info,
>>   	bio->bi_private =3D &done;
>>   	bio->bi_end_io =3D scrub_bio_wait_endio;
>>
>> -	mirror_num =3D spage->sblock->pagev[0]->mirror_num;
>> +	mirror_num =3D spage->sblock->sectorv[0]->mirror_num;
>>   	ret =3D raid56_parity_recover(bio, spage->recover->bioc,
>>   				    spage->recover->map_length,
>>   				    mirror_num, 0);
>> @@ -1406,9 +1406,9 @@ static int scrub_submit_raid56_bio_wait(struct bt=
rfs_fs_info *fs_info,
>>   static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_in=
fo,
>>   					  struct scrub_block *sblock)
>>   {
>> -	struct scrub_page *first_page =3D sblock->pagev[0];
>> +	struct scrub_page *first_page =3D sblock->sectorv[0];
>>   	struct bio *bio;
>> -	int page_num;
>> +	int sector_num;
>
> Also 'i'

This single letter usage is much safer here, the function only has one
single loop, no double loop to cause problems.

>
>>   	/* All pages in sblock belong to the same stripe on the same device.=
 */
>>   	ASSERT(first_page->dev);
>> @@ -1418,8 +1418,8 @@ static void scrub_recheck_block_on_raid56(struct =
btrfs_fs_info *fs_info,
>>   	bio =3D btrfs_bio_alloc(BIO_MAX_VECS);
>>   	bio_set_dev(bio, first_page->dev->bdev);
>>
>> -	for (page_num =3D 0; page_num < sblock->page_count; page_num++) {
>> -		struct scrub_page *spage =3D sblock->pagev[page_num];
>> +	for (sector_num =3D 0; sector_num < sblock->sector_count; sector_num+=
+) {
>> +		struct scrub_page *spage =3D sblock->sectorv[sector_num];
>>
>>   		WARN_ON(!spage->page);
>>   		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
>> @@ -1436,8 +1436,8 @@ static void scrub_recheck_block_on_raid56(struct =
btrfs_fs_info *fs_info,
>>
>>   	return;
>>   out:
>> -	for (page_num =3D 0; page_num < sblock->page_count; page_num++)
>> -		sblock->pagev[page_num]->io_error =3D 1;
>> +	for (sector_num =3D 0; sector_num < sblock->sector_count; sector_num+=
+)
>> +		sblock->sectorv[sector_num]->io_error =3D 1;
>>
>>   	sblock->no_io_error_seen =3D 0;
>>   }
>> @@ -1453,17 +1453,17 @@ static void scrub_recheck_block(struct btrfs_fs=
_info *fs_info,
>>   				struct scrub_block *sblock,
>>   				int retry_failed_mirror)
>>   {
>> -	int page_num;
>> +	int sector_num;
>
> And here too

The remaining usage of single letter is all good.

I'll update the patch regarding to those single letter and comment updates=
.

Thanks,
Qu

>
>>   	sblock->no_io_error_seen =3D 1;
>>
>>   	/* short cut for raid56 */
>> -	if (!retry_failed_mirror && scrub_is_page_on_raid56(sblock->pagev[0])=
)
>> +	if (!retry_failed_mirror && scrub_is_page_on_raid56(sblock->sectorv[0=
]))
>>   		return scrub_recheck_block_on_raid56(fs_info, sblock);
>>
>> -	for (page_num =3D 0; page_num < sblock->page_count; page_num++) {
>> +	for (sector_num =3D 0; sector_num < sblock->sector_count; sector_num+=
+) {
>>   		struct bio *bio;
>> -		struct scrub_page *spage =3D sblock->pagev[page_num];
>> +		struct scrub_page *spage =3D sblock->sectorv[sector_num];
>>
>>   		if (spage->dev->bdev =3D=3D NULL) {
>>   			spage->io_error =3D 1;
>> @@ -1507,7 +1507,7 @@ static void scrub_recheck_block_checksum(struct s=
crub_block *sblock)
>>   	sblock->checksum_error =3D 0;
>>   	sblock->generation_error =3D 0;
>>
>> -	if (sblock->pagev[0]->flags & BTRFS_EXTENT_FLAG_DATA)
>> +	if (sblock->sectorv[0]->flags & BTRFS_EXTENT_FLAG_DATA)
>>   		scrub_checksum_data(sblock);
>>   	else
>>   		scrub_checksum_tree_block(sblock);
>> @@ -1516,15 +1516,15 @@ static void scrub_recheck_block_checksum(struct=
 scrub_block *sblock)
>>   static int scrub_repair_block_from_good_copy(struct scrub_block *sblo=
ck_bad,
>>   					     struct scrub_block *sblock_good)
>>   {
>> -	int page_num;
>> +	int sector_num;
>
> i
>
>>   	int ret =3D 0;
>>
>> -	for (page_num =3D 0; page_num < sblock_bad->page_count; page_num++) {
>> +	for (sector_num =3D 0; sector_num < sblock_bad->sector_count; sector_=
num++) {
>>   		int ret_sub;
>>
>>   		ret_sub =3D scrub_repair_page_from_good_copy(sblock_bad,
>>   							   sblock_good,
>> -							   page_num, 1);
>> +							   sector_num, 1);
>>   		if (ret_sub)
>>   			ret =3D ret_sub;
>>   	}
>> @@ -1534,10 +1534,10 @@ static int scrub_repair_block_from_good_copy(st=
ruct scrub_block *sblock_bad,
>>
>>   static int scrub_repair_page_from_good_copy(struct scrub_block *sbloc=
k_bad,
>>   					    struct scrub_block *sblock_good,
>> -					    int page_num, int force_write)
>> +					    int sector_num, int force_write)
>>   {
>> -	struct scrub_page *spage_bad =3D sblock_bad->pagev[page_num];
>> -	struct scrub_page *spage_good =3D sblock_good->pagev[page_num];
>> +	struct scrub_page *spage_bad =3D sblock_bad->sectorv[sector_num];
>> +	struct scrub_page *spage_good =3D sblock_good->sectorv[sector_num];
>>   	struct btrfs_fs_info *fs_info =3D sblock_bad->sctx->fs_info;
>>   	const u32 sectorsize =3D fs_info->sectorsize;
>>
>> @@ -1581,7 +1581,7 @@ static int scrub_repair_page_from_good_copy(struc=
t scrub_block *sblock_bad,
>>   static void scrub_write_block_to_dev_replace(struct scrub_block *sblo=
ck)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D sblock->sctx->fs_info;
>> -	int page_num;
>> +	int sector_num;
>
> i >
>>   	/*
>>   	 * This block is used for the check of the parity on the source devi=
ce,
>> @@ -1590,19 +1590,19 @@ static void scrub_write_block_to_dev_replace(st=
ruct scrub_block *sblock)
>>   	if (sblock->sparity)
>>   		return;
>>
>> -	for (page_num =3D 0; page_num < sblock->page_count; page_num++) {
>> +	for (sector_num =3D 0; sector_num < sblock->sector_count; sector_num+=
+) {
>>   		int ret;
>>
>> -		ret =3D scrub_write_page_to_dev_replace(sblock, page_num);
>> +		ret =3D scrub_write_page_to_dev_replace(sblock, sector_num);
>>   		if (ret)
>>   			atomic64_inc(&fs_info->dev_replace.num_write_errors);
>>   	}
>>   }
>>
>>   static int scrub_write_page_to_dev_replace(struct scrub_block *sblock=
,
>> -					   int page_num)
>> +					   int sector_num)
>>   {
>> -	struct scrub_page *spage =3D sblock->pagev[page_num];
>> +	struct scrub_page *spage =3D sblock->sectorv[sector_num];
>>
>>   	BUG_ON(spage->page =3D=3D NULL);
>>   	if (spage->io_error)
>> @@ -1786,8 +1786,8 @@ static int scrub_checksum(struct scrub_block *sbl=
ock)
>>   	sblock->generation_error =3D 0;
>>   	sblock->checksum_error =3D 0;
>>
>> -	WARN_ON(sblock->page_count < 1);
>> -	flags =3D sblock->pagev[0]->flags;
>> +	WARN_ON(sblock->sector_count < 1);
>> +	flags =3D sblock->sectorv[0]->flags;
>>   	ret =3D 0;
>>   	if (flags & BTRFS_EXTENT_FLAG_DATA)
>>   		ret =3D scrub_checksum_data(sblock);
>> @@ -1812,8 +1812,8 @@ static int scrub_checksum_data(struct scrub_block=
 *sblock)
>>   	struct scrub_page *spage;
>>   	char *kaddr;
>>
>> -	BUG_ON(sblock->page_count < 1);
>> -	spage =3D sblock->pagev[0];
>> +	BUG_ON(sblock->sector_count < 1);
>> +	spage =3D sblock->sectorv[0];
>>   	if (!spage->have_csum)
>>   		return 0;
>>
>> @@ -1852,12 +1852,12 @@ static int scrub_checksum_tree_block(struct scr=
ub_block *sblock)
>>   	struct scrub_page *spage;
>>   	char *kaddr;
>>
>> -	BUG_ON(sblock->page_count < 1);
>> +	BUG_ON(sblock->sector_count < 1);
>>
>> -	/* Each member in pagev is just one block, not a full page */
>> -	ASSERT(sblock->page_count =3D=3D num_sectors);
>> +	/* Each member in pagev is just one sector , not a full page */
>> +	ASSERT(sblock->sector_count =3D=3D num_sectors);
>>
>> -	spage =3D sblock->pagev[0];
>> +	spage =3D sblock->sectorv[0];
>>   	kaddr =3D page_address(spage->page);
>>   	h =3D (struct btrfs_header *)kaddr;
>>   	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
>> @@ -1888,7 +1888,7 @@ static int scrub_checksum_tree_block(struct scrub=
_block *sblock)
>>   			    sectorsize - BTRFS_CSUM_SIZE);
>>
>>   	for (i =3D 1; i < num_sectors; i++) {
>> -		kaddr =3D page_address(sblock->pagev[i]->page);
>> +		kaddr =3D page_address(sblock->sectorv[i]->page);
>>   		crypto_shash_update(shash, kaddr, sectorsize);
>>   	}
>>
>> @@ -1911,8 +1911,8 @@ static int scrub_checksum_super(struct scrub_bloc=
k *sblock)
>>   	int fail_gen =3D 0;
>>   	int fail_cor =3D 0;
>>
>> -	BUG_ON(sblock->page_count < 1);
>> -	spage =3D sblock->pagev[0];
>> +	BUG_ON(sblock->sector_count < 1);
>> +	spage =3D sblock->sectorv[0];
>>   	kaddr =3D page_address(spage->page);
>>   	s =3D (struct btrfs_super_block *)kaddr;
>>
>> @@ -1966,8 +1966,8 @@ static void scrub_block_put(struct scrub_block *s=
block)
>>   		if (sblock->sparity)
>>   			scrub_parity_put(sblock->sparity);
>>
>> -		for (i =3D 0; i < sblock->page_count; i++)
>> -			scrub_page_put(sblock->pagev[i]);
>> +		for (i =3D 0; i < sblock->sector_count; i++)
>> +			scrub_page_put(sblock->sectorv[i]);
>>   		kfree(sblock);
>>   	}
>>   }
>> @@ -2155,8 +2155,8 @@ static void scrub_missing_raid56_worker(struct bt=
rfs_work *work)
>>   	u64 logical;
>>   	struct btrfs_device *dev;
>>
>> -	logical =3D sblock->pagev[0]->logical;
>> -	dev =3D sblock->pagev[0]->dev;
>> +	logical =3D sblock->sectorv[0]->logical;
>> +	dev =3D sblock->sectorv[0]->dev;
>>
>>   	if (sblock->no_io_error_seen)
>>   		scrub_recheck_block_checksum(sblock);
>> @@ -2193,8 +2193,8 @@ static void scrub_missing_raid56_pages(struct scr=
ub_block *sblock)
>>   {
>>   	struct scrub_ctx *sctx =3D sblock->sctx;
>>   	struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>> -	u64 length =3D sblock->page_count * PAGE_SIZE;
>> -	u64 logical =3D sblock->pagev[0]->logical;
>> +	u64 length =3D sblock->sector_count * fs_info->sectorsize;
>> +	u64 logical =3D sblock->sectorv[0]->logical;
>>   	struct btrfs_io_context *bioc =3D NULL;
>>   	struct bio *bio;
>>   	struct btrfs_raid_bio *rbio;
>> @@ -2227,8 +2227,8 @@ static void scrub_missing_raid56_pages(struct scr=
ub_block *sblock)
>>   	if (!rbio)
>>   		goto rbio_out;
>>
>> -	for (i =3D 0; i < sblock->page_count; i++) {
>> -		struct scrub_page *spage =3D sblock->pagev[i];
>> +	for (i =3D 0; i < sblock->sector_count; i++) {
>> +		struct scrub_page *spage =3D sblock->sectorv[i];
>>
>>   		raid56_add_scrub_pages(rbio, spage->page, spage->logical);
>>   	}
>> @@ -2290,9 +2290,9 @@ static int scrub_pages(struct scrub_ctx *sctx, u6=
4 logical, u32 len,
>>   			scrub_block_put(sblock);
>>   			return -ENOMEM;
>>   		}
>> -		ASSERT(index < SCRUB_MAX_PAGES_PER_BLOCK);
>> +		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
>>   		scrub_page_get(spage);
>> -		sblock->pagev[index] =3D spage;
>> +		sblock->sectorv[index] =3D spage;
>>   		spage->sblock =3D sblock;
>>   		spage->dev =3D dev;
>>   		spage->flags =3D flags;
>> @@ -2307,7 +2307,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u6=
4 logical, u32 len,
>>   		} else {
>>   			spage->have_csum =3D 0;
>>   		}
>> -		sblock->page_count++;
>> +		sblock->sector_count++;
>>   		spage->page =3D alloc_page(GFP_KERNEL);
>>   		if (!spage->page)
>>   			goto leave_nomem;
>> @@ -2317,7 +2317,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u6=
4 logical, u32 len,
>>   		physical_for_dev_replace +=3D l;
>>   	}
>>
>> -	WARN_ON(sblock->page_count =3D=3D 0);
>> +	WARN_ON(sblock->sector_count =3D=3D 0);
>>   	if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
>>   		/*
>>   		 * This case should only be hit for RAID 5/6 device replace. See
>> @@ -2325,8 +2325,8 @@ static int scrub_pages(struct scrub_ctx *sctx, u6=
4 logical, u32 len,
>>   		 */
>>   		scrub_missing_raid56_pages(sblock);
>>   	} else {
>> -		for (index =3D 0; index < sblock->page_count; index++) {
>> -			struct scrub_page *spage =3D sblock->pagev[index];
>> +		for (index =3D 0; index < sblock->sector_count; index++) {
>> +			struct scrub_page *spage =3D sblock->sectorv[index];
>>   			int ret;
>>
>>   			ret =3D scrub_add_page_to_rd_bio(sctx, spage);
>> @@ -2456,8 +2456,8 @@ static void scrub_block_complete(struct scrub_blo=
ck *sblock)
>>   	}
>>
>>   	if (sblock->sparity && corrupted && !sblock->data_corrected) {
>> -		u64 start =3D sblock->pagev[0]->logical;
>> -		u64 end =3D sblock->pagev[sblock->page_count - 1]->logical +
>> +		u64 start =3D sblock->sectorv[0]->logical;
>> +		u64 end =3D sblock->sectorv[sblock->sector_count - 1]->logical +
>>   			  sblock->sctx->fs_info->sectorsize;
>>
>>   		ASSERT(end - start <=3D U32_MAX);
>> @@ -2624,10 +2624,10 @@ static int scrub_pages_for_parity(struct scrub_=
parity *sparity,
>>   			scrub_block_put(sblock);
>>   			return -ENOMEM;
>>   		}
>> -		ASSERT(index < SCRUB_MAX_PAGES_PER_BLOCK);
>> +		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
>>   		/* For scrub block */
>>   		scrub_page_get(spage);
>> -		sblock->pagev[index] =3D spage;
>> +		sblock->sectorv[index] =3D spage;
>>   		/* For scrub parity */
>>   		scrub_page_get(spage);
>>   		list_add_tail(&spage->list, &sparity->spages);
>> @@ -2644,7 +2644,7 @@ static int scrub_pages_for_parity(struct scrub_pa=
rity *sparity,
>>   		} else {
>>   			spage->have_csum =3D 0;
>>   		}
>> -		sblock->page_count++;
>> +		sblock->sector_count++;
>>   		spage->page =3D alloc_page(GFP_KERNEL);
>>   		if (!spage->page)
>>   			goto leave_nomem;
>> @@ -2656,9 +2656,9 @@ static int scrub_pages_for_parity(struct scrub_pa=
rity *sparity,
>>   		physical +=3D sectorsize;
>>   	}
>>
>> -	WARN_ON(sblock->page_count =3D=3D 0);
>> -	for (index =3D 0; index < sblock->page_count; index++) {
>> -		struct scrub_page *spage =3D sblock->pagev[index];
>> +	WARN_ON(sblock->sector_count =3D=3D 0);
>> +	for (index =3D 0; index < sblock->sector_count; index++) {
>> +		struct scrub_page *spage =3D sblock->sectorv[index];
>>   		int ret;
>>
>>   		ret =3D scrub_add_page_to_rd_bio(sctx, spage);
>> @@ -4058,18 +4058,18 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_in=
fo, u64 devid, u64 start,
>>   	}
>>
>>   	if (fs_info->nodesize >
>> -	    PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK ||
>> -	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK) {
>> +	    SCRUB_MAX_SECTORS_PER_BLOCK * fs_info->sectorsize ||
>> +	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_SECTORS_PER_BLOCK) {
>>   		/*
>>   		 * would exhaust the array bounds of pagev member in
>>   		 * struct scrub_block
>>   		 */
>>   		btrfs_err(fs_info,
>> -			  "scrub: size assumption nodesize and sectorsize <=3D SCRUB_MAX_PA=
GES_PER_BLOCK (%d <=3D %d && %d <=3D %d) fails",
>> +			  "scrub: size assumption nodesize and sectorsize <=3D SCRUB_MAX_SE=
CTORS_PER_BLOCK (%d <=3D %d && %d <=3D %d) fails",
>>   		       fs_info->nodesize,
>> -		       SCRUB_MAX_PAGES_PER_BLOCK,
>> +		       SCRUB_MAX_SECTORS_PER_BLOCK,
>>   		       fs_info->sectorsize,
>> -		       SCRUB_MAX_PAGES_PER_BLOCK);
>> +		       SCRUB_MAX_SECTORS_PER_BLOCK);
>>   		return -EINVAL;
>>   	}
>>
>> --
>> 2.35.1
