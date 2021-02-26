Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D353325C31
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 04:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhBZD4U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 22:56:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBZD4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 22:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614311692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXvPvwpzblhe1ssQWirHDB36I3K3aT43aO1CtB7cQ2M=;
        b=c2aYhYdwuE9P1i36c0Pn5OZM2pBnnn1oUpP69GRFa+dQum5qfdhVSHUJdsu1hvKJbOTV/W
        qpldiDQfSp8H6KifYhZgUxHR06zJjIcubwJb0wFsSrpuD2jooDMjJzo1EDlamIEv44tY61
        QrMHor+pI7MfwwH6c7iEtX0Xw567JGE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-isA9oa1SMaiszJmQNEp1eg-1; Thu, 25 Feb 2021 22:54:50 -0500
X-MC-Unique: isA9oa1SMaiszJmQNEp1eg-1
Received: by mail-pj1-f69.google.com with SMTP id 19so5453926pjk.7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 19:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXvPvwpzblhe1ssQWirHDB36I3K3aT43aO1CtB7cQ2M=;
        b=no0IWUwyqSpuyt9S/I0SCTFbDfPNqCy+DkTpLnunl9wPO6WqapjJCQwVNzv7d9yJcJ
         F/cz1gTF2qCTvNzUBb5kLWXgjlAw8q0P1g+TsOhDVLul5FemOyj+Ls00ylN2o/l1T2St
         dC4OcEP01vsJJiXHfavH0c7vqagYAHU7hICvpOh+07c7L4RWODkd/mH0kF1MGkkXaDvv
         fp+pElRP9hhdQ0k9rxLreiucatmioC4899Ux5B+SkBsk4f/i5XhrkwDOFMM/vMdRkGVw
         ijZ1rvCbpRGGFf+Z515zYEGl5qinCesyantH1H8HvxHyCq8b6El+aifGoC9r+4gzx4L4
         3r3g==
X-Gm-Message-State: AOAM533RilnlYGlZcjOew38A3btJ9Ln9GkvdXPIOVVhJ/4GUcUUJO/bR
        vR1eZuo8CiF4OXBH5+99MO/HaRCMFPSnzWFsixXL84na6kYRFyyRv7gm/Am5/llwXVixa81f80l
        TlvlTg7H2hfHW5zhBzmwXOMU=
X-Received: by 2002:a63:fb11:: with SMTP id o17mr1124282pgh.282.1614311689729;
        Thu, 25 Feb 2021 19:54:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLwthVn3ErB5FJJ8D3RILvNqSTxwlL+mmdtW8EMVdNTkKQlOcGdAkOl+qJoURmZrrGkSiZGg==
X-Received: by 2002:a63:fb11:: with SMTP id o17mr1124268pgh.282.1614311689480;
        Thu, 25 Feb 2021 19:54:49 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d12sm6896114pgm.83.2021.02.25.19.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 19:54:48 -0800 (PST)
Date:   Fri, 26 Feb 2021 11:54:38 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210226035438.GA1831167@xiangao.remote.csb>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDfxkGkWnLEfsDwZ@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:
> > 
> > LZ4 support has been asked for so many times that it has it's own FAQ
> > entry:
> > https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F
> > 
> > The decompression speed is not the only thing that should be evaluated,
> > the way compression works in btrfs (in 4k blocks) does not allow good
> > compression ratios and overall LZ4 does not do much better than LZO. So
> > this is not worth the additional costs of compatibility. With ZSTD we
> > got the high compression and recently there have been added real-time
> > compression levels that we'll use in btrfs eventually.
> 
> When ZSTD support was being added to btrfs, it was claimed that btrfs compresses
> up to 128KB at a time
> (https://lore.kernel.org/r/5a7c09dd-3415-0c00-c0f2-a605a0656499@fb.com).
> So which is it -- 4KB or 128KB?
> 

I think it was to say in one 4kb block there are no 2 different
compress extents, so there is no noticable extra space saving
difference if compression algorithms (e.g. LZ4 vs LZO) with very
similiar C/R. I think that conclusion is also be applied to F2FS
compression as I said months ago before.

LZ4 has better decompression speed (also has better decompression
speed / CR ratio) due to LZ4 block format design. Apart from
compatibility concern, IMO LZ4 is much better than LZO (Also LZ4
itself is much actively maintainence compared with LZO as well.)

Thanks,
Gao Xiang

> - Eric

