Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F0362BDE
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 01:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhDPXS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 19:18:27 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41547 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhDPXS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 19:18:26 -0400
Received: by mail-pf1-f180.google.com with SMTP id w6so4778860pfc.8;
        Fri, 16 Apr 2021 16:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mH1Ma8Sm5bk3lpTGX4oY/8pZj+YJEpOBjR0h/3eGX9w=;
        b=VFB2VakOyNXr9kI39JttRYoiS4JIZ10nsmIA5SS/c5q5wQ7Dc6AXcb3X460u0fB+7i
         5+miRTf9iqvSebdTOWZZsIL2S6R+qtk0RGX22kKDnVYagrwfG7/zOSIKPPZ160xWnziy
         EAvn6B0XiB4QcR9OB6TaPMN7hln3omGnkFThnQzeavi6Am6dqLjhbAAJaYXeJ98F4td0
         LVH0fUuOFm7Hpzwogh7TuS68P9oTgkA1sDIt9KViJk7xBDkb3RR2JK5X0XyroprntxZe
         t8TiQ3Ztd9AGiqk0Xq/e8nmVE0x+tYARrMrD/25Oys8DUJ+lQ8994NvP60u6apWkN+8F
         fWDQ==
X-Gm-Message-State: AOAM5303E1o1GhVJ8tghWeTMRaJwD74fpZLinjUo3PYS52nhXu8WI3d8
        5l3sqB/Z2Pm3NnDYViPFlYw=
X-Google-Smtp-Source: ABdhPJwkPggk5/Bm3RxS9LdQsuDpVF109Y+PN1zXktQiJBZd3SsaxelMdBr3lpy46Iz77jo/h7RE9Q==
X-Received: by 2002:a63:d714:: with SMTP id d20mr1173746pgg.285.1618615078799;
        Fri, 16 Apr 2021 16:17:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f2sm5814240pfe.177.2021.04.16.16.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:17:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 037F2403A2; Fri, 16 Apr 2021 23:17:56 +0000 (UTC)
Date:   Fri, 16 Apr 2021 23:17:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>,
        Greg KH <gregkh@linuxfoundation.org>, dsterba@suse.cz,
        Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>,
        fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20210416231756.GW13911@42.do-not-panic.com>
References: <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
 <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
 <20210403202538.GW4332@42.do-not-panic.com>
 <20210408180224.GV13911@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408180224.GV13911@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 08, 2021 at 06:02:24PM +0000, Luis Chamberlain wrote:
> On Sat, Apr 03, 2021 at 08:25:38PM +0000, Luis Chamberlain wrote:
> > So creating say 1000 random files in /lib/firmware on a freshly created
> > btrfs partition helps reproduce:
> > 
> > mkfs.btrfs /dev/whatever
> > mount /dev/wahtever /lib/firmware
> > # Put it on /etc/fstab too
> > 
> > Generate 1000 random files on it:
> > 
> > ```
> > for n in {1..1000}; do                                                          
> >     dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
> > done  
> > ```
> > 
> > Then reboot, upon reboot do:
> > 
> > modprobe test_firmware
> > echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
> > systemctl suspend
> > 
> > If its a guest wake it up:
> > 
> > virsh dompmwakeup domidofguest
> 
> This happens because:
> 
> btrfs_lookup() --> ... -->                                                      
> btrfs_search_slot() --> read_block_for_search() -->                             
> 	--> read_tree_block() --> btree_read_extent_buffer_pages() -->                
> 	--> submit_one_bio() --> btrfs_submit_metadata_bio() -->                      
> 	--> btrfsic_submit_bio() --> submit_bio()
> 		--> this completes and then
> 	--> wait_on_page_locked() on the first page
> 	--> never returns                                                             
> 
> I also managed to reproduce this easily with XFS as well, so this is not
> a btrfs thing as I suspected. It does not happen with ext4 though.
> However I think that's just by chance, it should still be prone to the
> same issue.
> 
> Either way, I'm dusting off my patches for fs freeze as I believe that
> should fix this problem. I am not sure if we want a stop gap hack like
> the one I posted in the meantime... I don't think so. I rather fix this
> well with the series I'll post for fs freeze. Give me a bit of time and
> I'll CC you on the patches.

Low and behold, as I suspectd, my old VFS fsfreeze / thaw patch series
this. However I should note that I needed to add remove also the
WQ_FREEZABLE from fs as well, which was missing in my patch series, and
which Jan Kara had pointed out.

However, the VFS freeze work is quite a bit of work which we are still
discussing, so in the meantime, I think we have no other option but
to put the stop-gap patch I suggested with the usermode helper lock.
I will just modify it a bit more.

I'll also post my fs freeze work now again, but I'll note that it
still requires some more work to address everything which we have
discussed in the community. I'll post the patches as I think others
may be interested in the progress of that.

  Luis
