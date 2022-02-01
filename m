Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4AC4A66E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 22:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiBAVSS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiBAVSR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 16:18:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D7C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 13:18:17 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u130so17016527pfc.2
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 13:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BXFWt0OO+pKW1VkO+hKNaIxgycAsUYwV5fx1Mi9+DPY=;
        b=dJT++MY3KsPmvlnjbTC3XJxAoCaLOEaxBK9a9YAIV1mcoTs65k5KVcisKE0XdFB0i+
         dG7ZgzOClfGwL5B8jF4746jXoDYGb3sOwBKn0kbvVFBys0BaemnWGc6PVMlWyqZjAoMk
         ASiGzevzXX5GBRKWr2spI7tNsp7HyMTsi4FmlbaV5UlmTHlWR853UknFPyj5H9Ot12HC
         iuwQGqFlVxmGwM4qz0GIpqVNve+senXuUm7JzaQiwHhbw62f0ZmqkvfRyNP4bQkKFODc
         latzheaHahjeFCzcYOqtca9EidqHpi8JMZGTB078DQmUN2YxH3suu8TTCrnQbsg9WwkM
         t6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BXFWt0OO+pKW1VkO+hKNaIxgycAsUYwV5fx1Mi9+DPY=;
        b=37EuChF1u+pBOHeFgGmL7aDVkQt8MoHo8J/7dcaoYLfndxB+CQDxb14SV6BtyKS04I
         RcxX4GPM7avLFfgitWFB5y9Ekm0jtVvMjQWfmzo33oSm00cNKy32S75CbuIDhnyvOUP6
         Yh2DkpfhBc0oExib5q5vtTLgLVqhs+vf9sOJKG2eJxJ817mexQYvIN1rxppCEnrICm40
         mCOf12YhhChlkzj2qEDeO3R1pByP1tSDQaJ6ewAQ1D4g5c7qZE6R7J2V5dEbMe5jjWWY
         5lU1aqwCRPpf5lPQecSQYROYuyubo6SuGUdbpPfzWVkMLdYMFtb+fXmxyUIrGZXEcwNX
         2Ypw==
X-Gm-Message-State: AOAM530ivkQ9gCVrCtzjiZJJm76Pw7gtVRqblgLryfsVcxKgxzYhLQwY
        NLA3/+9PSGWCBGCRLLiWuWpiXhenVMIsRKnNKxDt20mgrfnOcQ==
X-Google-Smtp-Source: ABdhPJxr+rnUdNYey8lFmOw2XhKSlaiEy9sGOaMrN6qxh3tX0gLTid51bMRjU3Qcj9ETdy4YDMKeEl4YeCBPdwx3nm0=
X-Received: by 2002:a05:6a00:10c6:: with SMTP id d6mr27069964pfu.42.1643750296921;
 Tue, 01 Feb 2022 13:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
In-Reply-To: <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Tue, 1 Feb 2022 22:18:05 +0100
Message-ID: <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Sure, I'll take the last 5.15 I used (5.15.13) as a base + the 2
> patches from this thread, is that good?
>    1-btrfs-dont-defrag-preallocated-extents.patch
>    2-defrag-limit-cluster-size-to-first-hole.patch
>
> Will post results tomorrow when it finishes compiling.

Tomorrow ended up taking a week, as it happens, sorry for that. No
significant difference compared to before:
https://i.imgur.com/BNoxixL.png

I'm not sure what we can infer from this, if I understood correctly
this should have shown similar amounts of I/O to 5.16 with all the
previous fixes, right?

I pasted the full diff I used at the end of this mail, since
`defrag_lookup_extent` changed signature between 5.15 and 5.16 I had
to do a couple of minor changes to get it to compile on 5.15.13.
Hopefully that was what you initially intended on testing.

Thanks,
Fran=C3=A7ois-Xavier

----

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cc61813213d8..07eb7417b6e7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1119,19 +1119,23 @@ static struct extent_map
*defrag_lookup_extent(struct inode *inode, u64 start)
 static bool defrag_check_next_extent(struct inode *inode, struct
extent_map *em)
 {
     struct extent_map *next;
-    bool ret =3D true;
+    bool ret =3D false;

     /* this is the last extent */
     if (em->start + em->len >=3D i_size_read(inode))
-        return false;
+        return ret;

     next =3D defrag_lookup_extent(inode, em->start + em->len);
     if (!next || next->block_start >=3D EXTENT_MAP_LAST_BYTE)
-        ret =3D false;
-    else if ((em->block_start + em->block_len =3D=3D next->block_start) &&
-         (em->block_len > SZ_128K && next->block_len > SZ_128K))
-        ret =3D false;
+        goto out;
+    if (test_bit(EXTENT_FLAG_COMPRESSED, &next->flags))
+        goto out;
+    if ((em->block_start + em->block_len =3D=3D next->block_start) &&
+     (em->block_len > SZ_128K && next->block_len > SZ_128K))
+        goto out;

+    ret =3D true;
+out:
     free_extent_map(next);
     return ret;
 }
@@ -1403,6 +1407,30 @@ static int cluster_pages_for_defrag(struct inode *in=
ode,

 }

+static u64 get_cluster_size(struct inode *inode, u64 start, u64 len)
+{
+    u64 cur =3D start;
+    u64 cluster_len =3D 0;
+    while (cur < start + len) {
+        struct extent_map *em;
+
+        em =3D defrag_lookup_extent(inode, cur);
+        if (!em)
+            break;
+        /*
+         * Here we don't do comprehensive checks, we just
+         * find the first hole/preallocated.
+         */
+        if (em->block_start >=3D EXTENT_MAP_LAST_BYTE ||
+            test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+            break;
+        cluster_len +=3D min(em->start + em->len - cur, start + len - cur)=
;
+        cur =3D min(em->start + em->len, start + len);
+    }
+    return cluster_len;
+}
+
+
 int btrfs_defrag_file(struct inode *inode, struct file *file,
               struct btrfs_ioctl_defrag_range_args *range,
               u64 newer_than, unsigned long max_to_defrag)
@@ -1531,6 +1559,13 @@ int btrfs_defrag_file(struct inode *inode,
struct file *file,
         } else {
             cluster =3D max_cluster;
         }
+        cluster =3D min_t(unsigned long,
+                get_cluster_size(inode, i << PAGE_SHIFT,
+                         cluster << PAGE_SHIFT)
+                    >> PAGE_SHIFT,
+                    cluster);
+        if (cluster =3D=3D 0)
+            goto next;

         if (i + cluster > ra_index) {
             ra_index =3D max(i, ra_index);
@@ -1557,6 +1592,7 @@ int btrfs_defrag_file(struct inode *inode,
struct file *file,
         balance_dirty_pages_ratelimited(inode->i_mapping);
         btrfs_inode_unlock(inode, 0);

+next:
         if (newer_than) {
             if (newer_off =3D=3D (u64)-1)
                 break;
