Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F327C27C290
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgI2Kmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 06:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2Kmq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 06:42:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118FC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UON/LrKi+Pz49oCidnsBCO7lYWeCMuW1bjxi6OfvbTA=; b=ZushfLpD4zSZzuSuGvBN++dCHw
        W+07N6J0jLno0FVCj7KoPfZm/9UacCI0WCrPHmK3qZGWpGn8U/VsHlJJs0FzbD0Jjf9RIzWrms12p
        KaTLJQOAYJeoDh2Nccm4vKTcer29Z4vJ2kImwF6ofzZf+tj87qsDDytASUUCGJYyx2GcPSSw5NBef
        o6YiRwfFetzWjkwhsrAuFbQCJdcL6CEacQd+5VuIYoEUmobriebDe0VEfvtUnDNg3Pplgc95vLkKc
        R4NIhmhrSd8gRs83rk2n41Y5ApSmw7s0JagBTSamJ49P70XNLO4mElTEqgiSpS0ndRditv4E0BetT
        wTvw2lCA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kND5o-0003Vt-1J; Tue, 29 Sep 2020 10:42:44 +0000
Date:   Tue, 29 Sep 2020 11:42:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Marc Wittke <marc@wittke-web.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Recover from Extent Tree Corruption (maybe due to hardware
 failure)
Message-ID: <20200929104243.GA13215@infradead.org>
References: <5df695c82cd7f44da5e57d3a8c8549a01130d759.camel@wittke-web.de>
 <937038014748c11e7c951cef28e2f697570fbf22.camel@wittke-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937038014748c11e7c951cef28e2f697570fbf22.camel@wittke-web.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 07:39:27AM -0300, Marc Wittke wrote:
> On Mon, 2020-09-28 at 10:17 -0300, Marc Wittke wrote:
> > 
> > Disk type: intel 600p 2000GB nvme
> 
> Update: the disk seems to be fine. badblocks did two and a half passes over night without finding errors.

FYI, the Intel 600p is the most buggy common NVMe controller.
Older firmware versions are known to corrupt data when the OS commonly
writes multiple 512 byte buffers inside of a 4k boundary, something that
happens frequently with XFS.
