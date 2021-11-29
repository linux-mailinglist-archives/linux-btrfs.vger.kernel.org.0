Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F2461B07
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 16:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhK2PhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 10:37:12 -0500
Received: from vps.thesusis.net ([34.202.238.73]:46754 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236774AbhK2PfG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 10:35:06 -0500
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 9DF3A68BBB; Mon, 29 Nov 2021 10:31:18 -0500 (EST)
References: <MpesPIt--3-2@tutanota.com>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Borden <borden_c@tutanota.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Connection lost during BTRFS move + resize
Date:   Mon, 29 Nov 2021 10:26:49 -0500
In-reply-to: <MpesPIt--3-2@tutanota.com>
Message-ID: <87r1azashl.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Borden <borden_c@tutanota.com> writes:

> Good morning,
>
> I couldn't find any definitive guidance on the list archives or Internet, so I want to double-check before giving up.
>
> I tried to left-move and resize a btrfs partition on a USB-attached
> hard drive. My intention was to expand the partition from 2 TB to 3 TB
> on a 4TB drive. During the move, the USB cable came loose and the
> process failed.

The only tool I know of that can do this is gparted, so I assume you are
using that.  In this case, it has to umount the filesystem and manually
copy data from the old start of the partition to the new start.  Being
interrupted in the middle leaves part of the filesystem in the wrong
place ( and which parts is unknowable ), and so it is toast.  This is
one area where LVM has a significant advantage as its moves are
interruption safe and automatically resumed on the next activation of
the volume.

