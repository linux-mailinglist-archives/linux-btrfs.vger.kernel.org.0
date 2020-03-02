Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24C8175272
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 05:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCBEFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 23:05:03 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:54947 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBEFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 23:05:03 -0500
Received: by mail-wm1-f42.google.com with SMTP id z12so9508404wmi.4
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 20:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocmmlV/5YRVgqAzxR1L4i1Vz5B5OnbFwUhtdQ4WD/0Y=;
        b=ZtxwQTwMohpA8/pxwfBjPJ33fzZlSfMWBdAIRXN+1C+PLhvlLI+SiyvMkc45N/kCHJ
         5Z+z6SroGI3nSaCIohi+8L1iirk+PP4tckah3iPNbD9YMedcaVGwg+SWJLGMvxTFvyLe
         LvlVAGBXi9+n04tJgv6BU0lMSn5EETLE3YVlL3Y+QnYPb2mWl+E7LSIG2SfOFWsu8+4r
         QDDWrvE8ZeIMSQyLhIg/RJFtM5D+T4EcpU385AQcVHCDGZxsCn4eiVIfylsDQDBnI+F6
         AQDUI53QgFbp2V0y1jZibTYWIYKBpXPid/lquVlOpViRiDRuaEZAyz/09JpKHaXss9oh
         BEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocmmlV/5YRVgqAzxR1L4i1Vz5B5OnbFwUhtdQ4WD/0Y=;
        b=f/bPG1cDyv+ovJ8yrZmiw5QzncdazVJIVUsjpxPDYl8+oxrnrvsqO8q8Mnr23jDhsp
         szNqwg7eixY5W935cgNXThKHTuvE4SsNHa9hBdhia13sxvx1G3wvJ6m0DSwo2kdvhlpY
         eVzcF5+zlOxelJvXd6rW0yK41a7jjtLXOAUdDyng/t8fvA+/OYrMaXsGPJUl4d2AVPDP
         bCvdclsLkevUn3BE/WJ8YN/B1FjL8n0tC/PysN55PZH1LTuUFf7G441NCIeKG7S1QDlv
         inMPdStoEklUwng+v7dhwXzIF/DFHF0ufv21vc4ra+kQ+yjn2joHyPykPCYEAI0najbA
         te4g==
X-Gm-Message-State: APjAAAUUUg6Hk5k4ig878eA+Tuf2Ix3mvYDrM5hy+u7twUvzrm65y1Df
        Z3J3pRqHzobsEMT7trTZCi6r4Kbtgm3L6E3w2P/jEw==
X-Google-Smtp-Source: APXvYqyx8ZDGlz8foM+fs5DRimCAM3/hpWa6MzH0LoGiAB3AIM6+Ry4vkQXx3IGBxbl10KA5gWW5q2Lf1QXcunz3v/4=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr10706617wmf.168.1583121901965;
 Sun, 01 Mar 2020 20:05:01 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
 <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com>
 <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
 <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com> <CAG+QAKUuLz0jewrrBOxuQQUvbSBBBrxBZgfabFzn7moJ9Ka55A@mail.gmail.com>
In-Reply-To: <CAG+QAKUuLz0jewrrBOxuQQUvbSBBBrxBZgfabFzn7moJ9Ka55A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 21:04:45 -0700
Message-ID: <CAJCQCtTROLooGiR4OixEqJKEqMHiOq_Hwndw6EvK2mam1vvG0Q@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 8:45 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
>
> On Sun, Mar 1, 2020 at 6:38 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
> > ...but that's what I'd expect the balance to do?  If Block (Chunk?) A
> > is on, say device 1 (4TB) and device 2 (2TB), why wouldn't it move
> > Block A to the new drive from device 1 or 2 in order to free up space
> > and balance/spread out usage across the drives?  Is that not what
> > balance's purpose is?   Or is free space required on 1 or 2 in order
> > to move the allocation to the new drive?
>
> Am I just not taking COW into account?  It rewrites the chunk to
> reallocate so needs two destinations?  There is no "move"?

Correct. The block group is a single unit, there isn't (yet) a short
cut to COW just one of the two copies to another device.


-- 
Chris Murphy
