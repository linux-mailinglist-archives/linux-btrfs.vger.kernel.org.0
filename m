Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C670091D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjELNWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbjELNWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 09:22:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055913869;
        Fri, 12 May 2023 06:22:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE78D68B05; Fri, 12 May 2023 15:22:39 +0200 (CEST)
Date:   Fri, 12 May 2023 15:22:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: delete a stray tab in
 can_finish_ordered_extent()
Message-ID: <20230512132238.GA30665@lst.de>
References: <a145fa32-2095-455f-a9a1-d06d9e785e55@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a145fa32-2095-455f-a9a1-d06d9e785e55@kili.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
