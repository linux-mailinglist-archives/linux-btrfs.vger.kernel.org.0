Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9121DFBD3
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 May 2020 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbgEWX2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 May 2020 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbgEWX17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 May 2020 19:27:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81502C061A0E
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 16:27:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so9578939wru.12
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5BJFefnoM9qaF31uJMNY/NaA4gXihdlifYkpP5dew4=;
        b=L4LjoX/6r6/+LhWau93m21fi/jwKX7fEHtfzSwwJlxTi3OGvcYX/haItfAaGA+pbC1
         3fGpmPgslwox4EdJRh8l5gQnLmoJVcuxwiflU2xadXgSm5ueDhnSnMFi/NfxyGkEskg4
         ssTuyPs3zO79FEG37RPzmca6rHCDY5SKFAnXH04+sKVLySauR7OnhmTyY+v6T6A6Dc4n
         jTzd2qZSPnZbQohYgxebCOFDli3iQ03V+atNiJbTsP7LUNVziNHV5jUpcUbOBTJd2L4G
         lC+MSBjOojny9GLsGh3+9rqSl0w9VnWa3lCxVgm/Dj0y57mVI72PIu0IXmMDj88VlQr2
         iodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5BJFefnoM9qaF31uJMNY/NaA4gXihdlifYkpP5dew4=;
        b=NT5axGGEprq4okjYBeJRUlxKJrY+nu5hupz3bU/TG2bCvy2nLnDfdAMCaVt/N1BHrZ
         9IG67onvnnj5Mi77gO1g5w2hI5FRk+YT9ZM+z5sq/3h/2p0/JV4YsJD9EXzZ7bLg9wPx
         J/cAJBp9itpDPy7wl2zEYW/Yb1krZKb/hdlFybVMpc2xwICf/o3xHuZS46nHdJTTY/lp
         nQHfBaFlG0d181zx3PPJxSYS8lBOtHzgApjZQ+XTvPiHKO21uVqw5J9OH3Wewj2sTNFL
         J5p04572ABFY0JBrcPB35y41EZnO/PbAmzqggWglNVo7vjLbj393yTMmXY9CSsv1o3r6
         pwMQ==
X-Gm-Message-State: AOAM530sppNU/dJLj63OjplppDUARvnN4uBqOeQ7U1LQoi+/7tftYu3e
        VRX+ug+8ryVGcy+VKbYjyejTNsreTNX70yEXW8/vrlM67UlPIQ==
X-Google-Smtp-Source: ABdhPJxQbRH6Gu9FlL+SSo9EF1HhkPMoFDRekRqBVKrg7Ej8WHeiagXttY7Dw/i8pCv2HJHa6apFe9b4o8flyxX+poI=
X-Received: by 2002:a5d:5092:: with SMTP id a18mr8806364wrt.42.1590276478332;
 Sat, 23 May 2020 16:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
 <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
 <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
 <CAJCQCtQXBphGneiHJT_O7VHgZkfqfHaxmkAwFEzGPXY5E7U_cA@mail.gmail.com> <3bc39223e567b7a4eca13bc554c74ef0c36fbaf2.camel@seznam.cz>
In-Reply-To: <3bc39223e567b7a4eca13bc554c74ef0c36fbaf2.camel@seznam.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 23 May 2020 17:27:42 -0600
Message-ID: <CAJCQCtRkWhtYmsS54ZNg7SnUsnB+WWzWcDCepV-f_giACY7SaQ@mail.gmail.com>
Subject: Re: I can't mount image
To:     =?UTF-8?B?SmnFmcOtIExpc2lja8O9?= <jiri_lisicky@seznam.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By the way, if you want to try repairs, I know that you're using an
image on loop. But it could still save you time to set up an overlay
to avoid modifying the image until you've found a combination that
works - if possible.

https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

This strikes me as extent tree corruption so I'd start with
--init-extent-tree, and follow that up without options (implies
--readonly). There is no bigger hammer, so it's worth a shot but only
because you're working on a copy of the fs. There's a chance it makes
things worse.

--
Chris Murphy
