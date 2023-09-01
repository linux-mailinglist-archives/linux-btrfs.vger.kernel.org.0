Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28C78FB07
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjIAJkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjIAJkw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 05:40:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7442C0;
        Fri,  1 Sep 2023 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693561227; x=1694166027; i=quwenruo.btrfs@gmx.com;
 bh=mbk5ttY8Ji7hT+eBG4b829KGSre73vImgrcAzyDyh9k=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=kVsLZNzMbwyqnTajqQWU0476uqnSCJQn5htwfUSc3puDreII7DY/3t2RSqsEcYu8gs1DJmZ
 co1fo6z621aqfvnN6nuFWK8aIpgr6ksVzJMQR/nEZSCsrYBPu5C58+wYtvAlY3HfRdx1hI/JO
 PJQFKZeW4ojRIOHl9sQfkce30WQsLFWU5k2ZH9xWdA17HLptCHP2kz+3pR2zUKxAyehLulv86
 93Lhw1SN8SHJm9+YZn+uY6SMnRfb6AkyHBBj2Z2BsIKryWzNnqvgS+/fBaz6qcd34/RZmUsCy
 nzIpz/GWU6q/rfwKCVLTeurSn2BrrTveYrnnWat/3vbaNt/QoesA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsQ4-1qTAx02ux6-008ol4; Fri, 01
 Sep 2023 11:40:27 +0200
Message-ID: <fc88a524-7b24-4f2c-91dd-a9e1d7ddd3c0@gmx.com>
Date:   Fri, 1 Sep 2023 17:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove btree_dirty_folio() inside DEBUG
Content-Language: en-US
To:     Yunhui Cui <cuiyunhui@bytedance.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230901031817.93630-1-cuiyunhui@bytedance.com>
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
In-Reply-To: <20230901031817.93630-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TUPJrqw1akN+CdARoYvOFWPkjrK4Kj1GZoZqgXEnWkbWpCbD2KV
 ucc5R52UXYMWjgLOxDZE6MkHTbttfo/iVvveQ0exiUgP6SCsOJZjeQKahL4HdrOSciEDhn1
 Y1LBeoP1DXXb4ljHbNrEHPPvXAWpxsRMuD+C4z8vRVlxpR1hsOa4NwZDT4gRo05+dEr5a+o
 Vcn4LzFiJrN7a1+IHtR2g==
UI-OutboundReport: notjunk:1;M01:P0:QzmZyeM2Ki8=;gxyxNQQM5Evr7P0hO+edlCxTV0Q
 qTluOcHcZfPYJW6vF8CWIQsE6IebgMpqXRYH4DlMSM9xUsw49JA2F39UIbmhIJymzTn1dQnKB
 HLB/akUJso1zAQwe1x+W6k8gN0k6eLTGXE0ZnR+r2K2AmMWcM0et1OgDX6EJgJb+a/dnlkO+D
 ibBmVskDlRQeuneBDGSw6aZ5ue/euGEa64JTyjWPMh0JJB8LAsXAxCAhNuvpqJQUr05DURrZu
 yKqTEsgPthlUuueIPTyKQNy/lzkL2VELsPLEwcvzIKywCqYi4sBWlV4IxHCyDKwymhyTuMaWc
 mK6LPsbGpKf+sLn/APhFLuJtat8ceIEkjamHlrQsWaG3LX6ldxEyutwmZAkFZLHhSpEzJhB89
 hDzm5UZPJGpCa1p9p9NMViKmSINy8VLUfGldvgQaWEqoNd1HlylgmlDOLrotA1lK1d16x9WFM
 4192G2rOfxmeyyOTW+yWZFU8eB5R3DaJxhXzbzcPopOtRUO0Z1LOn+lMZ6pcq3VeNNIanSBEK
 uVA7FVsoiUCzRVFs0I3AvOFbn9leYuFgOc+48gAFpydgBYhkKuuzfnqxDbv45njG1Md8BvpWf
 f+qWYae/wlMDUxeLUqnIZvZNEqCdJI8sU8lF2IVyNSt7eYw5bwoOcTTx7YGoztd7JXKuheLOH
 ZDo2xWUX8F8L5es//t3/DA5GRJIYn6zVmJEYXL5QjmsHGbdnwa8mQVX7fIF/zhGgnjEh8DrdR
 FeD41ARM0hhs8zFrP1hI5+8QN46BjM2EGK9fu0CSLvDjQ0Id1cKiQUf3QWfdro8r0ys+2Nt0V
 beHa6QAetYXWAxMMLfr1ax9yXs/DqAaXEaFNUXiSF/Z+m1Zb6Srnjkmz9xXWYdluihUZsdlRk
 94kF4Qe5XeBhsf6tTeJ2A/qpPgEumsERqLlXBlACK5T8l8DubYGEVkBm0fdern6B6T31wy/bX
 xc03S9HVR6tvwFmpFvIpqG7FyJ4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/1 11:18, Yunhui Cui wrote:
> When the DEBUG compilation option is enabled (KCFLAGS=3D-DDEBUG),
> the following compilation error will occur:
> fs/btrfs/disk-io.c: In function =E2=80=98btree_dirty_folio=E2=80=99:
> fs/btrfs/disk-io.c:538:16: error: =E2=80=98struct btrfs_subpage=E2=80=99=
 has no member named =E2=80=98dirty_bitmap=E2=80=99
>    ASSERT(subpage->dirty_bitmap);
>                  ^~
> fs/btrfs/messages.h:181:29: note: in definition of macro =E2=80=98ASSERT=
=E2=80=99
>   #define ASSERT(expr) (void)(expr)
>                               ^~~~
> fs/btrfs/disk-io.c:539:19: error: =E2=80=98BTRFS_SUBPAGE_BITMAP_SIZE=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98BTRF=
S_FREE_SPACE_BITMAP_SIZE=E2=80=99?
>    while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~
>                     BTRFS_FREE_SPACE_BITMAP_SIZE
> fs/btrfs/disk-io.c:539:19: note: each undeclared identifier is reported =
only once for each function it appears in
> fs/btrfs/disk-io.c:545:22: error: =E2=80=98struct btrfs_subpage=E2=80=99=
 has no member named =E2=80=98dirty_bitmap=E2=80=99
>     if (!(tmp & subpage->dirty_bitmap)) {
>                        ^~
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

There is already a proper fix for it other than deleting it completely:

https://lore.kernel.org/linux-btrfs/14ea9aa0a4d5ac8f2c817978e9fff6ded8777e=
f9.1692683147.git.wqu@suse.com

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 52 +---------------------------------------------
>   1 file changed, 1 insertion(+), 51 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0a96ea8c1d3a..f0252c70233a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -515,62 +515,12 @@ static void btree_invalidate_folio(struct folio *f=
olio, size_t offset,
>   	}
>   }
>
> -#ifdef DEBUG
> -static bool btree_dirty_folio(struct address_space *mapping,
> -		struct folio *folio)
> -{
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(mapping->host->i_sb);
> -	struct btrfs_subpage *subpage;
> -	struct extent_buffer *eb;
> -	int cur_bit =3D 0;
> -	u64 page_start =3D folio_pos(folio);
> -
> -	if (fs_info->sectorsize =3D=3D PAGE_SIZE) {
> -		eb =3D folio_get_private(folio);
> -		BUG_ON(!eb);
> -		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> -		BUG_ON(!atomic_read(&eb->refs));
> -		btrfs_assert_tree_write_locked(eb);
> -		return filemap_dirty_folio(mapping, folio);
> -	}
> -	subpage =3D folio_get_private(folio);
> -
> -	ASSERT(subpage->dirty_bitmap);
> -	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
> -		unsigned long flags;
> -		u64 cur;
> -		u16 tmp =3D (1 << cur_bit);
> -
> -		spin_lock_irqsave(&subpage->lock, flags);
> -		if (!(tmp & subpage->dirty_bitmap)) {
> -			spin_unlock_irqrestore(&subpage->lock, flags);
> -			cur_bit++;
> -			continue;
> -		}
> -		spin_unlock_irqrestore(&subpage->lock, flags);
> -		cur =3D page_start + cur_bit * fs_info->sectorsize;
> -
> -		eb =3D find_extent_buffer(fs_info, cur);
> -		ASSERT(eb);
> -		ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> -		ASSERT(atomic_read(&eb->refs));
> -		btrfs_assert_tree_write_locked(eb);
> -		free_extent_buffer(eb);
> -
> -		cur_bit +=3D (fs_info->nodesize >> fs_info->sectorsize_bits);
> -	}
> -	return filemap_dirty_folio(mapping, folio);
> -}
> -#else
> -#define btree_dirty_folio filemap_dirty_folio
> -#endif
> -
>   static const struct address_space_operations btree_aops =3D {
>   	.writepages	=3D btree_writepages,
>   	.release_folio	=3D btree_release_folio,
>   	.invalidate_folio =3D btree_invalidate_folio,
>   	.migrate_folio	=3D btree_migrate_folio,
> -	.dirty_folio	=3D btree_dirty_folio,
> +	.dirty_folio	=3D filemap_dirty_folio,
>   };
>
>   struct extent_buffer *btrfs_find_create_tree_block(
