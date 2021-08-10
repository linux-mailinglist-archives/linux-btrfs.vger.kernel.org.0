Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698793E86D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 01:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhHJXzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 19:55:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:46191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235508AbhHJXzH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 19:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628639680;
        bh=xqxPq8QSW2lge5VLhafsWX+I4Ty/wAK+JQrZStTFLOw=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Vi4bPfxoADkGBUfzzcHZghASdM+fQdUm9fWt3EYkmZIUAlD4ecM9SFAhVcApXmu/G
         WxvruFfsVJkuq/sdVTItE7B9+2qAx3JmEFAUFnMN1ISfbpW7pDVtjo3Kt3BevsHYQD
         GCETuxn06eWE4IFdlfa5AaxTAQt9yed3qBkqvXcE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1n0kNl2Ily-00x4J6; Wed, 11
 Aug 2021 01:54:40 +0200
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Trying to recover data from SSD
Message-ID: <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
Date:   Wed, 11 Aug 2021 07:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------92F7580D948FE395BD1D12A6"
Content-Language: en-US
X-Provags-ID: V03:K1:ZffaobnofCbUvZDcBTW6R9Wn3nVOvHyqiEvr4S7rhGdtgA1vncI
 weeiK/2zBk/8RQH5vX8ejQR1EIjMnAcdQdDSfxPMqd+ndg0af4fv10hqVJ1BVgb1EKvJX0Z
 SPqutgkG5iSMdeFrOPTfsEpEwCCG+TPL30SH3uPSpGWwe8XyTsowpPWo8R+X3/gWAPd96Pj
 6Sl9jgisDShq8DVrCVkpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3sE4ezjNqd0=:hNNVdPkGvC8r8Cb5d5d3jr
 /iJ0nlzqQNsEhAdh0PmnN7Eok7/BbsExUorqUP7fN46wK8yjH64Iu3HLfl3YXpoqO4xBoNJXX
 dh+FazAJwiuwBVpjySOkuqYFbIqDQ+72H9zXeRUgqOQxXxpmIhq1xEyotG67XQD/uttAAvOKu
 BiJXvo9waV12MQA9zeeGJODeM7jGJg3v103I9Wq4F8qPiUQN63n18DcSwVZjMAHzeMIv4Bvh7
 ss97vutX3shUnIkZ+fGKhkgEB2wzPU7qV3seXE3d/SigkBaA5ECN5XMXnDtqxyyfCeX0HQFxR
 QREgjWg4b+01MiQSsV/WCdQ/YemqOLG7X5IEEyIQm7ccT/1pttET0U7bGDaPOSKM6r3nsuU08
 9wqML20Bno9u6YTms7jQkqV8HGVxBXUZ7shnHS52YvaYsUaV+0b9CNW5YWtK7OkWKOlpOnZ1T
 l7HX7Vnn7xV07xPhUCEY/3GJ8d2dNIaspBkbO4JBOdwlkwPELVMRrEwdndDGcqLRUeeh4LFVh
 qflpiLRIcPYRGiAOGO/zvkptaJNL565PcjdCe0ffmJtPKfk40tN/QrUx1qHW0v5+0aRRWaVQY
 /cRj8XzkoC3lWLORCRM/U2vIEVZRp5Xsl2uluM/9KBC3P66L+5Lwkn6iRns34oWwXFWCvFbOp
 EehAGdE1vl+CQx6gpJb40fdh1WWfSnrrHx0EcXj1umhYujgHkF1hHJwnqWufQP9qOAyrvQi2a
 Q6DFvIUIY0KdIeo+CvmIpeJ6mReSG03cEO8681UZVOdpIRe32RyiCW7vkDKjCe/zuhg0VkytH
 fIfhnP3HhADsoRtnv6cvJgs1NPTGhbKk3nhFSOaNPc4+/ngcwdMkhWHVwCBGhgwg/Mm6XcQWt
 03rrIRud+ZVwMhGcWiFFr39aUFZ+a8A7lStGnYpO0l6KNptsYrkKd/zPtt+cvxQZLZ5Jap5HZ
 Q0Ium4QmWTKZPcjs++b97+4IUs27DCjhEoczVNdYF0NLH++k6MCba90ydpqLCcD1ge2zJ1+zW
 Kk93YieGF0Gmweevz62snGMIwTqTfE7jiv2dPAU9Hn43LWqLh8fa2W/D/XiAlyDR9U6mIhFOc
 3y2tXmCPYpzxRB+rgRbRyluFux+mlHhQQVoj+nQaI/8KI6P9OZfM/Fukg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------92F7580D948FE395BD1D12A6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/8/11 =E4=B8=8A=E5=8D=887:21, Konstantin Svist wrote:
> On 8/10/21 15:24, Qu Wenruo wrote:
>>
>> On 2021/8/11 =E4=B8=8A=E5=8D=8812:12, Konstantin Svist wrote:
>>>
>>>>> I don't know how to do that (corrupt the extent tree)
>>>>
>>>> There is the more detailed version:
>>>> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf5972=
99a@gmx.com/
>>>>
>>>
>>>
>>> So, here's what I get:
>>>
>>>
>>> # btrfs ins dump-tree -t root /dev/sdb3 |grep -A5 'item 0 key
>>> (EXTENT_TREE'
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff=
 15844 itemsize 439
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932 root_di=
rid 0 bytenr 786939904 level 2 refs 1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 0 byte_limit 0 b=
ytes_used 50708480 flags 0x0(none)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 uuid 00000000-0000-0000-0=
000-000000000000
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drop key (0 UNKNOWN.0 0) =
level 0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15=
405 itemsize 439
>>>
>>>
>>> # btrfs-map-logical -l 786939904 /dev/sdb3
>>>
>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>>> bad tree block 952483840, bytenr mismatch, want=3D952483840, have=3D0
>>> ERROR: failed to read block groups: Input/output error
>>> Open ctree failed
>>>
>>>
>>>
>>> Sooooo.. now what..?
>>>
>> With v5.11 or newer kernel, mount it with "-o rescue=3Dall,ro".
>
>
> Sorry, I guess that wasn't clear: that error above is what I get while
> trying to corrupt the extent tree as per your guide.

Oh, that btrfs-map-logical is requiring unnecessary trees to continue.

Can you re-compile btrfs-progs with the attached patch?
Then the re-compiled btrfs-map-logical should work without problem.

Thanks,
Qu

>
>
> That said, my kernel is 5.13.* (without your patch) and this mount
> command still fails as before
>
>

--------------92F7580D948FE395BD1D12A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-progs-map-logical-handle-corrupted-fs-better.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-btrfs-progs-map-logical-handle-corrupted-fs-better.patc";
 filename*1="h"

=46rom c3c0dd1c04e0f96ef3f6d72534e367482871bb31 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 11 Aug 2021 07:37:57 +0800
Subject: [PATCH] btrfs-progs: map-logical: handle corrupted fs better

Currently if running btrfs-map-logical on a filesystem with corrupted
extent tree, it will fail due to open_ctree() error.

But the truth is, btrfs-map-logical only requires chunk tree to do
logical bytenr mapping.

Make btrfs-map-logical more robust by:

- Loosen the open_ctree() requirement
  Now it doesn't require an extent tree to work.

- Don't return error for map_one_extent()
  Function map_one_extent() is too lookup extent tree to ensure there is
  at least one extent for the range we're looking for.

  But since now we don't require extent tree at all, there is no hard
  requirement for that function.
  Thus here we change it to return void, and only do the check when
  possible.

Now btrfs-map-logical can work on a filesystem with corrupted extent
tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-map-logical.c | 50 +++++++++++----------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index b35677730374..f06a612f6c14 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -38,8 +38,8 @@
  * */
 static FILE *info_file;
=20
-static int map_one_extent(struct btrfs_fs_info *fs_info,
-			  u64 *logical_ret, u64 *len_ret, int search_forward)
+static void map_one_extent(struct btrfs_fs_info *fs_info,
+			   u64 *logical_ret, u64 *len_ret, int search_forward)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -52,7 +52,7 @@ static int map_one_extent(struct btrfs_fs_info *fs_info=
,
=20
 	path =3D btrfs_alloc_path();
 	if (!path)
-		return -ENOMEM;
+		return;
=20
 	key.objectid =3D logical;
 	key.type =3D 0;
@@ -94,7 +94,11 @@ out:
 		if (len_ret)
 			*len_ret =3D len;
 	}
-	return ret;
+	/*
+	 * Ignore any error for extent item lookup, it can be corrupted
+	 * extent tree or whatever. In that case, just ignore the
+	 * extent item lookup and reset @ret to 0.
+	 */
 }
=20
 static int __print_mapping_info(struct btrfs_fs_info *fs_info, u64 logic=
al,
@@ -261,7 +265,8 @@ int main(int argc, char **argv)
 	radix_tree_init();
 	cache_tree_init(&root_cache);
=20
-	root =3D open_ctree(dev, 0, 0);
+	root =3D open_ctree(dev, 0, OPEN_CTREE_PARTIAL |
+				  OPEN_CTREE_NO_BLOCK_GROUPS);
 	if (!root) {
 		fprintf(stderr, "Open ctree failed\n");
 		free(output_file);
@@ -293,34 +298,7 @@ int main(int argc, char **argv)
 	cur_len =3D bytes;
=20
 	/* First find the nearest extent */
-	ret =3D map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
-	if (ret < 0) {
-		errno =3D -ret;
-		fprintf(stderr, "Failed to find extent at [%llu,%llu): %m\n",
-			cur_logical, cur_logical + cur_len);
-		goto out_close_fd;
-	}
-	/*
-	 * Normally, search backward should be OK, but for special case like
-	 * given logical is quite small where no extents are before it,
-	 * we need to search forward.
-	 */
-	if (ret > 0) {
-		ret =3D map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
-		if (ret < 0) {
-			errno =3D -ret;
-			fprintf(stderr,
-				"Failed to find extent at [%llu,%llu): %m\n",
-				cur_logical, cur_logical + cur_len);
-			goto out_close_fd;
-		}
-		if (ret > 0) {
-			fprintf(stderr,
-				"Failed to find any extent at [%llu,%llu)\n",
-				cur_logical, cur_logical + cur_len);
-			goto out_close_fd;
-		}
-	}
+	map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
=20
 	while (cur_logical + cur_len >=3D logical && cur_logical < logical +
 	       bytes) {
@@ -328,11 +306,7 @@ int main(int argc, char **argv)
 		u64 real_len;
=20
 		found =3D 1;
-		ret =3D map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
-		if (ret < 0)
-			goto out_close_fd;
-		if (ret > 0)
-			break;
+		map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
 		/* check again if there is overlap. */
 		if (cur_logical + cur_len < logical ||
 		    cur_logical >=3D logical + bytes)
--=20
2.32.0


--------------92F7580D948FE395BD1D12A6--
