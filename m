Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511E11D08F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgEMGtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 02:49:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:57583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgEMGtY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 02:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589352555;
        bh=3FwkvNXHCuaIaWFUnUmEeBHmmdmeZXLLttfIAyZleDU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Gr+VG7QsGAaTV9Tubc/CNyyYmvuk2fJkhoe9j2SSJJApEeH/hUNPHGOTjlkx06qml
         P91wsvYLyp/WyeL5W17LjrAf/LGteIk74b0gPk5sADTJUC2UDruiIoDW80cUQhEKdU
         8cuQjK4F92+/Hp4bIDi0vkrF1/yoqOd1H1DrgbPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0XCw-1jDmRj0U9k-00wXCA; Wed, 13
 May 2020 08:49:15 +0200
Subject: Re: [PATCH 2/2] btrfs: Don't set SHAREABLE flag for data reloc tree
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200513061611.111807-1-wqu@suse.com>
 <20200513061611.111807-3-wqu@suse.com>
 <84d3fb22-3845-b952-88ca-c5ce31ab967f@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <2dc7bd7b-dc68-613e-f668-0462829f380f@gmx.com>
Date:   Wed, 13 May 2020 14:49:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <84d3fb22-3845-b952-88ca-c5ce31ab967f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3AqIxMnoSafOBdLCosSWGvDBZYdtRamtW9vcDW6Mhg50tWq1bSL
 CG6qXA9E/LEIa9UF6+10e9RXTxd897zE4FAPKYqm0DoiMxZcSQoEP7m2ZPgr2u6y3ln8tqR
 Cg7zmpAsV3FYdfsyZskl4GxIewO401qkN15MfIlLZUE7REQsedxctyXCPK4EduTvRKXt+LP
 gwhArKLYX8z5lpPqkiNlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wnfQ0Z5R3RE=:fcQXP66fHc/4meeUhSxE2K
 ZLpMDlpVk+GsbQ4f1NRsrnur7SL4JB1GTjV2uhnjN0oLbh1YA7eLUIWJsh7N2wSEyGpEIDQ2Z
 z7I7Ga2Z4vPGU8gF8o6J1j6oOzNtGRWwJ+m2Wq9h8F6mnRFvdbWVGOyfk0C4JRjxQ8iGzN/yS
 rOyZ8lwJqa0iEXQtPxUMrLg/+wuf6SLNWNl3nFdvzpdOFAjSESkEZ136v8WAd5gPSpfwurhQ8
 piNUC3XJ+o8eZjykvZmAJxncT+UgJcuFoeLv8Imky3RiH45AB3oI1YShwKZ4ks4oxUERWjUao
 Mdt57pHfilBW9iNG5LHtPM/g/OyyJhkk66a11WKjxyx+G5eY/fjY7YuT0UqSZVDQjkzdivKu8
 Dhhj7hkyh9YAQ5XFlF6dsH2J7eatyCJPDHF1upUIFInN8mxfXWm/KI0mee7cZVNbPeeYS7dt1
 HDdyHzRMiNyHbKD6YZLd1VpkBr7aSIV/T7/NAbj4VSev92Ufiji8eAA78yCZqAbotfo5399DO
 F+mGbpShTFHlupO6r4B4sPReh1sAbB15uCrktHJF7jTVWgPhnSdtb2LQDCQOZZ1o5Jw+tgaRw
 zqttcaYgmaf+Yuvwmcn6ZkJhwxSGRpL+uEt7tXNnLpr647491T3AZpqW1eEOMn7LJwwFCr/FQ
 uk35SBqHmpOSwwTYhSaj2zqpjQQYuXdMJ8CGg1TcGcZJWr2Dy7zMxtCBQH2js3FOt2X8/QD+m
 S8d6Vaiyq/JFJ9vcZ78dEAHRoe0lescjimv1+uujEXP5HBZSWSDdLU6ua1fM/DYFFuMIKrYQ2
 PKStUWhVQXVGHm5RC0vD1sDcteRrhtm4x6yxhC1gOB/1qiFHBwIggiwdyV+UbNwaUTaqsxgTr
 dsyTKFPZItVUDi2WGidIgICRbHsLzuJ2nj+lPZhocZgHa77XiS5NXK+YQxKWb6p+ji3JgwoUZ
 2Dd8bGyVxeEILZt6AC7wCPJXP+XA2QOUG9GCpHbxutNet8frW7sU56/VpzAFA24QU09dwvLTr
 gwCfK7I9hXUTC5HQI3dnMkmqGInYE2P/cmK3KrXDmKPVeHALSDY0ylnELzn6Tae8FTK3pEIFE
 J/GSi2z1i+PqdsFf2zEP/2i67SdCiCSgWJAd0zuInRlFobt2sg+y+4oWvclL0Xk6Q7f3bZ9Lm
 +Erc9I+4k3a3+wyBkQv8hk30kCdympPKkCwNZHV8HCnb8sr68ivye/lWgDhcp2Tto44QrAAyR
 BsymOhvszJpmY383x
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/13 =E4=B8=8B=E5=8D=882:44, Nikolay Borisov wrote:
>
>
> On 13.05.20 =D0=B3. 9:16 =D1=87., Qu Wenruo wrote:
>> SHAREABLE flag is set for subvolumes because users can create snapshot
>> for subvolumes, thus sharing tree blocks of them.
>>
>> But users can't access data reloc tree as it's only an internal tree fo=
r
>> data relocation, thus it doesn't need the full path replacement treat a=
t
>> all.
>>
>> This patch will make data reloc tree just a non-shareable tree, and add
>> btrfs_fs_info::dreloc_root for data reloc tree, so relocation code can
>> grab it from fs_info directly.
>>
>> This would slightly improve tree relocation, as now data reloc tree
>> can go through regular COW routine to get relocated, without bothering
>> the complex tree reloc tree routine.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h      |  1 +
>>  fs/btrfs/disk-io.c    | 14 +++++++++++++-
>>  fs/btrfs/inode.c      |  7 ++++---
>>  fs/btrfs/relocation.c | 18 ++++--------------
>>  4 files changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 65c09aea4cb9..a9690f438a15 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -582,6 +582,7 @@ struct btrfs_fs_info {
>>  	struct btrfs_root *quota_root;
>>  	struct btrfs_root *uuid_root;
>>  	struct btrfs_root *free_space_root;
>> +	struct btrfs_root *dreloc_root;
>
> Rename this to data_reloc_root or simply reloc_root, dreloc is rather
> cryptic.

Data_reloc_root looks good.
Reloc_root would easily conflict with tree reloc tree.

>>
>>  	/* the log root tree is a directory of all the other log roots */
>>  	struct btrfs_root *log_root_tree;
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 4dd3206c1ace..7355ebc648c5 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1419,7 +1419,8 @@ static int btrfs_init_fs_root(struct btrfs_root *=
root)
>>  	if (ret)
>>  		goto fail;
>>
>> -	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
>> +	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
>> +	    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
>>  		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
>>  		btrfs_check_and_init_root_item(&root->root_item);
>>  	}
>> @@ -1525,6 +1526,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_=
info)
>>  	btrfs_put_root(fs_info->uuid_root);
>>  	btrfs_put_root(fs_info->free_space_root);
>>  	btrfs_put_root(fs_info->fs_root);
>> +	btrfs_put_root(fs_info->dreloc_root);
>>  	btrfs_check_leaked_roots(fs_info);
>>  	btrfs_extent_buffer_leak_debug_check(fs_info);
>>  	kfree(fs_info->super_copy);
>> @@ -1981,6 +1983,7 @@ static void free_root_pointers(struct btrfs_fs_in=
fo *info, bool free_chunk_root)
>>  	free_root_extent_buffers(info->quota_root);
>>  	free_root_extent_buffers(info->uuid_root);
>>  	free_root_extent_buffers(info->fs_root);
>> +	free_root_extent_buffers(info->dreloc_root);
>>  	if (free_chunk_root)
>>  		free_root_extent_buffers(info->chunk_root);
>>  	free_root_extent_buffers(info->free_space_root);
>> @@ -2287,6 +2290,15 @@ static int btrfs_read_roots(struct btrfs_fs_info=
 *fs_info)
>>  	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>>  	fs_info->csum_root =3D root;
>>
>> +	location.objectid =3D BTRFS_DATA_RELOC_TREE_OBJECTID;
>> +	root =3D btrfs_get_fs_root(fs_info, &location, true);
>> +	if (IS_ERR(root)) {
>> +		ret =3D PTR_ERR(root);
>> +		goto out;
>> +	}
>> +	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> +	fs_info->dreloc_root =3D root;
>> +
>>  	location.objectid =3D BTRFS_QUOTA_TREE_OBJECTID;
>>  	root =3D btrfs_read_tree_root(tree_root, &location);
>>  	if (!IS_ERR(root)) {
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 13bbb6b0d495..6b7ba20eee52 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -4133,7 +4133,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans=
_handle *trans,
>>  	 * inode.
>>  	 */
>>  	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>> -	    root =3D=3D fs_info->tree_root)
>> +	    root =3D=3D fs_info->tree_root || root =3D=3D fs_info->dreloc_roo=
t)
>>  		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
>>  					fs_info->sectorsize),
>>  					(u64)-1, 0);
>> @@ -4338,7 +4338,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans=
_handle *trans,
>>
>>  		if (found_extent &&
>>  		    (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>> -		     root =3D=3D fs_info->tree_root)) {
>> +		     root =3D=3D fs_info->tree_root ||
>> +		     root =3D=3D fs_info->dreloc_root)) {
>>  			struct btrfs_ref ref =3D { 0 };
>>
>>  			bytes_deleted +=3D extent_num_bytes;
>> @@ -5046,7 +5047,7 @@ void btrfs_evict_inode(struct inode *inode)
>>  		btrfs_end_transaction(trans);
>>  	}
>>
>> -	if (!(root =3D=3D fs_info->tree_root ||
>> +	if (!(root =3D=3D fs_info->tree_root || root =3D=3D fs_info->dreloc_r=
oot ||
>>  	      root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID))
>>  		btrfs_return_ino(root, btrfs_ino(BTRFS_I(inode)));
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 437b782c57e6..cb45ae92f15d 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1087,7 +1087,8 @@ int replace_file_extents(struct btrfs_trans_handl=
e *trans,
>>  		 * if we are modifying block in fs tree, wait for readpage
>>  		 * to complete and drop the extent cache
>>  		 */
>> -		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID) {
>> +		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
>> +		    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
>>  			if (first) {
>>  				inode =3D find_next_inode(root, key.objectid);
>>  				first =3D 0;
>> @@ -3470,15 +3471,11 @@ struct inode *create_reloc_inode(struct btrfs_f=
s_info *fs_info,
>>  {
>>  	struct inode *inode =3D NULL;
>>  	struct btrfs_trans_handle *trans;
>> -	struct btrfs_root *root;
>> +	struct btrfs_root *root =3D fs_info->dreloc_root;
>
> So why haven't you added code in btrfs_get_fs_root to quickly return a
> refcounted root and instead reference it without incrementing the refcou=
nt?

This is exactly the same as how we handle fs_root.
And since the lifespan of data reloc root will be the same as the fs, I
don't think there is any need for it to be grabbed each time we need it.

Thanks,
Qu
>
>>  	struct btrfs_key key;
>>  	u64 objectid;
>>  	int err =3D 0;
>>
>> -	root =3D read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
>> -	if (IS_ERR(root))
>> -		return ERR_CAST(root);
>> -
>>  	trans =3D btrfs_start_transaction(root, 6);
>>  	if (IS_ERR(trans)) {
>>  		btrfs_put_root(root);
>> @@ -3501,7 +3498,6 @@ struct inode *create_reloc_inode(struct btrfs_fs_=
info *fs_info,
>>
>>  	err =3D btrfs_orphan_add(trans, BTRFS_I(inode));
>>  out:
>> -	btrfs_put_root(root);
>>  	btrfs_end_transaction(trans);
>>  	btrfs_btree_balance_dirty(fs_info);
>>  	if (err) {
>> @@ -3870,13 +3866,7 @@ int btrfs_recover_relocation(struct btrfs_root *=
root)
>>
>>  	if (err =3D=3D 0) {
>>  		/* cleanup orphan inode in data relocation tree */
>> -		fs_root =3D read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
>> -		if (IS_ERR(fs_root)) {
>> -			err =3D PTR_ERR(fs_root);
>> -		} else {
>> -			err =3D btrfs_orphan_cleanup(fs_root);
>> -			btrfs_put_root(fs_root);
>> -		}
>> +		err =3D btrfs_orphan_cleanup(fs_info->dreloc_root);
>>  	}
>>  	return err;
>>  }
>>
