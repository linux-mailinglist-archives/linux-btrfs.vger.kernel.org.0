Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37A42331A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfETL5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 07:57:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730679AbfETL5W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 07:57:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AABE2AE9A;
        Mon, 20 May 2019 11:57:21 +0000 (UTC)
Date:   Mon, 20 May 2019 13:57:21 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Diego Calleja <diegocg@gmail.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190520115721.GD4985@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
 <2947276.sp5yYTaRCK@archlinux>
 <20190517190703.GA6723@x250>
 <20190518003808.GA17312@angband.pl>
 <20190520074750.GC4985@x250>
 <6b6f85cd-ec77-a39f-8afa-2c0f093d77ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b6f85cd-ec77-a39f-8afa-2c0f093d77ec@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 07:34:34AM -0400, Austin S. Hemmelgarn wrote:
> Those would also be cryptographic applications, which BTRFS is not.  If
> you're in one of those situations and need to have cryptographic
> verification of files on the system, you need to be using either IMA,
> dm-verity, or dm-integrity.

This is a system we're aiming at in the followups to this series, but haven't
ultimately validated the design yet.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
