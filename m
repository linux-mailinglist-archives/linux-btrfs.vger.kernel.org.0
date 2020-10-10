Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55D289E0B
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Oct 2020 05:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgJJDnM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 23:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgJJDeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 23:34:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC75DC0613D6
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 20:17:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k18so11554898wmj.5
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIFHa1bzTKj4ECt0oZoDalXZS1KmUfTQvW5B5SF8DOE=;
        b=hveAn7QtJKtXY5/KAtzYxjwNY+pK5tnRwoFXIo5bcs+OnD1WiJHab9Kx1OEINTyMvQ
         fmCBMVu4ElDdF4zrH5Gy5joBj80/pYsQWQp1TnKipy2gdj6b/jq3gwDSTj3tV0+ekzXJ
         BfBhWkdarToCk09a+1TMixtLKVegqBAOVI0FW3sDbe/5hX1/OFiRHHh5/hf9EqPesNrM
         /09G1cfpUlwF/8Iq8uQyqRWIXh5akTlc0UstQMzqxNZ2o+fs3RY+PfFG8El2c+A3qms0
         a5OQ3NZOMDSECEFR2TEfHz0eOFzQm72be3mRmn8czec/FXi4iss0NMJ/WMjMkx1abeGD
         WQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIFHa1bzTKj4ECt0oZoDalXZS1KmUfTQvW5B5SF8DOE=;
        b=dCx5RX0bV7fjIoZsXFzi5/IkvzLqsIzUa8rYCk5ZyKweKEZT4c29sJ/mrY6OHvj2Ub
         4kKDu6WKlxXJwV4DddCvn41nN6WqpCU3rjwfC+DMEbgGNDQJPl9MlIWpG2ErAdunM38P
         up50JwijPT3zeQ+zvIAA8YoHAFO77lkmg/TWVbZ3HtjZA6wfxv0hGewuxmoTWQWHaRT0
         E8ZOJ3Y2wMT2sioHwRCgfawPP5qtfjWfGZ3ZSXycQhkRwBzm6emPmOR0J018ZkBc1ZXX
         TL71eejlld2SHj1TKsFu6Lop43ilbF5+lgp2qsmr9SPRLZoEge9Dn4g4orDpaphf8KhU
         aESg==
X-Gm-Message-State: AOAM533tCrXFeTpHmcjAV0Gdwu78O68R+zePC15sLgWyRV181nRUgUD1
        ZllQcFaNej1jLF2Bq+Yg+0UHakCEHtEznvCKcnitDA==
X-Google-Smtp-Source: ABdhPJxV84wfEF2PWGTd0CVpwm14OEEgJ9BhI9G3/NlnuJWI5O9wfnRXgDVa352eqoJ6T74w8iONHIhcrVQvzSNYu/4=
X-Received: by 2002:a1c:960a:: with SMTP id y10mr800775wmd.128.1602299825421;
 Fri, 09 Oct 2020 20:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com> <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com> <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
 <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com> <6BF631F4-3B9D-4332-AC42-2BCDE387322C@icloud.com>
In-Reply-To: <6BF631F4-3B9D-4332-AC42-2BCDE387322C@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 9 Oct 2020 21:16:49 -0600
Message-ID: <CAJCQCtTvTH7XeA1F3nd011-X4vVUZJ15zRN2HK8cOL722oJ13A@mail.gmail.com>
Subject: Re: Drive won't mount, please help
To:     J J <j333111@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 7, 2020 at 2:31 PM J J <j333111@icloud.com> wrote:
>
> Thanks Chris. The results :
>
> btrfs insp dump-t -t 1 /dev/mapper/sda-crypt | grep -A1 'ROOT_REF'
> parent transid verify failed on 2639007596544 wanted 395882 found 395362
> parent transid verify failed on 2639007596544 wanted 395882 found 395362
> parent transid verify failed on 2639007596544 wanted 395882 found 395362
> parent transid verify failed on 2639007596544 wanted 395882 found 395362
> Ignoring transid failure
> leaf parent key incorrect 2639007596544
>
> I dont see an output like your example

OK we'll have to find a tree that isn't this broken. But what version
of btrfs-progs is this? I suggest something relatively recent 5.4 or
newer. 5.7 is current.

btrfs inspect-internal dump-super --full /dev/

That'll get some possible alternatives for root tree. And plug that
into 'dump-tree' as the value  for -b.

btrfs insp dump-t -t 1 /dev/whatever | grep -A1 'ROOT_REF'

becomes

btrfs insp dump-t -t 1 -b <byteforbackuproot> /dev/whatever | grep -A1
'ROOT_REF'

There are some other ways to get info what's in subvolume's, using
dry-run or -d to get a basic listing and then infer from the output
what subvolume it is. Older subvolumes (smaller ID number) might be
more intact. But they will also not contain as much current data.

-- 
Chris Murphy
