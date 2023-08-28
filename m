Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1598978A7FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjH1Ipq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjH1Ipd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:45:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74BE5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693212322; x=1693817122; i=quwenruo.btrfs@gmx.com;
 bh=QY7ndobHyx7e5JN4VgnV30ztfcjkkC0cpmkK+hwjihw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ccq/BTa9nAIHfZmx97IBgJujDJjmGiwO1cVFOeElWMjRLqKN8cZjd13svNKOOKlmPmji1Gs
 /WPDR+Vi0nXZFawspYlYNOKnc5ayi1w6UB0/HEJ9SxXPSOllUd//7lVL4zDS6HVTZEvLbmg0J
 GfN3hvvJccl5EwO/gFkiVxeSmDpMntbupkkd00y+c1XsOwLY5+XO32XsV0qlbbeDfS8Sh6WT3
 SZKOuA/uyTVaqv9tj7f5J/eEMPXV/0qqo8hcAD8xPQIY+7NTtpvUkgHjmGKzlgG+FIxY+XAgo
 ssoXLlq6WIa98ypB93Y4Iuv3jl6qlcohWNcbMo6+bOuAkZiyXdPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1qGfZi0bua-00JpJu; Mon, 28
 Aug 2023 10:45:22 +0200
Message-ID: <b1b88efe-37d3-4d96-9720-e324a9d1c786@gmx.com>
Date:   Mon, 28 Aug 2023 16:45:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: assert delayed node locked when removing
 delayed item
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1693209858.git.fdmanana@suse.com>
 <29dfd7c6aebbfbd0638a2e34ae34aa1d4f550389.1693209858.git.fdmanana@suse.com>
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
In-Reply-To: <29dfd7c6aebbfbd0638a2e34ae34aa1d4f550389.1693209858.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j14IHhbB3KzYbMQW+zp+sZGH/hTx3RWfEJqeFh4BqBRRDdRIbV/
 VeV2Ao4DTLLh5aaNq8AYNr9TGxLr3f5Z7bKGF/d/a4PZBezV9RJM4FLuoUAZcas3MRMTshq
 1FHT7WPS78XI31qWiPMordCE4o/LySZo/Jl00UJHYhGdqZ/8mgGsSY9UiCcCQF9rWl7I+Rm
 NPnSILoqYOQ2dwsH0B50Q==
UI-OutboundReport: notjunk:1;M01:P0:EQFHVDJfFnI=;tIcacahFmNfd6skm4LiPttnLnYF
 RBAovzDFdlbYcyx8utmZDpDfYw2s9J9Ap8Ibd0hQNxfxbn/WHq4dWlNe1Ru36v2nB5pdDXFUX
 +HDFP9XSe7z7HhozBSmUTNfBGfbbwZc+/Gulin3yr/HUL7ehDAMflt828lqtQscJEgOdPg9d8
 lTtdXg0oHXbDujBJiI/lfpUnPFluya03IhknC6BG2zhookC/oXP3hc3Y1GJsgga9xM3LF/XTn
 XbVzr++hebxNcJ0Z17P0M1RA+Fgvbdnxg44/FuGR9RWPrrUVK3Jz/Q2koPG5EOpZsA3xJdy0C
 zxGBzYhZb+UEENeaZ5N66mAjUQlp7RbR9gyYNF/m8XGU7LS5b2wYrJRoIUUhBRRmPUw2/rLiy
 w7yNdt1KEtsIj1p5GTfrT9PRpWnOpipWjmIh7NgtnnQcwf9Y5I6OIGbL8pb1yQhAFz5KdKTH9
 rE4hgNrITzSNg6Nt+C6gFiqD81HZ9DfKywuv8alzwjkv8qZUBywr2c4W31E2pfrtW0P5yDAPP
 sfw/pASPkcxtEJVTKKNxC6j9J3aRC3M1Dq+9FcJQ3icWgnfW8qNmolQdPaIbwf1jYcmJIUG13
 8NI5bv1RCvqX1k1RhgxXy+iCzMafn2noSiUKTCKK3W6Srzv2Qgv3jwPjf2KdD+zEJAGmrb6hT
 B4LFJQdUEZquVzZ8+3xfu/Zv1t6Tzs9R7qrqKtnOGSJQL9DE1pQp/Du3hve+ZSPAuwbugTpR2
 b+kyIJ3I50zkQlvbYEFdUW+46vwZckFK1NVY7tWLzPXKx6HRULIHVVhINKolRpvQNnC8mgB2P
 KtTydLdO1/DvlCrokRW3Iuw7lKmnpNE+E+wNEoFkX8E/pqACW7yLeKH0s1f95M+/bah09OfRK
 jG4RW7wfeg18KIHRk/yueqYOXANyqm0qwSnvirlJCxVvfBlFkAIjp1JBYo3VUEmqc+goULioY
 AHMSQ084cLEBv9sRhi/8jzoIRIY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/28 16:06, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When removing a delayed item, or releasing which will remove it as well,
> we will modify one of the delayed node's rbtrees and item counter if the
> delayed item is in one of the rbtrees. This require having the delayed
> node's mutex locked, otherwise we will race with other tasks modifying
> the rbtrees and the counter.
>
> This is motivated by a previous version of another patch actually callin=
g
> btrfs_release_delayed_item() after unlocking the delayed node's mutex an=
d
> against a delayed item that is in a rbtree.
>
> So assert at __btrfs_remove_delayed_item() that the delayed node's mutex
> is locked.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although it would be even better to add lockdep asserts for both
__btrfs_add_delayed_item() and __btrfs_remove_delayed_item().

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index eb175ae52245..8534285f760d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -412,6 +412,7 @@ static void finish_one_item(struct btrfs_delayed_roo=
t *delayed_root)
>
>   static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *del=
ayed_item)
>   {
> +	struct btrfs_delayed_node *delayed_node =3D delayed_item->delayed_node=
;
>   	struct rb_root_cached *root;
>   	struct btrfs_delayed_root *delayed_root;
>
> @@ -419,18 +420,21 @@ static void __btrfs_remove_delayed_item(struct btr=
fs_delayed_item *delayed_item)
>   	if (RB_EMPTY_NODE(&delayed_item->rb_node))
>   		return;
>
> -	delayed_root =3D delayed_item->delayed_node->root->fs_info->delayed_ro=
ot;
> +	/* If it's in a rbtree, then we need to have delayed node locked. */
> +	lockdep_assert_held(&delayed_node->mutex);
> +
> +	delayed_root =3D delayed_node->root->fs_info->delayed_root;
>
>   	BUG_ON(!delayed_root);
>
>   	if (delayed_item->type =3D=3D BTRFS_DELAYED_INSERTION_ITEM)
> -		root =3D &delayed_item->delayed_node->ins_root;
> +		root =3D &delayed_node->ins_root;
>   	else
> -		root =3D &delayed_item->delayed_node->del_root;
> +		root =3D &delayed_node->del_root;
>
>   	rb_erase_cached(&delayed_item->rb_node, root);
>   	RB_CLEAR_NODE(&delayed_item->rb_node);
> -	delayed_item->delayed_node->count--;
> +	delayed_node->count--;
>
>   	finish_one_item(delayed_root);
>   }
