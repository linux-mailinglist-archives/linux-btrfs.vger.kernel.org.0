Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E388C2DBC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 09:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfJAHAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 03:00:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43330 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 03:00:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so8920197pgk.10
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2019 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsmLJHCbhiqvsXb9gvZB19KfDB7lWFICN1Pn2eBe80U=;
        b=aGI73CSwFombXRz6j02+9yRK8jx7h1OvxAojVi8+wQ1VPI5olXolxbZ8hU2Yawc+vX
         XA2NqCliUeudbsNs8CTd9qJrhGTaCWDxO4WzSp8I5d+4Yt2Q0kaadXgYyiX9u/e1o3JB
         Gf5sQVi0FfzpXfF/f1dE9OCr9jPKNFbuq1za6MSxBFm/TwpLXzknrSCh6XEzRWiqPa8B
         67CaPSlwAPJ5VOGPq/y8L+V6GmZV/6nY6ySE7mwyBcsfrM8MlRy+M0I215g7SB5Nft1l
         4KCd0M96HEFX2K/sA3guhQjf5Kwx0h8LEsQeaGwr+qkntr3q1n6ukVR71s0VOimx5ngI
         ai7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsmLJHCbhiqvsXb9gvZB19KfDB7lWFICN1Pn2eBe80U=;
        b=HQ3Yvfa/NX6vlv7DkQSS7aV0XtPHGIkbsDUY7a/zdtVq03CBVOYGkS5qa97yOIoF8G
         KWs8lHsmsj1irnLey6qRK7li6T5U9Js6ZcirxKHa1ioAV6dXSXSOO2m3iNiYjSMhfoLs
         q7bg+Vd6b3uJEln+eDyTc8vsq1e8VpHJxZdLiaZV/CbbAonEoURF+0eNAX85CBtFcWvK
         Adj8ZSwyXX4/kqjZxZn0C69lJvRN4kNBoqCgHJ3qVHNKBZe0CDde0VvAS58S33nhC1U6
         8KSEGwKt1uSpdpTDA1IzN8FxXGFRdsCCoLxi0qRqlS+shHZI/uybNXeLOk9oc+Megcuu
         QTWQ==
X-Gm-Message-State: APjAAAV814XCB46Y2rvo4zUGUP0JjVTXmdH/5Xq7YfFyZ+kqGLqIiuZq
        kg0+yhQprqputRpR9BmL+kBW65aPSu+kYg==
X-Google-Smtp-Source: APXvYqxqVSP1vrMHbdWn4iAOJ4SKjB3CFxYk0pzsuVZI11NQEsYWnPKE2RNRlrwm3Lev6aJhIfs2RA==
X-Received: by 2002:a63:114b:: with SMTP id 11mr28358485pgr.42.1569913223737;
        Tue, 01 Oct 2019 00:00:23 -0700 (PDT)
Received: from aliasgar ([2401:4900:16a7:e082:2043:a667:769:f528])
        by smtp.gmail.com with ESMTPSA id g24sm24320294pgn.90.2019.10.01.00.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 00:00:22 -0700 (PDT)
Date:   Tue, 1 Oct 2019 12:30:08 +0530
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: removed unused return variable
Message-ID: <20191001070008.GA9578@aliasgar>
References: <1569848421-25978-1-git-send-email-aliasgar.surti500@gmail.com>
 <20190930133335.GZ2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930133335.GZ2751@twin.jikos.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 03:33:35PM +0200, David Sterba wrote:
> On Mon, Sep 30, 2019 at 06:30:21PM +0530, Aliasgar Surti wrote:
> > From: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > 
> > Removed unused return variable and replaced it with returning
> > the value directly
> 
> This change has been sent several times and I give the same answer each
> time:
> 
> https://lore.kernel.org/linux-btrfs/20190418154913.GO20156@twin.jikos.cz/
> 
> "When switching a fuction to return void, please check the whole
> callgraph for functions that do not properly handler errors and do
> BUG_ON. You won't see errors passed from them so this gives the
> impression no error handling is needed in the caller.
> 
> This has been sent in the past, so I can point you to the 2nd paragraph
> in
> https://lore.kernel.org/linux-btrfs/20180815124425.GM24025@twin.jikos.cz/
> 
> hint: btrfs_pin_extent"

Okay, reverted back the changes and submitted v3.

Thanks,
Aliasgar
