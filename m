Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B24381429
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhENXTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 19:19:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:52553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENXTJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 19:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621034274;
        bh=xww6Xhfv6L/RbbyZ4Rkwm9W6eYZR8fnsjQvElpC8p78=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KmFkPtTcDNkZWGHqJ47gQCMQPh5vffs66OaXcklNqQ7J59HVDl6bsPJucSpr4sUcM
         2mnmCjvP0ONspaglYASuSQEBFljD+tY6MHIJxR59BQCZPJFp3HmQetqJLYDPTO9x3V
         GY4HiZlNvp94gLt3Xhl6I9OdK/MXwn5S3XdnpI5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6R1-1l7oHa25lT-00aIO4; Sat, 15
 May 2021 01:17:54 +0200
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210514113040.GV7604@twin.jikos.cz>
 <b2490ac7-7bb8-238c-1602-043bfcb09c8f@gmx.com>
 <20210514230554.GB7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2df5629d-cd3b-5da5-3917-ab66970cd8a0@gmx.com>
Date:   Sat, 15 May 2021 07:17:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514230554.GB7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ceel4W9rOhP5bXvJjPr+5mNPHaU1RTTk4x1n15RRuOQV2ei5aal
 GbtaQ6Sx/haGKnee0ld6K8nhHMzjHtjDhmYOWOWq4ztobUDZPcCR2WWKxdK5c31QRZ7kLuZ
 ey8hfP+jXdJfBI1AydP61WpYJtFsFZS3ocm75vB05wO5+WgwQ66U0+LNHWdbqzv9FJDWsZt
 /xDpaaq+cbPJo4ZOvWbMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KiAw5g9A/xU=:/Jb5ukah3X+NGkP8wZgaUh
 mnKEnUHipN3h0oUzdY6+dRSfm453qaRNbS0i6qGBqCfcHsSEclSMiFPkKEhecXuqm10vpHCL2
 T7Cx5S7lsNAm10gHDCEwvVciX/9ar3UcIpn0f5tWZaLTNoUtiF0oOEnkwoTYvRdYf7OfOpoxH
 NnalfP/bI3Gq8kAyQa1oArTOAJBWi4AGKZwGNtBvda4K/C8FWaeIgWlAXZQ68gfOuJTz28yOz
 yPk0CpDHnHItuFewl9VmxdrIzbB8AGotaNkG1eRnrmfqCHeuKSBBvtcUcSg4Oe2+uY6aanKDy
 2Bb1A19PE/UiZdsKmL8SAaXyuVCA2OEZkptJKs/YJcMKR8LYGMx0/RzxaY8KD099+wIZWa0PQ
 3pbyIbK7ULRzSBLG7gJaL/23as4Kl4+D2us9swAEjH506qpwCjZmo3d+K4BHfwXanLNUXeJVf
 hvyXQ2STjy8Vm9egG69ByaIP7M6QyCRqlS9gGwIc1wJwvHMobpM65dqs2frDdK3sEgiOHswI7
 5pQ3WfofltLEuyITeafOSBnHCRkL1leNUphVMjVNyWmL3W94OZSo680KWJ+jljvvMlPuNbDrk
 a86d14F2AWXP1J0eBskFZmiWQWXc89ZR3YWxnkPNCCxdWec+9wIurDW8Q+Ih6bVYvds9hWfE+
 dPLoSU7WoV/fcvCmrCyXkW1uPlq5X1h/FUxV65ZKehyZRRBx5edRpCOMkjY9ygK5GK7sDAuzj
 MKq0IiCI9CdXMgHdiebY3GiaCHIG8QEWIThYCv9CgN40U0Z7nYBVwj2neBe/1E2f+lEJCZd0R
 zUXvF7/bBSEy7oifb8rjdkm3GDz+BubUs1Kw1VGXoG1Wh8ZRtnriKdhki5nTSbJcPXgN6eame
 C9Yu6/OrNgNL+Fhn9TkHYFCiSGbfLmj39vH3UkgTXj1WHfmaatyV33eEHKvQp9mqWG9iEs/Od
 TISWrTseJ7Eyb+t+JUvPQ6Bf+ZFMvuppg/3t54xclG4IKL5zvJAXtAZEHGVwtNJi23ODz6nRd
 EsN6Vq9PN5VcDdOLMU18kH+jnEADESR3fab6qcfiT/XmoYcX7+MsOfNF0TOuAMqH1ICKt8DBm
 Ef8TRAr0Bk+zHEEDVqtBZKBgxlbDy1VYenYgSNgmRXwkjR0PGWBPcTlNWYr4MHqlnEy5KzAbc
 52o5Hxhhw3KNijzyy8m6E2orVdbIPtDaGzh8QR4boXGbsF6HKEZbpVjKmOTBrdvjpZghLTFBO
 brr1Y2XkJs51NVwMe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/15 =E4=B8=8A=E5=8D=887:05, David Sterba wrote:
> On Sat, May 15, 2021 at 06:45:42AM +0800, Qu Wenruo wrote:
>>> [27273.028163] general protection fault, probably for non-canonical ad=
dress 0x6b6b6b6b6b6b6a9b: 0000 [#1] PREEMPT SMP
>>> [27273.030710] CPU: 0 PID: 20046 Comm: fsx Not tainted 5.13.0-rc1-defa=
ult+ #1463
>>> [27273.032295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>>> [27273.034731] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [=
btrfs]
>>
>> It's in the new function introduced, and considering how few parametere=
s
>> are passed in, I guess it's really something wrong in the function,
>> other than some conflicts with other patches.
>>
>> Any line number for it?
>
> (gdb) l *(btrfs_lookup_first_ordered_range+0x46)
> 0x2366 is in btrfs_lookup_first_ordered_range (fs/btrfs/ordered-data.c:9=
60).
> 955              * and screw up the search order.
> 956              * And __tree_search() can't return the adjacent ordered=
 extents
> 957              * either, thus here we do our own search.
> 958              */
> 959             while (node) {
> 960                     entry =3D rb_entry(node, struct btrfs_ordered_ex=
tent, rb_node);
> 961
> 962                     if (file_offset < entry->file_offset) {
> 963                             node =3D node->rb_left;
> 964                     } else if (file_offset >=3D entry_end(entry)) {
>
> Line 960 and it's the rb_node.
>
Since I can't reproduce it locally yet, but according to the line
number, it seems to be something related to the node initialization,
which happens out of the spinlock.

Would you please try the following diff?

Thanks,
Qu

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4fa377da40e4..b1b377ad99a0 100644
=2D-- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -943,13 +943,14 @@ struct btrfs_ordered_extent
*btrfs_lookup_first_ordered_range(
                         struct btrfs_inode *inode, u64 file_offset, u64
len)
  {
         struct btrfs_ordered_inode_tree *tree =3D &inode->ordered_tree;
-       struct rb_node *node =3D tree->tree.rb_node;
+       struct rb_node *node;
         struct rb_node *cur;
         struct rb_node *prev;
         struct rb_node *next;
         struct btrfs_ordered_extent *entry =3D NULL;

         spin_lock_irq(&tree->lock);
+       node =3D tree->tree.rb_node;
         /*
          * Here we don't want to use tree_search() which will use
tree->last
          * and screw up the search order.
