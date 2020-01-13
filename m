Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732A8139B37
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 22:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAMVJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 16:09:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgAMVJl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 16:09:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CFC9FAC44;
        Mon, 13 Jan 2020 21:09:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E741DA78B; Mon, 13 Jan 2020 22:09:28 +0100 (CET)
Date:   Mon, 13 Jan 2020 22:09:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: Extend metadata uuid testcase
Message-ID: <20200113210927.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200110122333.8272-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110122333.8272-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 02:23:33PM +0200, Nikolay Borisov wrote:
> This adds cooked images to exercise the case when a filesystem with
> metadata uuid incompat flag is switched back to having fsid/metadata
> uuid being equal.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks.
