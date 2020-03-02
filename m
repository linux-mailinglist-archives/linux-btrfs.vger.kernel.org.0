Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53B01764A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 21:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBUHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 15:07:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:44210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBUHj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 15:07:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22573AD63;
        Mon,  2 Mar 2020 20:07:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8486ADA733; Mon,  2 Mar 2020 21:07:16 +0100 (CET)
Date:   Mon, 2 Mar 2020 21:07:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] progs: mkfs-tests: Skip test if truncate failed with
 EFBIG
Message-ID: <20200302200716.GW2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200224180534.15279-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224180534.15279-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 03:05:34PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> The truncate command can fail in some platforms like PPC32[1] because it
> can't create files up to 6E in size. Skip the test if this was the
> problem why truncate failed.
> 
> [1]: https://github.com/kdave/btrfs-progs/issues/192

Issue: #192

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to devel, thanks.
