Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365C7E1B84
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 08:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFHxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 02:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKFHxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 02:53:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5BB3;
        Sun,  5 Nov 2023 23:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YM4MsMFJ6bT2wXXzMvFgAHevmPY5/9JeSlZIQ1ihbtQ=; b=IBLSX7QpsVTrHC8uvWK0DYgMkE
        38J9DF/2kzWoMnWODTD1xmu2x8ko2Bb4sjDpqRJfiABsv5iePauVAY8Qr7TyFRdBx7NjmIA6yehqc
        1jrTRWshDsfECCHHMkVwTzfxPHTJ6dGCAiHeb4KfIHBpCQJfERxB5uRvHOWWXiVFeGa2/hZ0q0pxl
        t8ToArDRbI99QIUZkyNw4yZzxOxqaF9kex1tIWFakQk/4maJowz+5dUer6bOM/J6UM1sVCLN5mNU4
        mxTqaMJh1eaAFQ/kLSPOsZK+7V5qHRlmAEVyN+i1Ku/1Gaqn5OO35C5HMk2ppzPImgVqetij6kafn
        m3TJWt1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzuQ2-00G27L-2Q;
        Mon, 06 Nov 2023 07:53:10 +0000
Date:   Sun, 5 Nov 2023 23:53:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUibZgoQa9eNRsk4@infradead.org>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 04:47:02PM +0100, Christian Brauner wrote:
> I think the idea of using vfsmounts for this makes some sense if the
> goal is to retroactively justify and accommodate the idea that a
> subvolume is to be treated as equivalent to a separate device.

st_dev has only been very historically about treating something as
a device.  For userspae the most important part is that it designates
a separate domain for inode numbers.  And that's something that's simply
broken in btrfs.

> I question that premise though. I think marking them with separate
> device numbers is bringing us nothing but pain at this point and this
> solution is basically bending the vfs to make that work somehow.

Well, the only other theoretical option would be to use a simple
inode number space across subvolumes in btrfs, but I don't really
see how that could be retrofitted in any sensible way.

> I would feel much more comfortable if the two filesystems that expose
> these objects give us something like STATX_SUBVOLUME that userspace can
> raise in the request mask of statx().

Except that this doesn't fix any existing code.

> If userspace requests STATX_SUBVOLUME in the request mask, the two
> filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> return the _real_ device number of the superblock and stop exposing that
> made up device number.

What is a "real" device number?
