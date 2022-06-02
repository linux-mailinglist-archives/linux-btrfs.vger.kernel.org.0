Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025153BEE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiFBTgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiFBTf7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 15:35:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60756F59A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 12:35:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q76so571085iod.8
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYtmL0dkTuhA+HVUCnPIZCAH7nR4y5Hpcm4CKakXxTs=;
        b=CmMrtMOBv2xDKFT+PTVeOZQIANLSVZbHUzes2/esf8sAfOsq5OebmjDZuwr9UQI6JO
         uRLGHXB2BMnhA6uwPdu0QhikgYE3Er1CIy1cK+Ip38L7m/555UjUH8YWxaCourqktsrK
         fEX0/6W5msFo5RVdlarfd7exSfn/NGq/HBoTftpTxU8TL8E44DZ9Yt+/KDtiXjB3u8CN
         V33ts071NdnZC+USFqaZjMFy+E0H8SAHR4nKxdjGclr8e2xOHWXHsaSJakKfGFdYXBSR
         +f3NC4WZTOQcfz1OmVuVuHnrL19hUztgtUMNhEK2teehVXYNv+dmQ2LRxI0mdHGo3Gcd
         RvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYtmL0dkTuhA+HVUCnPIZCAH7nR4y5Hpcm4CKakXxTs=;
        b=6rA/q8FQ8FolXX3dPxALHGLLFducoHPuKlaVxqoavM+dB9+SuMJwXr+hmJ5/97rda3
         s9mXDWRw+TILnWL8FvSP++5PZ3rzenxeQQTm+xKqW3un5phv2JyDnr+43/eF7BloO9Dp
         lev3+0n18d+0GpyNHHaPAbkI2BAo1O8DuUDfJkxUw9XwjHmKW9T19oPmKo/66+3jNIHN
         Wx8WchaYr2ZlGQbevbwTkNVpi1pjAPYUR4OzXuoiNws/GYwdZE8WZvVkVjLZrg3jlQsP
         WifAcAsuS8i6uSzrW8N/Vncde1fdsNGSIh2vnqTl62tWnFWMzEOnZzLqB1kCe+JcudHA
         OUdg==
X-Gm-Message-State: AOAM533QMKEOGtyq+Zo97lipUyqENLuqogCBFy83JYnO4KuHoBBjTcKV
        FvYKQZEiONj2ycsoir8em53oijQ8B9A2IBFtckRdA1EOcWA=
X-Google-Smtp-Source: ABdhPJxLUkFtg8ZXk0Mw2X6rlF3nK1081GzQ/GWTg3qaF/s1CPe7OzvOt6MNjchQndCcYCZzjFtVCOOj1/JYLSzPRE0=
X-Received: by 2002:a02:a609:0:b0:32e:7865:17f4 with SMTP id
 c9-20020a02a609000000b0032e786517f4mr3850748jam.313.1654198557596; Thu, 02
 Jun 2022 12:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220602000637.GL22722@merlins.org> <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org> <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org> <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org> <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org> <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org>
In-Reply-To: <20220602190848.GS22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 15:35:46 -0400
Message-ID: <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 3:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 02:43:03PM -0400, Josef Bacik wrote:
> > Now we run
> >
> > btrfs rescue tree-recover <device>
>
> It got pretty far, and then
> Invalid mapping for 364837339136-364837355520, got 11106814787584-11107888529408
> Couldn't map the block 364837339136
> Couldn't map the block 364837339136
> deleting slot 0 in block 11160501878784
> Invalid mapping for 364837306368-364837322752, got 11106814787584-11107888529408
> Couldn't map the block 364837306368
> Couldn't map the block 364837306368
> deleting slot 0 in block 11160501878784
> Invalid mapping for 364746457088-364746473472, got 11106814787584-11107888529408
> Couldn't map the block 364746457088
> Couldn't map the block 364746457088
> deleting slot 0 in block 11160501878784

Was it printing a lot of these messages?  I was sort of hoping we
found all the chunks so it didn't feel the need to delete a bunch of
stuff.  Can you re-run

btrfs rescue recover-chunks <device>

and make sure it doesn't find anything new?  Maybe there were some
system chunks that it found that has the other chunks in it.  Thanks,

Josef
