Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7E76B939
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjHAP5m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjHAP5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 11:57:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DE1AA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 08:57:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71A9868AFE; Tue,  1 Aug 2023 17:57:23 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:57:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-ID: <20230801155723.GB13009@lst.de>
References: <20230801210400.F0DE.409509F4@e16-tech.com> <20230801145946.GA11625@lst.de> <20230801235123.B665.409509F4@e16-tech.com> <20230801155649.GA13009@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801155649.GA13009@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also I'm curious if you see any differents for a non-RAID0 (i.e.
single profile) workload.

