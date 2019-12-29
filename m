Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598F912CB28
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 23:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfL2Wcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 17:32:43 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53139 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfL2Wcn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 17:32:43 -0500
Received: by mail-wm1-f45.google.com with SMTP id p9so12702234wmc.2
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARaDtWkq09dnS7x6Uu2BSVOHcYe/fT5+XhkRuhsQs6A=;
        b=aUz8qzWwadJJgZjyBNuA+Ujfz5i/3IzGjmyAorHV5VDbzXO1jr2V46TMMkD4iwewF4
         AAJbd8BuKovdZmZzERgaL+eH5iE0cs2jO3LplgOUIBXSkCtbltoYWJgmt6KijRVT9Nrz
         8sPjGecFDUxCs+Y6/w7fg649+tf6f4vIpG3Icv3L4fdmQepMYUIp1u5WQPoZbGD2OMup
         FIHLiGWdjGHXbJVUcRyp2ey7AwewP2pQPg9cJ8zecK2S2QBMg+VemmZBoBBRPXdv38K8
         D3haYQTDjJZ8tC1RaOOoDOPZ0COrpmblwOnXxXc5yL+xc39FAS+GpdgHC3jyF8Jvsdzv
         kZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARaDtWkq09dnS7x6Uu2BSVOHcYe/fT5+XhkRuhsQs6A=;
        b=lVJRrau5OTwP41UrSjaSRbEe74GGSula1jVAaOKoNQVdetd7Q/rZ7I6+ftRE02aMDv
         qJITIDYs36ZhhTNq3FyCEIjQvcuasUi9xD5Hz5qtTyOQMSvOV7nE6HPcSx+kqnPRMxe7
         cocUmdrT/+O7eVbbT8fR821cMG92Xp4beKwm8B4BWyIm7SWOBTexto/2t1gq61Y4R1aN
         oLLSctd/9Z8RCOaM4njcepK953TSpVRwrrkDCnSivAxj2yxUMjLOTaYhN0XB1UevY7Ub
         d870HzI5j3pae/S6+EZRXOIkeUI37lW5ApDjHf37ZhYhQmP0BYrurWKIx1gDr2D6Xrq5
         bR8w==
X-Gm-Message-State: APjAAAV1JGEPUMIJrSTbSFuKuuoKKQZZYGdPtZO6FhHAa26HiCb/conW
        OMidmTqod/lbtE4q3z1gJEpilkxckz/m3pW1uQ7/l1mkscs=
X-Google-Smtp-Source: APXvYqzmogkmzfXR0DBFYH5qzVwn33tarHnv5GCY/FF6VCa/2upydTDUsh7AE45c/QX6EXxoqrHfcnnKzqIjqR9tJ1I=
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr29584169wmm.44.1577658760956;
 Sun, 29 Dec 2019 14:32:40 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com> <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com>
In-Reply-To: <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 15:32:25 -0700
Message-ID: <CAJCQCtQogopy56foRdqb6+3ejYL=gofVyYKwoAWFjYRgyaVZew@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 3:28 PM Patrick Erley <pat-lkml@erley.org> wrote:
>
> Should I --force it while mounted, or run the checks from RO mount status?

Check isn't reliable when the volume is mounted rw so I personally
wouldn't bother trying.


-- 
Chris Murphy
