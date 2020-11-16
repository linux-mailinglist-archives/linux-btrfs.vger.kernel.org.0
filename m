Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD182B3B45
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 03:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKPCKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Nov 2020 21:10:02 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:36410 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgKPCKC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Nov 2020 21:10:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 5B0FCCFC;
        Mon, 16 Nov 2020 03:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        references:message-id:content-transfer-encoding:date:date
        :in-reply-to:from:from:subject:subject:mime-version:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1605492598; x=1607306999; bh=clUkb72Rh6MbBBP4HE/HwbJQG8TQgs7k5BU
        4aoUhJnM=; b=p8C1MPW9Eb9m2T6noNb+4Fc6ZoBZGFyHftNabf10BYTJI3++M71
        qB7sVaDZVXP8S22Q720JlyAnOMFL5wq/K+jdHp9cpsGvedBHnFuecMOzBuFjpAps
        x41CnTNLzVCHV1hsWpf9I5ApA9C+u/gUlbh1YBV5XQaSWSNVV/U+QA4yYsY59wmK
        m3Z/8JDFUTZxTJLyF33w74aw+VUdFFYcKnO9/nVK4KBLYXZNOIoqADi9idQ3jwd1
        +K+ekUAWjvuB5TK337mdYDR27Q5n17jHedFmNpnNwKirSzncptcVZnvEdouutTcn
        +pcPM9VY0Fj+PnCLrG9eTyJtaqHzwp7Sy86aw+DCl7WMzgoF0kxP5U3iJpsVIkD/
        XwSWnvPwcxY0lEO/Xyrq8UBUBoilhuLbt/IcsZ9UvqsMDWUEsQ9h+K1U4dY6vClE
        EBAt/vb2ULJzNoVb3jFCnZ9NvcLov0yASNCJz+b13MHT465zkxU4DXW7dVeqF26U
        aCNerG2FaZ6f0zLK9ah0EzI9DVNwNj7thNea93UjKAqHRV3PInIsL7OJGEjivX1q
        nx51h1oYdLiy5fERz2sVQZd19I+T1UBlqIcHYBsWpq9AKsjtF7bCpoPK+orWNXxd
        bsQ6Ft445AINVY4lq2+i7OBUh7THD8IXgVoJ92TlCD8lAS40h3qWAUQo=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uCBJYLHhiE6v; Mon, 16 Nov 2020 03:09:58 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 1EA53B4A;
        Mon, 16 Nov 2020 03:09:57 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A31192168;
        Mon, 16 Nov 2020 03:09:57 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: bizare bug in "btrfs subvolume show"
From:   Lawrence D'Anna <larry@elder-gods.org>
In-Reply-To: <20201115145323.1628d710@natsu>
Date:   Sun, 15 Nov 2020 18:09:52 -0800
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Meghan Gwyer <mgwyer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C20FAB48-98B0-49AE-B804-FC720E31C5B0@elder-gods.org>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
 <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
 <20201115145323.1628d710@natsu>
To:     Roman Mamedov <rm@romanrm.net>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Nov 15, 2020, at 1:53 AM, Roman Mamedov <rm@romanrm.net> wrote:
>=20
> This still sounds very puzzling, as to how output redirection could =
affect
> things. Perhaps you could run "btrfs sub show" with "strace"? Both =
with and
> without the redirect to see exactly what was the call sequence, =
parameters and
> return values, to compare and find where the difference starts.
>=20
>=20

The first meaningful difference occurs at this ioctl:

--- /dev/fd/63	2020-11-15 18:06:23.000000000 -0800
+++ /dev/fd/62	2020-11-15 18:06:23.000000000 -0800
@@ -1,84 +1,84 @@
 ioctl(3, BTRFS_IOC_TREE_SEARCH, {key=3D{tree_id=3DBTRFS_ROOT_TREE_OBJECTI=
D,=20
 min_objectid=3DBTRFS_FS_TREE_OBJECTID, =
max_objectid=3DBTRFS_FS_TREE_OBJECTID,=20
 min_offset=3D7274, max_offset=3DUINT64_MAX, min_transid=3D0, =
max_transid=3DUINT64_MAX,=20
 min_type=3DBTRFS_ROOT_REF_KEY, max_type=3DBTRFS_ROOT_REF_KEY, =
nr_items=3D4096}} =3D>=20
 {key=3D{nr_items=3D53}, buf=3D[{transid=3D56320, =
objectid=3DBTRFS_FS_TREE_OBJECTID,=20
 offset=3D7274, type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20=

 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7275, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7276,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7277, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7278,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7279, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7280,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7281, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7282,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7283, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7284,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7285, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7286,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7287, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7288,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7289, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
-{transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7290,=20
+{transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7168,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7291, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7292,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7293, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7295,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7296, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7297,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7298, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7299,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7300, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7309,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7310, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7311,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7312, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7313,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7314, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7315,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7316, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7317,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56570,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7318, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56570, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7319,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7320, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7322,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7323, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7324,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7325, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7326,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7327, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7328,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7329, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7330,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7331, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7332,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D43}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7333, =
type=3DBTRFS_ROOT_REF_KEY, len=3D43},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7334,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D45}, {transid=3D56695,=20
 objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7335, =
type=3DBTRFS_ROOT_REF_KEY, len=3D45},=20
 {transid=3D56695, objectid=3DBTRFS_FS_TREE_OBJECTID, offset=3D7336,=20
 type=3DBTRFS_ROOT_REF_KEY, len=3D45}]}) =3D 0

A little while later they diverge again when the good side does a =
BTRFS_IOC_TREE_SEARCH for
7290, and the bad side does it for 7168, which fails.

Full traces are at https://odin.elder-gods.org/btrfs-bug/a  and =
https://odin.elder-gods.org/btrfs-bug/b
If you=E2=80=99d like to see them







