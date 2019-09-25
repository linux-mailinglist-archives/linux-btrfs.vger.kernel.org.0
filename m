Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106FCBDF63
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406977AbfIYNr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405102AbfIYNr2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:47:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00085AFCC;
        Wed, 25 Sep 2019 13:47:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3AED3DA835; Wed, 25 Sep 2019 15:47:47 +0200 (CEST)
Date:   Wed, 25 Sep 2019 15:47:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] The remaining extent_io.c split code
Message-ID: <20190925134747.GG2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190924203252.30505-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924203252.30505-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 04:32:48PM -0400, Josef Bacik wrote:
> Hopefully all of it makes it this time, if you want you can pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git \
> 	extent-io-rearranging

The size of the exported patch 1/4 is 109066 bytes and the diff itself
is incomprehensible to even see what code moves where and what is new.

I'm still thinking if this is a good idea to apply a monster patch, even
it's just moving code around. The previous series splitting
extent-tree.c were better so I'd rather take that approach again. Some
of the functions belong logically together and won't break compilation
and would actually make it possible for a human to review.
