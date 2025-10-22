Return-Path: <linux-btrfs+bounces-18158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309FBFB22C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 11:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D3B1888E2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DF30149D;
	Wed, 22 Oct 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="R5m9jGom"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72F311C1B;
	Wed, 22 Oct 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124887; cv=none; b=e6QUJavZkz4LOn+KpG4mMkqAXa+SCgKj+2R1sFH3TbPYLe2AdJ9EubVG5WgvN4JSfBM8IwOwk7junj2hP+A3fJvpy//qPViigcdY5KMUSSFleIoqjXEybAo6dpE7+OpKep37siSA1IZi3PmtSs0l1+JnOiitNqxMLO5GnQaWuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124887; c=relaxed/simple;
	bh=1OIsnEGxlHugRCPOEP3sJwXtaxYn2QiI9y9VSB7uhLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSG4wf8avmzRHV3COZuHL4pwpZ6V/zDzw5/y4a/RVjj59Y94Ncu37rnsOz1mO73jBJUpoGZxNMf7BfNU16PWrS+TiFL+5xrT5CwUVcwps8P9m5NIXBsp2Ru8QLghTOuQTH37WSPEmZFcc1HoVCDzk3VxB+IQM8t27R0jE48XuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=R5m9jGom; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cs3Z76JTDz9sk9;
	Wed, 22 Oct 2025 11:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761124879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMrSmskdCHHFiz1x4aXeqxxIGXXyd3X4wrvhlDk0wn8=;
	b=R5m9jGomr+jqjgT01ZNW7lxf5GPQZYDpSieXfsHXFLzog8Q1IDpsOdO1mNJtTT9flV0wST
	vk23B/oNmOADxKboGyxLmlEkAF80vD2iRYPfiZt1rxCHHOHbnqtPr7AUdib2Um4zUrJ7fv
	O77acz2OmVBSjDNLc+X7zyfrFePF/dd359FTt/yjpI2zkNhEMxNUDkNttS+pb7fFQ0BhbM
	LeNvTN/mME1dL7ez/XxKfFr8gia66xQliwO4Y1fb3CYHNDuHhUL/GW8h+axEJ+UEeuDmqg
	WcRCzs4DFR9F9KaDQyYlzyZWd7bVBKpMQq2fymmnucg1Oqo3+2s3JQepMtbkCw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  johannes.thumshirn@wdc.com,  fdmanana@suse.com,  boris@bur.io,
  wqu@suse.com,  neal@gompa.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: declare free_ipath() via DEFINE_FREE() instead
In-Reply-To: <20251022073138.GX13776@twin.jikos.cz> (David Sterba's message of
	"Wed, 22 Oct 2025 09:31:38 +0200")
References: <20251021142749.642956-1-mssola@mssola.com>
	<20251021142749.642956-2-mssola@mssola.com>
	<20251022073138.GX13776@twin.jikos.cz>
Date: Wed, 22 Oct 2025 11:21:16 +0200
Message-ID: <87a51jqokz.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2025-10-22 09:31 +02:

> On Tue, Oct 21, 2025 at 04:27:46PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> This transforms the signature to __free_ipath() instead of the original
>> free_ipath(), but this function was only being used as a cleanup
>> function anyways. Hence, define it as a helper and use it via the
>> __free() attribute on all uses. This change also means that
>> __free_ipath() will be inlined whereas that wasn't the case for the
>> original one, but this shouldn't be a problem.
>>
>> A follow up macro like we do with BTRFS_PATH_AUTO_FREE() has been
>> discarded as the usage of this struct is not as widespread as that.
>
> The point of adding the macros or at least the freeing wrappers is to
> force the NULL initialization and to make it visible in the declarations
> (typed all in capitals). The number of use should not be the main factor
> and in this case it's 4 files.
>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>> ---
>>  fs/btrfs/backref.c | 10 +---------
>>  fs/btrfs/backref.h |  7 ++++++-
>>  fs/btrfs/inode.c   |  4 +---
>>  fs/btrfs/ioctl.c   |  3 +--
>>  fs/btrfs/scrub.c   |  4 +---
>>  5 files changed, 10 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index e050d0938dc4..a1456402752a 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -2785,7 +2785,7 @@ struct btrfs_data_container *init_data_container(u=
32 total_bytes)
>>   * allocates space to return multiple file system paths for an inode.
>>   * total_bytes to allocate are passed, note that space usable for actua=
l path
>>   * information will be total_bytes - sizeof(struct inode_fs_paths).
>> - * the returned pointer must be freed with free_ipath() in the end.
>> + * the returned pointer must be freed with __free_ipath() in the end.
>>   */
>>  struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *f=
s_root,
>>  					struct btrfs_path *path)
>> @@ -2810,14 +2810,6 @@ struct inode_fs_paths *init_ipath(s32 total_bytes=
, struct btrfs_root *fs_root,
>>  	return ifp;
>>  }
>>
>> -void free_ipath(struct inode_fs_paths *ipath)
>> -{
>> -	if (!ipath)
>> -		return;
>> -	kvfree(ipath->fspath);
>> -	kfree(ipath);
>> -}
>> -
>>  struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_inf=
o *fs_info)
>>  {
>>  	struct btrfs_backref_iter *ret;
>> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
>> index 25d51c246070..d3b1ad281793 100644
>> --- a/fs/btrfs/backref.h
>> +++ b/fs/btrfs/backref.h
>> @@ -241,7 +241,12 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root,=
 struct btrfs_path *path,
>>  struct btrfs_data_container *init_data_container(u32 total_bytes);
>>  struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *f=
s_root,
>>  					struct btrfs_path *path);
>> -void free_ipath(struct inode_fs_paths *ipath);
>> +
>> +DEFINE_FREE(ipath, struct inode_fs_paths *,
>> +	if (_T) {
>
> You can drop the if() as kvfree/kfree handles NULL pointers and we don't
> do that in the struct btrfs_path either.
>
>> +		kvfree(_T->fspath);
>> +		kfree(_T);
>> +	})
>>
>>  int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
>>  			  u64 start_off, struct btrfs_path *path,
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 79732756b87f..4d154209d70b 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -130,7 +130,7 @@ static int data_reloc_print_warning_inode(u64 inum, =
u64 offset, u64 num_bytes,
>>  	struct btrfs_fs_info *fs_info =3D warn->fs_info;
>>  	struct extent_buffer *eb;
>>  	struct btrfs_inode_item *inode_item;
>> -	struct inode_fs_paths *ipath =3D NULL;
>> +	struct inode_fs_paths *ipath __free(ipath) =3D NULL;
>
> I'd spell the name in full, like __free(free_ipath) or
> __free(inode_fs_paths) so it matches the type not the variable name.
>

The first option is not possible with __free as it would add "__free_"
automatically to the name. We'd need to go with __cleanup, and so it
would look like this:

     struct inode_fs_paths *ipath __cleanup(__free_ipath) =3D NULL;

Which is quite a mouthful :) So if you don't mind I'll go with the
second option you are suggesting for v2. Hence:

     struct inode_fs_paths *ipath __free(inode_fs_paths) =3D NULL;

>>  	struct btrfs_root *local_root;
>>  	struct btrfs_key key;
>>  	unsigned int nofs_flag;
>> @@ -193,7 +193,6 @@ static int data_reloc_print_warning_inode(u64 inum, =
u64 offset, u64 num_bytes,
>>  	}
>>
>>  	btrfs_put_root(local_root);
>> -	free_ipath(ipath);
>>  	return 0;
>>
>>  err:
>> @@ -201,7 +200,6 @@ static int data_reloc_print_warning_inode(u64 inum, =
u64 offset, u64 num_bytes,
>>  "checksum error at logical %llu mirror %u root %llu inode %llu offset %=
llu, path resolving failed with ret=3D%d",
>>  		   warn->logical, warn->mirror_num, root, inum, offset, ret);
>>
>> -	free_ipath(ipath);
>>  	return ret;
>>  }
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 692016b2b600..453832ded917 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3298,7 +3298,7 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_r=
oot *root, void __user *arg)
>>  	u64 rel_ptr;
>>  	int size;
>>  	struct btrfs_ioctl_ino_path_args *ipa =3D NULL;
>> -	struct inode_fs_paths *ipath =3D NULL;
>> +	struct inode_fs_paths *ipath __free(ipath) =3D NULL;
>>  	struct btrfs_path *path;
>>
>>  	if (!capable(CAP_DAC_READ_SEARCH))
>> @@ -3346,7 +3346,6 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_r=
oot *root, void __user *arg)
>>
>>  out:
>>  	btrfs_free_path(path);
>> -	free_ipath(ipath);
>>  	kfree(ipa);
>>
>>  	return ret;
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index fe266785804e..74d8af1ff02d 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -505,7 +505,7 @@ static int scrub_print_warning_inode(u64 inum, u64 o=
ffset, u64 num_bytes,
>>  	struct btrfs_inode_item *inode_item;
>>  	struct scrub_warning *swarn =3D warn_ctx;
>>  	struct btrfs_fs_info *fs_info =3D swarn->dev->fs_info;
>> -	struct inode_fs_paths *ipath =3D NULL;
>> +	struct inode_fs_paths *ipath __free(ipath) =3D NULL;
>>  	struct btrfs_root *local_root;
>>  	struct btrfs_key key;
>>
>> @@ -569,7 +569,6 @@ static int scrub_print_warning_inode(u64 inum, u64 o=
ffset, u64 num_bytes,
>>  				  (char *)(unsigned long)ipath->fspath->val[i]);
>>
>>  	btrfs_put_root(local_root);
>> -	free_ipath(ipath);
>>  	return 0;
>>
>>  err:
>> @@ -580,7 +579,6 @@ static int scrub_print_warning_inode(u64 inum, u64 o=
ffset, u64 num_bytes,
>>  			  swarn->physical,
>>  			  root, inum, offset, ret);
>>
>> -	free_ipath(ipath);
>>  	return 0;
>>  }
>>
>> --
>> 2.51.1
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmj4ogwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZRjrD/9yp6tG+OdiqUFP8k7DzzDAbEBaBbfr19PdTDWwpHfm+VXDmrW7o2olyY2/
2ii3N1nhF4vd29kC1NM17KMITUprs3HGrv3K3xeJC0vRvj8F/tulchTdcN7mIzPt
x85CrnZ8EEraFs6okd+ufvZSLl2VNIcAEouY9qrVyeaigQlC1qG4GzbTZ7pfNUCe
J5LT0esgaGOJjXlaIgTP+TPFhE3juULG1dGayaub48QxJfmN7VbrJRVvgEgcSjRE
E5QK5SXFNjymzAVuZtJLN5fifLK7HL6HKx1Y4oxfVFar9ta9RAEmmP1HxH9rIkwZ
jrX3lyHAmOoWwo6IdFf3lbsJjFWAn+x+04BKR9Z04OcVQLGRbANwj2QlxLfkGRYZ
eYG6cn19DwBJWwAuKESxRErnijOAQvJF4+GtPLEU4NFivxur8hfq5WM1GT/Gs6sN
DUdyVXXhgiQPcFXYBi9kk9Mq+Zf7Gj2pet9HGNVrX9kRVS+RZHTCr9D3NQyD9XoQ
KyFCS1+EBMXLzjzRjw/olri10Hy9UQUTqbbtTAxer/AOdMPsJGntQrQESz8/j/5N
jNfyo7m/dzSF9BO/e2jUmctPygb5DcsrOrwmvV3EAZsKBH5z4SHuMRUaQzOiF5Ni
yRo4Y1E2f9exjSymHzjr73pjk34bOKOPY+s0YyblKOTjvU+Dbg==
=Duv7
-----END PGP SIGNATURE-----
--=-=-=--

