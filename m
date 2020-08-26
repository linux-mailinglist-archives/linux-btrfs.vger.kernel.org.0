Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01C9253988
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 23:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZVJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZVJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 17:09:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DACC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 14:09:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f7so3302575wrw.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3u1rCE7gafjMRsudujyf5pzmfpNncQWB0VHwUkFMGHw=;
        b=pGRPS6U0pa9KVzMT3mAIVne7JcY5vWyNFhAAK5Cnn6f+4j7yIiK6wb4fo9hny48F02
         qgXqmbHb4gLqvw5kWXSfKqGuXCaDytdT/xpk6pC3tkA+L+P1+aMgznSAhvCyynzwfEog
         xZpc2KMUohItF8ZRRZ612PssTpX4CaiyQTDRvfGUrEvUvkSucw2DQnAnRSgP/eIfQx/I
         OC1if4fuJEoT6tJGMyUPBhVYTsT4c2aIv72gCyYKQXo+sQXkZLGHQlM5r5SnSArGXRP7
         G2Wv9tf2eaH2WyqZvOuyGHVnvxNdpib145KI07wkH6tZBLC8BG/0+xfC7Seyy1lNzvz5
         eEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3u1rCE7gafjMRsudujyf5pzmfpNncQWB0VHwUkFMGHw=;
        b=eI41poTWWwraIVBy6yWiCyIGx1EoZH/9rEJw6+XCOy2LDqNmsX8gJSYGStVLgHHwOS
         TX4PnesTJlBPyWFRQMkeOzOAdneNSlBoFG8GuJssWtbwdnIB/O2JMlZlM0Aj5t/dN8EV
         cvwUTbf5nP/3KGRS36KVM7F3//sJpiQgfZtIUlwqFwFyhOToJmUsbhF07Wr1PkqKW1Zm
         yJMaeYWr8d6n2vvt3Yc2kbj7b8Ix5QzAxYLWK8gw0wfucZ99cr4wKemcC968kromQ62L
         vc6XO5kqjHpMdUH7nzj4R4ul7BHKWdWKvlqrt2EPDCO27CqXSCu/V8GIv+eZRW3ASOOZ
         RPRA==
X-Gm-Message-State: AOAM531EZ7N8j8iWxZDnTYnIAWR6H+Tar2t1iN9QqWlWXGzK4S7le/SF
        WImS2MYbI5P921wK0fJZrGEVy3FWzI++L7H500URGg==
X-Google-Smtp-Source: ABdhPJwRHu26ASiTmNIy2ocgnQQ8CK6OM15gr3++ZJjy98TVneUKdkpAzJPqfWDR9WHZU2SypoJT5FhyrT3H2Pz55qw=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr16794442wrn.65.1598476154647;
 Wed, 26 Aug 2020 14:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
 <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
 <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com>
 <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com>
 <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
 <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com>
 <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
 <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
 <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
 <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com>
In-Reply-To: <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 15:08:30 -0600
Message-ID: <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrii Zymohliad <azymohliad@protonmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 3:06 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> OK is the sysfs output from before or after the homectl resize? And it
> matches with the second strace fallocate -l 300g ?

Figured it out. The sysfs is the first strace before the resize.



-- 
Chris Murphy
