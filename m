Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221491B20FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUIEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 04:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDUIEx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 04:04:53 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002BC061A0F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 01:04:53 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id n128so3365814vke.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lW1NQBCOz+WmCLpluHP2UT+B6fMQD2yLPJaqz2YNlns=;
        b=Qea8LJqWI1+VF+cT1AXyXf1x8zZsyii5qWdHnf5ZTPRWyYMUH1se3ks6b/HIDqPLn6
         5s2q6opUm2z/skRLoCCgcKlTNxpTd0uepQ4tFxmlLhk8gg9zt8Fhf1uIakkVY6mVvTpl
         uVUpkqGtQn0YWXEOn9sGmeBaaEZlEBhH9JD3L4eTOcHDzIB4gXWyq8rXhB0mS5Tr0IFW
         fnNhKzA2Aym8ywOf+O1p/RDINPvDsNzUNZLaOI48g8qevMDBQ+1vOHEqxDUA5/nTOue6
         kbw4cJ+2xaOj/sT7zsi/GTCROTB40qAPxl1TBCS04/WVGH1mGttsYmMhQWWpDzo86L3W
         w6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=lW1NQBCOz+WmCLpluHP2UT+B6fMQD2yLPJaqz2YNlns=;
        b=nctI3YKw1C4MieILPjJVQDAI/7ohfjiI7EbwdQpRocxNrCBoqORkRnFXF8O/hJabnT
         5ptid+SVHWEjfCmmhSrEzpBCDaGus33TNYLmyR9bWGyf7vM1kMQ4C2gD+BTvvFZ0rdEM
         5qV2kMvnwUUJ9C8hezE3BmFxddM4qDcv6y8oEXmVxWOYvvmU3rWPRy+VhoYWFXtUfjqq
         rPesxOKIoc6lIeymb9LPl1x7dqLE5SOrThRrT60CuSpXs6dja6LioWte4tIB0T5PUZVq
         sroEdKW+pVlnV8C27Y5TlqMOdjinw4lfdoM8bZD/oyA7k/BYDL0xlMQRD4aS5zrVh0rj
         M6/w==
X-Gm-Message-State: AGi0PuYX8xGOUwHTib6qO5gBvOOLZaTVOsf+CJtD9kGedI4sOkVLVbnD
        rEDlnXJiWVydb4yB4j2PMSvRkvC+LPxj9d+3YEU=
X-Google-Smtp-Source: APiQypI359pP9fu5bPFMr8YDMrRahHM8Da+hUaql37LAgxHYiPptvjM8wemi1QcTAB6znAwlk8JntPwmnAqdX2FeWAA=
X-Received: by 2002:a1f:d145:: with SMTP id i66mr13714593vkg.24.1587456292817;
 Tue, 21 Apr 2020 01:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200410154248.2646406-1-josef@toxicpanda.com>
 <SN4PR0401MB35985AA68F3ECB8C8AAE9D3F9BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598C2A93849EB046D06AAC59BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200420232016.GL18421@twin.jikos.cz>
In-Reply-To: <20200420232016.GL18421@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 21 Apr 2020 09:04:41 +0100
Message-ID: <CAL3q7H5bduJcyZ5S8ZYnV7tznWsXQiPhvQ773mUfsMn=Voau0w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix setting last_trans for reloc roots
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 12:22 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Apr 16, 2020 at 03:34:30PM +0000, Johannes Thumshirn wrote:
> > On 16/04/2020 14:38, Johannes Thumshirn wrote:
> > > This fixes a kmemleak complaint from btrfs/074, complete re-run of
> > > xfstests is pending, but one down again.
> > >
> > > Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > >
> >
> > I'll take that back, I still see a leak of 'cur_trans' allocated in
> > join_transaction() for btrfs/074 on a full xfstests run. The same leak
> > is reported for btrfs/072 and generic/127.
>
> I'm not sure, but the patch "btrfs: drop logs when we've aborted a
> transaction" is fixing transaction handle leaks. I've added it to
> misc-next, the effects have been observed in test generic/475 so it's
> only a weak link, tests btrfs/074 do not stress the transaction cleanup
> that much.

Hum?
That patch fixes a use-after-crash during unmount after a transaction
was aborted - it doesn't fix transaction leaks as far as I can see.
Perhaps you meant patch "btrfs: fix memory leak of transaction when
deleting unused block group", which fixes a regression introduced in
5.7-rc1.
btrfs/074 (and tests 060 to 073) often triggers unused block group
deletion due to fsstress and other operations in parallel.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
