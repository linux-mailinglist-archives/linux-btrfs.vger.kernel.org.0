Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407D1710847
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjEYJGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjEYJGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 05:06:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6848A7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZjLhIPPu3r9FdGlwT87F0T0Gwif22eXgd5pFHA+g5c=; b=D9dFjmYX3J9IL9ytTMRgUV1Zxv
        hIjS/fLlAZvMBj5Tz9+IUf6DeBM+3cbUIlVg3qwnZ72Y956G8mnd3rivEUx2idgpAnzZfrMGG/JrC
        gdYJuTpHsVzw0BeAucL3IKIfRNZOh4OftxpZ1yF/zq2erslSXm3TfMnXM7AydMQGyIFCyaPSreeRz
        8wonAEKX8I4aIysf/r/wiV2bly+v/u/orJePaDg/pnGvG3hnNAZ4hFya/fHbs7ysCu6BLEqFh69IK
        A0V4cXAPu9Eh6uWvD2+bumFb+X6V6X0kADgsINFySzhvFjA6lxQv27OGenAbsZ7Nii/eJq5zb2GH/
        e/dGAMEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26v7-00G5dy-2C;
        Thu, 25 May 2023 09:06:05 +0000
Date:   Thu, 25 May 2023 02:06:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] btrfs: drop NOFAIL from set_extent_bit allocation
 masks
Message-ID: <ZG8k/ZMryufugSMN@infradead.org>
References: <cover.1684967923.git.dsterba@suse.com>
 <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
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

On Thu, May 25, 2023 at 01:04:34AM +0200, David Sterba wrote:
> The __GFP_NOFAIL passed to set_extent_bit first appeared in 2010
> (commit f0486c68e4bd9a ("Btrfs: Introduce contexts for metadata
> reservation")), without any explanation why it would be needed.
> 
> Meanwhile we've updated the semantics of set_extent_bit to handle failed
> allocations and do unlock, sleep and retry if needed.  The use of the
> NOFAIL flag is also an outlier, we never want any of the set/clear
> extent bit helpers to fail, they're used for many critical changes like
> extent locking, besides the extent state bit changes.

Given how many of the callers do not check the return value, and that
the trees store essential information, I think the right thing here
is to always use __GFP_NOFAIL unless GFP_NOWAIT is passed.  In practice
this won't make a difference as currently small slab allocations never
fail, but that's an undocumented assumption.
