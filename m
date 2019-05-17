Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F21E0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfEQTHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 15:07:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:38800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfEQTHF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 15:07:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7A30AD3E;
        Fri, 17 May 2019 19:07:04 +0000 (UTC)
Date:   Fri, 17 May 2019 21:07:03 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Diego Calleja <diegocg@gmail.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190517190703.GA6723@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
 <2947276.sp5yYTaRCK@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2947276.sp5yYTaRCK@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 08:36:23PM +0200, Diego Calleja wrote:
> Modern CPUs have SHA256 instructions, it is actually that slow? (not sure how 
> fast these instructions are)

This still is subject to evaluation.

> If btrfs needs an algorithm with good performance/security ratio, I would 
> suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that made 
> to the final round in the SHA3 competition, it is considered pretty secure 
> (above SHA2 at least), and it was designed to take advantage of modern CPU 
> features and be as fast as possible - it even beats SHA1 in that regard. It is 
> not currently in the kernel but Wireguard uses it and will add an 
> implementation when it's merged (but Wireguard doesn't use the crypto layer 
> for some reason...)

SHA3 is on my list of other candidates to look at for a performance
evaluation. As for BLAKE2 I haven't done too much research on it and I'm not a
cryptographer so I have to trust FIPS et al.

One other (non chrypto) hash that is often mentioned would be XXHash which is
in the kernel but not yet wired up to the kernel's crypto framework, but this
shouldn't be too hard to do.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
