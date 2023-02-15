Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDB697682
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 07:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBOGj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 01:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBOGj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 01:39:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5165B7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 22:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=20r4cNrFDI+1phbrJdwqAtxgJTErgj3drkO2WOdNMaM=; b=Z2ygtU1+vIYrAyD6z6/gP/D3se
        lreKR6LN3IKO/VFJ+/JGTzjESYy49Vxm2ZY0d17t9PRp+ZNKUhNbrfCUGdkDvVygQ3c9m82/5+chZ
        aKoPDwUUXsaWrDnZOfIgGWPN8bbcCUwVNW2+4KvkWYWyXLdJ8F+ASIrma5C/6as20sgWouwDy/O2j
        8spGSIXPuxewFutx2/ijrJntE3tZGKuz5VlWRBUbrf3dkouCjQf9VpuJo9DyAr7KNZiU5vxEMs6bo
        Ft0EVV+4pBegBy4XGESuWPn7iflSPpUwxzqTYgtlsRtdbES9hDJssOokVa4GcBPz3WRFSA9lJUFNe
        EkKr0tzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSBRq-004wS1-58; Wed, 15 Feb 2023 06:39:22 +0000
Date:   Tue, 14 Feb 2023 22:39:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Stefan Behrens <sbehrens@giantdisaster.de>
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Message-ID: <Y+x+GjgREMyYe5pP@infradead.org>
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 14, 2023 at 03:18:11PM +0800, Qu Wenruo wrote:
> > from which I father that the idea is that when a drive is replaced
> > due to a high number of read errors, it might be a better idea to
> > redirect it to the target device.
> 
> To me, avoiding reading from source != read from target.

Well, it's not identical, but it does severly reduce the redundancy.

But maybe Stefan will find some time to chime in.
