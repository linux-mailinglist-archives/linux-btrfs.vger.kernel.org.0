Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF47D8FD9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjJ0Haz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 03:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345560AbjJ0Haj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 03:30:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A75D6A;
        Fri, 27 Oct 2023 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J6bGrCB4/rnJbNUoK7rjk8D6SEpjbkD0IcJAoKAw/ZA=; b=GSuH2Vb2MK6W0WG7iGQteJWCD3
        wA5FnQ+hPzb9xB/i3sRiYGdwlJz85PjZZcRZr9e8mkdKGEESI/lsfyhRtbSwBmloCmkYBSVO//xBM
        ZDOJRalDpqdnt6fsS+yt4tCefCe2osONoEcHac7WGK5gQjzFSC75aiYhlWSMb+a4J1qH2osB+kqT+
        WVNYAL6C2GQwpH23PmR/W1A1IGudSBpWz9poA3nyTsQacoxvPZed397HR9miGAs2xQj0tZ2jsvOTq
        4Ed7M7OsKYf7G0qvjrZsIRK35qEX0z6VqRsySnGh40Uj9dSB1Nmd4m2/ZQ1QKubb3RUeHN/GAPBuS
        3IS9BywQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwHIb-00FnEy-2g;
        Fri, 27 Oct 2023 07:30:29 +0000
Date:   Fri, 27 Oct 2023 00:30:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTtnFe2W9vB04z46@infradead.org>
References: <20231026155224.129326-1-amir73il@gmail.com>
 <ZTtOz8mr1ENl0i9q@infradead.org>
 <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com>
 <ZTtTy0wITtw2W2vU@infradead.org>
 <CAOQ4uxigdYYCWopKjonxww-be9Rxv9H3_KfcMe3SktXAKoXq4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxigdYYCWopKjonxww-be9Rxv9H3_KfcMe3SktXAKoXq4g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 27, 2023 at 09:33:19AM +0300, Amir Goldstein wrote:
> OK. You are blaming me for attempting to sneak in a broken feature
> and I have blamed you for trying take my patches hostage to
> promote your agenda.

I'm not blaming you for anything.  But I absolutely reject spreading
this broken behavior to core.  That's why there is hard NAK on this
patchs. 

> 
> If that is the case, fanotify will need to continue reporting the fsid's
> exactly as the user observes them on the legacy btrfs filesystems.
> The v2 patches I posted are required to make that possible.

The point is tht you simply can't use fanotify on a btrfs file system
with the broken behavior.  That's what btrfs gets for doing this
broken behavior to start with.

