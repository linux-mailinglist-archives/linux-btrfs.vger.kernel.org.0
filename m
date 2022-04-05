Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2404F2128
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiDECh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiDEChs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:37:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CB1FD2DE
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:35:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q142so8013987pgq.9
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vycd6UjcU4nk4tfpHK5TrbYH82L3zrEgFQ8vvI1PmeE=;
        b=57BlbF2hYe92x58pHSoPaRrvUXFkoSO8gOuGRSvvV0eSS8xc9+A04SI1qDcPEe1W79
         V9NPLmPBjYiOOLqtH6LhIyeFTClNMIQOfzTVmNrA8Cum7PB3ZXqWT9hp8KVwpYJ3Fnh3
         9c+VNJE/OSnRXpBhDg54m4tCfN56K7t+YpgGdmAI96NftnVlpS9JtSQS3B33Rq1vt+B6
         ZoIKv9eCdPilrUcU3KNTnJTmqwRLROpJAVEqXOneTQ+5Gd0JYd5NgLZ7qAeWqWaQCl0L
         cFUHyofeE+Y3p93pRRZcwhnENucrznbVGuwoYygagSrw49/KMRM+iDYAtVATebLEkazw
         +RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vycd6UjcU4nk4tfpHK5TrbYH82L3zrEgFQ8vvI1PmeE=;
        b=YlAwqWwKCdyLIHu6Gdr30EXld5qmho+I8evz9i+l+z/3U08YhdWIZxoc3ivZJaoWs4
         UBuvFDhdy/ilW5gV5OuaU1lRBeBNYRami4cSZK66DdoQ+WBkvC1WcJkoYUfAQq+40l6D
         S+LizLdm3m5xza3TYXGXfv52/E2o3Jh3Vj6rN0nhIOpSFr3Xi0ZsszPFaGqzAY9Fe8E9
         +GU2aBLX2i9fmij3W1hMP88Puxei+hOrvke+bJxKasZrrY7P/gC5RW61fdIWtO1l92sW
         xDWjxgt6QtPuMBBR9myM7epNQ0k3sZWOn3oJzZF2YXPrX0ApbcyVgYEAO0afCDypvwGL
         cfaA==
X-Gm-Message-State: AOAM530zqiWwd1Z6Mdh3zfkbLg2lcRO9Q4/rMOazyHh2hWySzHGpsJ+I
        6Y6CaQZUYr0Zez/psE8x03MB+Y4yIWuEu6RpuTyoc1cWzJZlUg==
X-Google-Smtp-Source: ABdhPJybivGZKQy1iD74HRhGcyqf8YVENV7ek1/mKrNv0gZ37YFGA2fTcQfz9De4arNR3wWM2nS8pX4be3qM4q8vinE=
X-Received: by 2002:a92:d6c9:0:b0:2c7:aba1:6231 with SMTP id
 z9-20020a92d6c9000000b002c7aba16231mr511952ilp.206.1649121757044; Mon, 04 Apr
 2022 18:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220404234213.GA5566@merlins.org> <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org> <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org> <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org> <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org> <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org>
In-Reply-To: <20220405011559.GF5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 21:22:26 -0400
Message-ID: <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 9:16 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 09:06:01PM -0400, Josef Bacik wrote:
> > On Mon, Apr 4, 2022 at 8:58 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, Apr 04, 2022 at 08:39:14PM -0400, Josef Bacik wrote:
> > > > On Mon, Apr 4, 2022 at 8:28 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Mon, Apr 04, 2022 at 08:24:55PM -0400, Josef Bacik wrote:
> > > > > > > Binary identical after rebuild.
> > > > > >
> > > > > > Sigh time for printf sanity checks, thanks,
> > > > >
> > > >
> > > > I'm dumb, try again please, thanks,
> > >
> > > progress :)
> >
> > Ok, lets try
> >
> > btrfs inspect-internal dump-tree -b 13577779511296
> >
> > and see what that gives us, the root we think is ok is missing the
> > part with the actual root items.  Thanks,
>

Ok lets try again with -b 13577821667328, and if the owner doesn't say
ROOT_TREE try 13577775284224 and then 13577814573056.  Thanks,

Josef
