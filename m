Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430D5EC558
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfKAPJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 11:09:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727893AbfKAPJC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 11:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87590B43A;
        Fri,  1 Nov 2019 15:09:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51991DA7AF; Fri,  1 Nov 2019 16:09:08 +0100 (CET)
Date:   Fri, 1 Nov 2019 16:09:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
Message-ID: <20191101150908.GU3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1572534591.git.dsterba@suse.com>
 <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 01, 2019 at 10:54:45AM -0400, Neal Gompa wrote:
> What's the reasoning for not submitting this for 5.4? I think the
> improvements here are definitely worth pulling into the 5.4 kernel
> release...

Because 5.4 is at rc5, new features are allowed to be merged only during
the merge window, ie. before 5.4-rc1. Thats more than a month ago.  From
rc1-rcX only regressions or fixes can be applied, so you can see pull
requests but the subject lines almost always contain 'fix'.

A new feature has to be in the develoment branch at least 2 weeks before
the merge window opens (for testing), so right now it's the last
opportunity to get it to 5.5, 5.4 is out of question. No matter how much
I or users want to get it merged. This is how the linux development
process works.

The raid1c34 patches are not intrusive and could be backported on top of
5.3 because all the preparatory work has been merged already.
