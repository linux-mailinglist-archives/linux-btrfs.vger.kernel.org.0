Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8FB2487C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHROhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 10:37:20 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33634 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHROhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 10:37:19 -0400
Received: by mail-io1-f48.google.com with SMTP id g14so21468317iom.0;
        Tue, 18 Aug 2020 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvDiFSHCMP00JRwPpFIepjmdNNs7NQxVpXYCSaohcWE=;
        b=mFPreDZKV4vHYBF0Yi9lRSvvKBWSlaWYIXQeN6p7mHAZkoKTZwTQNbxhBwUs1ur3G3
         m5IFCVGubhjDKDl6j1tT1aXsTigDGZevp3iJsxj60Bki8CozHYEHYGsE3nSWZZCoucuo
         lu5wUL7lDTOrW+zBpRYpO+KcTEi+lE61uPdl75xYbIiHkKwao2fNzCqBdXsy8GL97Rvi
         16AFS0gHhMMmn4Qqm3ZBsuIGEqYD5sJerj77rE+4CgfjcaIo2IeH4kkhnosyOW7wHSAE
         kl5VJ5IQDgRaV/1onoeiHfYcHBB5wQCeOBQKMbz+AaoWVABqx4Gr6QcH8dUxTycvJeRw
         pULA==
X-Gm-Message-State: AOAM532P/LEI58ErhYaoO5zdTt4bdK47FtXe7FSe+gTIDx4IEGc+NwRD
        iIdjodZNwhC08FiJDQfDDCk=
X-Google-Smtp-Source: ABdhPJxnn2B0WzR309SekP4oYLzfek0uIR9zSY77kfpMtT2egbp4JP9sX7OBycX0RREH5J0lgPswRA==
X-Received: by 2002:a5d:9943:: with SMTP id v3mr16086981ios.51.1597761438176;
        Tue, 18 Aug 2020 07:37:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y11sm10913813iot.23.2020.08.18.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:37:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A04904046C; Tue, 18 Aug 2020 14:37:15 +0000 (UTC)
Date:   Tue, 18 Aug 2020 14:37:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20200818143715.GF4332@42.do-not-panic.com>
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
 <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 18, 2020 at 12:04:51AM +0200, Lukas Middendorf wrote:
> On 17/08/2020 17:20, Luis Chamberlain wrote:
> A freeze can happen on resume with and without the si2168 firmware files
> installed. It however is easier to hit the freeze with the firmware files
> installed. Without the firmware files present the freeze happens only if no
> other driver uses the firmware loader.
> 
> > 
> > This helps, thanks so much, now we'll have to write a reproducer, thanks
> > for the report!!
> 
> Will you do it yourself or do you expect me to do anything for this?

I meant to imply that we'd do this, now that we understand the problem. Thanks
for your report!

> > > The nouveau driver in use seems to be equivalent to running "ls -R
> > > /usr/lib/firmware" before suspend.
> > > 
> > > All the cases seem to boil down to:
> > > It freezes if the file system has to be accessed to list the content of
> > > /usr/lib/firmware or to read the si2168 firmware file
> > 
> > Let's confirm first whether or not your system is using other firmware
> > files too or not.
> 
> I confirmed that above. Why is this so important, anyway?

A reproducer is easier to write if the actual file neeed is not needed.
That's all.

  Luis
