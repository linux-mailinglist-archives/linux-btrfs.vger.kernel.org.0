Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F043DDA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhJ1JZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1JZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 05:25:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77DEC061570;
        Thu, 28 Oct 2021 02:23:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t40so5074126qtc.6;
        Thu, 28 Oct 2021 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LDJKZqlaK+Mu+bC3aeuDwUclxPASM/iMw2i79aUxLro=;
        b=WTCdpIPoxG7MIV+d4RM1oZEocEcSuD2F+whPINBsSZh17zek0UhjdVb6WoVZ+fiaBc
         hGRbEZDu/2GBQjOuew4t4F+1TfF6Odq/BawA+fmbJHNXJ3cZmv8UggCj9OmRb8cMnRhS
         TR5czlMDdhNoq6u5cHocIAOukGRG896ZW72eHPRRVuCGjtZoUgcvKHxI6zXm/gCaHC/M
         tgc1A5AWByXeWz0alK0CGB27UPoGWPpCX8pcstOscE9wIy1iDhr0rEnJkYW7iK5A9U/M
         lHRKxiUgNzRsVgelD9xtBY5OSy1nOlQgvRs3qJMmlj5jhutjYwO8Q4fKqnNUhkBpghMT
         EI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LDJKZqlaK+Mu+bC3aeuDwUclxPASM/iMw2i79aUxLro=;
        b=FRIgNuEwPz+GbhH3jJrx4Fw0Cy60yCpoVoJHyMR9XphHf4taIpLZa4afnMGaexvm5O
         kBhl+DYgRWDe3W9UuMY7PZdh1dpig+T8+tyNfIp3p9LSSZejw2EBwGJo0+4JLl0aYbER
         wFEbDVZTGGTHKbbu4Q8fQ+ZO5qxOcEh6JyT/6IRFAN0wxpY9ihbS+CYqxbP3dI7S+Rz2
         cNyj1CCCuxbwQr58N0SepsYJlpBfADEhsXfytjvcWypBlRSBgsnU9c9Hzqq1QyPEWmmh
         ZjTGmNII4HQMBlwSqtnk2NDiqxfpqFkduFELsiAMkyEpB4j3riifumz/3StD+r4ZXMtY
         yKZQ==
X-Gm-Message-State: AOAM530cpijVyQhb1lili7a8+J+Br7MEJBOSDed2N+UbZ5jbzASxgbFl
        YQG3oKcr3VPcW7f68WQHbuq9SX2ne5XT54qTiSKqyUq6hgI=
X-Google-Smtp-Source: ABdhPJyj1oEYIhXHWV2tUVgophhx03nWjTIZaK9v0i0895Sp4gbjDKCWEqIbqE/2Pq+diHizu/50jsWoayLHCQ8eA3o=
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr3360640qtp.124.1635413000179;
 Thu, 28 Oct 2021 02:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211027135754.20101-1-nborisov@suse.com> <CAL3q7H66tOAu0qANiwimWcDZwhgMKQpO46qz+uR1FaF61Y8A0g@mail.gmail.com>
 <6f63dd3a-982f-6875-2e47-a091f8d8d96a@suse.com>
In-Reply-To: <6f63dd3a-982f-6875-2e47-a091f8d8d96a@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 28 Oct 2021 10:22:44 +0100
Message-ID: <CAL3q7H6iZ8-YZPUmRsbvnaFwLA+NzU8-HBGNiT3GW618xNnRUA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Test proper interaction between skip_balance and
 paused balance
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 10:17 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 28.10.21 =D0=B3. 12:01, Filipe Manana wrote:
> > On Wed, Oct 27, 2021 at 10:25 PM Nikolay Borisov <nborisov@suse.com> wr=
ote:
>
> <snip>
>
> >> +if [[ ! -e /sys/fs/btrfs/$uuid/exclusive_operation ]]; then
> >> +       _notrun "Requires btrfs exclusive operation support"
> >> +fi
> >
> > Why is it required to have the sysfs export file for the exclusive oper=
ations?
> > The test doesn't use the file at all, and exclusive operations exist
> > for many years, unlike the sysfs file which is recent.
>
> Because the report mentioned the following error message being printed:
>
> ERROR: unable to start device add, another exclusive operation 'balance'
> in progress
>
> And this comes from check_running_fs_exclop which got added as part of
> the sysfs interface for exclusive ops.

Ok, so check_running_fs_exclop() is a btrfs-progs function.

But even before that, and the sysfs file was added, it was not
possible to do a device add while there's stopped balance, no?

>
> >
>
> <snip>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
