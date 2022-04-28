Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2002513597
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbiD1Nsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347620AbiD1Ns3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:48:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC71FCFD
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/mhsTAqdz+JXrc217F32fHAS4x3S11/hdGQa5mrbRl8=; b=SexRl+97PBKYqxTOdqj+Qwjd58
        Uv/gZkoU7UokbOmunF9T7m+PozccEBSXYaCK09mOJTrgU5NUt4yZa4Ut161qpxdaEllriyzMeWXmD
        BwO9AUiq0DAlAG+PoW35xzuylKzbQPuojDdXuEr2Cd6Fv3wIrStqfB4GXpyfrRDJAKnNROxrzMVZ/
        pET49I4tnf88dUoPWg5m28mqShscqts6qT2ae72juafyNugSi5rUzqoIr5j6IwmnIuN1xfA5FBske
        zqWm9PoV+Hq/UNmV3XJYIMLFN9Dlq/2WXYftuQ5RA+BlnItYBumxibSlj/kXVV4jr6J9Cpw1s232R
        ELTJf9uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk4SH-007APa-VT; Thu, 28 Apr 2022 13:45:13 +0000
Date:   Thu, 28 Apr 2022 06:45:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 10/12] btrfs: cleanup btrfs_repair_one_sector()
Message-ID: <YmqaacNkEcydCOr6@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <b3aaa77d32dbed374a6a3aa0375077333bb3fba7.1651043618.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3aaa77d32dbed374a6a3aa0375077333bb3fba7.1651043618.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The next two patches should really be merged with this one as all that
infrastructure is related.
