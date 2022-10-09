Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8895F8BC4
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJIOdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiJIOdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 10:33:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829C922BF6
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 07:33:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b2so13329125lfp.6
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Oct 2022 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NWjjK0X49/8WGE04vIQCOT51Kq1QB4mCDgsn2pPsxMA=;
        b=q6JBsYxHTQI2ez0RTWCGg3ol4OEo1C/6X7eiEBWO8CTtIMu56UUJi8r0PyRT/0pY3v
         oZxIN6keZ5rc0Qvi7HsBhjQFYJETACPMX4gmVJKmQwOkND1MIHpeEj4DJ6/U0TpPwBrq
         P8YsRBqAFDoqVksBTlp3J8yAX2ydFDooNHuljgYUGhQkrvHrYH8pPADeRKKnDODAUJB/
         REPP2NgfjAwe83dXmAOdc+SddJCl7mdJkVnDjuEutRlOiB5c79La52v0oMPT5LA2LI3a
         kchy8zt6udEm7CdMhrFs7Anrgrqj/OeGe9WGzj90EqtpZw9aZ753TTgmBToBwsQmY9Kv
         4mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWjjK0X49/8WGE04vIQCOT51Kq1QB4mCDgsn2pPsxMA=;
        b=VaHNd+qukjm6+SF8mMGpGkKE8imwdX0jUyym+tUbrhxJUNKgoOSG5wxq2Yyc6oCPqF
         Dd4XAmEDiqGMRPWusO4cbto+D4lRXuLDo1/kdgT5SRtssNu+g0OlFLHiKiXuGTgW+2qz
         kwmZsCMzdXdy2NBoM8KC+LLDBs7lRVnWncqXWM3UAumIZrDpT79Ad+kUEjf45xQ4E5oh
         Ij/S63B2IcqpTcinsOPZ0HJIAgw0GJIBe0Oa1wy6feclxmwg4CU2cSZlO3x5b5ueUjnf
         sVxaCnU0PnZfKaj+1omLwJf0X/mZXXcmwI+Awa+gffwdDe1MTPerJySQan+oM0q9V5PJ
         K1WQ==
X-Gm-Message-State: ACrzQf06mMTQLeTBj3C2ytHcD6hQg1klwOO0wQskz5acyC04juSgMM1R
        f/C5AB03pA/WLdUdY/A1PHso+CBlyjfG00axVWap81Mw
X-Google-Smtp-Source: AMsMyM4i9iwAq7AJQfLy4UR/R3/v8jbSyqFoFe0bPIduFJjePv7hX9RbxGSOqnd7tQrzn0eCagRzQ9e22cish9P/1qM=
X-Received: by 2002:ac2:5e23:0:b0:4a2:6e06:e107 with SMTP id
 o3-20020ac25e23000000b004a26e06e107mr4544238lfg.256.1665326019391; Sun, 09
 Oct 2022 07:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de> <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
In-Reply-To: <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Sun, 9 Oct 2022 15:33:27 +0100
Message-ID: <CAHzMYBTWVrm6UAuyUZiRc9X7+xZhR79xaKXZtxAUuDG5tuYoqA@mail.gmail.com>
Subject: Re: RAID5 on SSDs - looking for advice
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Ochi <ochi@arcor.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 9, 2022 at 12:50 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> - Extra IO for RAID56 scrub.
>    It will cause at least twice amount of data read for RAID5, three
>    times for RAID6, thus it can be very slow scrubbing the fs.
>
>    We're aware of this problem, and have one purposal to address it.
>
>    You may see some advice to only scrub one device one time to speed
>    things up. But the truth is, it's causing more IO, and it will
>    not ensure your data is correct if you just scrub one device.
>
>    Thus if you're going to use btrfs RAID56, you have not only to do
>    periodical scrub, but also need to endure the slow scrub performance
>    for now.
>
>

I have a few small btrfs RAID5 pools and just wanted to add that for
me scrub speed with SSDs while not ideal is still decent, for example
with 7 devices I get around 500MB/s, on the other when using disk
drives it's painfully slow, for a pool with 6 drives it scrubs at
around 60MB/s.

Jorge
