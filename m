Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC29B4E4CC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 07:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiCWGfv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiCWGfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 02:35:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953A60079
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j/uR4Uo8pRLGHR/HmVERHyeqorUylWmGTw/egfQ1MO0=; b=WakMdak0w8SZGaysJhGDbljkz3
        I83suBc3wY7mUD4rpmhzvSUwdrJsrfLEPXMx3TCuq/6c+PCndh73cKEqsZmNXYdXjx4m+Tqc8xk7Y
        2M13eCeUXNv756qRaxXrkO9RsIUixt01FRCxkp0mzpC2gXC3ql1CzSZYvhitglEcfDvFTG9Qy2FF3
        0g7VNknh9H/6b0IQJ5kG+ckAcQWLelLx8NWUchFE6JixWcCUCe98Sh5DIIMAMQII1abNFbepWwX1I
        eFU+EVMbb7DodtLQDv7fSTKNPI5qaXCRlCxQKlTansijy4e1wko+heX0tup6r1brL8QSndiIK81Sh
        3voBXo8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWuZY-00Cqxd-EG; Wed, 23 Mar 2022 06:34:20 +0000
Date:   Tue, 22 Mar 2022 23:34:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: verify the endio function at layer boundary
Message-ID: <Yjq/bNLcB6uBU3I2@infradead.org>
References: <27688f5ed1d59b26255f285843c4573322acfa39.1647926689.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27688f5ed1d59b26255f285843c4573322acfa39.1647926689.git.wqu@suse.com>
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

So based on my staring at this area for a while I think the fundamental
probem is that btrfs passes a struct bio in a lot of places where it
should pass a btrfs_bio.

Basically all the layers that eventually call into btrfs_map_bio should
all be working on a btrfs_bio.  The fact that the btrfs_bio contains
a struct bio is an implementation detail that should be mostly invisible
to the consumers of the btrfs_bio API.  That also means the "high level"
end_io callbacks should take a btrfs_bio and we can just use good old
type safety for this sanity check.  I have started this work, but as
my bio cleanup series already got big enough I've not finished and
posted it.
