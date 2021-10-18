Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4369343141C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhJRKL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 06:11:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36918 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRKLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 06:11:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BD1D01FD6D;
        Mon, 18 Oct 2021 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634551753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaSTpA1xcVsPNWJRSjE6q/vuLWbx4J/8tpmM6UhZ/4I=;
        b=u4wphM4o2J7JoaG/OE5XFhQ6q2RIK2xVHINh+ez1md1K7XZcLw9wjmeXFn84Kyi2yTZ1Pz
        /O0jKVVNlzId3IyrvZtCmENQ6O7jQ5ZMsY+ys638iQ87cW98MC+5QsWlj5HBoY14hZfvEC
        eeU8eQyQ5RdE2ggY/RQjz38kfTt55P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634551753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaSTpA1xcVsPNWJRSjE6q/vuLWbx4J/8tpmM6UhZ/4I=;
        b=fOOUTXB2k9taMiGIwlmS3NTxOsxgboUaR1PIbDpBm3PaZfSuZwEskioA5YGoJO4NzvMcRT
        ZQCwS0YICzqhR+AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B35C2A3B84;
        Mon, 18 Oct 2021 10:09:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96FB6DA7A3; Mon, 18 Oct 2021 12:08:46 +0200 (CEST)
Date:   Mon, 18 Oct 2021 12:08:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     James Harvey <jmsharvey771@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: csum failed, bad tree, block, IO failures. Is my drive dead or
 has my BTRFS broke itself?
Message-ID: <20211018100846.GF30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        James Harvey <jmsharvey771@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
 <637a43e5-4d6f-f69a-74e4-ae240880aa1b@gmx.com>
 <CAHB2pq_6Wb7H3zxvV33gm7j4nknAvPieNtFU_xFRWr4TZE=6cA@mail.gmail.com>
 <95cd0638-b070-6e92-0de7-bfe74e039684@gmx.com>
 <CAHB2pq_hmje4zEjf33KHiQe7TpGAsW+0mczgjZkVnkRnVW7z=g@mail.gmail.com>
 <32b91541-1b30-eb26-36d0-7a642172b547@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b91541-1b30-eb26-36d0-7a642172b547@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 17, 2021 at 08:00:59AM +0800, Qu Wenruo wrote:
> On 2021/10/17 04:45, James Harvey wrote:
> > Check hasn't done yet, but it's spit out about 1700 messages (tmux
> > won't let me scroll up futher) that all look like this:
> 
> Yeah, this means quite a lot of metadata are filled with garbage.
> 
> I'm not sure why, but it doesn't like to be caused by btrfs itself.

Agreed, this amount of garbage would be detected by other means
(mismatching csums while the system is still in use or by
pre-write/post-read tree checker). It's not bitflips, there are too many
changes eg. in the bogus block offsets.

Analyzing the actual data left on disk for some known pattern could at
least give some hint what it was, eg. strings, file headers or raw
pointers. Besides that a manual system check could prevent that in the
future, so check cables, possible overheating, up to date
kernel/firmware (in case it would be cause by other subsystems).
