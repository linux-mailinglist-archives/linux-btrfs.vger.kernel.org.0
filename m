Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7274AFEE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGGLgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGLgo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 07:36:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E939E
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OV9ZZmDXBFBEhwgG2HOyjlYwTa
        jhetOhuiY0I5gI7Qp4ulkNViM0rEsexNO0UD7qh2/+dd1roaLxiUk/36eFVqFYUAuH8iEcMYCZWLl
        /rKnsc6UkydWPix9aZ+oeY6GKnTU/HDlBUdSalCWx9E4n/8o/k1DB04TehtH/BjCmqL+Da345CANB
        zqth8s9FJN4ZtPXyKeFvQiynNGovH18TC6CsSfu46kBcDTyXk+R20ZqU+RM2riYXdBBI3ioQ7Pr4z
        S4HfDOzEayOWuVgpTb3KWQoqi4IeJriVWVVlok7SSSsHhR2HI3PQ4KnZuFrY4KJs+uqi3/8ItxNnI
        DgCvcUeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjlT-004Wpp-0h;
        Fri, 07 Jul 2023 11:36:43 +0000
Date:   Fri, 7 Jul 2023 04:36:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs-progs: print out the correct minimum size
 for zoned file systems
Message-ID: <ZKf4ywhFlil7xtlf@infradead.org>
References: <cover.1688658745.git.josef@toxicpanda.com>
 <d4a3973e50ab59cc063327252121edd1260024a8.1688658745.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a3973e50ab59cc063327252121edd1260024a8.1688658745.git.josef@toxicpanda.com>
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
