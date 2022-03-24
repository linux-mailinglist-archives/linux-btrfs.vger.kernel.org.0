Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4894E6761
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiCXQ7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiCXQ7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:59:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B07420F
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:57:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2211A68B05; Thu, 24 Mar 2022 17:57:30 +0100 (CET)
Date:   Thu, 24 Mar 2022 17:57:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: fixes for handling of split direct I/O bios
Message-ID: <20220324165729.GA27778@lst.de>
References: <20220324160628.1572613-1-hch@lst.de> <46203a49-0fde-aa5c-e92e-da0f1dd48885@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46203a49-0fde-aa5c-e92e-da0f1dd48885@dorminy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 12:49:26PM -0400, Sweet Tea Dorminy wrote:
> I'm pretty new and don't know much about the criteria for cc'ing stable, 
> but arguably this makes the check_data_csum() error message not lie about 
> the start offset in such cases and it seems like a very low risk 
> improvement to me... might it be worth adding a Fixes: tag / might this be 
> a reasonable fix for stable?

The error message is the least of the problems - if there is an I/O
error or checksum mismatch this bug will make the repair not work.
