Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F9458435
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Nov 2021 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhKUO4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Nov 2021 09:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbhKUO4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Nov 2021 09:56:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A2C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Nov 2021 06:53:11 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r130so13758893pfc.1
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Nov 2021 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3xtYJFtAbK7UvtWEyJsQ8BCwZC339x/7s5NIKIIlLt4=;
        b=pydKK3bzP0qRH/b5YERvqSl19fS6jFVApElMor6YgKdNDANJqzjxYLH+Hrbk6wMyAQ
         CREAKwKHUxW03T+RMhNSQTe1/GHRdzhSgINb0GTd1SvS9xTgzZoH8GAoA8DPkCbFy15e
         /Iro6HLcvzFjjC/AcEWabfDEJTRTclUSxartz9V3oC6R8+3ZN8m3movzVhXDiK7/CAE0
         gLV3hFLdi8GRknMAh8TmR+8qPlt5MYgwtReHtG8oSEWZSzHTlES+tVs38F0GovX8rwIF
         iCjV6Fvu92PRlFPlURxpg06q2GmS2YPo/rbD/Kb0zliZ2Gg2oxrj7pgEKk/TJePAVzBW
         tYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3xtYJFtAbK7UvtWEyJsQ8BCwZC339x/7s5NIKIIlLt4=;
        b=ESkOtRixW+t101mvweuFm6Du2q/kEDGgEPqqQEKeZjFcmff7L3h6Az3g0ev+PTBMT1
         RDpvjoVILDVBkVs2lv0AjmBbBVs8fQ1x+UAjGfRqSI1lV79+dAi74Y9JCOXKaOK4L9vR
         IpnKPx5XDTKeual/1g8Y9XMADo4LyLACk+7JOA82kNO1lTm/B6EFhzjW1cdbv5oLlrdJ
         eBCsxEbvTbYbqp15bjx/ctdmWPHaWDpFIlG9DB2fwimj7+CuLJE3p714Db6S2/Ae/cqD
         LwEPqeWzYLVGPGM8rh2ThnDYexcjILYBS7iOun1TVAobeDUgOjIOSdONiD6j6GiWc2s6
         BWOQ==
X-Gm-Message-State: AOAM5306ZyzAJuAh0g3IgU1VhdjR0je8uZdfBskFlVNqKQIIF5P/wdGG
        YTMUG5T2f+kDM5eeiugVb4I=
X-Google-Smtp-Source: ABdhPJxx/LonifLBinmAs0+LK83a4Jw8zskr7m9wK74rvjC1H2oCOV0f6itD/e8muOMYCkU7sa53nQ==
X-Received: by 2002:a05:6a00:1705:b0:4a0:3492:16c with SMTP id h5-20020a056a00170500b004a03492016cmr80324408pfc.3.1637506390752;
        Sun, 21 Nov 2021 06:53:10 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id f8sm6155072pfv.135.2021.11.21.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 06:53:10 -0800 (PST)
Date:   Sun, 21 Nov 2021 14:53:02 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] btrfs-progs: filesystem: du: skip file that
 permission denied
Message-ID: <20211121145302.GA8836@realwakka>
References: <20211121074705.8615-1-realwakka@gmail.com>
 <fb414950-fb0d-d24a-08f3-c0247f9bff9b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb414950-fb0d-d24a-08f3-c0247f9bff9b@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 21, 2021 at 11:01:02AM +0200, Nikolay Borisov wrote:
> 
> 
> On 21.11.21 г. 9:47, Sidong Yang wrote:
> > This patch handles issue #421. Filesystem du command fails and exit
> > when it access file that has permission denied. But it can continue the
> > command except the files. This patch recovers ret value when permission
> > denied.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  cmds/filesystem-du.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
> > index 5865335d..64a1f7f5 100644
> > --- a/cmds/filesystem-du.c
> > +++ b/cmds/filesystem-du.c
> > @@ -406,6 +406,9 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
> >  				if (ret == -ENOTTY) {
> >  					ret = 0;
> >  					continue;
> > +				} else if (ret == -EACCES) {
> 
> This can be added to the above condition with || ret == -EACCESS. Avoids
> code duplication.

Thanks! It would be better. 
> 
> > +					ret = 0;
> > +					continue;
> >  				} else if (ret) {
> >  					errno = -ret;
> >  					fprintf(stderr,
> > 
