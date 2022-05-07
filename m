Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA66851E94C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 May 2022 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386979AbiEGTCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 May 2022 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiEGTCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 May 2022 15:02:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0062E2
        for <linux-btrfs@vger.kernel.org>; Sat,  7 May 2022 11:58:50 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o5so6792134ils.11
        for <linux-btrfs@vger.kernel.org>; Sat, 07 May 2022 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkAi1ECof7lrh6fOXNTr4Jzh33F4kSjEKCdSfmpHhaY=;
        b=6fLQWW+SQgAduUV4ZTIlOQJkmQUTvuLSdIipmVJKKOA+f61kk20EaoaroszBrfAEuP
         lctSrRhpxCPdBWqVIpWp5znqXGg9I93E0bOJ527R2xbBni2lS5lavOsYRUb/ymWrWaE1
         fGd72h3WY2dZFbQcJCbyfRy7kKkzVTUxpJtyWXny8nd2wfkfAzsxC17QIhnCpmQ08dPM
         AR3r74WmhDWj+MEOOma0eNukI2JAvNrXrBYKSItknCLvlDwKC+RLtE1KCS+WqTeuTdSL
         lH3pM9aEC7U+IHAdqHVt6L3ErJpZo7+J3UGUJ+5xUE07xiZJVQRmvrrVzTDd0t+W8lrs
         lqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkAi1ECof7lrh6fOXNTr4Jzh33F4kSjEKCdSfmpHhaY=;
        b=PT7Eh69W4snB71EYMwK9EqbXAtpW5Stytzs8Caz1+TLr9MKbgjF+MTABeAuJclOY+j
         Afsj+aUoOEpSp+kqhW27w/Z0zT5Ka2+AxLZdI12wRXc1dLBRp2/q3bT72HR7XWeKgVnP
         eZYbX9Z/NmKw2QSf4j+N+sZQGeYJklJub+wRPOqJ5oOBSHxNiikHa0VMkv3v0p3gu1uZ
         hnGi0TeDSHOFs+KCDfz6rr6kLjKDgMgsyid9MQhlfylwhNKfNq6dQBOL7VX8JKWRmyxV
         njcUyCvdG4PsgU4Sdd+k/xzmcmypAt2cZneWZdBvYRckzTYg06r6lNyWnO6IquvwbwRf
         cClw==
X-Gm-Message-State: AOAM532P3AQ6LDi305cRcd4q1MeDypKjSQr3HjLb/WTsZNYBlNNu4fv6
        4ljbOK+OwpDcnAJff4IRluytvmO0OggG6SJB7Z7eg6i0N98=
X-Google-Smtp-Source: ABdhPJy86n7LxlmqVfRr/ZZ3F2Z32GM3SIsGYdBQr824KsQ5W2ev5XnEIyy8LN2X4668WAf9z7pz7eub/gyB1u4pSCE=
X-Received: by 2002:a05:6e02:1566:b0:2cf:12bf:aeb with SMTP id
 k6-20020a056e02156600b002cf12bf0aebmr3849731ilu.153.1651949929281; Sat, 07
 May 2022 11:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220503040250.GW12542@merlins.org> <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org> <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org> <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org> <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com> <20220507153921.GG1020265@merlins.org>
In-Reply-To: <20220507153921.GG1020265@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 7 May 2022 14:58:38 -0400
Message-ID: <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 7, 2022 at 11:39 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, May 06, 2022 at 09:15:58PM -0400, Josef Bacik wrote:
> > > > The delete block bit should be automated somehow, it's quite slow and painful to do by hand (hours again here)
> > >
> > > Agreed, I'm going to wire something up now.  Thanks,
> > >
> >
> > Ok I pushed something, hopefully it works and you don't have to touch
> > it anymore?  Thanks,
>
> Thanks. That seems to almost work and I like the progress percentage,
> thanks :)
>
> But now it seems to loop on the same one? I got over 50 of those
>

Did any of the previous ones succeed?  I hope so and we just have one
misbehaving thing.  I've pushed more debugging, maybe it's a large
file that has a lot of broken extents, in either case it'll tell us
what's going on so I can narrow down the problem.  Thanks,

Josef
