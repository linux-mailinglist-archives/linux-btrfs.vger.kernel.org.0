Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A06181499
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKJTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 05:19:44 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55990 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 05:19:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so532612pjb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SPhEGr9wzsIs4TZ7GhoT2PXQODCxITe8TD7NOWUSGV4=;
        b=kaeTI5tDbWr7DWizfHWO5WN1trerHH2v4VTIOgnU7bFd9vXuOsoO8DONTo9NsqMakm
         7z0iAY7ZTQzBrwbnQ/ZXQx93PsUuJ4TzdFZTHV4psZjNemK6pDjvdo54kQAJH45Gy9Nh
         7Ah6GZvMTXxCqmCy0rKAK2o/mkCBMimfa3SpIVPirwjNTz37sQX/5caoSpe84yTB5sOY
         KexTQV/RVoyyPqVrzB1aFPHCxQhMQ5I7Dghdxd+lzNiZB5PZyDzkYO4cKLNJnvXmloWw
         Ss3aKxLxeh7eJLQHh7DgwtXy5WwVy7gWfkykfGlkBw2I0xuIbdwzbNLh/jb59ileEcFt
         PoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPhEGr9wzsIs4TZ7GhoT2PXQODCxITe8TD7NOWUSGV4=;
        b=NYbscl7IC3phBhGuC5CBN8LCGkvfoaHNkOYWDIVexSHlTiRQzVFKpKf5bIvnvkbVLp
         ARwz0veIF0y93IECaFDA8Y+BC9BZkjjqj3YDQLy/MgyiF1gfEyA54M4moWsIHyekAwDz
         Xjxb3Uat+3p933WDeBqbdUcPfoiKIBwybOA/zAMeG8t68raXJ8uKDtCHc6DQKUVXzM1M
         Ba0G7uUR4tbr561F9EPcnsS4BuAq4RawLrjXWOqf8niD3XF0mWnEtpSaBrD8a6G8y7Qd
         fEcq1RgVZkka81KMyKbIQ4ta61h4wy38hdSsQDR1SC63VdPY4t35qmV05V7YVLwi4DMZ
         7T6g==
X-Gm-Message-State: ANhLgQ0WVPSfK1lJWfEEkZELO6AkvJialin6DM1wbTpnz9PAXdBm9GDy
        xodMnvN1ukwSueYTA7pthGGuiQ==
X-Google-Smtp-Source: ADFU+vvyPtfIpL38xagisM2PO8lvx2YnKqN62Y3S6kotvhdl7eLIWwqxZjkzj9vxPhEO7LyzUrXgmQ==
X-Received: by 2002:a17:90a:5801:: with SMTP id h1mr2455930pji.121.1583918381864;
        Wed, 11 Mar 2020 02:19:41 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id u13sm4846163pjn.29.2020.03.11.02.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 02:19:41 -0700 (PDT)
Date:   Wed, 11 Mar 2020 02:19:40 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/15] btrfs: get rid of one layer of bios in direct I/O
Message-ID: <20200311091940.GF252106@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
 <20200310163835.GD6361@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310163835.GD6361@lst.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 05:38:35PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 09, 2020 at 02:32:38PM -0700, Omar Sandoval wrote:
> > 1. The bio created by the generic direct I/O code (dio_bio).
> > 2. A clone of dio_bio we create in btrfs_submit_direct() to represent
> >    the entire direct I/O range (orig_bio).
> > 3. A partial clone of orig_bio limited to the size of a RAID stripe that
> >    we create in btrfs_submit_direct_hook().
> > 4. Clones of each of those split bios for each RAID stripe that we
> >    create in btrfs_map_bio().
> 
> Just curious:  what is number 3 useful for?

The next thing we do with bio 2 (which has a logical block address) is
to map it to physical block addresses on each device (btrfs_map_bio()).
That mapping is per-stripe, so we either have to avoid building bios
that cross a stripe (which is what buffered I/O does) or we have to
split up the bio (which is what direct I/O does). We probably want to
move towards the first approach for direct I/O, as well, but reworking
get_blocks would conflict with the iomap series, and it looks like that
would be easier to do using iomap instead, anyways.
