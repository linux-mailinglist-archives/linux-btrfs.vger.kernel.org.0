Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090557F210
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 01:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiGWXYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 19:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiGWXYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 19:24:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7012775;
        Sat, 23 Jul 2022 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658618640;
        bh=p4gGVnOg7wiHmitkIGdgKM6HNW3HKIzEzNyi+6h6cXY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CXu8EB0IGFykOIfjgTqO6mrWlVwlf8Uf9T9qTW02wIEzqwGJW3vUV7tn8qpE7YECF
         BCExIMZWAy5gKwdMH+b43eUCS8M7MjRDNPGEpMvGszVI3tt3dOMQn8UVYQDx93W9zb
         1O650oKbumX8SBvCXUWJPuMIG94UbglqwZOElgms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1ngKhq3OHR-00ZgGI; Sun, 24
 Jul 2022 01:24:00 +0200
Message-ID: <6b203ca9-8232-d695-e88c-c50119875e3a@gmx.com>
Date:   Sun, 24 Jul 2022 07:23:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: change btrfs_insert_file_extent() to
 btrfs_insert_hole_extent()
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>
References: <41e212570f521d9c0838b5ab8e66da0f942c7f46.1658615058.git.sweettea-kernel@dorminy.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <41e212570f521d9c0838b5ab8e66da0f942c7f46.1658615058.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ugxkW65iQVooPRhxmPSSmJpqduefDYbEXsiQ8HfNR7QvUJC1qGN
 f4m96/CyHY7RfvW+gyKHLZjt8MbUPmWvuWZ7HMdVtmkBj3RDa0oVXtOIg9DS+f8CJ1lb7VH
 YqQlWSClkg4HtIpDia24F6P/cZRdkjIHSqchHEoGQSVkgGUPipIYAxg+K70vRXA3LkKyCXu
 4zMYrSQZ4TnplEO6p+C8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJSQjE6uEqs=:LxWlI9vlLVHfkuvL0Dlg3N
 Ggqb436iTKrnFtl1+NL6qsv/O+QvJ8TOxEl8bkzLBjJ1xu876nxAmn4oAnG5H5iH5duuvsoTT
 XoH/oiCSWGr6g2S00OBqvyRRgFCLTBnDzQP4tWbHvYGoydheq5PywBeV6WNkXVKsojTm2KrhB
 BOIDgjut8OkUvd1j1mKMiXho1JJ1mNNGSFXsobF1P0gQQCRaH5wEpnz/K9g/ZLMOJwyu7qxj1
 dKK9KAB2orkOijbrdOEGNjBl5BL8UdoagZuRtvqk88WG3mykZaZRmrneiv0bw888GRO38jZQA
 xftCUubzRy4ZJKGJOGUqjBIiWrN5jRFFNMJzDZbKpeJJYFwOCTU0h7y1c7bbhLySRuEou9zHp
 2jZUCVN02anIElnaza7M63gLFZQCa8MPyXrgPG1WFj0UKTRaEOhiVFgSttGZbFu1GXWqoFe1a
 CqMszfX+F2zfWl4gBJZMEbP6Pn59CsYEiFJMP8CVaO7mSUl46LwSSjcWgyOJHkS3sXAh3ck6i
 8A9BbEkcplCHSqpOVdskuMlxksbTh/3XyqixERRmmvU2vAZYYRL8cv/7MioLJhC11H4C2Yxr/
 zK7fi1D05qkWMzAMzgJ1wrA2Z4QCxjLDhEGIMbFcJqkDv+rfbuoF8dJJ69RBK3mEuTQyWO8Kc
 Cwg3fgrqPlXlpTAHHhIK7EXFmgzZPNc/l6byA0tP6vBgeJmZ8HJdX6suT329fPkD58bmIx3HA
 ofaNxFNEQSuigzhxuZMN/ea7+KIMaeSGBxFn+XL3tsrsrtt2YXw2ejnt6B6vidDukPzflL/Br
 J9uzlQn3PJKvjvwBVyFTvqSmVXzsCf9u8bVnmG4cfu7dwzJz/cKvXoifOz7P5iKxWMUUq2IBA
 Ei1uKXZe1gq5CC3chatzHArZTAdsjWvgCmRCBjLDaEUTUrUyAHyl6Eun6CHFccxdLQH9UwdL7
 w1H6HdjYx9PH6Ay3e7w1tc90DsqwlYAw7NDsbLNVKdH+4KTjRTiBENQ9JVCgVhGr5QOtRbuGq
 ix8ALxOFhsqda6amMjjjoqV5eIX6cRW1fAfH4BxCFzQic4jbX6mwtukihX6QaQgBjbOU3Hdff
 vv6fu4NGxSh97bJbckH+QFxtTybMnM9ZWLQnoIS5mBfIobZehUTw+wpWA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/24 06:25, Sweet Tea Dorminy wrote:
> From: Omar Sandoval <osandov@osandov.com>
>
> btrfs_insert_file_extent() is only ever used to insert holes, so rename
> it and remove the redundant parameters.
>
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h     |  9 +++------
>   fs/btrfs/file-item.c | 21 +++++++++------------
>   fs/btrfs/file.c      |  4 ++--
>   fs/btrfs/inode.c     |  4 ++--
>   fs/btrfs/tree-log.c  | 13 +++++--------
>   5 files changed, 21 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db85b9dc7ed..3482eea0f1b8 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3258,12 +3258,9 @@ int btrfs_find_orphan_item(struct btrfs_root *roo=
t, u64 offset);
>   int btrfs_del_csums(struct btrfs_trans_handle *trans,
>   		    struct btrfs_root *root, u64 bytenr, u64 len);
>   blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bi=
o, u8 *dst);
> -int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
> -			     struct btrfs_root *root,
> -			     u64 objectid, u64 pos,
> -			     u64 disk_offset, u64 disk_num_bytes,
> -			     u64 num_bytes, u64 offset, u64 ram_bytes,
> -			     u8 compression, u8 encryption, u16 other_encoding);
> +int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_root *root, u64 objectid, u64 pos,
> +			     u64 num_bytes);
>   int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>   			     struct btrfs_root *root,
>   			     struct btrfs_path *path, u64 objectid,
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index c828f971a346..29999686d234 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -129,12 +129,9 @@ static inline u32 max_ordered_sum_bytes(struct btrf=
s_fs_info *fs_info,
>   	return ncsums * fs_info->sectorsize;
>   }
>
> -int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
> +int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
>   			     struct btrfs_root *root,
> -			     u64 objectid, u64 pos,
> -			     u64 disk_offset, u64 disk_num_bytes,
> -			     u64 num_bytes, u64 offset, u64 ram_bytes,
> -			     u8 compression, u8 encryption, u16 other_encoding)
> +			     u64 objectid, u64 pos, u64 num_bytes)
>   {
>   	int ret =3D 0;
>   	struct btrfs_file_extent_item *item;
> @@ -157,16 +154,16 @@ int btrfs_insert_file_extent(struct btrfs_trans_ha=
ndle *trans,
>   	leaf =3D path->nodes[0];
>   	item =3D btrfs_item_ptr(leaf, path->slots[0],
>   			      struct btrfs_file_extent_item);
> -	btrfs_set_file_extent_disk_bytenr(leaf, item, disk_offset);
> -	btrfs_set_file_extent_disk_num_bytes(leaf, item, disk_num_bytes);
> -	btrfs_set_file_extent_offset(leaf, item, offset);
> +	btrfs_set_file_extent_disk_bytenr(leaf, item, 0);
> +	btrfs_set_file_extent_disk_num_bytes(leaf, item, 0);
> +	btrfs_set_file_extent_offset(leaf, item, 0);
>   	btrfs_set_file_extent_num_bytes(leaf, item, num_bytes);
> -	btrfs_set_file_extent_ram_bytes(leaf, item, ram_bytes);
> +	btrfs_set_file_extent_ram_bytes(leaf, item, num_bytes);
>   	btrfs_set_file_extent_generation(leaf, item, trans->transid);
>   	btrfs_set_file_extent_type(leaf, item, BTRFS_FILE_EXTENT_REG);
> -	btrfs_set_file_extent_compression(leaf, item, compression);
> -	btrfs_set_file_extent_encryption(leaf, item, encryption);
> -	btrfs_set_file_extent_other_encoding(leaf, item, other_encoding);
> +	btrfs_set_file_extent_compression(leaf, item, 0);
> +	btrfs_set_file_extent_encryption(leaf, item, 0);
> +	btrfs_set_file_extent_other_encoding(leaf, item, 0);
>
>   	btrfs_mark_buffer_dirty(leaf);
>   out:
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 687fb372093f..d199275adfa4 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2520,8 +2520,8 @@ static int fill_holes(struct btrfs_trans_handle *t=
rans,
>   	}
>   	btrfs_release_path(path);
>
> -	ret =3D btrfs_insert_file_extent(trans, root, btrfs_ino(inode),
> -			offset, 0, 0, end - offset, 0, end - offset, 0, 0, 0);
> +	ret =3D btrfs_insert_hole_extent(trans, root, btrfs_ino(inode), offset=
,
> +				       end - offset);
>   	if (ret)
>   		return ret;
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ecc5fa3343fc..f2c83ef8d4aa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5022,8 +5022,8 @@ static int maybe_insert_hole(struct btrfs_root *ro=
ot, struct btrfs_inode *inode,
>   		return ret;
>   	}
>
> -	ret =3D btrfs_insert_file_extent(trans, root, btrfs_ino(inode),
> -			offset, 0, 0, len, 0, len, 0, 0, 0);
> +	ret =3D btrfs_insert_hole_extent(trans, root, btrfs_ino(inode), offset=
,
> +				       len);
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
>   	} else {
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index dcf75a8daa20..f99fd0a08902 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -5219,10 +5219,9 @@ static int btrfs_log_holes(struct btrfs_trans_han=
dle *trans,
>   			 * leafs from the log root.
>   			 */
>   			btrfs_release_path(path);
> -			ret =3D btrfs_insert_file_extent(trans, root->log_root,
> -						       ino, prev_extent_end, 0,
> -						       0, hole_len, 0, hole_len,
> -						       0, 0, 0);
> +			ret =3D btrfs_insert_hole_extent(trans, root->log_root,
> +						       ino, prev_extent_end,
> +						       hole_len);
>   			if (ret < 0)
>   				return ret;
>
> @@ -5251,10 +5250,8 @@ static int btrfs_log_holes(struct btrfs_trans_han=
dle *trans,
>
>   		btrfs_release_path(path);
>   		hole_len =3D ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
> -		ret =3D btrfs_insert_file_extent(trans, root->log_root,
> -					       ino, prev_extent_end, 0, 0,
> -					       hole_len, 0, hole_len,
> -					       0, 0, 0);
> +		ret =3D btrfs_insert_hole_extent(trans, root->log_root, ino,
> +					       prev_extent_end, hole_len);
>   		if (ret < 0)
>   			return ret;
>   	}
