Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF28D9C67
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 23:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfJPVWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 17:22:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:44168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729231AbfJPVWD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 17:22:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85065B372;
        Wed, 16 Oct 2019 21:22:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD328DA7E3; Wed, 16 Oct 2019 23:22:11 +0200 (CEST)
Date:   Wed, 16 Oct 2019 23:22:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>
Cc:     linux-btrfs@vger.kernel.org, pmhahn+btrfs@pmhahn.de,
        dsterba@suse.com, lakshmipathi.g@giis.co.in
Subject: Re: [PATCH v2] Setup GitLab-CI for btrfs-progs
Message-ID: <20191016212211.GD2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>,
        linux-btrfs@vger.kernel.org, pmhahn+btrfs@pmhahn.de,
        dsterba@suse.com, lakshmipathi.g@giis.co.in
References: <20191014175159.GA13501@giis.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014175159.GA13501@giis.co.in>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 14, 2019 at 11:21:59PM +0530, Lakshmipathi.G wrote:
> Make use of GitLab-CI nested virutal environment to start QEMU instance inside containers 
> and perform btrfs-progs build, execute unit test cases and save the logs.
> 
> More details can be found at https://github.com/kdave/btrfs-progs/issues/171
> 
> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.com>

Thank you, I've added it for 5.3 release so we have a base for further
changes and fine tuning.
