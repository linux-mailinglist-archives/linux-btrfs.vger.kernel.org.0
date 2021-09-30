Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDC41D2BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 07:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbhI3Fgd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348109AbhI3Fgd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 01:36:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38818C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 22:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OUxH/Pgh4K+xkldr1hsX43Vy+ustmag9uOCJUk2A5Kc=; b=eexENmGPTg2PKBV6fyj6djJnhO
        5RQ6K0kCWpo6FTRlOovKPaycEH8wLo0qLgLqLopOhMWZ8dvbB8orFfHqS2gxuQvJTLLcP5jPLt8Ul
        jp6Ew2xhvfvRTIxgXidHDl9Q33jKB0zs+4tjYvjsJhqmMdTEacxQqtX6+lE5CzDLNtCOPamoP0RsQ
        GanFdwwaqmdDvaioh4sFsCTVmftnwi6KzWtsPznEYN4wSd5tLK+pYwWNdkEDHNXm/NwfhtD4oSiji
        ryf4vsrRKNCzelD4WRoUzrhn9ipYheW05RjKexEqy7W9dEuPxGwAn7uLHlsysF/xnCj2DKIqlAUa9
        6tzc70kw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVohX-00CX4x-Vl; Thu, 30 Sep 2021 05:33:58 +0000
Date:   Thu, 30 Sep 2021 06:33:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Grub-devel@gnu.org,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: About the code style requirement
Message-ID: <YVVMOzTUMF/JTY/1@infradead.org>
References: <d7af6d9d-7178-f950-1934-3179e001e291@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7af6d9d-7178-f950-1934-3179e001e291@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 01:41:09PM +0800, Qu Wenruo wrote:
> Hi,
> 
> I'm recently considering to cross-port btrfs-progs/U-boot btrfs code to
> GRUB, so that we can have more unified code base, with more features (and
> of-course bug fixes)

The GPLv2 only kernel code is not going be much use for the GPLv3+ grub
code.
