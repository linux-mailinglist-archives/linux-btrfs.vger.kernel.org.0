Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E84E4CB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 07:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiCWG3N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 02:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCWG3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 02:29:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A7710E6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U8+c6Dn173zuDDa2VCSAazLeYiFwiqzTvKrCTu1cABU=; b=XD0lA8G2d+5WWULGQbi7LbvMPw
        zYrrg5+8Jo6LmYersJWlVqBV0f4AmoZqzF5J3WttK2YI6REHR2C+A8vfn3DUyQfjiEjKAt4U8ay5l
        jHtIlcFgvbwCcbyEp+s29TN38y5QhbTrCd0hq/jr+mi7QCJO7GatTJFC0mpCXOsjDEUlh0hsoa5B5
        w5jEBCcpgec/VmaFHRhQrV8LNGsThsk74ugx9QfywJqWBD2q9WWqsoZXMtbx0sHI/8Z7cc4f2JP9K
        5+lWItn36It4Cle9TcNXlSx63wnZk/eYf4TKA3ffpKTlkKxwjVNhX+JGrIIPJNGFnPZuVfoJMyXjO
        tn1l4G7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWuT9-00CqQW-PF; Wed, 23 Mar 2022 06:27:43 +0000
Date:   Tue, 22 Mar 2022 23:27:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 2/9] btrfs: introduce a helper to locate an extent item
Message-ID: <Yjq935OOywPFefuo@infradead.org>
References: <cover.1646984153.git.wqu@suse.com>
 <140f3318f93d004713e12c10dc44f7640f04856e.1646984153.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140f3318f93d004713e12c10dc44f7640f04856e.1646984153.git.wqu@suse.com>
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

Adding a static function without a user will generate a compiler
warning.
