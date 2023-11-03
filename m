Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5177E049C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 15:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjKCOXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjKCOXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 10:23:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4A1B9;
        Fri,  3 Nov 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZJ7LPQ3GnvRgDrJKFJUcbvTnIjY96mQSJDKJHx0Emk=; b=caZxQdt0+HWGkRhgC5bEyTIorI
        woNm8ezr7fTQAzNgHiQxUdDSkean9Jv5aaTOshgznslGH34+t1uhrAjq5xvVh+BCFJFQlkq7RymI+
        bZpnGUTCsrD4Z/j6ioEcX6aOJHyO+vRg2CETMkrBpxqVIR5IHET2vsawZChOsrLW+fYDbe+WfefQF
        nf6cwD8P08YOlSoFKFUK6FWr6840VNATn2aagSoFy+9CI1zJPrLDYEO44upGVP3nQdw7ujQKI0hNH
        55k/mLd69YgE8NcukXzhYVs2HOay1B+i/rzvohKJ1K2e10WQZeaWR7wgmBVwpPbumf+rMIFBnS06L
        Vn3WsQww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyv4a-00BZNw-25;
        Fri, 03 Nov 2023 14:22:56 +0000
Date:   Fri, 3 Nov 2023 07:22:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUCQA7kIioHBv7d@infradead.org>
References: <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
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

On Wed, Nov 01, 2023 at 09:16:50AM +0100, Christian Brauner wrote:
> mkfs.btrfs -f /dev/sda
> mount -t btrfs /dev/sda /mnt
> btrfs subvolume create /mnt/subvol1
> btrfs subvolume create /mnt/subvol2
> 
> Then all subvolumes are always visible under /mnt.
> IOW, you can't hide them other than by overmounting or destroying them.

Yes.

> If we make subvolumes vfsmounts then we very likely alter this behavior
> and I see two obvious options:
> 
> (1) They are fake vfsmounts that can't be unmounted:
> 
>     umount /mnt/subvol1 # returns -EINVAL
> 
>     This retains the invariant that every subvolume is always visible
>     from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}

Why would we have to prevent them to be automounted?  I'd expect
automount-like behavior where they are automatially mounted and then
expired or manuall unmounted.

> But if we do e.g., (2) then this surely needs to be a Kconfig and/or a
> mount option to avoid breaking userspace (And I'm pretty sure that btrfs
> will end up supporting both modes almost indefinitely.).

It would definitively need to be an opt-in for existing systems.

