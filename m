Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFF1626A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfEGK4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 06:56:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbfEGK4h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 06:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B622AC61;
        Tue,  7 May 2019 10:56:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B41EEDA8F1; Tue,  7 May 2019 12:57:35 +0200 (CEST)
Date:   Tue, 7 May 2019 12:57:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "litaibaichina@gmail.com" <litaibaichina@gmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: can I change NAME_MAX limit
Message-ID: <20190507105735.GO20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "litaibaichina@gmail.com" <litaibaichina@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <201905071748449682914@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201905071748449682914@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 05:48:47PM +0800, litaibaichina@gmail.com wrote:
> I am running btrfs on a 4.4.178 kernel,  I want to support a longer
> file name, now the NAME_MAX is 255,  can I just increase the NAME_MAX
> macro and recompile the kernel to support longer file name ?  I guess
> I will break sth,  but I am not sure what part will be broken.

NAME_MAX is system-wide and defined in limits.h. This is not btrfs
specific, you'd need to recompile the whole userspace too and who knows
what would break.

255 fits into a byte and I think some filesystems use that as maximum
that can be stored in their metdata, ie. not possible to change without
wider thanges.

Btrfs has space in btrfs_dir_item as it stores the name as 16bit number.
