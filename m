Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E747E2151
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjKFMZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 07:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjKFMZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 07:25:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443CA4;
        Mon,  6 Nov 2023 04:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L5cl+RDGvEZz/eLwTMy1ZuCPzEPX60KHCPNo+ErIHy4=; b=puA6n0PgFkK0VPgWd7sgpG2sKf
        OmzKe1XT0YAyimc52KRiAoNH3O7Fhq11tS78bssrVpQO0kvL6mwWtq/FRod5W7JUC08ERJOBDokh+
        MGzUkO+0pGktqi7q27y5BrHpvOu9tR6YqvXhowUaDtSyN2QKyY2LKR6R/L7bVW4o+sn7pfzf2c11+
        3n4D480mji01XbaZ0xulBr9wfUPqoIPCZEWPY5yBnYWeAbOhX3LrtloYWcbZsWaPi/ZoIaNmmbcdv
        /UqFj568ILBgUbruYDaQs+rjPuAB3sqX5rtvGqU5Wrc/mkdXnCLsXrN0Zc3xYxYJuArzoeFfAYDP6
        OfTe6/lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzyfc-00GdBF-0X;
        Mon, 06 Nov 2023 12:25:32 +0000
Date:   Mon, 6 Nov 2023 04:25:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUjbPK0oizILoUDl@infradead.org>
References: <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
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

On Mon, Nov 06, 2023 at 06:48:11PM +1030, Qu Wenruo wrote:
> > st_dev has only been very historically about treating something as
> > a device.  For userspae the most important part is that it designates
> > a separate domain for inode numbers.  And that's something that's simply
> > broken in btrfs.
> 
> In fact, I'm not sure if the "treating something as a device" thing is even
> correct long before btrfs.

It never really has been.  There's just two APIs that ever did this,
ustat and the old quotactl.  Both have been deprecated a long time ago
and never hid wide use.

> For example, for an EXT4 fs with external log device. Thankfully it's still
> more or less obvious we would use the device number of the main fs, not the
> log device, but we already had such examples.

More relevant (as the log device never has persistent data) is the XFS
realtime device.

