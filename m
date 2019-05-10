Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48F219CF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEJMCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 08:02:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:58260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfEJMCQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 08:02:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83CF9AE08
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 12:02:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C09C3DA8D6; Fri, 10 May 2019 14:03:13 +0200 (CEST)
Date:   Fri, 10 May 2019 14:03:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Return EAGAIN if we can't start no snpashot write
 in check_can_nocow
Message-ID: <20190510120313.GY20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190507072346.17964-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507072346.17964-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 10:23:46AM +0300, Nikolay Borisov wrote:
> The first thing code does in check_can_nocow is trying to block
> concurrent snapshots. If this fails (due to snpashot already being in
> progress) the function returns ENOSPC which makes no sense. Instead
> return EAGAIN. Despite this return value not being propagated to callers
> it's good practice to return the closest in terms of semantics error
> code. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to 5.3 queue, thanks.
