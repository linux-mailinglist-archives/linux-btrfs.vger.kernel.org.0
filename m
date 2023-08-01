Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E876B82A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHAO7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 10:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjHAO7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 10:59:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E38E4E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 07:59:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60B896732D; Tue,  1 Aug 2023 16:59:46 +0200 (CEST)
Date:   Tue, 1 Aug 2023 16:59:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-ID: <20230801145946.GA11625@lst.de>
References: <20230801173208.4F08.409509F4@e16-tech.com> <20230801100006.GA30042@lst.de> <20230801210400.F0DE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801210400.F0DE.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 09:04:05PM +0800, Wang Yugui wrote:
> good performance
> 	drop 'btrfs: submit IO synchronously for fast checksum implementations' too
> 	6.4.0 + patches until ' btrfs: use SECTOR_SHIFT to convert LBA to physical offset'
> 
> but I have tested 6.1.y with  a patch almost same as 
> 'btrfs: submit IO synchronously for fast checksum implementations'
> for over 20+ times, no performance regression found.

Can you try a git-revert of 140fb1f734736a on the latest tree (which
should work cleanly) for an additional data point?
