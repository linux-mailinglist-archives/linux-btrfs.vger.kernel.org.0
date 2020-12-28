Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64202E6BEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 00:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgL1Wzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 17:55:50 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:46960 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729351AbgL1T7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 14:59:18 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id BF0681C8;
        Mon, 28 Dec 2020 20:58:35 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609185515;
        bh=yfQJ5X/aMZvinhsyuM4T36VUqR9Gi+c9e4IPJYmvJn4=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=FS/E5d6qY9MTaOsfnGS0uVgn4TORP/rBGR55GOtMZ4BHK7SJbRSnoS9f31P9QZ9Hf
         f0zYUciIp3V5lxeYPjTXeHFdMzkxhMaDsgHaG/XiYz6sPkE5ycxvdbGsXmAcsUmicF
         qd1A6zOSavfXQHyrQ5l2OOzfVstr1QdKf0CPCK9A=
MIME-Version: 1.0
Date:   Mon, 28 Dec 2020 19:58:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <1904ed2c92224d38747377b43e462353@lesimple.fr>
Subject: Re: 5.6-5.10 balance regression?
To:     "Qu Wenruo" <wqu@suse.com>, "David Arendt" <admin@prnet.org>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
References: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
 <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> I know it fails in relocate_block_group(), which returns -2, I'm curren=
tly=0A> adding a couple printk's here and there to try to pinpoint that b=
etter.=0A=0AOkay, so btrfs_relocate_block_group() starts with stage MOVE_=
DATA_EXTENTS, which=0Acompletes successfully, as relocate_block_group() r=
eturns 0:=0A=0ABTRFS info (device <unknown>): relocate_block_group: prepa=
re_to_realocate =3D 0=0ABTRFS info (device <unknown>): relocate_block_gro=
up loop: progress =3D 1, btrfs_start_transaction =3D ok=0A[...]=0ABTRFS i=
nfo (device <unknown>): relocate_block_group loop: progress =3D 168, btrf=
s_start_transaction =3D ok=0ABTRFS info (device <unknown>): relocate_bloc=
k_group: returning err =3D 0=0ABTRFS info (device dm-10): stage =3D move =
data extents, relocate_block_group =3D 0=0ABTRFS info (device dm-10): fou=
nd 167 extents, stage: move data extents=0A=0AThen it proceeds to the UPD=
ATE_DATA_PTRS stage and calls relocate_block_group()=0Aagain. This time i=
t'll fail at the 92th iteration of the loop:=0A=0ABTRFS info (device <unk=
nown>): relocate_block_group loop: progress =3D 92, btrfs_start_transacti=
on =3D ok=0ABTRFS info (device <unknown>): relocate_block_group loop: ext=
ents_found =3D 92, item_size(53) >=3D sizeof(*ei)(24), flags =3D 1, ret =
=3D 0=0ABTRFS info (device <unknown>): add_data_references: btrfs_find_al=
l_leafs =3D 0=0ABTRFS info (device <unknown>): add_data_references loop: =
read_tree_block ok=0ABTRFS info (device <unknown>): add_data_references l=
oop: delete_v1_space_cache =3D -2=0ABTRFS info (device <unknown>): reloca=
te_block_group loop: add_data_references =3D -2=0A=0AThen the -ENOENT goe=
s all the way up the call stack and aborts the balance.=0A=0ASo it fails =
in delete_v1_space_cache(), though it is worth noting that the=0AFS we're=
 talking about is actually using space_cache v2.=0A=0ADoes it help? Shall=
 I dig deeper?=0A=0ARegards,=0A=0ASt=C3=A9phane.
