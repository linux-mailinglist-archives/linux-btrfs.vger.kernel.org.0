Return-Path: <linux-btrfs+bounces-6934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F5943958
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 01:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0EAB2225C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B0D16DC2E;
	Wed, 31 Jul 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jzwf/c6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89E3A1A8
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467990; cv=none; b=KAM8uIfUmPSu+wnYNWZYrgpU+VXyw53qFN1vl+L9zqv0dWlIKrirmxBwCgy5DUlC+hBRqdK5uImAcycdwAJ+ApYVIS6oAr6oeXjo3NTbixnCJiA0Tk7m1y1kFgBR/kxd3ERBe1fEa34Hvs8c0nqZUSCUBtLhGro5SZ0AjbE4QWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467990; c=relaxed/simple;
	bh=JSAMr1NEtGLs3fXIy3LEONPhheJ9b1LYLJ1o/5xVA60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVKAoZHQp9zUPOglHQtHqAIanuldMTxdnLX9lNefDOgJDmzqDTJ9KG8xh+YDMIbOE4fj1qLY1Sf7t5XvcNdF+6ao53H/Vc3lJ5z7pQ6XC4RNMHYFjXB4hhptkEJmBVmUSIkaAE3oNlnLwNwMAcylUKzssKU7zP5n9z1nGIDZs0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jzwf/c6U; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722467982; x=1723072782; i=quwenruo.btrfs@gmx.com;
	bh=K71om96ehID0mb0FpBXBU4FjVGrzLOD9JUgDESWKAgk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jzwf/c6Uq094zhYMOOGpw21e83+TB/g3guthbG3cPYzXrLP2HqpFfIHk3Gfryead
	 v8VsS36ykw61HyyfxgK3491Y92SkBr3oo2aAgPOawOP/BuvnEF9GQY/pVRwBuoWWB
	 pGjUK4/jg3JwO5wONBYVyL2AOmERGwWE8p9nIBiB4Dgv3/kAhrZH4KFAeniswfWUj
	 mNQD9D25HLf3+SIZQs4uGNpTfxMMDmwDnztlkbN7kxNv3Zqq10M1fqjyz6kC6DCXe
	 z01GnOInwDP8N+9q6mZn8BybtTWhtBkmmDmiV1KQfpQY87BGUuVIqGXsZ8x/UZn6+
	 yJO4iD0u4d+P39CRSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdefD-1s0Eu43UXZ-00lx9T; Thu, 01
 Aug 2024 01:19:42 +0200
Message-ID: <dd3444f9-c8be-46e7-97b1-8f95a161c709@gmx.com>
Date: Thu, 1 Aug 2024 08:49:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs-progs: mkfs: rework how we traverse rootdir
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1722418505.git.wqu@suse.com>
 <667ee4f02fdc2cb6f186eb8b06dd089f3ce53141.1722418505.git.wqu@suse.com>
 <20240731225935.GB3808023@zen.localdomain>
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
In-Reply-To: <20240731225935.GB3808023@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:It9OxwfNQOEepxeAGbPIS2z1NaYCPgE5hfsLFUBvjJhxq+t4EQs
 mW5ysUiaHJci59JmTKUmNmYQtnt1SW6wx1k8VqW68Rqn9fJYkqSfHKDVuDinfgEqAfT1knK
 vAd7LRfhb3tgdlDpf+BuxFMwJSX6I09Zs2cLyLzsj3Ck+vjMeO2+Pndut2ln9yRAP0/JTVS
 Z66tJkPesOMxlJPp29oRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bbr28gVLV8Y=;ei9Z01PvwM2fhmNzgvS3wc8B6VH
 vXlc5LWnanZ0WpP0E7KX/whcOjbAmRutYFdmXpmGho0Kd3WqQ1IqjllHQIxtN7fJlGkGACeDI
 jxHT+aFxuK+/1jwMtbOU/11HtFwgDRNAIf+ieth4ucLqFjDY7z73BlewAsJL5Depdv5ircXYG
 sR5J1aeVUbfx0UHz6fh9KW3SBql37oR+vDxuhF5L7+lxwSofmOxovlrVi+x0Y6oYXiwiRJxRM
 wlm6kKtj5Qk5RbjvNKQGKboPlDb3sdVK99jp53VRKAEqlyU7hcQV8C5BZPCNnRv/+56GDZrB7
 1heMV7mhuwlnGCtCHzIHHhMD0APcadS6VAJkHpQNHh5T783OP+r6HjkPYyRex3rjMFna72WrX
 ZdsZ4oUeTqPEn4T85mD0p3GCPV0WhiatCTbHrDPmvtjnOO7vLwBd6QOq5r7/bXPeORo+K6zjO
 e+7LseQWa43QQptUIlXHnbYy3yPKxd5+wD5D6sVubxkZEP4J0LF3WTfuokPmyxhMYQ2MLmtDG
 bd+uOglIhHFq/Fu3QoH38v0wQiaIHsDchrRXQ8PdwERdcay0iIuaLacZIW0OAbcWPoWXrG7Oi
 d3PgTvOwxTM1/ATVQfx0ZnCCFPryUBePDYhx9OQZUC2lUvtFLDR9UgLV1jYL5Y/WpsEfXDx7L
 q8OlOMIQRN/G/p6zg85DP9FbkSdbP8zfpvg/9jfpTd80a71sduj73Gn9LVZJ+d4uMilUgFcMr
 BTjjr0DseVai6kNy1ZcVXkX8XNvSbphptj+9Lps+fGyo6/CWI4LRNyUBcryShNesPKAHDBzJY
 9dZ2XJFI9tMGUCJekrgOt0Ag==



=E5=9C=A8 2024/8/1 08:29, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Jul 31, 2024 at 07:08:47PM +0930, Qu Wenruo wrote:
>> There are several hidden pitfalls of the existing traverse_directory():
>>
>> - Hand written preorder traversal
>>    Meanwhile there is already a better written standard library functio=
n,
>>    nftw() doing exactly what we need.
>
> This is great!
>
>>
>> - Over-designed path list
>>    To properly handle the directory change, we have structure
>>    directory_name_entry, to record every inode until rootdir.
>>
>>    But it has two string members, dir_name and path, which is a little
>>    overkilled.
>>    As for preorder traversal, we will never need to read the parent's
>>    filename, just its inode number.
>>
>>    And it's exported while no one utilizes it out of mkfs/rootdir.c.
>>
>> - Weird inode numbers
>>    We use the inode number from st->st_ino, with an extra offset.
>>    This by itself is not safe, if the rootdir has child directory in
>>    another filesystem.
>
> Can you explain what you mean by not safe? As far as I can tell, the
> +256 is to handle that particular invariant of btrfs. Are you worried
> about duplicate inode numbers in the vein of the usual st_dev/st_ino
> debates?

I'm worried about this case:

rootdir (on fs1)
|- dir1
|  |- file1 (fs1, ino 1024)
|- dir2 (on fs2)
    |- file2 (fs2, ino 1024)

We do not have any cross mount point checks.

I created a case like this:

# fallocate -l 1G 1.img
# fallocate -l 1G 2.img
# mkfs.ext4 1.img
# mkfs.ext4 2.img
# mount 1.img mnt
# mkdir mnt/dir1 mnt/dir2
# touch mnt/dir1/file1 mnt/file1
# umount mnt
# mount 2.img mnt
# mkdir mnt/dir1 mnt/dir2
# touch mnt/dir1/file1 mnt/file1
# umount mnt
# mkdir rootdir
# mount 1.img rootdir
# mount 2.img rootdir/dir2
# mkfs.btrfs -f --rootdir rootdir test.img
ERROR: item file1 already exists but has wrong st_nlink 1 <=3D 1
ERROR: unable to traverse directory rootdir/: 1
ERROR: error while filling filesystem: 1

And it failed as expeceted.

>
> In that case, if this is a bugfix, I think it makes sense to write a
> regression test that highlights it. It would be nice to pull the fix
> out of the refactor, too, but I suppose that with such a deep refactor,
> that might not be possible/worth it.

Unfortunately I didn't even notice how serious these problems are, until
I tried...

Will add two new test cases. One is the above one, the other is the
hardlink out of rootdir bug I mentioned in 3/3.

>
>>
>>    And this results very weird inode numbers, e.g:
>>
>> 	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>> 	item 6 key (88347519 INODE_ITEM 0) itemoff 15815 itemsize 160
>> 	item 16 key (88347520 INODE_ITEM 0) itemoff 15363 itemsize 160
>> 	item 20 key (88347521 INODE_ITEM 0) itemoff 15119 itemsize 160
>> 	item 24 key (88347522 INODE_ITEM 0) itemoff 14875 itemsize 160
>> 	item 26 key (88347523 INODE_ITEM 0) itemoff 14700 itemsize 160
>> 	item 28 key (88347524 INODE_ITEM 0) itemoff 14525 itemsize 160
>> 	item 30 key (88347557 INODE_ITEM 0) itemoff 14350 itemsize 160
>> 	item 32 key (88347566 INODE_ITEM 0) itemoff 14175 itemsize 160
>>
>>    Which is far from a regular fs created by copying the data.
>
> +1, especially since it doesn't even *preserve* the inode numbers, which
> would be a comprehensible (if not working) behavior. Creating the oids
> in "btrfs order" seems like a nice improvement!
>
>>
>> - Weird directory inode size calculation
>>    Unlike kernel, which updated the directory inode size every time new
>>    child inodes are added, we calculate the directory inode size by
>>    searching all its children first, then later new inodes linked to th=
is
>>    directory won't touch the inode size.
>>
>> Enhance all these points by:
>>
>> - Use nftw() to do the preorder traversal
>>    It also provides the extra level detection, which is pretty handy.
>>
>> - Use a simple local inode_entry to record each parent
>>    The only value is a u64 to record the inode number.
>>    And one simple rootdir_path structure to record the list of
>>    inode_entry, alone with the current level.
>>
>>    This rootdir_path structure along with two helpers,
>>    rootdir_path_push() and rootdir_path_pop(), along with the
>>    preorder traversal provided by nftw(), are enough for us to record
>>    all the parent directories until the rootdir.
>>
>> - Grab new inode number properly
>>    Just call btrfs_get_free_objectid() to grab a proper inode number,
>>    other than using some weird calculated value.
>>
>> - Use btrfs_insert_inode() and btrfs_add_link() to update directory
>>    inode automatically
>>
>> With all the refactor, the code is shorter and easier to read.
>
> Agreed on all counts, I think this is a lovely refactor.
>
> For a change of this magnitude, I think it is helpful to justify the
> correctness of the change by documenting the testing plan. Are there
> existing unit tests of mkfs that cover all the cases we are modifying
> here?

We have existing rootdir test cases, from the regular functional tests,
to corner cases.

But we lack corner cases of corner cases, like duplicating inode number
(cross mnt) and hard links.

> Is there some --rootdir master case that covers everything?

It's inside tests/mkfs-tests/

A quick grep shows:

004-rootdir-keeps-size
009-special-files-for-rootdir
011-rootdir-create-file
012-rootdir-no-shrink
014-rootdir-inline-extent
016-rootdir-bad-symbolic-link
021-rfeatures-quota-rootdir
022-rootdir-size
027-rootdir-inode


> Is it
> in fstests? Knowing that all of the new code has at least run correctly
> would go a long way to feeling confident in the details of the
> transformation.

We have btrfs-progs github CI, runs the all the selftests on each PR.
And it's all green (except a typo caught by code spell).

[...]
>> -	parent_inum =3D highest_inum + BTRFS_FIRST_FREE_OBJECTID;
>> -	dir_entry->inum =3D parent_inum;
>> -	list_add_tail(&dir_entry->list, &dir_head->list);
>> +	/*
>> +	 * If our path level is higher than this level - 1, this means
>> +	 * we have changed directory.
>> +	 * Poping out the unrelated inodes.
>
> Popping

Exposed by the CI, and fixed immediately in github.

>
> Also, this took me like 15 minutes of working examples to figure out why
> it worked. I think it could definitely do with some deeper explanation
> of the invariant, like:
>
> ftwbuf->level - 1 is the level of the parent of the current traversed
> inode. ftw will traverse all inodes in a directory before leaving it,
> and will never traverse an inode without first traversing its dir,
> so if we see a level less than or equal to the last directory we saw,
> we are finished with that directory and can pop it.
>
> Perhaps with an annotated drawing like:
>
> 0: /
> 1:         /foo/
> 2:                 /foo/bar/
> 3:                         /foo/bar/f
> 2:                 /foo/baz/            POP! 2 > (2 - 1); done with /foo=
/bar/
> 3:                         /foo/baz/g
> 1:         /h                           POP! 2 > (1 - 1); done with /foo=
/baz/
>
> To help make it clearer. I honestly even think just changing to >=3D mak=
es
> it clearer? Not sure about that.

I'll add comments with an example to explain the workflow.

BTW, David and I are working with Github review system a lot recently:
https://github.com/kdave/btrfs-progs/pull/855

We do not force anyone to use specific system to do anything, but you
may find it a little easier to comment, and feel free to fall back to
the mail based review workflow at any time.

Thanks a lot for the detailed review!
Qu

