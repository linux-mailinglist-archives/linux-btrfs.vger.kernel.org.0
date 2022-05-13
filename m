Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64A5260EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiEMLX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 07:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358866AbiEMLX2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 07:23:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE6723DEF1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xGu+ggtNU7gHyNn1wgc8wnh3l8Bfgmo1ZLGJlArDWe8=; b=TeIBUjuSs1ea4v8ZZPn8i9YWcs
        990A/kKwsiD1djC9R4u16tk0WlGXodGFT3oCDdtBg17L7uoTT9VyiXeMQAMWXiLEyWINkjv9aMbZ2
        2Af00Ib6rmZUdBXisdx5/tdjFHBlJ7py/+/Oo8F6Vqh99G1jjQKVh5iLoM1ODo37MtkLi2WfnJmb3
        m10srMAszFOgmO+y1L62TWu4Z6vY7iiDDd/9sNvUsypziz3awP0rYRKVOAuPvHO3oBx/6hjejG0Kb
        yVo+/uWLR3IWk7wCGG3Vi+3bv0AF2B70G8uR3TxvhGctOQxO7R/rPu6Ct+RpLDUxK41d4q8WzgPa5
        RcF9DmAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npTOD-00FlNX-Sk; Fri, 13 May 2022 11:23:21 +0000
Date:   Fri, 13 May 2022 04:23:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <Yn4/qQmrWkRymqCV@infradead.org>
References: <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
 <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
 <20220512171629.GT18596@twin.jikos.cz>
 <Yn40Fkhz0jyef1ow@infradead.org>
 <5520df08-b998-a384-f1aa-16b301474cab@gmx.com>
 <Yn45tomlUQ8mGyVs@infradead.org>
 <581432b0-9324-8509-2737-a57f19c93937@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581432b0-9324-8509-2737-a57f19c93937@gmx.com>
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

On Fri, May 13, 2022 at 07:21:55PM +0800, Qu Wenruo wrote:
> This middle ground is still synchronous, but batched.
> 
> Although for the checker patterned corrupted sectors, it falls back to
> fully synchronous submit for each sector.

Indeed.  But how common is that case?
