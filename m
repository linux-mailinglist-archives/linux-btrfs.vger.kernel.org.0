Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3387871870B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEaQI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEaQI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 12:08:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A5132
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wpq5i4ufHJpGlLBeeeAQ4+Ph3B
        b24UFDjD3DMEQmgYFvVtwaKIBmuuo+soOvgdkQx0jnAD2WCcLwK+oY0ppX+fSc9l28NRhOfzzzXeh
        ZZr0VLVqxA5AgZtN7nT3j0El5fDckGJlamYa8X7kb3+2bBPl0vV8YwFo1p2cQdjc/8IaTtO8tPGOL
        N1oJ5TZs6mZGRcMWdzPRNUGWFWlA97BhSepk4xI477xZqx1xo8NOCJaREsipe2FvGuBwGlfPSOggv
        tgv6nERk3AqxAJxbvmY9OTarg0TfuwgcDGL9uMXvchFrU51I8aYevlmum1Jf3O8WruSXfZB3fxKHD
        Y4Plg1TA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ONa-000PvD-11;
        Wed, 31 May 2023 16:08:54 +0000
Date:   Wed, 31 May 2023 09:08:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add xxhash to fast checksum implementations
Message-ID: <ZHdxFg4re+qKbbfy@infradead.org>
References: <20230526210201.12661-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526210201.12661-1-dsterba@suse.com>
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
