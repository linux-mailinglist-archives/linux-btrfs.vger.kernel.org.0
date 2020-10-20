Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1A42941B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 19:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403923AbgJTRsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 13:48:13 -0400
Received: from mail.itouring.de ([85.10.202.141]:36098 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403883AbgJTRsM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 13:48:12 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 13:48:12 EDT
Received: from tux.applied-asynchrony.com (p5b07e9c2.dip0.t-ipconnect.de [91.7.233.194])
        by mail.itouring.de (Postfix) with ESMTPSA id 95C91CC304D
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 19:41:34 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 5F528F015C5
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 19:41:34 +0200 (CEST)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: libbtrfsutil + python = UUID confusion?
Organization: Applied Asynchrony, Inc.
Message-ID: <92dcded4-3281-eeda-6072-527aa685a07e@applied-asynchrony.com>
Date:   Tue, 20 Oct 2020 19:41:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I wanted to see how much btrfs-progs' python binding likes python-3.9, so that
it can be enabled for Gentoo's ebuild. First let's verify that it works correctly
with 3.8..

   holger>python3.8
   Python 3.8.6 (default, Sep 25 2020, 11:47:38)
   [GCC 10.2.0] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import btrfsutil
   >>> i=btrfsutil.subvolume_info("/mnt/data1")
   >>> i
   btrfsutil.SubvolumeInfo(id=5, parent_id=0, dir_id=0, flags=0, uuid=b'S\x98\xa9\xc8\xaa0FX\xb3\xcf\xca\xaf\x03\xe9\xf8S', parent_uuid=b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00', received_uuid=b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00', generation=8349, ctransid=8349, otransid=0, stransid=0, rtransid=0, ctime=1602972626.0, otime=1566909923.0)
   >>> i.uuid
   b'S\x98\xa9\xc8\xaa0FX\xb3\xcf\xca\xaf\x03\xe9\xf8S'

Hm, that's unreadable. Let's make a UUID from those bytes:

   >>> import uuid
   >>> uuid.UUID(bytes=i.uuid)
   UUID('5398a9c8-aa30-4658-b3cf-caaf03e9f853')

Yeah no wait what? The expected fsid of /mnt/data1 is
"14831af0-32d2-40b7-98c9-ca5467910a8c".

What do the UUID's bytes look like as hex?

   >>> i.uuid.hex()
   '5398a9c8aa304658b3cfcaaf03e9f853'

..not helping..

Just for funsies let's see what python-btrfs has to say (since it already works
fine with 3.9):

   holger>python3.9
   Python 3.9.0 (default, Oct 13 2020, 23:55:04)
   [GCC 10.2.0] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import btrfs
   >>> btrfs.FileSystem("/mnt/data1").fs_info().fsid
   UUID('14831af0-32d2-40b7-98c9-ca5467910a8c')

Looks correct. We need to go deeper!

btrfsutil.h defines the UUID as:

     /** @uuid: UUID of this subvolume. */
     uint8_t uuid[16];

..and indeed the wrong bytes sequence (5398..) has 32 characters aka 16 bytes,
so we're not too far off. What should the correct byte representation look like?

   >>> import uuid
   >>> u=uuid.UUID('14831af0-32d2-40b7-98c9-ca5467910a8c')
   >>> u.bytes
   b'\x14\x83\x1a\xf02\xd2@\xb7\x98\xc9\xcaTg\x91\n\x8c'

Soo..am I holding it wrong or is this a case of Python-2.7/3.x string-vs-bytes
confusion? I see in btrfs-progs/libbtrfsutil/subvolume.c that
get_subvolume_info_unprivileged() simply copies the UUID bytes received from
the ioctl, but I'm not sure what else can or should happen to them.
One suspect (to me) seems the "PyBytes_FromStringAndSize" in:
https://github.com/kdave/btrfs-progs/blob/master/libbtrfsutil/python/subvolume.c#L121

Any other ideas? Should this go into the btrfs-progs bug tracker?

(paging Dr. Sandoval..)

cheers
Holger
