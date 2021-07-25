Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8303D4B0C
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 04:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGYCPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 22:15:53 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:36358 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGYCPw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 22:15:52 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id B15731E0065C;
        Sun, 25 Jul 2021 05:56:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1627181782; bh=ai1Ndk+Y8Ph1vQ/OfrqDEYftyIwkH6+OViczuy2wI1Y=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=sG0OI4iP9MLFXokSgNLCpq79y3ykiC01eNQQdEXwdas/Pyxa/A1XcVfzQOX1CzUro
         +BR3qarga1i95LfP+ZaIc7kaJCC7JGXSB1f/aOLLW2X+tFnK+WvRF5vbp8UCOc6asL
         Ob0iK3YL1gwWyfcMqoX+zOZRyAQ9m7mIDbDCfuQA=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id A74F91E00662;
        Sun, 25 Jul 2021 05:56:22 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id AQPRzceWSuFy; Sun, 25 Jul 2021 05:56:22 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 571371E0065C;
        Sun, 25 Jul 2021 05:56:22 +0300 (EEST)
Received: from nas (unknown [103.138.53.19])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 498E41BE0035;
        Sun, 25 Jul 2021 05:56:20 +0300 (EEST)
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
 <20210724082356.GA68829@realwakka>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
Date:   Sun, 25 Jul 2021 10:54:05 +0800
In-reply-to: <20210724082356.GA68829@realwakka>
Message-ID: <czr7w180.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+ngkCkQGXfDBpV3CdKQJ6W9p/BzG4nkTulcTLmCkUMVhC2n2R1THi+og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 24 Jul 2021 at 16:23, Sidong Yang <realwakka@gmail.com>=20
wrote:

> On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/24 =E4=B8=8B=E5=8D=883:46, Sidong Yang wrote:
>> > There is some code that using NAME_MAX but it doesn't include=20
>> > header
>> > that is defined. This patch adds a line that includes=20
>> > linux/limits.h
>> > which defines NAME_MAX.
>>
>> I guess it's related to this issue?
>>
>> https://github.com/kdave/btrfs-progs/issues/386
>
> Yeah, It seems that there is no patch for this yet. So I sent=20
> this
> patch. Is this too minor patch?
>
Good fix. But there is one PR before the issue creation:
https://github.com/kdave/btrfs-progs/pull/385

--
Su

> Thanks,
> Sidong
>
>>
>> Thanks,
>> Qu
>>
>> >
>> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
>> > ---
>> >   cmds/filesystem-usage.c | 1 +
>> >   1 file changed, 1 insertion(+)
>> >
>> > diff --git a/cmds/filesystem-usage.c=20
>> > b/cmds/filesystem-usage.c
>> > index 50d8995e..2a76e29c 100644
>> > --- a/cmds/filesystem-usage.c
>> > +++ b/cmds/filesystem-usage.c
>> > @@ -24,6 +24,7 @@
>> >   #include <stdarg.h>
>> >   #include <getopt.h>
>> >   #include <fcntl.h>
>> > +#include <linux/limits.h>
>> >
>> >   #include "common/utils.h"
>> >   #include "kerncompat.h"
>> >
