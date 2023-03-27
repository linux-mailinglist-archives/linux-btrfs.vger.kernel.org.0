Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DA6C9AD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 07:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjC0FWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FWn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 01:22:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757949D6
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s4GmsOh5JRA3tLReQctoPYCbJ3fXhlRFAt/QIFnLBuU=; b=CrM5MZdcPHj6QlcDU6rb/GpdRz
        VWyehDIGZbcvpox23zdX4FZcWbhab3yi20YV/vlMdPxoQDIVK8yg6vSEd2BWBgwz/UVNHoBaIXP++
        L7wfLzFB+BvhwiaZBcOTKH1wTmO4bdrRnW20ZUFFvRrmX1kil54ki5giKdWh3o+1ZGzd6WNhLD/Rz
        m8XRORvhiyYfjjuRZqB4WDumLD2RDhgO0+BHKCz5++1Lv5/QU0c+ZqkCQFGSr+hp9LqkfqrNgYl6Z
        NjpAxDpt5IGhZaqYN3vko1nhuio3deOg1I8dkTjaAiq6maovhjQJTnxW6SZSV2BMflhnSukyWw+ig
        9V9nRPLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgfJX-009o3U-2l;
        Mon, 27 Mar 2023 05:22:39 +0000
Date:   Sun, 26 Mar 2023 22:22:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Message-ID: <ZCEoHxLZ6KWXMlKu@infradead.org>
References: <cover.1679826088.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1679826088.git.wqu@suse.com>
 <ZCERG/+o6515r06h@infradead.org>
 <a9efa03d-2472-db26-ebb0-dd6b21991863@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9efa03d-2472-db26-ebb0-dd6b21991863@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 27, 2023 at 12:32:22PM +0800, Qu Wenruo wrote:
> > Not crossing the stripe boundary is not enough, for zone append it
> > also must not cross the zone append limit, which (at least in theory)
> > can be arbitrarily small.
> 
> Do you mean that we can have some real zone append limit which is even
> smaller than 64K?
> 
> If so, then the write helper can be more complex than I thought...

In theory it can be as small as a single LBA.  It might make sense
to require a minimum of 64k for btrfs, and reject the writable mount
if it is not, as a device with just a 64k zone append limit or smaller
would be really horrible to use anyway.
