Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA736336DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFCRgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 13:36:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43757 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfFCRgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jun 2019 13:36:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so950071qka.10
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2019 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MpnliDt//C20Zuh05ix82YrkKj7iXPmYTS29BS296fU=;
        b=FGXQu37MgyyZBG94Ly0B8+zLSnHB4byK5uHQ5uZjPyIj+Hz5qZFsKvv4eUQ0j+u35B
         IvR13Zx0JyC56TMA4s9qnzG+QNfpRJTm2QSWBlwM0YoLuRgIQPqawRhl+ax9BZFQxL2I
         kOKeEhXpxooOuy8Efq4GxXg+qJ8IUqE8TW5HnJR90wKi5a07mUuA4UhD9RpmNPtjlZQn
         wwu0EfcDqk7YxrkAgUalvW6zh3LVQeIxPz8LnO/K2nuvJL+skXGeub1EEF6II1pm21FT
         IfmbYX0R4j8p9rTKJ0VRyNZd3j80eXtEzENQYJRYggRLgNt8e5HWJ6kP/7j89sgWt6ne
         WRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MpnliDt//C20Zuh05ix82YrkKj7iXPmYTS29BS296fU=;
        b=udHWu9JMKT5E8YAiHAc7f1Sv9XfZGximbAnffyod+HhGpZbYRRAgJfSdOq6TndT8S1
         Bb7gvhZcK6GtD1PFzU3DUkJs7Bix2aUoqJpDj0sOZk5Gtnvenq60J71fZiiWcTyufNoQ
         GzOHDfKRWn5kf2HN46cPNue6Vx9qGQuvLY/qhBFBUfF0tncv/r9bL0pruBrkGZNFagqj
         rQfJ9ikBYjgynae+uLu/uAZqx/pA1mHKtq47QsjLjceYf4ZI9ma2tA5Dknjxp83gUt/H
         dOeO7xx25eJKjdvwNstB3Fnf9PI3JJfDpXASMGTEC4TD0GSsz6nz7zYbxuO2lQb110I/
         Pgbg==
X-Gm-Message-State: APjAAAW/3Von3kCSq7d7e1VwRG5+y72og2LycN916nHRKmdkjB/2+lZn
        ZijRsm84MMwhsOaaGhO06tiFdg==
X-Google-Smtp-Source: APXvYqwl5ljXxcHb2KvsGLK0pkuY/7WxaARLfMxsnLPqUPs0/oxEpPdXozBnpVFlbl0bFEO70D/qEg==
X-Received: by 2002:a37:696:: with SMTP id 144mr22210446qkg.250.1559583373491;
        Mon, 03 Jun 2019 10:36:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e133sm11951719qkb.76.2019.06.03.10.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:36:12 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:36:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
Message-ID: <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 02:53:00PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/2/13 上午12:03, David Sterba wrote:
> > On Thu, Jan 24, 2019 at 09:31:43AM -0500, Josef Bacik wrote:
> >> Previously callers to btrfs_end_transaction_throttle() would commit the
> >> transaction if there wasn't enough delayed refs space.  This happens in
> >> relocation, and if the fs is relatively empty we'll run out of delayed
> >> refs space basically immediately, so we'll just be stuck in this loop of
> >> committing the transaction over and over again.
> >>
> >> This code existed because we didn't have a good feedback mechanism for
> >> running delayed refs, but with the delayed refs rsv we do now.  Delete
> >> this throttling code and let the btrfs_start_transaction() in relocation
> >> deal with putting pressure on the delayed refs infrastructure.  With
> >> this patch we no longer take 5 minutes to balance a metadata only fs.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > For the record, this has been merged to 5.0-rc5
> > 
> 
> Bisecting leads me to this patch for strange balance ENOSPC.
> 
> Can be reproduced by btrfs/156, or the following small script:
> ------
> #!/bin/bash
> dev="/dev/test/test"
> mnt="/mnt/btrfs"
> 
> _fail()
> {
> 	echo "!!! FAILED: $@ !!!"
> 	exit 1
> }
> 
> do_work()
> {
> 	umount $dev &> /dev/null
> 	umount $mnt &> /dev/null
> 
> 	mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
> 
> 	mount $dev $mnt
> 
> 	for i in $(seq -w 0 511); do
> 	#	xfs_io -f -c "falloc 0 1m" $mnt/file_$i > /dev/null
> 		xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
> 	done
> 	sync
> 
> 	btrfs balance start --full $mnt || return 1
> 	sync
> 
> 
> 	btrfs balance start --full $mnt || return 1
> 	umount $mnt
> }
> 
> failed=0
> for i in $(seq -w 0 24); do
> 	echo "=== run $i ==="
> 	do_work
> 	if [ $? -eq 1 ]; then
> 		failed=$(($failed + 1))
> 	fi
> done
> if [ $failed -ne 0 ]; then
> 	echo "!!! failed $failed/25 !!!"
> else
> 	echo "=== all passes ==="
> fi
> ------
> 
> For v4.20, it will fail at the rate around 0/25 ~ 2/25 (very rare).
> But at that patch (upstream commit
> 302167c50b32e7fccc98994a91d40ddbbab04e52), the failure rate raise to 25/25.
> 
> Any idea for that ENOSPC problem?
> As it looks really wired for the 2nd full balance to fail even we have
> enough unallocated space.
> 

I've been running this all morning on kdave's misc-next and not had a single
failure.  I ran it a few times on spinning rust and a few times on my nvme
drive.  I wouldn't doubt that it's failing for you, but I can't reproduce.  It
would be helpful to know where the ENOSPC was coming from so I can think of
where the problem might be.  Thanks,

Josef

