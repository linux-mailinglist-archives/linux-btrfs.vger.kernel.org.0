Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88D72F55D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbjFNHEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbjFNHEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 03:04:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB92684;
        Wed, 14 Jun 2023 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=yckbadJmiEAPUC27fCEyF+XdnQ
        b1vZzxuMJahz3bckjmnEW3w0Lx6XjjBsi+j3Iebc+V+n2LVbIoMysl/e3iAW+/bKpUIfw0DVCFrp6
        QaJBD5bk2AINEp6/aXZnt8mKdj8X87zMyvOQOa3OnBRLcYLI7pPzexYIsJ7rUMtKe0/x8IUhyGzkz
        2KoMpHrnV+BOfrfly6xNT3TIv0UAJtysd682eAKTHPJNNTSahzLa5SjNvSv728+3C2aFXBzYI+0Xt
        yDDYx3bVId9IR1FitbzHlGKBfnlt+yyCZt/Hh5ryFyoSFBYE34EkxQ4UtJpmUxEcO0t74mF3J0xer
        mgFjI5JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9KWy-00AZm1-1E;
        Wed, 14 Jun 2023 07:03:00 +0000
Date:   Wed, 14 Jun 2023 00:03:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     baomingtong001@208suo.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unneeded variable from unpin_extent_cache()
Message-ID: <ZIlmJPgPwhvmDP+N@infradead.org>
References: <20230614065736.22353-1-luojianhong@cdjrlc.com>
 <a1c89487cc2839474f232ab140a96e3b@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c89487cc2839474f232ab140a96e3b@208suo.com>
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
