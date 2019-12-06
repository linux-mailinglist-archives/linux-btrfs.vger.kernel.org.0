Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A193D11596A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 23:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLFWvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 17:51:44 -0500
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:45314 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfLFWvo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 17:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1575672702;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=jOYEpzgqC20aG7poYlSeeJgmw2BcWzAIBQtMCJyAgLc=;
        b=O4QHu0dX5PIRqxRfCCFK7aiPNtGH+uhc8QT9G2Izg+ifFPoZe39tbRK7/LBgeAmA
        9f66MuLryWLmjKW9jhndwHeqxjYTwQbTctmd6/g6WGgn2ixeUvp0Xx9m3+Pm8EDbxTG
        7cENAr8is9N+GUqbGbBrVs0WBmwNozv1akmUoizc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1575672702;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=jOYEpzgqC20aG7poYlSeeJgmw2BcWzAIBQtMCJyAgLc=;
        b=FWaGoWqdoaDuTsfUPCo3SFHetXcfNyeeBhC2TSK9nsO6hAT6jwwn3CIprLkbkXby
        PzZlwurxPDSS6cXF7mbfg+z2LUVFqGflqZogQ8Qfrmom8+FYFj72sM/k8d7GVicuxTp
        iKWFNX7HsAjypspw/N9fDJVKQ0RkEjqTTnF7zpUQ=
Subject: Re: df shows no available space in 5.4.1
To:     Chris Murphy <lists@colorremedies.com>,
        Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <CAJCQCtTMCQBU98hYdzizMsxajB+6cmxYs5CKmNVDh4D9YZgfEg@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016edd69655b-b6d07bce-6036-4add-aa0c-f91b57e78ee5-000000@eu-west-1.amazonses.com>
Date:   Fri, 6 Dec 2019 22:51:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTMCQBU98hYdzizMsxajB+6cmxYs5CKmNVDh4D9YZgfEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.12.06-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.12.2019 23:35 Chris Murphy wrote:
> On Fri, Dec 6, 2019 at 2:26 PM Martin Raiber <martin@urbackup.org> wrote:
>> Hi,
>>
>> with kernel 5.4.1 I have the problem that df shows 100% space used. I
>> can still write to the btrfs volume, but my software looks at the
>> available space and starts deleting stuff if statfs() says there is a
>> low amount of available space.
> This is the second bug like this reported in as many days against 5.4.1.
>
> Does this happen with an older kernel? Any 5.3 kernel or 5.2.15+ or
> any 5.1 kernel? Or heck, even 5.4? :P

Sorry, didn't see the other thread. Looks like the same issue.
Unfortunately, I was previously using 4.19.x, so I can't pinpoint it. I
think it did not occur when I was testing 5.4-rc7, but it does
(randomly?) take a few days of runtime to start occuring, so it could
have just not occurred then.

>> # df -h
>> Filesystem                                            Size  Used Avail
>> Use% Mounted on
>> ...
>> /dev/loop0                                            7.4T  623G     0
>> 100% /media/backup
>> ...
>>
>> statfs("/media/backup", {f_type=BTRFS_SUPER_MAGIC, f_bsize=4096,
>> f_blocks=1985810876, f_bfree=1822074245, f_bavail=0, f_files=0,
>> f_ffree=0, f_fsid={val=[3667078581, 2813298474]}, f_namelen=255,
>> f_frsize=4096, f_flags=ST_VALID|ST_NOATIME}) = 0
>
> f_bavail=0 seems wrong to me.
>
> What distro and what version of coreutils?

It's debian stretch coreutils 8.26-3, glibc 2.29-3. But that's an
excerpt of the strace output so that shouldn't matter.

Thanks!

>
> It's the same questions for Tomasz in yesterday's thread with similar subject.
>
> --
> Chris Murphy


