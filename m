Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85AEAD5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJaKX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 06:23:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:48884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfJaKX4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 06:23:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBD42B2CE;
        Thu, 31 Oct 2019 10:23:54 +0000 (UTC)
Message-ID: <1572517345.3573.2.camel@suse.de>
Subject: Re: [PATCH v2 1/5] btrfs: merge blocking_writers branches in
 btrfs_tree_read_lock
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <ea8b9bd87a7a909960e0d9fb7bba33bba34aac6a.1572432768.git.dsterba@suse.com>
References: <cover.1572432768.git.dsterba@suse.com>
         <ea8b9bd87a7a909960e0d9fb7bba33bba34aac6a.1572432768.git.dsterba@suse.com>
Content-Type: text/plain
Date:   Thu, 31 Oct 2019 11:22:25 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannnes Thumshirn  <jthumshirn@suse.de>
