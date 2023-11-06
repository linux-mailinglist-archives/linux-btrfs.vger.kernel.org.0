Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE987E218E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjKFMbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 07:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjKFMbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 07:31:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48176AB;
        Mon,  6 Nov 2023 04:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5gv7Tk/V+i9O7re/VgIDi+SyhOAoqKetvsihXPjDjuM=; b=kIQyV9UPD9Z2gRNQ9DdLsMa516
        11JEIt871RSE5VapfffmDaIQE18UvpTZ4j/x2xZjRoqxSTvd1ZI1x++TCZcwnrNEpVfddGRyqPbht
        2lF7zIsOI1P69mLCV9sOHA30rjf5wz0m3/EWT9Pe1r55oMEwhAGOQgmR1kpdTWCk4BrfmixXikuW6
        qzkwgnCoyNgymGeuJLRQljvZMjgHdcnQLL/T9J1DN1RtlDfNfBfZ2q/yumGYnFbfa8+m2aj41UY61
        vaNRtQwKZJQD5Z6UAOugCrIBFtC9AFOo49P1CxiXBy+irmO9YUh/uWk8AwoUO4iQCfMdKIPGYo1P2
        Y613mviw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzykr-00Gddv-0x;
        Mon, 06 Nov 2023 12:30:57 +0000
Date:   Mon, 6 Nov 2023 04:30:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUjcgU9ItPg/foNB@infradead.org>
References: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-postfach-erhoffen-9a247559e10d@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 06, 2023 at 11:59:22AM +0100, Christian Brauner wrote:
> > > They
> > > all know that btrfs subvolumes are special. They will need to know that
> > > btrfs subvolumes are special in the future even if they were vfsmounts.
> > > They would likely end up with another kind of confusion because suddenly
> > > vfsmounts have device numbers that aren't associated with the superblock
> > > that vfsmount belongs to.
> > 
> > This looks like you are asking user space programs (especially legacy
> > ones) to do special handling for btrfs, which I don't believe is the
> > standard way.
> 
> I think spending time engaging this claim isn't worth it. This is just
> easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
> util-linux.

Myabe you need to get our of your little bubble.  There is plenty of
code outside the fast moving Linux Desktop and containers bubbles that
takes decades to adopt to new file systems, and then it'll take time
again to find bugs exposed by such odd behavior.
