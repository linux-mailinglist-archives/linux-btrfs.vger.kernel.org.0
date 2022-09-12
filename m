Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD705B5BEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiILOJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILOJY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 10:09:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8516F32DA6
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r98rNCppztxKp2Kauy1nzusdkvvPHj9tz0z5O6JL0X0=; b=ydYOSbwtYtrhhkh2ZLEO60a0Bs
        nXoI/WUOMJW5Mo2XkRlkvjesE3TYm0UqbvBN9BCL0hJIUtBi9KdN7dvqtxzo3E3Q9mmTXqNurFVaj
        UZEJVfKIZ87lnAuqJUZWxiYFThy7BXXvbY1nAj05MKumPmBNSCw5oSoMfJBH/JAMDho+sy8ZbtwTM
        HRTLXJRdng+NmUcE+MbtLsWnvxK6/VQrfsnRSCt0wuJYSTckbiMH3jSxglHrhwsbUWkk59W0zA898
        C2k3R4qci2Fn93mCGU0aV6Bn0Zsld5FKGY11Xwg2dYaRgsSVdwHZUZgX3zhIbBrdpvFjBPaq03i4P
        484xT4lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXk7n-00AVYQ-5R; Mon, 12 Sep 2022 14:09:23 +0000
Date:   Mon, 12 Sep 2022 07:09:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 02/36] btrfs: unexport internal failrec functions
Message-ID: <Yx89kw4j+p/Nu0Hd@infradead.org>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <baa7597615c94103ff8b597cc27d6282f505b3dd.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa7597615c94103ff8b597cc27d6282f505b3dd.1662760286.git.josef@toxicpanda.com>
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

On Fri, Sep 09, 2022 at 05:53:15PM -0400, Josef Bacik wrote:
> These are internally used functions and are not used outside of
> extent_io.c.

All the failrec stuff goes away in my series as well..
