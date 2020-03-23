Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860F318FB03
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 18:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCWRLV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 13:11:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbgCWRLU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 13:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 921D2ADE2;
        Mon, 23 Mar 2020 17:11:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C730DA811; Mon, 23 Mar 2020 18:10:49 +0100 (CET)
Date:   Mon, 23 Mar 2020 18:10:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: sysfs: Use scnprintf() instead of snprintf()
Message-ID: <20200323171048.GL12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Takashi Iwai <tiwai@suse.de>,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <20200322090911.25296-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322090911.25296-1-tiwai@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 22, 2020 at 10:09:11AM +0100, Takashi Iwai wrote:
> snprintf() is a hard-to-use function, and it's especially difficult to
> use it properly for concatenating substrings in a buffer with a
> limited size.  Since snprintf() returns the would-be-output size, not
> the actual size, the subsequent use of snprintf() may point to the
> incorrect position easily.  Also, returning the value from snprintf()
> directly to sysfs show function would pass a bogus value that is
> higher than the actually truncated string.
> 
> That said, although the current code doesn't actually overflow the
> buffer with PAGE_SIZE, it's a usage that shouldn't be done.  Or it's
> worse; this gives a wrong confidence as if it were doing safe
> operations.
> 
> This patch replaces such snprintf() calls with a safer version,
> scnprintf().  It returns the actual output size, hence it's more
> intuitive and the code does what's expected.

Thanks, added to patch queue.
