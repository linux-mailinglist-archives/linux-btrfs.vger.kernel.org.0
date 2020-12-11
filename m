Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25042D7DC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392540AbgLKSKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 13:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391593AbgLKSJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 13:09:58 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAA2C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 10:09:18 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f14so2576496pju.4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHGaR9A/TxWAjFz0siqJ2cujTM0JaKYjc5rm6P9EKo4=;
        b=dNZ+4jjkgwAniupzlKGEFCbKQYsmhL70DKXHA3oqrcMmASsoSoWvDJji7mdX8eRYQt
         CwUKxYqh0it03LN/qPOu816yCP54Zr4yHn1XUR3dGtj0wQ7y82C8DEYrkv/ShTTBLgjr
         isKakpD0FyuuplAjQsVlWRiI5f83LsILc+Kt3W0ZiZS4+YtDgZpGaIgif3Wl7zwDKh3L
         4cW/H2vcmH66J/UnX+lX8kVvWkl7EGXcnAwi2pcIq61TqVeQA3xIx2d++c0Pb4jLwd7B
         +KVeytZSXRdXNYVWcIudAK6CeLsgCoEdAVOslciXSfGw3K/LxT8WDBVhQd50NUzQDaRJ
         5xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tHGaR9A/TxWAjFz0siqJ2cujTM0JaKYjc5rm6P9EKo4=;
        b=aLUXp4nT2jFVjLSrNWxuAsyc82DhdCdvbH0GFlHf5Qo4iSLglToJxxoC5zL7XTBWIh
         dhkXS6OD2APxRCjVgc8/pL8l3GzMiPDwab8b7FUpOirx+Ns/qqf+KfELxt8PagfHWL6u
         rtE0R2BovQcVwh47UFavJ+oMczsbci5KnP+Ee+nObcI2fcHnaO6sDxSo15tfFnxoSDqi
         dROT4Mt2Go+0Si4S05t10NHN5w0wg6psD1xyvlccBSPuTCHTmfxtO5Zxfn+m74tl9b9v
         tSbJj1NMahSnAtDpPU7o1A5CCrMpZEW2hSrlBEW7e9RSR/83kgT3WylgPh1IKo3IPywE
         pQvg==
X-Gm-Message-State: AOAM532FWsgC1nXSijXKnjSUEelJ94tu5TOHc2oa1Jk5DzH74MTNgj9e
        xG+RHjb20sJoxQ/+tCGJoK4=
X-Google-Smtp-Source: ABdhPJxuxywaB+ScHTeANki+lEz/Bbkl4fQg+8j+rHAkJf44npp2a1RfO99babLSWzNOg/3u5G/AsQ==
X-Received: by 2002:a17:90a:d502:: with SMTP id t2mr3434773pju.131.1607710158287;
        Fri, 11 Dec 2020 10:09:18 -0800 (PST)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id mj5sm11046383pjb.20.2020.12.11.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 10:09:17 -0800 (PST)
Date:   Fri, 11 Dec 2020 18:09:11 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201211180911.GB456927@realwakka>
References: <20201211164812.459012-1-realwakka@gmail.com>
 <20201211164812.459012-2-realwakka@gmail.com>
 <20201211173025.GO6430@twin.jikos.cz>
 <20201211174629.GQ6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211174629.GQ6430@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 06:46:29PM +0100, David Sterba wrote:
> On Fri, Dec 11, 2020 at 06:30:25PM +0100, David Sterba wrote:
> > On Fri, Dec 11, 2020 at 04:48:12PM +0000, Sidong Yang wrote:
> > > Example json format:
> > > 
> > > {
> > >   "__header": {
> > >     "version": "1"
> > >   },
> > >   "device-stats": [
> > >     {
> > >       "device": "/dev/vdb",
> > >       "devid": "1",
> > >       "write_io_errs": "0",
> > >       "read_io_errs": "0",
> > >       "flush_io_errs": "0",
> > >       "corruption_errs": "0",
> > >       "generation_errs": "0"
> > >     }
> > >   ],
> >      ^
> > 
> > I've verified that the comma is really there, it's not a valid json so
> > there's a bug in the formatter. To verify that the output is valid you
> > can use eg. 'jq', simply pipe the output of the commadn there.
> > 
> >   $ ./btrfs --format json dev stats /mnt | jq
> >   parse error: Expected another key-value pair at line 16, column 1
> 
> I've pushed the updated plain text formatting to devel, so the only
> remaining bug is the above extra comma.

I've tested devel branch. but there is no extra comma and I also tested
with jq you said. jq results no error. I think that It's just mistype in
message.
