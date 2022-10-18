Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BFA603265
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 20:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJRS0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRS0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 14:26:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F11AD93;
        Tue, 18 Oct 2022 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AEJf2mNYwXZ5xrVD3xYZy+5u0F73izIOkv8ZsjU50Ng=; b=MzBS007LU+n50xTa/QwcK9g5cK
        CRC3WNNnL3E6oQsHPvVR/Yy9qp+SOTG/culz+OokdCI2bsKrE9SATVM6No4+N2XjaFWnMHj8kO6NO
        Xtz77p07hLugAK/FG2id8GrdpUh+ANUXxqqvL7hJzaU2MWW1rKG0Av81DpufsUqwn3DY4m7xbq9kD
        x53uB9GTlVZya0y/CMs8fT1lplECe4i8KYfV/O3hwreSTi0DIJcnOW4dv3YCXEdTg2ff0g95m3sWv
        r89tiLpFXqXNuOXJt8Vb24on88Qw/DrKSZ+lsbETpy+i1c3c7gcmu31ZYm7wgszp51LcfiNBj9X2W
        ftVQEv+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okrIG-009uqz-40; Tue, 18 Oct 2022 18:26:24 +0000
Date:   Tue, 18 Oct 2022 11:26:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add btrfs tests exercising raid to the raid
 group
Message-ID: <Y07v0MWnbCa0zLhT@bombadil.infradead.org>
References: <20221017085317.96172-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017085317.96172-1-johannes.thumshirn@wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 01:53:17AM -0700, Johannes Thumshirn wrote:
> Several tests for btrfs exercise the raid code, but are not added to the
> raid group. Most of these tests pull in raid via
> '_btrfs_get_profile_configs()'.
> 
> Other tests have a '_require_btrfs_fs_feature raid56' which also pulls in
> raid, but are not added to the raid group.
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Shouldn't we have a raid56 group alone too? Then distros that simply
don't support it can skip those tests.
 
  Luis
