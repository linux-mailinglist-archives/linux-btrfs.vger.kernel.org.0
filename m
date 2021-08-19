Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A923F1CD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhHSPc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbhHSPc5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 11:32:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B19C061575
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 08:32:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa17so5230119pjb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=evXAogE912+oXRWnnBTByvWfoAPmg/tID/FsWt9WDWA=;
        b=j3dLa7D3tiyVogDuYEBvto1iTmJLkhh3XnT+FiPZh0u2zLw0bsO50oHgnC0K8PheBR
         kq1X/qE8OFhqjLWO3wEn3J4xtolGLbGJpZMHmpcDNQOnaQg+LMPAM0V6X82nnJI3VcAZ
         WtQOl/oYSe+MAqx4XLIPUhVjm49jzz5g3tWlUFZ307DPTMKOcl7Ftt+85CkEHUg88si2
         GVDcMyjvCmtN9WNlziyadUlPKWhWHwq+zaBAXUW1mQdl2sKD7Sydp1jVQUYsi/0rmvwb
         Ce4F2HPAulofMYI9F1OEH4053h0GZqw6lvJSaJ6J7LnwLSAW4x3Cebv0sUDz2rNZyliK
         JCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=evXAogE912+oXRWnnBTByvWfoAPmg/tID/FsWt9WDWA=;
        b=h0dc+i4i6emmdOmEq65mkhMDDtFJUhbuVXWV+qcvwxSyYyZsAxD6r0S5kGqJvW/sAu
         wDg9MBz2kIyRoq0+pvAJn6pLbPQtafnK1+ghD6aBY/E6PrJdLJS0c1WSjTvvLr4uJUVT
         m/0VV//DS7Zj+Jk7LC4D/B4SLIpU3zZS1ahp5LHvzA+Ch+9TGPsWaVjDlEaulLeKdfIF
         n0GprmJP7gqxOP8tCZTVGSYxDaE2l4qbR6qpDDTR3cGmhk/WRls01RmICpMcE5s2/I5o
         81rsNs9RFW/tOTtb1xCmEWAnD+9zwwXsAojnTQz6kZ8URgXn7wtuU3nRwG3QZudJjhg6
         pXFQ==
X-Gm-Message-State: AOAM533zmxmrndQy1Ef9AgWcwREskJ1kWDCuqGnIFTpxZkNHMjBWGJQq
        4zix5TCF8sycb2afYMClyqopZq5myGa86g==
X-Google-Smtp-Source: ABdhPJx8yMGvxLU7zzifGkYCL07GRqrki3kNdc87bbatMjVGAJV9huWCxj1RSgV5MzW9wb4Z7XwZ3g==
X-Received: by 2002:a17:90b:4d0c:: with SMTP id mw12mr16194200pjb.123.1629387140681;
        Thu, 19 Aug 2021 08:32:20 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id c2sm3948668pfp.138.2021.08.19.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:32:20 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:32:16 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
Message-ID: <20210819153216.GD1987@realwakka>
References: <20210818160815.1820-1-realwakka@gmail.com>
 <e6423897-3886-73b1-42dc-5e24ca792682@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6423897-3886-73b1-42dc-5e24ca792682@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 11:04:58AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 19:08, Sidong Yang wrote:
> > btrfs_extent_same() cannot be called with zero length. Because when
> > length is zero, it would be filtered by condition in
> > btrfs_remap_file_range(). But if this function is used in other case in
> > future, it can make ret as uninitialized.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 
> This is not sufficient, with the assert compiled out the error would
> still be in place. It seem that it is sufficient to initialize ret to
> some non-arbitrary value i.e -EINVAL ?

I agree. It's better way to assign intial value than adding assert. If
there is code that initialize ret, It seems that assert is no need for
this.
> 
> > ---
> >  fs/btrfs/reflink.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index 9b0814318e72..69eb50f2f0b4 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
> >  	u64 i, tail_len, chunk_count;
> >  	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
> >  
> > +	ASSERT(olen);
> >  	spin_lock(&root_dst->root_item_lock);
> >  	if (root_dst->send_in_progress) {
> >  		btrfs_warn_rl(root_dst->fs_info,
> > 
