Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19624438659
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJXCbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Oct 2021 22:31:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38205 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231611AbhJXCbe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Oct 2021 22:31:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19O2T5xk006050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Oct 2021 22:29:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 269B515C34DD; Sat, 23 Oct 2021 22:29:05 -0400 (EDT)
Date:   Sat, 23 Oct 2021 22:29:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: Is generic/647 known failing test for btrfs?
Message-ID: <YXTE8bHlL3zEBrW0@mit.edu>
References: <YXQrjnZcqU8pmUOI@mit.edu>
 <20211024091701.8ED1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024091701.8ED1.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 24, 2021 at 09:17:02AM +0800, Wang Yugui wrote:
> Hi,
> 
> Yes. It is a known problem of btrfs and others.

Hmmm, I haven't noticed a problem running generic/647 on ext4, xfs,
f2fs, reiserfs, overlayfs, and vfat.  I do see the proposed iomap
changes referenced in [1] which is a prereqsuite for [2]. but it
appears that most other file systems (both thoes that do and don't use
iomap) are able to pass generic/647 even without the iomap changes
proposed in [1].

[1] https://lore.kernel.org/all/20210827164926.1726765-1-agruenba@redhat.com/
[2] https://lore.kernel.org/linux-btrfs/20211023115852.2517.409509F4@e16-tech.com/T/

					- Ted
