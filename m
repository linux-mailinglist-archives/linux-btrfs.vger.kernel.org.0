Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8F94B00
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHSQ4s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 12:56:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727459AbfHSQ4s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 12:56:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E42BB0DA;
        Mon, 19 Aug 2019 16:56:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B52A5DA7DA; Mon, 19 Aug 2019 18:57:13 +0200 (CEST)
Date:   Mon, 19 Aug 2019 18:57:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more
 frequently for BPF
Message-ID: <20190819165713.GK24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
 <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
 <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 16, 2019 at 11:03:33AM +0100, Filipe Manana wrote:
> > Originally planned to use this feature to catch the exact update, but
> > the problem is, with this pressure, we need an extra ioctl to wait the
> > full subvolume drop to finish.
> 
> That, the ioctl to wait (or better, poll) for subvolume removal to
> complete (either all subvolumes or just a specific one), would be
> useful.

The polling for subvolume drop is implemented using the SEARCH_TREE
ioctl and provided as 'btrfs subvolume sync' command. Is there
something that this approach does not provide and would need a new
ioctl?
