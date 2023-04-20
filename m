Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0D6E8906
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 06:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDTEOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 00:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTEOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 00:14:34 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE61FD2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 21:14:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so499625a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 21:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1681964073; x=1684556073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lk1Hu54bqxb56oTMJlDrcHj2SO/24RzI3+MgtWZPUEQ=;
        b=rJUA5LmxkYaPl4B0O2w/33bUQyDga4I7vnc8+D/kh6m9SmU2tSFRJcM2csW3LRKVOM
         QvLdgvMjF/9g65gD7KQ0Qrg5UL0l9r6KZhkjC3TQXy/38GkZjOFCi93TSJUZ91AKl60Z
         7axpjo+wSkzar5brbSFAwse+z23x/APt6nXtNaCBqpwbKHMmzSuhLFDORYyb/jY8UgHZ
         nvi6ISeTTrr1w1UWTTMCQm/Eo03WJfU3sgaMnDCKkYKdU9k+FqkfSqupFH+E65q3k+mR
         QnpruDavFLQgs1oy+VZ4v0D5CbZ0zgiO7k1GNJ+Wga+dHq7oNiF3oSEkIQQnBzYie7o2
         v40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681964073; x=1684556073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk1Hu54bqxb56oTMJlDrcHj2SO/24RzI3+MgtWZPUEQ=;
        b=Gvq48SYtf3D3EW1RJrPTpzgAfJcl+7VTaVKafP9qltJ2pGQnns8w8pZzHpcRYdhwRP
         EyWcfbc/wV5q5jUofoKZgHp+s6QOz4v9f1qogawmNHPGKZ7e+cwJIjM4yzzbda3f5EtW
         DRrtp4kiWaHr4lE0qlp/tBgdqp5URoSRu6ZzvWiQcKnfwlllVZqqVmlg1LuCYSzmJb2V
         YuyOZ7fS5efvzDjGC48psJD0Q7qv+zwKCHYYjcHKMUv/52BBloKb90qgzfNS4XRne37g
         K7msJ2FrpSTdSZOeaMOKvmwjiAhPoTgqMa+rpP7in+qwE+GE7phs+yhyoZCh1jhRdKk+
         UxQw==
X-Gm-Message-State: AAQBX9eppQzdSjM2McpAgYx2KJBd3fnLLxBYYErP9xI1/lFSL8FRwR5Q
        RqwRD9fYIoP8j4F9v0M3vxyhzc0qTUxrq4K9BDq+2A==
X-Google-Smtp-Source: AKy350ZlHxoL16E+KXT4pHhT/zZbnivJHhWCmPCrEJnqnXeAAAFIfMNrGqUUlO2XNMum4TDOXwnUnA==
X-Received: by 2002:a17:902:e848:b0:1a9:21bc:65f8 with SMTP id t8-20020a170902e84800b001a921bc65f8mr300350plg.11.1681964072898;
        Wed, 19 Apr 2023 21:14:32 -0700 (PDT)
Received: from localhost (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709028d9500b001a664e49ebasm196306plo.304.2023.04.19.21.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 21:14:32 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:14:30 +0900
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix bitops api misuse
Message-ID: <ghiglpjvgkvtdwpkl2h73b6gqlyfh6cl3m4b3uv3rhv5tmhyxq@2esoibq7emjk>
References: <fc21b3d5ddf062b746bc55425672969f897d685d.1681801005.git.naohiro.aota@wdc.com>
 <20230418232456.GT19619@twin.jikos.cz>
 <rr25zuiruz5p3gtnlojmezwzkkd4vdp6zqcarskgq7ecancv4g@xpj4jx6f5ouv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rr25zuiruz5p3gtnlojmezwzkkd4vdp6zqcarskgq7ecancv4g@xpj4jx6f5ouv>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 20, 2023 at 12:58:14PM +0900, Naohiro Aota wrote:
> On Wed, Apr 19, 2023 at 01:24:56AM +0200, David Sterba wrote:
> > On Tue, Apr 18, 2023 at 05:45:24PM +0900, Naohiro Aota wrote:
> > > From: Naohiro Aota <naohiro.aota@wdc.com>
> > > 
> > > find_next_bit and find_next_zero_bit take @size as the second parameter and
> > > @offset as the third parameter. They are specified opposite in
> > > btrfs_ensure_empty_zones(). Thanks to the later loop, it never failed to
> > > detect the empty zones. Fix them and (maybe) return the result a bit
> > > faster.
> > > 
> > > Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
> > > CC: stable@vger.kernel.org # 5.15+
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/zoned.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > index 2b160fda7301..55bde1336d81 100644
> > > --- a/fs/btrfs/zoned.c
> > > +++ b/fs/btrfs/zoned.c
> > > @@ -1171,12 +1171,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
> > >  		return -ERANGE;
> > >  
> > >  	/* All the zones are conventional */
> > > -	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> > > +	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
> > 
> > End is defined as "end = (start + size) >> shift", and the 2nd parameter
> > of find_next_bit is supposed to be 'size'. Shouldn't it be "size >>
> > shift"?
> 
> Not so. The argument "size" represents the size of the allocation range,
> which is to be confirmed as empty. OTOH, find_next_bit()'s "size" (the 2nd
> parameter) represents the size of an entire bitmap, not the number of bits to
> be tested.

BTW, I found the same logic is implemented in subpage.c as
bitmap_test_range_all_{set,zero}. So, it might worth moving them to
somewhere (misc.h?) and use them here.
