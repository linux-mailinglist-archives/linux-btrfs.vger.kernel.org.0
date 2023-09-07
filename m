Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE2797F70
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjIGX4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjIGX4k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:56:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EE1BD2
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694130987; x=1694735787; i=quwenruo.btrfs@gmx.com;
 bh=Uu2XUDG5cG8rv7ETvcThUtT7TVaIR2cPC4Ht2S2JgC0=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=WdQKP+1zTA1qOU8CAP7ovOBVPNOKUWST3BfM6m2vulXp05gxeKPAkmcu6dPK/WYOrG7ExE3
 /GbIPLFBuKU2Eqr/G3S+JUFJqdPyHzxC7c0L8ftqunMdIG0qTqoPAbp0aES6pCX3J7gRdoDUL
 Xj1bjo9MFkzpTrgcLamAxt5uGyTL+bfKnKwNMw2kg6cWbmbtzhq3ntBNZQv0v5qk4na3wkpDy
 do8jiE6zfGU5JCZhHQJ2NQ5HW5vJ2XKmQQiPERotj/rUp9QxDOyMJFA524wsnkAFtDqrdsxYf
 t1xLIDmNsJjXRUMRoRgJ8yJ3BMgCUvHn4QCXV2vEjhVnuLYr1pBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH9Y-1q4Fl82PPg-00cl5S; Fri, 08
 Sep 2023 01:56:27 +0200
Message-ID: <ef9b407d-b9ac-487d-8194-6a26e4cafb21@gmx.com>
Date:   Fri, 8 Sep 2023 07:56:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] btrfs: drop __must_check annotations
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <565b63e6e34c122ca9bbe1e0272f43d6327a6316.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <565b63e6e34c122ca9bbe1e0272f43d6327a6316.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OtZbmFWwjM6p3vmQg7JsUYpB5KZxGct8AXA0A1FffXtGJmn2j1O
 aoal3mgIloU/juxyZlUSQ8sKQ7tdwHPLCLgUMygvA7/ZFwF5i64GIne3YdLwYfAXkEZfpjZ
 j7a1ZBvQ8ipnSYiGyLHICSZiapZ8YWJFNJhGgaUPh96HJIrsr5h0wIXWv/KLwtrILTdJliK
 mf+kghYYngLkQkYtdBmuQ==
UI-OutboundReport: notjunk:1;M01:P0:JnVXC/5kb1A=;KK6sNta9wzTwUg6fsXe7bYKC0su
 yexrK3xuYdPEI1uh6IPZUF1z6iar9MsYX6GhhqxDa8/ULwbeU6JKOv55j2+mVva+FNk11UZ1M
 7Y3n7dgzw5U3UWfVJtgmY1MGKE6d+PUIN4wMlmk7lGIBDgvoFfXvRsaLS3+PCT/Ri/MAP4Are
 XEv2YdOX9+i4nDSU5pFJ6RfCgMeLg7pzs6wfSvyrBs6N8J80fTQxl3sPb3qpcFtapPFqEXRpt
 +6Jb288zFGFEN7AcXwP1KkywCD+GNZJwC0WYbP4bHusUBpfgt3tVUwS9E64NJps3VOsR4l2+G
 QhyJL8uRcY0bDTCo7w1ONJx3eE/PlOaNykQs0RRSsNfbsS1r1zoIQ2+qILmHjURR+LSfOkWjM
 wZiki3t6YG8w6ZeZyReMUjDdmiKNV/8yERZzu/XBIdKhHYqZ7NGpXaFDFaAiJSgSpVXlxaZxp
 PYPvJHhkLtxJkiVxnvew3xwEUe9s4ENUaEkZzLJDblEL2xdVo5eNnAH/cTNdUlBji1Wo5TFNl
 O52IwFe0atpci3p65mJ4jiHPbSuV19epg+mS+QApbkYM8vSnt72029uzek8ubuLORfEvx2p/8
 +GFxUZHvb98nQydjBBp7h3PhwtjUGJsc1lpRzzNdj2ieSAmcyuh60TJmei7hKiELFORLUFchF
 8Xw1BeaXtvFWOBLLe7fgELpkLZlvPdbMgKwRNOsT4i3aJbITBOYLy/6LxRXGItGPUtpXrQuSD
 KMqFAugXva8nLg7bPflDQuKhedx+tZDQV69BM8wrEoSt81/PvVwRt/FBP5ngQlal62PVtUVuW
 y0Tad7IeZUcGRXnj9z9ek7AL0sQqEB06+44E0lgjwp+bvCNwICzYChJ+uYk34j56TL1Z3jG/C
 /fHqdhD7lNcemEwKAkWZK1znnT9I14o2ND70XSYXj2fAULjzehsM7njKmXZanMYly0QzJBBzZ
 1gxy7+Dy8JsjFZbFsFP1F6vjsZc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> Drop all __must_check annotations because they're used in random
> functions and not consistently. All errors should be handled.

Is there any compiler warning option to warn about unchecked return value?

In fact recently when working on qgroup GFP_ATOMIC, I found a call site
that we didn't handle error at all (qgroup_update_counters()).

I'm pretty sure that is not the last one.

>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-tree.h | 2 +-
>   fs/btrfs/relocation.c  | 2 +-
>   fs/btrfs/root-tree.h   | 6 ++----
>   3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index ab2016db17e8..2109c72aea2a 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -142,7 +142,7 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info =
*fs_info,
>   int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 st=
art, u64 len);
>   int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
>   int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans, struct btrf=
s_ref *generic_ref);
> -int __must_check btrfs_drop_snapshot(struct btrfs_root *root, int updat=
e_ref,
> +int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
>   				     int for_reloc);
>   int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>   			struct btrfs_root *root,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9951a0caf5bb..ad67a88f2bbf 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -631,7 +631,7 @@ static int clone_backref_node(struct btrfs_trans_han=
dle *trans,
>   /*
>    * helper to add 'address of tree root -> reloc tree' mapping
>    */
> -static int __must_check __add_reloc_root(struct btrfs_root *root)
> +static int __add_reloc_root(struct btrfs_root *root)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct rb_node *rb_node;
> diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
> index eb15768b9170..8b2c3859e464 100644
> --- a/fs/btrfs/root-tree.h
> +++ b/fs/btrfs/root-tree.h
> @@ -20,10 +20,8 @@ int btrfs_del_root(struct btrfs_trans_handle *trans, =
const struct btrfs_key *key
>   int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_r=
oot *root,
>   		      const struct btrfs_key *key,
>   		      struct btrfs_root_item *item);
> -int __must_check btrfs_update_root(struct btrfs_trans_handle *trans,
> -				   struct btrfs_root *root,
> -				   struct btrfs_key *key,
> -				   struct btrfs_root_item *item);
> +int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_ro=
ot *root,
> +		      struct btrfs_key *key, struct btrfs_root_item *item);
>   int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *s=
earch_key,
>   		    struct btrfs_path *path, struct btrfs_root_item *root_item,
>   		    struct btrfs_key *root_key);
