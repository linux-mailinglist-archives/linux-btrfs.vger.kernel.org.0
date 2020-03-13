Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD21850E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCMVTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgCMVTq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:19:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA96BAD81;
        Fri, 13 Mar 2020 21:19:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 446ECDA7A7; Fri, 13 Mar 2020 22:19:19 +0100 (CET)
Date:   Fri, 13 Mar 2020 22:19:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8][v4] Cleanup how we handle root refs, part 2
Message-ID: <20200313211919.GQ12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200214211147.24610-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 04:11:39PM -0500, Josef Bacik wrote:
> v3->v4:
> - Rebased onto the latest misc-next, there were some subtle conflicts and
>   weirdness with the automatic merge, so resending.

With some last touches the series has been moved from topic branch to
misc-next. The bugs found by the leak detector plus some other bugs
found on the way have your fixes before this series so the bisection
should not cause weird surprises should we ever need it. Thanks.
