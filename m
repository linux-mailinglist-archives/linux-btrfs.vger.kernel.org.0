Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26793659DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhDTNV2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 09:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhDTNV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 09:21:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD7C06174A;
        Tue, 20 Apr 2021 06:20:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso8222616wmq.1;
        Tue, 20 Apr 2021 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J3e7kbQq5St6RlbDyul6tsPbXu/C51Diuoyxp5D86fI=;
        b=mZOPjGwS2tguLvoeL+qTDW5wKf9rE9LMBM1LVvNmR+ds9MDU0oFHCssoeniGZP0qWo
         2C/aSFWRkTFyK7788JV7TtpVM8tfpyayIl+b5QqxLC2z4AzWpVEUgGRYFFrBeym1AfAS
         1/R002DwbLOfYzINdcZfhHZOelwOFzjJ0MK1/oPYBMkJLx5LKyDHN66OKAxPHS03zh7G
         5mzyr4f8Q+s6VuVjDpblj+OXrZ6yycJQWz58nx7qJiQWOUZ/7c5DgvHG3QO9O4GdtDEs
         +6ESIRpPLSw8/eVSJXNPRxZ08u3T/Dx9jD+eujtj0ftilVf/95dGwx1oRxXB8BMNund1
         WBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3e7kbQq5St6RlbDyul6tsPbXu/C51Diuoyxp5D86fI=;
        b=X4vkox7F8Y5h8g/5eJFU6HXv6bs2VCnZio0ZHjMI/ONsO+r6rW4FafgHaWjE7UQdwU
         Ze968rCGBOgu14sgJ3O2Q4PYde80zciUidJk600iTo44lSnSrklBigpyui2YRgo38S7S
         YZLIixISkMt2PCj71GbgjMXDpaLrp4fLGFVynZxpHMgVSoWgolssTfsTVL90/VR7A6/m
         x4ALEyIC+9XEqFoaD+wPxECWFbBpWwXFY4DBZ2RpTK9dmbAy8PpYMYAD7IR7XQxOLUXM
         +7+J1UFnixTUKS+B22cG2OyZ1XH6+0wHdyLA0Sis+dv5vc4ZWn8wLf/r1xviEDlPacvV
         2xCQ==
X-Gm-Message-State: AOAM5300ENTTt8eGYbLlBNtM6z5QZTuChn7aB55gDlPcTnv6Sin2dSSt
        kBqm20qKAH4bFCkuilMfiOFdHfMkSHFJnA==
X-Google-Smtp-Source: ABdhPJwWQykuNw2FTMz3ac8RTLG/HRENz8kxWRcXJ50uj7xKxZKZp0TkI1HnHitzb6eA9JgHc+TwXQ==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr4660442wmr.23.1618924855647;
        Tue, 20 Apr 2021 06:20:55 -0700 (PDT)
Received: from ard0534 ([197.240.34.190])
        by smtp.gmail.com with ESMTPSA id l4sm27696668wrx.24.2021.04.20.06.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Apr 2021 06:20:55 -0700 (PDT)
Date:   Tue, 20 Apr 2021 14:20:51 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     David Sterba <dsterba@suse.cz>, clm@fb.com, josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, khaledromdhani216@gmail.com
Subject: Re: [PATCH v2] fs/btrfs: Fix uninitialized variable
Message-ID: <20210420132051.GA3433@ard0534>
References: <20210417153616.25056-1-khaledromdhani216@gmail.com>
 <20210419173225.GT7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419173225.GT7604@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 19, 2021 at 07:32:25PM +0200, David Sterba wrote:
> On Sat, Apr 17, 2021 at 04:36:16PM +0100, Khaled ROMDHANI wrote:
> > As reported by the Coverity static analysis.
> > The variable zone is not initialized which
> > may causes a failed assertion.
> > 
> > Addresses-Coverity: ("Uninitialized variables")
> > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > ---
> > v2: add a default case as proposed by David Sterba
> > ---
> >  fs/btrfs/zoned.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index eeb3ebe11d7a..82527308d165 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -143,6 +143,9 @@ static inline u32 sb_zone_number(int shift, int mirror)
> >  	case 0: zone = 0; break;
> >  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
> >  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> > +	default:
> > +		zone = 0;
> 
> Well yeah but this is not a valid case at all, we'd rather catch that as
> an assertion failure than letting is silently continue.

So, as all callers pass valid value. It would be
better to catch that as an assertion failure.
