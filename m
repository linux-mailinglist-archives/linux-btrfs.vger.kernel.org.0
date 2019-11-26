Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC72C10A364
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 18:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfKZRgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 12:36:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43267 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKZRgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 12:36:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id q16so4270807plr.10
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NtvB90Am5ZTLYm+Aanm0y4QmpQ4zRvwI0Pg1w2+PDpk=;
        b=rGNbv7Q/X/5vfOv3mEOUHT0ifP2BNEzSFwVUFi60A3yjv16WqHdBPaULOwt59Zn5jT
         gRvE//8RWtJpaj/TRQfMmRf6SBpTz2Y54xeympjIDF/o3ZrhXFas7GBOqXuO4RYEQokq
         DeGwcPrVZvj6zd6bHf5EGPJOWL4UEEQX7sImp33qn01RPtL3vw9ts8Lg9n4GyoDbCFD9
         UM3t9zmxGiVNPZatYm0w8uT0PYKSAv1YccttU0918i+7vjV/dtx5Fw2UcVFnXXV8IcOL
         LJ8UlYU64ghrRk56ahQOTQOWpwcXe1Ss0w/j2aWx47gGCqN2Xnt05Kw4FiDRlZv4LqvY
         Lj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NtvB90Am5ZTLYm+Aanm0y4QmpQ4zRvwI0Pg1w2+PDpk=;
        b=uMaDImoNBG59MLwGzYF3eEKVwDyrSjAMrhJG9I3sEV3SFh9plkepVWnc0yI+5Rlq3v
         ZInSP8CCFfPd5XAts8wm7RCnTPiUhxRvo2kh8VHHRavTc5weWrFx6B/PJ3io1y06HTql
         NZoAFWEs7gb7T5/knlCyDhdu2BAW9lKESZ46s/hcwP/18yA83mSGCI5ZfcOYqJYDBT5R
         SltJZpE7A3nOImjBaK0iOTvBnWbwFfVwebiND40Z9U0LbFNtWg1lOhxdon6Tu1pYEkt3
         cf8Optod8hKdXaM6MFAGy++kVn8xiu8WYZMjehMFqIB4Nz2+B22PS9JSmEmO5adWxT+7
         tCkw==
X-Gm-Message-State: APjAAAWrH0t5uKxUH6Rfp85QOq5KdPAbwZo/XKtHoxQF8eqtpLz0eyLB
        Pgz87sfBpUhBQ0/gRgrbeiArTw==
X-Google-Smtp-Source: APXvYqxQGleSEyUIqfvJa8/NiJsP5dYY2++4KZCeuP6V5fzHKL8ASxLjBD4+U8MsBGYZ6bwvbS0HNA==
X-Received: by 2002:a17:902:d881:: with SMTP id b1mr35712590plz.170.1574789771532;
        Tue, 26 Nov 2019 09:36:11 -0800 (PST)
Received: from vader ([2620:10d:c090:180::92f5])
        by smtp.gmail.com with ESMTPSA id c28sm13143566pgc.65.2019.11.26.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:36:10 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:36:07 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v3 03/12] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191126173607.GA657777@vader>
References: <cover.1574273658.git.osandov@fb.com>
 <07f9cc1969052e94818fa50019e7589d206d1d18.1574273658.git.osandov@fb.com>
 <d1886c1f-f19e-f3a7-32d6-8803a71a510c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1886c1f-f19e-f3a7-32d6-8803a71a510c@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 03:53:02PM +0200, Nikolay Borisov wrote:
> 
> 
> On 20.11.19 г. 20:24 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> 
> <snip>
> 
> >  
> > +enum {
> > +	ENCODED_IOV_COMPRESSION_NONE,
> > +#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
> > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > +#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
> > +	ENCODED_IOV_COMPRESSION_LZO,
> > +#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
> > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > +#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
> > +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> 
> This looks very dodgy, what am I missing?

This is a somewhat common trick so that enum values can be checked for
with ifdef/ifndef. See include/uapi/linux.in.h, for example.
