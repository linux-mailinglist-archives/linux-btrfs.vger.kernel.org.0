Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8014799CB0
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Sep 2023 06:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjIJEvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Sep 2023 00:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbjIJEvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Sep 2023 00:51:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B41A5
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694321484; x=1694926284; i=quwenruo.btrfs@gmx.com;
 bh=cRchGqWJk/rdmHP3XENQHL9jf2mwjRF44DpaaOZ9WSk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ovFfFxPmr/CIShfET4xYrBxHvu5tEe09sUkvXhOzswW+QkAAM97cJrIco3eVOQ3i+gJ9MwZ
 6uTSWYQw61Sl7UJfa5lm46FVFPfy3G64cwIbpOTDo5h3kb33dJissseazjhZjeEf55BEpflAu
 025Vh2zGyeYEY/q+wSFqV10N4Z8tVnBWJ4x17XHFHZ8QFU+hj0xP81aXoAxGJGgAAzFqvGiqQ
 /QU1eh5UyafLkgHLV3jcJIcrEgxYwE3sFhedzHbRvGH5M9GUaOzx4zAgVsScsnPzt4V6IJYlw
 zbO1B++Gla+c4Ft0Px2qzXcySl95uDzpXCw8absjUtqG1qVBleXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.7.112.80] ([154.6.151.166]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbirE-1q3Np72vVu-00dJgJ; Sun, 10
 Sep 2023 06:51:24 +0200
Message-ID: <b04947da-81ad-4fd8-97c8-0737c3ba1705@gmx.com>
Date:   Sun, 10 Sep 2023 14:21:19 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't clear uptodate on write errors
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <b709ff69f5d190ec620b7e4a21530be08442bf4b.1694201483.git.josef@toxicpanda.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <b709ff69f5d190ec620b7e4a21530be08442bf4b.1694201483.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d4eLOWyBXaDDGbi6N+FfJb5PqToUktmp1PyVAGNFVxpf44FzzX/
 MuROA3eEYuUgIbOiYuf54dl4RtZBNARc4zHQF5ccFKqg/eP4dVxcTgIu9yONpg9pjvFhiGO
 WQi0kFZD+aVRoCBcmvzMPkifwukS7/jGp+feHmhVHOyC6R4XWtae3WFpV97ULgEeC69SoMs
 +/rHJS+5aV6ILbxI6UOXA==
UI-OutboundReport: notjunk:1;M01:P0:prC+4/cVD0Y=;z8NINUepHFwSx96Xi9EsXdKmtIg
 9CHRBW0iQmaMGZLVXtsPS3PG5vgbUK3XU/Il9TuqZab/RikWbvdAHLZ9xZg9J6UQ7LJhC25J4
 zIQgUAdzEWeZk8gBH6HNpvNy2MhXzsw1JFJ5Ea+N1mbGkY8oTm7ImwPXX8PVWJHCHzY0ME0SK
 9Z1IZn3ut2j02IhUMX17koGDJAlFdYBq+vN6832QRw+C6Lya72JXmRp7FBtBv2g/n4Op3PEgY
 pQJLssiB9QExgIjbXCNp4B88xdG9nQCd2qpoyqNQ2l20cnvbX8Aaxl8c63SpOc0OF6BMs8p7E
 J2zdQuofPcyWP7QJsvxDDvvQLnYIEXyThqs0dxA7jlGOcZgzKBNNcitSKsbnWfPZKBdJNFjuk
 f37VtxVhh0WAH5L5VdA9EIxIudhH6eZZTeat+z2RP54VtVZW1XieVKuXQk4iMLnqjBNIYqrhi
 mvaN2yS5RZ4QAXY+jOhPfVHdk/bfhQq2rJvbGWXWKD9pO/AIldgbwsS5ok1YKF1Zlr/f6dDTe
 rFIoxdMkkZCbZjQvdqtz7en3ccGpXtkk9igGwy9DOcrhccFJRutVfsieWjSVfjy8cH+WJYIzZ
 9iwXdY5VzNTb+Q4Y+eztYnzdKQH+YBo4FITM+uvpFvvS/ek70WxJTSZVJiJNbTrEcc5WcvezQ
 IQhFFiuYpmgwHEGIPCtCEmWVf484Q0RMiiAKSRJyhtC/W1lDfk5BCi4XGWtGfA21RZBDW82KN
 cl7otVgYUdrtTm4ABl6OvxH4fBjh6yAQtQYGepzWzswfD3THguQkicb5sNo9zRkinvcch7Z0F
 jtpL7xcwKi3Pi/J74BB6Q6yw6BxMWLN0qFjA9RGXvryHrg+zLH8vZTk72hykpObLaFzV0Pj4M
 BtLtqnL9BE6BPtLuFBW/eYa7axBuQ5LDG+js3O1wsjujgNuNWVqatCVZj/dlL5YUJQzvApS/E
 RBLSQ4Wi206M5hunFDB2gkKcR5o=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/9 05:01, Josef Bacik wrote:
> We have been consistently seeing hangs with generic/648 in our subpage
> GitHub CI setup.  This is a classic deadlock, we are calling
> btrfs_read_folio() on a folio, which requires holding the folio lock on
> the folio, and then finding a ordered extent that overlaps that range
> and calling btrfs_start_ordered_extent(), which then tries to write out
> the dirty page, which requires taking the folio lock and then we
> deadlock.

Thanks for pinging this down, this is indeed a bug for subpage case only.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> The hang happens because we're writing to range [1271750656, 1271767040)=
, page
> index [77621, 77622], and page 77621 is !Uptodate.  It is also Dirty, so=
 we call
> btrfs_read_folio() for 77621 and which does btrfs_lock_and_flush_ordered=
_range()
> for that range, and we find an ordered extent which is [1271644160, 1271=
746560),
> page index [77615, 77621].  The page indexes overlap, but the actual byt=
es don't
> overlap.  We're holding the page lock for 77621, then call
> btrfs_lock_and_flush_ordered_range() which tries to flush the dirty page=
, and
> tries to lock 77621 again and then we deadlock.
>
> The byte ranges do not overlap, but with subpage support if we clear
> uptodate on any portion of the page we mark the entire thing as not
> uptodate.
>
> We have been clearing page uptodate on write errors, but no other file
> system does this, and is in fact incorrect.  This doesn't hurt us in the
> !subpage case because we can't end up with overlapped ranges that don't
> also overlap on the page.
>
> Fix this by not clearing uptodate when we have a write error.  The only
> thing we should be doing in this case is setting the mapping error and
> carrying on.  This makes it so we would no longer call
> btrfs_read_folio() on the page as it's uptodate and eliminates the
> deadlock.
>
> With this patch we're now able to make it through a full xfstests run on
> our subpage blocksize vms.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/extent_io.c | 9 +--------
>   fs/btrfs/inode.c     | 4 ----
>   2 files changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ac3fca5a5e41..6954ae763b86 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -484,10 +484,8 @@ static void end_bio_extent_writepage(struct btrfs_b=
io *bbio)
>   				   bvec->bv_offset, bvec->bv_len);
>
>   		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error)=
;
> -		if (error) {
> -			btrfs_page_clear_uptodate(fs_info, page, start, len);
> +		if (error)
>   			mapping_set_error(page->mapping, error);
> -		}
>   		btrfs_page_clear_writeback(fs_info, page, start, len);
>   	}
>
> @@ -1456,8 +1454,6 @@ static int __extent_writepage(struct page *page, s=
truct btrfs_bio_ctrl *bio_ctrl
>   	if (ret) {
>   		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
>   					       PAGE_SIZE, !ret);
> -		btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
> -					  page_start, PAGE_SIZE);
>   		mapping_set_error(page->mapping, ret);
>   	}
>   	unlock_page(page);
> @@ -1624,8 +1620,6 @@ static void extent_buffer_write_end_io(struct btrf=
s_bio *bbio)
>   		struct page *page =3D bvec->bv_page;
>   		u32 len =3D bvec->bv_len;
>
> -		if (!uptodate)
> -			btrfs_page_clear_uptodate(fs_info, page, start, len);
>   		btrfs_page_clear_writeback(fs_info, page, start, len);
>   		bio_offset +=3D len;
>   	}
> @@ -2201,7 +2195,6 @@ void extent_write_locked_range(struct inode *inode=
, struct page *locked_page,
>   		if (ret) {
>   			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
>   						       cur, cur_len, !ret);
> -			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
>   			mapping_set_error(page->mapping, ret);
>   		}
>   		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f09fbdc43f0f..478999dcb2a3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1085,9 +1085,6 @@ static void submit_uncompressed_range(struct btrfs=
_inode *inode,
>   			btrfs_mark_ordered_io_finished(inode, locked_page,
>   						       page_start, PAGE_SIZE,
>   						       !ret);
> -			btrfs_page_clear_uptodate(inode->root->fs_info,
> -						  locked_page, page_start,
> -						  PAGE_SIZE);
>   			mapping_set_error(locked_page->mapping, ret);
>   			unlock_page(locked_page);
>   		}
> @@ -2791,7 +2788,6 @@ static void btrfs_writepage_fixup_worker(struct bt=
rfs_work *work)
>   		mapping_set_error(page->mapping, ret);
>   		btrfs_mark_ordered_io_finished(inode, page, page_start,
>   					       PAGE_SIZE, !ret);
> -		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
>   		clear_page_dirty_for_io(page);
>   	}
>   	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
