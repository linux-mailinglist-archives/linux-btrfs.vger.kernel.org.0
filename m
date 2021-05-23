Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B738DDAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 01:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhEWXLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 19:11:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:58179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231980AbhEWXLK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 19:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621811376;
        bh=wgm0hx6bOSFylDtE3c+PpbLmjA7hGUlRIIETUjLfbqw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XH5IH4/8DySf8TzfK19/ZSPKwSoiNSzhdcAq9nDy4+9UWrmpvWSFSjZKjVdVjpzbu
         oW5SRreVOUS13jt+SdAvWy/bDsLiK3q+n9GZOMkAZ4/nVPuTR2G61EDZEtNhPJsEET
         lcdihu4I6ZloomIJ6J1t3jgYWFyZib6lTI+1ACXA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGrE-1lwQtN2tZu-00Ygxh; Mon, 24
 May 2021 01:09:36 +0200
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
To:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <92273193-366c-8121-c2f6-26c885d77ead@gmx.com>
Date:   Mon, 24 May 2021 07:09:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LMsGORpB/Q+qa+xGJeJM3lf8nAXf9V2MzOYE6UkzKHAOiy77Wgk
 gTolN/QKuWwFztAZSz4zgw4cceaP+y770p6BC9xqYM04RHSVvuoSRvYtB+ubtgOmqowBnHf
 Swu4mlOxev7UhhkozHmx69YrtcDTJaNontZlFnRAH2Gb9WdOF90v+NV9Hr6JOughSz+xXL7
 JbQBx2wkboci0lEgtH6Hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H1yBGpl2Bg4=:P4cqTVcD0tZIzx6L/O34io
 fzPlZ6DjO8u84KwSEchme0ginm2lRtAeLxdVs9fKVrxZus5XE/fcBq8HJduQQghzufrMK9dO0
 8r5crJ1tMCE/nptkLGJp2mlQX8Mx247XaEshWBvxCnqVbz1tqR8ffpnzoBAA2VWlbWaz7TQuV
 cGbQsGF6Kn9y8KyPilzkjKcLzwXRlioI5Ibg//1/B4lRwGDmrM2Tcns1rxAPXtwSsa2172ztz
 Ei9HD0S4rxQXVZHg2nLtQJOIbpe1P7eQOqjQGtNnhZYmPLmjGao2xl2u4feOlQepIHspBJkBh
 16IrdRDV5nFGTiY4WyI1jRHUTT+OMp+d0JQ8DWAx0uhWIlx1F9tq5QcfauYSQphMCTsMbFwy7
 aI3093NSCQM4l8Ilw6rgHHxCFxQvetVb/H6PzEbhTMTIiLZ2kkiSXuu5QqhKXcXbL5C8qw60V
 k5qONuyNBo94g/6V9cQb+6Sj8v6G7SII/zDwYmQJJE8LyViIbBdCm+cSVB3tky9zzGeChPYgI
 hK3xAOI8UaY5CZLDxJHUHn+2VaEzdgAimKLbLMjnIT4zcZisoA08W6OkZeu29ICmzfUIfzgjB
 F+pd8VTe4sAXYJfjXRcyERw+WSS21vOeyqstf9SvSA7gzSD0BodqrkR/gZBSG0mJM02a9qVAI
 esAhVjU00Tu2mqPnfSdyvDzKeIjCQ+D8yOitkdOy55DVic1jGPmOfgnj1x4/AJqIj9/SlnH4v
 pjou/P6RVXbwKIsGOgRJc8GlQjgtKX3Ou+KZLH8K0DK4UaILGDdLe5V9N1GDw2gCrIcxdcGvP
 hejtZtZR7rRdSGgmlKalDyXKm5IfR5lFWolG1JqsuDKddYFHORSJB1O1J0XdjWydm7BKiwAK8
 FOVQar677PuNxywODQuOeBxnOYdNBpP1IyeDmzWIyjW7pTtbM9crkbDLiRrOzAmiRJEOEQlli
 DfvflYFc5w+e1RmjL6r7JKjpjD8sMa06aTCZk1PNuBZLkZG4CX8J+MWbRga1Li3bRyoghBYI0
 4PzVWEQ+H5jOtmKKlVKEsgUIys80Gl3SJi0/WmW0fg8ruo5U/RF9/jQPd0HRx+CQlDpP4lHs9
 y6OmS9ffZhUuLmS9+Vz8VkjKXtea2VgRSao+CYroMcqZwpb/F0EZqtikQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/23 =E4=B8=8B=E5=8D=8810:13, Josef Bacik wrote:
> On 5/18/21 11:40 AM, Johannes Thumshirn wrote:
>> When multiple processes write data to the same block group on a
>> compressed
>> zoned filesystem, the underlying device could report I/O errors and dat=
a
>> corruption is possible.
>>
>> This happens because on a zoned file system, compressed data writes whe=
re
>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
>> operation. But with REQ_OP_WRITE and parallel submission it cannot be
>> guaranteed that the data is always submitted aligned to the underlying
>> zone's write pointer.
>>
>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zon=
ed
>> filesystem is non intrusive on a regular file system or when
>> submitting to
>> a conventional zone on a zoned filesystem, as it is guarded by
>> btrfs_use_zone_append.
>>
>> Reported-by: David Sterba <dsterba@suse.com>
>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat flag=
")
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> This one is causing panics with btrfs/027 with -o compress.=C2=A0 I bise=
cted
> it to something else earlier, but it was still happening today and I
> bisected again and this is what popped out.=C2=A0 I also went the extra =
step
> to revert the patch as I have already fucked this up once, and the
> problem didn't re-occur with this patch reverted.=C2=A0 The panic looks =
like
> this
>
> May 22 00:33:16 xfstests2 kernel: BTRFS critical (device dm-9): mapping
> failed logical 22429696 bio len 53248 len 49152

This is the interesting part, it means we are just one sector beyond the
stripe boundary.
Definitely a sign of changed bio submission timing.

Just like the code:

+		if (pg_index =3D=3D 0 && use_append)
+			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
+		else
+			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);
+
  		page->mapping =3D NULL;
-		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
-		    PAGE_SIZE) {
+		if (submit || len < PAGE_SIZE) {

The code has changed the timing of bio_add_page().

Previously, if we have submit =3D=3D true, we won't even try to call
bio_add_page().

But now, we will add the page even we're already at the stripe boundary,
thus it causes the extra sector being added to bio, and crosses stripe
boundary.

This part is already super tricky, thus I refactored
submit_extent_page() to do a better job at stripe boundary calculation.

We definitely need to make other bio_add_page() callers to use a better
helper, not only for later subpage, but also to make our lives easier.

Thanks,
Qu
> May 22 00:33:16 xfstests2 kernel: ------------[ cut here ]------------
> May 22 00:33:16 xfstests2 kernel: kernel BUG at fs/btrfs/volumes.c:6643!
> May 22 00:33:16 xfstests2 kernel: invalid opcode: 0000 [#1] SMP NOPTI
> May 22 00:33:16 xfstests2 kernel: CPU: 1 PID: 2236088 Comm: kworker/u4:4
> Not tainted 5.13.0-rc2+ #240
> May 22 00:33:16 xfstests2 kernel: Hardware name: QEMU Standard PC (Q35 +
> ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> May 22 00:33:16 xfstests2 kernel: Workqueue: btrfs-delalloc
> btrfs_work_helper
> May 22 00:33:16 xfstests2 kernel: RIP: 0010:btrfs_map_bio.cold+0x58/0x5a
> May 22 00:33:16 xfstests2 kernel: Code: 50 e8 6b 83 ff ff e8 5b 0d 88 ff
> 48 83 c4 18 e9 94 8f 88 ff 48 8b 3c 24 4c 89 f1 4c 89 fa 48 c7 c6 f8 db
> 62 96 e8 47 83 ff ff <0f> 0b 4c 89 e7 e8 52 1f 83 ff e9 03 98 88 ff 49
> 8b 7a 50 44 89 f2
> May 22 00:33:16 xfstests2 kernel: RSP: 0018:ffffb310c1de7c88 EFLAGS:
> 00010282
> May 22 00:33:16 xfstests2 kernel: RAX: 0000000000000055 RBX:
> 0000000000000000 RCX: 0000000000000000
> May 22 00:33:16 xfstests2 kernel: RDX: ffff9b9a7bd27540 RSI:
> ffff9b9a7bd18e10 RDI: ffff9b9a7bd18e10
> May 22 00:33:16 xfstests2 kernel: RBP: ffff9b9a482ad7f8 R08:
> 0000000000000000 R09: 0000000000000000
> May 22 00:33:16 xfstests2 kernel: R10: ffffb310c1de7a48 R11:
> ffffffff96973748 R12: 0000000000000000
> May 22 00:33:16 xfstests2 kernel: R13: ffff9b9a001e7300 R14:
> 000000000000d000 R15: 0000000001564000
> May 22 00:33:16 xfstests2 kernel: FS:=C2=A0 0000000000000000(0000)
> GS:ffff9b9a7bd00000(0000) knlGS:0000000000000000
> May 22 00:33:16 xfstests2 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> May 22 00:33:16 xfstests2 kernel: CR2: 00005621fe4566e0 CR3:
> 000000013943a005 CR4: 0000000000370ee0
> May 22 00:33:16 xfstests2 kernel: Call Trace:
> May 22 00:33:16 xfstests2 kernel:
> btrfs_submit_compressed_write+0x2d7/0x470
> May 22 00:33:16 xfstests2 kernel:=C2=A0 submit_compressed_extents+0x364/=
0x420
> May 22 00:33:16 xfstests2 kernel:=C2=A0 ? lock_acquire+0x15d/0x380
> May 22 00:33:16 xfstests2 kernel:=C2=A0 ? lock_release+0x1cd/0x2a0
> May 22 00:33:16 xfstests2 kernel:=C2=A0 ? submit_compressed_extents+0x42=
0/0x420
> May 22 00:33:16 xfstests2 kernel:=C2=A0 btrfs_work_helper+0x133/0x520
> May 22 00:33:16 xfstests2 kernel:=C2=A0 process_one_work+0x26b/0x570
> May 22 00:33:16 xfstests2 kernel:=C2=A0 worker_thread+0x55/0x3c0
> May 22 00:33:16 xfstests2 kernel:=C2=A0 ? process_one_work+0x570/0x570
> May 22 00:33:16 xfstests2 kernel:=C2=A0 kthread+0x134/0x150
> May 22 00:33:16 xfstests2 kernel:=C2=A0 ? __kthread_bind_mask+0x60/0x60
> May 22 00:33:16 xfstests2 kernel:=C2=A0 ret_from_fork+0x1f/0x30
>
> Thanks,
>
> Josef
