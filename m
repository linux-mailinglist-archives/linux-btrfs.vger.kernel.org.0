Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5725C3C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgICO62 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 10:58:28 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:37092 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgICO5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 10:57:01 -0400
Date:   Thu, 03 Sep 2020 14:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599145012;
        bh=V+4EFbFQpJyIaAFv04pfYfr80TksSVULQe3JjJfxwLQ=;
        h=Date:To:From:Reply-To:Subject:From;
        b=tf7QHgG1j4GC6Hgw9BmFYNFZ5qBIKWgDLZOEh4iK+TcO9WWFSbDwYc4iDjEImZfdg
         0tYI5uVyd1csQfxkQrKMSsBKIBz73ZCoe9rVzGinAFr4Z7vsjQrnx1pLePjJng1wPP
         NdBO3FDS3lP8AZdefjekuTqBRLwQEsn8SC+PWf9U=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Althorion <althorion@protonmail.com>
Reply-To: Althorion <althorion@protonmail.com>
Subject: [btrfs-progs] btrfs check --clear-space-cache v2 segfaults
Message-ID: <37TAH07_l2Srimzx9YvwQjA7Y1KW9-Xqca9YysAnCJc2c_oOhnmUmvWF7U-JTkntMZQL7qBu82LV-4xA8Sjr3rgtSrM3ses2QPAbaib85Yk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

My BTRFS partition started throwing errors and remounting read-only, with e=
rrors like:

Sep 02 14:49:44 ripper systemd[1]: Started Scrub btrfs filesystem, verify b=
lock checksums.
Sep 02 14:50:56 ripper kernel: BTRFS error (device sdc4): incorrect extent =
count for 82707480576; counted 1, expected 2
Sep 02 14:50:56 ripper kernel: BTRFS error (device sdc4): incorrect extent =
count for 126730895360; counted 5, expected 6
Sep 02 14:50:56 ripper kernel: BTRFS error (device sdc4): incorrect extent =
count for 131025862656; counted 0, expected 1
Sep 02 14:51:55 ripper kernel: BTRFS error (device sdc4): incorrect extent =
count for 82707480576; counted 2, expected 3
Sep 02 14:51:55 ripper kernel: BTRFS: error (device sdc4) in convert_free_s=
pace_to_bitmaps:316: errno=3D-5 IO failure
Sep 02 14:51:55 ripper kernel: BTRFS info (device sdc4): forced readonly

I've tried running btrfs check --clear-space-cache to try and clear the sec=
ond to last error, but it segfaulted after a few seconds.

OK, but I run Gentoo, so maybe it's something on my end, so I tried again f=
rom an Arch LiveCD, using btrfs-progs 5.7-1, and it segfaulted too.

What else should I try before wiping up the system and recreating from back=
up?




