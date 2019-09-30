Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D19C2209
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfI3NdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 09:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:55598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbfI3NdS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 09:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1857BADD5;
        Mon, 30 Sep 2019 13:33:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49163DA88C; Mon, 30 Sep 2019 15:33:35 +0200 (CEST)
Date:   Mon, 30 Sep 2019 15:33:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: removed unused return variable
Message-ID: <20190930133335.GZ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Aliasgar Surti <aliasgar.surti500@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1569848421-25978-1-git-send-email-aliasgar.surti500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569848421-25978-1-git-send-email-aliasgar.surti500@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 06:30:21PM +0530, Aliasgar Surti wrote:
> From: Aliasgar Surti <aliasgar.surti500@gmail.com>
> 
> Removed unused return variable and replaced it with returning
> the value directly

This change has been sent several times and I give the same answer each
time:

https://lore.kernel.org/linux-btrfs/20190418154913.GO20156@twin.jikos.cz/

"When switching a fuction to return void, please check the whole
callgraph for functions that do not properly handler errors and do
BUG_ON. You won't see errors passed from them so this gives the
impression no error handling is needed in the caller.

This has been sent in the past, so I can point you to the 2nd paragraph
in
https://lore.kernel.org/linux-btrfs/20180815124425.GM24025@twin.jikos.cz/

hint: btrfs_pin_extent"
