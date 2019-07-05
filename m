Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61360C5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGEU2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 16:28:32 -0400
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:55556 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfGEU2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 16:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1562358510;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=4FjpfZL8lT0uHxL0t3FZs2X6SbsSz2YKwan1YEEHRoI=;
        b=hGPUf9ug2bmz4i5PYrtuVjQlq+27PCGmw2JYjEN/WQRHrrGOi7VzydrvE5vYG9fr
        We2WwSvqVMlqkE/bsCedTTh7T5+cjKOosQ1INMrTfNfMGJQzHzO0tuiSnqyJCQdiiSc
        JLe8bGisHEffqZVUqfYwF5hwtfb39uJ+FVHcVJY4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1562358510;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=4FjpfZL8lT0uHxL0t3FZs2X6SbsSz2YKwan1YEEHRoI=;
        b=XKlBvutkklwGfhqaLZBbJ96YL7EpnFteKElwmd1zwT8VErR0AOfEXwS55F5wG0Nw
        fOKbdD3nY9qNFiat6LM7+/estFcnOTw7oc1oisMLYGme+rwqtOH1yIMp+y0mmkGn4/d
        e/DBfzuMEyx/y2LJ5M5HRgS04PpHJAAITN6GGXRM=
Subject: Re: syncfs() returns no error on fs failure
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016bc283c774-ca60b6ce-5179-4de8-8df3-80752411b5c0-000000@eu-west-1.amazonses.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016bc3d2f2a2-46c55025-ec28-468f-b1d2-82d655fa3a1c-000000@eu-west-1.amazonses.com>
Date:   Fri, 5 Jul 2019 20:28:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0102016bc283c774-ca60b6ce-5179-4de8-8df3-80752411b5c0-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.07.05-54.240.4.2
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

More research on this. Seems a generic error reporting mechanism for
this is in the works https://lkml.org/lkml/2018/6/1/640 .

Wrt. to btrfs one should always use BTRFS_IOC_SYNC because only this one
seems to wait for delalloc work to finish:
https://patchwork.kernel.org/patch/2927491/ (five year old patch where
Filipe Manana added this to BTRFS_IOC_SYNC and with v2->v3 not to
syncfs() ).

I was smart enough to check if the filesystem is still writable after a
syncfs() (so the missing error return doesn't matter that much) but I
guess the missing wait for delalloc can cause the application to think
data is on disk even though it isn't.

On 05.07.2019 16:22 Martin Raiber wrote:
> Hi,
>
> I realize this isn't a btrfs specific problem but syncfs() returns no
> error even on complete fs failure. The problem is (I think) that the
> return value of sb->s_op->sync_fs is being ignored in fs/sync.c. I kind
> of assumed it would return an error if it fails to write the file system
> changes to disk.
>
> For btrfs there is a work-around of using BTRFS_IOC_SYNC (which I am
> going to use now) but that is obviously less user friendly than syncfs().
>
> Regards,
> Martin Raiber


