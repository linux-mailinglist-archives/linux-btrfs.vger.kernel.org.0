Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5662834C0E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 03:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2BNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC2BMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 21:12:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42633C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 18:12:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso7683673wmq.1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 18:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXFZ7dsSYS/7G0NYzOk/YXKkvO4gzJ4nGS+2SojLMJY=;
        b=0SQJzxYXve9LpDNWlvcApRTN3H1aOkJX7lEvCZ3iTHycNYd66bfIkUO1RZGZlm6QU/
         raWIWRrTpHmHpolfETnNhYK6pyFxrDEcdAbeSEXbNBaw7xA6nj1vGkWQUuBfdIBtHPQW
         JwR3xICtQPKSpqPwNoCcnk0OrCOwbASBsCMqn056shQ7hk2Yhn0IBu1P5cLbqSceJ6r1
         dSbsag8CeWYBbbRQLUibMP9I4FPlMoa5DGvD1I7CHcLgOIgDql6VBiY2PJs0f06Z17sA
         f9FyOOM/Mv+DZ+x9SzTjpeXoyZ2jKjw62Hcd/AKz6IWuAdMu9XoMKW3bbQDecsaZ6dDq
         dcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXFZ7dsSYS/7G0NYzOk/YXKkvO4gzJ4nGS+2SojLMJY=;
        b=ITeXBO/Eqf3nANwt2DvxTkC6jAHgy6qrL8RhnaHu0yPz8YpvIedFZIEYzjwUNZ/QGA
         eqe9ycm/zyF/hHu3zavlGp0/qa3h73dV1n9dQfVAyxrWx9yJ/qZhU1RFie63OxZ3TQJs
         Rii2U9FC8jAOFexHWfopQKuVZdEFuSYLOWe9yxIEkFtTjTHILcKRPbllAjsyLEXjWcer
         Ccsobr2pYbFyRFGm1LsV7OIURqczh7PGokbZwlpdo1plQzA34UX23dM8ZsGVjfBtLlE+
         M91gR+7RH183006lPhV9xVZFF2jgNzBfBEBD/LmSU3e3enCj4S1I660IFjqWJxsauEeJ
         CFQg==
X-Gm-Message-State: AOAM531sQyd93AfQl7QUdePe7dyMkz2RkvnTtbGTuQ36At6BolHlmSQ8
        F9UVLn0yavwxXbsZwiknbQgr7x1BGjbRJeyvnJeVZw==
X-Google-Smtp-Source: ABdhPJzSh5M0/F9INSTBJSvIR0CZHUrUJfNpzZEEtxcZ7VMg/DYYLw8Z82sXjD0/GpgNmsFrln2RHCdvHVlG7SV1wII=
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr22891328wmc.168.1616980368080;
 Sun, 28 Mar 2021 18:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com>
In-Reply-To: <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 28 Mar 2021 19:12:32 -0600
Message-ID: <CAJCQCtTKwWT7rp6oQiWzhLXCU9zS=AuWA_NnGrtbhV0KK0Bw1Q@mail.gmail.com>
Subject: Re: Help needed with filesystem errors: parent transid verify failed
To:     Chris Murphy <lists@colorremedies.com>
Cc:     B A <chris.std@web.de>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 28, 2021 at 7:02 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Can you post the output from both:
>
> btrfs insp dump-t -b 1144783093760 /dev/dm-0
> btrfs insp dump-t -b 1144881201152 /dev/dm-0

I'm not sure if those dumps will contain filenames, so check them.
It's ok to remove filenames before posting the output. You can also
use the option --hide-names.

btrfs insp dump-t --hide-names -b 1144783093760 /dev/dm-0

It may be a good idea to do a memory test as well.


-- 
Chris Murphy
