Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2572FB78
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfE3MUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 08:20:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:57590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfE3MUS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 08:20:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0612CAE3E;
        Thu, 30 May 2019 12:20:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 241FEDA85E; Thu, 30 May 2019 14:21:11 +0200 (CEST)
Date:   Thu, 30 May 2019 14:21:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Diego Calleja <diegocg@gmail.com>
Cc:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190530122110.GE15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Diego Calleja <diegocg@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
 <2947276.sp5yYTaRCK@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2947276.sp5yYTaRCK@archlinux>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 08:36:23PM +0200, Diego Calleja wrote:
> El miércoles, 15 de mayo de 2019 19:27:21 (CEST) David Sterba escribió:
> > Once the code is ready for more checksum algos, we'll pick candidates
> > and my idea is to select 1 fast (not necessarily strong, but better
> > than crc32c) and 1 strong (but slow, and sha256 is the candidate at the
> > moment)
> 
> Modern CPUs have SHA256 instructions, it is actually that slow? (not sure how 
> fast these instructions are)
> 
> If btrfs needs an algorithm with good performance/security ratio, I would 
> suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that made 
> to the final round in the SHA3 competition, it is considered pretty secure 
> (above SHA2 at least), and it was designed to take advantage of modern CPU 
> features and be as fast as possible - it even beats SHA1 in that regard. It is 
> not currently in the kernel but Wireguard uses it and will add an 
> implementation when it's merged (but Wireguard doesn't use the crypto layer 
> for some reason...)

BLAKE2 looks as a good candidate. I have a glue code to export it as the
crypto module so we'll be able to test it at least. I'm not sure about
SHA3 due to the performance reasons, it comes out slower than SHA256 and
that one is already considered slow.
