Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E876AB2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjHAIgC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHAIgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 04:36:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9761B6
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 01:36:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B901768AFE; Tue,  1 Aug 2023 10:35:56 +0200 (CEST)
Date:   Tue, 1 Aug 2023 10:35:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-ID: <20230801083556.GA24287@lst.de>
References: <20230731152223.4EFB.409509F4@e16-tech.com> <20230801102253.1AF4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801102253.1AF4.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 10:22:58AM +0800, Wang Yugui wrote:
> 'git bisect' show that this patch is the root cause of performance
> regression.
> 
> e917ff56c8e7 :Christoph Hellwig: btrfs: determine synchronous writers from bio
> or writeback control

Odd.  What CPU are you using to test?  It seems like it doesn't set
BTRFS_FS_CSUM_IMPL_FAST as that is the only way to even hit a potential
difference.  Or are you using a non-standard checksum type?

