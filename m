Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775241FD550
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 21:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFQTUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 15:20:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQTUK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 15:20:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D4FDADF2;
        Wed, 17 Jun 2020 19:20:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ACE96DA728; Wed, 17 Jun 2020 21:19:59 +0200 (CEST)
Date:   Wed, 17 Jun 2020 21:19:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Robbie Smith <zoqaeski@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Does balancing also defragment data?
Message-ID: <20200617191959.GR27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Robbie Smith <zoqaeski@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CACurcBuLnsLKB1qgsOyU+W8TecZEnfoqnLziA6ynT95DEvNdDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACurcBuLnsLKB1qgsOyU+W8TecZEnfoqnLziA6ynT95DEvNdDw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 13, 2020 at 03:20:25PM +1000, Robbie Smith wrote:
> This is something I've been wondering about lately. The defragmenting
> tool has known issues that break reflinks when run on files with lots
> of snapshots or copies, but balancing does not do this. The manual
> states that running a full balance without filters will basically
> rewrite the entire filesystem, so does it also defragment as it runs,
> or does it preserve the extents?

I've updated the manual page of balance to avoid saying 'rewrite' but
rather 'move to new physical location' and added notes about extent
sharing. Thanks.
