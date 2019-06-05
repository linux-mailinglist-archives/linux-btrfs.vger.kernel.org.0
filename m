Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7C35850
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFEIGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 04:06:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfFEIGq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 04:06:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 330A0AF51
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 08:06:45 +0000 (UTC)
Date:   Wed, 5 Jun 2019 10:06:44 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: Skip first megabyte on device when trimming
Message-ID: <20190605080644.GD27972@x250>
References: <20190603100602.19362-1-nborisov@suse.com>
 <20190603100602.19362-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603100602.19362-4-nborisov@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
