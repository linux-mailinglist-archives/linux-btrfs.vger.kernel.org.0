Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0816E575E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDRCNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDRCNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:13:33 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 19:13:32 PDT
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22126198C
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:13:32 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by gw.atmark-techno.com (Postfix) with ESMTPS id AF9AB60146
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 11:05:36 +0900 (JST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-63d30b08700so1529891b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681783536; x=1684375536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAPiAIU5HgclSinkp6F/Z6yHela0V5UFfJjRmjfpsOQ=;
        b=lF7asbtQnajcakvkhWrQp+gkyUG4oZfmk+KiP0ixf4xQ1qqPxlQlO+mkBk7HnpTDLe
         CSDTokRs7bLII+/fD13YAJSjnx0WweC8myDs8JxlWwpoc5QF7KfP6MnGDIZuqxHjg2X8
         pM+kPLkJwXZ95uz36fB5i+aL/UKPIWQxVuKNXX+Ic35uKtM1tr5to81gtD5Lb5XjUoSy
         ERd1SXHpa59oT7NeYSvfeMIPPEsKSfdXMpwNfZKnPhwbmRFSKgGN3CRA8ZnbfZdCd7dn
         lNZ+QiMX91VRcGotdajujM1IUBzKGpiftsJ6ZD6ZgsjBcvulEipGXTaOqrU8+7XWfZi8
         ws7w==
X-Gm-Message-State: AAQBX9fuF4Dh2wTgXvTWTsOR+9luKFbzw7Ak8kqjNOA6vRw+ib5tS6mB
        YE8vxc+hNBUGaBTOXn27oOuaCQtsit3JnsNqyjRgtg5zZaYFukDZksiAEQI1GSzn4P7/rQDWhdI
        liqQdFYQv0RPewgpwn2BI/gKeVJCh4/o/oC8=
X-Received: by 2002:a17:902:ea0b:b0:1a3:dcc1:307d with SMTP id s11-20020a170902ea0b00b001a3dcc1307dmr603721plg.23.1681783535778;
        Mon, 17 Apr 2023 19:05:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350bLwCPS7GbsopYCgKlj2OCNPofnolvAojawj4enlZlARH69d5NLtIUeHL5qeDYsjEyvBVlyfQ==
X-Received: by 2002:a17:902:ea0b:b0:1a3:dcc1:307d with SMTP id s11-20020a170902ea0b00b001a3dcc1307dmr603696plg.23.1681783535420;
        Mon, 17 Apr 2023 19:05:35 -0700 (PDT)
Received: from pc-zest.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id jl12-20020a170903134c00b0019fea4d61c9sm8332812plb.198.2023.04.17.19.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 19:05:35 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1poair-00C6xf-3C;
        Tue, 18 Apr 2023 11:05:33 +0900
Date:   Tue, 18 Apr 2023 11:05:23 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 1/3] btrfs: fix offset within
 btrfs_read_extent_reg()
Message-ID: <ZD364ycA71hLmmOK@atmark-techno.com>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-1-47ba9839f0cc@codewreck.org>
 <ad41862c-e7fb-acd7-7657-85b76cb302ee@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad41862c-e7fb-acd7-7657-85b76cb302ee@gmx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote on Tue, Apr 18, 2023 at 09:58:37AM +0800:
> The subject can be changed to "btrfs: fix offset when reading compressed
> extents".
> The original one is a little too generic.

Ok.

> > btrfs_file_read()
> >   -> btrfs_read_extent_reg
> >      (aligned part loop from 0x40480000 to 0x40ba0000, 128KB at a time)
> >       last read had 0x4000 bytes in extent, but aligned_end - cur limited
> >       the read to 0x3000 (offset 0x720000)
> >   -> read_and_truncate_page
> >     -> btrfs_read_extent_reg
> >        reading the last 0x1000 bytes from offset 0x73000 (end of the
> >        previous 0x4000) into 0x40ba3000
> >        here key.offset = 0x70000 so we need to use it to recover the
> >        0x3000 offset.
> 
> You can use "btrfs ins dump-tree" to provide a much easier to read on-disk
> data layout.

key.offset is the offset within the read call, not the offset on disk.
The file on disk looks perfectly normal, the condition to trigger the
bug is to have a file which size is not sector-aligned and where the
last extent is bigger than a sector.

I had a look at dump-tree early on and couldn't actually find my file in
there, now the problem is understood it should be easy to make a
reproducer so I'll add this info and commands needed to reproduce (+ a
link to a fs image just in case) in v2
 
> >   	/* Preallocated or hole , fill @dest with zero */
> >   	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_PREALLOC ||
> > @@ -454,9 +456,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
> >   	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
> >   		u64 logical;
> > -		logical = btrfs_file_extent_disk_bytenr(leaf, fi) +
> > -			  btrfs_file_extent_offset(leaf, fi) +
> > -			  offset - key.offset;
> > +		logical = btrfs_file_extent_disk_bytenr(leaf, fi) + offset;
> 
> This is touching non-compressed path, which is very weird as your commit
> message said this part is correct.

my rationale is that since this was considered once but forgotten the
other time it'll be easy to add yet another code path that forgets it
later, but I guess it won't change much anyway -- I'll fix the patch
making it explicit again.


Thanks,
-- 
Dominique
