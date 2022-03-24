Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8F4E6AFE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 00:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355611AbiCXXGU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 19:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbiCXXGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 19:06:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D5BA94F9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 16:04:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p15so12092596ejc.7
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=reHIl9Z6a1JFMZJwr9mXdc1HKHjaOwNPOwnk59zXHDQ=;
        b=qqvMYOqz/PoM/HTfJYD0t2ZD/jNmO5dZ3O1qt8il/GO6atSiOSpLbBjRkYgRuF7C2o
         mvEUD6k6MDpgCW5aC6ii9eil8VXEtRz1eJeJcOvkjQ2TS2unVUhssrYEUaFS/sa/CusR
         lZTemkm56Y+M+gsnqyw5ScmlW9tgDM5HK4+SNfdb6T1U/2LC6oy0HYW09oTPVYjZsx2m
         uZg5UT7fBadxVeqfCPDpsKCaLt1GRGT8PYk1IoNuLvfIwzbucntnu4NJGKf5iiKXoegX
         An2MbGg6LsRGNju0DGnkdT00v4qZ4nZcjMiLae3ksRIMGBl4R9jT+m3sGIwqOmsEx2OQ
         Fc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=reHIl9Z6a1JFMZJwr9mXdc1HKHjaOwNPOwnk59zXHDQ=;
        b=oluuaWlupkzFn1Sc2ewIggXCYriwiln0TgV4yEbUFzayaSXu5Xjz/wUc9AtbJXhx4N
         kLRihNKtb6rcUcSGxfbpaQu9/JFfzQykBNUiioreCiaC6egwT2agW2lRbDw4t1LzRKL4
         6vvqH9WmhQkkzVYzSlrNx5d1g/YIYtDMlV3JPKcuApFCie0LxXTZkaZVp/Rjf3NuOYbr
         PunHJKv24uAf/i9LlF0OeTG3fFhRWBYnYwMCMnvoVyOUYAzQd9aGBxd/7jz/2OOgIM5K
         lxX1RmO02HVdBPfZYjLLl45MgAuBFZaqJfqpm7Euj4rqeQgL1T7/pNfl0YljwHEB9m0D
         G7wg==
X-Gm-Message-State: AOAM531LvfNxAUXyePkTaM8zOXvOoNIz8E2pkhXBmoV2DdOrvDBA7wyn
        dEcBTkZWUbxKOdpL6laIU577QICEggWz9+3N6996VjnUKECd0g==
X-Google-Smtp-Source: ABdhPJzNMqJ8roRDfXwIWje8w5jZnXfsBAnouK6jerJx9Qj/7lJ5QbfP+/ieLTXDvGAGHBo6vSZMXyfazRQNlg0qaaY=
X-Received: by 2002:a17:907:97d4:b0:6df:ad22:f9c with SMTP id
 js20-20020a17090797d400b006dfad220f9cmr8168108ejc.680.1648163085688; Thu, 24
 Mar 2022 16:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
 <20220322202424.GJ12643@twin.jikos.cz>
In-Reply-To: <20220322202424.GJ12643@twin.jikos.cz>
From:   Jonathan Lassoff <jof@thejof.com>
Date:   Thu, 24 Mar 2022 16:04:34 -0700
Message-ID: <CAHsqw9vD=iWo00-wXVzKAtV=8VsAPQQfbKB+WODoUFkXWgPjjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Add Btrfs messages to printk index
To:     dsterba@suse.cz, Jonathan Lassoff <jof@thejof.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 22 Mar 2022 at 13:28, David Sterba <dsterba@suse.cz> wrote:
> > +#define btrfs_printk(fs_info, fmt, args...)  \
> > +do {                                         \
> > +     _btrfs_printk(fs_info, fmt, ##args);    \
> > +} while (0)
>
> This is just a single statement, does it need the do { } while(0)
> protection?

Not really... this style is just a habit for me when defining any
macro in Kernel C that might have the potential to be multiple
statements some day. I'm down to follow up with a PATCH v2 to trim
that out and minimize the changes.

> > +     printk_index_subsys_emit(                                       \
> > +             "BTRFS: error (device %s) in %s:%d: errno=%d %s",       \
> > +             KERN_CRIT, fmt, ##args);                                \
>
> I've looked at printk_index_subsys_emit and it does not need the
> arguments (##args), only the prefix, level and format, though the
> arguments are consumed by the macro.
>
> I'd rather keep it simple and drop ##args in this case, unless there are
> plans to make use of that in the future.

You are right that this does nothing and there is no need to pass the
##args through. I'm also down to remove this in a PATCH v2.

-- jof
