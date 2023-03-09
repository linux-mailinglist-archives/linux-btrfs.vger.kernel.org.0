Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477EA6B289C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCIPVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCIPVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:21:46 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D93E6834
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:21:45 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B801268AA6; Thu,  9 Mar 2023 16:21:42 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:21:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/20] btrfs: always read the entire extent_buffer
Message-ID: <20230309152142.GD17952@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-5-hch@lst.de> <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 11:29:54AM +0000, Johannes Thumshirn wrote:
> Can someone smarter than me explain why we need to iterate eb->pages four
> times in this function? This doesn't look super efficient to me.

We don't, and only a single iteration is left by the end of the series :)
