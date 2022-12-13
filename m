Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AFB64B6D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiLMOIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiLMOIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3D18B35
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 06:08:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D793167373; Tue, 13 Dec 2022 15:08:06 +0100 (CET)
Date:   Tue, 13 Dec 2022 15:08:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: use file_offset to limit bios size in
 calc_bio_boundaries
Message-ID: <20221213140806.GA24075@lst.de>
References: <20221212073724.12637-1-hch@lst.de> <20221212073724.12637-2-hch@lst.de> <Y5d41lL0MSBqTto2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5d41lL0MSBqTto2@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 01:54:14PM -0500, Josef Bacik wrote:
> Can you add a comment to the code as well?

Sure.

> I'm going to see this in a year or two
> and spend a little bit scratching my head as to why we're using the file_offset
> here.  With that done you can add

Heh.  I hope the code in this form is actually gone in a year, as the
concept of first creating the ordered extents and inserting them into a
tree, and then doing a lookup a few lines down in writepages is not
exactly very efficient and we should be able to just pass a pointer
down.  But that is several series down in my queue.
