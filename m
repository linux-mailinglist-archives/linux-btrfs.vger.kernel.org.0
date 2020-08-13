Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763F5244123
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMWNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 18:13:54 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42131 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMWNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 18:13:52 -0400
Received: by mail-il1-f194.google.com with SMTP id t13so6859161ile.9;
        Thu, 13 Aug 2020 15:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5zEMqet8hV78AhYB9ypFCOyzxUiSK2YeYxxaqVn9Xe4=;
        b=oeiIlR7MSv9M9bulmBaz67xPq/kJQ6h8bBfV1iEDbgpAh009Nj7Xs/pJ2QsERsBHt6
         egrPyQ7/0EijtzF1CDXXzw3midR9FVC1l0+jcp6DTBZjSc48VI/Hgpxdwl8xY3EuS/41
         TBbPo10I2AT1ubUhSNkDR2WCUK/LvGQO08lYFr3C/VdPVwhkyv0ltbg+fI6iTswdaNwl
         IymSa2C/RN2P8DA++l1aN5SOH5y4ywcDEVd938kSHrfh8d74Oqn6fPxJo3QaUztH2cRZ
         MyZQozTxptx+Yu8M5mwnxjnEThuuTx8l5ygvCX+C4pEkQWnSNeTz5GZ0lpYeqtW2+js2
         b+HA==
X-Gm-Message-State: AOAM5323efd9iTO5m4b+RbUc2SVIFw10xkVCWeE3TO0X5utFzFlvRICY
        7rAjpwftU4c9mTS96xJiNas=
X-Google-Smtp-Source: ABdhPJw4Dh2C9EiB4uam2CnmFuUCrwPbBp8x/WrtGnjJc9FBG9dTejZJqlpYFe9PKKdbUO1/8YIlaA==
X-Received: by 2002:a92:994e:: with SMTP id p75mr5774307ili.253.1597356831096;
        Thu, 13 Aug 2020 15:13:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 82sm3204776ioc.34.2020.08.13.15.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 15:13:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0B8AE403DC; Thu, 13 Aug 2020 22:13:49 +0000 (UTC)
Date:   Thu, 13 Aug 2020 22:13:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20200813221348.GB4332@42.do-not-panic.com>
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
 <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 13, 2020 at 11:53:36PM +0200, Lukas Middendorf wrote:
> Hey Luis,
> 
> On 13/08/2020 18:37, Luis Chamberlain wrote:
> > On Sun, Aug 09, 2020 at 08:51:35PM +0200, Lukas Middendorf wrote:
> > 
> > >     b) if the firmware file is not present and the directory content of
> > > /usr/lib/firmware has been listed (e.g. through loading of a different
> > > firmware from there; by the nouveau driver in my case) the firmware load
> > > fails but does not freeze the system
> > 
> > Can you clarify if you mean then that in this case the dvb device is not
> > used?
> > 
> > Which driver firmware load fails?
> 
> With "not used" I mean that the device has been recognized, the si2168
> module is loaded and si2168_probe() has been called on the device, but I
> have not started a media player which actually plays a DVB-C stream.
> Therefore si2168_init() has never been called and the firmware has never
> been requested or loaded to the device.
> 
> On resume si2168_init() will be called (although I don't think this actually
> is really necessary)

Indeed, that seems odd given its not on probe. So yet another possible
si2168 bug. Or another way to put it: your cache calls are not needed
if you remove that si2168_init() if init was not called yet. So simply
extending the data structure for the driver and seting a bool flag to
true if init was called should do the trick.

Then the two cache calls would not be needed.

> and the firmware load of si2168 fails if the firmware
> files are not installed.

OK well that is expected.

> If the kernel does not already know that the files
> are not present without access to the file system, the system just freezes.

It is not clear to me what this means. Can you clarify?

> > >     c) manually reading the firmware files before suspend can make the resume
> > > succeed, but this does not seem to be reliable
> > 
> > That may because of the dentry cache, and so helping races, doing
> > something similar as to what the firmware cache does, but in hacky way.
> > 
> > >     d) modifying the si2168 by adding calls to firmware_request_cache() in
> > > si2168_probe() makes the firmware loading during resume succeed.
> > 
> > That indeed seems like a good idea in general for dvb that should
> > probably be generalized, if dvb had a way to get a dvb's driver
> > firmware name and indeed all dvb drivers are not skipping the firmware
> > cache today.
> > 
> > >     e) having the firmware files not installed freezes the system during
> > > resume if the content of /usr/lib/firmware has not been listed before
> > > suspend (e.g. installing the nvidia driver, so the nouveau driver does not
> > > access this directory)
> > 
> > That may be the same issue as in b) assuming that you meant you didn't
> > use the dvb device, and that the firmware load issue is from nouveau.
> 
> This is actually just the inverted case of b).
> The only real relevance of the nouveau driver here is that its (perfectly
> working) firmware caching on suspend actually seems to be equivalent to
> manually running "ls" on the firmware directory and afterwards the kernel
> also knows whether or not the si2168 firmware files are present without file
> system access.

OK.. I still don't get it, so let me see if we can decipher what you
mean here.

If the firmware is *not* present for the si2168 driver and the device
has *not* been used yet you get a system freeze which you cannot recover
from, but only if you are *not* using a driver which also caches its
firmware already?

In this case if the nouveau is used this freeze does not happen, and you
believe this is because of at least one fetch for the directory is done
already. If so, then this speedup of a fugure negative dentry lookup on
btrfs seems like an interesting test case for btrfs developers too look
at.

But we must first undersand the case well.

> > Are all firmware files used by nouveau upon resume the samea as during
> > probe? If not using firmware_request_cache() for each of them would be
> > a good idea to resolve possible races issues.
> 
> I have not compared them one-by-one, but as I have already written, nouveau
> seems fine here.

OK cool. Thanks for ruling this out!

> > > I'm not sure who really is to blame here:
> > > - BTRFS (ext4 is fine after all)
> > > - the firmware loader because the implementation or the documentation are
> > > wrong
> > > - si2168 because of not loading the firmware or calling
> > > firmware_request_cache() before suspend. Also I don't think it is even
> > > necessary to load the firmware during resume, it should be sufficient to
> > > load the firmware when the tuner is used. I'm not sure though whether the
> > > dvb-frontend driver structure allows to properly distinguish between
> > > resuming and initialization before device usage. The problem can definitely
> > > be worked around here until the root cause is fixed. I can provide a patch
> > > if this solution is seen as appropriate.
> > > 
> > > I'm putting all the maintainers and/or lists of the possible culprits on CC.
> > 
> > Indeed send the patch to use firmware_request_cache() for si2168.
> 
> I sent it to the media mailing list (split into two patches).

Looks good to me, except now that you metion the resuem thing, I think
you can drop those patches if you do the check I mentioned on resume,
ie, to verify that init hasn't been called yet.

Also, might as well rename that function to make it clearer what it does
as init prefixed or postfixed calls tend to be used for things during
initialization.

> > The generic filesystem races on suspend/resume are known, and I will
> > tackle that once I am done with some other task I am completing.
> 
> Great to know that the underlying cause for the freeze is known and a
> solution is being worked on (or at least planned to be worked on).

There is a sliver possibility here that a negative dentry slowdown may
cause a btrfs freeze on suspend easily. If so that can likely be fixed
before that big general filesystem freeze issue I noted with URLs and
talks. But I think we need to confirm that is what is happening here.

  Luis
