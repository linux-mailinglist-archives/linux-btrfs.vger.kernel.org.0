Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A33A47BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFKRUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhFKRUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 13:20:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD175C0617AF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 10:18:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ei4so6054902pjb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UXppqLkX5+zDdKE95awDQUS3d4O8fRgScba4RX4Ikc4=;
        b=VUA0jnZGZj1qd9bJxmI/L5iivbzx3U22MNlw9nZEx+YGOYJP+KM1b8pxMnJA6SMbVF
         mMmSOq9oQUZivUt6bs1utloWCzh6zOX7kgkv4ts+wJBrnPdW237h1HwwlPrmVOy7dbJk
         5d6M7mPiRjnC+pWMASYZKeeoaIM7YtvdMYsPN2ec7jZdH9CowpjljEiCEZEqwytrn8cW
         wNN/LSih/gzM5eiF0R74Q8FGJg7tHyeVtJJoIwUWRnn11TGpbXVQ3t15XF1hJSqFVUo4
         J7icPgPKkD8+9QCx05DOElFED358FKAD6cuzK90VLgK5Uk2mKaWfivZqsWUwDW4lZ+Il
         27Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UXppqLkX5+zDdKE95awDQUS3d4O8fRgScba4RX4Ikc4=;
        b=UEU8KW7cPGc93tIbOWhejToipgjt63oOCqNZoqeiQLaUOQsI1YfkFPn037YHJnyQYs
         bCEhhzLHfbMyAnQ6fYLiXX0H7sm69b2LW/m2EUEk6fWTZxuXpijLNsqGCu7iGY1V3U/R
         E/ccxlMY+SpNof9r+osvK+zdwQ0LLTgHGw/NbzC/rSGk96dKgJWgOSG7N8iHYz9MJosW
         s59V5MbKfuqlPOV+sdWNrI1njBHuBXkN7HAUZ5dfnJnAXppewUihqdSYlcxaAtt67BbC
         xDS5Tt0KK5IN5KqakgHoLEqV5UTWNXBwI93AKPmm7KU+/dkfoKlMwYNUNO/lcs+iw4UE
         emSA==
X-Gm-Message-State: AOAM533j2pgtNxny8QOY9Bha2VSMpPSjTOXfv8TlqTlEgLDDUWPS5wXh
        h7xoZnCpAC0H0M2IQX3Sw9I=
X-Google-Smtp-Source: ABdhPJxpe0oNEfwTrQ1cfCBqYNShvPgeFPYwG8L/FL6028OIVFq5T8AGlKDiXUvaV+PWww8Qdu1KmA==
X-Received: by 2002:a17:90a:474f:: with SMTP id y15mr10284852pjg.69.1623431936457;
        Fri, 11 Jun 2021 10:18:56 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t5sm5496051pfe.116.2021.06.11.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:18:56 -0700 (PDT)
Date:   Fri, 11 Jun 2021 17:18:49 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
Message-ID: <20210611171849.GA833912@realwakka>
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
 <20210515133523.GC7604@twin.jikos.cz>
 <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
 <20210518160623.GA38825@realwakka>
 <a907270f-26c4-be08-e149-b0e0f8f56152@gmx.com>
 <20210611142329.GH28158@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611142329.GH28158@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 11, 2021 at 04:23:29PM +0200, David Sterba wrote:
> On Wed, May 19, 2021 at 08:09:45AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2021/5/19 上午12:06, Sidong Yang wrote:
> > > On Sun, May 16, 2021 at 07:55:25AM +0800, Qu Wenruo wrote:
> > >>
> > >>
> > >> On 2021/5/15 下午9:35, David Sterba wrote:
> > >>> On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
> > >>>> On 2021/5/15 上午10:36, Sidong Yang wrote:
> > >>>>> This patch adds the options --delete-qgroup and --no-delete-qgroup. When
> > >>>>> the option is enabled, delete subvolume command destroies associated
> > >>>>> qgroup together. This patch make it as default option. Even though quota
> > >>>>> is disabled, it enables quota temporary and restore it after.
> > >>>>
> > >>>> No, this is not a good idea at all.
> > >>>>
> > >>>> First thing first, if quota is disabled, all qgroup info including the
> > >>>> level 0 qgroups will also be deleted, thus no need to enable in the
> > >>>> first place.
> > >>>>
> > >>>> Secondly, there is already a patch in the past to delete level 0 qgroups
> > >>>> in kernel space, which should be a much better solution.
> > >>>
> > >>> I've filed the issue to do it in the userspace because it gives user
> > >>> more control whether to do the deletion or not and to also cover all
> > >>> kernels that won't get the patch (ie. old stable kernels).
> > >>>
> > >>> Changing the default behaviour is always risky and has a potential to
> > >>> break user scripts. IMO adding the option to progs and changing the
> > >>> default there is safer in this case.
> > >>>
> > >> Then shouldn't it still go through ioctl options?
> > >>
> > >> Doing it completely in user space doesn't seem correct to me.
> > >
> > > Yes, It still use ioctl calls for destroying qgroup.
> > 
> > What I mean is to add new ioctl flags for the existing destory subvolume.
> 
> Which is what I don't want to do. Why: it's doing more than operation so
> the error code is unclear what it's related to. Either subvolume
> deletion or qgroup deletion.

IMO, If new ioctl will be added for this problem, maybe it operates that
delete subvolume and it's qgroup. I think it makes some problem. If it
fails only deleting qgroup but subvolume, it needs to return the error
that describes it. It is also duplicated with old ioctl that destroy
subvolume only.

I think the point is how to support additional operation that usually
executed with. If the solution is adding a new ioctl includes old ioctl,
there will be too many ioctls and it's hard to manage it.

> 
> A similar suggestion was in for subvolume creation to force quota rescan,
> https://lore.kernel.org/linux-btrfs/20210525162054.GE7604@twin.jikos.cz/333
> same reason why not.
