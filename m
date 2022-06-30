Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF115613CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 09:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiF3H4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiF3H4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 03:56:52 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 981F0403CC
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 00:56:51 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id E359C20D6D
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 16:56:50 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id w2-20020a626202000000b00527c208de00so3151857pfb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 00:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9tsQZpz4WXfPjbCLjHObeiUz+3sf+6cNHEEIAsk+90=;
        b=MzfTtjRgRGdgSHYt7PrqSPQIWa1FQSAUDNsVjKh/IPpVDiJSCs2mK7YwlFz+LYsakr
         FBPtAFfB39F4pLKWYOSOmCwdRu0vEptwhbmpaO155JTTDgtou3YqTjeTswoch5STnHHL
         H2SxQarmj2sOD1iaKKiu0yUlQnMM1IydHp8ofcZnk0/58gxTIayb8UnfvrvdyJbfzYrp
         w+nmts+2SX8jxG9wkvBDuYH8xXxD0rkOUK3fyTwmJqy39AGNhXm00j28hsu4zOFZ/B2e
         UjjKL7m4qgLr68SkcGhz7SZUE5Rq3r2yAyF2yaEOv4HG7OMk0uEWGwj/y4VF2NDYx0+2
         NZ5Q==
X-Gm-Message-State: AJIora80uULaVou4Ro3/GjwTjm70lIpYeuKjH1nmxmC5XUApTWUvWaOZ
        nRU1q9ybBPgG3Uz3HrSvkwPlsNcCU8rBzgQ1MqbnaOXWLdxBee6q2RC6rwX0dUzb1z/1jW6CdG4
        ury+WjZNkKJNkhCOEGGJesDh4
X-Received: by 2002:a05:6a00:b43:b0:525:2a02:8bdc with SMTP id p3-20020a056a000b4300b005252a028bdcmr13048101pfo.28.1656575809964;
        Thu, 30 Jun 2022 00:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9TO3Nut4uWam12T1dirwyrKo9EzD2QIjRE5kZjH/GMiseR2RSj/EpQ6fNmXLD298a94jMzw==
X-Received: by 2002:a05:6a00:b43:b0:525:2a02:8bdc with SMTP id p3-20020a056a000b4300b005252a028bdcmr13048062pfo.28.1656575809393;
        Thu, 30 Jun 2022 00:56:49 -0700 (PDT)
Received: from pc-zest.atmarktech (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id t16-20020aa79390000000b0052521fd273fsm12835562pfe.218.2022.06.30.00.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 00:56:48 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o6p2d-00BfJF-Ds;
        Thu, 30 Jun 2022 16:56:47 +0900
Date:   Thu, 30 Jun 2022 16:56:37 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: read corruption with qemu master io_uring engine / linux master
 / btrfs(?)
Message-ID: <Yr1XNe9V3UY/MkDz@atmark-techno.com>
References: <33cd0f9a-cdb1-1018-ebb0-89222cb1c759@kernel.dk>
 <bd342da1-8c98-eb78-59f1-e3cf537181e3@suse.com>
 <dd55e282-1147-08ae-6b9f-cf3ef672fce8@suse.com>
 <YrueYDXqppHZzOsy@atmark-techno.com>
 <Yrvfqh0eqN0J5T6V@atmark-techno.com>
 <20220629153710.GA379981@falcondesktop>
 <YrzxHbWCR6zhIAcx@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrzxHbWCR6zhIAcx@atmark-techno.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dominique MARTINET wrote on Thu, Jun 30, 2022 at 09:41:01AM +0900:
> > I just tried your program, against the qemu/vmdk image you mentioned in the
> > first message, and after over an hour running I couldn't trigger any short
> > reads - this was on the integration misc-next branch.
> >
> > It's possible that to trigger the issue, one needs a particular file extent
> > layout, which will not be the same as yours after downloading and converting
> > the file.
> 
> Ugh. I've also been unable to reproduce on a test fs, despite filling it
> with small files and removing some to artificially fragment the image,
> so I guess I really do have something on these "normal" filesystems...
> 
> Is there a way to artificially try to recreate weird layouts?
> I've also tried btrfs send|receive, but while it did preserve reflinked
> extents it didn't seem to do the trick.

I take that one back, I was able to reproduce with my filesystem riddled
with holes.
I was just looking at another distantly related problem that happened
with cp, but trying with busybox cat didn't reproduce it and got
confused:
https://lore.kernel.org/linux-btrfs/Yr1QwVW+sHWlAqKj@atmark-techno.com/T/#u


Anyway, here's a pretty ugly reproducer to create a file that made short
reads on a brand new FS:

# 50GB FS -> fill with 50GB of small files and remove 1/10
$ mkdir /mnt/d.{00..50}
$ for i in {00000..49999}; do
	dd if=/dev/urandom of=/mnt/d.${i:0:2}/test.$i bs=1M count=1 status=none;
  done
$ rm -f /mnt/d.*/*2
$ btrfs subvolume create ~/sendme
$ cp --reflink=always bigfile ~/sendme/bigfile
$ btrfs property set ~/sendme ro true
$ btrfs send ~/sendme | btrfs receive /mnt/receive

and /mnt/receive/bigfile did the trick for me.
This probably didn't need the send/receive at all, I just didn't try
plain copy again.

Anyway, happy to test any patch as said earlier, it's probably not worth
spending too much time on trying to reproduce on your end at this
point...

-- 
Dominique
