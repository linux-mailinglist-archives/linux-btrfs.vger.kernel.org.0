Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E1358BE2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDHSCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 14:02:38 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:37535 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhDHSCi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 14:02:38 -0400
Received: by mail-pf1-f180.google.com with SMTP id o123so2420530pfb.4;
        Thu, 08 Apr 2021 11:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmRxsFwPJZvgZ2ZutPHOUue/cGAfIG+bHPlIWgMNM/E=;
        b=E4RsyJEK0WD9SPIGmj4LRgTkt//ymUew7chXpkHG17xon77d10JxZ5QGFMa0gG44gk
         U+7ywlb8Bn8VRMxUD8AfXNDVx3O/qnmde1wIOF6q+wcMuJY/WeMC6a9aYJWpbrs/jeCw
         IcY8vdnU71JaasSjkx3uH9dU+HnCd9LYfAvpAKW6zJlpGu18iEGnDmaXc4EuFvjX0ije
         vHnPOao/RK16Jq6QCqoSlwTw8oX7u1gyTiKCgeP4PziwcY9bFYFIm1BJsTBBXn0vysVI
         1sD1tbEbM/DkLku41ucsUv/SGgdBGUgbyUZCpZ5cuSFw9HFEeyRwlItmDEVrwFvt380C
         onDA==
X-Gm-Message-State: AOAM533gDshVBs9tQP4DrnwEWV/pKf5XHBzmWRF6n3qhhMxEQ7InvQ4B
        4AKXWhAaZOvGRQPTe9j5tJQ=
X-Google-Smtp-Source: ABdhPJyDMh4PSxd/V9evdQx1SANBlCgmjCjNhtVIKYT0qS6zPrk0gCNheU4HLnmN0SJVeR0acVBlzA==
X-Received: by 2002:a63:4c66:: with SMTP id m38mr9190242pgl.313.1617904946227;
        Thu, 08 Apr 2021 11:02:26 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d75sm127540pfd.100.2021.04.08.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 11:02:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 46C62402D7; Thu,  8 Apr 2021 18:02:24 +0000 (UTC)
Date:   Thu, 8 Apr 2021 18:02:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>,
        Greg KH <gregkh@linuxfoundation.org>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20210408180224.GV13911@42.do-not-panic.com>
References: <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
 <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
 <20210403202538.GW4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403202538.GW4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 03, 2021 at 08:25:38PM +0000, Luis Chamberlain wrote:
> So creating say 1000 random files in /lib/firmware on a freshly created
> btrfs partition helps reproduce:
> 
> mkfs.btrfs /dev/whatever
> mount /dev/wahtever /lib/firmware
> # Put it on /etc/fstab too
> 
> Generate 1000 random files on it:
> 
> ```
> for n in {1..1000}; do                                                          
>     dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
> done  
> ```
> 
> Then reboot, upon reboot do:
> 
> modprobe test_firmware
> echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
> systemctl suspend
> 
> If its a guest wake it up:
> 
> virsh dompmwakeup domidofguest

This happens because:

btrfs_lookup() --> ... -->                                                      
btrfs_search_slot() --> read_block_for_search() -->                             
	--> read_tree_block() --> btree_read_extent_buffer_pages() -->                
	--> submit_one_bio() --> btrfs_submit_metadata_bio() -->                      
	--> btrfsic_submit_bio() --> submit_bio()
		--> this completes and then
	--> wait_on_page_locked() on the first page
	--> never returns                                                             

I also managed to reproduce this easily with XFS as well, so this is not
a btrfs thing as I suspected. It does not happen with ext4 though.
However I think that's just by chance, it should still be prone to the
same issue.

Either way, I'm dusting off my patches for fs freeze as I believe that
should fix this problem. I am not sure if we want a stop gap hack like
the one I posted in the meantime... I don't think so. I rather fix this
well with the series I'll post for fs freeze. Give me a bit of time and
I'll CC you on the patches.

  Luis
