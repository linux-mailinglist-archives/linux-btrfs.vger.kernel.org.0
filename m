Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6A255D75
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 17:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH1PJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 11:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH1PJ0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 11:09:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E42EAE91;
        Fri, 28 Aug 2020 15:09:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 199FEDA7FF; Fri, 28 Aug 2020 17:08:16 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:08:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: hold the uuid_mutex for all close_fs_devices calls
Message-ID: <20200828150815.GO28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <e45e00c3d31286c86b76693262266e702ed7f1a3.1598624685.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45e00c3d31286c86b76693262266e702ed7f1a3.1598624685.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 10:24:57AM -0400, Josef Bacik wrote:
> My recent change to not take the device_list_mutex for closing devices
> added a lockdep_assert_held(&uuid_mutex) to close_fs_devices.  I then
> went and verified all calls had that, except I overlooked
> btrfs_close_devices() where we close seed devices.  Fix this by holding
> the uuid_mutex for this entire operation.
> 
> 20cc6d129252 ("btrfs: do not hold device_list_mutex when closing devices")

This is still in misc-next so I won't apply it as a separate patch.
You can eithere send a v2 of the patch or send it as an "improper" patch
with reference to the patch that needs to be updated with the diff.
