Return-Path: <linux-btrfs+bounces-4131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E078A07EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 07:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCDE1C21D19
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E013CA86;
	Thu, 11 Apr 2024 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uFJa4608"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C313C806
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815109; cv=none; b=dJzJ0HQnNA47IDRlu5tqtwdbUk8hRVPdiD34JEfhcN0D4kPwg2x8yd18srbFSrufVdg7rDae+CnoepPnTPA0eHSiq9ihsCoRAnVpzkNkcx1BPjVXb592pVhKypk+1bnkELNRDkAz/U6a6MDQR3WqqhCcsz4Zebcs2ugF4h0jpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815109; c=relaxed/simple;
	bh=/Qpe5lsM8pGY8JTgUNtKXsVsr2UUNYbC0DmqxWipCas=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KLfLiYnAsVjQTA0YWA18YqsFqlDsD/7N/qY7a7SfLVFJIeDlKksHoWkp1q9W5V8KjK/OFuezBfWRdFKI1S2LMxdVWimLglekqPgbX6sv2/ZHN5T8VmAV2oeDAAvrEG2xNxIw8dkZ2Wlt0EWhH8aHMVEgewDVbyMmbw73q7Hd200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uFJa4608; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712815099; x=1713419899; i=quwenruo.btrfs@gmx.com;
	bh=hev4+/8w+ZpjP1CIjKj+R0NSEpefcIcd0TOxqT4yqKU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uFJa4608exsclsWMyM1eCkd3gNCYW4onLEmsQbGDIr4FiY7/Cmc2Wr9x5vDpI0RT
	 KjC+qqp8AawI1PsBVNb9EHcP4CBxcCBUINsWWlGXsHPslHaukSgXIOzBWU0rcNVrp
	 FJfQ6POofeEVCg6ntw4As/NuXz9bg5FOtbny54I0V/3S+/JnCEVQGfjMoU/RVehM9
	 GQW5/nc+BicwbrPiRdhJyd8CBKowr1+QON9Ii2qjswLf096HhMVugcVWHkpK96vaM
	 QDgP3yWe6aeApo8KQULmf+X65N157dR3jkHkG3wHQeYtqkPM7ZMKuOwR3oV1e6uYG
	 1nKkPXdFZWP3KhOe3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1s0Ex43J8O-00GbNl; Thu, 11
 Apr 2024 07:58:19 +0200
Message-ID: <ae52bfc9-ea64-4079-a98a-acd1750fe7ab@gmx.com>
Date: Thu, 11 Apr 2024 15:28:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] btrfs: add a shrinker for extent maps
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712748143.git.fdmanana@suse.com>
 <5d1743b20f84e0262a2c229cd5e877ed0f0596a0.1712748143.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <5d1743b20f84e0262a2c229cd5e877ed0f0596a0.1712748143.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2z86pCmGjwv7QAuY1r/WbRFvRVvkj4W7pJouroGqThGI62kabjZ
 9e6/nsbGJnJYGN0gX17rFmGeof/L6smMiXYtbNsPR6wnnf13TXsW8zt2kZ6zr8ncLge4T6T
 tlGHRjgtKdecfLk3jy7cjKonz0pNI1WNt2lKuMNRkbDJmIaRKM8m2/8xVWZzDajsnMGMXvY
 krktnhE0Sh3YtSzjN7Cnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CFfkFtnL14Y=;84EY34iKKLaXriJrsIfQZI+t09U
 jKxADtDcQ9rE8Pvm8qhCqpjUMRdnmNObLKZTX/gDnlcqYtNNDRf+Es+VoVTeES3JTAGmB0xJr
 +MJhqdt8x10CP0WSH3BuOem72KEnuixKiN3kaN0L3G7LuOcNVIjjLGE8Qj0TipaY956hEBf/l
 YCTM1zoC5vElh9ZanMAGwZgGHXRXb/OZ8C+0OTde37hQGiC6iCefcZdluWzScL9WQsga6d5XI
 WEaPoCHynBR6RQd7VpqwZU1jywl+Rns6pKtxWHjIZFI54fVrIiui6PwX34PMzWFWRI8P0SWmz
 gSrVzKgBCDzQBULXYF88bqBtHLlSvkA/KgjQw+orkb/SjiB16Rhs04DhsEAqF7EnS3zekEKxq
 MSJCeCSzBvQ6bjCKAbzxoj46ZsVGpwQBl/zsC6Xl8mlT6OLrbB35HokPGt+aV2vHhFTCAgL7L
 Hu9E1Ugy6opPd6Yz7qLWcQwBJMB5nwqeNKxpncR1paD+DoZ8Jf5mwjMfduzWeBgl9NSFTxO5r
 RJp63fNkOhWuCy2peI3X21owQdv1BV5Q+0S4VfYa71MujFUqtnWv9ZF5eb0+JwZNRIs4Wt5ki
 FhJlby4hOV65W+DBZmKPaV55NO6cXwDcvN5Doq7tFE7mWsSYPT6ndjisyjBE6B7VtVNfhHfCY
 rTAj9OXE3cfyr4Hsg6Fkywn2Ot+EPgRgHVU4+PiZPSm700NCaDzYVkFpwLs96grt8TZPjNm8v
 XuRp83A7emM5yH/WcfEENmpEIDwz9BpajAvOT+wRWylQhkFi+qLZue92VBGmtSuklEXy7N5xe
 eppcks/a9eF32eKtcf0wkI6bZReLmxFKE6ItmY1i7RsdQ=



=E5=9C=A8 2024/4/10 20:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Extent maps are used either to represent existing file extent items, or =
to
> represent new extents that are going to be written and the respective fi=
le
> extent items are created when the ordered extent completes.
>
> We currently don't have any limit for how many extent maps we can have,
> neither per inode nor globally. Most of the time this not too noticeable
> because extent maps are removed in the following situations:
>
> 1) When evicting an inode;
>
> 2) When releasing folios (pages) through the btrfs_release_folio() addre=
ss
>     space operation callback.
>
>     However we won't release extent maps in the folio range if the folio=
 is
>     either dirty or under writeback or if the inode's i_size is less tha=
n
>     or equals to 16M (see try_release_extent_mapping(). This 16M i_size
>     constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
>     extent_io and extent_state optimizations"), but there's no explanati=
on
>     about why we have it or why the 16M value.
>
> This means that for buffered IO we can reach an OOM situation due to too
> many extent maps if either of the following happens:
>
> 1) There's a set of tasks constantly doing IO on many files with a size
>     not larger than 16M, specially if they keep the files open for very
>     long periods, therefore preventing inode eviction.
>
>     This requires a really high number of such files, and having many no=
n
>     mergeable extent maps (due to random 4K writes for example) and a
>     machine with very little memory;
>
> 2) There's a set tasks constantly doing random write IO (therefore
>     creating many non mergeable extent maps) on files and keeping them
>     open for long periods of time, so inode eviction doesn't happen and
>     there's always a lot of dirty pages or pages under writeback,
>     preventing btrfs_release_folio() from releasing the respective exten=
t
>     maps.
>
> This second case was actually reported in the thread pointed by the Link
> tag below, and it requires a very large file under heavy IO and a machin=
e
> with very little amount of RAM, which is probably hard to happen in
> practice in a real world use case.
>
> However when using direct IO this is not so hard to happen, because the
> page cache is not used, and therefore btrfs_release_folio() is never
> called. Which means extent maps are dropped only when evicting the inode=
,
> and that means that if we have tasks that keep a file descriptor open an=
d
> keep doing IO on a very large file (or files), we can exhaust memory due
> to an unbounded amount of extent maps. This is especially easy to happen
> if we have a huge file with millions of small extents and their extent
> maps are not mergeable (non contiguous offsets and disk locations).
> This was reported in that thread with the following fio test:
>
>     $ cat test.sh
>     #!/bin/bash
>
>     DEV=3D/dev/sdj
>     MNT=3D/mnt/sdj
>     MOUNT_OPTIONS=3D"-o ssd"
>     MKFS_OPTIONS=3D""
>
>     cat <<EOF > /tmp/fio-job.ini
>     [global]
>     name=3Dfio-rand-write
>     filename=3D$MNT/fio-rand-write
>     rw=3Drandwrite
>     bs=3D4K
>     direct=3D1
>     numjobs=3D16
>     fallocate=3Dnone
>     time_based
>     runtime=3D90000
>
>     [file1]
>     size=3D300G
>     ioengine=3Dlibaio
>     iodepth=3D16
>
>     EOF
>
>     umount $MNT &> /dev/null
>     mkfs.btrfs -f $MKFS_OPTIONS $DEV
>     mount $MOUNT_OPTIONS $DEV $MNT
>
>     fio /tmp/fio-job.ini
>     umount $MNT
>
> Monitoring the btrfs_extent_map slab while running the test with:
>
>     $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
>                          /sys/kernel/slab/btrfs_extent_map/total_objects=
'
>
> Shows the number of active and total extent maps skyrocketing to tens of
> millions, and on systems with a short amount of memory it's easy and qui=
ck
> to get into an OOM situation, as reported in that thread.
>
> So to avoid this issue add a shrinker that will remove extents maps, as
> long as they are not pinned, and takes proper care with any concurrent
> fsync to avoid missing extents (setting the full sync flag while in the
> middle of a fast fsync). This shrinker is similar to the one ext4 uses
> for its extent_status structure, which is analogous to btrfs' extent_map
> structure.
>
> Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c5=
5e@amazon.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
[...]
> +
> +static unsigned long btrfs_scan_root(struct btrfs_root *root,
> +				     unsigned long *scanned,
> +				     unsigned long nr_to_scan)
> +{
> +	unsigned long nr_dropped =3D 0;
> +	u64 ino =3D 0;
> +
> +	while (*scanned < nr_to_scan) {
> +		struct rb_node *node;
> +		struct rb_node *prev =3D NULL;
> +		struct btrfs_inode *inode;
> +		bool stop_search =3D true;
> +
> +		spin_lock(&root->inode_lock);
> +		node =3D root->inode_tree.rb_node;
> +
> +		while (node) {
> +			prev =3D node;
> +			inode =3D rb_entry(node, struct btrfs_inode, rb_node);
> +			if (ino < btrfs_ino(inode))
> +				node =3D node->rb_left;
> +			else if (ino > btrfs_ino(inode))
> +				node =3D node->rb_right;
> +			else
> +				break;
> +		}
> +
> +		if (!node) {
> +			while (prev) {
> +				inode =3D rb_entry(prev, struct btrfs_inode, rb_node);
> +				if (ino <=3D btrfs_ino(inode)) {
> +					node =3D prev;
> +					break;
> +				}
> +				prev =3D rb_next(prev);
> +			}
> +		}

The "while (node) {}" loop and above "if (!node) {}" is to locate the
first inode after @ino (which is the last scanned inode number).

Maybe extract them into a helper, with some name like
"find_next_inode_to_scan()" could be a little easier to read?

> +
> +		while (node) {
> +			inode =3D rb_entry(node, struct btrfs_inode, rb_node);
> +			ino =3D btrfs_ino(inode) + 1;
> +			if (igrab(&inode->vfs_inode)) {
> +				spin_unlock(&root->inode_lock);
> +				stop_search =3D false;
> +
> +				nr_dropped +=3D btrfs_scan_inode(inode, scanned,
> +							       nr_to_scan);
> +				iput(&inode->vfs_inode);
> +				cond_resched();
> +				break;
> +			}
> +			node =3D rb_next(node);
> +		}
> +
> +		if (stop_search) {
> +			spin_unlock(&root->inode_lock);
> +			break;
> +		}
> +	}
> +
> +	return nr_dropped;
> +}
> +
> +static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
> +					    struct shrink_control *sc)
> +{
> +	struct btrfs_fs_info *fs_info =3D shrinker->private_data;
> +	unsigned long nr_dropped =3D 0;
> +	unsigned long scanned =3D 0;
> +	u64 next_root_id =3D 0;
> +
> +	while (scanned < sc->nr_to_scan) {
> +		struct btrfs_root *root;
> +		unsigned long count;
> +
> +		spin_lock(&fs_info->fs_roots_radix_lock);
> +		count =3D radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +					       (void **)&root, next_root_id, 1);
> +		if (count =3D=3D 0) {
> +			spin_unlock(&fs_info->fs_roots_radix_lock);
> +			break;
> +		}
> +		next_root_id =3D btrfs_root_id(root) + 1;
> +		root =3D btrfs_grab_root(root);
> +		spin_unlock(&fs_info->fs_roots_radix_lock);
> +
> +		if (!root)
> +			continue;
> +
> +		if (is_fstree(btrfs_root_id(root)))
> +			nr_dropped +=3D btrfs_scan_root(root, &scanned, sc->nr_to_scan);
> +
> +		btrfs_put_root(root);
> +	}
> +
> +	return nr_dropped;
> +}
> +
> +static unsigned long btrfs_extent_maps_count(struct shrinker *shrinker,
> +					     struct shrink_control *sc)
> +{
> +	struct btrfs_fs_info *fs_info =3D shrinker->private_data;
> +	const s64 total =3D percpu_counter_sum_positive(&fs_info->evictable_ex=
tent_maps);
> +
> +	/* The unsigned long type is 32 bits on 32 bits platforms. */
> +#if BITS_PER_LONG =3D=3D 32
> +	if (total > ULONG_MAX)
> +		return ULONG_MAX;
> +#endif

Can this be a simple min_t(unsigned long, total, ULONG_MAX)?

Another question is, since total is s64, wouldn't any negative number go
ULONG_MAX directly for 32bit systems?

And since the function is just a shrink hook, I'm not sure what would
happen if we return ULONG_MAX for negative values.

Otherwise the idea looks pretty good, it's just me not qualified to give
a good review.

Thanks,
Qu
> +	return total;
> +}
> +
> +int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info)
> +{
> +	int ret;
> +
> +	ret =3D percpu_counter_init(&fs_info->evictable_extent_maps, 0, GFP_KE=
RNEL);
> +	if (ret)
> +		return ret;
> +
> +	fs_info->extent_map_shrinker =3D shrinker_alloc(0, "em-btrfs:%s", fs_i=
nfo->sb->s_id);
> +	if (!fs_info->extent_map_shrinker) {
> +		percpu_counter_destroy(&fs_info->evictable_extent_maps);
> +		return -ENOMEM;
> +	}
> +
> +	fs_info->extent_map_shrinker->scan_objects =3D btrfs_extent_maps_scan;
> +	fs_info->extent_map_shrinker->count_objects =3D btrfs_extent_maps_coun=
t;
> +	fs_info->extent_map_shrinker->private_data =3D fs_info;
> +
> +	shrinker_register(fs_info->extent_map_shrinker);
> +
> +	return 0;
> +}
> +
> +void btrfs_unregister_extent_map_shrinker(struct btrfs_fs_info *fs_info=
)
> +{
> +	shrinker_free(fs_info->extent_map_shrinker);
> +	ASSERT(percpu_counter_sum_positive(&fs_info->evictable_extent_maps) =
=3D=3D 0);
> +	percpu_counter_destroy(&fs_info->evictable_extent_maps);
> +}
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index c3707461ff62..8a6be2f7a0e2 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -140,5 +140,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode =
*inode,
>   int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
>   				   struct extent_map *new_em,
>   				   bool modified);
> +int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info);
> +void btrfs_unregister_extent_map_shrinker(struct btrfs_fs_info *fs_info=
);
>
>   #endif
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 534d30dafe32..f1414814bd69 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -857,6 +857,8 @@ struct btrfs_fs_info {
>   	struct lockdep_map btrfs_trans_pending_ordered_map;
>   	struct lockdep_map btrfs_ordered_extent_map;
>
> +	struct shrinker *extent_map_shrinker;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;

