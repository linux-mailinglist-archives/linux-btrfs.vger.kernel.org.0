Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F215302773
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbhAYQFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 11:05:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:46140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbhAYQEU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 11:04:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2770AC97;
        Mon, 25 Jan 2021 15:28:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4461ADA7D2; Mon, 25 Jan 2021 16:27:06 +0100 (CET)
Date:   Mon, 25 Jan 2021 16:27:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nigel Christian <nigel.l.christian@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove repeated word
Message-ID: <20210125152706.GJ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Nigel Christian <nigel.l.christian@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210125014141.GA10137@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125014141.GA10137@fedora>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 24, 2021 at 08:41:41PM -0500, Nigel Christian wrote:
> Comment for processed extent end of range has an
> unnecessary "in". Eradicate it.
> 
> Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>

Added to misc-next, thanks.
