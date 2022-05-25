Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337FD533F50
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbiEYOfk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiEYOfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 10:35:38 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865ADA7747
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 07:35:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j6so557071ilk.11
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXkPFjz1S/0dLTPUWpp4c+xhX6+L9vwzsu65ejlBgJg=;
        b=icHXkuopb6Ilfqd5f2rxog1CCXINA0CDDghGUMyQT4qYG/PCREsdqS9qA83C7xYBuB
         D1eeIy85lLIUL82XXPStjBPScsqADoAeYY8+3rBMmQcXVhYBX02h3mzjy4g+QROV3TDZ
         nwGsp1FIKYcy2Fyh8bC9YiYBziJi/NSsYnQfXstRznvvRrpSy8VuqXvlo/I5zkCtqUSg
         v619ec1b4p7JBNL9adzM25fyI4g2BtRYBGgurycDY8UM7IhxkZyQYSrgcCM4ri7TYBNy
         Rn69GM97KFc1n4hnWQQrfsdenW8snWjUCvbEX+MII3TzOjwuNZ+EWeX/tVc0Jy/bSRkY
         J8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXkPFjz1S/0dLTPUWpp4c+xhX6+L9vwzsu65ejlBgJg=;
        b=W1KtuKxsBVRfPmFMbinKxjjQ9PODrK7BDPs2Ex3troKnTl76lIZGrbJ9asoMmQoO2f
         J5FyQlavfNABtO25OrPmb2X8dI4OFcY3G/YvwvAPq4iOK34hthRbDfcUJUCMTXZDTJlD
         m2Mx1qFfwXUN4ptDYbAVPtbKwcpm/YijlHsX22wapE3xgV18CBLk+8xYJUmUaQFZIAQM
         GXXHXNw5eGEPhb7rM1//7ARCC9Axco8cH55iQ9IIsrDzsAGZP1QsGsJyQJccmfrQlXbq
         bOu1JJngwMtp6fBuuKbboGFRqPBzZ4CXf9haCDBRa9IudxLxIsQUpNlSaWeBoPQu+25G
         w+TQ==
X-Gm-Message-State: AOAM532sOhVuNXuFdOHDsmgy6F31vRwVc7Y20REM0tsDLgxGsOeJ9nAV
        4Tn+Ogmxm3CwrXmOd/imDgbhsq/VpOIftg16J0VjaNMHga0=
X-Google-Smtp-Source: ABdhPJxm2viy7XytysikB57y2dAEkMpZgYpqZi3rwieY1BRO6PL33fq2PeVx1zF7tLfeZMlBg5huSheJDOmO1kEBIek=
X-Received: by 2002:a05:6e02:106d:b0:2d1:e8e4:a59a with SMTP id
 q13-20020a056e02106d00b002d1e8e4a59amr313086ilj.152.1653489333835; Wed, 25
 May 2022 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org> <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org> <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org> <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org> <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com> <20220524191345.GA1751747@merlins.org>
In-Reply-To: <20220524191345.GA1751747@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 25 May 2022 10:35:22 -0400
Message-ID: <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
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

On Tue, May 24, 2022 at 3:13 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 24, 2022 at 02:26:11PM -0400, Josef Bacik wrote:
> > So it's 600k extents, not files.  Here you have the same file, just
> > different offsets
>
> True.
>
> > Right now I feel like absolute crap, my kids gave me COVID so I've
> > been fluctuating between dying and feeling ok.  Tomorrow if I'm
>
> Sorry :( hope you get better soon
>
> > feeling better I'll take a look at the chunk restore code and see if I
> > can't just put the tree back the way it was easily.  Thanks,
>
> As long as it's not deleting stuff it shouldn't delete, I'll keep it
> running for now, or should I stop it?
>

At this point let's stop it and try and get the missing chunks back.
Looking at the chunk rescue code it looks like it should do the
correct thing, can you do

btrfs rescue chunk-recover <device>

and let me know what that does?  Thanks,

Josef
