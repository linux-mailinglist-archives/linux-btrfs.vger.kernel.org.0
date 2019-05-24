Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8A29A7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2019 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbfEXPBF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 24 May 2019 11:01:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37819 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbfEXPBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 May 2019 11:01:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id d10so8013486qko.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2019 08:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6WYsWGoo7KnyaxFuZ/Yh2ndGF4aNWjzfm/GfB52cjhA=;
        b=ZZ2qlPLWcc5CUhy+K7ocG9UlVpRNLhNZ+t4H9aNBjQEQdFvz7czyo7ncz19JtluwSI
         0nafPJ4qETagToMQJNcXhamL/YDOzDfMYWAKbupOAtvCoDzaV1xlMT804NTUOEpsC46N
         SK3LUF6iwp2X6ITRJeGvrfJaUTuiDnbDmLp5fw3uOn8+fiDPuF5PzNF3hXkPMDhYabOA
         QgB5kC1OcXjhhh+PxQxnGSwxo9xtorcryWFNgnstOBGWKg1DcsNyvjPKHrrnBMMNEbHP
         25rz9EgeDXKTjN6N4DZ6MK838151f5r1ZCxZpmcs/zgMvdz0rSb6qjJBsLEZDcxC+trt
         FcFg==
X-Gm-Message-State: APjAAAUs0wCNJ75lJ4CfCDhxr6GwUjsJTElS9OnNVMfYm6XTdWXaV1Aq
        mG6e4hRWNj8mjHlm1zoj3+MYoaTx9/xncT7TNrw=
X-Google-Smtp-Source: APXvYqxu0GSiJR70jmpkuZvq72awef6MIgh4RAEJVL2w0st/e9LariRPqUgkZ6I2jKxVfZfpabIkvvPkY+LLwmahUHY=
X-Received: by 2002:ac8:51c1:: with SMTP id d1mr578452qtn.204.1558710063995;
 Fri, 24 May 2019 08:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <297da4cbe20235080205719805b08810@bi-co.net> <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net> <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net> <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net> <3142764D-5944-4004-BC57-C89C89AC9ED9@bi-co.net>
 <F170BB63-D9D7-4D08-9097-3C18815BE869@bi-co.net> <20190521190023.GA68070@glet>
 <20190521201226.GA23332@lobo>
In-Reply-To: <20190521201226.GA23332@lobo>
From:   Andrea Gelmini <andrea.gelmini@linux.it>
Date:   Fri, 24 May 2019 17:00:51 +0200
Message-ID: <CAK-xaQZ9PCLgzFw0-YJ=Yvou=t0k=Vv-9JY4n3=VD2s=NaYL4w@mail.gmail.com>
Subject: Re: fstrim discarding too many or wrong blocks on Linux 5.1, leading
 to data loss
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     =?UTF-8?B?TWljaGFlbCBMYcOf?= <bevan@bi-co.net>,
        dm-devel@redhat.com, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Mike,
   I'm doing setup to replicate and test the condition. I see your
patch is already in the 5.2 dev kernel.
   I'm going to try with latest git, and see what happens. Anyway,
don't you this it would be good
   to have this patch ( 51b86f9a8d1c4bb4e3862ee4b4c5f46072f7520d )
anyway in the 5.1 stable branch?

Thanks a lot for your time,
Gelma

Il giorno mar 21 mag 2019 alle ore 22:12 Mike Snitzer
<snitzer@redhat.com> ha scritto:
>
> On Tue, May 21 2019 at  3:00pm -0400,
> Andrea Gelmini <andrea.gelmini@linux.it> wrote:
>
> > On Tue, May 21, 2019 at 06:46:20PM +0200, Michael Laß wrote:
> > > > I finished bisecting. Here’s the responsible commit:
> > > >
> > > > commit 61697a6abd24acba941359c6268a94f4afe4a53d
> > > > Author: Mike Snitzer <snitzer@redhat.com>
> > > > Date:   Fri Jan 18 14:19:26 2019 -0500
> > > >
> > > >    dm: eliminate 'split_discard_bios' flag from DM target interface
> > > >
> > > >    There is no need to have DM core split discards on behalf of a DM target
> > > >    now that blk_queue_split() handles splitting discards based on the
> > > >    queue_limits.  A DM target just needs to set max_discard_sectors,
> > > >    discard_granularity, etc, in queue_limits.
> > > >
> > > >    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > >
> > > Reverting that commit solves the issue for me on Linux 5.1.3. Would
> > that be an option until the root cause has been identified? I’d rather
> > not let more people run into this issue.
> >
> > Thanks a lot Michael, for your time/work.
> >
> > This kind of bisecting are very boring and time consuming.
> >
> > I CC: also the patch author.
>
> Thanks for cc'ing me, this thread didn't catch my eye.
>
> Sorry for your troubles.  Can you please try this patch?
>
> Thanks,
> Mike
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 1fb1333fefec..997385c1ca54 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1469,7 +1469,7 @@ static unsigned get_num_write_zeroes_bios(struct dm_target *ti)
>  static int __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
>                                        unsigned num_bios)
>  {
> -       unsigned len = ci->sector_count;
> +       unsigned len;
>
>         /*
>          * Even though the device advertised support for this type of
> @@ -1480,6 +1480,8 @@ static int __send_changing_extent_only(struct clone_info *ci, struct dm_target *
>         if (!num_bios)
>                 return -EOPNOTSUPP;
>
> +       len = min((sector_t)ci->sector_count, max_io_len_target_boundary(ci->sector, ti));
> +
>         __send_duplicate_bios(ci, ti, num_bios, &len);
>
>         ci->sector += len;
>
