Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39628244CCB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHNQha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 12:37:30 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44764 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHNQh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 12:37:27 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so8931998ilc.11;
        Fri, 14 Aug 2020 09:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S8Y/V4Si1WfvlF1LOT6Jq+FPkz/jjzFd3zUw+PXGrW0=;
        b=il0wOQuNcrz57C4qXCS+17yEiQK/MnKI6kUERnS9wpRRClyffbcbSRM0A1Qw9DHGc1
         glAat/i86xgaxGeEB4IffG6vL9pfO4Zuy8jYfJ8ie03DvvUIm7/47JmoypOQJMLbfxU+
         zyiF8/xKSMcGxRsWmmhoNdAjoPXd98TrzsePrSUD8Nn+kFPenS4pzN+vrnwmaxbrGdoX
         8MztYKqH+6p86KsPBVV4Z5ZMwUqjayPlX+qMyBCHV9L3RNwUpB98+0qJk65Pl/v/T3Gz
         rYPWrlMtsiN8vpk3HLhO14UMBq41CxsPgg4AVZA6g0O2FEZnaAu/IjC1eENZV5TkPdI1
         njNw==
X-Gm-Message-State: AOAM5314RtD3QQlpDYOUumTcNaOnE3CJquu3WEA/fTSLrzDdNMUBhiSL
        IxEf51gu87t2perCoX5jljo=
X-Google-Smtp-Source: ABdhPJyhlcGye/3L9pxJ4SzgPIFlWL6VZMywnuPGNAJ5yjhQq511Y8SdFXHwnbXUP1ZYQqM7De7daw==
X-Received: by 2002:a92:1545:: with SMTP id v66mr3241142ilk.251.1597423045737;
        Fri, 14 Aug 2020 09:37:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p21sm4415956ioj.10.2020.08.14.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:37:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B4D474075D; Fri, 14 Aug 2020 16:37:23 +0000 (UTC)
Date:   Fri, 14 Aug 2020 16:37:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20200814163723.GC4332@42.do-not-panic.com>
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
 <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 01:38:40PM +0200, Lukas Middendorf wrote:
> Hey Louis,
> 
> On 14/08/2020 00:13, Luis Chamberlain wrote:
> > On Thu, Aug 13, 2020 at 11:53:36PM +0200, Lukas Middendorf wrote:
> > > With "not used" I mean that the device has been recognized, the si2168
> > > module is loaded and si2168_probe() has been called on the device, but I
> > > have not started a media player which actually plays a DVB-C stream.
> > > Therefore si2168_init() has never been called and the firmware has never
> > > been requested or loaded to the device.
> > > 
> > > On resume si2168_init() will be called (although I don't think this actually
> > > is really necessary)
> > 
> > Indeed, that seems odd given its not on probe. So yet another possible
> > si2168 bug. Or another way to put it: your cache calls are not needed
> > if you remove that si2168_init() if init was not called yet. So simply
> > extending the data structure for the driver and seting a bool flag to
> > true if init was called should do the trick.
> > 
> > Then the two cache calls would not be needed.
> 
> I already thought about a way to remove the firmware load on suspend if it
> has not happened earlier. But I saw no way to distinguish between calls to
> si2168_init() during resume and calls to si2168_init() at the start of
> device usage.
> 
> In contrast to struct dvb_tuner_ops the relevant struct dvb_frontend_ops has
> no separate members "suspend" and "resume" to store callbacks to be called
> instead of sleep and init during suspend and resume. Changing the behavior
> of si2168 would likely include some bigger architectural work on the
> dvb_frontend system to extend dvb_frontend_ops.
> It might be possible to just put nothing into dvb_frontend_ops.init but
> instead populate the dvb_tuner_ops part of the struct, but those pointers
> might already be populated externally for some other use.
> 
> If I try to do this on my very first kernel contribution without in-depth
> knowledge of how the dvb drivers really work, this will likely just explode,
> if not for me then for somebody else with different hardware.

Indeed, the dvb init is called from dvb, so your two patches are good
for now I think.

> > > If the kernel does not already know that the files
> > > are not present without access to the file system, the system just freezes.
> > 
> > It is not clear to me what this means. Can you clarify?
> > 
> > > > >      e) having the firmware files not installed freezes the system during
> > > > > resume if the content of /usr/lib/firmware has not been listed before
> > > > > suspend (e.g. installing the nvidia driver, so the nouveau driver does not
> > > > > access this directory)
> > > > 
> > > > That may be the same issue as in b) assuming that you meant you didn't
> > > > use the dvb device, and that the firmware load issue is from nouveau.
> > > 
> > > This is actually just the inverted case of b).
> > > The only real relevance of the nouveau driver here is that its (perfectly
> > > working) firmware caching on suspend actually seems to be equivalent to
> > > manually running "ls" on the firmware directory and afterwards the kernel
> > > also knows whether or not the si2168 firmware files are present without file
> > > system access.
> > 
> > OK.. I still don't get it, so let me see if we can decipher what you
> > mean here.
> > 
> > If the firmware is *not* present for the si2168 driver and the device
> > has *not* been used yet you get a system freeze which you cannot recover
> > from, but only if you are *not* using a driver which also caches its
> > firmware already?
> 
> Yes, this is exactly what I wanted to say.
> 

OK great.. but..

> A new installation of Fedora 32 without firmware files 

Fedora 32 comes with no firmware at all? Are you sure? How about your
wifi?

> and with nouveau did
> not show my freeze problem. Installing either the firmware files or the
> nvidia driver started the freeze during resume.

Here now you say that if you install either the firmware files for
either si2168 or nouveau can cause a freeze, meanwhile what I wrote
above and you agreed is what you meant, says that the freeze happens
only if you *don't* have the firmware for nouveau present *and* you
also don't have the any other firmware present.

You also clarify here your freeze happens on resume only. Is that right?
Never on suspend, but if the freeze happens, it happens only on resume?

The actual case where you reach a freeze is still not clear yet. Let's
try to clarify this.

  Luis
