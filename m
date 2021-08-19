Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5F3F1CB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbhHSP15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbhHSP14 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 11:27:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D3CC061575
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 08:27:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so5836807pfl.10
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wBVyLg2xeGKrVleyhN1ubgV7JGMlafyiIppV4wZtsT8=;
        b=YmwmEkCKVh+zUi+iAiyViPOg+ajZ7ee/GuQWVrSZOiXQaokU7OSufC4QzDhdW1fPui
         6un2ptJO2m47Hqc1xvvL7igAwGzXINOlgPehEv1ynV1qdwgRMdoDJZXJ7Vor9caTXeeF
         Rp7vWnFQPG656KOJbc3zwghwg2sG7a/BCl67PrFotzNQ/KD3Se/kPvG6E+bzoVFa0ND6
         Ji/aqZM860zpDpK7NflhRMvDxwrO/hMCP/ZfQ/pS2jbDLei6GQ0zf2dIwpuVHJTwutLH
         z0iCDqOjcEMHWf0gKqnFd77YF2Dbe8vMw6qebxatw+FU0oE8/wjm0CeSgK2wIptqxiBs
         6cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wBVyLg2xeGKrVleyhN1ubgV7JGMlafyiIppV4wZtsT8=;
        b=iZdtxNjduNdhRhW1a7tMFP5oVNFQ+7uhHPGGJubKfuxH7D12UxaYNddHmqcR0ebPz0
         426fCTQC1iTx+oTu/bwMvkBv0WwjgTpbk3HLl1fLvKMlIKqen4FBPZZjFTmwQuHoHJcd
         r1hrHSkhwFhuv4IZps3kzwEa3GafRoZiSuM/W4IXvpB4K65Oy8YuaxeqHzTLu8d+qc6F
         A9AqxpYKDpEhTqyK/nMfkNcTFzX+dxPmZZsmH9/xvuBsTZsxxoi4TjfItmEtEIS1r5bz
         ty63lCnENOCS/YU/vxlWOGjr+VfO62x8USgACad86Jyq+/TZvQZhBssXUrgXP1YtSB1p
         YrpA==
X-Gm-Message-State: AOAM53003QaR5hAdfgBGAox/bhHMjQ4MKOc0de/7QauWJx2SG+vyD5hh
        eECEzoCXgivSXUblGtnLBIE=
X-Google-Smtp-Source: ABdhPJy4EDiA56bobwy4G+wvuN95b64qFmFrvjfARDPolqsFhBPfBlPYqsP7Jx+NPEBmM057+eH4mA==
X-Received: by 2002:a05:6a00:ac8:b029:320:a6bb:880d with SMTP id c8-20020a056a000ac8b0290320a6bb880dmr15192336pfl.41.1629386839630;
        Thu, 19 Aug 2021 08:27:19 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id z2sm4753673pgb.33.2021.08.19.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:27:19 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:27:14 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210819152714.GC1987@realwakka>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz>
 <20210818003819.GA2365@realwakka>
 <792d01d9-97f0-6a80-15e9-f6cd6356984d@gmx.com>
 <2f355551-3216-cc4c-5522-fab8ed6928e3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f355551-3216-cc4c-5522-fab8ed6928e3@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 02:05:52PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/19 下午2:03, Qu Wenruo wrote:
> > 
> > 
> > On 2021/8/18 上午8:38, Sidong Yang wrote:
> > > On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
> > > > On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
> > > > > This patch adds an subcommand in inspect-internal. It dumps file
> > > > > extents of
> > > > > the file that user provided. It helps to show the internal information
> > > > > about file extents comprise the file.
> > > > 
> > > > Do you have an example of the output? That's the most interesting part.
> > > > Thanks.
> > > 
> > > Thanks for reply.
> > > This is an example of the output below.
> > > 
> > > # ./btrfs inspect-internal dump-file-extent /mnt/test1
> > > type = regular, start = 2097152, len = 3227648, disk_bytenr = 0,
> > > disk_num_bytes = 0, offset = 0, compression = none
> > > type = regular, start = 5324800, len = 16728064, disk_bytenr = 0,
> > > disk_num_bytes = 0, offset = 0, compression = none
> > > type = regular, start = 22052864, len = 8486912, disk_bytenr = 0,
> > > disk_num_bytes = 0, offset = 0, compression = none
> > > type = regular, start = 30572544, len = 36540416, disk_bytenr = 0,
> > > disk_num_bytes = 0, offset = 0, compression = none
> > > type = regular, start = 67112960, len = 5299630080, disk_bytenr = 0,
> > > disk_num_bytes = 0, offset = 0, compression = none
> > 
> > Could you give an example which includes both real (non-hole) extents
> > and real extents (better to include regular, compressed, preallocated
> > and inline).
> 
> Tons of typos... I mean to include both holes (like the existing
> example) and non-holes extents...

Sorry, I had no idea about holes. But I found some test code in
xfstests. It helpes me to make hole in file.

xfs_io -c "fpunch 96K 32K" /mnt/a/foobar
xfs_io -c "fpunch 64K 128K" /mnt/a/foobar

and the example is below.

# ./btrfs inspect dump-file-extent /mnt/a/foobar 
type = regular, start = 0, len = 98304, disk_bytenr = 21651456,
disk_num_bytes = 4096, offset = 0, compression = zstd
type = regular, start = 98304, len = 32768, disk_bytenr = 0,
disk_num_bytes = 0, offset = 0, compression = none

I'm afaid that I understand your request correctly. Is it what you want?
> 
> > 
> > Currently the output only contains holes, and for holes, a lot of
> > members makes no sense, like disk_bytenr/disk_num_bytes/offset (even it
> > can be non-zero) and compression.
> > 
> > Thanks,
> > Qu
> > 
> > > 
> > > Thanks,
> > > Sidong
> > > 
