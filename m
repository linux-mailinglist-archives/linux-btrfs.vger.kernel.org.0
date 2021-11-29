Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F04461B63
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 16:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhK2Pzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 10:55:41 -0500
Received: from w1.tutanota.de ([81.3.6.162]:50444 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232047AbhK2Pxk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 10:53:40 -0500
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id D9C5DFBF883;
        Mon, 29 Nov 2021 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638201020;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=90UgJKs8MANi/hqnG6V971kSyvmKZ2rw7WNKHUUdWaQ=;
        b=WWs3oa+FgmGwAxCHHajOHARLEYdkU0DTpTr8hisagwaHgEeuPBd3XAIa+eMTwIe+
        NiRMnUVFjhxqFsnMz82O4DF1VswLFf/39r1CTuOphQpBYOvlMnT7aFcXAvDKQGs0Y9p
        7tTafvCJn3qw+lFmBrEi1mlovpVkCd80SJPkpuTW2dRe/h8HmxhgIiUY8t059Qn0F78
        zXDOlq/nWku0aBSZ4IqjNrPgVOyMQm8nScBBlFCcD933K7333iF57wBsjLMJjnG5Tyl
        g31o3ut+Sl7N4ryXDrOqWHjUxANuTc/IGGAjmgazFsy0pKdsTWtti0HXmqUBjNFHgED
        Dzzd5jYwvQ==
Date:   Mon, 29 Nov 2021 16:50:20 +0100 (CET)
From:   Borden <borden_c@tutanota.com>
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <MpgNwtq--3-2@tutanota.com>
In-Reply-To: <87r1azashl.fsf@vps.thesusis.net>
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net>
Subject: Re: Connection lost during BTRFS move + resize
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

29 Nov 2021, 10:26 by phill@thesusis.net:
> The only tool I know of that can do this is gparted, so I assume you are
> using that.  In this case, it has to umount the filesystem and manually
> copy data from the old start of the partition to the new start.  Being
> interrupted in the middle leaves part of the filesystem in the wrong
> place ( and which parts is unknowable ), and so it is toast.  This is
> one area where LVM has a significant advantage as its moves are
> interruption safe and automatically resumed on the next activation of
> the volume.
>
This is the answer that I anticipated, and it's good to know now so I don't destroy data that I _cannot_ afford to lose later. So thank you.

For my own education/curiosity/intellectual banter: ddrescue, badblocks, rsync and other utilities have log files that track progress and allow it to resume if it's interrupted. Since resize operations work in the linear process you described, how hard would it be, theoretically, to implement a "needle position" in a move operation to allow a move to pick up where it left off?

Obviously, it wouldn't be 100% perfect, but if a recovery utility could look at the disk and say "partition starts here, skip a bit somewhere in the middle, continue here, stop there," surely that would be more efficient than trying to recover files with a low-level utility?
