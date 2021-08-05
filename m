Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE90A3E0C61
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 04:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhHECRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 22:17:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:43135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhHECRS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 22:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628129823;
        bh=aVQxcV+xeOGA9mGZsXOPtKpq3zY44zkvTHTAyIM7wSQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lBgXflIfI9CApuSY80MTFJOP837EjrIDenxKXgWZ5bXJL7SzvTpQv9sqxNx3n1evN
         Sn5e0sBJkUa8b9VfA8+xgJ6paw99MUfTHe9mlHzDYzU/NDDS9EyPqBHOPEr0QWj5+y
         I6CD4ibAK+vwjp7JZGUAlx+hbgBbvK4I0AryhImw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9UK-1n3R6Y0oCK-00s81U; Thu, 05
 Aug 2021 04:17:02 +0200
Subject: Re: [PATCH 1/7] btrfs: Reorder btrfs_find_item arguments
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-2-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f50cc30c-ea62-5581-2a52-d3a475d3044d@gmx.com>
Date:   Thu, 5 Aug 2021 10:16:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184854.10696-2-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jWrbbgpTkwGvGiD6mhfF98vA37WnBGx9uX6k4j0WSJI+rqxbNHF
 6o3OUcEtE/ducnrab2cXqBK6tTyUGga+//uhimev6bzdsi+527PNyfXNXUXLlCRks9uUd3l
 +KVyqEDxlzIJ4uTN0IdauW8OGd7FcqK9QnOwLoM1jIQt5BJgyARnVCwLk6b5p0npZOgpx3r
 gNsRn0fSdlEYCZSdaTfcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3E9BF1Hozog=:GHVe0UH/CGSwc/ArKaWx6s
 +oEIspV4/PLKEoFFH8P+lqkAUXzN5iOFn+vA8X1wJYj/B+5Z+ezWJxeKvqJWgxDxwYpGWt08l
 C7Pij6dglNN8dyzvneb6+s5QGe5vk4UGpEYpNCLqdopwUfpNTh+afOfkhquQBW1kVFtov3xxX
 faXorNnq6m6ZJ3W9DYZQxd0FCey+ugIOuDxb3MK66lx+dza17dSjoc/JGGQYL4R2V3sOcK2id
 X8zVgqAlcfw9JhGqJ8usVu9xYzelVJnQ8kKnkIqGNbUi5sCgQxboIvB47z45xdW3uqnHfXUWr
 HO1V9sF0uA5bkdZRQnzFe5monLtAwKDbU8CW+Abkc9haCoRCFezL9KEp8N6VkG0rTecGC+Ms9
 MekGfIzvWzRfCKSHmzdngYWz/NWGrnDmuOha7tS1s1Np7lhYPM4CywrYR5ArDhnljUbMLX0p3
 5WddbOw2/CnZWQSb070uoNkqOK1UmTPz9gKqGaSw0aqzyBG7/WpSAyTPAaJuvqfu0DEtWALso
 suRd1OaNfOMDofeaaSxzQkcoaba1hD8isTn9EHSm4haee1jIqsNPsZaic93sXvOpZ7nT4KJAW
 INIazqmKgq5ZVGKxBqQSyZ82uY0K+98njAdCB24ScK4rB4chWCK1/PybGRga4pX2eUQPsrQx2
 fL3XZz3A1o0xMIIrPjaUwmR7Ez65GAHibXCs6wjPBhSWdx4ha+LkSCBCsGWNp9xtCB/RY/84B
 LaOeow/+SZSYgqVWbM6TcysnNKOoC+g0j/Fgc7Fsz9NlYRoX0YH9tO08p8nBX5ZdjXn8D1RWS
 TUizn3MEJYIukwIFh5P+3EKGMuWoXi3+ASazHiPtSXMFgADcsC/O5sSanLXNQvAvCmzN4rgq2
 8ANqk3V/eaMJkhgjl1siOEnRpb4dRbegUeWZHS5jJ64vWK4SlZYEQX68wF71/zUEe1dtU4HKa
 n+eBlvjwY8ylkq1S14LKsRYO3TJ92xVtC5h+3pP/oFBXiMJKFCl0/GpZtNgMTtfb6bcYAR/h6
 94852LB7XdWxUFdgtF7odjMUPLMdg6BoU3RSbUXOjCPko5S3ZAMBC/I+UdIvOisf6X9joVdEV
 hf/LtutD3svgZzFgInoNZu5ZdbDO7DoF1pYVBnh68ybYf2HWed3R7J7og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/5 =E4=B8=8A=E5=8D=882:48, Marcos Paulo de Souza wrote:
> It's more natural do use objectid, type and offset, in this order, when
> dealing with btrfs keys.

I'm completely fine with this part.

>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   fs/btrfs/backref.c | 9 ++++-----
>   fs/btrfs/ctree.c   | 2 +-
>   fs/btrfs/ctree.h   | 2 +-
>   3 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index f735b8798ba1..9e92faaafa02 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1691,8 +1691,8 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root=
, struct btrfs_path *path,
>   				btrfs_tree_read_unlock(eb);
>   			free_extent_buffer(eb);
>   		}
> -		ret =3D btrfs_find_item(fs_root, path, parent, 0,
> -				BTRFS_INODE_REF_KEY, &found_key);
> +		ret =3D btrfs_find_item(fs_root, path, parent, BTRFS_INODE_REF_KEY,
> +					0, &found_key);
>   		if (ret > 0)
>   			ret =3D -ENOENT;
>   		if (ret)
> @@ -2063,9 +2063,8 @@ static int iterate_inode_refs(u64 inum, struct btr=
fs_root *fs_root,
>   	struct btrfs_key found_key;
>
>   	while (!ret) {
> -		ret =3D btrfs_find_item(fs_root, path, inum,
> -				parent ? parent + 1 : 0, BTRFS_INODE_REF_KEY,
> -				&found_key);
> +		ret =3D btrfs_find_item(fs_root, path, inum, BTRFS_INODE_REF_KEY,
> +				parent ? parent + 1 : 0, &found_key);
>
>   		if (ret < 0)
>   			break;
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 84627cbd5b5b..c0002ec9c025 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1528,7 +1528,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *=
trans,
>   }
>
>   int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *pat=
h,
> -		u64 iobjectid, u64 ioff, u8 key_type,
> +		u64 iobjectid, u8 key_type, u64 ioff,
>   		struct btrfs_key *found_key)

But the @found_key part makes me wonder.

Is it really needed?

The caller has @path and return value. If we return 0, we know it's an
exact match, no need to grab the key.
If we return 1, caller can easily grab the key using @path (if they
really need).

So can we also remove @found_key parameter, and add some comment on the
function?

Thanks,
Qu

>   {
>   	int ret;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a898257ad2b5..0a971e98f5f9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2858,7 +2858,7 @@ int btrfs_duplicate_item(struct btrfs_trans_handle=
 *trans,
>   			 struct btrfs_path *path,
>   			 const struct btrfs_key *new_key);
>   int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *pat=
h,
> -		u64 inum, u64 ioff, u8 key_type, struct btrfs_key *found_key);
> +		u64 inum, u8 key_type, u64 ioff, struct btrfs_key *found_key);
>   int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_r=
oot *root,
>   		      const struct btrfs_key *key, struct btrfs_path *p,
>   		      int ins_len, int cow);
>
