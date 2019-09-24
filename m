Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC12BC8B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfIXNSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 09:18:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37451 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbfIXNSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 09:18:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id d2so2064225qtr.4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbKhRwJkuGlflXcl4Dv0BRBq3BZXRyGBalBLJf/LYKY=;
        b=gUwR6MSyPVwvVBD1uftHTLGej5ZAjviknVESmTmfn6XCFK3QSPtmmDyL4oCkWWPWcs
         /ezapct0rM0iKuxrkeR0w0NSrltJrShhRH2jN9zq2ofrBz4ntd9h5g9lhREQ+QyD/lzI
         m05/jafzrRHB9W3sM0SxlVL2mBHfql7rA9Z9RaV/5MHIac5MUpi1sDd3tIyWpH+ZFrNq
         PGa378yyej+gmmJmVxXKGUXrloV+fVyMlu9rdHum+qc2Mnzb5seqDsLHbLlZApqWrfG3
         c/uZsaZoddRgtHMrMVDlLLBh/bHYUO9u8TpYdgPE8A4aSTNFp5srLFLnFoQbDXHRSZ2j
         NbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbKhRwJkuGlflXcl4Dv0BRBq3BZXRyGBalBLJf/LYKY=;
        b=OZqoN7HqTQdd5eD1TM03aZlII8VZcwAeQ83E4g9xJ4eslgnn2LPWNjdQ3+bew0sPiv
         gYXjIm3xJAnQnITs0FcFNX2XPxMKrcosLvOvH70VZV72LXk9C4UE8V/KjHGqoaFZ5uJO
         ZugnFfb2Vde4GsSiSyI3GDsGIzGLI55oxTLzAz7JNOeQywNk0FgB76pb50JZC6x+VYnA
         HdipSOSRQ7jmqELVNZr9LFdK+J66PBGiqgIjswISXSD0W5ZpRMu/0Wh+EvIH+85L0DZf
         oiGu6XZXFmr5pCE7wgjfWILdbjeBc2ArdOY14L7ZMWK55MpAIcbY1CgX/EdKQoSqcXyh
         vs/g==
X-Gm-Message-State: APjAAAW039ijPPOCTaGqFrppDJDaNWCIEIjIeSEGpSEoaRfruXNLJ1kR
        1tG0FICzltpUFMpo8z9ySHkRUh2WcMSj7Q==
X-Google-Smtp-Source: APXvYqyZGCtzpxeWyrEIucHSAFrrvO+ijhpjKcByDrKd/UNWYk04kSPMeBZs4AbwDz4O6yvbUUKXLQ==
X-Received: by 2002:a0c:e948:: with SMTP id n8mr2367679qvo.113.1569331131881;
        Tue, 24 Sep 2019 06:18:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id f18sm864040qkl.55.2019.09.24.06.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:18:51 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:18:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9][V3] btrfs: break up extent_io.c a little bit
Message-ID: <20190924131848.idms3hljiz2exm2w@macbook-pro-91.dhcp.thefacebook.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
 <20190923170101.GM2751@twin.jikos.cz>
 <20190923182103.kokip2qevnaqzov4@MacBook-Pro-91.local>
 <20190924074615.GO2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924074615.GO2751@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 09:46:15AM +0200, David Sterba wrote:
> On Mon, Sep 23, 2019 at 02:21:04PM -0400, Josef Bacik wrote:
> > > I got some strange merge conflicts, it turns out patch 6/9 did not make
> > > it to the mailinglist (nor patchwork where I could pick it eventually).
> > > For that it's useful to have the list of commits too along with the
> > > diffstat, ie. what format-patch generates.
> > 
> > Huh weird.  I see you merged up through patch 5, I'll rebase and resend and
> > maybe this time the ML will take it.
> 
> Yeah I merged what I had, even some of the 7-9 applied but that could
> cause conflicts after your changes.
> 
> > How about I start sending pull requests through github for everything in
> > addition to sending stuff to the mailinglist, that way it's easier to track the
> > bigger things?  Thanks,
> 
> You can always send a link to git branch with the patches, not only for
> cases like that, but we also want the mailig list copy. I almost always
> process the mailinglist to send replies and to check previous
> iterations. IOW, git branch is for convenience.

Yeah I'm not saying replace the mailinglist stuff, but augment it with a github
PR to make sure things don't get lost.  I'll follow up with that shortly.

Josef
