Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC06A9964
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCCO2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCCO1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:27:54 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C322211B
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:27:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D995468C4E; Fri,  3 Mar 2023 15:27:46 +0100 (CET)
Date:   Fri, 3 Mar 2023 15:27:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: improve type safety by passing struct btrfs_bio around
Message-ID: <20230303142746.GC32738@lst.de>
References: <20230301134244.1378533-1-hch@lst.de> <a0d08906-acb2-d5b4-9585-d43faf05227a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d08906-acb2-d5b4-9585-d43faf05227a@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 03, 2023 at 07:34:08AM +0800, Qu Wenruo wrote:
> But I'm still a little concerned about possible rogue non-btrfs bios.
> Is it possible to add one magic number member for btrfs_bio, and do extra 
> magic number check in btrfs_bio() macro?

A magic number adds runtime overhead.  The container_of on the bio
frontpad is very common all over the kernel, and we don't do that
anywhere else.  After this series the btrfs_bio() only really happens
on allocation and the end_io handler which is fairly easy to keep
straight.

