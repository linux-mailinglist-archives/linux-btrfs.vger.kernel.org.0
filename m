Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8B3E1AE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbhHER7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 13:59:09 -0400
Received: from vps.thesusis.net ([34.202.238.73]:35240 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233027AbhHER7J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Aug 2021 13:59:09 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 13:59:08 EDT
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 2EB1641757; Thu,  5 Aug 2021 13:49:16 -0400 (EDT)
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
Date:   Thu, 05 Aug 2021 13:47:46 -0400
In-reply-to: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
Message-ID: <87eeb7pysj.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Dave T <davestechshop@gmail.com> writes:

> I'm using btrbk via a systemd timer. I have a daily and hourly timer
> set up. Each timer starts by mounting the btrfs root, performing the
> btrbk task, and unmounting the btrfs root.

It looks like the unmounting is not being done, so it just keeps
mounting it over again on the next backup.

