Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1A70E1C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjEWQ1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjEWQ1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 12:27:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F3CD
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umT/3hwQ+kwkqudx2zOEjL2MSs11z9kzaL/QqprTgBQ=; b=b5qbXlfrfLjyrhUc8iSVVJGt0D
        zz+Co3T4XONkOQyN0utKR3jEaFdh7tWKhbs6RPHz8QLSjgl8RVsRLzZvBJycqTn+w0Tv+zlfVb4Hx
        5OKsgMlpkNsY4V/RWP2EUxztz/NBfhOtqC9oq6p7TZL2Hy3XH/OR434rLItzANFxmdfgtO2SNaEux
        C8pcBpoWcpF01Zlo+oDicBhrWY8hdShIgsvclNIb/uyQRfKuiI2dTpndvxzdJncJUdK/WSLDtoW3I
        I3EI4dUjWX5qwFxCI8750iTgiJyJfEGPZtwlS4+AUpMHc5vzOdegqeV2zrvJhvcRSwfTSk3xBWZ7G
        dyiV1sPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1UrQ-00AnQj-2s;
        Tue, 23 May 2023 16:27:44 +0000
Date:   Tue, 23 May 2023 09:27:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate
 fsid_change
Message-ID: <ZGzpgG8o5pv5+hNL@infradead.org>
References: <cover.1684826246.git.anand.jain@oracle.com>
 <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
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

On Tue, May 23, 2023 at 06:03:15PM +0800, Anand Jain wrote:
> By relocating the bool fsid_change near other bool declarations in the
> struct btrfs_fs_devices, approximately 6 bytes is saved.
> 
>    before: 512 bytes
>    after: 496 bytes
> 
> Furthermore, adding comments.

I like the better backing.  But what looks access to fsid_change
and the other bools?  For sub-word members atomicy guarantees are
very limited, so they'd better all use the same lock.
