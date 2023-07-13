Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98246751FDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGML1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGML1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 07:27:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186DB127
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aaezeooconEYeLeR00mZF+dVxxFVo6GvvN2cSdK1oJA=; b=uOYNvwT4Nr9XwEQW4vux+w3pPz
        Hv1Zsre149PTTPlGmA2+USLWAyOZ6KogLpO6L0GoE6EAkEB2fIhRHY/y0ifzT0DZDcSkrchJP6vPc
        BMrJ7Dly4TSMvzVXX+jNP6HYtf4r2ggeKNtlQNxPtjJ36JK3oTi/WX7r/Gsj8i1dP50/JGBa49g/F
        PDkGSVaiPNRFrN5OUdiOUfDQFwp7lgL/SCT4yo2ZzEkVFEvubC1JWH1Z4XNJEtGTys0emqlwm+ZCb
        oUVOEC8URyMCYkVWP82bmvKQPcKew6hq07ZjHeKZG1wRqA1NaDHtqEqsBCWle8U9ZsyAAYNqMMVmq
        NQ5Xn6Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJuTQ-0034xF-31;
        Thu, 13 Jul 2023 11:27:04 +0000
Date:   Thu, 13 Jul 2023 04:27:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set_page_extent_mapped after read_folio in
 btrfs_cont_expand
Message-ID: <ZK/fiBCblahhm3l2@infradead.org>
References: <f6704eb17e95f3f23a49ec7e4807f4fa45192965.1689180044.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6704eb17e95f3f23a49ec7e4807f4fa45192965.1689180044.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This feels a bit ugly, but I can't really think of a much better way
to do this, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Interestingly I've just started doing sub-page testing recently and
have not hit it yet.

