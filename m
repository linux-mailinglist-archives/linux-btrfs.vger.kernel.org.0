Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF33710832
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 10:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbjEYI7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjEYI7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 04:59:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A41398
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EA8loIuwi65ImNfe0sPpV4Tx+n
        qygXuMIzmgLrcO77wli53EYDbPI/WIYgvQ1yrKUkxaJUpxPLFZQR8Jj0q++wdcwZOHOnXFr9Fe3Kr
        cZE/gNSzxbcYnsp7k17YdT/qGnDmp2Z3Z9t6CJY7I0XTVQKB3eGSfGCAe6+zMkT61PM9hwy7ZuRSq
        +CtNxmF1VGBH7TBGl9uBsBTwTyIKijER7tDhNkQY9GP08jfaIzlWfDnSDaZKNA/wd2DRLP3k0QdFK
        yNQ6p7hrebkApSSWCCW0nEoDBL47ct1Ii9lO9vGQ7ChrRzlS5ZdM7nZUNRyTbxzwGCCi+xgoUmWMn
        yzYQFAnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26p2-00G4mT-1M;
        Thu, 25 May 2023 08:59:48 +0000
Date:   Thu, 25 May 2023 01:59:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/9] btrfs: open code set_extent_new
Message-ID: <ZG8jhPxOKvs3tut3@infradead.org>
References: <cover.1684967923.git.dsterba@suse.com>
 <34f3abd71b4da58527bfc16268a4d915f98e5305.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f3abd71b4da58527bfc16268a4d915f98e5305.1684967923.git.dsterba@suse.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
