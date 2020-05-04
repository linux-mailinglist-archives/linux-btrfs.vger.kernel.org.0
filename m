Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479A11C4673
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDSzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDSzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 14:55:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3576C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 11:55:09 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f13so700127qkh.2
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b55riKebKIuodP45FjgT5oUWng13z38QCNAKl6Q6iZs=;
        b=nTZlPKyCKfCicG7hseEz4EDY6WB8gJX25vEBcTgExO41Ma3T2YmteqmECZVOgLKqCI
         F2wO5YVU7FYxNzDwYTWSJ4E3BBYNM5C2T/OQoyfxl9YFSalfYmsKrVHYvfBjxFgoHhsI
         K5gtQWPFftW7wy/gLn/zffTjLEZ3Gw62kCfHd/YQwvCMxlpcHPjGWqNgiiJaCeE/LKx0
         NOfAIGOF5cALf8AkdOk42fHBE8E41zgsUCgGAN0psGAVuhh1t6GgvxKAQyXFUGEANs+M
         xhcEebhFtywSOJexaPjSgEBzwb2/FFnWBj2nFWL0jM4tyAkav+vymNHCe7rtN5RdjNS1
         VCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b55riKebKIuodP45FjgT5oUWng13z38QCNAKl6Q6iZs=;
        b=mXzAfW/C6WAGJHhUAtpExGzeu1NW1jcOTiIdAWzckl+r8H6EgZVXawZSaYSgwlTBL1
         eb7xjLvW0CffsQ1UlWgMYrwZdcfBAK/XIZ7ptf+Vdarq+jXTeLzf7JsdFYHiqlIhbBTi
         MS2/F5YYKsapm+5LyDr5Ycd3ZQdjwj2KRvD8wzkGtoKeIOty9/NQXopRD7vHZTX3K19k
         77QUbRqa8W8NuVRY2CtquohBFnDzDf6fLdMRSjFDzq3LmpFdOpNlAsuZC27zGeKYrflk
         8afANpYTgLp4iD3hYXQmSIeZLtDG0/ytp7ubKNU7vHgTclVjdSKErHsNP0jyijrU2CpD
         jl7w==
X-Gm-Message-State: AGi0PualGXa1phGIc5D51A1gBNGYaZvciHwyxMy8VbaD5EM3WAJ5ialF
        u1enbi6vCKyigD8KnMLT+8FZRKL+9mwfy1vO4uRwPKVG
X-Google-Smtp-Source: APiQypImhb+r7OatxMqyS2E+SuG/uxGbN9JZfgLXuVvnvdicKdz7eJ8k6xdfWXsekaKsD9RHvVz91s0+JGOlxBhF+bo=
X-Received: by 2002:a05:620a:662:: with SMTP id a2mr634956qkh.304.1588618508825;
 Mon, 04 May 2020 11:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200411211414.GP13306@hungrycats.org> <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org> <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
In-Reply-To: <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Mon, 4 May 2020 20:54:57 +0200
Message-ID: <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
Subject: Re: Balance loops: what we know so far
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mar 28 apr 2020 alle ore 12:00 Qu Wenruo
<quwenruo.btrfs@gmx.com> ha scritto:

>
> Would you please take an image dump of the fs when runaway balance happened?
>
> Both metadata and data block group loop would greatly help.

Hi Qu, and thanks a lot for your work.

I have a VirtualBox machine (in save-state) with the problem running.

So, I can send it to you, if you are comfortable with VirtulBox, or we
can work together on my machine.

Short story:
a) system running is live CD ubuntu 20.04 with kernel 5.4.0-21
b) partition of 10 giga (not /) mounted;
c) shrinked to 4 giga;
d) then removed files and left just 59 mega of data;
e) started balance -m (not -d), then it loops forever (or, at least, I
left it running for hours, guess it should be enough).

If I reset it, at restart no more loop.

Thanks again,
Gelma
