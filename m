Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE269E256
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjBUOcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjBUOb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:31:59 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2C28D0B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:31:58 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2879868AFE; Tue, 21 Feb 2023 15:31:56 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:31:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/12] btrfs: add a wbc pointer to struct btrfs_bio_ctrl
Message-ID: <20230221143155.GC29949@lst.de>
References: <20230216163437.2370948-1-hch@lst.de> <20230216163437.2370948-6-hch@lst.de> <737667ca-cd16-756d-dab4-fff77f1acf23@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737667ca-cd16-756d-dab4-fff77f1acf23@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 07:18:57PM +0800, Qu Wenruo wrote:
>
>
> On 2023/2/17 00:34, Christoph Hellwig wrote:
>> Instead of passing down the wbc pointer the deep callchain, just
>> add it to the btrfs_bio_ctrl structure.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> I'd prefer to get this folded into the previous patch.

Why?  It has nothing to do with the previous change except for
touching some of the same code areas.
