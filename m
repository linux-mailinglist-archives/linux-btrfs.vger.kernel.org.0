Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5255A6BAA2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 08:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCOH5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCOH5P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 03:57:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246A34025
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wEMrDl0QV+yKKfPsV0viUKnkdRPJC1X0o/HyCN2fajw=; b=OBsmUIX/kPW5B9+6fc53bMqvv/
        DqmGHlHWx2WEk3JRWoEFbV12xB4rj0K6Yr07TxGJMocHrTNv4vJCc9iP8uCieWMfIm+kMRJIvfc5I
        mzVNjj+juHgqb29GQO10xmUnrO63aAgKGtLR48/pUtseDRwLVqlBTZca0q/nUYjQBrNtGBupYE5LH
        BxiV+aZ0sWaOIADv5KTw1UM+5TcECnQBrbzpW6xGjXC4hYeI6CFyxPQZquSX3GqD34Cumwgiyfb/r
        BO5rAcjiRupKM8O9cB18fJOynSzZI/OUE7m/t7PdxXQZMFpHQvZ85FuxDlLxj5+ausWr/g++kXzlB
        4esnIqFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcM0W-00CiBD-33;
        Wed, 15 Mar 2023 07:57:12 +0000
Date:   Wed, 15 Mar 2023 00:57:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Phillip Susi <phill@thesusis.net>, 4censord <mail@4censord.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: Corruption with hibernation and other file system access.
Message-ID: <ZBF6WKjRV5J8ZR52@infradead.org>
References: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
 <87mt4f9qrn.fsf@vps.thesusis.net>
 <ZBCzZH7Lq2K1jS/M@infradead.org>
 <22489ca9-37e0-f4a3-d7ec-b61357e8b535@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22489ca9-37e0-f4a3-d7ec-b61357e8b535@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 15, 2023 at 07:32:57AM +0300, Andrei Borzenkov wrote:
> > I'm not a hibernation user because it's generally been rather
> > flakey, but last time I checked hibernation was doing a file system
> > freeze, which implies the file system should always be consistent.
> 
> The problem is not on-disk inconsistency, but inconsistency between cached
> in-memory metadata and modified on-disk metadata.

That can only happen when resuming from a hibernation image after
another kernel has run in the meantime, and I think file system
corruption is the least of your problems in that case, which is
why the hibernation code is supposed to prevent that whenever it can.
