Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2EF421552
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhJDRrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:47:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52324 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJDRrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:47:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 408BB222E6;
        Mon,  4 Oct 2021 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633369549;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpNwOA7Xi6Vq442VExGNVB0rdOBsvU18euGtuUSRmV8=;
        b=V4V9zw3QZWH41ci9IR1ykC19Eg31tRYTGJsqkpFZNwWgA3PPaUUngivbZ0s/tW1OIoIerR
        IVShX+xgMiUHeR8RRLUw2zgMv1o4f/elUmVtoTKHWAuT2NXSEuvQILe8e3g+/NsQ4WmVnZ
        JCeVTSE2G1mf3oee7x43roFUg99lHsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633369549;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpNwOA7Xi6Vq442VExGNVB0rdOBsvU18euGtuUSRmV8=;
        b=86OVUUGl8mWT+FqDQOPX6iz4o5rONyDv7PjQhEBorEOmGuXTER+9pHZmUNmkeAGrp8GL4G
        MeVqDC+1NjuZBRCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3D4F4A3B87;
        Mon,  4 Oct 2021 17:45:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02C6FDA7F3; Mon,  4 Oct 2021 19:45:29 +0200 (CEST)
Date:   Mon, 4 Oct 2021 19:45:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 05/26] btrfs: make add_ra_bio_pages() to be subpage
 compatible
Message-ID: <20211004174529.GB9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927072208.21634-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:21:47PM +0800, Qu Wenruo wrote:
>  fs/btrfs/compression.c | 89 +++++++++++++++++++++++++++---------------
>  fs/btrfs/extent_io.c   |  1 +

  CC [M]  fs/btrfs/tests/extent-map-tests.o
fs/btrfs/compression.c: In function ‘add_ra_bio_pages’:
fs/btrfs/compression.c:680:25: error: implicit declaration of function ‘btrfs_subpage_start_reader’ [-Werror=implicit-function-declaration]
  680 |                         btrfs_subpage_start_reader(fs_info, page, cur, add_size);
      | 

Fails when compiled with that patch on top.

Missing #include "subpage.h"
