Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5738A710834
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbjEYJAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbjEYJAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 05:00:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C798
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Mf0ZBjhU+vrn+SwgDl7o9xe8T+
        98liaGC6TjTQzYluKIiBbe5rohs1PRghuE0XOKtG7NFAC/MtwEAtBUXrNwaZ9y/4DvfiyQk59hzOq
        kHReFEnZFTJiS4wwnfyWE62BtZ1kIea1KXOvnxnvWxmrtBKHRyw9etNwqH3qQOYawQjNz+ZuXuYoj
        xMvMJHjqxX67cpHVdp0yC4u7E+sGZgBlThn2d/vNcwFAl56YRW4rt16eeG4qEnCwSKtpwyDTzew2+
        NqBC0CxoPwv4PKrACGU7USqzMix3w11Wfp6uN++4Ew38nuaHoIC3Mto5SkSu6LQelqmO3refsHZ2k
        OY7+W0Aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26pL-00G4pU-0s;
        Thu, 25 May 2023 09:00:07 +0000
Date:   Thu, 25 May 2023 02:00:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: open code set_extent_dirty
Message-ID: <ZG8jlzvax6v//NrI@infradead.org>
References: <cover.1684967923.git.dsterba@suse.com>
 <2d4be0b36bb199c70308f945320def249512b0d9.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4be0b36bb199c70308f945320def249512b0d9.1684967923.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
