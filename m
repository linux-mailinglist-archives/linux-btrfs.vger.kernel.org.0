Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9B530330
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbiEVNAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEVNAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 09:00:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914315FD4;
        Sun, 22 May 2022 06:00:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 51BD568AFE; Sun, 22 May 2022 15:00:30 +0200 (CEST)
Date:   Sun, 22 May 2022 15:00:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: test repair with corrupted sectors
 interleaved over multiple mirrors
Message-ID: <20220522130029.GA25364@lst.de>
References: <20220520164743.4023665-1-hch@lst.de> <20220520164743.4023665-3-hch@lst.de> <791e365d-eb41-9073-80b7-40ee9a42d659@oracle.com> <c28607d6-34c5-5c9e-cb55-2a64273c477f@gmx.com> <1fc36e3f-8fa9-2bfb-ede1-d4f852bcb8cf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc36e3f-8fa9-2bfb-ede1-d4f852bcb8cf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 22, 2022 at 06:26:26PM +0530, Anand Jain wrote:
>  Agreed this method is unreliable. But there is no other choice.
>  Unless we integrated [1] patch in the ML.
>
>  [1] btrfs: introduce new read_policy device
>
>  [1] is more reliable. You can set which mirrored device to read.

I actually thought about something like this as the reliable way
to hit a mirror.  Besides testing I could also thing of some other
use cases for it where you want to avoid a mirror by default for some
reason (e.g. because it is network attached store while the other
one is local).
