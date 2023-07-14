Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6964753D81
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjGNOdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjGNOdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 10:33:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56653C11
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7YeyXOIvNqy+ijV9EYv88M9gZ7YB738oWZG/kZpE3Ls=; b=IpZNWolN3Umx6npsUhom+XMC4g
        9VjXF1Q1IQ98KeNpm8SmJFw0mjq12qsi8V+SKBTtQ73V/KXWD8QrXs1om3B6p6YDMT1qDLQ3G/vsY
        fY8NrqoRd3UogBU07Ca0j52Lq8Q+x6ghS0ag9HYZfQOhHWhLpruLYlYLFAcSHb8MkJN9FPm0g1Tjr
        3jM1tILD7aE1J9CPeh1BfrITo/o823dYmEnbjQjYq7yXnB8xBuP5NRQwPmlRVK6H/0Q0bz2ZzLxYj
        MXEtzkXYL0hAOqfwiigDdg4b0xkbpjPHJjQfVXSqP7pCvMxxUq8XRaer/DFKJ9pM7Yfql5kzGW/wB
        56qhwUMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qKJqI-006Oy8-1I;
        Fri, 14 Jul 2023 14:32:22 +0000
Date:   Fri, 14 Jul 2023 07:32:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix warning when putting transaction with
 qgroups enabled after abort
Message-ID: <ZLFcdvuhHag14G2k@infradead.org>
References: <b3c8ed953bbac475211b40c2f100e57168a56f45.1689336707.git.fdmanana@suse.com>
 <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I don't know enough of this code to review, but I can say that I saw
quite a lot of these warnings when testing zoned devices, and this
patch makes them go away.

