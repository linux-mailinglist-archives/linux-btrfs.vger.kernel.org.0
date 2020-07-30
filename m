Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F32336D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgG3Qc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 12:32:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Qc6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 12:32:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7DC0AD20;
        Thu, 30 Jul 2020 16:33:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DF7CDA842; Thu, 30 Jul 2020 18:32:27 +0200 (CEST)
Date:   Thu, 30 Jul 2020 18:32:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH] btrfs: make sure SB_I_VERSION doesn't get unset by
 remount
Message-ID: <20200730163227.GI3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Sandeen <sandeen@redhat.com>
References: <20200730151809.4889-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730151809.4889-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 11:18:09AM -0400, Josef Bacik wrote:
> There's some inconsistency around SB_I_VERSION handling with mount and
> remount.  Since we don't really want it to be off ever just work around
> this by making sure we don't get the flag cleared on remount.

Agreed. There's a tiny cpu cost of setting the bit, otherwise all
changes to i_version also change some of the times (ctime/mtime) so the
inode needs to be synced. We wouldn't save anything by disabling it.
