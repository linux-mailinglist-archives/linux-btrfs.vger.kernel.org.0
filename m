Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C816E88EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 05:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjDTD6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 23:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDTD6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 23:58:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5BF7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 20:58:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b733fd00bso528446b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 20:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1681963097; x=1684555097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q38bObAK5Sut8F7rryJZqrJRUs516A7W8zPzHgDWtrs=;
        b=TxgAQdrv9gZEaYSXR5fiEkjRvsXQb7eAbir+QlYdvMpu1+yDDV7udfV286oVP0z7t1
         WfrhEty2FnDEjdK2gvpLylFSYE/oXz/uE7fWgi/MyJ/F30SpzgrtxyvUBTpZYlcA9ua9
         WKskJsmRSLUzIUpl4jnXzpp/4OI5kohn7AhF19LRn7kXD1+F7LryxHchrgm54RLCQExk
         6rza6Bs4AEdmeVeIH1+PWE+VB1enZJwr+IfyQNiQmbeLEkdDiY06fHXvVx6D8wcNJI50
         Axg3GYKVUsEu29ZjBFz8a6Ccu0qIFz9PtCyFjmZaM0fqSLaW9qg1vspwef+bSVxrrJQm
         no/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681963097; x=1684555097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q38bObAK5Sut8F7rryJZqrJRUs516A7W8zPzHgDWtrs=;
        b=LXt8OTgyTnVUZ/ColwAj/AqQH8eGTIFgrf0zusohd/oxngNZCH9S6UPKz/441NV1vZ
         a8lEA75lNdtZcLQWYMBEKdjUT4jz3VMLv6X2BJtyIy/KREi6iLazY+2zFMMADEczFEua
         GLl+ivmsMyQlaDoPRHUHYCee7kr9d40w/rng+uaY0iWIhMxeJLphYroP3ROSBMgzp0Dv
         GFTVz5TaJK8p8mGw9OoV0ycWCiZTOLkSgizKm7AWB3AZQnLkBs0bzP+Wg7wIDw+d1uCj
         kfb6EkNywafoCe6TipIGDZ4aekglW/Jr3+bMhDPkx0q6A0TAqyXsr9p5tCD0K04EiWzh
         Ip2g==
X-Gm-Message-State: AAQBX9fkbXa1qq2E1GxujczmPof/RbqtDV+Kfo4FCk4XbE2BUW2gdBxA
        6eN1T0cq6V6IlLDICh3OnU9TkUzgNFdrbNtCN5LEOg==
X-Google-Smtp-Source: AKy350buDYljA0u0a0QjFaT65OGhTl/14OdRUb0BkOeUmlu21C5KfdwLnZ+FZEIXYd0g6AD0KxsiOQ==
X-Received: by 2002:a05:6a00:130a:b0:63b:859f:f094 with SMTP id j10-20020a056a00130a00b0063b859ff094mr6315411pfu.20.1681963097567;
        Wed, 19 Apr 2023 20:58:17 -0700 (PDT)
Received: from localhost (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b0063d63d48215sm184886pfg.3.2023.04.19.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:58:16 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:58:14 +0900
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix bitops api misuse
Message-ID: <rr25zuiruz5p3gtnlojmezwzkkd4vdp6zqcarskgq7ecancv4g@xpj4jx6f5ouv>
References: <fc21b3d5ddf062b746bc55425672969f897d685d.1681801005.git.naohiro.aota@wdc.com>
 <20230418232456.GT19619@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418232456.GT19619@twin.jikos.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 19, 2023 at 01:24:56AM +0200, David Sterba wrote:
> On Tue, Apr 18, 2023 at 05:45:24PM +0900, Naohiro Aota wrote:
> > From: Naohiro Aota <naohiro.aota@wdc.com>
> > 
> > find_next_bit and find_next_zero_bit take @size as the second parameter and
> > @offset as the third parameter. They are specified opposite in
> > btrfs_ensure_empty_zones(). Thanks to the later loop, it never failed to
> > detect the empty zones. Fix them and (maybe) return the result a bit
> > faster.
> > 
> > Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
> > CC: stable@vger.kernel.org # 5.15+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/zoned.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 2b160fda7301..55bde1336d81 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -1171,12 +1171,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
> >  		return -ERANGE;
> >  
> >  	/* All the zones are conventional */
> > -	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> > +	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
> 
> End is defined as "end = (start + size) >> shift", and the 2nd parameter
> of find_next_bit is supposed to be 'size'. Shouldn't it be "size >>
> shift"?

Not so. The argument "size" represents the size of the allocation range,
which is to be confirmed as empty. OTOH, find_next_bit()'s "size" (the 2nd
parameter) represents the size of an entire bitmap, not the number of bits to
be tested.
