Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC10D4208C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhJDJx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 05:53:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhJDJxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 05:53:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 146D42222A;
        Mon,  4 Oct 2021 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633341126;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RuHaM5/+Zd6rypZQOnlIw+TZpWd8IS6XEW40dyMfvGw=;
        b=eTqG0HGvDtBM16YckjwR1wMWpojv6zcL0rhEx0ep+PMB9yqAiGmtntA9sDpiP8vCcuokMx
        gzum4YbR7/Hav1jsVqwGGJtdKnmfs1syD7fC9G5Jd6zpax6UERtveBckVOZjRRFyaMHCmO
        hAgTNfSag6YidBfs5Z4YzdoeLNKXE8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633341126;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RuHaM5/+Zd6rypZQOnlIw+TZpWd8IS6XEW40dyMfvGw=;
        b=9PbyHeAY0lRS63SDQZjK6HeN6fKgECC1ejbixZ/DdpKQ/eNlXZS8WNkAE6aaBgUFHJx4qX
        fvBR8M/vxfZ6nYBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0D002A3B91;
        Mon,  4 Oct 2021 09:52:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EBF50DA7F3; Mon,  4 Oct 2021 11:51:46 +0200 (CEST)
Date:   Mon, 4 Oct 2021 11:51:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Changing the checksum algorithm on an existing BTRFS filesystem
Message-ID: <20211004095146.GU9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Matthew Warren <matthewwarren101010@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 04, 2021 at 12:26:16AM -0500, Matthew Warren wrote:
> Is there currently any way to change the checksum used by btrfs
> without recreating the filesystem and copying data to the new fs?

I have a WIP patch but it's buggy. It works on small filesystems but
when I tried it on TB-sized images it blew up somewhere. Also the WIP is
not too smart, it deletes the whole checksum tree and rebuilds if from
the on-disk data, so it lacks the verification against the existing
csums. I intend to debug it some day but it's a nice to have feature,
I'm aware that people have been asking for it but at this point it would
be to dangerous to provide even the prototype.
