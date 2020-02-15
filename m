Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BD15FC9F
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 06:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgBOFPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Feb 2020 00:15:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgBOFPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Feb 2020 00:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lf5pEsLkDMHfAnIJnWJNxE9knTjSXnGbMKa+RFoMfjY=; b=LwE4I7V7QvVg4koNTaLDl6Ql9c
        YiBbBCgoTgmMvds2JkPe7s3Qd7qEXqNaI3P0pnWsJFQ6cntswzX0HhKd/TKDSHoZ6nul08INXP1Xa
        UhGxoNT9HfaE9Ggn5CujsBKNG0CPWOcKE61RsRTfWJ5BYT4LdxLn1BfFUjRLy0G4FUZyb97iDtSHi
        X2XzLIop1BVPPPwcyjIPCNMnlz0AAPujy3B0tEwgYx6+O+rrKzMXZc8dm2TNbREdy13+jQJNvTYQt
        zE6dXZXLaJrKiJcOA6tFpwNSt5cR0JxCIQtNpkmuulHbybhSU2MVIJAe6+RyRYgaejg7qhGc4rw8V
        ruD4O7oQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2po2-0004FX-To
        for linux-btrfs@vger.kernel.org; Sat, 15 Feb 2020 05:15:54 +0000
Date:   Fri, 14 Feb 2020 21:15:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-btrfs@vger.kernel.org
Subject: Missing unread page handling in readpages
Message-ID: <20200215051554.GF7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


As part of my rewrite of the readahead code, I think I spotted a hole
in btrfs' handling of errors in the current readpages code.

btrfs_readpages() calls extent_readpages() calls (a number of things)
then finishes up by calling submit_one_bio().  If submit_one_bio()
returns an error, I believe btrfs never unlocks the pages which were in
that bio.  Certainly the VFS does not; the filesystem is presumed to
unlock those pages when IO finishes.  But AFAICT, returning an error
there means btrfs will never start IO on those pages submit_one_bio()
is a btrfs function.  It calls tree->ops->submit_bio_hook() so that's
either btree_submit_bio_hook() or btrfs_submit_bio_hook(), which certainly
seem like they might be able to return errors.

So do we need to do something to complete the bio with an error in
order to unlock those pages?  Or have I failed to notice that already
happening somewhere?

