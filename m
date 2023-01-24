Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B86792D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 09:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAXIQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 03:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXIQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 03:16:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B71BE4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 00:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kvEKR0O2Y0QJMkCP8vweX08WtDotjFrYle8//1iKEsM=; b=kx8Htw+IjToNfAT5DV+0j1t1Vf
        FREgGnD8Wp6KDe8etqtN5ZzuYDbj99TJiUxb8f3Ym0TRPTBNLwro/Dl4KpgK16N2LgXMadREmjD0k
        qPsP4pds+9j52QdovsYbzG75jfChOdZRSw+ba17wxjG3zDTFDwJ47RHf4vWFq/eQzMrJzVX2FZvmG
        kIN5WAkypv49aPYLTWbvnklJvn5FOlo70vFRQjS3kT+2fhmhRTchTwYyGgochNsgnvnY5HF4tPt8h
        ZwLsFIayELSI4G2oFGvyJC5O792RsCl5/+8wU7iE7uSBcDMIdU+JkIa181Xv/vYdOxJnBzGqWIVaD
        wE1cEgjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKETs-002iGI-DB; Tue, 24 Jan 2023 08:16:36 +0000
Date:   Tue, 24 Jan 2023 00:16:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: separate single stripe optimization into a
 dedicate branch
Message-ID: <Y8+T5PIURkONMvTD@infradead.org>
References: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 24, 2023 at 04:00:24PM +0800, Qu Wenruo wrote:
> This patch would looks awful by itself, as it's causing a lot of new
> lines.

Yeah.

> 
> But firstly, a lot of the new lines are just comments.
> 
> Secondly I hope my RAID56/non-RAID56 split can later be used to
> refactor the slow path.

I'm not sure what exact refactor you are planning.  Right now this
duplicates a lot of code and makes the function harder to read.

So while I agree that __btrfs_map_block could use some splitting,
this patch as-is seems counter productive.  It might make more
sense to look into reusable building blocks and split them into
helpers rather than duplicating code to start out.
