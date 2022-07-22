Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E057E49C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiGVQnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 12:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiGVQnP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 12:43:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D278CEA7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 09:43:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ku18so4852960pjb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bb/urPHZHGtaqFSyZLowx2ewPSAvXUU/K6Hq5nJ8PNs=;
        b=qWEV/0IQ/TKwU0/9Nsw9iz9k2TACZ0ZgZEC0mcEsgP93aLMVFHPyIUmwICJ8bb5CrV
         jCYe6YtxvpPKCkwj57C8/SmA163O3VzalBEuf0Sd/fcv1YOUEPhiVJfF0DrsEy5gCQjM
         N1fDuyKTAmEQz7sw6aKFRHbC5j1Cp2s5IRJJJ5mB89/cU0n8IZF/2sBS0pfnzLTC70Fm
         zv3JVpj9A7lFoWA0s0gpCr504zjuj+DTO++kW1sZ5QdxbtzmG3Hz9yAS7wsnEEcVLj2T
         KJaxE09mlyMV/lGAeFUHgD+LWVZU4yX1vhL9WA3hiKR0zZTWSvNU3qyYiYYWAbmQAqim
         wH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bb/urPHZHGtaqFSyZLowx2ewPSAvXUU/K6Hq5nJ8PNs=;
        b=O+fL2ijOdCgHXrKP1wXWxBurEzm3dnP0UpWNYmPSZh9hkMjWGsMzlpZEeFIojgW4kF
         oqaqjM+krEHcuolaB1Gg2O+8hJkEBGsWfNC9r41uaD6K8Q3y1VF5ZqbHVUk+CiQn2KEF
         1x9s8gTO4JRVaoNMqA6adebw4t1Ue654tMYxlKYWh2RJolcohmDcjgEsWtlanICA83C0
         TyR/hCa2fXoyjC8PwxeuUQSmvV+uzRE1hCIUvMOexczVGOHCxWZ5wsBjBUjyD3twOoO3
         fYqeHfIYWKoPimHzqQSi8C0QreR/rzw+3r+L/7tCtAq2xG+JUpjvGXhmiEuw23ckbwRN
         +Cug==
X-Gm-Message-State: AJIora8+Oy9d2vHl+TkUuOTZVR03Nw2/CTanbJFOjRozWlvVREzn6AO1
        ag/awL86zKHVs+5GR5Otv8x4ww==
X-Google-Smtp-Source: AGRyM1vwe00RJwcCdjXBmmfKLgvPibWNGA0LHofdnMUV5DQm21pfWyqJ4YVMEEeyVnZ0dpPH9slVTw==
X-Received: by 2002:a17:90a:9315:b0:1f1:fea7:5899 with SMTP id p21-20020a17090a931500b001f1fea75899mr17892691pjo.123.1658508193933;
        Fri, 22 Jul 2022 09:43:13 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:a300:cc0::2344])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b0016c6e360ff6sm3934348plt.303.2022.07.22.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:43:13 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:43:11 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] More send v2 updates: otime, fileattr
Message-ID: <YtrTn30IumaM305L@relinquished.localdomain>
References: <cover.1655299339.git.dsterba@suse.com>
 <20220623142905.GR20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623142905.GR20633@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 23, 2022 at 04:29:05PM +0200, David Sterba wrote:
> On Wed, Jun 15, 2022 at 03:24:55PM +0200, David Sterba wrote:
> > New protocol enhancements:
> > 
> > - send otime with utimes command
> > - rename SETFLAGS to FILEATTR and send the btrfs inode flags
> > - other cleanups
> > 
> > David Sterba (6):
> >   btrfs: send: add OTIME as utimes attribute for proto 2+ by default
> >   btrfs: send: add new command FILEATTR for file attributes
> >   btrfs: send: drop __KERNEL__ ifdef from send.h
> >   btrfs: send: simplify includes
> >   btrfs: send: remove old TODO regarding ERESTARTSYS
> >   btrfs: send: use boolean types for current inode status
> 
> Moving from topic branch to misc-next. I got no feedback on the protocol
> extensions, there's still time though.

This looks good to me. I think it's reasonable to send the inode flags
exactly as is and implement applying them in receive later.

I don't know whether you want to go back and add it, but for the series
as it currently exists in misc-next:

Reviewed-by: Omar Sandoval <osandov@fb.com>
