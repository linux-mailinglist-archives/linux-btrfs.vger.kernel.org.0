Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B91B10F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfEMHRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 03:17:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfEMHRa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 03:17:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFA2BAE34;
        Mon, 13 May 2019 07:17:29 +0000 (UTC)
Date:   Mon, 13 May 2019 09:17:29 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Chris Mason <clm@fb.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190513071729.GD12653@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
 <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
 <A792E55A-8007-44AB-8E9A-4EE4C363D15C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A792E55A-8007-44AB-8E9A-4EE4C363D15C@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 01:54:30PM +0000, Chris Mason wrote:
> Looking at the callers of btrfs_csum_final() and btrfs_csum_data(), lets 
> just pass the shash_desc from the callers.  That way you don't have to 
> poke at memcpy and shash_desc_ctx().
 
I wanted to avoid spreading knowledge about the crypto api to deep into the
filesystem. I'd actually loved to have something akin to ubifs'
ubifs_info::log_hash but wasn't really sure how to handle concurrency.

> I'm a little worried about stack usage (at least 360 bytes), but worst 
> case we can do some percpu gymnastics.
> 
> -chris

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
