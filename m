Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16D614E4CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3Vcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 16:32:48 -0500
Received: from a4-4.smtp-out.eu-west-1.amazonses.com ([54.240.4.4]:53270 "EHLO
        a4-4.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbgA3Vcs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 16:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1580419966;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=8B8f1cmVmHS61n/OBQvoeqQlBs4q5e1CuDpiMk76FbA=;
        b=BdOM4EWAwZunb+A26zYY0knRijQfHTF/IAYyoZt7ugmDMypJkV5xf5xTs/RnlOBf
        GEWChucLL6kHlv5so//fghMjwKfILwnGPhPFGQBzO+4CaELyDkdY4qqHgtA5Dk1bLg4
        wlrOZ1PiTygdpDo/JifUisMtclRhBFeR35LbcY6Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1580419966;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=8B8f1cmVmHS61n/OBQvoeqQlBs4q5e1CuDpiMk76FbA=;
        b=PWdf67QhmQlBylcIg5qJSK1ZaRXrEAEbyifpF0++9Q1rthQMetA2tRvQW4WdhgX5
        q8YCyKSg6x0nHYJjdkLCPQl+FksuQ3oqgiKO0Q9gs1Pu5UTukQN4K7B9A3M3QfG5H1w
        9k9SYz9Ls+onPwjANkqlRIrf4iC6BYW6qfDSYspc=
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Chris Murphy <lists@colorremedies.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <112911984.cFFYNXyRg4@merkaba> <10361507.xcyXs1b6NT@merkaba>
 <CAJCQCtQgqg2u78q2vZi=bEy+bkzX48M+vHXR00dsuNYWaxqRKg@mail.gmail.com>
 <21104414.nfYVoVUMY0@merkaba>
 <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
 <ab7f3087-7774-7660-1390-ba0d8e6d7010@toxicpanda.com>
 <CAJCQCtRq5Q25sqW8wrfiYecnMg3Q+XjTuChdCU=cg9AwboVtCQ@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016ff85ee439-d6f9d7e0-c71e-426e-bade-318dcc91b660-000000@eu-west-1.amazonses.com>
Date:   Thu, 30 Jan 2020 21:32:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRq5Q25sqW8wrfiYecnMg3Q+XjTuChdCU=cg9AwboVtCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2020.01.30-54.240.4.4
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.01.2020 22:09 Chris Murphy wrote:
> On Thu, Jan 30, 2020 at 1:59 PM Josef Bacik <josef@toxicpanda.com> wrote:
>> The file system is fine, you don't need to balance or anything, this is purely a
>> cosmetic bug.
> It's not entirely cosmetic if a program uses statfs to check free
> space and then errors when it finds none. Some people are running into
> that.
>
> https://lore.kernel.org/linux-btrfs/alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org/
>
> I guess right now the most reliable work around is to revert to 5.3.18.

Yeah, my backup system does check via statfs() if a file fits on storage
before backing it up and there is also a setting (global soft file
system quota) that allows users to configure the amount of storage the
backup system should use (e.g. 90% of available storage). In both cases
with statfs() returning zero it'll delete backups till there is "enough
free space", i.e. it'll delete all the backups it is allowed to delete
and then start reporting errors, which is obviously very problematic.

