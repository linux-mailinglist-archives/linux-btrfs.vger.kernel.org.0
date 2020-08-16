Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC6245865
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHPPfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Aug 2020 11:35:52 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:58134 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgHPPfw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Aug 2020 11:35:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.21547|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0160227-0.00309564-0.980882;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IIZotgj_1597592147;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IIZotgj_1597592147)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 16 Aug 2020 23:35:48 +0800
Date:   Sun, 16 Aug 2020 23:35:47 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] fstests: btrfs/218 check if mount opts are applied
Message-ID: <20200816153547.GN2557159@desktop>
References: <20200804205648.11284-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804205648.11284-1-marcos@mpdesouza.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 04, 2020 at 05:56:48PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This new test will apply different mount points and check if they were applied
> by reading /proc/self/mounts. Almost all available btrfs options are tested
> here, leaving only device=, which is tested in btrfs/125 and space_cache, tested
> in btrfs/131.
> 
> This test does not apply any workload after the fs is mounted, just checks is
> the option was set/unset correctly.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Test looks thorough, thanks! But I'd like other btrfs folks take a look
as well, as there're many btrfs-specific mount options that I'm not
familiar with. Thanks!

Eryu
