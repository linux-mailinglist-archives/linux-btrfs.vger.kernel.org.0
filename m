Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895DB7ABBA8
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjIVWLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVWLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:11:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0F19A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420683; x=1696025483; i=quwenruo.btrfs@gmx.com;
 bh=UCthk2O8sPrKhnFnWkVHSmzYsD9Glx1lbbdH8EJGK84=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=caD7Jzv9/GYzKJqN6VRS5JQSY8baR+Lg6h5q+Y4tPUKpSThTLh2i7x0QmG01sRmpsz/sPVNEk9v
 MXjzdfzGKOjkgIZ+JyLC3b9Y7Xra1Cb4XqpVCBLucL/BFMeUvIcjXFFTXgWvNjgft0jolJ6+VgYuA
 zpDQ4u9NKL0BBtWP+txuVy/IFGJDnZC8RBR9/tLs3+yeK/GBtZxcrAK0+nuPqSX9o0crNf1utGZhd
 /uqHGcTImZDzSxDOas4XThdaLxcIOsg1fu2n1EIQ+LNXoiVyjSh51DwF3giaszRL23kYuSxmOPLiL
 1z5r6qtGG/57djfHQGC2V+/n4T+3n+eRHx7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKsjH-1qySyF1uxh-00LGUA; Sat, 23
 Sep 2023 00:11:23 +0200
Message-ID: <ea74eb11-9a70-405f-b166-e1bf09abb58c@gmx.com>
Date:   Sat, 23 Sep 2023 07:41:19 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] btrfs: remove redundant root argument from
 fixup_inode_link_count()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <9bae05da75131701556cd6704cab663d10e2bb20.1695333082.git.fdmanana@suse.com>
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
In-Reply-To: <9bae05da75131701556cd6704cab663d10e2bb20.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WLE2bKUHSfi3RX0VblbtPsaSTg1k70/l59hNHmBHE9KZNc6b9M
 ZOxNrqrIgT/qTy3yKXQD7Sndm1l8hFlBaenAZ1jrQwsuM0GhmBg3bgekKPBBfziwaJPo3NT
 wNafpMti6O4wfyjOJWS2HjuqEj+3Vtt/VLjDRyXHpumcPDN5R/bKJT+vsEmdTBOCC5dtIL+
 3PYg07tvnFuCnF67hoDSA==
UI-OutboundReport: notjunk:1;M01:P0:yMzLSYO76Z8=;ZkBA2+cUPT5HSeyM2vSt5BJNhiR
 tjQv1edoi9ZmqTXnCN3ObPdSX7PadeAGyq1u10UUDchpaTWn2VmpMGvhF5a7u/OP6pjxNKDGV
 BYqrGOe9j3P4Ljg+xC4nxgk1OOF3SeTT5aEdGBwNlgnBdWN9w+WjaMyu60Izm/fY07rsZ8Kud
 vizi9mBXjj2tGRKWHihPU8ZGIDs0iTdfjFgIjmOZRLMdRiu9CiP5/7HDWjD6xWnR8ck90soHQ
 VKZY9WrSuE0vd5Vtr8f1n725KXb5mt2cJ8RbCmJ6VaHYdXUvgtDvgiqRUudphNIHLARcmiGAo
 ZFaoyRYlHUHqoTvshsljrCGHTRxgvFmkQKUjf5Fwo8SoKoofUVechpKGfA4nvFuUhHAtTfpN3
 sf67umInynvlFzq+uC+4n7pG9nxPtgnqlE8u4TzQwaDEyOcVM7xFbct6BML8Y38ZY+L5TG0aT
 qqUwCOjCwA9sNAnUtX2x7t2a4ELKaO9k2g0r86hmlbSaeZZ95Dsb7xdy0rvDGTIVNnK3Z29Th
 BZZsHLw8doBB5yS9v35V/itCv3pEdMXmpFf/lWY++Gv5EgG/3pxLM4WbBzY/5U+4vxvgKWAWZ
 j4m6KubNPoO3JqbUEdyifyNgSbR7tHvkabu9IqE4Ge4ncHgsR6/TPpCKNN+T48WqUvYKAL7ww
 qsWKsD4roKfvLTTI8MZuzC5yCXTde2j+LDcjOYLqc3IQ1qVTkorZcTFI9Erc+QcRyUsmrVxK1
 dhCIebvJMX7aB8WhRt5jm/z6QZpi9CB63fD3UGoGKITDABVb7md/0nWUTnQHxAFDgBvBb5FGL
 Kd655l78z8Lj/miyFfwYcBuRCkg8xpK0YvKBXcKItNuC4+SC2x9Nnq6Gn6RkMp7FJhPL91Cw1
 htkyLrzCBcf/xV9+3QT6yVGWAsrLK2k3PztEajOjKA+TMSbeiRcYPGuEydm+aNElKBu9POG30
 Ndbas04F01sDLjMwg5d58RBbZfM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The root argument for fixup_inode_link_count() always matches the root o=
f
> the given inode, so remove the root argument and get it from the inode
> argument. This also applies to the helpers count_inode_extrefs() and
> count_inode_refs() used by fixup_inode_link_count() - they don't need th=
e
> root argument, as it always matches the root of the inode passed to them=
.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/tree-log.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index a7bba3d61e55..f4257be56bd3 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1482,8 +1482,7 @@ static noinline int add_inode_ref(struct btrfs_tra=
ns_handle *trans,
>   	return ret;
>   }
>
> -static int count_inode_extrefs(struct btrfs_root *root,
> -		struct btrfs_inode *inode, struct btrfs_path *path)
> +static int count_inode_extrefs(struct btrfs_inode *inode, struct btrfs_=
path *path)
>   {
>   	int ret =3D 0;
>   	int name_len;
> @@ -1497,8 +1496,8 @@ static int count_inode_extrefs(struct btrfs_root *=
root,
>   	struct extent_buffer *leaf;
>
>   	while (1) {
> -		ret =3D btrfs_find_one_extref(root, inode_objectid, offset, path,
> -					    &extref, &offset);
> +		ret =3D btrfs_find_one_extref(inode->root, inode_objectid, offset,
> +					    path, &extref, &offset);
>   		if (ret)
>   			break;
>
> @@ -1526,8 +1525,7 @@ static int count_inode_extrefs(struct btrfs_root *=
root,
>   	return nlink;
>   }
>
> -static int count_inode_refs(struct btrfs_root *root,
> -			struct btrfs_inode *inode, struct btrfs_path *path)
> +static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_pat=
h *path)
>   {
>   	int ret;
>   	struct btrfs_key key;
> @@ -1542,7 +1540,7 @@ static int count_inode_refs(struct btrfs_root *roo=
t,
>   	key.offset =3D (u64)-1;
>
>   	while (1) {
> -		ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		ret =3D btrfs_search_slot(NULL, inode->root, &key, path, 0, 0);
>   		if (ret < 0)
>   			break;
>   		if (ret > 0) {
> @@ -1594,9 +1592,9 @@ static int count_inode_refs(struct btrfs_root *roo=
t,
>    * will free the inode.
>    */
>   static noinline int fixup_inode_link_count(struct btrfs_trans_handle *=
trans,
> -					   struct btrfs_root *root,
>   					   struct inode *inode)
>   {
> +	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>   	struct btrfs_path *path;
>   	int ret;
>   	u64 nlink =3D 0;
> @@ -1606,13 +1604,13 @@ static noinline int fixup_inode_link_count(struc=
t btrfs_trans_handle *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	ret =3D count_inode_refs(root, BTRFS_I(inode), path);
> +	ret =3D count_inode_refs(BTRFS_I(inode), path);
>   	if (ret < 0)
>   		goto out;
>
>   	nlink =3D ret;
>
> -	ret =3D count_inode_extrefs(root, BTRFS_I(inode), path);
> +	ret =3D count_inode_extrefs(BTRFS_I(inode), path);
>   	if (ret < 0)
>   		goto out;
>
> @@ -1684,7 +1682,7 @@ static noinline int fixup_inode_link_counts(struct=
 btrfs_trans_handle *trans,
>   			break;
>   		}
>
> -		ret =3D fixup_inode_link_count(trans, root, inode);
> +		ret =3D fixup_inode_link_count(trans, inode);
>   		iput(inode);
>   		if (ret)
>   			break;
