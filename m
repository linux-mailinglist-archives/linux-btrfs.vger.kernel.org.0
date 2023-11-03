Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634107E04A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjKCOXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjKCOXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 10:23:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0376B1BC;
        Fri,  3 Nov 2023 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bAkQU5uTG56T8s4ikHNxWHhDwijbHjGis6JbtOJnAMo=; b=3JjsbooYVQO/bzrQouq9h8eu8D
        7/iNZB6XPj9jq6uDHFWwUVAHeRrIAtFZ7bPzrn6BdOCIj40abM91dlQX1ML5+rH2JxOQLH/G7d1q9
        t4ICWH59T9F6UJvUaIPvfzKuBNz6xDpCwao/4MYvcAuBdrWuvoM4LdvFUMWID/eMKJ1TlIHeEAPvS
        1opE5y3t+dZqjWTPPajLAJ+KNOa1qIeOOnuS1vLTpTWijCrDK+lbD9pjoZGsN0AXhsucModA3Eakj
        zReI17dfC6kukb3G/t+Hf6g0yYBl3lzpvL82NSBtiESLwWmdIB1rEcDqeS2QzU2m6gLj+htdX/5K7
        KcSYiUOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyv5H-00BZTK-0x;
        Fri, 03 Nov 2023 14:23:39 +0000
Date:   Fri, 3 Nov 2023 07:23:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUCa/JdOlD7x+/C@infradead.org>
References: <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
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

On Wed, Nov 01, 2023 at 07:11:53PM +1030, Qu Wenruo wrote:
> > mount -t btrfs /dev/sda /mnt
> > 
> > could be exploded into 1000 individual mounts. Which many users might not want.
> 
> Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfect
> timing here.
> 
> That would greatly reduce the initial vfsmount explode, but I'm not sure
> if it's possible to add vfsmount halfway.

Yes, that's what I had in mind as well.

