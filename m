Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49B59195F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 10:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiHMIJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 04:09:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E31222BA
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 01:09:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DA4F68AA6; Sat, 13 Aug 2022 10:09:13 +0200 (CEST)
Date:   Sat, 13 Aug 2022 10:09:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: don't merge pages into bio if their page
 offset is not continuous
Message-ID: <20220813080913.GA12088@lst.de>
References: <1d9b69af6ce0a79e54fbaafcc65ead8f71b54b60.1660377678.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9b69af6ce0a79e54fbaafcc65ead8f71b54b60.1660377678.git.wqu@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 13, 2022 at 04:06:53PM +0800, Qu Wenruo wrote:
> -	bool contig;
> +	bool contig = false;

Nit: the initialization isn't strictly needed in this new version.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
