Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5733369E5D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjBURVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 12:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjBURVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 12:21:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A62A15E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eL6oYTxlRc2LjFT5fUSD372Lwf
        hmOlEx4FngPthl5hKvNQoXnO2A/NhgYFA6ZsVJNeQ5of2GkzlEbo3bs82ufq/NcCXLx6H4R+AG1Er
        2PObg3Is8TWVSH5dIMZcGo2iL1qaEtVDW/ItBmvCy23m9CmotJppgriSojgM3PC09eYAT8K8BZP7y
        8ryyyjDaemGWdkpx/BIJQ43cFLE6amwc1b5ZLuHASLAqBEV6SVR4qqHyHG15qq5bz8dnTnuvFujSb
        JARe5/oBzFQNlAnBzbGSHmtji56v1+4+BdDw4O8EEZAa+3ebTmYwXlGdH0l+HXb0TG7ERjWnjjiNP
        drkUJBPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUWKn-00981R-66; Tue, 21 Feb 2023 17:21:45 +0000
Date:   Tue, 21 Feb 2023 09:21:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        hch@infradead.org
Subject: Re: [PATCH v2] btrfs: sink calc_bio_boundaries into its only caller
Message-ID: <Y/T9qUq4VF1QmW50@infradead.org>
References: <9c8a6815c5cfd36dbf2a45a80fea31c052bbb318.1676996243.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8a6815c5cfd36dbf2a45a80fea31c052bbb318.1676996243.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
