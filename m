Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD66E28FE04
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbgJPGF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 02:05:29 -0400
Received: from waffle.tech ([104.225.250.114]:50648 "EHLO mx.waffle.tech"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391456AbgJPGF3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 02:05:29 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Oct 2020 02:05:28 EDT
Received: from mx.waffle.tech (unknown [10.50.1.6])
        by mx.waffle.tech (Postfix) with ESMTP id 0FE036D800;
        Thu, 15 Oct 2020 23:59:20 -0600 (MDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.waffle.tech 0FE036D800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waffle.tech; s=mx;
        t=1602827960; bh=1SOOzZUEPtTZ1cEnxe0bGc3shN/MtTJj5BxDLkuKFFA=;
        h=Date:From:Subject:To:From;
        b=PlbrU3B6CT8RjpMdJ/M7nXuOu9O621r1CH8MWvVjO1gTc1tZBgPXmyR7gYSoPTUKK
         O1lUqbz38Fon9qmm3ufgI38jN3REKGaqmR6EpzLY6o2H/DV6H4O9utUpMpsSJoKHR0
         eAqD52P+9ZfSXvdTvEzTDQfyGTfCURvqo3I780gM=
Received: from waffle.tech ([10.50.1.3])
        by mx.waffle.tech with ESMTPSA
        id DiCbArg2iV+EXQcAQqPLoA
        (envelope-from <louis@waffle.tech>); Thu, 15 Oct 2020 23:59:20 -0600
MIME-Version: 1.0
Date:   Fri, 16 Oct 2020 05:59:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From:   louis@waffle.tech
Message-ID: <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
Subject: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
To:     linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.waffle.tech
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Balance RAID1/RAID10 mirror selection via plain round-robin scheduling. T=
his should roughly double throughput for large reads.=0A=0ASigned-off-by:=
 Louis Jencka <louis@waffle.tech>=0A---=0A fs/btrfs/volumes.c | 6 +++++-=
=0A 1 file changed, 5 insertions(+), 1 deletion(-)=0A=0Adiff --git a/fs/b=
trfs/volumes.c b/fs/btrfs/volumes.c=0Aindex 58b9c419a..45c581d46 100644=
=0A--- a/fs/btrfs/volumes.c=0A+++ b/fs/btrfs/volumes.c=0A@@ -333,6 +333,9=
 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)=0A 	r=
eturn &fs_uuids;=0A }=0A =0A+/* Used for round-robin balancing RAID1/RAID=
10 reads. */=0A+atomic_t rr_counter =3D ATOMIC_INIT(0);=0A+=0A /*=0A  * a=
lloc_fs_devices - allocate struct btrfs_fs_devices=0A  * @fsid:		if not N=
ULL, copy the UUID to fs_devices::fsid=0A@@ -5482,7 +5485,8 @@ static int=
 find_live_mirror(struct btrfs_fs_info *fs_info,=0A 	else=0A 		num_stripe=
s =3D map->num_stripes;=0A =0A-	preferred_mirror =3D first + current->pid=
 % num_stripes;=0A+	preferred_mirror =3D first +=0A+	    (unsigned)atomic=
_inc_return(&rr_counter) % num_stripes;=0A =0A 	if (dev_replace_is_ongoin=
g &&=0A 	    fs_info->dev_replace.cont_reading_from_srcdev_mode =3D=3D
