Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5573F452
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 08:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjF0GO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 02:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjF0GOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 02:14:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4941FD9
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tj9FMOVsrRZPlMKKjXYQACXW9TaZ59FN2t3ftkcZMCw=; b=RPVN4dXwBRWeKp6g9VS5qvwdoe
        ZUMNhK12OTI66OpEsabuksaoUT1d/wpRGpxZHsjfmHbNP57I3H5eGahlmjaXpukNxH595wsRNNdqV
        TP/+hhFEYlcb2d+UaxDXuS6Ufns5vNuZm+BU5tfc4kThL3gvk/p4kpnplk/Cz8r0WOJR1Qz3qAGCw
        zrsJEEJJ5UmsRDAeMfciZ+IDCy2Ky/vqvwr9B1PAqq01nOROK6yLGHDHWA5kSwMPqsYZOk90pBq9b
        XOcwHakCautZpdwG9W6O2MdEqYzH9TYaoERuO3tGJnAQ187DwwiU8puKGAIRJm3yHAXtth2S0RH0a
        r99mwaaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE1yY-00C5db-2j;
        Tue, 27 Jun 2023 06:14:54 +0000
Date:   Mon, 26 Jun 2023 23:14:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: deprecate check_int* feature
Message-ID: <ZJp+XrDdmOrc++oS@infradead.org>
References: <d1b4174922a786884a1a3bfdcbbc208925797f4b.1687773318.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b4174922a786884a1a3bfdcbbc208925797f4b.1687773318.git.wqu@suse.com>
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

The subject reads odd, why not spell out check_integrity?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
