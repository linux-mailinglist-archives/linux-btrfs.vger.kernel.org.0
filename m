Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEE75FA66
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGXPE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGXPEz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 11:04:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D312E
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iF3s8R5e5rCioeNL+vkncD6PSWYoV5fWqubi8zjgziE=; b=c6SqYHSmGP8HlHd00cc0he6Gsv
        aobzwMsquPPmYBos4hrGEzFyrZwWoLADrGcIX/bGGwhejJ1Q5nPN5iWtdyTOWF69puCyEy5Isulr+
        tw98bl4NEB3Sxe4u5oaqvO9SAzALih1c3kcz/Z7ezMR4dF+XDLygw5HhmgxM9tjvMaILCbvkKmfyi
        JhHvo15Hdr1QD6N15vQ4eIJWNirgiBY2puxXUS2uEuWYAsz8dEt+bY0RbYmP/DK3Xhss4R8lbEFWY
        liYysAKDYI1qequCzMJf3hbW/Tod0tGEilKilQ0cRgBzJ8r6oJ/Lei6qN84EBJ/tCC8kvdc4jJNTN
        RTeR6Uvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNx7G-004gB7-0z;
        Mon, 24 Jul 2023 15:04:54 +0000
Date:   Mon, 24 Jul 2023 08:04:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/8] btrfs: zoned: update meta_write_pointer on zone
 finish
Message-ID: <ZL6TFrca5TfyVYCO@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <61507f174fbd62e792667bec3defed99633605bd.1690171333.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61507f174fbd62e792667bec3defed99633605bd.1690171333.git.naohiro.aota@wdc.com>
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

On Mon, Jul 24, 2023 at 01:18:32PM +0900, Naohiro Aota wrote:
> On finishing a zone, the meta_write_pointer should be set of the end of the
> zone to reflect the actual write pointer position.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Does this need a Fixes a tag?
