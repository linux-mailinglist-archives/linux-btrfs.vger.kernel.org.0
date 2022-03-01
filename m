Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8E4C8085
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 02:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiCABuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 20:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiCABue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 20:50:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D115DA7C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 17:49:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t13so12442743lfd.9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 17:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omAkmfjrU7R8vJQ3SUw3ervwoHHifwO93LattnVy2jk=;
        b=41m2h6V9PsnnJK+zOu1pRkEcyKhbZrG5WR5f6mjzTIjaqoZh/2o/LTSwmftA+eMOev
         8OqPaWzQ4KtMVedFwaQtBbKViesPcglG9JLGSnKDdoaWWtnVXwwieu2inbFUKHCKyzF4
         N40HuLNZjBzeZuDSBSM9QnYLsi/jjXGrQyHIgHwGtUBMPVR6+DjjRqPCmka56LsaGjiy
         BnPD68WcSe/fPm2NDPLGIsijLe3KJB6SuXb6yXurFG6tDyf2W/PdG/rKZ6zGZ+W2Qe7Q
         MzNK2pT9/rgqB+iRo8RBjK53p/mhJvPj3u72ChmGRfKCnvHIaVf5zEArt3z2H3uh2XsC
         G6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omAkmfjrU7R8vJQ3SUw3ervwoHHifwO93LattnVy2jk=;
        b=5qireB/+H/TF10qiW4hmGt195DsJslNlZngtDhbcwxhaGd4LXtZXEWz0jYXPVsWgFg
         LV5SvVXSB3SYuWUTizcTbdCVFnsKSkS1iZXSfEnHGnj9+nAAw770j96UvTwlIUraqQ5+
         vRpyVeYzvURELGLpNRVCdMSgiTxAMO9UJv3pG90G5QeI55r+2l8oa6wHQUn1RBU0MwG9
         0dvP6CgYxYBpb2Bfpst7+EIm0Z63jfyYimHsY758b6aGDcd4FDICyalb0kI049OCvTzX
         SVvuh98E3bdQpPz8EQjcUAOM7QMu12rf5ciVOIEOKvLtpv17Leji15KhT5iggamdS86m
         XZFw==
X-Gm-Message-State: AOAM530N7BbWhRtDq4m7uKj8m182EBlHnFXBVBJtfjHDa1u/FMDctSmL
        iv8+zT2TDll+FDOZPYcLslYveckU7ue2qw6yAyRjUgewKqZVpJT2
X-Google-Smtp-Source: ABdhPJyPx+toLspAYHi/HPgSpniNLQepGVbh232KOkK9RsjNsEgOR8iQLg2nvZdgB7ZVajrEqHr6XcdeLv6EetDwA+U=
X-Received: by 2002:a05:6512:2294:b0:442:7e24:9628 with SMTP id
 f20-20020a056512229400b004427e249628mr13945549lfu.357.1646099384879; Mon, 28
 Feb 2022 17:49:44 -0800 (PST)
MIME-Version: 1.0
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz> <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain> <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com> <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
 <508772bc-237a-552b-5b63-80827a5b268a@oracle.com> <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
 <20220228184050.GJ12643@twin.jikos.cz> <7feddd5a-856c-a525-a05c-fd682574aa49@gmx.com>
In-Reply-To: <7feddd5a-856c-a525-a05c-fd682574aa49@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 28 Feb 2022 18:49:28 -0700
Message-ID: <CAJCQCtRNFo4McC12z59+hxAuvfU6yk6GPCUtd=VtJ+rxaUZz1w@mail.gmail.com>
Subject: Re: Seed device is broken, again.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.cz>, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 5:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/3/1 02:40, David Sterba wrote:
> > On Mon, Feb 28, 2022 at 11:27:16AM +0800, Qu Wenruo wrote:
> >>> Ah. That's fine, IMO. It is a matter of understanding the nature of the
> >>> seed device. No?
> >>> The RO mount used to turn into an RW mount after the device-add a long
> >>> ago. It got changed without a trace.
> >>
> >> Think twice about this, have you every seen another fs allowing a RO
> >> mount to be converted to RW without even remounting?
> >
> > There's no other filesystem with a remotely close feature so we can't
> > follow an established pattern.
> >
> > The ro->rw transition can be done from inside the filesystem too and
> > btrfs sort of does that in btrfs_mount, calling kern_mount.
> >
> >> Still think this doesn't provide any surprise to end users?
> >
> > The RO status means the filesystem does not support any write operations
> > from the user perspective that go through VFS. Adding the device in the
> > seed mode modifies the filesystem structures, ie. changes the block
> > device, but does not change the VFS status regarding writability.  The
> > read-write remount is mandatory to actually make use of the writable
> > device. This is documented and I don't find it confusing from the end
> > user perspective.
> >
> > If you're concerned that there's a write to the block device then yes,
> > it's a bug that the mnt_set_write should be done just before we start
> > any change operation.
>
> I'm not concerned with that at all.
>
> >
> > There was a discussion some time ago if the log replay should happen on
> > a read-only mount, or any potential repair action that could happen
> > regardless of the ro/rw mount status. The conclusion was that it could
> > happen, and guaranteeing no writes to the block device should be done
> > externally eg. by blockdev --setro. But I think we opted not to do any
> > writes anyway for btrfs.
>
> My main concern is still there, we change RO to RW without any remount.

Well, it hasn't been changed to rw yet - `btrfs dev add` is only btrfs
kernel code writing to it, user space still can't write until the user
`mount -o remount,rw` and now you can write to the sprout or remove
the seed to replicate it.

> It's weird from the beginning, but we just accept that.

It's unexpected but I think the story is still consistent.

> If we have chance to rethink this, would we still take the same path?
> Other than making seed device into user space tool like mkfs?

I do not mind revising this so that device add sprout is only
supported in user space.


-- 
Chris Murphy
