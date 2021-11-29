Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619A1461BBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbhK2Q3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 11:29:15 -0500
Received: from vps.thesusis.net ([34.202.238.73]:46760 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244943AbhK2Q1O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 11:27:14 -0500
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id B8D5C68C35; Mon, 29 Nov 2021 11:23:26 -0500 (EST)
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net>
 <MpgNwtq--3-2@tutanota.com>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Borden <borden_c@tutanota.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Connection lost during BTRFS move + resize
Date:   Mon, 29 Nov 2021 11:20:28 -0500
In-reply-to: <MpgNwtq--3-2@tutanota.com>
Message-ID: <87mtlnaq2p.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Borden <borden_c@tutanota.com> writes:

> For my own education/curiosity/intellectual banter: ddrescue,
> badblocks, rsync and other utilities have log files that track
> progress and allow it to resume if it's interrupted. Since resize
> operations work in the linear process you described, how hard would it
> be, theoretically, to implement a "needle position" in a move
> operation to allow a move to pick up where it left off?

Theoretically it shouldn't be too hard.  It's just a matter of deciding
on a location where you can safely record the checkpoint information and
then update the checkpoint between blocks.  That's how LVM handles
moves safely.  In the worst case, you restart the move at the last
checkpoint and just waste some time copying data that was already copied
but not checkpointed.


