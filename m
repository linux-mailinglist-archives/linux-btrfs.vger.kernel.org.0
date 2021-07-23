Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6413D4061
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGWSFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 14:05:09 -0400
Received: from a4-4.smtp-out.eu-west-1.amazonses.com ([54.240.4.4]:41073 "EHLO
        a4-4.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGWSFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 14:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1627065941;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=Y8EbgLpnyeEHhKcyISjzds5+hI5vFsuA/Dze+0G+Wik=;
        b=KaPl6KGQ2cEzGYTsvGMtmm8wqUtfg3N2E4MCKeRWp1U5tGsbNIpSyQXKmCZ0uIpg
        R7Pfzf7WU22bYcJ1o+BdzoquLiv4TkY25h4IbC79Gxvqfy0ysMd6vXIFJ26W80mJjsx
        WpuvcGsxeehFv8QyITtx33teVNXLJZAFW++mY1TU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1627065941;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Y8EbgLpnyeEHhKcyISjzds5+hI5vFsuA/Dze+0G+Wik=;
        b=NUwCelXVUqubGa2PQjcbXF0br5HcbasC7Y0sfcBhktMkc+HdE8b6uud/h/jnPlPG
        nONzLh0y7qpzuq6QPVKSUCpr2ovHoGUbLwYR04FxX21QVTLT8csQnfKCcq3P1deHbH6
        WdH3MF/0tsJ0LIhT6aYin7Jueyuu2/AdTKpNzHyE=
Subject: Re: On the issue of direct I/O and csum warnings
To:     Jonas Aaberg <cja@lithops.se>, linux-btrfs@vger.kernel.org
References: <20210723165517.2614d1b4@poirot.localdomain>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017ad4affb63-e12c8463-8971-4b1c-b271-ee880969fa5b-000000@eu-west-1.amazonses.com>
Date:   Fri, 23 Jul 2021 18:45:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723165517.2614d1b4@poirot.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.07.23-54.240.4.4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.07.2021 16:55 Jonas Aaberg wrote:
> Hi,
>
> I use btrfs on dm-crypt. About two months ago, I started to get:
>
> --
> BTRFS warning (device dm-0): csum failed root 257 ino 1068852 off
> 25690112 csum 0xa27faf9a expected csum 0x4c266278 mirror 1 BTRFS error
> (device dm-0): bdev /dev/mapper/disk0 errs: wr 0, rd 0, flush 0,
> corrupt 349, gen 0
> --
>
> kind of warning/errors on my laptop. I went a bought a new NVME disk
> because I'm rather found of my data, eventhough most is backup-ed up.
>
> A week later, I started to get the same kind of warning/error message
> on my new NVME. After half a day of memtest86, resulted in no memory
> errors found, I gave up on my otherwise stable laptop and started to
> use an old laptop that I've been to lazy to sell instead while looking
> out for a decent pre-owned newer laptop.
>
> Now I'm just about to install and move over to a newly bought laptop,
> when today my old laptop started to show the same warning/errors.
> My old laptop does not share a single part with the laptop which I
> previous got the "checksum failure" warnings on. Therefore I have a hard
> time to believe that I've gotten the same hardware failure twice.
>
> Then I found:
> <https://btrfs.wiki.kernel.org/index.php/Gotchas> and "Direct I/O and
> CRCs".
>
> Which I believe is what I've ran into. One of the affect files is
> a log file from syncthing on both computers.

I wouldn't be certain about the conclusion that it is the direct I/O csum issue. Are you sure syncthing is writing to logs via direct I/O? That would be bad e.g. because it disables btrfs compression and log files compress really well. So I'd say report additional information like kernel version (and if it is a vanilla kernel), how your btrfs is setup (metadata RAID1), etc.

> I have just one humble request, please do something about this
> checksum error message. Just add printk with a link to:
> <https://btrfs.wiki.kernel.org/index.php/Gotchas> and the issue of
> "Direct I/O and CRCs".
The problem is nothing can be done without impacting performance and direct I/O is used for performance. IMO it should be disabled by default (i.e. it just pretends to do direct I/O like ZFSOnLinux) and be able to be enabled via mount option.
>
> Maybe update the wiki with:
> `find <mountpoint> -inum <ino-number-from-warning-message>`
> would be a helpful as well.

btrfs inspect-internal inode-resolve <ino-number-from-warning-message> <fs>

is faster.

