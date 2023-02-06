Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5A68B5FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 08:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBFHC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 02:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBFHC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 02:02:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B13A98
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 23:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xf1tktrP/zHwnIblytLs+bpH4YH4nc0pI3xzL+ctR7A=; b=xKmGO5ZJu1PWCuwC6FDNkiIl9Q
        DSlijx2fYorxHP1MNQkdGD+5fhypy45JbRJEGtFDW35mUrwYeVGiY50fPa8D5IPOryiT3oIKb+vJ9
        oTe45pOCMGb+04isdb8GZRYJfFhnLXDX2aPAIT2l41LO2oRCQ6RHVuuhHguGejEyJ0iquR7UnvN/v
        /ZwOV0ea9YnXwp1ap3lMEkQgQGOaElel5JsHhG54I2kAs87RDzG51WPmtbmZU9I8iw7+4zfLlH7du
        FJxjDAYYscVEfvAhP0zklnpi5AS6VIKmtOGhUEo00lPYdOex7DPG/nZKFkx99LxN0pMQ1L3MrZe6x
        gUWhgtbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOvWE-007WEt-2D; Mon, 06 Feb 2023 07:02:26 +0000
Date:   Sun, 5 Feb 2023 23:02:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: reduce div64 calls for __btrfs_map_block()
 and its variants
Message-ID: <Y+CmAqw7JTYwvbTR@infradead.org>
References: <cover.1675586554.git.wqu@suse.com>
 <Y+CgXXV4wRh/PuGA@infradead.org>
 <46998577-18fd-1854-8509-b1a4e330995b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46998577-18fd-1854-8509-b1a4e330995b@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 06, 2023 at 02:58:55PM +0800, Qu Wenruo wrote:
> Right, I focused too much on the perf part, but sometimes the perf part may
> sound more scary:
> 
>   For example, DIVQ on Skylake has latency of 42-95 cycles [1] (and
>   reciprocal throughput of 24-90), for 64-bits inputs.
> 
> I'm not sure what's the best way to benchmark such thing.
> Maybe just do such division with random numbers and run it at module load
> time to verify the perf?

Honestly, getting rid of the ugly divisions calls is probably
reason enough as the series looks like a nice cleanup.  I just had
to nipick on the sentence.
