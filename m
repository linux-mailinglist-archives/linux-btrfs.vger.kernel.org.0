Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6A5511E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiFTHwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 03:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbiFTHwU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 03:52:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4EDEEF
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 00:52:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FAFC68AA6; Mon, 20 Jun 2022 09:52:16 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:52:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.com
Cc:     Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't limit direct reads to a single sector
Message-ID: <20220620075216.GA12443@lst.de>
References: <20220616080224.953968-1-hch@lst.de> <a2dd54d7-ea9e-8647-261c-7d622f536f53@suse.com> <20220617155812.GB31552@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617155812.GB31552@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David, I saw this patch is already in misc-next.  Do you want me to
send an incremental patch or a new revision with the limit?  Incremental
would look kinda silly, so I'd prefer the updated version.
