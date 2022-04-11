Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD64FBBE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbiDKMSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiDKMSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 08:18:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A240E65
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=coNkX+YcEaxuES65lg5jr/ydnOTdNOy6GHR1Ly7HbCE=; b=GO85uMlvyKZnU+aAFt6D3Ek8wD
        VqU0EKzleqH8vIRLeoDewoM0wqlI5JNoBlezRWLNFXQjLOxmB2XxTCYPJqwvSP8tZvGhuweH7Mrz/
        tzV4+dBgxpyeUer8UXhznjQTIXDwVEzjIkQTTVDHBBfZgEt7Rhex7T6T78k1AdaCwbituNoQatp6Y
        hqxXCuXAwHSeTAdNpT5ojlpcDF49xyAy4BMi+F0gnQLUBSIIzclttH8IVU70pPYE2+vZ47o4wlxW2
        NXZhZsnif2WjWfGbXNJ+YRvGovXppeIhdhK3lNdLVh6L0416nl93ApW1oXd0MFgMWgXOn02sFwXgn
        mBFTvpXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndsxS-008vOK-Mx; Mon, 11 Apr 2022 12:15:50 +0000
Date:   Mon, 11 Apr 2022 05:15:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 4/4] btrfs: make submit_one_bio() to return void
Message-ID: <YlQb9pH6dQ1zL8ix@infradead.org>
References: <cover.1649657016.git.wqu@suse.com>
 <e4bb98b5884a77114ef0334dee6677e6e6260ea7.1649657016.git.wqu@suse.com>
 <YlPWXw+cWtMG0kE8@infradead.org>
 <32af072b-ab06-9a89-ad6b-0503106cef94@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32af072b-ab06-9a89-ad6b-0503106cef94@suse.com>
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

On Mon, Apr 11, 2022 at 03:20:47PM +0800, Qu Wenruo wrote:
> > This really should go into patch 1.
> > 
> Stable tree won't be happy about the size.

Really?  I've never really seen stable maintainers complain about
the size of a patch.  Especially if it is almost 100% removal of buggy
code.
