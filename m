Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AE82F22A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 23:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbhAKWWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 17:22:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbhAKWWg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 17:22:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4FCBB747;
        Mon, 11 Jan 2021 22:21:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9037DA701; Mon, 11 Jan 2021 23:20:03 +0100 (CET)
Date:   Mon, 11 Jan 2021 23:20:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 08/13] btrfs: abort the transaction if we fail to inc ref
 in btrfs_copy_root
Message-ID: <20210111222003.GM6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135557.git.josef@toxicpanda.com>
 <464b00efa5cbf3e97c795c56605fbb4291839247.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464b00efa5cbf3e97c795c56605fbb4291839247.1608135557.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:22:12AM -0500, Josef Bacik wrote:
> I hit a pretty ugly corruption when doing some error injection, it turns

Maybe it's useful to have the stack trace even for injected errors, it
gives some perspective about the context and call chain.
