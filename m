Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534DEF7CB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKKStH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 13:49:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:54334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728739AbfKKStA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 13:49:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86C25AD19;
        Mon, 11 Nov 2019 18:48:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C8FCDA7AF; Mon, 11 Nov 2019 19:49:04 +0100 (CET)
Date:   Mon, 11 Nov 2019 19:49:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/22] btrfs: add the beginning of async discard, discard
 workqueue
Message-ID: <20191111184903.GV3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1571865774.git.dennis@kernel.org>
 <cd08686265272a470d5905b093ac84255cf8f4c9.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd08686265272a470d5905b093ac84255cf8f4c9.1571865774.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:52:59PM -0400, Dennis Zhou wrote:
> --- /dev/null
> +++ b/fs/btrfs/discard.c
> @@ -0,0 +1,274 @@
> +/*
> + * Copyright (C) 2019 Facebook.  All rights reserved.
> + */

It's the other way around, SPDX should be there,
https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Copyright_notices_in_files.2C_SPDX
