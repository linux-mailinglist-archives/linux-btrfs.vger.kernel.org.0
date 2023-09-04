Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9E791705
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbjIDMWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbjIDMWO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 08:22:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BDE1B8
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693830124; x=1694434924; i=quwenruo.btrfs@gmx.com;
 bh=QYUwjlingC+czvb+OqWgK2edMhv+vTDACcJs1VJ7SFU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=lJel/zwcIkXGby4jNSlRQ3ykbQj2KS5DU4pxVTS47N/8jBeSmyAEq8rCsvcW4VP2ZIKIZuT
 cD6RCJbAHyGCUJPwPXLc7tX/UiIFPVsIqo27M/WJ8BsxZQeAWpe289av4NZPvYam7ia9ALIya
 6f0zDiSuuY9sok4qOmwvT8soDL2GzkhttnwFB67TEAWNr1AiJ8kbYNCcAaT/8nIklg6fuIQ8U
 4B3YbUnwbyA4QGnA57Lk7MKjewkYNvVVlLXv8pr1BWIqgG10WCckm9ZhdixK/pX9a2VM/knHf
 wo/muk6gILYidPNPcjqVPtFpeVyt93lVrHBFq9wdCNsS9pxQHLBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdif-1qOcOM15Xh-00Ea11; Mon, 04
 Sep 2023 14:22:03 +0200
Message-ID: <2141e167-99ba-4a12-b053-af2cd7124a7a@gmx.com>
Date:   Mon, 4 Sep 2023 20:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix race between finishing block group creation
 and its item update
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
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
In-Reply-To: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yj4F+/pJdK7+wukzr/pfKlr3RKOGIWt0EdqYBAx5A5Pw9aT0Dz6
 7RNtkoQW7PLwCLjzHnlYSbDTUX+X+vQs0wY0YuBIb3t9TiG/LCYyzUOFV13K1L7CnH27ifJ
 6iDpHJxuLKu2MHU+2Vei+rwz0uL5F49HkFaRyw/p/0zfsBS0JN3Bmz7vozoOD5CD5syPWhB
 flt5Kc9hHqFqMqigJ6EAQ==
UI-OutboundReport: notjunk:1;M01:P0:KzAX8ZujwrQ=;NyuyHwYLFC7nd7it2HZs2s6VyvI
 YgYyovTc4k1A8DdzZIPf1f2+yTlrnIv+ZJ08xlZQ1B+ORi7MYqr7fwI4t4zSTeQ8Au7QgV9B/
 e8UPBqUy9x8gm34p3/a9z4vm7AYnuKgwujeT9eCrR0dqqd7hhOu6HWl6IewTNU1DncAxkR/0J
 Za7s2fxCJ/XfQEfzkZsd0Ho4SmcmOmlHvUouyra9otyMSlGKCr/24/gTs84yPIQR79RJeodG4
 TVrx1yJWPIYrBOLWPZe1mb/JBqNwxNy5dviNsAPh/Clw+mnj+PMZXHsHqA7TmA5TwmpVckooK
 WWn8H5XMCMEPza8WsldoMRqC1bcAp/ReQRS3UcaLOjh8HACU5j2AHQmc8oLFF0fziFP4axB0X
 UDmrcGF967oO6eDu4LRMBdf/ll5Aq6HpRzftiQe5UnMbPyr0VkjmlW9+d9T9hOMUT0PkKkupX
 7cINXClvD2eMQG+YNXEDdskDjojWp4x/Khv64t/6L7wZbbHSeHtvHRdI9rT3sPkLl4Vpjsdzm
 pet/yqZvzwRW5nGEoZOOXusw3scdSAVxeWp8YmrcbOQYPYyZ6udXKA+xG6bwn4m9zsT9HeK/g
 +wswFYJ0ITRP6pfj57wHsFBAK+l+INKl/dPMPPOtIydBiu1UWH1vjzGbWit/bP2wCdznrWE+H
 mgQJcc2bbh/jRGY1bMKtBvMKNhC69lZM3lZCFkl6MUrHTapX/AsKVXFi+eENAaMBxk2ufo74a
 hW9fcHGarvks1rnt53DUvYmWq+MB3/Pg8DpX5hlxO+hquAfwoHE9omg86gJo+ZdsQodEfClGi
 AFIYArtFVcQ0ViuYaJ3czxKzBH12x6uD1SnmLP2/rXY9SgfMokqiKdCJXvwZE4nnjiWITJP8e
 hrdo8KHrM04taA8ERHXD2HSv5aHiXI8n/4G30Y90MjdpLEDkF4oEbT1PbwmHoH9jN3fvAcNX6
 pq5tyQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/4 19:10, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Commit 675dfe1223a6 ("btrfs: fix block group item corruption after
> inserting new block group") fixed one race that resulted in not persisti=
ng
> a block group's item when its "used" bytes field decreases to zero.
> However there's another race that can happen in a much shorter time wind=
ow
> that results in the same problem. The following sequence of steps explai=
ns
> how it can happen:
>
> 1) Task A creates a metadata block group X, its "used" and "commit_used"
>     fields are initialized to 0;
>
> 2) Two extents are allocated from block group X, so its "used" field is
>     updated to 32K, and its "commit_used" field remains as 0;
>
> 3) Transaction commit starts, by some task B, and it enters
>     btrfs_start_dirty_block_groups(). There it tries to update the block
>     group item for block group X, which currently has its "used" field w=
ith
>     a value of 32K and its "commited_used" field with a value of 0. Howe=
ver
>     that fails since the block group item was not yet inserted, so at
>     update_block_group_item(), the btrfs_search_slot() call returns 1, a=
nd
>     then we set 'ret' to -ENOENT. Before jumping to the label 'fail'...
>
> 4) The block group item is inserted by task A, when for example
>     btrfs_create_pending_block_groups() is called when releasing its
>     transaction handle. This results in insert_block_group_item() insert=
ing
>     the block group item in the extent tree (or block group tree), with =
a
>     "used" field having a value of 32K and setting "commit_used", in str=
uct
>     btrfs_block_group, to the same value (32K);
>
> 5) Task B jumps to the 'fail' label and then resets the "commit_used"
>     field to 0. At btrfs_start_dirty_block_groups(), because -ENOENT was
>     returned from update_block_group_item(), we add the block group agai=
n
>     to the list of dirty block groups, so that we will try again in the
>     critical section of the transaction commit when calling
>     btrfs_write_dirty_block_groups();
>
> 6) Later the two extents from block group X are freed, so its "used" fie=
ld
>     becomes 0;
>
> 7) If no more extents are allocated from block group X before we get int=
o
>     btrfs_write_dirty_block_groups(), then when we call
>     update_block_group_item() again for block group X, we will not updat=
e
>     the block group item to reflect that it has 0 bytes used, because th=
e
>     "used" and "commit_used" fields in struct btrfs_block_group have the
>     same value, a value of 0.
>
>     As a result after committing the transaction we have an empty block
>     group with its block group item having a 32K value for its "used" fi=
eld.
>     This will trigger errors from fsck ("btrfs check" command) and after
>     mounting again the fs, the cleaner kthread will not automatically de=
lete
>     the empty block group, since its "used" field is not 0. Possibly the=
re
>     are other issues due to this incosistency.
>
>     When this issue happens, the error reported by fsck is like this:
>
>       [1/7] checking root items
>       [2/7] checking extents
>       block group [1104150528 1073741824] used 39796736 but extent items=
 used 0
>       ERROR: errors found in extent allocation tree or chunk allocation
>       (...)
>
> So fix this by not resetting the "commit_used" field of a block group wh=
en
> we don't find the block group item at update_block_group_item().
>
> Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used byt=
es are the same")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although considering we have hit at least two bugs around "commit_used",
can we have a more generic way like setting "commit_used" to some
impossible values (e.g, U64_MAX) so that the bg is ensured to be updated?

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 0cb1dee965a0..b2e5107b7cec 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3028,8 +3028,16 @@ static int update_block_group_item(struct btrfs_t=
rans_handle *trans,
>   	btrfs_mark_buffer_dirty(leaf);
>   fail:
>   	btrfs_release_path(path);
> -	/* We didn't update the block group item, need to revert @commit_used.=
 */
> -	if (ret < 0) {
> +	/*
> +	 * We didn't update the block group item, need to revert commit_used
> +	 * unless the block group item didn't exist yet - this is to prevent a
> +	 * race with a concurrent insertion of the block group item, with
> +	 * insert_block_group_item(), that happened just after we attempted to
> +	 * update. In that case we would reset commit_used to 0 just after the
> +	 * insertion set it to a value greater than 0 - if the block group lat=
er
> +	 * becomes with 0 used bytes, we would incorrectly skip its update.
> +	 */
> +	if (ret < 0 && ret !=3D -ENOENT) {
>   		spin_lock(&cache->lock);
>   		cache->commit_used =3D old_commit_used;
>   		spin_unlock(&cache->lock);
