Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11684F2007
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiDDXNe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 19:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348400AbiDDXMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 19:12:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0D4992B
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 15:53:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 9so13185417iou.5
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWeV8tL/CKb80y/QjSse10ryS08EdM61P7oP8sLYyYU=;
        b=D94wmaUbUSy7toKk8ft80cSPcFNXvqLt380fOE0po+Lh5SQPj4v0a1xStu767HNLT2
         jq/epyAeAvj6BlTOmhZOeEyNDjeb5PQOW8m2wdjSIpbvUOuxtUmp/9+dX+QqOyLYaVyo
         gIUDN12ecQAvZhpfXXveyNC3jwzQH+kbCt3h4tmz+c6qg/mf+4weVoSAyViGghbBH7a+
         i59F4L+P3JuvjU+58r0zHQn9Pzojgrx1GJsRAX9c0Z2VeiAwXzFVk9YlHdNcZqlSHjo0
         xnXbdiKqxIMZPXxdSXEmMn4Va+IMBawmySpGzsDQlex/owjNsc+JvdXGwueSWrNFY6Zm
         dL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWeV8tL/CKb80y/QjSse10ryS08EdM61P7oP8sLYyYU=;
        b=E51SkhPqeZT1y5OySwl0Izx6cv1qtGYqKi88mRHNUpuJHQ4jh2vCbRiqS8o2OV3zWL
         JyMhTWn5HhvcRf5z9z6aNEyEBKZpyUN2ZBQHteBKU+CemZdeBzuyZpuLqfqk3E9jDb+Z
         aIe59J8iaJbgTAqcHL9j0rRnK64CKv5u4sicss46efeuGdvfciZZcLlHrMqBetfRwQjf
         vMkrGifO1msSpgDZbJdfiP439W0UC+7rmmhZpUjnpnd1eQNjlxG4beaPNeQ+VWb85wwQ
         FeEDyYT8cG7uo0N/tWvH9MtU7AU1lLpHeqVL1RtmvRgViYPB9wyxye+kSMXzxCiMB7hK
         fFHg==
X-Gm-Message-State: AOAM5327YYWL+Rzdh/yA5/QiSDCxdNkfVpxuNrMfi9Qm05BvodV1l1Cy
        cduJzuozmdfeb0b//2Akdc/m7HJigZOuf91LJ3yS/g==
X-Google-Smtp-Source: ABdhPJwwOE8vci5JtYkr929qxrQYpDJwe93sXtgWmp5RP7n6FLeDO7aWwrh0w3gksuxYRDZMPTlE+PrGDBXnhrNbCkU=
X-Received: by 2002:a05:6638:b1a:b0:311:4aa1:6c36 with SMTP id
 a26-20020a0566380b1a00b003114aa16c36mr361707jab.281.1649112789312; Mon, 04
 Apr 2022 15:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220404181055.GW1314726@merlins.org> <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org> <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org> <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
 <20220404212951.GG14158@merlins.org> <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
 <20220404220935.GH14158@merlins.org> <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
 <20220404224503.GA11442@merlins.org>
In-Reply-To: <20220404224503.GA11442@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 18:52:58 -0400
Message-ID: <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 6:45 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 06:34:39PM -0400, Josef Bacik wrote:
> > Alright, lets see how fucked this thing is
> >
> > ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal
> dump-tree -t ROOT /dev/mapper/dshelf1a
> btrfs-progs v5.16.2
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Couldn't read chunk tree
> ERROR: unable to open /dev/mapper/dshelf1a
>

idk what I expected there, you can pull my tree again, rebuild,
re-run, it should work this time.  Thanks,

Josef
