Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5F71083B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjEYJDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjEYJDX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 05:03:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D39A7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3slPtsRlYChU97yH1vJEvytUJPZhMX/+LCLWmlpSl0Y=; b=f6DautMoY5ytywe31OJbaJePIV
        UxXrTnPAdGTWuLhaaPkpN+obHMGaaSxXZucbHpsLbIhxdw3XGPqxh76rl8yRfDcdNgas6BVjX/+FV
        9DumJhIJj/4loB/EZOnoPPF7iWNYhM1DuwJlpt738xK13SLyK172DQbgVhHcNeYEnGE3aZGNB0s/E
        IkB1OMpMpYd32gkkFFyaMW9Xu9sA9E4dUBBNOp1IWM59FhtBjID4Xedso0GeFkkuv+CaBFRicCVdi
        Y+YengPiaFt1zTYsjI/tfwZWKH2T0FBaqE7qbctVb3h4b7iThor0fvAlRzTAb5+hfFcntbJfK7Mmf
        gy2AROvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26sV-00G5Ez-0L;
        Thu, 25 May 2023 09:03:23 +0000
Date:   Thu, 25 May 2023 02:03:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/9] btrfs: open code set_extent_bits
Message-ID: <ZG8kW2Bfaf7SpDxb@infradead.org>
References: <cover.1684967923.git.dsterba@suse.com>
 <016d0db9c71e15f4c39ea866ce82a425db55cf07.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016d0db9c71e15f4c39ea866ce82a425db55cf07.1684967923.git.dsterba@suse.com>
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

On Thu, May 25, 2023 at 01:04:32AM +0200, David Sterba wrote:
> This helper calls set_extent_bit with two more parameters set to default
> values, but otherwise it's purpose is not clear.

... and the naming is confusing as f*%$ given that it doesn't set any
more or less bits thatn set_extent_bit.  Good riddance.

Reviewed-by: Christoph Hellwig <hch@lst.de>
