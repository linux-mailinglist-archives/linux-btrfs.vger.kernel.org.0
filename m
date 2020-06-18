Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF831FEFAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 12:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgFRKbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 06:31:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgFRKbr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 06:31:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5822BAB64;
        Thu, 18 Jun 2020 10:31:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25FE6DA728; Thu, 18 Jun 2020 12:31:36 +0200 (CEST)
Date:   Thu, 18 Jun 2020 12:31:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     DanglingPointer <danglingpointerexception@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <20200618103135.GU27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 18, 2020 at 12:28:41PM +1000, DanglingPointer wrote:
> btrfs-dedupe is currently broken and no longer actively supported.
> 
> It no longer builds with current rustc v1.44.0 with cargo
> 
> It is in the official btrfs Deduplication wiki:
> 
>      https://btrfs.wiki.kernel.org/index.php/Deduplication
> 
> There's no real active community and proper QA, reviewing and vetting.
> 
> A poster in the issues area of the projects Github location stated that 
> even if fixed, it may not function correctly due to BTRFS having evolved 
> since the tool was designed created.
> 
> There's just too many unknowns with this BTRFS specific dedupe tool.

That's enough reason to remove the entry from the page.

> People using your official wiki and trying to use that deduplication 
> program could inadvertently destroy their data through nativity or 
> accident.  Especially if they start trying to fix the code.
> 
> I recommend you remove it from your website or at least put large 
> warnings there that it is broken (which looks ugly, I would rather only 
> stuff that works were there since it isn't your project anyway but some 
> 3rd party).

With the 3rd party tools it's often leading to that situation and
feedback like yours helps to keep the information up to date.  I'll
remove the tools that are known to be unmainained.  Thanks.
