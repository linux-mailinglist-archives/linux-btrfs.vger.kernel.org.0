Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF3B18FDD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 20:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCWTkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 15:40:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgCWTkb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 15:40:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5603ACE0;
        Mon, 23 Mar 2020 19:40:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39310DA81D; Mon, 23 Mar 2020 20:39:59 +0100 (CET)
Date:   Mon, 23 Mar 2020 20:39:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs-progs: qgroup-verify: Remove duplicated message in
 report_qgroups
Message-ID: <20200323193959.GO12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200315034253.11261-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315034253.11261-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 15, 2020 at 12:42:53AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Since 1d5b2ad9 ("btrfs-progs: qgroup-verify: Don't treat qgroup
> difference as error if the fs hasn't initialized a rescan") a new
> message is being printed when the qgroups is incosistent and the rescan
> hasn't being executed, so remove the later message send to stderr.
> 
> While in this function, simplify the check for a not executed rescan
> since !counts.rescan_running and counts.rescan_running == 0 means the
> same thing.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to devel, thanks.
