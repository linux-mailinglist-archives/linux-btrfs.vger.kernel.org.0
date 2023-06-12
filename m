Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0A72B80A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjFLG0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjFLG0q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 02:26:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8C172D
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zMGado4+AhMAzP70CPVXyP1uEO
        D2op2XSRAS2OJ7Ax/RaQwzUqUUl5Fi3h6AWKyQs6T/v9D4GqDboVCkDgrBuzYAVrml5C8vbl0nuk7
        VUrrg7YtgW006A9syH9lS+jB7aHNI64jAHfKr3lTekPrGAYk3GDcZbW7kwQxW9BEFnm8S5a1k44C9
        BBjjbbv4qb8T/yuR4ED9mKCxTKBCXwZQQk9M7E3O5QshFFkPyjmohnHPfaq3ZoqP71wXPa4yvNPvi
        C+diY9yykm3ew6nKkcwM0tgeILE65o61sY0EX1mZvvXyWP92fgRtpZ6rLXCB7IK1fTfjUFvCC2vnM
        Rf5jSbig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8atm-002kWM-2b;
        Mon, 12 Jun 2023 06:19:30 +0000
Date:   Sun, 11 Jun 2023 23:19:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove scrub_ctx::csum_list member
Message-ID: <ZIa48qQyK0wfAN4u@infradead.org>
References: <71bd17cb42d8caafe12b9fc009d97ba869d627b4.1686550463.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71bd17cb42d8caafe12b9fc009d97ba869d627b4.1686550463.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
