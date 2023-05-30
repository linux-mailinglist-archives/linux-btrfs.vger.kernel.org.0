Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65FB715527
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 07:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjE3Frb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 01:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjE3Fra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 01:47:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCEEC
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vj3P4dh9WYoURI5rGEPJ8G9gG4iFtJpTelQk67+lDWI=; b=c83pko6YfiFpgLUhB/s9eA10Aq
        1G2V1aTpuNQ5Owjnjbrpqca2l/HUFer73qVW+nawtcb0tTKFzHXhAD1iaEE3MWOJzU3uT/f0IWnNz
        4pu+cl2cNMLU/eOp1W9oiubICnryW5OFw2Y2mNLnxacMtJSRLZUKtIXAE2m9fY3Su6vrbY7KJv9g7
        HrIuSFSh2OgSXcjw10mktfT3SDUo5IXgKYpx+hI4ahDGYPK/rnRbLBy7BHz1iw1CqdcImgYiaw4bb
        /bTPT+TPdxV7f67e6Ixa/ypBPGiQtBZl2akIvVo3z+7tEyvVsuNR4xPs1Qk5SEKW/vhoavcSnSG6y
        /jZNX93g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q3sCc-00CVMI-08;
        Tue, 30 May 2023 05:47:26 +0000
Date:   Mon, 29 May 2023 22:47:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linux-btrfs@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        riteshh@linux.ibm.com
Subject: Re: WARNING at fs/btrfs/disk-io.c:275 during xfstests run(4k block)
Message-ID: <ZHWN7lD6QPIoNa6C@infradead.org>
References: <50217126-0798-4ED7-BF46-4DF14C99ED0D@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50217126-0798-4ED7-BF46-4DF14C99ED0D@linux.ibm.com>
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

This should be fixed by

"btrfs: fix the uptodate assert in btree_csum_one_bio"

on the list.
