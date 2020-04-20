Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81C1B06A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDTKe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 06:34:56 -0400
Received: from len.romanrm.net ([91.121.86.59]:32914 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKez (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 06:34:55 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id A9514401F7;
        Mon, 20 Apr 2020 10:34:49 +0000 (UTC)
Date:   Mon, 20 Apr 2020 15:34:49 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Nick Gilmour <nickeforos@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: ERROR: Could not destroy subvolume/snapshot: Directory not
 empty
Message-ID: <20200420153449.3bd2d339@natsu>
In-Reply-To: <CAH-droy1qkV0mfWY5ojRVej7fGnznmSiN9+sPoxvPF2Oy5JSLA@mail.gmail.com>
References: <CAH-droy1qkV0mfWY5ojRVej7fGnznmSiN9+sPoxvPF2Oy5JSLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 20 Apr 2020 12:05:58 +0200
Nick Gilmour <nickeforos@gmail.com> wrote:

> # btrfs subvolume delete /tlsv5/@.broken.20190830a
> 
> Delete subvolume (no-commit): '/tlsv5/@.broken.20190830a'
> ERROR: Could not destroy subvolume/snapshot: Directory not empty

It appears like it contains a few other subvolumes:

> ID 324 gen 54829 top level 257 path
> <FS_TREE>/@.broken.20190830a/var/lib/portables
> ID 351 gen 268851 top level 257 path
> <FS_TREE>/@.broken.20190830a/var/lib/docker/btrfs/subvolumes/641bd5ec86e1c5e1f2d504a0656da736bafb858551067aca7f1b84c24c1e7d33
> ...

Even though it doesn't really "contain" them for the purposes of snapshotting,
for deletion you first have to remove all the nested ones.

I believe in recent enough kernels the regular "rmdir" call is able to remove
empty subvolumes, so doing an "rm -rf" on the subvolume you want to remove
will take care of all the nested ones (if any). Or if there's just a couple,
then just remove them manually first.

-- 
With respect,
Roman
