Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0651A1C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 16:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351216AbiEDOJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351239AbiEDOJT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 10:09:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83781EC5A
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=31gAglVFpAWrPU9V8pg12t6TRzr4QGS9umOrNH15HCE=; b=2D1Pm1c9ZL6DYR1Z1hM0obzoMj
        bwCBoLmT+wwT9Adei7zufC90yCT0gw+Kky6LEPHnN+2cYI4ik5Sm4jRgnCzfnIEzdYlGYhMyhGyBq
        ZCI0xdHi8PQALbLG3Js2LcVcthfts3njdBXdBP5/I30mS9Pn9DJZdD9CWOtzQke6A3SusJwPKJ6bc
        Taa6aECBeLJHWX/CvN0jRwEsQRMwjmpOuV8FZXOX9XYLRS54m1FFx1MWMtSq3/SDfTeF9CXlgSOBB
        2fODpV+W/1LqP7Ii8TLR3Wmh8ZDHmeVQkc9xIGlOVItA2aVsNj3TO9NR0FahOyaly32x3xpiewdkX
        lLNjmTsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmFdL-00BDN9-Eg; Wed, 04 May 2022 14:05:39 +0000
Date:   Wed, 4 May 2022 07:05:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <YnKIM/KBIJEqU/6b@infradead.org>
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
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

On Wed, May 04, 2022 at 09:12:50AM +0800, Qu Wenruo wrote:
> > This is a really bad idea.  Now every read needs to pay the quite
> > large price for corner case of a read repair.  As I mentioned last time
> > I think a mempool with a few entries that any read repair can dip into
> > is a much better choice here.
> 
> The problem is, can mempool provide a variable length entry?

It can't.  But you can allocate a few different bucket sizes as a
starter or do a multi-level setup where you don't have a bitmap that
operates on the entire bio.
