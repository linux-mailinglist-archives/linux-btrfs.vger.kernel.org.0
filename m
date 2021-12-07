Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8397D46BFAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhLGPrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:47:31 -0500
Received: from vps.thesusis.net ([34.202.238.73]:46820 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239126AbhLGPrb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 10:47:31 -0500
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 70EAD6A4E7; Tue,  7 Dec 2021 10:44:00 -0500 (EST)
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: ENOSPC while df shows 826.93GiB free
Date:   Tue, 07 Dec 2021 10:39:20 -0500
In-reply-to: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
Message-ID: <87ilw0v2rj.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Christoph Anton Mitterer <calestyo@scientia.org> writes:

> yet:
> # /srv/dcache/pools/2/foo
> -bash: /srv/dcache/pools/2/foo: No such file or directory

I'm not sure what you intended this to do or show.  It looks like you
tried to execute a program named /srv/dcache/pools/2/foo, and there is
no such program.  That doesn't say anything about the filesystem.

> balancing also fails, e.g.:
> # btrfs balance start -dusage=50 /srv/dcache/pools/2
> ERROR: error during balancing '/srv/dcache/pools/2': No space left on device

Balance is basically like a defrag.  You have less than 0.01% space
free, which is not enough to do a defrag.  Either free up some space, or
don't bother trying to defrag.

