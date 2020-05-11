Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49C1CD103
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 06:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgEKErG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 00:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgEKErF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 00:47:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106BC061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 21:47:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so9158861wrt.1
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS9czWPhR07pzFV+3JsW0p/5+Hy9pvtXQUaYuGP4x3U=;
        b=WXeNFqKvSB9RJuX9SXnSDBvy/y8U4Spmb8rPzq+QZCECz/WrtCj4Csf0Z1vTxZaNEv
         ctt8u8UjOQdNgVMbUPJ0bmIwNlUO+HbUshoTaPLnvTSTCJ7VJSXQEYX+9O3agYTR85Lk
         1yJXO8dtXS9j4msQ/mvKloR1gAGPX1UVTctujkiVeFJX3kZg9B8dH60L7C75ZndvtdRY
         Wyb2WKzpUW3wBOow4NZQSjw+Og9suiCr6TAlQPZ5eG+SmlekNXsmEp1TwiMhWVvakxjE
         E+95jdoKm23xavT2VK7mGNnuOPAWnJ2v1rLbFSabdzdZH/ECB98IbeBPcidHBnfZ8QXl
         BWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS9czWPhR07pzFV+3JsW0p/5+Hy9pvtXQUaYuGP4x3U=;
        b=Qbgorhfr3dKhvw1MgQCTh0fmRcj5Ly914FptiMfvEdcA7pM2W5H0m5ZegsoJRtvTY7
         XmI5d7hbh31+NdzpyciGin76a0ztY7WO16aGV8f6ATkSFREz1yAfH9rvOnptNYayvt1o
         uxEggd8qp0Cv6NkO8UBk7GG38wSLpiSY1sbQunMHLiXVVUoGHjRR/RGa6ayPdaDM79SW
         08aHHwGs8xnR+zngE0XGPa8tGDqnqdfWTCd6Ohe0UPcS4ZEN3EPWySndb8Y64rmzqQLY
         qBgxfskgXXI5tEhoyqVlr57VFTYAQPbGsfZbWUVo8na4mb8ge6e+LlnUhdMPySTK7cib
         V27A==
X-Gm-Message-State: AGi0PuZbEYbHDqmnXOWgth99TLjIzE4cEWwkEwntPx1Pu66neQqDe/pW
        kTJOoN9sN0sT2YdQfsE2ikG1azVhkYGmidlhfA1V1A==
X-Google-Smtp-Source: APiQypLC7fJAuMJQtm4rzqUy5bmIAxbD4X9llrPDp0f8AelwK1sSyiJFnAH7UFlO1v0/3+lfXUPGw5f/8pjZbfwdhkg=
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr16448127wrx.42.1589172423294;
 Sun, 10 May 2020 21:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au> <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au> <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
 <b41da576-55b2-4599-10e9-e8aeb0e9ad20@sericyb.com.au>
In-Reply-To: <b41da576-55b2-4599-10e9-e8aeb0e9ad20@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 10 May 2020 22:46:47 -0600
Message-ID: <CAJCQCtSWwypfm2xjtJ2vP8O4LT2bFOY=omHMMPe8_Jq6jG_3qA@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 10, 2020 at 7:39 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 10/5/20 6:33 am, Chris Murphy wrote:
> > 2. That a scrub started, then cancelled, then resumed, also does
> > finish (or not).
>
> OK, I have now run a scrub with multiple cancel and resumes and that
> also proceeded and finished normally as expected:
>
> $ sudo ./btrfs scrub status -d /home
> NOTE: Reading progress from status file
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) history
> Scrub resumed:    Mon May 11 06:06:37 2020
> Status:           finished
> Duration:         7:27:31
> Total to scrub:   3.67TiB
> Rate:             142.96MiB/s
> Error summary:    no errors found
> scrub device /dev/sdb (id 2) history
> Scrub resumed:    Mon May 11 06:06:37 2020
> Status:           finished
> Duration:         7:27:15
> Total to scrub:   3.67TiB
> Rate:             143.04MiB/s
> Error summary:    no errors found
>
> [54472.936094] BTRFS info (device sda): scrub: started on devid 2
> [54472.936095] BTRFS info (device sda): scrub: started on devid 1
> [55224.956293] BTRFS info (device sda): scrub: not finished on devid 1
> with status: -125
> [55226.356563] BTRFS info (device sda): scrub: not finished on devid 2
> with status: -125
> [58775.602370] BTRFS info (device sda): scrub: started on devid 1
> [58775.602372] BTRFS info (device sda): scrub: started on devid 2
> [72393.296199] BTRFS info (device sda): scrub: not finished on devid 1
> with status: -125
> [72393.296215] BTRFS info (device sda): scrub: not finished on devid 2
> with status: -125
> [77731.999603] BTRFS info (device sda): scrub: started on devid 1
> [77731.999604] BTRFS info (device sda): scrub: started on devid 2
> [87727.510382] BTRFS info (device sda): scrub: not finished on devid 1
> with status: -125
> [87727.582401] BTRFS info (device sda): scrub: not finished on devid 2
> with status: -125
> [89358.196384] BTRFS info (device sda): scrub: started on devid 1
> [89358.196386] BTRFS info (device sda): scrub: started on devid 2
> [89830.639654] BTRFS info (device sda): scrub: not finished on devid 2
> with status: -125
> [89830.856232] BTRFS info (device sda): scrub: not finished on devid 1
> with status: -125
> [94486.300097] BTRFS info (device sda): scrub: started on devid 2
> [94486.300098] BTRFS info (device sda): scrub: started on devid 1
> [96223.185459] BTRFS info (device sda): scrub: not finished on devid 1
> with status: -125
> [96223.227246] BTRFS info (device sda): scrub: not finished on devid 2
> with status: -125
> [97810.489388] BTRFS info (device sda): scrub: started on devid 1
> [97810.540625] BTRFS info (device sda): scrub: started on devid 2
> [98068.987932] BTRFS info (device sda): scrub: finished on devid 2 with
> status: 0
> [98085.771626] BTRFS info (device sda): scrub: finished on devid 1 with
> status: 0
>
> So by elimination it's starting to look like suspend-to-RAM might be
> part of the problem.  That's what I'll test next.
>

Power management is difficult. (I'm actually working on a git bisect
right now, older laptop won't wake from suspend, 5.7 regression.)

Do all the devices wake up correctly isn't always easy to get an
answer to. They might all have power but did they really come up in
the correct state? Thing is, you're reporting that iotop independently
shows a transfer rate consistent with getting data off the drives.

I also wonder whether the socket that Graham mentions, could get in
some kind of stuck or confused state due to sleep/wake cycle? My case,
NVMe, is maybe not the best example because that's just PCIe. In your
case it's real drives, so it's SCSI, block, and maybe libata and other
things.



--
Chris Murphy
